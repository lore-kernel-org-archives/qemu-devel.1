Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7B11C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 10:19:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F66F20760
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 10:19:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GG84reCw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F66F20760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37446 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqDMk-0003Q2-O7
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 06:19:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58732)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqD7R-0002kH-CW; Tue, 30 Jun 2020 06:04:02 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d]:46802)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqD7P-0004hB-Ji; Tue, 30 Jun 2020 06:04:01 -0400
Received: by mail-ej1-x62d.google.com with SMTP id p20so19862916ejd.13;
 Tue, 30 Jun 2020 03:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=zGHpga6H2Rh60b+shqZXMAR/68CCrter5/aFoJNoNjw=;
 b=GG84reCwLGmxirJzTSDZ1TKY//DM9x7P0UHiGXRCZc5yE7j5u0qqXLdru62rlGqm6x
 HXPWnek0NfZmiXu4OwwOJWit0/NACsqMSBaKiplcy4+pI58GKMid5CZ+VHWMNlwdYClc
 gkYPgDMCXZWuBy9tHxhVzTs17TjVcDxzE2jMNEMzIOBp0phSX8Ayvq6+ID176zcY+eIF
 Kc92Gf+eqm8XWF4/xEZZfIUzLx/P+piu0Hv1OVrCrhY3FpREj8/IDXykRbT6qKFX2TzF
 x37xSKRAEM6EyjKTGcdC+9UVXVuvnQIVHW9mjcPTI5BrQHRAHAih8sjxOVvhL3RbOGNe
 2m4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=zGHpga6H2Rh60b+shqZXMAR/68CCrter5/aFoJNoNjw=;
 b=bAg9eK2diTJSReP0DcAUjkEVUVxES96JzBP+LdK2CFVIMF88M+Zak4l1SRO132P7jj
 iK/hESwkfCHkLKrEN8yaJyiJhRn9P0nRDUK3Vf9EMHyGf7EpVDfybvW/mUvpQ0roWefo
 qWEQBgI4ZUh90bK/H7eB4zbtV7au633K41meOM7qnNPmMlru/es5LGcTLY08FqT82Br+
 tlAEsAnGYHc6Iw8yy5ULLU2z1V6ksExiELQCoxF4yb2bjS4epeg9zbHjlknoGnAx0J9N
 XMxlpJtsZw8PBxts2d3ySSwd2c9n9iIHYM+NSLiAepCiNQf4cXvidupg/KKztfC6XXvX
 kxqg==
X-Gm-Message-State: AOAM533LASxCfDu67X09CgqmraCHq7mWaW8MRJRyRh+xHY6kYdJfVcA3
 3N5yy8qYn7icZhr3DKLfN71Mgs17+28=
X-Google-Smtp-Source: ABdhPJy7f71t6+HMDAMJQupy69MxORznFBGbe62ASB8xFozccU9HcUc5dIrRLS3l+iKH/KjE1J1AtA==
X-Received: by 2002:a17:907:4240:: with SMTP id
 oi24mr17051034ejb.23.1593511437547; 
 Tue, 30 Jun 2020 03:03:57 -0700 (PDT)
Received: from x1w.redhat.com (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id h2sm2304697edk.54.2020.06.30.03.03.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2020 03:03:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 12/15] hw/sd/sdcard: Make iolen unsigned
Date: Tue, 30 Jun 2020 12:03:39 +0200
Message-Id: <20200630100342.27625-13-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200630100342.27625-1-f4bug@amsat.org>
References: <20200630100342.27625-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x62d.google.com
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
index 2238ba066d..504228198e 100644
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


