Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60E03C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 14:24:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21FEB2065D
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 14:24:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iP3oBFQj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21FEB2065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZEmK-00065S-7u
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 10:24:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38522)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jZEd0-0007mL-4G
 for qemu-devel@nongnu.org; Thu, 14 May 2020 10:14:27 -0400
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:43233)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jZEcz-0003oi-DJ
 for qemu-devel@nongnu.org; Thu, 14 May 2020 10:14:25 -0400
Received: by mail-lj1-x244.google.com with SMTP id l19so3664604lje.10
 for <qemu-devel@nongnu.org>; Thu, 14 May 2020 07:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=hHXzvT0ne/aeVCxE+iMY7gU5VPnnGQChVHUMUTuz5KQ=;
 b=iP3oBFQjQcoENgO8zf2xhHRlly1V2mMzMQM9Qq58k8I0L5lCK01QgJwtxvB5R0DCXH
 aijXJv70S44d9uw7trn2bdDYWOvSjKlfomBDi7Yj/pU0jGtKzZ7GKaMriqWUoTIRLA0x
 tuZ7OjNbNlgkcKWDbhmcettoCUfRjaogmBAPyZ9sgy2M35WIa95mmUecDM4wU70pYOeJ
 ihXpVyS0a+xjcUn30NPtdRhF+C1DUhUFGnH1itPJVZ8X8MtH6L472TvTf21zsh0rDrdP
 O8hTS48BrBpYnHQpryppFQxKZpTOa+p4cyLqmAZdzaIWvMxlXTCFASQZUXsg0ZSezi7f
 hqvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=hHXzvT0ne/aeVCxE+iMY7gU5VPnnGQChVHUMUTuz5KQ=;
 b=aZuqZ1Klm+MmsxhOLPhsXbxFmFf2NKK0BoqfQsq0deC6Ad3cYWvgp0GHZcSzXhV1hH
 jhdHFcqwomJ5n9/UvskUzlGSz90ju4Yenb/ZLDAzGyzgn+O/D122plpaZEO7Zbq3TtAp
 jKDnZVZp2s0Nd7mGzdrRtKuYjcDB3h5rXhNxSk38RKPA6HWCGGSlc1w9EP7+ljCIdmQK
 hpvkyMDm9brht2ka6YHk1yuzibv35BBxty3ore/MpOkO45/eKCs1UIPGW+sHbCESX4u2
 CEH4Mn+DqbDCFYzNAkGczg5D81CUnfeflDs21utCQ9P09lkqCKPrTPsdc4MJK8ZSz8Mp
 RioA==
X-Gm-Message-State: AOAM530My/Q07SE024+4uwrO+D95wfjLtXz9UFdCiPHzkfRDsiI17biR
 CdlTvpvPGz1RCGHVdUxtnYcDXujnc2A=
X-Google-Smtp-Source: ABdhPJxFcWsTA2HP5+hC1Ms7pxBKavniROcQpahL3GUuMYzzFk4y5zcVelcSX3IBi3ilx72boJs1GQ==
X-Received: by 2002:a2e:7508:: with SMTP id q8mr3045648ljc.234.1589465663341; 
 Thu, 14 May 2020 07:14:23 -0700 (PDT)
Received: from gmail.com (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id m15sm1561799lji.21.2020.05.14.07.14.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2020 07:14:22 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PULL v1 14/14] target/microblaze: monitor: Increase the number of
 registers reported
Date: Thu, 14 May 2020 16:14:02 +0200
Message-Id: <20200514141402.12498-15-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200514141402.12498-1-edgar.iglesias@gmail.com>
References: <20200514141402.12498-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::244;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x244.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 13
X-Spam_score: 1.3
X-Spam_bar: +
X-Spam_report: (1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FSL_HELO_FAKE=3.399, RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: edgar.iglesias@xilinx.com, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Joe Komlodi <joe.komlodi@xilinx.com>

Increase the number of registers reported to match GDB.

Registers that aren't modeled are reported as 0.

Signed-off-by: Joe Komlodi <komlodi@xilinx.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Message-Id: <1589393329-223076-4-git-send-email-komlodi@xilinx.com>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 target/microblaze/translate.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 8079724f32..f6ff2591c3 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -1789,9 +1789,11 @@ void mb_cpu_dump_state(CPUState *cs, FILE *f, int flags)
     qemu_fprintf(f, "IN: PC=%" PRIx64 " %s\n",
                  env->sregs[SR_PC], lookup_symbol(env->sregs[SR_PC]));
     qemu_fprintf(f, "rmsr=%" PRIx64 " resr=%" PRIx64 " rear=%" PRIx64 " "
-                 "debug=%x imm=%x iflags=%x fsr=%" PRIx64 "\n",
+                 "debug=%x imm=%x iflags=%x fsr=%" PRIx64 " "
+                 "rbtr=%" PRIx64 "\n",
                  env->sregs[SR_MSR], env->sregs[SR_ESR], env->sregs[SR_EAR],
-                 env->debug, env->imm, env->iflags, env->sregs[SR_FSR]);
+                 env->debug, env->imm, env->iflags, env->sregs[SR_FSR],
+                 env->sregs[SR_BTR]);
     qemu_fprintf(f, "btaken=%d btarget=%" PRIx64 " mode=%s(saved=%s) "
                  "eip=%d ie=%d\n",
                  env->btaken, env->btarget,
@@ -1799,7 +1801,17 @@ void mb_cpu_dump_state(CPUState *cs, FILE *f, int flags)
                  (env->sregs[SR_MSR] & MSR_UMS) ? "user" : "kernel",
                  (bool)(env->sregs[SR_MSR] & MSR_EIP),
                  (bool)(env->sregs[SR_MSR] & MSR_IE));
+    for (i = 0; i < 12; i++) {
+        qemu_fprintf(f, "rpvr%2.2d=%8.8x ", i, env->pvr.regs[i]);
+        if ((i + 1) % 4 == 0) {
+            qemu_fprintf(f, "\n");
+        }
+    }
 
+    /* Registers that aren't modeled are reported as 0 */
+    qemu_fprintf(f, "redr=%" PRIx64 " rpid=0 rzpr=0 rtlbx=0 rtlbsx=0 "
+                    "rtlblo=0 rtlbhi=0\n", env->sregs[SR_EDR]);
+    qemu_fprintf(f, "slr=%x shr=%x\n", env->slr, env->shr);
     for (i = 0; i < 32; i++) {
         qemu_fprintf(f, "r%2.2d=%8.8x ", i, env->regs[i]);
         if ((i + 1) % 4 == 0)
-- 
2.20.1


