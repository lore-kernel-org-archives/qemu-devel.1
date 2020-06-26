Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83532C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 16:37:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E65520781
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 16:37:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZQz6ojsc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E65520781
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56066 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jorLg-0002Hq-GW
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 12:37:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54174)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jorDN-0005Y9-5W; Fri, 26 Jun 2020 12:28:33 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:40563)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jorDL-0003LI-N7; Fri, 26 Jun 2020 12:28:32 -0400
Received: by mail-wr1-x442.google.com with SMTP id h5so10073198wrc.7;
 Fri, 26 Jun 2020 09:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=KpF9MIzXWHFH1j+WNA+tLcvpyt6lEogn0WVElNJnFTM=;
 b=ZQz6ojscR4GpPX9HEkimPLCyckwIyMKDMgjh21CemtY2xrLgtuJ/z8qRlNqxv0egq5
 tj9pGbSfwbLotvo+zvIfyw1+t0yv11cpXNh5AKMDQsnoRg9xi/Oyx6jHFeiTBwZo5K30
 r3Wlrjl8tvRm3OGhJLrYtJNd9DH1QjoCfsuCh1/pnvKWy+f41PjAj/due6AN61pNfEeK
 cO5igRpOql+tJlt5LUPi4uzXX0r3+1KggcJ8VEZeDf3+pBuTIzekaqdbvfRCtf/76U8o
 AttAx7oM8Xp04SHQJ8ONGb+dMdmvB2Z8fo70d9M6cgEcOyz960nf6a80jtkSYK7QQ1Wu
 XFKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=KpF9MIzXWHFH1j+WNA+tLcvpyt6lEogn0WVElNJnFTM=;
 b=bjzNMUoB0dnvnD1FcRL118/Dn7I94ExF0MuJzq24v6kDZ+G9IQyit8QeMBw/VCdfK0
 RLIfh3HX21P+QtByIGFyKmS/FiAzCRIuUXT4KpsTRx7s+RyjAknqmEfTHyqQYZb2zM9v
 Uye+z4ULSUak3AvovSvMrfZ2zA89ifC3odG75Ru9aLfL29ygI0LfrJIjxcUT+I3NdO6K
 1IEbOOAWsntUnbwq1w+/obPDepRKsmNqw6rUwf5nwox6WFFt4sUrWOhUAL6Dm4g0Q1pX
 rwL4WAEnCw2VtqECZ8s7TqpmdxtzKsBFMO5XHcvBEiKBhh9kUAjDEA7eoD7svVAhJZ2T
 DYzw==
X-Gm-Message-State: AOAM532uPnPyLIyq+a+zETpAEC4LZtXlW+Ep0hO44EfiaCZbMASsToMe
 QjYK0OcpGKg/LPzEhoigCKRV8qnq
X-Google-Smtp-Source: ABdhPJzr3vN4IIPed9yajvsrdON/AAcvvefPm6imYi4Lkpixm6+n1A/pt7IbOcoueBCcgwK+DjrLWg==
X-Received: by 2002:adf:ec88:: with SMTP id z8mr4557160wrn.395.1593188909631; 
 Fri, 26 Jun 2020 09:28:29 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id 12sm4867255wmg.6.2020.06.26.09.28.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2020 09:28:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 08/14] hw/sd/sdcard: Update the SDState documentation
Date: Fri, 26 Jun 2020 18:28:12 +0200
Message-Id: <20200626162818.25840-9-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200626162818.25840-1-f4bug@amsat.org>
References: <20200626162818.25840-1-f4bug@amsat.org>
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
index 0b606e9054..7d20f344bf 100644
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


