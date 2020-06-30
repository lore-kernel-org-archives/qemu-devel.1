Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F1F3C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 10:18:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 680A12073E
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 10:18:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GIK5puHW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 680A12073E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqDLQ-0001Sf-KU
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 06:18:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58672)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqD7N-0002cx-Pa; Tue, 30 Jun 2020 06:03:57 -0400
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641]:40178)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqD7M-0004fO-5k; Tue, 30 Jun 2020 06:03:57 -0400
Received: by mail-ej1-x641.google.com with SMTP id o18so15461285eje.7;
 Tue, 30 Jun 2020 03:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=rpSMNc4ANWfLw4/zrjH+Quy+g4jLa++YxrzfC8zwAh8=;
 b=GIK5puHWMXKbQyRd3mJWceDXdlQzJMwQToYFhff5x8/05wI0MKDNwqfA50DIctuo6A
 rD+pm/CgxfUFHqbh7i2L2XOHGscBGIAgZYeOXWtCl9Mi1yKccFRPKiPuGSu8R9zPOz4L
 SxAtARY1fY/9KS1OunSAF+VW9/ar1aclji4Aj+9dwaW3DIjSMm6MDBGlDVF55nc5oVRk
 kNpqxo3juu56qSswh02b5GClhhE3Li51X6lsyU35MPYlQZFgurQkSdHsy8RIu4Q1tmVk
 6vHbD2CUea3QocZgqui0GUNrhoh2Wra/dmIMDKm5u14S6V/VbMoJh1yh4wARodEoAjmw
 VXHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=rpSMNc4ANWfLw4/zrjH+Quy+g4jLa++YxrzfC8zwAh8=;
 b=ospbKRsYZtTnn9LQo+7VHPbpgX12p4aBw7PXn0iP7FrAWZdDBpcEFXqQjHno+yMcBQ
 ZLUy5fjIN9TqTeen8uQ4P73ZHoOU4LfL2k0qCPeWA7ZeJV0EPWJ5W+3bveD1faUPZTbK
 Vj1daIcNajJgIL0+6I7+2c5rW5Wq6KFtu4fk5Z+Rkoq8ssZzxO5PffWx+SsKR4lXxKqx
 Om7+r5yBJy4cWwKrmSle89qOV2EWaU2teatQ1UgLThudK/rQxjZ5I5vG9VRjTKHqkGVC
 x3KT75QUElDv3084FZYHQ8yAJNsgyGXivS4qNrmjdg8fxMXb50BdyUt2Ay7u5zjtuYBk
 8e4w==
X-Gm-Message-State: AOAM531k6sktvgciJN77GI75WMHQijmd2o/s6/BaBbEuezBXKwj4yVfH
 cT8etQJXQsWpWosoR7QIdnZF8wK+D64=
X-Google-Smtp-Source: ABdhPJyubHHFBRyrFVYKIz3khfhcrZfhXn62qvN+OBjLe1JElmxyMapIEUTJln4LzeNkytOgtcA62g==
X-Received: by 2002:a17:906:2786:: with SMTP id
 j6mr17236358ejc.216.1593511434449; 
 Tue, 30 Jun 2020 03:03:54 -0700 (PDT)
Received: from x1w.redhat.com (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id h2sm2304697edk.54.2020.06.30.03.03.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2020 03:03:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 09/15] hw/sd/sdcard: Update the SDState documentation
Date: Tue, 30 Jun 2020 12:03:36 +0200
Message-Id: <20200630100342.27625-10-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200630100342.27625-1-f4bug@amsat.org>
References: <20200630100342.27625-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::641;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x641.google.com
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
index c6742c884d..ba4d0e0597 100644
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


