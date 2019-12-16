Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CCC7C43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 11:34:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 071B8206D3
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 11:34:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RJZUjOgv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 071B8206D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igodg-00061j-Dg
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 06:34:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51028)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1igoFk-0007ne-Mi
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:09:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1igoFj-0008DF-Dc
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:09:28 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:54091)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1igoFj-000888-6m
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:09:27 -0500
Received: by mail-wm1-x344.google.com with SMTP id m24so4865941wmc.3
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 03:09:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=L01Bt7Pn8EbpPwCHMv8nyAgPyUlPk/hoQ9vzWdPLN80=;
 b=RJZUjOgvO0qyIxENiw+1QxNEsvUdcvTb8Qc3CzTD924W2vt2U8C0LtCdmp3Bcc5QVx
 H3u47BgHUXjpQKF/bUZstVXnhq+FRR/1RyLKHjc1tgYBUC6DDxgYnqnZAA6X3gVALJwp
 XTC10qkSry5tuYki+YgBmBp/rGyPS6yK5UOdWzZAqJhQKmNlWY4GEr3sVvm7Rm5U2PCi
 J8+lw4TO1PwTStg/FOHNxnceyd9w4gg40x+El8DU3sdqvcCAxtukYD4ByfZnB/KtMgju
 1o+qMTOPnMm6o2IaWA5LRtTtbTCZ453nDjVjStALYdWk6anB6p8kuZy+ixBWd2iJXOR/
 sMog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=L01Bt7Pn8EbpPwCHMv8nyAgPyUlPk/hoQ9vzWdPLN80=;
 b=EoLKi32BEeJzPg1T9G+qWuyK3zEJUVgCniF35A23oc8OfqBFPSRR13hkED7X7wibdf
 JuNmxIqZxkIemJ9kgH5UesBMEHYcGmt6ZfIbeBpKGDooZ7bZTbBz7AoIYf3S11N2Oz4t
 LKhP1bF4x636VJddsvVOrJTt947Rw0/wPpIaRz6Ps76gVM/gc8bfkF7jk3XJxzjK+loO
 wVdI9/pNWb9P5ohkzaEokabOC/3FzyMYzU36FkfPchU6kfINI8lmYwURiYjgZp6pOyin
 Z+Mk3omWzWYNCFboAkNHSjOdOdBPDcH1K2mwVwepw534d1c5j0CWlNfCtaCAeKxwTNlv
 bjsw==
X-Gm-Message-State: APjAAAX7Aj3vkZXgXBlhRZ3WdGyb+Ed1U+h11ZGW2SnwsequsD2lOBPA
 HS4oVpbyDW8+LhHNpNeq4w52AtxrL5Gtxg==
X-Google-Smtp-Source: APXvYqxeDTVy51nQQ4NPncoZFp95ISBxcKkumABMZ8jixJWukFSxp6+EuolYveD8daa5s6ZqrWG3Gg==
X-Received: by 2002:a7b:cd83:: with SMTP id y3mr28187588wmj.168.1576494564817; 
 Mon, 16 Dec 2019 03:09:24 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id x10sm20976131wrp.58.2019.12.16.03.09.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2019 03:09:24 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 16/34] aspeed: Add support for the tacoma-bmc board
Date: Mon, 16 Dec 2019 11:08:46 +0000
Message-Id: <20191216110904.30815-17-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191216110904.30815-1-peter.maydell@linaro.org>
References: <20191216110904.30815-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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

From: Cédric Le Goater <clg@kaod.org>

The Tacoma BMC board is replacement board for the BMC of the OpenPOWER
Witherspoon system. It uses a AST2600 SoC instead of a AST2500 and the
I2C layout is the same as it controls the same main board. Used for HW
bringup.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
Message-id: 20191119141211.25716-15-clg@kaod.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/aspeed.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index e34e6787430..cc06af4fbb3 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -92,6 +92,10 @@ struct AspeedBoardState {
 #define AST2600_EVB_HW_STRAP1 0x000000C0
 #define AST2600_EVB_HW_STRAP2 0x00000003
 
+/* Tacoma hardware value */
+#define TACOMA_BMC_HW_STRAP1  0x00000000
+#define TACOMA_BMC_HW_STRAP2  0x00000000
+
 /*
  * The max ram region is for firmwares that scan the address space
  * with load/store to guess how much RAM the SoC has.
@@ -363,6 +367,9 @@ static void witherspoon_bmc_i2c_init(AspeedBoardState *bmc)
     AspeedSoCState *soc = &bmc->soc;
     uint8_t *eeprom_buf = g_malloc0(8 * 1024);
 
+    /* Bus 3: TODO bmp280@77 */
+    /* Bus 3: TODO max31785@52 */
+    /* Bus 3: TODO dps310@76 */
     i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 3), TYPE_PCA9552,
                      0x60);
 
@@ -381,6 +388,7 @@ static void witherspoon_bmc_i2c_init(AspeedBoardState *bmc)
                           eeprom_buf);
     i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 11), TYPE_PCA9552,
                      0x60);
+    /* Bus 11: TODO ucd90160@64 */
 }
 
 static void aspeed_machine_class_init(ObjectClass *oc, void *data)
@@ -485,6 +493,22 @@ static void aspeed_machine_ast2600_evb_class_init(ObjectClass *oc, void *data)
     mc->default_ram_size = 1 * GiB;
 };
 
+static void aspeed_machine_tacoma_class_init(ObjectClass *oc, void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+    AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
+
+    mc->desc       = "Aspeed AST2600 EVB (Cortex A7)";
+    amc->soc_name  = "ast2600-a0";
+    amc->hw_strap1 = TACOMA_BMC_HW_STRAP1;
+    amc->hw_strap2 = TACOMA_BMC_HW_STRAP2;
+    amc->fmc_model = "mx66l1g45g";
+    amc->spi_model = "mx66l1g45g";
+    amc->num_cs    = 2;
+    amc->i2c_init  = witherspoon_bmc_i2c_init; /* Same board layout */
+    mc->default_ram_size = 1 * GiB;
+};
+
 static const TypeInfo aspeed_machine_types[] = {
     {
         .name          = MACHINE_TYPE_NAME("palmetto-bmc"),
@@ -510,6 +534,10 @@ static const TypeInfo aspeed_machine_types[] = {
         .name          = MACHINE_TYPE_NAME("ast2600-evb"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_ast2600_evb_class_init,
+    }, {
+        .name          = MACHINE_TYPE_NAME("tacoma-bmc"),
+        .parent        = TYPE_ASPEED_MACHINE,
+        .class_init    = aspeed_machine_tacoma_class_init,
     }, {
         .name          = TYPE_ASPEED_MACHINE,
         .parent        = TYPE_MACHINE,
-- 
2.20.1


