Return-Path: <SRS0=BZbV=DR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AEFAC433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 21:02:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1E3A20657
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 21:02:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L2cCiuW1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1E3A20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56418 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRM0X-0005Ve-Vc
	for qemu-devel@archiver.kernel.org; Sat, 10 Oct 2020 17:02:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52216)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRLic-0000xF-FE
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 16:43:55 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:33556)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRLia-0007X0-2K
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 16:43:54 -0400
Received: by mail-wr1-x444.google.com with SMTP id b8so948772wrn.0
 for <qemu-devel@nongnu.org>; Sat, 10 Oct 2020 13:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=HmgC37wCjLUJVnf61J8zdojgJc5xhuHBXkX9blUA1GM=;
 b=L2cCiuW1gh4KaQIQssXFB0b86mjkC7G5lKUM6vl1IOuEa7RYxGPDx+cp4HqfjrwADi
 KV72V48Shrst0S1S7+kqekCHaMuxwvGq6MFh1tXKSlpY65ogy/y6vgKXESIvHM+CS8n2
 L4AbE4wSmOB88hMcXlR5oy0iY7PC8zDxzN/ZHmm/Ej0sKi6CaJZhooujVnzbNN5vpytq
 lxk44gLaEaHj3eTKH93hLhcxv1eSXPTcun88i269GDJZkdvK1ehCXoCj60cmzggzDmxR
 HwkLIIMugb88KYYcAxa7JcBu07YkfcavjNfSwoQ4DSeqak2Gv3ttVPYy5/WeMrSFGM1F
 oVJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=HmgC37wCjLUJVnf61J8zdojgJc5xhuHBXkX9blUA1GM=;
 b=kXiI5qUYonzToJo21rXbh54zlrm4S4kw/APbMVYAeRXTppM0p64ioeiXAwzuM/3nuA
 8mFwKLNIRPf/cyaBh1ExVSKm6MmzElht2Uc+XpzsRFmXKjhc8u2UudlW3+z8tdNRdUOA
 jReEIkWw77BRDMKsTIvDuxLFMlUc1i1dh2INCiQAGUSwXebnnUrzL8KkSeuaUwpils6s
 nBta8Oht1vFL5h7sZE/1Df+zePWF4mY04Em9PHoPh2zW++gAyvvLn03/Nm3B8xLfL5HD
 MTlQTt7L1zOrc/Jwpms/aknZSPG1b7ywGh28JohUVwkT36IGAWAVwtIs9fMwTziYOs9E
 tk/w==
X-Gm-Message-State: AOAM532c2oG44EjNtrYyjd8jGiDjbSgw8i8ug6EWE00EnME/0WyLqFbn
 5VXRKWVWSOtPf6EBTvz9K74Ro61wwOs=
X-Google-Smtp-Source: ABdhPJzrK6R/IBjIkkKex+DEZ6OJEqH8AmIait6xHkDT0ThvG0ifr9pZ7ThXNV+ZwiRz24lX8PHz/g==
X-Received: by 2002:adf:e6c4:: with SMTP id y4mr21980726wrm.423.1602362629751; 
 Sat, 10 Oct 2020 13:43:49 -0700 (PDT)
Received: from localhost.localdomain
 (106.red-83-59-162.dynamicip.rima-tde.net. [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id 205sm2705471wme.38.2020.10.10.13.43.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Oct 2020 13:43:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 20/20] target/mips/cpu: Display warning when CPU is used
 without input clock
Date: Sat, 10 Oct 2020 22:43:19 +0200
Message-Id: <20201010204319.3119239-21-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201010204319.3119239-1-f4bug@amsat.org>
References: <20201010204319.3119239-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
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
Cc: Damien Hedde <damien.hedde@greensocs.com>,
 Huacai Chen <zltjiangshi@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>, Luc Michel <luc@lmichel.fr>,
 Eduardo Habkost <ehabkost@redhat.com>, Paul Burton <paulburton@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Huacai Chen <chenhc@lemote.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

All our QOM users provides an input clock. In order to avoid
avoid future machines added without clock, display a warning.

User-mode emulation use the CP0 timer with the RDHWR instruction
(see commit cdfcad788394) so keep using the fixed 200 MHz clock
without diplaying any warning. Only display it in system-mode
emulation.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 target/mips/cpu.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index 3deb0245e7c..60011068e4d 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -19,12 +19,14 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/cutils.h"
 #include "qapi/error.h"
 #include "cpu.h"
 #include "internal.h"
 #include "kvm_mips.h"
 #include "qemu/module.h"
 #include "sysemu/kvm.h"
+#include "sysemu/qtest.h"
 #include "exec/exec-all.h"
 #include "hw/qdev-properties.h"
 #include "hw/qdev-clock.h"
@@ -157,6 +159,14 @@ static void mips_cpu_realizefn(DeviceState *dev, Error **errp)
     Error *local_err = NULL;
 
     if (!clock_get(cpu->clock)) {
+#ifndef CONFIG_USER_ONLY
+        if (!qtest_enabled()) {
+            g_autofree char *cpu_freq_str = freq_to_str(CPU_FREQ_HZ_DEFAULT);
+
+            warn_report("CPU input clock is not connected to any output clock, "
+                        "using default frequency of %s.", cpu_freq_str);
+        }
+#endif
         /* Initialize the frequency in case the clock remains unconnected. */
         clock_set_hz(cpu->clock, CPU_FREQ_HZ_DEFAULT);
     }
-- 
2.26.2


