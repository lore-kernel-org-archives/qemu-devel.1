Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D9AAC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 14:07:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0948122510
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 14:07:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iqye65JM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0948122510
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvLb6-0001OM-BS
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 10:07:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35084)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jvLS5-0004SD-Vq; Tue, 14 Jul 2020 09:58:34 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:38924)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jvLS0-0003S6-Hi; Tue, 14 Jul 2020 09:58:33 -0400
Received: by mail-wr1-x441.google.com with SMTP id q5so21792786wru.6;
 Tue, 14 Jul 2020 06:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=xJNAHPmz369DioNcGM4Scwy8Ugn1lj7QhwxPj6ml31c=;
 b=iqye65JM8+hj/MGqzuxOZbmYUlTZ6AdWXw2OCcTI7fNfM+ci6btDSzXyh+o4PT6NW0
 dtxXh8OLEL2KJ2Uglc1ahWJUVYaULQxF45co9prwgapp4WN4/JpjeyDMOxvcp4jEexv2
 sgLS2tht6pFNAh/bJr3vquRn7dx+Hkzn99l82PykgbWxohN0MHyBIFk/PiNbRuvAYHwd
 dOqWiTIwmU6Bs3IV1B2YV8fdzxK5z5j1bm1nupkwLzVgoxE2ZU+7ZuWvjKmfZElA05+E
 YRVbv2IMT4DjmXBGFl4iO8yvgTZBhjct5LDTMp3+O2gqM1dIiSN4RjTslpRaWYqy3ZJy
 tdQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=xJNAHPmz369DioNcGM4Scwy8Ugn1lj7QhwxPj6ml31c=;
 b=qcUWpeM2jyZstOfZCAsYc+Y9Vr5hr9dejp7u5RENxa9NR8F0Gk+lZbaIfMDyaRfQYI
 wBC7mWwoBMm3pAAZ/rnxLnKWZIT8rEnA3TNNyi7tVeIWXGl1uyQ85iuuSSm0p/tPGW4j
 /Zbm2IU9lw+3ZuzpuC5OZOVVQ2aZjL1/8N4iPIY3hFZTkqxKp4133v5DR73Cr6JYGLrs
 6Ky6EX3wzFddciBgxlZbQvraH5zKH7VsvKynLmghlLru0CNdkzhKybMfVSnsMO+1jtlG
 HNACWThVE/YZatoEJhx9ITImAzVWpCL4SqOVqbwDa/XqjI9Ml8HS124I3UsKxQrj7UmM
 hKmg==
X-Gm-Message-State: AOAM530/gCGzlfBw+zxG+drPz0VBjmSOxKPITJapt104Lnc3afXFAWtp
 0PgSPnaMR+2eIaA1o3yhb1VP/BxR9GA=
X-Google-Smtp-Source: ABdhPJyiSvaSVhQJ+rJxWSsOVCQeB7z/TtQcouCdy8qB9Ok/ybsZwGmOt0M246FzkaFMGUQJTI2hgw==
X-Received: by 2002:adf:f34f:: with SMTP id e15mr5769852wrp.415.1594735106722; 
 Tue, 14 Jul 2020 06:58:26 -0700 (PDT)
Received: from localhost.localdomain
 (138.red-83-57-170.dynamicip.rima-tde.net. [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id k14sm29145343wrn.76.2020.07.14.06.58.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2020 06:58:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 8/9] hw/sd/sdcard: Update coding style to make checkpatch.pl
 happy
Date: Tue, 14 Jul 2020 15:58:13 +0200
Message-Id: <20200714135814.19910-9-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200714135814.19910-1-f4bug@amsat.org>
References: <20200714135814.19910-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Prasad J Pandit <ppandit@redhat.com>, Alexander Bulekov <alxndr@bu.edu>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

To make the next commit easier to review, clean this code first.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Alexander Bulekov <alxndr@bu.edu>
Message-Id: <20200630133912.9428-3-f4bug@amsat.org>
---
 hw/sd/sd.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 76d68359a4..f4f76f8fd2 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1175,8 +1175,9 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
             sd->data_start = addr;
             sd->data_offset = 0;
 
-            if (sd->data_start + sd->blk_len > sd->size)
+            if (sd->data_start + sd->blk_len > sd->size) {
                 sd->card_status |= ADDRESS_ERROR;
+            }
             return sd_r1;
 
         default:
@@ -1191,8 +1192,9 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
             sd->data_start = addr;
             sd->data_offset = 0;
 
-            if (sd->data_start + sd->blk_len > sd->size)
+            if (sd->data_start + sd->blk_len > sd->size) {
                 sd->card_status |= ADDRESS_ERROR;
+            }
             return sd_r1;
 
         default:
@@ -1237,12 +1239,15 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
             sd->data_offset = 0;
             sd->blk_written = 0;
 
-            if (sd->data_start + sd->blk_len > sd->size)
+            if (sd->data_start + sd->blk_len > sd->size) {
                 sd->card_status |= ADDRESS_ERROR;
-            if (sd_wp_addr(sd, sd->data_start))
+            }
+            if (sd_wp_addr(sd, sd->data_start)) {
                 sd->card_status |= WP_VIOLATION;
-            if (sd->csd[14] & 0x30)
+            }
+            if (sd->csd[14] & 0x30) {
                 sd->card_status |= WP_VIOLATION;
+            }
             return sd_r1;
 
         default:
@@ -1261,12 +1266,15 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
             sd->data_offset = 0;
             sd->blk_written = 0;
 
-            if (sd->data_start + sd->blk_len > sd->size)
+            if (sd->data_start + sd->blk_len > sd->size) {
                 sd->card_status |= ADDRESS_ERROR;
-            if (sd_wp_addr(sd, sd->data_start))
+            }
+            if (sd_wp_addr(sd, sd->data_start)) {
                 sd->card_status |= WP_VIOLATION;
-            if (sd->csd[14] & 0x30)
+            }
+            if (sd->csd[14] & 0x30) {
                 sd->card_status |= WP_VIOLATION;
+            }
             return sd_r1;
 
         default:
-- 
2.21.3


