Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15D97C433E3
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 18:35:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4590206F0
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 18:35:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xejc1Pr7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4590206F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56612 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jv3IV-0007eu-W6
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 14:35:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40316)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jv3FW-00027p-Mj; Mon, 13 Jul 2020 14:32:22 -0400
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644]:40261)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jv3FU-0004HB-Fe; Mon, 13 Jul 2020 14:32:22 -0400
Received: by mail-ej1-x644.google.com with SMTP id o18so18423687eje.7;
 Mon, 13 Jul 2020 11:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=SN1q0PMCO1/b3G/yTwrOsu/XAVNUpaToYvO1YyH52/o=;
 b=Xejc1Pr7KYGOXiEWoif+Zso7A5D77D4/ExAVGk/jqOVZLeV2GpdLynJZm6yiObHN3f
 pqRCwJuZhrXleP2cIV6GxR9y1zYWYD9zoafaZd6/ejWLZZm+XbuN3KuP/UOnqWvPIyHL
 aAcdjKDM2rZQmdhzSxEZ+J63K/+giTaPZc+V8NY3Vb3X4+MgIq1Lvh3vl48xBfgcC1EG
 7jWICq8f61zeQ9BW0nm27rb1eELx2ZGIox3SwoHLINtO/naiLIU1bdRlFWzcandkxjCy
 FJOAkEWV57KUdg3YUW4XWeHgLBKG3J6/5raPhQq9tR62xmCy+AeCua0wumZLMho/Jq6+
 fI9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=SN1q0PMCO1/b3G/yTwrOsu/XAVNUpaToYvO1YyH52/o=;
 b=Mc02/CZcHyDbxGYQESA+KT0m8kA+jBkh7bWQ9cv2hfc9EQ+7Tb94qVZ6X9ZrdcdgZE
 EQG3dQ73JXXCnVYckT1VQ7wzzR51qigW2+Im5bb8CGhZ8p8XoIKhNfbRRGfyhZ0/whUe
 GfzWwiFTdxNJshHS3WFIulDrUPPDkqIxn53E6QoD/9BOtL+QGmN7kuyKHbdFWnPyi2lp
 T47XYd2jqXFrm50Q81xOo9JhPMiSI97Pwnl/rufOQm6gLwWwCY8x7KwjC2wQY+z5ix2h
 7WkAD/BludPy/nvWiZ6nryZVKQIjNPdEl6/15MBJNWb82emfiyOwzCUO7SGYBwPAE+WA
 lRqw==
X-Gm-Message-State: AOAM533PWeR0CEhuFMqoPyAgZMppzuIBBSotyskLKTVPw36+EVlgzTxt
 tNFWQiVaSLbUg68MI0EqR4b8ZC2qWK8=
X-Google-Smtp-Source: ABdhPJxE6OxkdisEP4bvRpUfZ85Uto0+Rvw9utbKVHtqJtVJCKMPmwjBbgusrC3TFD2InzFEpAy5zA==
X-Received: by 2002:a17:906:191a:: with SMTP id
 a26mr1006282eje.315.1594665138603; 
 Mon, 13 Jul 2020 11:32:18 -0700 (PDT)
Received: from x1w.redhat.com (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id ce12sm4353148edb.4.2020.07.13.11.32.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2020 11:32:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 5/9] hw/sd/sdcard: Restrict Class 6 commands to SCSD cards
Date: Mon, 13 Jul 2020 20:32:05 +0200
Message-Id: <20200713183209.26308-6-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200713183209.26308-1-f4bug@amsat.org>
References: <20200713183209.26308-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::644;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x644.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Prasad J Pandit <pjp@fedoraproject.org>, qemu-block@nongnu.org,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>, Niek Linnenbank <nieklinnenbank@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>, Cleber Rosa <crosa@redhat.com>,
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


