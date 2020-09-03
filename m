Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE6AAC43461
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:26:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F2E7206D4
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:26:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lXC9ZYGU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F2E7206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54318 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDwkv-0004qh-KX
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 17:26:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59154)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kDwLl-0004cC-SU; Thu, 03 Sep 2020 17:00:54 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:44057)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kDwLj-0007mx-Qo; Thu, 03 Sep 2020 17:00:53 -0400
Received: by mail-ot1-x344.google.com with SMTP id a2so3982573otr.11;
 Thu, 03 Sep 2020 14:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=jToX5f8+EsTioWIIknUwq5OunQEZrWHXCk2GLVSldj8=;
 b=lXC9ZYGUoZ4KJA2vN/7SvDU0yg5UUTgbCJd1R7y3Cp7ezrlzbg8V9M/PIXkdZPNKM4
 yiCRIKI4cHACzyLPcdD8sXAWlEYhrBjPmZyHovdaIrSbbFyoKr59+tE5c43YK613g0Ax
 GpLdGCkFOlTj+SMvUY3OpBlEcbYRBW3O42uHzsp3EYtcg+CwG6osmhFewlySjnp1YAFk
 sFDbYQ6h16h6aRckxk7LvR4c9IV6F2RUXns9yqEAM5Qz82U3AwCQRPN/eSfvw6JZ26x0
 VmTYrruMSBzvIID/mD9HcTXknwrMbWa23YM2FTQWMu3cMGzzLJV5Hmj0xqQEcEIrT0YV
 C8RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=jToX5f8+EsTioWIIknUwq5OunQEZrWHXCk2GLVSldj8=;
 b=JtBEmGMTK+HQ06WazCt4h5VLPjc9xpbnZZFhWOX5rEhdy9mvjirtE5gKZfw1kHaibo
 7qCkqEM3gOqVUEylHI40oOQZ/swsV2Kzkg+YlTJE926fVVfwkjC/c1e8Wns/SRvdkQeZ
 m+SLW4jOgpLIOL/ILaSJARMHBn25xI7GvW57OIrRFQSc/VyRAiRjb0a6aGuefo+Zi7rS
 kHSNhYJ2zQeUIkMQEg8n37b/99OUKg3EWldRMuvDdOKDDCHYa5XsgjhY/DUHbRP/B3Hq
 esyMdcHupOgWV7URQ8FrMpOgRXRf2SEd9ztewqU0V6U2kzzxe3onD7g1ypgkheTK3YIh
 gZKA==
X-Gm-Message-State: AOAM530PLymmY8W2zntctqRiySDewRuiamBAlbEZ6fMaG4VbdI9mvxlr
 DaQpRgLuT6wtXslujofRY1Nn0Vlniqs=
X-Google-Smtp-Source: ABdhPJxyDxvVBQ8RnzNkokerKNl28JlrqJh77pW/7JQNFNrfBP0/iNHT4+PyEthWYnnEVPxmWZ/pFg==
X-Received: by 2002:a05:6830:48:: with SMTP id
 d8mr2968196otp.272.1599166850192; 
 Thu, 03 Sep 2020 14:00:50 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id m8sm767319otn.66.2020.09.03.14.00.49
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 03 Sep 2020 14:00:49 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 51/77] hw/sd/sdcard: Restrict Class 6 commands to SCSD cards
Date: Thu,  3 Sep 2020 15:59:09 -0500
Message-Id: <20200903205935.27832-52-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200903205935.27832-1-mdroth@linux.vnet.ibm.com>
References: <20200903205935.27832-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::344;
 envelope-from=flukshun@gmail.com; helo=mail-ot1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

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
(cherry picked from commit 9157dd597d293ab7f599f4d96c3fe8a6e07c633d)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/sd/sd.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 3c06a0ac6d..da39590f58 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -905,6 +905,11 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
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
2.17.1


