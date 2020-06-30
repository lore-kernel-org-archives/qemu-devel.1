Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86DCEC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 13:46:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 518F320675
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 13:46:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e2oMdVdd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 518F320675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqGaO-0004An-Fu
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 09:46:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34962)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqGTs-00018S-JK; Tue, 30 Jun 2020 09:39:24 -0400
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644]:44699)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqGTq-0006Ir-Qp; Tue, 30 Jun 2020 09:39:24 -0400
Received: by mail-ej1-x644.google.com with SMTP id ga4so20606770ejb.11;
 Tue, 30 Jun 2020 06:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2FehWZv489g7gLp1IpuJgAw0ELgG4HGTfqwfreEPxtg=;
 b=e2oMdVdd4oZtoWmdovJN09AUNZ5aa63JRs0EZqZvzdKYoST29gR2cZmkeg7HbcQl7P
 jQnnQZcPQOhHyx/rs/fSETxPemyWqDIaXIuCvaRaM6Zu1mORngXLMtvefPcZuPNrVfUb
 UG8/ltcPATNi+lsyfvPgnuqZXwhJ4lG7A3s540ZxI6YTTdEyuZilTqFFW8QkOTllWQhe
 TIj+zI7h1PJe6JaVnyhkg29MS+F8jPLcE6dZgJpBA9TpvdBxgC39oKCOZ3hnwVHpzBxn
 5DS6qJVqbcYJlKxdEQxrBwku7jo2TGAbsi9+rxb1YwVNahyBQweQTLeg/yPuuhqJxTfb
 01Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=2FehWZv489g7gLp1IpuJgAw0ELgG4HGTfqwfreEPxtg=;
 b=eqB3ZJ3ANmQr2JjAheHObbZFHsB7AJBOb+udlo962ZvVquSAec4RJg4gvasePuqxGA
 lBL3w8i53fj5aXojpnD2YlOCDFnPbtcD6LZwMMZFXhTrF+pyPsM3KS4AdJBVxtUdlDzr
 QBc+WRNgjOXWQfPWM0MCZ1pzcvbhbE89e7K8vsBIPY/0ocslv1dqTsPT/x0VGopIasGF
 yeOiIodCuaFF2BIihQOsXmM2ue3aulcbopMum5/8Xv4G7RNJgcY+yZ73tMT+B1cX1RkA
 lXduW+wXK8g0GCpzfjBqrZ8UEN/AbkAWF+2wfCro4MNBy8VWdRD1GNfLT3y7+QDQxq31
 cuJg==
X-Gm-Message-State: AOAM531vgtoE2TRyY3MeNWAWwPtvwHp1f9nkfBcqgHFQfw8Zj6AzTtiu
 gSDYs6jYN/B6lfi7lJw6bbuBpBuj9Z0=
X-Google-Smtp-Source: ABdhPJyTLMsXk33SElVRiJRGymWi9rdj8GAsvlkMvu/YXvr3OzOXZhYAK194W9m+ofYHx6kVyA0t7Q==
X-Received: by 2002:a17:906:e25a:: with SMTP id
 gq26mr17827740ejb.152.1593524360648; 
 Tue, 30 Jun 2020 06:39:20 -0700 (PDT)
Received: from x1w.redhat.com (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id p18sm2099172ejm.55.2020.06.30.06.39.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2020 06:39:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 06/17] hw/sd/sdcard: Restrict Class 6 commands to SCSD cards
Date: Tue, 30 Jun 2020 15:39:00 +0200
Message-Id: <20200630133912.9428-7-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200630133912.9428-1-f4bug@amsat.org>
References: <20200630133912.9428-1-f4bug@amsat.org>
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-block@nongnu.org
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
---
 hw/sd/sd.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 7e0d684aca..871c30a67f 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -922,6 +922,11 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
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


