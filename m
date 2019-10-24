Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F261CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 14:42:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2938B20679
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 14:42:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ttWmgb69"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2938B20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNeKD-0006We-R2
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 10:42:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34752)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iNdiu-0007kI-L6
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:04:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iNdit-0007iy-HP
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:04:20 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:37250)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iNdit-0007hc-59
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:04:19 -0400
Received: by mail-wm1-x329.google.com with SMTP id q130so2569763wme.2
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 07:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=jH2nwRqgKYa3R0rTBZTn8Xjzb4Jj1RuEeZP/EBmAFOQ=;
 b=ttWmgb69jGz6z5QeF+0pebo2cZ6OwLadDJYH6MVcSNs/aPgl9tPpoYyh6+LEGFZozD
 bwiamZoxfVu4NnjcMnzn531fBuf+Fw0v+H6ErrnyMACYzaLyQ1mzgRWdjEWFloxHnt/d
 mvMtBBWDszt69CYRKT8KL7DNi7W3cqU+HElPsLSM9Q5DEf/7Xzc+D4WaxiujfTrooR2p
 ROVRW1HYb1bTYvDFyTDvtTrIAFboIM0Pi7CQzaUy9tv8I4/LBHMC8d/fiEKxo/b03tWA
 vKYpkCmSW+XlVXOXjYt8lQOXW+9Dc74aD03evInhckEAq6twtW2XxCbYeq13I85O7KOQ
 QWXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=jH2nwRqgKYa3R0rTBZTn8Xjzb4Jj1RuEeZP/EBmAFOQ=;
 b=YGBdU54p9Wc1hO6RTso90ljB36HRJBKRoGueBtmDp1XRCejFhkCtj9R8BJQNN2+Fxk
 ZaZRXplIOs+a0RsBGTYI2zfNauBtNP2Z1uZ4f3BIwcAvgyT2AWULKzEyXFGFdOYdeybp
 ti7QihfUOXytkKX/TOTknai3duIeGQ5y0Ghs1agyOg1A4lr3vmuxffzIIOI8lTVcNJIO
 R/SP/Fz6RBVa6ycfBVYJo0i5eR7GJAHcsUdMrq/ZQFKGDhDstNpkAfVT0Z7LGyc4CvQa
 hlpMbhX7ebt18CoLbJEloJrlRk1r9oacQqnTZZqpDahOpc0YTPmkOnwgbjVWnB6QLQQy
 hAIQ==
X-Gm-Message-State: APjAAAXYuh/h6EyAv8GdtyKkpXtuWStLIpqLaUPUvYPemJ5y/wtx71jd
 i8Phdxy73ERaMRhbWw1tWtNzfNGn
X-Google-Smtp-Source: APXvYqzxsM5TBXTsSUza+KaQ68RXiGu+M6DI8KdwDaR47CCDCVzUBM/iFuxTG6Do/BwABWDAPi30zg==
X-Received: by 2002:a7b:cd19:: with SMTP id f25mr5365027wmj.154.1571925856561; 
 Thu, 24 Oct 2019 07:04:16 -0700 (PDT)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id b7sm10610155wrn.53.2019.10.24.07.04.15
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 24 Oct 2019 07:04:15 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 17/39] hw/intc/apic: reject pic ints if isa_pic == NULL
Date: Thu, 24 Oct 2019 16:03:33 +0200
Message-Id: <1571925835-31930-18-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1571925835-31930-1-git-send-email-pbonzini@redhat.com>
References: <1571925835-31930-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::329
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
Cc: Sergio Lopez <slp@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Sergio Lopez <slp@redhat.com>

In apic_accept_pic_intr(), reject PIC interruptions if a i8259 PIC has
not been instantiated (isa_pic == NULL).

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sergio Lopez <slp@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/intc/apic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/intc/apic.c b/hw/intc/apic.c
index bce8991..2a74f7b 100644
--- a/hw/intc/apic.c
+++ b/hw/intc/apic.c
@@ -610,7 +610,7 @@ int apic_accept_pic_intr(DeviceState *dev)
 
     if ((s->apicbase & MSR_IA32_APICBASE_ENABLE) == 0 ||
         (lvt0 & APIC_LVT_MASKED) == 0)
-        return 1;
+        return isa_pic != NULL;
 
     return 0;
 }
-- 
1.8.3.1



