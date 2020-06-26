Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AB1CC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 16:50:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 674B6206A1
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 16:50:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qUcy4cqt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 674B6206A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57004 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jorYl-00020B-KZ
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 12:50:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57268)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jorPC-0000KS-EF; Fri, 26 Jun 2020 12:40:46 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:56252)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jorPA-0006B6-SJ; Fri, 26 Jun 2020 12:40:46 -0400
Received: by mail-wm1-x344.google.com with SMTP id g75so9395491wme.5;
 Fri, 26 Jun 2020 09:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=SzJVtg/giHuTkd+J8k/OisBdWsb/IiYZi9QRfQu2hmE=;
 b=qUcy4cqtqne5kCrHujtYaDS0JqPF7akUIfY5NMEGhplfmgRPYn1EgH+t9eWyG36bUV
 +DYCjheTjcWXI2WqHifYE4oEwfcKcUc4PdUaXn/vFjgk/60D/GLMLVtgZlfBfnqdkd91
 mkPGnJsJnvBMCBljdWZPWPX3lJobtxxEvosC3O+fefJWzadFr8TSy7BxotV9D4doQwLl
 IxlFFR7+7VN05o+9sN1WDrzJr8vHeruRWFFX0fAAnmLWqv/UzT56p3IQ1YiZQeK5QdaN
 buHqt+hMqw1zYCYv5WO94rfnmxQelv/OGMg5ifqUdV5haAbEg76pnCv6M6FPd+lqn0vM
 ECYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=SzJVtg/giHuTkd+J8k/OisBdWsb/IiYZi9QRfQu2hmE=;
 b=SAHPv4Kos4jd0gXeJL9DVM+ovsS9ySvQA13K6Q+9CX56iPOL+YsN6TTRmsTz/cywLU
 eIHQt6N2cIm3XEDT+3TQkI4q5AR1PerN0OtLUchjna7jZoJoIE4TZNrCA/qFCjiudVzt
 Ob5u+GntR4gcc9KnrEoQ1vouEpl/4sS1UVYnPbpN9YvKsTJv+j2VzkU0GeLGAPQYIET1
 5mpacoTki/vjzqHfW03TiNVlsgm01Ebz79e87PzTEfdyR2PqZJ9bayOOmiHe8WBdSJjT
 ey0USBHiYMPA+j96cbqN7pjBO0Ox6scP8BNdz7F6IB08kWp5uKSnoHvCSr2dtn8Rp8sv
 IBuw==
X-Gm-Message-State: AOAM532UQgoPhrG/VwiVkjglI4Qy8PLFQhbXI7wfRGmejLrKBd3Ocqzd
 BAg0hphDGllpeWn0EvSV92XFKyOA
X-Google-Smtp-Source: ABdhPJxNg58hLNwddX/dLsUrGVg5NJS0FI+TBoJZjE+u+tHe1wZN19TTn1cHt0ecEMSN2XiEuqAm+g==
X-Received: by 2002:a1c:b182:: with SMTP id a124mr4120204wmf.114.1593189642944; 
 Fri, 26 Jun 2020 09:40:42 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id f12sm24623646wrw.53.2020.06.26.09.40.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2020 09:40:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 12/15] hw/sd/sdcard: Make iolen unsigned
Date: Fri, 26 Jun 2020 18:40:23 +0200
Message-Id: <20200626164026.766-13-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200626164026.766-1-f4bug@amsat.org>
References: <20200626164026.766-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
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
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

I/O request length can not be negative.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
v4: Use uint32_t (pm215)
---
 hw/sd/sd.c         | 2 +-
 hw/sd/trace-events | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 486538afc2..dc005e4d91 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1967,7 +1967,7 @@ uint8_t sd_read_data(SDState *sd)
 {
     /* TODO: Append CRCs */
     uint8_t ret;
-    int io_len;
+    uint32_t io_len;
 
     if (!sd->blk || !blk_is_inserted(sd->blk) || !sd->enable)
         return 0x00;
diff --git a/hw/sd/trace-events b/hw/sd/trace-events
index 5f09d32eb2..d0cd7c6ec4 100644
--- a/hw/sd/trace-events
+++ b/hw/sd/trace-events
@@ -52,7 +52,7 @@ sdcard_unlock(void) ""
 sdcard_read_block(uint64_t addr, uint32_t len) "addr 0x%" PRIx64 " size 0x%x"
 sdcard_write_block(uint64_t addr, uint32_t len) "addr 0x%" PRIx64 " size 0x%x"
 sdcard_write_data(const char *proto, const char *cmd_desc, uint8_t cmd, uint8_t value) "%s %20s/ CMD%02d value 0x%02x"
-sdcard_read_data(const char *proto, const char *cmd_desc, uint8_t cmd, int length) "%s %20s/ CMD%02d len %d"
+sdcard_read_data(const char *proto, const char *cmd_desc, uint8_t cmd, uint32_t length) "%s %20s/ CMD%02d len %" PRIu32
 sdcard_set_voltage(uint16_t millivolts) "%u mV"
 
 # milkymist-memcard.c
-- 
2.21.3


