Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D39E7C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 11:49:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F94920738
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 11:49:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T0ypwWmR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F94920738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnhQy-0003qs-Rc
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 07:49:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44320)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jnhHD-0003Mc-04
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 07:39:43 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:46058)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jnhHB-0003MN-6T
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 07:39:42 -0400
Received: by mail-wr1-x430.google.com with SMTP id s10so210599wrw.12
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 04:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=mmdsLUjFh7ohZWxR1J/P4GhrVs/dAJ8di+ouWpFUciU=;
 b=T0ypwWmRk24gC3ZDBC25X0HhIN5Jxx9PX0sO+rezghTlT6JuI8E0W77x4iHYuTyN4w
 sMfugxxeigTtUmpjvzbQYA3BBh4zVAJzawwMXOIxv7MZAEJGhD/Xn4bSRR1UgRx6VSKy
 s6+YjePxDLWQbMTRlw3p0uZdfKb/itjVvex7vSpozNgId1OPU8v4oMBLBNNYsoE4spLc
 Mb7cdwm8ev37N4+Ele5r2JbJhSeomGo/YhfZxNhE7Denvk5tj9eOLdbR7sS+ePlv2aAx
 zH+B/X6cwyL1s/JpZ4pXbcr757XdeCcVcYLpLXOm7p4gDXo6tknh9CyQzqudVzUIu6UL
 cFuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=mmdsLUjFh7ohZWxR1J/P4GhrVs/dAJ8di+ouWpFUciU=;
 b=X1jmn6pbaKbpg/pvxD66+a9mBpqBTQG91qSH8IrKQ+sdxOsg2gESH+utHtCTMSDIUr
 ClqUbFij97ukT19fcrMc2DIt3ExxijvUod86Bs6/hjHIt3nJAN+iaHa247gMgp5jwbcr
 Zw3se906O3cX78sBkNqR8GU3tIA8pbQpOhphfzUR3b5nZWRt7HvWBpGfk5kPgT0Zr9vd
 QgJ5bEXIJojbXKu3ACnPYyF0tZQtt5xK2GmawRutNbe6mEJa2RPjDh5+FepVEhI4PE3u
 HdrepOxH3D8/xIS7oalbvGRv1Wh/DeqXXYCdHG/S+Ihc8qMWAvSyP5biSUtoXFZyp8/1
 FzWg==
X-Gm-Message-State: AOAM533HZYkzvrm4udBDXfGaMNLpu6ox7Ks+E/AYMpaP7i+wXFWcc8GF
 DqehUarDH2TaSkQ2s9ZX2e+F7mEyffnHow==
X-Google-Smtp-Source: ABdhPJxxI1Y4SbbD6SenTw8tMgCZZFRAX0qLUOQ6qpWuwZ70CKDPVW0xCljwh0/aLWV9KNlT6LPcBA==
X-Received: by 2002:adf:db4d:: with SMTP id f13mr20905928wrj.336.1592912379587; 
 Tue, 23 Jun 2020 04:39:39 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id m10sm4022177wru.4.2020.06.23.04.39.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2020 04:39:38 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 28/42] hw/i2c/versatile_i2c: Add SCL/SDA definitions
Date: Tue, 23 Jun 2020 12:38:50 +0100
Message-Id: <20200623113904.28805-29-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200623113904.28805-1-peter.maydell@linaro.org>
References: <20200623113904.28805-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x430.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Use self-explicit definitions instead of magic values.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 20200617072539.32686-4-f4bug@amsat.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/i2c/versatile_i2c.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/hw/i2c/versatile_i2c.c b/hw/i2c/versatile_i2c.c
index 040139d701b..0ce10a1bcc0 100644
--- a/hw/i2c/versatile_i2c.c
+++ b/hw/i2c/versatile_i2c.c
@@ -45,6 +45,9 @@ REG32(CONTROL_GET, 0)
 REG32(CONTROL_SET, 0)
 REG32(CONTROL_CLR, 4)
 
+#define SCL BIT(0)
+#define SDA BIT(1)
+
 static uint64_t versatile_i2c_read(void *opaque, hwaddr offset,
                                    unsigned size)
 {
@@ -76,8 +79,8 @@ static void versatile_i2c_write(void *opaque, hwaddr offset,
         qemu_log_mask(LOG_GUEST_ERROR,
                       "%s: Bad offset 0x%x\n", __func__, (int)offset);
     }
-    bitbang_i2c_set(&s->bitbang, BITBANG_I2C_SCL, (s->out & 1) != 0);
-    s->in = bitbang_i2c_set(&s->bitbang, BITBANG_I2C_SDA, (s->out & 2) != 0);
+    bitbang_i2c_set(&s->bitbang, BITBANG_I2C_SCL, (s->out & SCL) != 0);
+    s->in = bitbang_i2c_set(&s->bitbang, BITBANG_I2C_SDA, (s->out & SDA) != 0);
 }
 
 static const MemoryRegionOps versatile_i2c_ops = {
-- 
2.20.1


