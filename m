Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50A07C3A5A1
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 08:13:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2922121848
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 08:13:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2922121848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0iDv-0007a1-2L
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 04:13:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53937)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1i0i5m-0007Lz-Eg
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 04:05:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1i0i5l-0005pj-7B
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 04:05:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40734)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1i0i5l-0005oz-0d
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 04:05:09 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 44A58111A440;
 Thu, 22 Aug 2019 08:05:08 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-60.ams2.redhat.com
 [10.36.116.60])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EA1207E43;
 Thu, 22 Aug 2019 08:05:03 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 1B44C9AF5; Thu, 22 Aug 2019 10:05:03 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 22 Aug 2019 10:04:56 +0200
Message-Id: <20190822080503.12063-3-kraxel@redhat.com>
In-Reply-To: <20190822080503.12063-1-kraxel@redhat.com>
References: <20190822080503.12063-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.66]); Thu, 22 Aug 2019 08:05:08 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 2/8] ati-vga: Add some register definitions for
 debugging
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
Cc: Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: BALATON Zoltan <balaton@eik.bme.hu>

Add names for AMCGPIO regs to make it easier to identify these in
trace output. This is where rage128p has the DDC from the DVI port
among others but because we don't implement the flat panel controller
we don't want to connect an EDID here to make sure drivers use the VGA
output instead. But since these are often probed by drivers it helps
to see what happens by logging these registers by name.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Message-id: 31ff69ca6959d090869907774faa1af7d2c02b2b.1565558093.git.balaton@eik.bme.hu
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/display/ati_regs.h | 4 ++++
 hw/display/ati_dbg.c  | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/hw/display/ati_regs.h b/hw/display/ati_regs.h
index 81fb5302c036..91947ab1e7f7 100644
--- a/hw/display/ati_regs.h
+++ b/hw/display/ati_regs.h
@@ -41,6 +41,10 @@
 #define GPIO_DVI_DDC                            0x0064
 #define GPIO_MONID                              0x0068
 #define I2C_CNTL_1                              0x0094
+#define AMCGPIO_MASK_MIR                        0x009c
+#define AMCGPIO_A_MIR                           0x00a0
+#define AMCGPIO_Y_MIR                           0x00a4
+#define AMCGPIO_EN_MIR                          0x00a8
 #define PALETTE_INDEX                           0x00b0
 #define PALETTE_DATA                            0x00b4
 #define CNFG_CNTL                               0x00e0
diff --git a/hw/display/ati_dbg.c b/hw/display/ati_dbg.c
index cbc52025d01c..7e59c41ac2ce 100644
--- a/hw/display/ati_dbg.c
+++ b/hw/display/ati_dbg.c
@@ -23,6 +23,10 @@ static struct ati_regdesc ati_reg_names[] = {
     {"GPIO_DVI_DDC", 0x0064},
     {"GPIO_MONID", 0x0068},
     {"I2C_CNTL_1", 0x0094},
+    {"AMCGPIO_MASK_MIR", 0x009c},
+    {"AMCGPIO_A_MIR", 0x00a0},
+    {"AMCGPIO_Y_MIR", 0x00a4},
+    {"AMCGPIO_EN_MIR", 0x00a8},
     {"PALETTE_INDEX", 0x00b0},
     {"PALETTE_DATA", 0x00b4},
     {"CNFG_CNTL", 0x00e0},
-- 
2.18.1


