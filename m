Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAE23C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 17:03:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0E282173E
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 17:03:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RPOuWlFv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0E282173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSkBp-0004F2-HX
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 13:03:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42748)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1kSkAN-0002p1-Qm; Wed, 14 Oct 2020 13:02:19 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:39837)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1kSkAM-0000o6-3g; Wed, 14 Oct 2020 13:02:19 -0400
Received: by mail-ed1-x542.google.com with SMTP id t21so200612eds.6;
 Wed, 14 Oct 2020 10:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=tA7JLmbIGrMajlGrZYwx7GZKaUy1dj+5f9/DC1Anv+U=;
 b=RPOuWlFvs0O9CT/MXSh+IPQtZeSBMjH7H2uZ1NmHoHDla2pm/LfYkKynw5b5KeetMy
 y8xAmZ0k95JicZTonxtnE3JgbtgpMAHM8cvPZOtFNKa0A1H53kp4+BCBjTz5AfB4qhSj
 MkuGQ74VXdTxDVzdB4jeXxUaw+6ar5GdEFOEO7T7aIJic8a0ELFcHAl6U7l1ZAnV4G5c
 3oJddOnwyMCo8YbXeFu5WuXztw/yaN1ecCtPRjIYiRlbSTW7IPacw2/Nl3AkYJCqCnmj
 Ew9IF7Q8bBL5os8RbZlN4dNP5njK2Bn3Oxbg67TmQl7rU1BQuctWQU4h32ZUATbLpTua
 /Yxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=tA7JLmbIGrMajlGrZYwx7GZKaUy1dj+5f9/DC1Anv+U=;
 b=Mn6+J8NcsSSiDbzxMTKx5x52jE0skD/84eJAzTZmmzYuxuSaLbhQupPkzBRSPk15K1
 YyfDLErTPqz3BSgNFVw7Udb8LChHzb8iERx8E8qzWf8/DPusf45j7pK4v6zCxpDqqF0n
 2hcM24UviJpzbAMTq9QrtddFFVCCyQPJpx02t0M3RBXRSPijjKPckyOOmV8EmoPBFC07
 SlLmJpGOi3YNCdvEp7cSL33px+7iaTME1C1eb+q2a2gRt7gTJnYvkQNzSaz/AajxOXAD
 xJfb7AzbHVlThRNDIp2tDVZAHWqb49T09G7FTtUIGmDQwXo6Gx0dCa6CxAPNq+f426b+
 QYlg==
X-Gm-Message-State: AOAM5327105EF08hY29VpF/Km8JhYqqzMRrPefjfXtsa8ubPnqC8keeY
 wpE19eO1NPVqX5dvxqYRIDI=
X-Google-Smtp-Source: ABdhPJwk9n524UEDD/4Qw/fVVfFqoT9SuRymQaDjAcyo4Dt0owTHKiHtTWclCHCO1k52mU9cg1tifg==
X-Received: by 2002:a05:6402:b0e:: with SMTP id
 bm14mr6223869edb.19.1602694936452; 
 Wed, 14 Oct 2020 10:02:16 -0700 (PDT)
Received: from neptune.lab ([46.39.229.194])
 by smtp.googlemail.com with ESMTPSA id g3sm76012edy.12.2020.10.14.10.02.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2020 10:02:15 -0700 (PDT)
From: Alexey Baturo <baturo.alexey@gmail.com>
X-Google-Original-From: Alexey Baturo <space.monkey.delivers@gmail.com>
To: 
Subject: [PATCH 3/5] [RISCV_PM] Print new PM CSRs in QEMU logs
Date: Wed, 14 Oct 2020 20:01:57 +0300
Message-Id: <20201014170159.26932-4-space.monkey.delivers@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201014170159.26932-1-space.monkey.delivers@gmail.com>
References: <20201014170159.26932-1-space.monkey.delivers@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::542;
 envelope-from=baturo.alexey@gmail.com; helo=mail-ed1-x542.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: baturo.alexey@gmail.com,
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 space.monkey.delivers@gmail.com, Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alexey Baturo <space.monkey.delivers@gmail.com>
---
 target/riscv/cpu.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index d63031eb08..8f8ee4d29c 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -255,6 +255,15 @@ static void riscv_cpu_dump_state(CPUState *cs, FILE *f, int flags)
         qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "htval ", env->htval);
         qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mtval2 ", env->mtval2);
     }
+    if (riscv_has_ext(env, RVH)) {
+        qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mmte    ", env->mmte);
+        qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "upmbase ", env->upmbase);
+        qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "spmbase ", env->spmbase);
+        qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mpmbase ", env->mpmbase);
+        qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "upmmask ", env->upmmask);
+        qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "spmmask ", env->spmmask);
+        qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mpmmask ", env->mpmmask);
+    }
 #endif
 
     for (i = 0; i < 32; i++) {
-- 
2.20.1


