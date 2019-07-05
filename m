Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 242F7C46499
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 20:59:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E28C52133F
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 20:59:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KVWXLN4g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E28C52133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjVJB-0002uV-2g
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 16:59:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34211)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hjUkG-0004N5-M1
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 16:23:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hjUk8-0002pr-HJ
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 16:23:44 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:36279)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1hjUk4-0002iX-9B
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 16:23:37 -0400
Received: by mail-wr1-x435.google.com with SMTP id n4so11052720wrs.3
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2019 13:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=yDJUvL9nWhLhts5GRxzh+3OuJBbBUiS1ssTSFuvIqR4=;
 b=KVWXLN4gLf5250ibJWUojN2agC6g4K9l5l5slyuX/pZtA6N4+Q5NeaDZFz5yHFnfZ/
 mfaBqisbwzTNBVsRofxx1w5jvoLdmD1d/JtdK98FvHpnNCTzP9HGebAziOpIKu4i8FD+
 dkHndFhNLVvuuY/x/H3e6R7dUKejWpUybEX684u9NEG/TzPIuR5NWK16Ns1LATRgi4es
 EIpenb5hZL4888UVl/GYohKbKrXO1+Svgeg0Xl/IVSEVd4tAtVuyGOCq93/v0Gvadr58
 7xGMtw1wzb7bPV2FUYdaTHbu4FIcYl/HofQxE1vNgvxkLs1mChhOVFyYecRVPWiXZAM9
 7Fcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=yDJUvL9nWhLhts5GRxzh+3OuJBbBUiS1ssTSFuvIqR4=;
 b=mjoXql5NqolMW8EZcUsI7K5KLYyt8pLcGusrxEDZBc9Vh5gtXPoVAg79DxER9FD8OS
 7BNDAzNgaVsNjwJOZo7eJW8Kp65rTsGTrX8ZuVe2sXwy3htulpbJKkMtot3NrkyilLqN
 q3T8fvuBoymI4nyWgi3CduhXJTTsrY2KvQi9/tmuGqXteTzNiJeri1R4KlzlWcn9blgJ
 TTj55cStms6fXDEdi6NbJxkVRhxKBdg0WLkeP2RsWQXTZskYows7iHbfBtU7jfcrYSHf
 XSutF7dM/DvnxNEshGp5WHxHEymiJAx1x1cTOxo5yaCvVpwN4gzP/NvewbCu6wGm0qhR
 jVIg==
X-Gm-Message-State: APjAAAVb6WiMBN915AgkMYSzeHIGyMbB52YwCa5BJocyJ10tEJ7usH28
 +wLjxIGjJz4OwHSsrDIBwMP1xyAdcsw=
X-Google-Smtp-Source: APXvYqxNc7nA0KeOWa7sxu2PCn5lDID7hTNzjhUDTvFf9ZidURsTG6NzzC1F7wbM/m4DwFREz/0/Vg==
X-Received: by 2002:adf:aacf:: with SMTP id i15mr4946756wrc.124.1562358209239; 
 Fri, 05 Jul 2019 13:23:29 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id v23sm3035875wmj.32.2019.07.05.13.23.28
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 05 Jul 2019 13:23:28 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri,  5 Jul 2019 22:23:16 +0200
Message-Id: <1562358202-28008-7-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1562358202-28008-1-git-send-email-pbonzini@redhat.com>
References: <1562358202-28008-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::435
Subject: [Qemu-devel] [PULL 06/12] ioapic: clear irq_eoi when updating the
 ioapic redirect table entry
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
Cc: Li Qiang <liq3ea@163.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Li Qiang <liq3ea@163.com>

irq_eoi is used to count the number of irq injected during eoi
broadcast. It should be set to 0 when updating the ioapic's redirect
table entry.

Suggested-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Li Qiang <liq3ea@163.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Message-Id: <20190624151635.22494-1-liq3ea@163.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/intc/ioapic.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/intc/ioapic.c b/hw/intc/ioapic.c
index 7074489..db9e518 100644
--- a/hw/intc/ioapic.c
+++ b/hw/intc/ioapic.c
@@ -380,6 +380,7 @@ ioapic_mem_write(void *opaque, hwaddr addr, uint64_t val,
                 /* restore RO bits */
                 s->ioredtbl[index] &= IOAPIC_RW_BITS;
                 s->ioredtbl[index] |= ro_bits;
+                s->irq_eoi[index] = 0;
                 ioapic_fix_edge_remote_irr(&s->ioredtbl[index]);
                 ioapic_service(s);
             }
-- 
1.8.3.1



