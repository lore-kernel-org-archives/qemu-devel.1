Return-Path: <SRS0=2JTU=UU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58616C48BE3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 01:54:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BA5C2084A
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 01:54:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nIFNT+/d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BA5C2084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54066 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1he8ko-0004he-9S
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 21:54:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40876)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <paolo.bonzini@gmail.com>) id 1he8Zu-0006Sw-6U
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 21:42:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1he8Zo-0006Mb-Ke
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 21:42:57 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:36105)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1he8Zh-0006Hi-4i
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 21:42:47 -0400
Received: by mail-wr1-x433.google.com with SMTP id n4so3676919wrs.3
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2019 18:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=bNCR6BSZrVAsd51s0wYru1/heSmPhGDxRbakfLjjL5g=;
 b=nIFNT+/deS9pSOLA5AIOHk4M5bnC0XnTWzwNgIE9V1MYR5nRViNgWkOrTSVhk/o76u
 4fEc95rWD23t1UsWYSw6wfdRhBQuOlpseyGHkxeIhZj+4EfM4n851FOBtyaylDZ/dbZN
 VnNvzkcxxZ+AORpRuj69fRph+ykEF2MTzE/5YP54Igls9dQm/qiDXgmaTrgAt0yfOEui
 GAO0z8/m90I9LSZmTzaU+uk6Rc3lZtxn2Yf2VtEbxD9fAV/O6ArLmbO+9dZ1JV8oe5+B
 TqnaL1DCPDcqME88m4CSdItKSBBADNrTOG9cfXtYhKoq0h5B3N2NERSsOOpirYDXljyC
 jEOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=bNCR6BSZrVAsd51s0wYru1/heSmPhGDxRbakfLjjL5g=;
 b=KfNgUaA7IOkVVonlVoa9JN7WEh5DiNuycGpMlHNhJdExWJfRnzfNaZEm9506qwvrag
 cM3tL5d+ZogBL4C2LmSx2L78+abt62l2dcGAT25Vdue7C1iWpX8gPYwfaFsoWW+o5YKM
 Sfl8FQWT0eVTwAz41IgYtV/UG0HZA+j3iSdkSenxmXv5NPTBGvYSKPbK+ngzXzKPTA5l
 /GW1BDI8HHSMhDSh17BjeOMYQE0retYmjGZaGenOcetuTChN4Dr71AWSK3QiYxSTBUvm
 6HU9Mza8Fmpela9LgImEkE6MhqQ0uP9bmBp2A2nwvrNW3n9oQuMl90KEFVmYcKEFa38+
 5InA==
X-Gm-Message-State: APjAAAX9PaW1IW7AKh6qFgiTaRs5mdEwjubGFINVAmmsNSb6daMW14S4
 rJhR2/EhfGvCMpicPGgdx4duiDL0
X-Google-Smtp-Source: APXvYqyUwCJcL/6q6Iitne1OuIt4XXxrssT9TPxTKhfdyG8m0rDACFOGdYIlUnfVUghgCBZuWcxAqw==
X-Received: by 2002:a5d:46cb:: with SMTP id g11mr3624013wrs.253.1561081362502; 
 Thu, 20 Jun 2019 18:42:42 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id d1sm1123125wru.41.2019.06.20.18.42.41
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 20 Jun 2019 18:42:41 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 21 Jun 2019 03:42:14 +0200
Message-Id: <1561081350-3723-10-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1561081350-3723-1-git-send-email-pbonzini@redhat.com>
References: <1561081350-3723-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::433
Subject: [Qemu-devel] [PULL 09/25] i386/kvm: hv-tlbflush/ipi require
 hv-vpindex
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vitaly Kuznetsov <vkuznets@redhat.com>

The corresponding hypercalls require using VP indexes.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Message-Id: <20190517141924.19024-8-vkuznets@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 58afa31..1dfa282 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -782,7 +782,8 @@ static struct {
             {.fw = FEAT_HV_RECOMM_EAX,
              .bits = HV_REMOTE_TLB_FLUSH_RECOMMENDED |
              HV_EX_PROCESSOR_MASKS_RECOMMENDED}
-        }
+        },
+        .dependencies = BIT(HYPERV_FEAT_VPINDEX)
     },
     [HYPERV_FEAT_EVMCS] = {
         .desc = "enlightened VMCS (hv-evmcs)",
@@ -797,7 +798,8 @@ static struct {
             {.fw = FEAT_HV_RECOMM_EAX,
              .bits = HV_CLUSTER_IPI_RECOMMENDED |
              HV_EX_PROCESSOR_MASKS_RECOMMENDED}
-        }
+        },
+        .dependencies = BIT(HYPERV_FEAT_VPINDEX)
     },
 };
 
-- 
1.8.3.1



