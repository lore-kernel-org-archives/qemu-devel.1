Return-Path: <SRS0=HB7V=X6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5253CC47404
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2019 15:50:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D5942133F
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2019 15:50:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JqbRLn/S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D5942133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGmJl-0001mJ-T8
	for qemu-devel@archiver.kernel.org; Sat, 05 Oct 2019 11:50:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46568)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iGmHn-0008K3-9L
 for qemu-devel@nongnu.org; Sat, 05 Oct 2019 11:48:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iGmHl-0007ya-MM
 for qemu-devel@nongnu.org; Sat, 05 Oct 2019 11:47:59 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:43802)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iGmHl-0007yF-Cv; Sat, 05 Oct 2019 11:47:57 -0400
Received: by mail-wr1-x441.google.com with SMTP id j18so9666661wrq.10;
 Sat, 05 Oct 2019 08:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=cNN3zQlFhxT6iWGCrzkAdnUP+7NnUIzpyS9EQoIRQR4=;
 b=JqbRLn/SSsx3jDPMksphf3Pr+g5XNUQeJ1HfM1cAu4jOb5wg3788xC6s7NUuNTg7Hm
 DYhCjvtvVKBPAo78V5UkM/x3bi1V8IspkdkNV7bp2XXFJiv4yiaB0JaqYN535CELxpHZ
 CnR/ifhhEBQZj8um1FC58jE2M+JCnM67HMKizsc7CXt7xBylcpARsDEW6Cnwrd95NXoA
 0m0hlB/tZjwDPNVsWJaPf1esu9yJfIwCD8D20l3LRLRm6/uOw9fEm3KcbSibVyJIQQsB
 B4UwXrowNli4IVbMJlhJ9OnrLqAHjaMTDpAd/Hs8q+98yPfDwnvQjvfCcLOBYrY7TvYi
 JqgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=cNN3zQlFhxT6iWGCrzkAdnUP+7NnUIzpyS9EQoIRQR4=;
 b=tvQnoD/rSZCw7I5O6AIOCO6F5d5e4az1qhQsU9VLtsfgA2q83zHcNniGLU86DGIbHK
 QpGRdDqu723Z20gbTirE0oKmNn14jWpnnIGHm4950sOc+4myLSQ3/V4d4lYRrIltjgvl
 W207NRBvw5/uJUvQBiOwcLx73HIJ10eyzhJXUYpg1NkPVc5fcVDD+RutDJ/YEy+QKYS+
 5NgPd8Ten+YDBV8IX6/4E5usDPe/p0dSc2XYY0kufPWUeM6nxdvQ0ub6fuQrZsU5c1ZX
 z6hKFk2sxbvUvmu8iMqsVfmiQbUFmbfie3CfHoa1alq8afA4XQMJTjHeQC35wRuC+jKy
 Q00A==
X-Gm-Message-State: APjAAAU63EdQlzfAWPqpxyOuhHBK5QGn+5tXdsFf9pmSuFw+rwFcxPlS
 K/bQ2EjF1FfCfcgt0m3eqot44Xwum3s=
X-Google-Smtp-Source: APXvYqzSG5PGCSenCjwNYiwzqbh2B1823YqpSd3zAXjT6SFJYjqgT2t+TuVG2lPsayAoiv9IrziCWA==
X-Received: by 2002:adf:afed:: with SMTP id y45mr15778527wrd.347.1570290475969; 
 Sat, 05 Oct 2019 08:47:55 -0700 (PDT)
Received: from localhost.localdomain (46.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.46])
 by smtp.gmail.com with ESMTPSA id o22sm24542294wra.96.2019.10.05.08.47.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Oct 2019 08:47:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/5] hw/sd/sdhci: Add dummy Samsung SDHCI controller
Date: Sat,  5 Oct 2019 17:47:46 +0200
Message-Id: <20191005154748.21718-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191005154748.21718-1-f4bug@amsat.org>
References: <20191005154748.21718-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Basse?= <contact@fredericb.info>,
 Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Evgeny Voevodin <e.voevodin@samsung.com>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-arm@nongnu.org,
 Dmitry Solodkiy <d.solodkiy@samsung.com>, Cleber Rosa <crosa@redhat.com>,
 Maksim Kozlov <m.kozlov@samsung.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Guenter Roeck <linux@roeck-us.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The Linux kernel access few S3C-specific registers [1] to set some
clock. We don't care about this part for device emulation [2]. Add
a dummy device to properly ignore these accesses, so we can focus
on the important registers missing.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/mmc/host/sdhci-s3c-regs.h?h=cc014f3
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/mmc/host/sdhci-s3c.c?h=v5.3#n263

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
Eventually we should add the ADMA changes Igor sent in this patch:
https://patchwork.ozlabs.org/patch/181854/
They might solve the boot timing issues when using SD cards.
---
 hw/sd/sdhci.c         | 65 +++++++++++++++++++++++++++++++++++++++++++
 include/hw/sd/sdhci.h |  2 ++
 2 files changed, 67 insertions(+)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 82ec5c1b4a..88404d0e9d 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -1761,11 +1761,76 @@ static const TypeInfo imx_usdhc_info = {
     .instance_init = imx_usdhc_init,
 };
 
+/* --- qdev Samsung s3c --- */
+
+#define S3C_SDHCI_CONTROL2      0x80
+#define S3C_SDHCI_CONTROL3      0x84
+#define S3C_SDHCI_CONTROL4      0x8c
+
+static uint64_t sdhci_s3c_read(void *opaque, hwaddr offset, unsigned size)
+{
+    uint64_t ret;
+
+    switch (offset) {
+    case S3C_SDHCI_CONTROL2:
+    case S3C_SDHCI_CONTROL3:
+    case S3C_SDHCI_CONTROL4:
+        /* ignore */
+        ret = 0;
+        break;
+    default:
+        ret = sdhci_read(opaque, offset, size);
+        break;
+    }
+
+    return ret;
+}
+
+static void sdhci_s3c_write(void *opaque, hwaddr offset, uint64_t val,
+                            unsigned size)
+{
+    switch (offset) {
+    case S3C_SDHCI_CONTROL2:
+    case S3C_SDHCI_CONTROL3:
+    case S3C_SDHCI_CONTROL4:
+        /* ignore */
+        break;
+    default:
+        sdhci_write(opaque, offset, val, size);
+        break;
+    }
+}
+
+static const MemoryRegionOps sdhci_s3c_mmio_ops = {
+    .read = sdhci_s3c_read,
+    .write = sdhci_s3c_write,
+    .valid = {
+        .min_access_size = 1,
+        .max_access_size = 4,
+        .unaligned = false
+    },
+    .endianness = DEVICE_LITTLE_ENDIAN,
+};
+
+static void sdhci_s3c_init(Object *obj)
+{
+    SDHCIState *s = SYSBUS_SDHCI(obj);
+
+    s->io_ops = &sdhci_s3c_mmio_ops;
+}
+
+static const TypeInfo sdhci_s3c_info = {
+    .name = TYPE_S3C_SDHCI  ,
+    .parent = TYPE_SYSBUS_SDHCI,
+    .instance_init = sdhci_s3c_init,
+};
+
 static void sdhci_register_types(void)
 {
     type_register_static(&sdhci_sysbus_info);
     type_register_static(&sdhci_bus_info);
     type_register_static(&imx_usdhc_info);
+    type_register_static(&sdhci_s3c_info);
 }
 
 type_init(sdhci_register_types)
diff --git a/include/hw/sd/sdhci.h b/include/hw/sd/sdhci.h
index cbf415e43a..c6868c9699 100644
--- a/include/hw/sd/sdhci.h
+++ b/include/hw/sd/sdhci.h
@@ -116,4 +116,6 @@ typedef struct SDHCIState {
 
 #define TYPE_IMX_USDHC "imx-usdhc"
 
+#define TYPE_S3C_SDHCI "s3c-sdhci"
+
 #endif /* SDHCI_H */
-- 
2.20.1


