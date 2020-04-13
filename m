Return-Path: <SRS0=kd+i=55=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6713C2BA19
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 07:24:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AEAA20663
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 07:24:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pm3BaaYH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AEAA20663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lemote.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jNtS8-0005QR-Np
	for qemu-devel@archiver.kernel.org; Mon, 13 Apr 2020 03:24:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37093)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chenhuacai@gmail.com>) id 1jNtR2-000430-H8
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 03:23:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chenhuacai@gmail.com>) id 1jNtR1-00072d-I4
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 03:23:12 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536]:43069)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <chenhuacai@gmail.com>)
 id 1jNtR1-00070k-Cs
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 03:23:11 -0400
Received: by mail-pg1-x536.google.com with SMTP id x26so2928918pgc.10
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2020 00:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=qhpq41BRu/RPPwD4eaCJ5cfb9DHBcGHPYRUi0Z0GRT4=;
 b=Pm3BaaYHprds2QFeII0r9egbTq6PKvjEZ4oGWq6qQF9MHfbSZOZ42IDzZkMcHh55A+
 moc02dm11rgYAADl/KyOBMkZhgs3w0bnFOczVFoIvmTj6F8HIN1ulrRauQW5Rgo5NuId
 cXruvUf/VP0hNrJKVD2c53l6etSJ/THuMFWw6OAzl97dx6gQWKjOGJ5CKq9HOOfckpbv
 sPR1JXy3tWmtoL4udghPanl6w/nfyKA+k43Y769uyDrP2/Y+pGF5wucOFknJIetRoSPE
 9AKK2KvEpo2cl4eZXGQrK9nOL0A6VnpDNJLZ3gNDdQSWbY++e/NP/xOvBAtzahq9328R
 HV+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=qhpq41BRu/RPPwD4eaCJ5cfb9DHBcGHPYRUi0Z0GRT4=;
 b=FontlRklqyGRBShb+jlQaYha7ND+Rn6esQIwmw7j6k7PBb/Ks7U3KWaH2b9F3JYIUR
 61ViHRXaQU9bWXf5PlrqwcAVHD2fR8VA/A49LXXlsIXKXo2gKRFT+WST0SWQ2jaXrQI7
 0XJU7m75iUAQygXdEyE56gidU/+4o8KvssjyNnPMK0WPownHU+rRdhIsUbU6g325t3kG
 q6DDDGZ1lUHhw3d4lfOmbVVX17FdSyHOuPNyWWZ0Akfp4OsTGVUWYVhtLTMsgmMCw4gC
 sgGbU6cAMl9dRiuqKUhlQ7DHcrOc6Mg29UevoLFrsu9HRT4ITBplRcYYQ4w/WhxGMp6K
 1wgQ==
X-Gm-Message-State: AGi0PubpMTnFhMmmwbge2qJfoSYXqbXsPUiMe4e6G4/Amo+CFnzzVP9V
 N3MnPgmk3N3eWZ9LOigOd1w=
X-Google-Smtp-Source: APiQypJ2RWntWbbpBSM1g5kZmzP5ruORUti27kfstHoJP/pSw4ATCiAl2BtVdEXVJ1aCioNa49hX9Q==
X-Received: by 2002:a62:164d:: with SMTP id 74mr1172550pfw.52.1586762590414;
 Mon, 13 Apr 2020 00:23:10 -0700 (PDT)
Received: from software.domain.org (28.144.92.34.bc.googleusercontent.com.
 [34.92.144.28])
 by smtp.gmail.com with ESMTPSA id u8sm7241341pgl.19.2020.04.13.00.23.08
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 13 Apr 2020 00:23:10 -0700 (PDT)
From: Huacai Chen <chenhc@lemote.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: [PATCH 04/15] KVM: MIPS: Increase KVM_MAX_VCPUS and
 KVM_USER_MEM_SLOTS to 16
Date: Mon, 13 Apr 2020 15:30:13 +0800
Message-Id: <1586763024-12197-5-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1586763024-12197-1-git-send-email-chenhc@lemote.com>
References: <1586763024-12197-1-git-send-email-chenhc@lemote.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::536
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
Cc: kvm@vger.kernel.org, Huacai Chen <chenhuacai@gmail.com>,
 qemu-devel@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 linux-mips@vger.kernel.org, Fuxin Zhang <zhangfx@lemote.com>,
 Huacai Chen <chenhc@lemote.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Loongson-3 based machines can have as many as 16 CPUs, and so does
memory slots, so increase KVM_MAX_VCPUS and KVM_USER_MEM_SLOTS to 16.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
Co-developed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/mips/include/asm/kvm_host.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index 7b47a32..2258a2e 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -78,8 +78,8 @@
 #define KVM_REG_MIPS_CP0_KSCRATCH6	MIPS_CP0_64(31, 7)
 
 
-#define KVM_MAX_VCPUS		8
-#define KVM_USER_MEM_SLOTS	8
+#define KVM_MAX_VCPUS		16
+#define KVM_USER_MEM_SLOTS	16
 /* memory slots that does not exposed to userspace */
 #define KVM_PRIVATE_MEM_SLOTS	0
 
-- 
2.7.0


