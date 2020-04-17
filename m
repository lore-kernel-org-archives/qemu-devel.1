Return-Path: <SRS0=Zx28=6B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51DF7C2D0EF
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 19:13:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1446220780
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 19:13:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SI5oIYz0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1446220780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPWQY-0005RH-8b
	for qemu-devel@archiver.kernel.org; Fri, 17 Apr 2020 15:13:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54219)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <edgar.iglesias@gmail.com>) id 1jPWNh-0002fJ-6L
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 15:10:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <edgar.iglesias@gmail.com>) id 1jPWNf-0005H6-3a
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 15:10:29 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:33073)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jPWNe-0005Ep-Rz
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 15:10:27 -0400
Received: by mail-lj1-x242.google.com with SMTP id q22so3200501ljg.0
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2020 12:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=j4+pLj7eQpP+1IFfO1O1TwFE+yPC5V1FdSQ5yPNNIxA=;
 b=SI5oIYz0rxAo0t32NBu+qd3LM6xE/sY4dTJJZBK2aCB01JY8UPCfxYQVWpesPHRxZ9
 GW8/z9uAzFtO0UjzwH+J3R8h2s3hoa1SJiAI4FlIQJuweRr7phWBdpI5+V1AidRpK4qw
 IdnR8NkhEkf2hCVDvFPkw5rIUz656xJPiWuH7q9nzTtlTuMgMk+LyK0dCzryI2TEylVd
 rz41QCfCFzwI2n08ZFva9nPn21oGHx8ZhJAvtTZKfYU8Oh7RFpVmUmfnB/Tl5IqAZVca
 BNIn/qI/1xCv30Mel9myKTzHwe6L0YqVoQVvh5QvX250d3bN2uN6oLeccpMT3SeixDsN
 CDbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=j4+pLj7eQpP+1IFfO1O1TwFE+yPC5V1FdSQ5yPNNIxA=;
 b=bY/PXhqg9viWZWE+5E8Uv2BON5yhvnEb+vGdSlnkOx1h+jzavxY+dExbKRuIDRg6O+
 3qzhZW0pQiE11iicbQ8HiJWsb7OEmYR1Sl15IGZVYEl/k4Ewd7FYXd98NWKKv4xr4Duk
 u04qSTce36MxHTM/C1rEDI9z8VGUuH4y5YCCLNUGe3HOzm6HYS96fqA/B7Hn0LsVeii/
 Q/tianxsgni0QEy5QP1+dsATv9MqzWf+x1GebKQXNttUKglGm3xI81vqoeLO9u82jjri
 vXk1gheqef3pyF78x7S6/u1lsPD8DYQ6JEhzlbM+PiwRNOu0eSxVhIbh0Jy7+hO06WfK
 +R7w==
X-Gm-Message-State: AGi0PubcoghPuy8YSdx8sxkHZMqj6KpfukschNlID2SSF97NpN+G74Ko
 VwlRTKj4eMAK1yh833mjyezn04LsAq8fzw==
X-Google-Smtp-Source: APiQypLNkc8db9WZydwpU+px78fjKec64UnfXLIp2fZanWQKzTNifgWfjNMZ66QSLvpKPxGob4353Q==
X-Received: by 2002:a2e:988f:: with SMTP id b15mr3116550ljj.232.1587150625127; 
 Fri, 17 Apr 2020 12:10:25 -0700 (PDT)
Received: from gmail.com (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id j22sm19235399lfg.96.2020.04.17.12.10.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2020 12:10:24 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 1/6] target/microblaze: Add the opcode-0x0-illegal CPU
 property
Date: Fri, 17 Apr 2020 21:10:17 +0200
Message-Id: <20200417191022.5247-2-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200417191022.5247-1-edgar.iglesias@gmail.com>
References: <20200417191022.5247-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::242
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
Cc: figlesia@xilinx.com, peter.maydell@linaro.org, sstabellini@kernel.org,
 edgar.iglesias@xilinx.com, sai.pavan.boddu@xilinx.com,
 frasse.iglesias@gmail.com, alistair@alistair23.me,
 richard.henderson@linaro.org, frederic.konrad@adacore.com, philmd@redhat.com,
 luc.michel@greensocs.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Add the opcode-0x0-illegal CPU property to control if the core
should trap opcode zero as illegal.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 target/microblaze/cpu.c       | 6 +++++-
 target/microblaze/cpu.h       | 1 +
 target/microblaze/translate.c | 2 +-
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index a2c2f271df..1044120702 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -206,7 +206,9 @@ static void mb_cpu_realizefn(DeviceState *dev, Error **errp)
                         (cpu->cfg.dopb_bus_exception ?
                                                  PVR2_DOPB_BUS_EXC_MASK : 0) |
                         (cpu->cfg.iopb_bus_exception ?
-                                                 PVR2_IOPB_BUS_EXC_MASK : 0);
+                                                 PVR2_IOPB_BUS_EXC_MASK : 0) |
+                        (cpu->cfg.opcode_0_illegal ?
+                                                 PVR2_OPCODE_0x0_ILL_MASK : 0);
 
     env->pvr.regs[5] |= cpu->cfg.dcache_writeback ?
                                         PVR5_DCACHE_WRITEBACK_MASK : 0;
@@ -274,6 +276,8 @@ static Property mb_properties[] = {
     /* Enables bus exceptions on failed instruction fetches.  */
     DEFINE_PROP_BOOL("iopb-bus-exception", MicroBlazeCPU,
                      cfg.iopb_bus_exception, false),
+    DEFINE_PROP_BOOL("opcode-0x0-illegal", MicroBlazeCPU,
+                     cfg.opcode_0_illegal, false),
     DEFINE_PROP_STRING("version", MicroBlazeCPU, cfg.version),
     DEFINE_PROP_UINT8("pvr", MicroBlazeCPU, cfg.pvr, C_PVR_FULL),
     DEFINE_PROP_END_OF_LIST(),
diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index 1a700a880c..d51587b342 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -303,6 +303,7 @@ struct MicroBlazeCPU {
         bool endi;
         bool dopb_bus_exception;
         bool iopb_bus_exception;
+        bool opcode_0_illegal;
         char *version;
         uint8_t pvr;
     } cfg;
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 37a844db99..222632b670 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -1573,7 +1573,7 @@ static inline void decode(DisasContext *dc, uint32_t ir)
     LOG_DIS("%8.8x\t", dc->ir);
 
     if (ir == 0) {
-        trap_illegal(dc, dc->cpu->env.pvr.regs[2] & PVR2_OPCODE_0x0_ILL_MASK);
+        trap_illegal(dc, dc->cpu->cfg.opcode_0_illegal);
         /* Don't decode nop/zero instructions any further.  */
         return;
     }
-- 
2.20.1


