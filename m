Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E81BAC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 10:31:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5225206A4
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 10:31:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HiP7ahUE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5225206A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6Wzn-0000Cx-Uy
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 06:31:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46786)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k6VwM-0005bF-Cb; Fri, 14 Aug 2020 05:23:58 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:47055)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k6VwK-0004Kx-2t; Fri, 14 Aug 2020 05:23:58 -0400
Received: by mail-wr1-x442.google.com with SMTP id f12so7710078wru.13;
 Fri, 14 Aug 2020 02:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=zwJXHp3KJLJ5yU+uajIVCj2N/BC26XZ5i/dgkGinGQQ=;
 b=HiP7ahUEXNgf0zHb1YrynIGJLWkYqtD8ozMErmvzrSFXlBj0ZE89dUnWMGjWuFBXTQ
 SCqF02phu2xm3KAi3O30o2kacRymmqf9ZO66OFl/tljXm/FPBUV1PSVH2WiBA3LyYHbR
 vXp7q4XEhRfYbXJl98MdqDXV/xSgvtdr8dq1LZI9w8zTIljAVddJb3xdFzNPJECKYiXj
 iQVpoNezTurv0p1MKES2vV3D8KbJBMIgaTGJ8rTx81Bq9a5A0fR/HM1t+0Rr0oFdaZB8
 HanM64pR3Fg6J6uH52OHU8lwNITL3si8wR3rSVVVzu793mYFE4228s/VDzEqtoIEw3kX
 ExYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=zwJXHp3KJLJ5yU+uajIVCj2N/BC26XZ5i/dgkGinGQQ=;
 b=lqRV030kfOcU2xqPgMPr6ItIk3QTzwKkk1OgIoRvSQ7yamJqVL3+aHk74CBq1D/lYn
 AIhxR4G2C+pz5G4w+9UeG3A3wNUJlCbxXWHxitvCwu2dQGiCj0LntafHNvdBbEe2Wjuh
 4R45iCG0+sxvyLHX5BeK2QY13IGmg3sfd8LbPRZ27nQhKQvakKD+QuglcvDqVtNVMbcO
 eU1jrVyY12EVGJjuU9NHkPdXhq2klssN2sVDTmPOQL4cavlYXEGG29XImTdqEx8vvkCl
 44wL8UI2Sn70dcwDRNX7oNvPBYypZKPtFzogDT1r2ycNofUnAaZKelLvRR1YrHXNKw1k
 xe0A==
X-Gm-Message-State: AOAM533WiPgkQWnnlO5XYIYLUZVFHmgz5B7Immi2kwz0synhMhjdMQjI
 lAqMv3T3zubaHxKwKFqwO3dABzPk+Hs=
X-Google-Smtp-Source: ABdhPJz1fSVWJGjTNSoq/QR3uzElI33jak2hSSYcN0WkCWl/AFHhJhh89LQ9dQbymkqCfbAzAu/peg==
X-Received: by 2002:a5d:51c3:: with SMTP id n3mr1932481wrv.104.1597397033717; 
 Fri, 14 Aug 2020 02:23:53 -0700 (PDT)
Received: from localhost.localdomain (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id b11sm12889395wrq.32.2020.08.14.02.23.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2020 02:23:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/7] hw/sd: Add sdbus_write_data() to write multiples bytes on
 the data line
Date: Fri, 14 Aug 2020 11:23:43 +0200
Message-Id: <20200814092346.21825-5-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200814092346.21825-1-f4bug@amsat.org>
References: <20200814092346.21825-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Beniamino Galvani <b.galvani@gmail.com>, Michael Walle <michael@walle.cc>,
 qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add a sdbus_write_data() method to write multiple bytes on the
data line of a SD bus.
We might improve the tracing later, for now keep logging each
byte individually.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/sd/sd.h |  9 +++++++++
 hw/sd/core.c       | 15 +++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/include/hw/sd/sd.h b/include/hw/sd/sd.h
index 14ffc7f475..3ae3e8939b 100644
--- a/include/hw/sd/sd.h
+++ b/include/hw/sd/sd.h
@@ -175,6 +175,15 @@ void sdbus_write_byte(SDBus *sd, uint8_t value);
  * Return: byte value read
  */
 uint8_t sdbus_read_byte(SDBus *sd);
+/**
+ * Write data to a SD bus.
+ * @sdbus: bus
+ * @buf: data to write
+ * @length: number of bytes to write
+ *
+ * Write multiple bytes of data on the data lines of a SD bus.
+ */
+void sdbus_write_data(SDBus *sdbus, const void *buf, size_t length);
 bool sdbus_data_ready(SDBus *sd);
 bool sdbus_get_inserted(SDBus *sd);
 bool sdbus_get_readonly(SDBus *sd);
diff --git a/hw/sd/core.c b/hw/sd/core.c
index a3b620b802..9c2781ebf9 100644
--- a/hw/sd/core.c
+++ b/hw/sd/core.c
@@ -114,6 +114,21 @@ void sdbus_write_byte(SDBus *sdbus, uint8_t value)
     }
 }
 
+void sdbus_write_data(SDBus *sdbus, const void *buf, size_t length)
+{
+    SDState *card = get_card(sdbus);
+    const uint8_t *data = buf;
+
+    if (card) {
+        SDCardClass *sc = SD_CARD_GET_CLASS(card);
+
+        for (size_t i = 0; i < length; i++) {
+            trace_sdbus_write(sdbus_name(sdbus), data[i]);
+            sc->write_byte(card, data[i]);
+        }
+    }
+}
+
 uint8_t sdbus_read_byte(SDBus *sdbus)
 {
     SDState *card = get_card(sdbus);
-- 
2.21.3


