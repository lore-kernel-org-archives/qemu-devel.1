Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7956C433E4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 14:01:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 874D222267
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 14:01:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vUkZjAiq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 874D222267
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvLVG-0001E4-Ml
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 10:01:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35006)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jvLRz-0004Ca-5z; Tue, 14 Jul 2020 09:58:27 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:46954)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jvLRx-0003RQ-IC; Tue, 14 Jul 2020 09:58:26 -0400
Received: by mail-wr1-x441.google.com with SMTP id r12so21717594wrj.13;
 Tue, 14 Jul 2020 06:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qdaethCtbmwxVVjeZXalK6EzGf52ykfDlbfqX2TJkVg=;
 b=vUkZjAiqe1MaENLAtCNcHc3UpXA9CN1HQSEkcVq38xEA9Nm1L76nO/n05QtcMHSWVm
 qPkhWXVVHL+U12n0S7gx16CMHCZEbVz19PNHZh1wOGI7Txbyr5dMAWZtqT8xEl0cwTtN
 c4BNqKw8J80gmoSyNDO+AB8sK4jpsrPRmebRgh8e6mEAUzVXTA9ADMOu7qD+MOlmYqmu
 9/TEV7J06iE5Vt1xwagYnZDq5GI4fqpKf3+fTO9+4JqGQnaOlFqyZvH94hSp1CsD/sxG
 7SZokAwJA32WSG9G7UiZt/JgAXzhBYHzZu9+OUH26x+REIrHOCi/62ZhBiIzaVEpwhHe
 02HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=qdaethCtbmwxVVjeZXalK6EzGf52ykfDlbfqX2TJkVg=;
 b=aGXXFHGNiFCSY0z0hVFKIS4ZR4p8YbDb2oT0muCclxiwbxRdqpDKY3OaG9QTxPOOHQ
 3ZSDyWH3eEmEIGXSBbwrAZsbgMoK/UuopK2oiBR/IEBpE4A48XsmTuV5xwE1PcGbZGbg
 yGbQS765CrUofsfxiCq5rS9G2dP5xIC/ub2IwdsYop06hZtHkFd4rg1tIHu98kZY0j/e
 D51Si1x9dRSi772dJcECNaH6QakQDwN+IxDQFVmBbIGRz7koBiLpvXZTRrV0CznQuUOR
 3my2c4ZfdRduYOgCIqlavGqEl/SMmeOhQaaj0InlOH7MFXZbzKIli0b0kPyL2k5fZePE
 NUxg==
X-Gm-Message-State: AOAM532P+CgvLrXUkfuULyUVEXRmLVfhMaku/e2sBytsU1HguHtuFRfm
 8jc/UF7mozOWckkRTNypQ+L9uSkI+9g=
X-Google-Smtp-Source: ABdhPJw0b9oM3ooLZseqYXZhs7Ci6R9aXgnT6N1WswBsMBgP8XfaYYLhpzRFVQC/GuNQVACNQQ7zKw==
X-Received: by 2002:adf:f2c5:: with SMTP id d5mr5807558wrp.96.1594735103363;
 Tue, 14 Jul 2020 06:58:23 -0700 (PDT)
Received: from localhost.localdomain
 (138.red-83-57-170.dynamicip.rima-tde.net. [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id k14sm29145343wrn.76.2020.07.14.06.58.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2020 06:58:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 5/9] hw/sd/sdcard: Restrict Class 6 commands to SCSD cards
Date: Tue, 14 Jul 2020 15:58:10 +0200
Message-Id: <20200714135814.19910-6-f4bug@amsat.org>
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
 qemu-stable@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Alexander Bulekov <alxndr@bu.edu>, Alistair Francis <alistair.francis@wdc.com>,
 Prasad J Pandit <ppandit@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Only SCSD cards support Class 6 (Block Oriented Write Protection)
commands.

  "SD Specifications Part 1 Physical Layer Simplified Spec. v3.01"

  4.3.14 Command Functional Difference in Card Capacity Types

  * Write Protected Group

  SDHC and SDXC do not support write-protected groups. Issuing
  CMD28, CMD29 and CMD30 generates the ILLEGAL_COMMAND error.

Cc: qemu-stable@nongnu.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <20200630133912.9428-7-f4bug@amsat.org>
---
 hw/sd/sd.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 5137168d66..1cc16bfd31 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -920,6 +920,11 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
         sd->multi_blk_cnt = 0;
     }
 
+    if (sd_cmd_class[req.cmd] == 6 && FIELD_EX32(sd->ocr, OCR, CARD_CAPACITY)) {
+        /* Only Standard Capacity cards support class 6 commands */
+        return sd_illegal;
+    }
+
     switch (req.cmd) {
     /* Basic commands (Class 0 and Class 1) */
     case 0:	/* CMD0:   GO_IDLE_STATE */
-- 
2.21.3


