Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79B84C2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 15:19:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4410024686
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 15:19:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SoKsJ7ZJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4410024686
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2GHP-00032K-H8
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 10:19:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60603)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j2FhP-0004qb-Gr
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:42:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j2FhN-0002QS-Tu
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:42:39 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:53668)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j2FhN-0002NB-LR
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:42:37 -0500
Received: by mail-wm1-x343.google.com with SMTP id s10so6542783wmh.3
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 06:42:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=H2gaLGMf5euvRIXxKTQ5zYLvx8BCFxjRX5PrMkWbQvc=;
 b=SoKsJ7ZJIlfsqCATGm3t1EyJ43/X+p7ji9LtUAQ6vmoETh2SBKYtjlK5U6Ij7ZAYfx
 pwLwnQOOb381oZjYW6zGU3B/cTRNJc+MWwKhqoKgbiOOd53LB8BoBwoe8A+9hpBgaUBi
 0rzQE8mVni2rWBgCfkt2jUD6m76sK+ANDuxyhGMT+lUCFjS17kUS4B1ChSjkuPNnqmpZ
 P8SVL7LzSLTCamZUlqFv1k20dGYQSiae1+ySEsNOwORur9O6m6E06HmVV3eQaK1oIFcF
 D7Yl3/3sW68UYhdgx9te8rkyY/oUN/I4WW8WVIW/YyoqGRDXlRxQxqN4Ji9JrbQDB7Rb
 YfxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=H2gaLGMf5euvRIXxKTQ5zYLvx8BCFxjRX5PrMkWbQvc=;
 b=G3q2KJn2DOPvgcqb+W5rQ6bflmOiUj/Zn9VYQmFdIylzLo7Q50gKQUdE7vqQz+Pi4d
 CNE1m7RV2Ewpdbb2Rl1bJKjFU9+oYyYDyCBzKLHGNWm5A1LulvEwU+Qs8SFLpaEvIa0X
 Y9tFo7Y/2Qg3gXD/9QFtOBXULtPT8QtU223wUEHqFO7E4CYOeSmt/egSH6ZV6415HTb6
 kHSysZXsvbPl8sh49fo5b1TlVavH7/wIUkcWc8VgX5MvuZqdSRvMoXTJ8oNxjck7L77N
 qRkvT9Jkmex7vqZZzHmKGaPdsyzdW/zoJmmBNGbv+UK5QCETG/QTCax68zqZ/JsB6VGZ
 V1/w==
X-Gm-Message-State: APjAAAVYP9X4ev4sIf0ThwC+0KDcWxDUMHBBCVE53evAtLHhP7FwTino
 s9cHIGvPgR9D3rxrWyatCBDmgOo87IE=
X-Google-Smtp-Source: APXvYqxdU9Yy5oLbvgcfJyMFVcOMslSR9ciafr2LYAwtdBtL0DCCOOwW2SLigVx2odbGFGzO4W1tTw==
X-Received: by 2002:a1c:2786:: with SMTP id n128mr6010122wmn.47.1581604955432; 
 Thu, 13 Feb 2020 06:42:35 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id e22sm3362454wme.45.2020.02.13.06.42.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2020 06:42:34 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 43/46] hw/arm/raspi: Extract the board model from the board
 revision
Date: Thu, 13 Feb 2020 14:41:42 +0000
Message-Id: <20200213144145.818-44-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200213144145.818-1-peter.maydell@linaro.org>
References: <20200213144145.818-1-peter.maydell@linaro.org>
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

The board revision encode the model type. Add a helper
to extract the model, and use it.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 20200208165645.15657-12-f4bug@amsat.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/raspi.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index f0dcffbc2ef..0537fc0a2d1 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -101,6 +101,20 @@ static const char *board_soc_type(uint32_t board_rev)
     return soc_types[proc_id];
 }
 
+static const char *board_type(uint32_t board_rev)
+{
+    static const char *types[] = {
+        "A", "B", "A+", "B+", "2B", "Alpha", "CM1", NULL, "3B", "Zero",
+        "CM3", NULL, "Zero W", "3B+", "3A+", NULL, "CM3+", "4B",
+    };
+    assert(FIELD_EX32(board_rev, REV_CODE, STYLE)); /* Only new style */
+    int bt = FIELD_EX32(board_rev, REV_CODE, TYPE);
+    if (bt >= ARRAY_SIZE(types) || !types[bt]) {
+        return "Unknown";
+    }
+    return types[bt];
+}
+
 static void write_smpboot(ARMCPU *cpu, const struct arm_boot_info *info)
 {
     static const uint32_t smpboot[] = {
@@ -287,7 +301,7 @@ static void raspi2_machine_class_init(ObjectClass *oc, void *data)
     uint32_t board_rev = (uint32_t)(uintptr_t)data;
 
     rmc->board_rev = board_rev;
-    mc->desc = "Raspberry Pi 2B";
+    mc->desc = g_strdup_printf("Raspberry Pi %s", board_type(board_rev));
     mc->init = raspi_machine_init;
     mc->block_default_type = IF_SD;
     mc->no_parallel = 1;
@@ -308,7 +322,7 @@ static void raspi3_machine_class_init(ObjectClass *oc, void *data)
     uint32_t board_rev = (uint32_t)(uintptr_t)data;
 
     rmc->board_rev = board_rev;
-    mc->desc = "Raspberry Pi 3B";
+    mc->desc = g_strdup_printf("Raspberry Pi %s", board_type(board_rev));
     mc->init = raspi_machine_init;
     mc->block_default_type = IF_SD;
     mc->no_parallel = 1;
-- 
2.20.1


