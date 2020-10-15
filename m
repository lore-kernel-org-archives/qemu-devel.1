Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B8A1C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 06:41:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D390F21D7F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 06:41:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nwxx2gtc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D390F21D7F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSwwu-00076S-OL
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 02:41:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55306)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kSwuX-0005QZ-Fb; Thu, 15 Oct 2020 02:38:51 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:38249)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kSwuU-0006wg-HG; Thu, 15 Oct 2020 02:38:49 -0400
Received: by mail-wm1-x343.google.com with SMTP id b127so2182757wmb.3;
 Wed, 14 Oct 2020 23:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9qL0PD5p90+XPqlO1VLzLa4jpbVXhICHWwCAyjStqAk=;
 b=nwxx2gtccqZNq65JhOP+DV95v3MTSRQH7uCYiEMRLIv4H0RBMvKBK7eX235IhEttva
 jXZAbs1FITK9Ei+N0bcPon7nDP3Po1a2tCoeLAX954fAuw5bkeCZedscbWJBCGSTgDM+
 4dnDsXjY5xE2NAyM9YnrZivU8ticMzqYx+LpRzXWV3d9UlJSD+iYiCrdu0y/H3fekpBZ
 GPfjP4IqeocIt/4MOwSJTyQMgqqsiLzxxxy3/tYsJQGRiK7LI2GugC95JNSeSnfd44+Y
 FvmImm8K1vWqNIhmnPfJbn1GXihiGQCE6g9zCMHfT4WJn4Dn3KW5urWwT/pmWaZKg5KI
 Hjbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=9qL0PD5p90+XPqlO1VLzLa4jpbVXhICHWwCAyjStqAk=;
 b=GRyQgV+wC5WSopsL2FXuPyS5aH2YLcelAKfI98WqY2rHd0G4D6EqjliK1VJ/tA0RAl
 otn8F4AQAYyCQUVQl3LddSHlHrApZZyUnUP4PZy5t5mCoscaWPhaE7UrwtWo5/f1hJXD
 AAKFyI4k9XL7xDBwS491mbzMTwPTGRzAOUCEuqp+8N3YN6sDO7URINf+/IqW+K+eCA9m
 SDrswz4bw/krMC1F5e/IgSGctoP3WerGepp3M3s5gPnlX3edJp9qDBSkXzc27ZrcYvdw
 6tXLKNGbhucr95xU8Hkr3JUJoqKLUooKbju+PBO8aDTZupK8vpElPcCqTSTSi7P2bsEH
 qgPw==
X-Gm-Message-State: AOAM532PtVXggAIuoBFBvH+rjYIeqS9vgwr93NzRcwK9YlIKhwjHtURr
 v759uyknP2G0DtIp/6QsV6APIGETLH4=
X-Google-Smtp-Source: ABdhPJzFvi2ccCa7gm3R1KRTXf6nmQLKa9nu4xy+tcczutaY4jkfY5ubfeTQFefkeOHCEW54uV2HtQ==
X-Received: by 2002:a05:600c:210f:: with SMTP id
 u15mr2444235wml.53.1602743924823; 
 Wed, 14 Oct 2020 23:38:44 -0700 (PDT)
Received: from localhost.localdomain
 (106.red-83-59-162.dynamicip.rima-tde.net. [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id c130sm4149925wma.1.2020.10.14.23.38.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2020 23:38:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 4/6] hw/sd/sdcard: Reset both start/end addresses on error
Date: Thu, 15 Oct 2020 08:38:22 +0200
Message-Id: <20201015063824.212980-5-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201015063824.212980-1-f4bug@amsat.org>
References: <20201015063824.212980-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
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
Cc: Alexander Bulekov <alxndr@bu.edu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From the Spec "4.3.5 Erase":

  The host should adhere to the following command
  sequence: ERASE_WR_BLK_START, ERASE_WR_BLK_END and
  ERASE (CMD38).

  If an erase (CMD38) or address setting (CMD32, 33)
  command is received out of sequence, the card shall
  set the ERASE_SEQ_ERROR bit in the status register
  and reset the whole sequence.

Reset both addresses if the ERASE command occured
out of sequence (one of the start/end address is
not set).

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/sd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 4c05152f189..ee7b64023aa 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -755,6 +755,8 @@ static void sd_erase(SDState *sd)
     if (sd->erase_start == INVALID_ADDRESS
             || sd->erase_end == INVALID_ADDRESS) {
         sd->card_status |= ERASE_SEQ_ERROR;
+        sd->erase_start = INVALID_ADDRESS;
+        sd->erase_end = INVALID_ADDRESS;
         return;
     }
 
-- 
2.26.2


