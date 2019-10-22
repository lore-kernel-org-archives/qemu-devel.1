Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC276CA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 14:08:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B284521783
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 14:08:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aa5dwVgz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B284521783
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMupd-0003lQ-3g
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 10:08:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37198)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iMuHS-0003Sh-KU
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 09:32:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iMuHR-0001av-9v
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 09:32:58 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:50827)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iMuHR-0001ai-4A
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 09:32:57 -0400
Received: by mail-wm1-x343.google.com with SMTP id q13so7252434wmj.0
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 06:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=VQV5FCBK+kBKKN7cw2HOegQIhSxfiRcO/BOW8D/eYOc=;
 b=aa5dwVgzlasXISGNrziOqMe0yxooTPHy5i1Q6TRlHvjYDMP3m1drDJQFN5QT/XQv0J
 9WZF2/9VgOEZBEvI67MS9D0ub/OvWI+EDO7tg3yqlPSslzkgJczsW6bPKKoIOtgCYIfm
 ZOGZ+rdXEpA/CVnxtiBvwp+8+7HvnokwkA3B08euaBKszT832A752itu4dL73MkawLN+
 ujkdhnxzqRilOiCuktVCY7rwrn0OeiaYqZGikPPAVaB/NWcqga8n+/JQaTtrvW4rTX4u
 70H+EYxge9UwJGiUsDURez0ksQl8hN5nBIH4KLl95t3ELhqaKJewia2oqqACskjojHBv
 AV5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=VQV5FCBK+kBKKN7cw2HOegQIhSxfiRcO/BOW8D/eYOc=;
 b=n2+tUvlw7nrUvvT4aOIXDtgInAn2m0vrzy4cO5uZFLJ8agOul7uQjYXfYmH4To7a4m
 KampQsfjmAXU4vlJb3HIG+7cYyOlv6Kh6N2/FjG8V4ZdOWi4yC7l/p7O0ZSF/dIlI/QD
 xVDK1SKY1PLFzuY4D0VGDRsOcRE5EQfLPNZklbHxJKb1ozaY8QGCsOfmwljbzXFMqvtx
 IdB8ReMvPLAJoVwp4gRmeG/kBz2D3yO5FgkPBly7AFUoORqYHKPXGAew74u7PmHUhuOI
 W2qBn2V8tB08uokDffb58ZWKNxxULQCsZwFOvPMzxni4ahABy9sP0ujCUEXuKGzLFN8l
 eoTQ==
X-Gm-Message-State: APjAAAXUqOLQS5RlM8r2bpwCs3mEw7zrsGg8catpB6BqYHcLen9UHiyq
 7x3kXfxMMwiLQRYChIcLlipuirtVo/s=
X-Google-Smtp-Source: APXvYqzu1qpHbhz8Ocw9Cmci6sLNR9WANJYbGTuDL6ttt63TyE+Uck2IOTN7wnzsEsOsTGEUpWQFAA==
X-Received: by 2002:a7b:c924:: with SMTP id h4mr3210630wml.46.1571751175554;
 Tue, 22 Oct 2019 06:32:55 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id r2sm20263856wma.1.2019.10.22.06.32.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2019 06:32:53 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 34/41] hw/sd/sdhci: Add dummy Samsung SDHCI controller
Date: Tue, 22 Oct 2019 14:31:27 +0100
Message-Id: <20191022133134.14487-35-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191022133134.14487-1-peter.maydell@linaro.org>
References: <20191022133134.14487-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

The Linux kernel access few S3C-specific registers [1] to set some
clock. We don't care about this part for device emulation [2]. Add
a dummy device to properly ignore these accesses, so we can focus
on the important registers missing.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/mmc/host/sdhci-s3c-regs.h?h=cc014f3
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/mmc/host/sdhci-s3c.c?h=v5.3#n263

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Message-id: 20191005154748.21718-4-f4bug@amsat.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/sd/sdhci.h |  2 ++
 hw/sd/sdhci.c         | 65 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 67 insertions(+)

diff --git a/include/hw/sd/sdhci.h b/include/hw/sd/sdhci.h
index cbf415e43ab..c6868c96994 100644
--- a/include/hw/sd/sdhci.h
+++ b/include/hw/sd/sdhci.h
@@ -116,4 +116,6 @@ typedef struct SDHCIState {
 
 #define TYPE_IMX_USDHC "imx-usdhc"
 
+#define TYPE_S3C_SDHCI "s3c-sdhci"
+
 #endif /* SDHCI_H */
diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 82ec5c1b4a4..88404d0e9d5 100644
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
-- 
2.20.1


