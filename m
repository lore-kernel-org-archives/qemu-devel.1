Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24866C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 13:45:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E885A20675
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 13:45:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aRM854uz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E885A20675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47000 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqGa1-0003DQ-5X
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 09:45:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35034)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqGTx-0001Hk-F1; Tue, 30 Jun 2020 09:39:30 -0400
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644]:39520)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqGTw-0006KN-1s; Tue, 30 Jun 2020 09:39:29 -0400
Received: by mail-ej1-x644.google.com with SMTP id w6so20656581ejq.6;
 Tue, 30 Jun 2020 06:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=XqwjlBbJ3fvA8pvvTo8a4BEWNTwUPbni3z+WTf5U/ws=;
 b=aRM854uztcoPNwlS6NAx0ri7TbvqffQaO97GKQrnriimWCRkcTe3NH40HaXWUtMeCG
 mXf+XEz5g6pWFvJ4A1O9KhJetp8QF43qXxZkAcp2SVu5G1IS8HFVGwYxJOXxY2ufPv7w
 JlGQ/HieZ+0TDoLidm0LfyC6yRdr4+Rp/6r3ldFtXqbGXDaHXonLc3C7rRdE7zOhwng5
 J/qPOKORSiyFsinrbxOOVVbcV+E2xGaUNOsTJ4cyErCGrROoCVRDjrBb7wobomKeRhix
 FFCdLpYNl/xgQ/9GXdkZsUaBEnZVYCsdgTgfAWA5stLkeeFtDpNfniATarWgKNftISvf
 Rkfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=XqwjlBbJ3fvA8pvvTo8a4BEWNTwUPbni3z+WTf5U/ws=;
 b=AkLq9g0pkQcwv6LKqXpH4LafoMJrKjS8KJiCGtt0Awko36awsnuorVqcVKIKGJkTS3
 TyMiFT9Umj/fm5kCaJnY1bCreKoTzFstlVeuPbNHqUJdQhYBkbSjxV+CjOBsj6l6jhW5
 myZ7LEiQ6gYcKEc3m+H99bnlF2K8as58oJtT7pev5qCBvohzA0xNhIl+WR2cTDyPPvCq
 Zcb0yeRKedoPZIfIfdAky5mEFGNdhgbPEn/9eL6eL38oo8Bm4xWhgamoSkyZA/oymmfh
 3Y4R/DKYU1z453b1v5pGG7yqV/li7nJfkLJ7jIaQp32pm1x5QKv77bm8ZH+SylZ8+O8f
 GwcQ==
X-Gm-Message-State: AOAM530fk7/3jYLZtzH9gbBtIm2khOgj6xXNp95MhGr1t0FUn+u6rRpm
 tQoRaz4eipgtHdEPMUU4Z1nPqO4/uK0=
X-Google-Smtp-Source: ABdhPJz/3CAAUu9olncDoAnQzS3yXRUTiL8abT5FHzPXHxbpIz1gsIC9UQ+qvTuzJN6Jiodg2TiC/A==
X-Received: by 2002:a17:907:9c6:: with SMTP id
 bx6mr18313287ejc.43.1593524366235; 
 Tue, 30 Jun 2020 06:39:26 -0700 (PDT)
Received: from x1w.redhat.com (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id p18sm2099172ejm.55.2020.06.30.06.39.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2020 06:39:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 11/17] hw/sd/sdcard: Update the SDState documentation
Date: Tue, 30 Jun 2020 15:39:05 +0200
Message-Id: <20200630133912.9428-12-f4bug@amsat.org>
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

Add more descriptive comments to keep a clear separation
between static property vs runtime changeable.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/sd.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 5d1b314a32..723e66bbf2 100644
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


