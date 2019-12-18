Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5B98C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 13:09:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEE6F2176D
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 13:09:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mq5L19V0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEE6F2176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihZ4m-0004EH-P6
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 08:09:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58904)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ihY45-0007bZ-Dz
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:04:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ihY44-0004Ie-Da
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:04:29 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:53047)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ihY44-0004FT-4W
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:04:28 -0500
Received: by mail-wm1-x331.google.com with SMTP id p9so1564832wmc.2
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 04:04:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4Jcio20l5vVSzyGNtxWMBugfhVYAAbulnAjuFKBNWM4=;
 b=mq5L19V0ZHFuiicTUsfVFMTyM6RuxfHwe0xcELs1xuxKY53/j5EcKh/Fia8ZiJ162M
 3LHpVyWYUHk2YxFol1ykdOa39FYil51xs766QZGEj7rnRLnTM6TxC4IfetS/Xra4TFw1
 mfX8A91MIl+WabrnFJ5xTpGJz7QNBUPNTT+yaHlBoGQ9bFnG4zorkaGN55IJl3KPm5f5
 Rb4CKbeDNG9UL/+kIWumnTMNVguz+U2DEEbeCpxnycKEY1zsqacc+36fOyux45sA9BhD
 btqY02oEVk4k91iRoxvYetFzlCVYeOEPx7TduSGTi0TCBFwKI2cRgCnBBZsOMwMbyPsa
 OzYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=4Jcio20l5vVSzyGNtxWMBugfhVYAAbulnAjuFKBNWM4=;
 b=FFwT+/Ysb6zaR4qqxaIDrDZ9bjcFOeqj1RTKG54y13Q5l5lUboU9/HHJ74FHM5vnet
 BYgdNDsy8DXczF074wWrJW0cQ1KHvsRaINAeo63KxTTWDH0Tv9m8z1GL4sKCFY+DW0RK
 GW4gWKKqb9CvdqALt5rMlHizj67VvXPL7iRctT+JzneK30foAe0nRRdMiRmI2ykDxnpB
 ZLUXnpENidcAwHkcVShA3MdCewwcyhEgf2EZL2/mrRK8mmh+DuA6jcsoHTU0yb8+2pMJ
 q++csRBhm9l/sqfKuciQMCLO8rtP8FkOKLwn9Ii6jHRr9J0W1FdRz3E663zQnYpnqYvR
 ojMw==
X-Gm-Message-State: APjAAAWGC1lI9P9dIst6UIFmxM2xMufTpy3sPHeMEzl6KNWnkxff/WBc
 bh5fts43j7ol6tH82i+DDmwq/WtT
X-Google-Smtp-Source: APXvYqxzO5fY0CBPMS2zueh/qSwr65wu3l5iiJfxDJ9iA3p2mCQ6+Dol6NydpK69KoLGgWcxRF40Bg==
X-Received: by 2002:a1c:f008:: with SMTP id a8mr2794675wmb.81.1576670666579;
 Wed, 18 Dec 2019 04:04:26 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n67sm2236838wmf.46.2019.12.18.04.04.25
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 18 Dec 2019 04:04:25 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 84/87] hw/audio: Remove the "use_broken_id" hack from the AC97
 device
Date: Wed, 18 Dec 2019 13:02:50 +0100
Message-Id: <1576670573-48048-85-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576670573-48048-1-git-send-email-pbonzini@redhat.com>
References: <1576670573-48048-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::331
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
Cc: Thomas Huth <thuth@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

Now that the old pc-0.x machine types are gone, we do not need
the "use_broken_id" hack anymore.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20191209125248.5849-3-thuth@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/audio/ac97.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/hw/audio/ac97.c b/hw/audio/ac97.c
index a136b97..78cda88 100644
--- a/hw/audio/ac97.c
+++ b/hw/audio/ac97.c
@@ -161,7 +161,6 @@ typedef struct AC97BusMasterRegs {
 typedef struct AC97LinkState {
     PCIDevice dev;
     QEMUSoundCard card;
-    uint32_t use_broken_id;
     uint32_t glob_cnt;
     uint32_t glob_sta;
     uint32_t cas;
@@ -1373,13 +1372,6 @@ static void ac97_realize(PCIDevice *dev, Error **errp)
     c[PCI_BASE_ADDRESS_0 + 6] = 0x00;
     c[PCI_BASE_ADDRESS_0 + 7] = 0x00;
 
-    if (s->use_broken_id) {
-        c[PCI_SUBSYSTEM_VENDOR_ID] = 0x86;
-        c[PCI_SUBSYSTEM_VENDOR_ID + 1] = 0x80;
-        c[PCI_SUBSYSTEM_ID] = 0x00;
-        c[PCI_SUBSYSTEM_ID + 1] = 0x00;
-    }
-
     c[PCI_INTERRUPT_LINE] = 0x00;      /* intr_ln interrupt line rw */
     c[PCI_INTERRUPT_PIN] = 0x01;      /* intr_pn interrupt pin ro */
 
@@ -1411,7 +1403,6 @@ static int ac97_init (PCIBus *bus)
 
 static Property ac97_properties[] = {
     DEFINE_AUDIO_PROPERTIES(AC97LinkState, card),
-    DEFINE_PROP_UINT32 ("use_broken_id", AC97LinkState, use_broken_id, 0),
     DEFINE_PROP_END_OF_LIST (),
 };
 
-- 
1.8.3.1



