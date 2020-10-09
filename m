Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 146FFC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 06:55:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C10922248
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 06:55:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KKnvFlLM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C10922248
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQmJ7-00071i-5C
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 02:55:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55680)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chetan4windows@gmail.com>)
 id 1kQm76-0001wy-2g; Fri, 09 Oct 2020 02:42:48 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:44318)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chetan4windows@gmail.com>)
 id 1kQm6v-0000vI-K2; Fri, 09 Oct 2020 02:42:43 -0400
Received: by mail-pl1-x643.google.com with SMTP id h2so3984166pll.11;
 Thu, 08 Oct 2020 23:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=sQy1HBjpiU1Vti4ARlN69b2jsDNxmJuiz70GahnHgs0=;
 b=KKnvFlLMwVNtNirRAItollkcJQufEjVeOwcz3bQfCcY24SiSGH+TfsijX71C3kkkT4
 D+0ldITuU7iAFuKmObjxS93hYGGFt3wCMqJhj8fad0zISdalFbLWRTk7zJw8rK+/nWfx
 glgPwZSM9Yr5XtuuEv2Xfz432QjXn7crZdzRRPHQOFO4lxAvj7zDNhi46aRHCMtHVrJj
 QnmPYziZNYkFWbUnTOpR8kpewV8A4W7/6unBJA0CKivmKZMgCsV2b4IHSmZfycmYgjft
 EITVyPoePezvdX5ACu9ylhxoDNE3vNLzpZLa/YiJyeAs5fl0VPDServwqhvwiwZzU8AG
 M7TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=sQy1HBjpiU1Vti4ARlN69b2jsDNxmJuiz70GahnHgs0=;
 b=UMGO6uIP+BKak1Y1UsoXwcvlmzTy2bWMXoVGMaIn+jyj9yI2lvGD3BQe7FQY+dFQzr
 a77phrhgHE9P76R3XqWkyW2Ye1yL/M/R2OFR1BFNcZDX/s5WfDlbDlITNQaZvPQtyt8k
 MaJGBJujZZobnPmm9ND1fRtp2L5g2vlWDQ8lu/jtANNIweKbjnMmcPtMROcHGH/rLGvS
 y93+ylhLX2M8C89yzrQKJaBRh0qZ634yMTmupr21A/4MXPaLBE8CK8TAeupj2MKcKzaF
 fyeSfpy4NRjkZil11fksjhN3nLfSdNg0qpNtb//kU0sJjnqlVf3c5QkrrKuCD1qN6GFk
 UHAA==
X-Gm-Message-State: AOAM533UO7Ls3Q47Nmel6xyCXbAxmqicsqg/0Z0er00cauH0jCDyshCm
 pUwjsjVhVVQVOt+ZtArmWLWYHaf000CAnCzq
X-Google-Smtp-Source: ABdhPJwBHhxQuFvuU/exSDFB8ifk1i6utc7jdbs+uBAEJDExLZrpt5JJgWKW91/+d7Wi/RUYcRRHvw==
X-Received: by 2002:a17:902:b096:b029:d3:e6c5:507c with SMTP id
 p22-20020a170902b096b02900d3e6c5507cmr11160457plr.71.1602225751065; 
 Thu, 08 Oct 2020 23:42:31 -0700 (PDT)
Received: from pulp100.localdomain ([103.199.158.131])
 by smtp.gmail.com with ESMTPSA id e16sm9317127pgv.81.2020.10.08.23.42.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2020 23:42:30 -0700 (PDT)
From: Chetan Pant <chetan4windows@gmail.com>
To: qemu-trivial@nongnu.org
Subject: [PATCH 3/5] Fixing Lesser GPL version number [3/5]
Date: Fri,  9 Oct 2020 06:41:06 +0000
Message-Id: <20201009064106.2818-1-chetan4windows@gmail.com>
X-Mailer: git-send-email 2.17.1
Received-SPF: pass client-ip=2607:f8b0:4864:20::643;
 envelope-from=chetan4windows@gmail.com; helo=mail-pl1-x643.google.com
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
Cc: thuth@redhat.com, qemu-devel@nongnu.org,
 Chetan Pant <chetan4windows@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There is no "version 2" of the "Lesser" General Public License. It is
either "GPL version 2.0" or "Lesser GPL version 2.1". This patch replaces all
occurrences of "Lesser GPL version 2" with "Lesser GPL version 2.1" in comment section.
Also, It came to notice that some of the files that were edited for the change
were not following latest comment rules. For example using "//" to mark comment
instead of "/*". That is also fixed in this patch.

This patch is divided in 5 parts, directory wise, in order to make reviewing process easier.
Below listed are the parts of the patch, where asterisk denotes the part you are currently viewing.

	[ ] Files in authz/backends/block/linux-user/tests/migration directory (82 Files)
	[ ] Files in hw/include/disas (100 files)
	[*] Files inside target/ 'alpha,arm,cris,hppa,i386' (96 files)
	[ ] Files inside target/ 'lm32,microblaze,mips,ppc,rx,sparc,tilegx,tricore,xtensa' (63 files)
	[ ] Files in ui/util/include/scripts and QEMU root directory (76 Files)

Below is how the license version was corrected:

1. To find the number of file having "Lesser GPL version 2 ":
	grep -l Lesser $(grep -rl "version 2 " * ) > result.dat
   Total of 417 files were found (After manually exluding the files like COPYING and COPYING.LIB from the result)

2. To find the number of occurences of "version 2 " in the resulted files:
	egrep -c "version 2 " $(cat result.dat)
   410 files had "version 2" occurence 1 time (name of those files was saved in one_timers.dat)
   and in 7 files "version 2" occurences were multiple times.

3. Files having occurence exactly 1 time were corrected using below command:
	sed -i "s/version 2 /version 2.1 /g" $(cat one_timers.dat)
   For rest of 7 files, correction was done manually.

Signed-off-by: Chetan Pant <chetan4windows@gmail.com>
---
 target/alpha/cpu.h                  |  2 +-
 target/alpha/fpu_helper.c           |  2 +-
 target/alpha/gdbstub.c              |  2 +-
 target/alpha/helper.c               |  2 +-
 target/alpha/int_helper.c           |  2 +-
 target/alpha/mem_helper.c           |  2 +-
 target/alpha/sys_helper.c           |  2 +-
 target/alpha/translate.c            |  2 +-
 target/alpha/vax_helper.c           |  2 +-
 target/arm/a32-uncond.decode        |  2 +-
 target/arm/a32.decode               |  2 +-
 target/arm/arm_ldst.h               |  2 +-
 target/arm/cpu.h                    |  2 +-
 target/arm/crypto_helper.c          |  2 +-
 target/arm/gdbstub.c                |  2 +-
 target/arm/gdbstub64.c              |  2 +-
 target/arm/helper-a64.c             |  2 +-
 target/arm/helper-a64.h             |  2 +-
 target/arm/helper-sve.h             |  2 +-
 target/arm/iwmmxt_helper.c          |  2 +-
 target/arm/neon-dp.decode           |  2 +-
 target/arm/neon-ls.decode           |  2 +-
 target/arm/neon-shared.decode       |  2 +-
 target/arm/op_helper.c              |  2 +-
 target/arm/pauth_helper.c           |  2 +-
 target/arm/sve.decode               |  2 +-
 target/arm/sve_helper.c             |  2 +-
 target/arm/t16.decode               |  2 +-
 target/arm/t32.decode               |  2 +-
 target/arm/translate-a64.c          |  2 +-
 target/arm/translate-a64.h          |  2 +-
 target/arm/translate-neon.c.inc     |  2 +-
 target/arm/translate-sve.c          |  2 +-
 target/arm/translate-vfp.c.inc      |  2 +-
 target/arm/translate.c              |  2 +-
 target/arm/vec_helper.c             |  2 +-
 target/arm/vec_internal.h           |  2 +-
 target/arm/vfp-uncond.decode        |  2 +-
 target/arm/vfp.decode               |  2 +-
 target/cris/cpu.h                   |  2 +-
 target/cris/crisv10-decode.h        |  2 +-
 target/cris/crisv32-decode.h        |  2 +-
 target/cris/gdbstub.c               |  2 +-
 target/cris/helper.c                |  2 +-
 target/cris/machine.c               |  2 +-
 target/cris/mmu.c                   |  2 +-
 target/cris/op_helper.c             |  2 +-
 target/cris/translate.c             |  2 +-
 target/cris/translate_v10.c.inc     |  2 +-
 target/hppa/cpu.h                   |  2 +-
 target/hppa/gdbstub.c               |  2 +-
 target/hppa/helper.c                |  2 +-
 target/hppa/insns.decode            |  2 +-
 target/hppa/int_helper.c            |  2 +-
 target/hppa/machine.c               |  2 +-
 target/hppa/mem_helper.c            |  2 +-
 target/hppa/op_helper.c             |  2 +-
 target/hppa/translate.c             |  2 +-
 target/i386/bpt_helper.c            |  2 +-
 target/i386/cc_helper.c             |  2 +-
 target/i386/cc_helper_template.h    |  2 +-
 target/i386/cpu.c                   |  2 +-
 target/i386/cpu.h                   |  2 +-
 target/i386/excp_helper.c           |  2 +-
 target/i386/fpu_helper.c            |  2 +-
 target/i386/gdbstub.c               |  2 +-
 target/i386/helper.c                |  2 +-
 target/i386/hvf/panic.h             |  2 +-
 target/i386/hvf/vmx.h               |  2 +-
 target/i386/hvf/x86.c               |  2 +-
 target/i386/hvf/x86.h               |  2 +-
 target/i386/hvf/x86_cpuid.c         |  2 +-
 target/i386/hvf/x86_decode.c        |  2 +-
 target/i386/hvf/x86_decode.h        |  2 +-
 target/i386/hvf/x86_descr.c         |  2 +-
 target/i386/hvf/x86_descr.h         |  2 +-
 target/i386/hvf/x86_emu.c           | 38 ++++++++++++++---------------
 target/i386/hvf/x86_emu.h           |  2 +-
 target/i386/hvf/x86_flags.c         | 38 ++++++++++++++---------------
 target/i386/hvf/x86_flags.h         | 38 ++++++++++++++---------------
 target/i386/hvf/x86_mmu.c           |  2 +-
 target/i386/hvf/x86_mmu.h           |  2 +-
 target/i386/hvf/x86hvf.c            |  2 +-
 target/i386/hvf/x86hvf.h            |  2 +-
 target/i386/int_helper.c            |  2 +-
 target/i386/mem_helper.c            |  2 +-
 target/i386/misc_helper.c           |  2 +-
 target/i386/mpx_helper.c            |  2 +-
 target/i386/ops_sse.h               |  2 +-
 target/i386/ops_sse_header.h        |  2 +-
 target/i386/seg_helper.c            |  2 +-
 target/i386/shift_helper_template.h |  2 +-
 target/i386/smm_helper.c            |  2 +-
 target/i386/svm_helper.c            |  2 +-
 target/i386/tcg-stub.c              |  2 +-
 target/i386/translate.c             |  2 +-
 96 files changed, 150 insertions(+), 150 deletions(-)

diff --git a/target/alpha/cpu.h b/target/alpha/cpu.h
index be29bdd..82df108 100644
--- a/target/alpha/cpu.h
+++ b/target/alpha/cpu.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/alpha/fpu_helper.c b/target/alpha/fpu_helper.c
index df8b589..3ff8bb4 100644
--- a/target/alpha/fpu_helper.c
+++ b/target/alpha/fpu_helper.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/alpha/gdbstub.c b/target/alpha/gdbstub.c
index 0cd76dd..7db14f4 100644
--- a/target/alpha/gdbstub.c
+++ b/target/alpha/gdbstub.c
@@ -7,7 +7,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/alpha/helper.c b/target/alpha/helper.c
index 55d7274..4f56fe4 100644
--- a/target/alpha/helper.c
+++ b/target/alpha/helper.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/alpha/int_helper.c b/target/alpha/int_helper.c
index e43b50a..5672696 100644
--- a/target/alpha/int_helper.c
+++ b/target/alpha/int_helper.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/alpha/mem_helper.c b/target/alpha/mem_helper.c
index 934faa1..75e72bc 100644
--- a/target/alpha/mem_helper.c
+++ b/target/alpha/mem_helper.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/alpha/sys_helper.c b/target/alpha/sys_helper.c
index 3922923..25f6cb8 100644
--- a/target/alpha/sys_helper.c
+++ b/target/alpha/sys_helper.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index 8870284..ba5bba7 100644
--- a/target/alpha/translate.c
+++ b/target/alpha/translate.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/alpha/vax_helper.c b/target/alpha/vax_helper.c
index 2b0c178..f94fb51 100644
--- a/target/alpha/vax_helper.c
+++ b/target/alpha/vax_helper.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/arm/a32-uncond.decode b/target/arm/a32-uncond.decode
index 60ccfc5..2339de2 100644
--- a/target/arm/a32-uncond.decode
+++ b/target/arm/a32-uncond.decode
@@ -5,7 +5,7 @@
 # This library is free software; you can redistribute it and/or
 # modify it under the terms of the GNU Lesser General Public
 # License as published by the Free Software Foundation; either
-# version 2 of the License, or (at your option) any later version.
+# version 2.1 of the License, or (at your option) any later version.
 #
 # This library is distributed in the hope that it will be useful,
 # but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/arm/a32.decode b/target/arm/a32.decode
index 4dfd913..fcd8cd4 100644
--- a/target/arm/a32.decode
+++ b/target/arm/a32.decode
@@ -5,7 +5,7 @@
 # This library is free software; you can redistribute it and/or
 # modify it under the terms of the GNU Lesser General Public
 # License as published by the Free Software Foundation; either
-# version 2 of the License, or (at your option) any later version.
+# version 2.1 of the License, or (at your option) any later version.
 #
 # This library is distributed in the hope that it will be useful,
 # but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/arm/arm_ldst.h b/target/arm/arm_ldst.h
index 45edb10..057160e 100644
--- a/target/arm/arm_ldst.h
+++ b/target/arm/arm_ldst.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 6036f61..36205a9 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/arm/crypto_helper.c b/target/arm/crypto_helper.c
index c76806d..28a84c2 100644
--- a/target/arm/crypto_helper.c
+++ b/target/arm/crypto_helper.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  */
 
 #include "qemu/osdep.h"
diff --git a/target/arm/gdbstub.c b/target/arm/gdbstub.c
index ecfa88f..866595b 100644
--- a/target/arm/gdbstub.c
+++ b/target/arm/gdbstub.c
@@ -7,7 +7,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/arm/gdbstub64.c b/target/arm/gdbstub64.c
index 35d0b80..251539e 100644
--- a/target/arm/gdbstub64.c
+++ b/target/arm/gdbstub64.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/arm/helper-a64.c b/target/arm/helper-a64.c
index 0308214..30b2ad1 100644
--- a/target/arm/helper-a64.c
+++ b/target/arm/helper-a64.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/arm/helper-a64.h b/target/arm/helper-a64.h
index 5b0b699..7bd6aed 100644
--- a/target/arm/helper-a64.h
+++ b/target/arm/helper-a64.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index 4411c47..e4cadd2 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/arm/iwmmxt_helper.c b/target/arm/iwmmxt_helper.c
index 24244d0..610b1b2 100644
--- a/target/arm/iwmmxt_helper.c
+++ b/target/arm/iwmmxt_helper.c
@@ -8,7 +8,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/arm/neon-dp.decode b/target/arm/neon-dp.decode
index 51aa0f0..ec83f10 100644
--- a/target/arm/neon-dp.decode
+++ b/target/arm/neon-dp.decode
@@ -5,7 +5,7 @@
 # This library is free software; you can redistribute it and/or
 # modify it under the terms of the GNU Lesser General Public
 # License as published by the Free Software Foundation; either
-# version 2 of the License, or (at your option) any later version.
+# version 2.1 of the License, or (at your option) any later version.
 #
 # This library is distributed in the hope that it will be useful,
 # but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/arm/neon-ls.decode b/target/arm/neon-ls.decode
index c7b03a7..c17f501 100644
--- a/target/arm/neon-ls.decode
+++ b/target/arm/neon-ls.decode
@@ -5,7 +5,7 @@
 # This library is free software; you can redistribute it and/or
 # modify it under the terms of the GNU Lesser General Public
 # License as published by the Free Software Foundation; either
-# version 2 of the License, or (at your option) any later version.
+# version 2.1 of the License, or (at your option) any later version.
 #
 # This library is distributed in the hope that it will be useful,
 # but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/arm/neon-shared.decode b/target/arm/neon-shared.decode
index a9d0108..ca0c699 100644
--- a/target/arm/neon-shared.decode
+++ b/target/arm/neon-shared.decode
@@ -5,7 +5,7 @@
 # This library is free software; you can redistribute it and/or
 # modify it under the terms of the GNU Lesser General Public
 # License as published by the Free Software Foundation; either
-# version 2 of the License, or (at your option) any later version.
+# version 2.1 of the License, or (at your option) any later version.
 #
 # This library is distributed in the hope that it will be useful,
 # but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/arm/op_helper.c b/target/arm/op_helper.c
index b106521..b84d6d5 100644
--- a/target/arm/op_helper.c
+++ b/target/arm/op_helper.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/arm/pauth_helper.c b/target/arm/pauth_helper.c
index 6dbab03..564c48f 100644
--- a/target/arm/pauth_helper.c
+++ b/target/arm/pauth_helper.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index 6425396..5c90603 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -5,7 +5,7 @@
 # This library is free software; you can redistribute it and/or
 # modify it under the terms of the GNU Lesser General Public
 # License as published by the Free Software Foundation; either
-# version 2 of the License, or (at your option) any later version.
+# version 2.1 of the License, or (at your option) any later version.
 #
 # This library is distributed in the hope that it will be useful,
 # but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index 4758d46..5f037c3 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/arm/t16.decode b/target/arm/t16.decode
index 43b9a26..646c749 100644
--- a/target/arm/t16.decode
+++ b/target/arm/t16.decode
@@ -5,7 +5,7 @@
 # This library is free software; you can redistribute it and/or
 # modify it under the terms of the GNU Lesser General Public
 # License as published by the Free Software Foundation; either
-# version 2 of the License, or (at your option) any later version.
+# version 2.1 of the License, or (at your option) any later version.
 #
 # This library is distributed in the hope that it will be useful,
 # but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/arm/t32.decode b/target/arm/t32.decode
index 7069d82..06d16b3 100644
--- a/target/arm/t32.decode
+++ b/target/arm/t32.decode
@@ -5,7 +5,7 @@
 # This library is free software; you can redistribute it and/or
 # modify it under the terms of the GNU Lesser General Public
 # License as published by the Free Software Foundation; either
-# version 2 of the License, or (at your option) any later version.
+# version 2.1 of the License, or (at your option) any later version.
 #
 # This library is distributed in the hope that it will be useful,
 # but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 7188808..6cb8d5a 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/arm/translate-a64.h b/target/arm/translate-a64.h
index 2e0d16d..3668b67 100644
--- a/target/arm/translate-a64.h
+++ b/target/arm/translate-a64.h
@@ -4,7 +4,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/arm/translate-neon.c.inc b/target/arm/translate-neon.c.inc
index 4d1a292..0c6db4d 100644
--- a/target/arm/translate-neon.c.inc
+++ b/target/arm/translate-neon.c.inc
@@ -9,7 +9,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index e4cd6b6..bf1ce67 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/arm/translate-vfp.c.inc b/target/arm/translate-vfp.c.inc
index 28e0dba..4a05312 100644
--- a/target/arm/translate-vfp.c.inc
+++ b/target/arm/translate-vfp.c.inc
@@ -9,7 +9,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/arm/translate.c b/target/arm/translate.c
index d34c1d3..0329648 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -8,7 +8,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/arm/vec_helper.c b/target/arm/vec_helper.c
index a973454..86ad8b1 100644
--- a/target/arm/vec_helper.c
+++ b/target/arm/vec_helper.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/arm/vec_internal.h b/target/arm/vec_internal.h
index 00a8277..e3eb3e7 100644
--- a/target/arm/vec_internal.h
+++ b/target/arm/vec_internal.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/arm/vfp-uncond.decode b/target/arm/vfp-uncond.decode
index 8891ab3..5c50447 100644
--- a/target/arm/vfp-uncond.decode
+++ b/target/arm/vfp-uncond.decode
@@ -5,7 +5,7 @@
 # This library is free software; you can redistribute it and/or
 # modify it under the terms of the GNU Lesser General Public
 # License as published by the Free Software Foundation; either
-# version 2 of the License, or (at your option) any later version.
+# version 2.1 of the License, or (at your option) any later version.
 #
 # This library is distributed in the hope that it will be useful,
 # but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/arm/vfp.decode b/target/arm/vfp.decode
index 51f143b..1300ba0 100644
--- a/target/arm/vfp.decode
+++ b/target/arm/vfp.decode
@@ -5,7 +5,7 @@
 # This library is free software; you can redistribute it and/or
 # modify it under the terms of the GNU Lesser General Public
 # License as published by the Free Software Foundation; either
-# version 2 of the License, or (at your option) any later version.
+# version 2.1 of the License, or (at your option) any later version.
 #
 # This library is distributed in the hope that it will be useful,
 # but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/cris/cpu.h b/target/cris/cpu.h
index 8f08d76..d3b6492 100644
--- a/target/cris/cpu.h
+++ b/target/cris/cpu.h
@@ -7,7 +7,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/cris/crisv10-decode.h b/target/cris/crisv10-decode.h
index 028179b..9c531f3 100644
--- a/target/cris/crisv10-decode.h
+++ b/target/cris/crisv10-decode.h
@@ -7,7 +7,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/cris/crisv32-decode.h b/target/cris/crisv32-decode.h
index cdc2f8c..fa0a7f0 100644
--- a/target/cris/crisv32-decode.h
+++ b/target/cris/crisv32-decode.h
@@ -7,7 +7,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/cris/gdbstub.c b/target/cris/gdbstub.c
index b01b2aa..2418d57 100644
--- a/target/cris/gdbstub.c
+++ b/target/cris/gdbstub.c
@@ -7,7 +7,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/cris/helper.c b/target/cris/helper.c
index b5159b8..ed45c3d 100644
--- a/target/cris/helper.c
+++ b/target/cris/helper.c
@@ -7,7 +7,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/cris/machine.c b/target/cris/machine.c
index be38a89..f370f33 100644
--- a/target/cris/machine.c
+++ b/target/cris/machine.c
@@ -7,7 +7,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/cris/mmu.c b/target/cris/mmu.c
index 2acbcfd..a279b7f 100644
--- a/target/cris/mmu.c
+++ b/target/cris/mmu.c
@@ -7,7 +7,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/cris/op_helper.c b/target/cris/op_helper.c
index 6b1e7ae..d55a18a 100644
--- a/target/cris/op_helper.c
+++ b/target/cris/op_helper.c
@@ -7,7 +7,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/cris/translate.c b/target/cris/translate.c
index c312e6f..c893f87 100644
--- a/target/cris/translate.c
+++ b/target/cris/translate.c
@@ -7,7 +7,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/cris/translate_v10.c.inc b/target/cris/translate_v10.c.inc
index 7f38fd2..86d78a8 100644
--- a/target/cris/translate_v10.c.inc
+++ b/target/cris/translate_v10.c.inc
@@ -7,7 +7,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index fb6c59d..61178fa 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/hppa/gdbstub.c b/target/hppa/gdbstub.c
index a6428a2..729c37b 100644
--- a/target/hppa/gdbstub.c
+++ b/target/hppa/gdbstub.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/hppa/helper.c b/target/hppa/helper.c
index 0dcd105..1ccff57 100644
--- a/target/hppa/helper.c
+++ b/target/hppa/helper.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/hppa/insns.decode b/target/hppa/insns.decode
index dceaad6..d4eefc0 100644
--- a/target/hppa/insns.decode
+++ b/target/hppa/insns.decode
@@ -6,7 +6,7 @@
 # This library is free software; you can redistribute it and/or
 # modify it under the terms of the GNU Lesser General Public
 # License as published by the Free Software Foundation; either
-# version 2 of the License, or (at your option) any later version.
+# version 2.1 of the License, or (at your option) any later version.
 #
 # This library is distributed in the hope that it will be useful,
 # but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/hppa/int_helper.c b/target/hppa/int_helper.c
index 462747b..349495d 100644
--- a/target/hppa/int_helper.c
+++ b/target/hppa/int_helper.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/hppa/machine.c b/target/hppa/machine.c
index 7030101..b60b654 100644
--- a/target/hppa/machine.c
+++ b/target/hppa/machine.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
index 5a465db..afc5b56 100644
--- a/target/hppa/mem_helper.c
+++ b/target/hppa/mem_helper.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/hppa/op_helper.c b/target/hppa/op_helper.c
index 39361d3..7ae31e1 100644
--- a/target/hppa/op_helper.c
+++ b/target/hppa/op_helper.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index f5765ef..64af1e0 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/i386/bpt_helper.c b/target/i386/bpt_helper.c
index c3a8ea7..e6cc292 100644
--- a/target/i386/bpt_helper.c
+++ b/target/i386/bpt_helper.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/i386/cc_helper.c b/target/i386/cc_helper.c
index c9c90e1..924dd3c 100644
--- a/target/i386/cc_helper.c
+++ b/target/i386/cc_helper.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/i386/cc_helper_template.h b/target/i386/cc_helper_template.h
index 607311f..bb611fe 100644
--- a/target/i386/cc_helper_template.h
+++ b/target/i386/cc_helper_template.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 3ffd877..3ff1cdf 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index f519d2b..97f2b4b 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/i386/excp_helper.c b/target/i386/excp_helper.c
index b10c7ec..1914717 100644
--- a/target/i386/excp_helper.c
+++ b/target/i386/excp_helper.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/i386/fpu_helper.c b/target/i386/fpu_helper.c
index 4ea7387..03b3544 100644
--- a/target/i386/fpu_helper.c
+++ b/target/i386/fpu_helper.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/i386/gdbstub.c b/target/i386/gdbstub.c
index 9ae43bd..4a3de5f 100644
--- a/target/i386/gdbstub.c
+++ b/target/i386/gdbstub.c
@@ -7,7 +7,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/i386/helper.c b/target/i386/helper.c
index 70be53e..d46999b 100644
--- a/target/i386/helper.c
+++ b/target/i386/helper.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/i386/hvf/panic.h b/target/i386/hvf/panic.h
index 411ef43..a3eabeb 100644
--- a/target/i386/hvf/panic.h
+++ b/target/i386/hvf/panic.h
@@ -5,7 +5,7 @@
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This program is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/i386/hvf/vmx.h b/target/i386/hvf/vmx.h
index 587b1b8..24c4cdf 100644
--- a/target/i386/hvf/vmx.h
+++ b/target/i386/hvf/vmx.h
@@ -8,7 +8,7 @@
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This program is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/i386/hvf/x86.c b/target/i386/hvf/x86.c
index fdb11c8..cd04518 100644
--- a/target/i386/hvf/x86.c
+++ b/target/i386/hvf/x86.c
@@ -5,7 +5,7 @@
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This program is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/i386/hvf/x86.h b/target/i386/hvf/x86.h
index bacade7..9e2c003 100644
--- a/target/i386/hvf/x86.h
+++ b/target/i386/hvf/x86.h
@@ -5,7 +5,7 @@
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This program is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/i386/hvf/x86_cpuid.c b/target/i386/hvf/x86_cpuid.c
index 16762b6..ac731c2 100644
--- a/target/i386/hvf/x86_cpuid.c
+++ b/target/i386/hvf/x86_cpuid.c
@@ -7,7 +7,7 @@
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This program is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/i386/hvf/x86_decode.c b/target/i386/hvf/x86_decode.c
index 34c5e30..062713b 100644
--- a/target/i386/hvf/x86_decode.c
+++ b/target/i386/hvf/x86_decode.c
@@ -5,7 +5,7 @@
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This program is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/i386/hvf/x86_decode.h b/target/i386/hvf/x86_decode.h
index ef79601..a2d7a2a 100644
--- a/target/i386/hvf/x86_decode.h
+++ b/target/i386/hvf/x86_decode.h
@@ -4,7 +4,7 @@
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This program is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/i386/hvf/x86_descr.c b/target/i386/hvf/x86_descr.c
index 8c05c34..9f539e7 100644
--- a/target/i386/hvf/x86_descr.c
+++ b/target/i386/hvf/x86_descr.c
@@ -5,7 +5,7 @@
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This program is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/i386/hvf/x86_descr.h b/target/i386/hvf/x86_descr.h
index 049ef9a..c356932 100644
--- a/target/i386/hvf/x86_descr.h
+++ b/target/i386/hvf/x86_descr.h
@@ -5,7 +5,7 @@
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This program is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/i386/hvf/x86_emu.c b/target/i386/hvf/x86_emu.c
index d3e289e..91668be 100644
--- a/target/i386/hvf/x86_emu.c
+++ b/target/i386/hvf/x86_emu.c
@@ -5,7 +5,7 @@
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This program is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
@@ -16,24 +16,24 @@
  * License along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
-/////////////////////////////////////////////////////////////////////////
-//
-//  Copyright (C) 2001-2012  The Bochs Project
-//
-//  This library is free software; you can redistribute it and/or
-//  modify it under the terms of the GNU Lesser General Public
-//  License as published by the Free Software Foundation; either
-//  version 2 of the License, or (at your option) any later version.
-//
-//  This library is distributed in the hope that it will be useful,
-//  but WITHOUT ANY WARRANTY; without even the implied warranty of
-//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-//  Lesser General Public License for more details.
-//
-//  You should have received a copy of the GNU Lesser General Public
-//  License along with this library; if not, write to the Free Software
-//  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA B 02110-1301 USA
-/////////////////////////////////////////////////////////////////////////
+/*
+ *
+ *  Copyright (C) 2001-2012  The Bochs Project
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA B 02110-1301 USA
+ */
 
 #include "qemu/osdep.h"
 #include "panic.h"
diff --git a/target/i386/hvf/x86_emu.h b/target/i386/hvf/x86_emu.h
index f92a9c5..233f7b8 100644
--- a/target/i386/hvf/x86_emu.h
+++ b/target/i386/hvf/x86_emu.h
@@ -5,7 +5,7 @@
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This program is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/i386/hvf/x86_flags.c b/target/i386/hvf/x86_flags.c
index 5ca4f41..d8b09ea 100644
--- a/target/i386/hvf/x86_flags.c
+++ b/target/i386/hvf/x86_flags.c
@@ -1,22 +1,22 @@
-/////////////////////////////////////////////////////////////////////////
-//
-//  Copyright (C) 2001-2012  The Bochs Project
-//  Copyright (C) 2017 Google Inc.
-//
-//  This library is free software; you can redistribute it and/or
-//  modify it under the terms of the GNU Lesser General Public
-//  License as published by the Free Software Foundation; either
-//  version 2 of the License, or (at your option) any later version.
-//
-//  This library is distributed in the hope that it will be useful,
-//  but WITHOUT ANY WARRANTY; without even the implied warranty of
-//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-//  Lesser General Public License for more details.
-//
-//  You should have received a copy of the GNU Lesser General Public
-//  License along with this library; if not, write to the Free Software
-//  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA B 02110-1301 USA
-/////////////////////////////////////////////////////////////////////////
+/*
+ *
+ *  Copyright (C) 2001-2012  The Bochs Project
+ *  Copyright (C) 2017 Google Inc.
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA B 02110-1301 USA
+ */
 /*
  * flags functions
  */
diff --git a/target/i386/hvf/x86_flags.h b/target/i386/hvf/x86_flags.h
index 785e80c..636446e 100644
--- a/target/i386/hvf/x86_flags.h
+++ b/target/i386/hvf/x86_flags.h
@@ -1,22 +1,22 @@
-/////////////////////////////////////////////////////////////////////////
-//
-//  Copyright (C) 2001-2012  The Bochs Project
-//  Copyright (C) 2017 Google Inc.
-//
-//  This library is free software; you can redistribute it and/or
-//  modify it under the terms of the GNU Lesser General Public
-//  License as published by the Free Software Foundation; either
-//  version 2 of the License, or (at your option) any later version.
-//
-//  This library is distributed in the hope that it will be useful,
-//  but WITHOUT ANY WARRANTY; without even the implied warranty of
-//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-//  Lesser General Public License for more details.
-//
-//  You should have received a copy of the GNU Lesser General Public
-//  License along with this library; if not, write to the Free Software
-//  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA B 02110-1301 USA
-/////////////////////////////////////////////////////////////////////////
+/*
+ *
+ *  Copyright (C) 2001-2012  The Bochs Project
+ *  Copyright (C) 2017 Google Inc.
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA B 02110-1301 USA
+ */
 /*
  * x86 eflags functions
  */
diff --git a/target/i386/hvf/x86_mmu.c b/target/i386/hvf/x86_mmu.c
index 65d4603..882a623 100644
--- a/target/i386/hvf/x86_mmu.c
+++ b/target/i386/hvf/x86_mmu.c
@@ -5,7 +5,7 @@
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This program is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/i386/hvf/x86_mmu.h b/target/i386/hvf/x86_mmu.h
index cd6e137..9ae8a54 100644
--- a/target/i386/hvf/x86_mmu.h
+++ b/target/i386/hvf/x86_mmu.h
@@ -5,7 +5,7 @@
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This program is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/i386/hvf/x86hvf.c b/target/i386/hvf/x86hvf.c
index 5cbcb32..f267698 100644
--- a/target/i386/hvf/x86hvf.c
+++ b/target/i386/hvf/x86hvf.c
@@ -6,7 +6,7 @@
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This program is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/i386/hvf/x86hvf.h b/target/i386/hvf/x86hvf.h
index 79539f7..860bd2e 100644
--- a/target/i386/hvf/x86hvf.h
+++ b/target/i386/hvf/x86hvf.h
@@ -5,7 +5,7 @@
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This program is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/i386/int_helper.c b/target/i386/int_helper.c
index 334469c..4f89436 100644
--- a/target/i386/int_helper.c
+++ b/target/i386/int_helper.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/i386/mem_helper.c b/target/i386/mem_helper.c
index 3a6d3ae..21ca3e3 100644
--- a/target/i386/mem_helper.c
+++ b/target/i386/mem_helper.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/i386/misc_helper.c b/target/i386/misc_helper.c
index b6b1d41..ae259d9 100644
--- a/target/i386/misc_helper.c
+++ b/target/i386/misc_helper.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/i386/mpx_helper.c b/target/i386/mpx_helper.c
index ade5d24..fd96617 100644
--- a/target/i386/mpx_helper.c
+++ b/target/i386/mpx_helper.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/i386/ops_sse.h b/target/i386/ops_sse.h
index c7614f8..6f1fc17 100644
--- a/target/i386/ops_sse.h
+++ b/target/i386/ops_sse.h
@@ -7,7 +7,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/i386/ops_sse_header.h b/target/i386/ops_sse_header.h
index 094aafc..6c0c849 100644
--- a/target/i386/ops_sse_header.h
+++ b/target/i386/ops_sse_header.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/i386/seg_helper.c b/target/i386/seg_helper.c
index b96de06..16311e5 100644
--- a/target/i386/seg_helper.c
+++ b/target/i386/seg_helper.c
@@ -7,7 +7,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/i386/shift_helper_template.h b/target/i386/shift_helper_template.h
index cf91a2d..54f15d6 100644
--- a/target/i386/shift_helper_template.h
+++ b/target/i386/shift_helper_template.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/i386/smm_helper.c b/target/i386/smm_helper.c
index eb5aa6e..d20e8ed 100644
--- a/target/i386/smm_helper.c
+++ b/target/i386/smm_helper.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/i386/svm_helper.c b/target/i386/svm_helper.c
index 6224387..3893158 100644
--- a/target/i386/svm_helper.c
+++ b/target/i386/svm_helper.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/i386/tcg-stub.c b/target/i386/tcg-stub.c
index b00e23d..8d45579 100644
--- a/target/i386/tcg-stub.c
+++ b/target/i386/tcg-stub.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/i386/translate.c b/target/i386/translate.c
index caea6f5..4c57307 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
-- 
2.17.1


