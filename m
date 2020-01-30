Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E76B1C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 16:30:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2086206D5
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 16:30:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T6Ax4MNC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2086206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixCiM-0005K5-SP
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 11:30:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43271)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ixCU7-0005ms-3G
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 11:16:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ixCU5-00037G-KJ
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 11:16:02 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:52560)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ixCU4-00035o-EQ
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 11:16:01 -0500
Received: by mail-wm1-x333.google.com with SMTP id p9so4410436wmc.2
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2020 08:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=dtQiX/MRRlIpxjI4PpXQAgny+XholocDWMM4mNtP8hw=;
 b=T6Ax4MNCp9n7ti4kobHPMF/yOGEiWv9V7JaWdtm4ioLfDHOmNzS1LCd2Q4XfOxDkcu
 Smegi6DCUKdLZ5ZFlpYZ1iLYOskjl8K7TfBJ7Ayy9UyR/t5zi0XCmO4T3ikjlPSpR5ot
 b3D3JMI/RsKy+CmXepquAaJxBLV0znsIF1689K9d88g1YSCj38XIyatiWR+lC9b4xB2k
 ohnfu9d3e9t2BkPAptFhTS94fOcCXOGw4jlZViY0F47uHfUAwYetrcWL59i9nf5DW6Xh
 2255QPqraAdIsbjz3YzfdPwoHXfmsvBBhkaTVxgI4jjUlA9Wlv5juMl8pYa94SbBufkE
 DqTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=dtQiX/MRRlIpxjI4PpXQAgny+XholocDWMM4mNtP8hw=;
 b=CbbaVF7PSE6f8xNMpQYDxh09tLUqmP6+iD1nmohlCd9TL7oeSKN6dc9XbWjCG/QPaU
 uvQDunwnmhXKjB34qyZye1DOLfKhW/L5y0xOC7zeMBbsjMPSfWKZJVnwv0IeOmVuRLOH
 NMcmqCISK8gz70M6RRVPAH+IYs0Vgsk73q7bm4SgYHXSb4fa97diNrT05CPi8cUUZOk0
 XieNKfiXUj6yteVTo2W/U2ukOQO4V81UruQhsagH0NjAhmVJVFizXc0B7Bo6rRxSszc5
 L2vLpWfGIEq6yJqYNTnadhCwnNXVZTfL4wHMzwuN5iUQ/DRMhAYhmEZWxrfaOWnr8KOt
 dz7A==
X-Gm-Message-State: APjAAAWqYUGpWMEqHGYQYF1/W58gmolROwNVCFdMn/dbsgov1JlXZXwt
 aLJLsqBQShhdE4aQs9OcaqxnerY/a1wKSg==
X-Google-Smtp-Source: APXvYqy4jR7M/6lz0hTdCYGP8OANqsvE2q/Z9PPEFSBj5I13sYNsfILwtYpkyn3nHBFV80FFP1Rxtw==
X-Received: by 2002:a05:600c:21c6:: with SMTP id
 x6mr6454258wmj.177.1580400958718; 
 Thu, 30 Jan 2020 08:15:58 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id a22sm6994442wmd.20.2020.01.30.08.15.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jan 2020 08:15:57 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 18/26] vl: replace deprecated qbus_reset_all registration
Date: Thu, 30 Jan 2020 16:15:25 +0000
Message-Id: <20200130161533.8180-19-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200130161533.8180-1-peter.maydell@linaro.org>
References: <20200130161533.8180-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::333
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Damien Hedde <damien.hedde@greensocs.com>

Replace deprecated qbus_reset_all by resettable_cold_reset_fn for
the sysbus reset registration.

Apart for the raspi machines, this does not impact the behavior
because:
+ at this point resettable just calls the old reset methods of devices
  and buses in the same order as qdev/qbus.
+ resettable handlers registered with qemu_register_reset are
  serialized; there is no interleaving.
+ eventual explicit calls to legacy reset API (device_reset or
  qdev/qbus_reset) inside this reset handler will not be masked out
  by resettable mechanism; they do not go through resettable api.

For the raspi machines, during the sysbus reset the sd-card is not
reset twice anymore but only once. This is a consequence of switching
both sysbus reset and changing parent to resettable; it detects the
second reset is not needed. This has no impact on the state after
reset; the sd-card reset method only reset local state and query
information from the block backend.

The raspi reset change can be observed by using the following command
(reset will occurs, then do Ctrl-C to end qemu; no firmware is
given here).
qemu-system-aarch64 -M raspi3 \
    -trace resettable_phase_hold_exec \
    -trace qdev_update_parent_bus \
    -trace resettable_change_parent \
    -trace qdev_reset -trace qbus_reset

Before the patch, the qdev/qbus_reset traces show when reset method are
called. After the patch, the resettable_phase_hold_exec show when reset
method are called.

The traced reset order of the raspi3 is listed below. I've added empty
lines and the tree structure.

 +->bcm2835-peripherals reset
 |
 |       +->sd-card reset
 |   +->sd-bus reset
 +->bcm2835_gpio reset
 |      -> dev_update_parent_bus (move the sd-card on the sdhci-bus)
 |      -> resettable_change_parent
 |
 +->bcm2835-dma reset
 |
 |   +->bcm2835-sdhost-bus reset
 +->bcm2835-sdhost reset
 |
 |       +->sd-card (reset ONLY BEFORE BEFORE THE PATCH)
 |   +->sdhci-bus reset
 +->generic-sdhci reset
 |
 +->bcm2835-rng reset
 +->bcm2835-property reset
 +->bcm2835-fb reset
 +->bcm2835-mbox reset
 +->bcm2835-aux reset
 +->pl011 reset
 +->bcm2835-ic reset
 +->bcm2836-control reset
System reset

In both case, the sd-card is reset (being on bcm2835_gpio/sd-bus) then moved
to generic-sdhci/sdhci-bus by the bcm2835_gpio reset method.

Before the patch, it is then reset again being part of generic-sdhci/sdhci-bus.
After the patch, it considered again for reset but its reset method is not
called because it is already flagged as reset.

Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20200123132823.1117486-11-damien.hedde@greensocs.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 vl.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/vl.c b/vl.c
index b0f52c4d6e0..24951b51a94 100644
--- a/vl.c
+++ b/vl.c
@@ -4381,7 +4381,15 @@ int main(int argc, char **argv, char **envp)
 
     /* TODO: once all bus devices are qdevified, this should be done
      * when bus is created by qdev.c */
-    qemu_register_reset(qbus_reset_all_fn, sysbus_get_default());
+    /*
+     * TODO: If we had a main 'reset container' that the whole system
+     * lived in, we could reset that using the multi-phase reset
+     * APIs. For the moment, we just reset the sysbus, which will cause
+     * all devices hanging off it (and all their child buses, recursively)
+     * to be reset. Note that this will *not* reset any Device objects
+     * which are not attached to some part of the qbus tree!
+     */
+    qemu_register_reset(resettable_cold_reset_fn, sysbus_get_default());
     qemu_run_machine_init_done_notifiers();
 
     if (rom_check_and_register_reset() != 0) {
-- 
2.20.1


