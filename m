Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 104F2C35DE1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:32:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF31420CC7
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:32:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HYRoj2i7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF31420CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54230 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6ZNY-0006Tn-VL
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 07:32:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52792)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6Z0S-0003wl-TU
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:08:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6Z0R-0003fP-Rz
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:08:08 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:52956)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j6Z0R-0003eZ-K8
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:08:07 -0500
Received: by mail-wm1-x336.google.com with SMTP id p9so2739626wmc.2
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 04:08:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ketsX9szEN/yEwdCDikauA8vhBP8YwqgK84yBa4Gy64=;
 b=HYRoj2i7ddw6Dw98VO5bDlJQMY8g5khqD2AbIxBp1lpe0PwfzuxcwKbgOLk0Y9mxJ2
 sUsJVMQsKGnrIzXWN0Yg7mP/ahYdbpEpsbAl/vzvZsMHem7lZXdBnCBKMPoQQoRLi3Wm
 cMoC5itNQgMBhgFTZa0/8AOURuyTwNz+9jxNsMIlhoh8+mAHy5SaQ2vrlEwVVNe0Pox5
 MRwpVcatyeHMwfcMHFBFWyBBguxGG8IW+fXoQrogeyzA3ONopPzky8CY08xES6MQCxCT
 JSamgDNMTihs5lnioIfCoRED83whB3mM9U6nUxYiuIPrg4ei2qt4a+lkDnwWli02tLkA
 Ma/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=ketsX9szEN/yEwdCDikauA8vhBP8YwqgK84yBa4Gy64=;
 b=CHEaNiNNVC3b+NHiZdTyqRKU57kGmZz82unoGwXPigGP3gRcLKL78/hqFsCOYMYvjt
 iNVSgrodwBLeYgf8cFcJoX5/Cm8OYvhk3AOAe60TXXJjIJw7yu8nyL4lD2XJCxRSPtD0
 zX+zfyVoPeklXIbis0untHqb00ZpL1o0WGzRqRTZ6cyHhwp2JEx3u+5+BwU1y6tt6WFX
 5BxMIw2rjtO21QvHrlyaJWmiuP5BZ8BgUtFOZPk7mj1eThmqlGbQ+RiHzEAAF6fLNtTL
 HouN00337yY0Y3yyctt/YNsm8y8sWaqistiZmdlWHuQQGvcGM+e8q05XP3vSfNVPVVvj
 gS9w==
X-Gm-Message-State: APjAAAXxscXHTe8zabwDV+up9qWZnG6GRBiA99d+wMRFnMjRq6zy3HGJ
 wyyuctwoGlwS7nWOdcl5GsWCX09U
X-Google-Smtp-Source: APXvYqzzwd/78vdfxRunoGHJ00bnzhcjsfwYuv8ueKn3YJiCik9me54bJdLhILKVjGq8emSA6NLhdA==
X-Received: by 2002:a1c:6755:: with SMTP id b82mr4795907wmc.127.1582632482201; 
 Tue, 25 Feb 2020 04:08:02 -0800 (PST)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id h13sm22709423wrw.54.2020.02.25.04.08.01
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Feb 2020 04:08:01 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 129/136] hw/net/milkymist-minimac2: Let devices own the
 MemoryRegion they create
Date: Tue, 25 Feb 2020 13:07:27 +0100
Message-Id: <1582632454-16491-27-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
References: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::336
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Avoid orphan memory regions being added in the /unattached QOM
container.

Note this change break the migration of the LM32 milkymist machine.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200224205533.23798-32-philmd@redhat.com>
Supersedes: <20200221173049.18134-1-philmd@redhat.com>
---
 hw/net/milkymist-minimac2.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/net/milkymist-minimac2.c b/hw/net/milkymist-minimac2.c
index 1ba0175..9582b5f 100644
--- a/hw/net/milkymist-minimac2.c
+++ b/hw/net/milkymist-minimac2.c
@@ -473,9 +473,9 @@ static void milkymist_minimac2_realize(DeviceState *dev, Error **errp)
     sysbus_init_mmio(sbd, &s->regs_region);
 
     /* register buffers memory */
-    memory_region_init_ram_nomigrate(&s->buffers, OBJECT(dev), "milkymist-minimac2.buffers",
+    memory_region_init_ram(&s->buffers, OBJECT(dev),
+                           "milkymist-minimac2.buffers",
                            buffers_size, &error_fatal);
-    vmstate_register_ram_global(&s->buffers);
     s->rx0_buf = memory_region_get_ram_ptr(&s->buffers);
     s->rx1_buf = s->rx0_buf + MINIMAC2_BUFFER_SIZE;
     s->tx_buf = s->rx1_buf + MINIMAC2_BUFFER_SIZE;
@@ -506,8 +506,8 @@ static const VMStateDescription vmstate_milkymist_minimac2_mdio = {
 
 static const VMStateDescription vmstate_milkymist_minimac2 = {
     .name = "milkymist-minimac2",
-    .version_id = 1,
-    .minimum_version_id = 1,
+    .version_id = 2,
+    .minimum_version_id = 2,
     .fields = (VMStateField[]) {
         VMSTATE_UINT32_ARRAY(regs, MilkymistMinimac2State, R_MAX),
         VMSTATE_UINT16_ARRAY(phy_regs, MilkymistMinimac2State, R_PHY_MAX),
-- 
1.8.3.1



