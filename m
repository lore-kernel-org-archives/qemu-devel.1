Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 151D8C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 16:43:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA472207FC
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 16:43:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="txwXMu4X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA472207FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jorRv-0005ND-3t
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 12:43:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57206)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jorP6-0000Ez-BH; Fri, 26 Jun 2020 12:40:41 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:41804)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jorP4-00064t-1M; Fri, 26 Jun 2020 12:40:39 -0400
Received: by mail-wr1-x443.google.com with SMTP id h15so10103321wrq.8;
 Fri, 26 Jun 2020 09:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2FehWZv489g7gLp1IpuJgAw0ELgG4HGTfqwfreEPxtg=;
 b=txwXMu4XvTfD1f8pUQtQk9yXebkKYepKvggw1Vy3cu4GclrXThTd6ud0foK3bRYntS
 6wtabgp+67wFTD0dMNy6CD6qkcRi8rCb+FC/ZBl4t207YvdHOCC5oiFpTQPVGh6+qnCm
 LlHOOw7WMqZaTBUpO9MBu5ykhC3jcIVt6SGzocvRnmbvRx4t7o/mGb/fsHyKG6XGMTnk
 YfG6SWbnMyRY6TO/I7uiXH9gK/mQbHFw51WeF2gxAzNrXz9cwFtSjiRpUjIhdAgnFzzs
 CNI8bTqvkvZ4WIcY2dx5HUALUdNBiBLq3V6OcYfMJwjt1wRNDc7dXi2fSl/pv89FIszO
 AxFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=2FehWZv489g7gLp1IpuJgAw0ELgG4HGTfqwfreEPxtg=;
 b=OBZE9fTWxbdYDNO0wQf6VLvLzDz5T3VbiT4qSLCiJ6x9W9hdy+MVqJUAkURu9t06Re
 lJpiUvaCoh2T0V6ifMrk4npOYqfhFdPIfl6RIXjpelYJHtbsiAn9TLHj6JMrlVN1+A93
 DhJE0bPMDffaiCikUmGrknEVUWNWtOGzfnmwtKUTF1CHxoIeFWz5pTSq3aBj6EyszQW2
 vrXYz13ai7g8WFBP3Lnp6Uz9qLbXS2uKlFfc6vdIz1vfN0sci+15K5x2twnRRUCysW0t
 bp4JCa9DGn7NwtYfNfAmgrJoid6814diF7xxnhaeDvLK+xvjqdNd09cKFmA6/1zbDoJ4
 BF4g==
X-Gm-Message-State: AOAM532wc0MCT2ORI/3tWjgIIZQwCzCUAwYwMxc2oHLFJvXj2Jzmbvke
 9GifoiVlROinnpU7+R645ydE4cjH
X-Google-Smtp-Source: ABdhPJxhoIM0XKrZpYY5JRU12pZfUtcDMDVd8w90AzShwY73VCFzDA9QhdQW9mNLc343257Rvb8IOw==
X-Received: by 2002:adf:de01:: with SMTP id b1mr4507277wrm.305.1593189636111; 
 Fri, 26 Jun 2020 09:40:36 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id f12sm24623646wrw.53.2020.06.26.09.40.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2020 09:40:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 06/15] hw/sd/sdcard: Restrict Class 6 commands to SCSD cards
Date: Fri, 26 Jun 2020 18:40:17 +0200
Message-Id: <20200626164026.766-7-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200626164026.766-1-f4bug@amsat.org>
References: <20200626164026.766-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
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


