Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42262C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 16:45:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EAE020781
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 16:45:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UpsxxqL4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EAE020781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jorU0-0001OJ-6c
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 12:45:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57232)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jorP8-0000GY-WA; Fri, 26 Jun 2020 12:40:43 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:37756)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jorP7-00067m-Aj; Fri, 26 Jun 2020 12:40:42 -0400
Received: by mail-wm1-x343.google.com with SMTP id o2so9975894wmh.2;
 Fri, 26 Jun 2020 09:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=GvHez0pE6D3D72aVrb08Q8wyh4pB4x9TJg2DukSgMrU=;
 b=UpsxxqL4tceQIFxKNT74gHGiNesv+WvURhNEvFvLDfW75f/xa2YMvUH9y8WaruPn2T
 Tpm8ZW1z4AFQct2CSRt7aD8R3AV0OF+zg0JaBozeqmzLDAHWu3iOmpHdDZ7LENVxX+jP
 vw393zxdqCtOw1RfiW0LroBXwQIgPdnyyZ4EE2s0HTqC1/SMot6gEtG6WbAeHhOmculz
 C4jK31V7XKccf998xuECro5fo7Y4iN3I1mdcvPoZU9/KSjoewkANNehBG8RI8iBxI+N9
 QXP8mUdnNqu3rC3eoioymPHTdIU5lGurvku4WBxLiKRLzp6SY2izjs7OLEwFnwodHAc0
 kaOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=GvHez0pE6D3D72aVrb08Q8wyh4pB4x9TJg2DukSgMrU=;
 b=lU4P7imQT9745N/dc01tp2dKdnI+0zeTiUg3SyIIXgweXYw7i5fW1hf3mJTAxVV4Zk
 17rMZNXUZ5IA0YDgSe+E+/yuDxTkj/J+6PAFSP+RGntaP7eTTtSB2wSOdAu82AT3whZo
 qChwZa5Q/HyI6hOKN4xyboSdhpqVWW9ALmtbtY70w/872F1ARneQLx6DD4FM0Vrm6mAA
 eMiDh1iLTJ1Vae4N30jy4BYtorIjL731wYKMO4DAsjsI6fZf9S9237XBRkIYIKfrJI29
 yzPe3IgMo1ou/trK/7VeBiO6hpqEblVaEPkBaKHRmeTxJA+7L3NFbdCmGWjZez9R9RUT
 417A==
X-Gm-Message-State: AOAM533Gc6+bnnC1TEvMyQCHlrs+teEEWo4YPxa+rbM6DZnTezB6DQN9
 tF1L9UUtOFnzYbiZaloFbPfXNq7L
X-Google-Smtp-Source: ABdhPJxZMEZDsTRcqCKoBgc6AVGSJpjDhrOGbvXoTkJB4DDVpe5hl/060sUHSdmbycHagw32M5wzJA==
X-Received: by 2002:a7b:c38c:: with SMTP id s12mr4327392wmj.136.1593189639596; 
 Fri, 26 Jun 2020 09:40:39 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id f12sm24623646wrw.53.2020.06.26.09.40.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2020 09:40:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 09/15] hw/sd/sdcard: Update the SDState documentation
Date: Fri, 26 Jun 2020 18:40:20 +0200
Message-Id: <20200626164026.766-10-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200626164026.766-1-f4bug@amsat.org>
References: <20200626164026.766-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
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

Add more descriptive comments to keep a clear separation
between static property vs runtime changeable.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/sd.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 2689a27b49..d9ae4090fb 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -103,11 +103,14 @@ struct SDState {
     uint32_t card_status;
     uint8_t sd_status[64];
 
-    /* Configurable properties */
+    /* Static properties */
+
     uint8_t spec_version;
     BlockBackend *blk;
     bool spi;
 
+    /* Runtime changeables */
+
     uint32_t mode;    /* current card mode, one of SDCardModes */
     int32_t state;    /* current card state, one of SDCardStates */
     uint32_t vhs;
-- 
2.21.3


