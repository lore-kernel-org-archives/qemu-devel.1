Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E494C433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 13:31:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D33BA23330
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 13:31:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vYlSNAj2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D33BA23330
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58776 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSKOR-00038i-Rf
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 09:31:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42892)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kSKJQ-0007K8-Rs
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 09:25:56 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:46898)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kSKJP-0000sx-11
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 09:25:56 -0400
Received: by mail-wr1-x444.google.com with SMTP id n6so23739254wrm.13
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2020 06:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=VFsuaswYufcuBvnCYcvUI12J1pzpFOAbqFSm76G5//c=;
 b=vYlSNAj2cgafv5YgMrJOUKpaa7oi/7ODTedvm0rol+gY+9uKZkGsQpHihuzT5jTJBd
 2GR3+os57JfJ0MEA5iCmg+OkEzvzevOBSgeaQtVVY9kjBawTDQjoRNCGeAe78hR9b6j4
 PgR3ejDyw3fCcsfasujQ46hdogd7S+llNkeFf7ANYIZcKr+932Kid1BvlcHnpX7H3QyY
 YHduVGmBva/RJrtco1iRNQwvWzebRyxb756MocWILxtkgcS8599kMl3t7OTgV/58B+f1
 +/zMheRMdPnyvm2iyOoGamDsXoSsgYyowhhx1pzqcFcAulbUsd9D6XnI4BA0WxBVbU9I
 eW0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=VFsuaswYufcuBvnCYcvUI12J1pzpFOAbqFSm76G5//c=;
 b=ge2Tn5AKBF5HfWQChsLyPLojoia7tjDYi4htMa4EJqu/NBoI40732HBhOiqoGMvBMe
 6irxbptAruyN1zKOw/WGuQsmt6Mn+BdXutwsM9HfRhJsHAr4QVp2hZ1evtbC4slnvAz2
 57PwcHF2LkU0KgQywAQtHkbKIhZVzMQtwIRuzdehxrUtuIg475vG89Xw9kjvfxciOicI
 nCr47uF4v5iB8iUelt2X11C/gMfpuBwkXY+y/e58RRHAbk7clU6ZCAKiiNMqb8byX7//
 U4Gd5ngr7UzKNuSanyhBAKRLIehUojoRlDqLjkDmcjD9V+rhmsbd6LQ6wBDraLRb7IuD
 Md2w==
X-Gm-Message-State: AOAM533EIWDQ83rZWh7RgxiAUcBiSg7DbXPDi9OVLj+o/hpnLG3/UJpb
 UXG52/7OR2UTh1IZTvZrhZJ1PL8G4zg=
X-Google-Smtp-Source: ABdhPJyaVQQqPRpyS7u1ykMOTf3wNuxAN72+BqzQrqNQ2H7QclLQT8ZiDXLRjwMcOVj15FyYWswksQ==
X-Received: by 2002:adf:eb41:: with SMTP id u1mr27684150wrn.94.1602595552209; 
 Tue, 13 Oct 2020 06:25:52 -0700 (PDT)
Received: from x1w.redhat.com (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id p4sm28990248wru.39.2020.10.13.06.25.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2020 06:25:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org,
	Victor Kamensky <kamensky@cisco.com>
Subject: [RFC PATCH 3/3] target/mips: Make the number of TLB entries a CPU
 property
Date: Tue, 13 Oct 2020 15:25:35 +0200
Message-Id: <20201013132535.3599453-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201013132535.3599453-1-f4bug@amsat.org>
References: <20201013132535.3599453-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Khem Raj <raj.khem@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Richard Purdie <richard.purdie@linuxfoundation.org>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Allow changing the number of TLB entries for
testing/tunning purpose.

Example to force a 34Kf cpu with 64 TLB:

  $ qemu-system-mipsel -cpu 34Kf,tlb-entries=64 ...

This is helpful for developers of the Yocto Project [*]:

  Yocto Project uses qemu-system-mips 34Kf cpu model, to run 32bit
  MIPS CI loop. It was observed that in this case CI test execution
  time was almost twice longer than 64bit MIPS variant that runs
  under MIPS64R2-generic model. It was investigated and concluded
  that the difference in number of TLBs 16 in 34Kf case vs 64 in
  MIPS64R2-generic is responsible for most of CI real time execution
  difference. Because with 16 TLBs linux user-land trashes TLB more
  and it needs to execute more instructions in TLB refill handler
  calls, as result it runs much longer.

[*] https://lists.gnu.org/archive/html/qemu-devel/2020-10/msg03428.html

Buglink: https://bugzilla.yoctoproject.org/show_bug.cgi?id=13992
Reported-by: Victor Kamensky <kamensky@cisco.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 target/mips/cpu.c       |  8 +++++++-
 target/mips/translate.c | 10 +++++++++-
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index 117c748345e..da31831368b 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -26,7 +26,7 @@
 #include "qemu/module.h"
 #include "sysemu/kvm.h"
 #include "exec/exec-all.h"
-
+#include "hw/qdev-properties.h"
 
 static void mips_cpu_set_pc(CPUState *cs, vaddr value)
 {
@@ -183,6 +183,11 @@ static ObjectClass *mips_cpu_class_by_name(const char *cpu_model)
     return oc;
 }
 
+static Property mips_cpu_properties[] = {
+    DEFINE_PROP_UINT8("tlb-entries", MIPSCPU, env.tlb_entries, 0),
+    DEFINE_PROP_END_OF_LIST()
+};
+
 static void mips_cpu_class_init(ObjectClass *c, void *data)
 {
     MIPSCPUClass *mcc = MIPS_CPU_CLASS(c);
@@ -192,6 +197,7 @@ static void mips_cpu_class_init(ObjectClass *c, void *data)
     device_class_set_parent_realize(dc, mips_cpu_realizefn,
                                     &mcc->parent_realize);
     device_class_set_parent_reset(dc, mips_cpu_reset, &mcc->parent_reset);
+    device_class_set_props(dc, mips_cpu_properties);
 
     cc->class_by_name = mips_cpu_class_by_name;
     cc->has_work = mips_cpu_has_work;
diff --git a/target/mips/translate.c b/target/mips/translate.c
index 9d13e164c2e..70e45b0f7ec 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -39,6 +39,7 @@
 #include "exec/translator.h"
 #include "exec/log.h"
 #include "qemu/qemu-print.h"
+#include "qapi/error.h"
 
 #define MIPS_DEBUG_DISAS 0
 
@@ -31319,7 +31320,14 @@ void mips_tcg_init(void)
 bool cpu_mips_realize_env(CPUMIPSState *env, Error **errp)
 {
     env->exception_base = (int32_t)0xBFC00000;
-    env->tlb_entries = 1 + extract32(env->cpu_model->CP0_Config1, CP0C1_MMU, 6);
+    if (!env->tlb_entries) {
+        env->tlb_entries = 1 + extract32(env->cpu_model->CP0_Config1,
+                                         CP0C1_MMU, 6);
+    } else if (env->tlb_entries > 64) {
+        error_setg(errp, "Invalid value '%d' for property 'tlb-entries'",
+                   env->tlb_entries);
+        return false;
+    }
 
 #ifndef CONFIG_USER_ONLY
     mmu_init(env, env->cpu_model);
-- 
2.26.2


