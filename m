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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B1F8C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 06:49:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB17C22245
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 06:49:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r1Tt1GSL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB17C22245
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQmDV-0008BY-Th
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 02:49:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55874)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chetan4windows@gmail.com>)
 id 1kQm8P-00045d-V9; Fri, 09 Oct 2020 02:44:09 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:44094)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chetan4windows@gmail.com>)
 id 1kQm8L-00010W-Er; Fri, 09 Oct 2020 02:44:09 -0400
Received: by mail-pf1-x441.google.com with SMTP id f19so6013172pfj.11;
 Thu, 08 Oct 2020 23:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=SD/Q3ImV6f6F9bHelbmtIGTurg8/TN9kNohb9uG2E5I=;
 b=r1Tt1GSLv5kdbdjE2C8hWk/UImBj4XmSOx05R19n2a7Jgp5hVY8VXHAIpLPTmFOY51
 bP5i981xgBHbFMj4aF+mln91zjRMr1ZJfGby5MRbCMgkdRBzimJ+AAwO7WllDwgWI1Sm
 4/Adxi+jOCbsfDI6zTVDl9Hkqu6eq8Rxv8jI/KxKUiWKn58627vGbyMRpFHo1ZH9juw7
 LV44lsJR1V8S97Ek3/g0HSU2OCsPI2qKgJFsZiuXvUKT+LVE2Fl1F3Fi3wuPbGixXRv7
 F02iUAogiUnTsOfBP0lUNkT5Slu47WGQtAG888Z3QqRs4b99a2s/QsnfD+/cfzUsksJx
 cZxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=SD/Q3ImV6f6F9bHelbmtIGTurg8/TN9kNohb9uG2E5I=;
 b=qK+ddHl3wQ7a0GeRnXp8JAu8q+Sg90PEaYR1YhiGtgqNiVaT/B4OIqyyzwlyPceyHx
 IyDbEWUb7GVHaN6pv1g93jdXxC5o31IjUt5Nedy0QGRM1Sbl8XQwIC3BlQvhecbtTAWm
 qkn4w6nObnmJxFMaHZJ2jfXZLLfJYkvuQ6KbFR65bSFzW4KEjZfmQUPFtaWxa+Kl/f4h
 JHGM3QcC2uJCuFerhyCH54Sq+7jVCTPZ8ciDr9aHhWvOLArtIeF1NEi3OAVz0j+oDoY4
 K4HG7mSc+6WVpgbV7upuNv4wFL4M/K7UdgGK21z9kM4egh7bqhiFW+4UkLtqgo3bMrXA
 uQnQ==
X-Gm-Message-State: AOAM531p4s28yadw2flK43eKrR7FmG4GmAxFKAiMoGItvS9AnFfCntIq
 H47MoHC39hr+IwtIuohl3u4oDJlSxjErgmId
X-Google-Smtp-Source: ABdhPJz94L6vhzSb5ZGWKDoYmlRDOeuU+bkYH+QNAdo/+tH3fqF5UtLsQHPS2N6ymxL+V6HOJQDMMg==
X-Received: by 2002:a65:63c5:: with SMTP id n5mr2309362pgv.437.1602225842042; 
 Thu, 08 Oct 2020 23:44:02 -0700 (PDT)
Received: from pulp100.localdomain ([103.199.158.131])
 by smtp.gmail.com with ESMTPSA id ck21sm9493818pjb.56.2020.10.08.23.43.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2020 23:44:01 -0700 (PDT)
From: Chetan Pant <chetan4windows@gmail.com>
To: qemu-trivial@nongnu.org
Subject: [PATCH 4/5] Fixing Lesser GPL version number [4/5]
Date: Fri,  9 Oct 2020 06:42:46 +0000
Message-Id: <20201009064246.2865-1-chetan4windows@gmail.com>
X-Mailer: git-send-email 2.17.1
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=chetan4windows@gmail.com; helo=mail-pf1-x441.google.com
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
	[ ] Files inside target/ 'alpha,arm,cris,hppa,i386' (96 files)
	[*] Files inside target/ 'lm32,microblaze,mips,ppc,rx,sparc,tilegx,tricore,xtensa' (63 files)
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
 target/lm32/cpu.h                |  2 +-
 target/lm32/gdbstub.c            |  2 +-
 target/lm32/helper.c             |  2 +-
 target/lm32/translate.c          |  2 +-
 target/microblaze/cpu.h          |  2 +-
 target/microblaze/gdbstub.c      |  2 +-
 target/microblaze/helper.c       |  2 +-
 target/microblaze/machine.c      |  2 +-
 target/microblaze/mmu.c          |  2 +-
 target/microblaze/mmu.h          |  2 +-
 target/microblaze/op_helper.c    |  2 +-
 target/microblaze/translate.c    |  2 +-
 target/mips/cp0_helper.c         |  2 +-
 target/mips/dsp_helper.c         |  2 +-
 target/mips/fpu_helper.c         |  2 +-
 target/mips/gdbstub.c            |  2 +-
 target/mips/helper.c             |  2 +-
 target/mips/lmmi_helper.c        |  2 +-
 target/mips/mips-semi.c          |  2 +-
 target/mips/msa_helper.c         |  2 +-
 target/mips/op_helper.c          |  2 +-
 target/mips/translate.c          |  2 +-
 target/mips/translate_init.c.inc |  2 +-
 target/ppc/compat.c              |  2 +-
 target/ppc/cpu-models.c          |  2 +-
 target/ppc/cpu-models.h          |  2 +-
 target/ppc/cpu.c                 |  2 +-
 target/ppc/cpu.h                 |  2 +-
 target/ppc/dfp_helper.c          |  2 +-
 target/ppc/excp_helper.c         |  2 +-
 target/ppc/fpu_helper.c          |  2 +-
 target/ppc/gdbstub.c             |  2 +-
 target/ppc/helper_regs.h         |  2 +-
 target/ppc/int_helper.c          |  2 +-
 target/ppc/internal.h            |  2 +-
 target/ppc/mem_helper.c          |  2 +-
 target/ppc/misc_helper.c         |  2 +-
 target/ppc/mmu-book3s-v3.c       |  2 +-
 target/ppc/mmu-book3s-v3.h       |  2 +-
 target/ppc/mmu-hash32.c          |  2 +-
 target/ppc/mmu-hash64.c          |  2 +-
 target/ppc/mmu-radix64.c         |  2 +-
 target/ppc/mmu_helper.c          |  2 +-
 target/ppc/timebase_helper.c     |  2 +-
 target/ppc/translate.c           |  2 +-
 target/ppc/translate_init.c.inc  |  2 +-
 target/ppc/user_only_helper.c    |  2 +-
 target/rx/insns.decode           |  2 +-
 target/sparc/cc_helper.c         |  2 +-
 target/sparc/cpu.c               |  2 +-
 target/sparc/fop_helper.c        |  2 +-
 target/sparc/gdbstub.c           |  2 +-
 target/sparc/helper.c            |  2 +-
 target/sparc/int32_helper.c      |  2 +-
 target/sparc/int64_helper.c      |  2 +-
 target/sparc/ldst_helper.c       |  2 +-
 target/sparc/mmu_helper.c        |  2 +-
 target/sparc/translate.c         | 34 ++++++++++++++++----------------
 target/sparc/vis_helper.c        |  2 +-
 target/sparc/win_helper.c        |  2 +-
 target/tilegx/cpu.h              |  2 +-
 target/tricore/gdbstub.c         |  2 +-
 target/xtensa/gdbstub.c          |  2 +-
 63 files changed, 79 insertions(+), 79 deletions(-)

diff --git a/target/lm32/cpu.h b/target/lm32/cpu.h
index 01d408e..ea7c01c 100644
--- a/target/lm32/cpu.h
+++ b/target/lm32/cpu.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/lm32/gdbstub.c b/target/lm32/gdbstub.c
index b6fe12e..56f508a 100644
--- a/target/lm32/gdbstub.c
+++ b/target/lm32/gdbstub.c
@@ -7,7 +7,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/lm32/helper.c b/target/lm32/helper.c
index 1130fc8..7c52ae7 100644
--- a/target/lm32/helper.c
+++ b/target/lm32/helper.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/lm32/translate.c b/target/lm32/translate.c
index e583d52..030b232 100644
--- a/target/lm32/translate.c
+++ b/target/lm32/translate.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index 297b368..c1c2641 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/microblaze/gdbstub.c b/target/microblaze/gdbstub.c
index be39fd4..2e6e070 100644
--- a/target/microblaze/gdbstub.c
+++ b/target/microblaze/gdbstub.c
@@ -7,7 +7,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/microblaze/helper.c b/target/microblaze/helper.c
index 3d6ce1b..cda14a1 100644
--- a/target/microblaze/helper.c
+++ b/target/microblaze/helper.c
@@ -7,7 +7,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/microblaze/machine.c b/target/microblaze/machine.c
index acdb8d0..c2074bb 100644
--- a/target/microblaze/machine.c
+++ b/target/microblaze/machine.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/microblaze/mmu.c b/target/microblaze/mmu.c
index 1dbbb27..2baaef7 100644
--- a/target/microblaze/mmu.c
+++ b/target/microblaze/mmu.c
@@ -7,7 +7,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/microblaze/mmu.h b/target/microblaze/mmu.h
index 7d0fbb8..09e4075 100644
--- a/target/microblaze/mmu.h
+++ b/target/microblaze/mmu.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/microblaze/op_helper.c b/target/microblaze/op_helper.c
index 757f3ff..58d6335 100644
--- a/target/microblaze/op_helper.c
+++ b/target/microblaze/op_helper.c
@@ -7,7 +7,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index abfcc7e..c1b13f4 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -7,7 +7,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/mips/cp0_helper.c b/target/mips/cp0_helper.c
index de64add..a950946 100644
--- a/target/mips/cp0_helper.c
+++ b/target/mips/cp0_helper.c
@@ -8,7 +8,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/mips/dsp_helper.c b/target/mips/dsp_helper.c
index 8c58eeb..09b6e5f 100644
--- a/target/mips/dsp_helper.c
+++ b/target/mips/dsp_helper.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/mips/fpu_helper.c b/target/mips/fpu_helper.c
index 56beda4..ffaac3c 100644
--- a/target/mips/fpu_helper.c
+++ b/target/mips/fpu_helper.c
@@ -8,7 +8,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/mips/gdbstub.c b/target/mips/gdbstub.c
index 98f56e6..e39f8d7 100644
--- a/target/mips/gdbstub.c
+++ b/target/mips/gdbstub.c
@@ -7,7 +7,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/mips/helper.c b/target/mips/helper.c
index afd78b1..063b65c 100644
--- a/target/mips/helper.c
+++ b/target/mips/helper.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/mips/lmmi_helper.c b/target/mips/lmmi_helper.c
index 6c645cf..abeb773 100644
--- a/target/mips/lmmi_helper.c
+++ b/target/mips/lmmi_helper.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/mips/mips-semi.c b/target/mips/mips-semi.c
index 10a710c..898251a 100644
--- a/target/mips/mips-semi.c
+++ b/target/mips/mips-semi.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/mips/msa_helper.c b/target/mips/msa_helper.c
index 6865add..249f0fd 100644
--- a/target/mips/msa_helper.c
+++ b/target/mips/msa_helper.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/mips/op_helper.c b/target/mips/op_helper.c
index 9552b28..bbd0bf6 100644
--- a/target/mips/op_helper.c
+++ b/target/mips/op_helper.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/mips/translate.c b/target/mips/translate.c
index 398edf7..3a6bd1e 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -10,7 +10,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/mips/translate_init.c.inc b/target/mips/translate_init.c.inc
index 637cacc..4f24443 100644
--- a/target/mips/translate_init.c.inc
+++ b/target/mips/translate_init.c.inc
@@ -7,7 +7,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/ppc/compat.c b/target/ppc/compat.c
index 08aede8..dd56025 100644
--- a/target/ppc/compat.c
+++ b/target/ppc/compat.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/ppc/cpu-models.c b/target/ppc/cpu-models.c
index 4ad1686..87e4228 100644
--- a/target/ppc/cpu-models.c
+++ b/target/ppc/cpu-models.c
@@ -8,7 +8,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/ppc/cpu-models.h b/target/ppc/cpu-models.h
index ce750b2..fc5e217 100644
--- a/target/ppc/cpu-models.h
+++ b/target/ppc/cpu-models.h
@@ -8,7 +8,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/ppc/cpu.c b/target/ppc/cpu.c
index 2801166..e501a7f 100644
--- a/target/ppc/cpu.c
+++ b/target/ppc/cpu.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 766e9c5..9e108ed 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/ppc/dfp_helper.c b/target/ppc/dfp_helper.c
index 2c65bad..07341a6 100644
--- a/target/ppc/dfp_helper.c
+++ b/target/ppc/dfp_helper.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index a988ba1..8429bf6 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
index ae43b08..ccc155a 100644
--- a/target/ppc/fpu_helper.c
+++ b/target/ppc/fpu_helper.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/ppc/gdbstub.c b/target/ppc/gdbstub.c
index 5c11c88..01459dd 100644
--- a/target/ppc/gdbstub.c
+++ b/target/ppc/gdbstub.c
@@ -7,7 +7,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/ppc/helper_regs.h b/target/ppc/helper_regs.h
index d78c2af..efcc903 100644
--- a/target/ppc/helper_regs.h
+++ b/target/ppc/helper_regs.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
index b45626f..0b682a1 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/ppc/internal.h b/target/ppc/internal.h
index 15d655b..6104940 100644
--- a/target/ppc/internal.h
+++ b/target/ppc/internal.h
@@ -4,7 +4,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/ppc/mem_helper.c b/target/ppc/mem_helper.c
index 98f5895..f4f7e73 100644
--- a/target/ppc/mem_helper.c
+++ b/target/ppc/mem_helper.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/ppc/misc_helper.c b/target/ppc/misc_helper.c
index e43a3b4..5d6e0de 100644
--- a/target/ppc/misc_helper.c
+++ b/target/ppc/misc_helper.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/ppc/mmu-book3s-v3.c b/target/ppc/mmu-book3s-v3.c
index 32b8c16..c78fd8d 100644
--- a/target/ppc/mmu-book3s-v3.c
+++ b/target/ppc/mmu-book3s-v3.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/ppc/mmu-book3s-v3.h b/target/ppc/mmu-book3s-v3.h
index 0f3c9d0..7b89be5 100644
--- a/target/ppc/mmu-book3s-v3.h
+++ b/target/ppc/mmu-book3s-v3.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/ppc/mmu-hash32.c b/target/ppc/mmu-hash32.c
index 55cf156..178cf09 100644
--- a/target/ppc/mmu-hash32.c
+++ b/target/ppc/mmu-hash32.c
@@ -7,7 +7,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
index c31d21e..46061e9 100644
--- a/target/ppc/mmu-hash64.c
+++ b/target/ppc/mmu-hash64.c
@@ -7,7 +7,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/ppc/mmu-radix64.c b/target/ppc/mmu-radix64.c
index c60bf31..30fcfcf 100644
--- a/target/ppc/mmu-radix64.c
+++ b/target/ppc/mmu-radix64.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
index 8972714..ed74144 100644
--- a/target/ppc/mmu_helper.c
+++ b/target/ppc/mmu_helper.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/ppc/timebase_helper.c b/target/ppc/timebase_helper.c
index d16360a..8ff4080 100644
--- a/target/ppc/timebase_helper.c
+++ b/target/ppc/timebase_helper.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index fedb9b2..54cac0e 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -7,7 +7,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/ppc/translate_init.c.inc b/target/ppc/translate_init.c.inc
index bb66526..c765803 100644
--- a/target/ppc/translate_init.c.inc
+++ b/target/ppc/translate_init.c.inc
@@ -7,7 +7,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/ppc/user_only_helper.c b/target/ppc/user_only_helper.c
index 683c033..aa3f867 100644
--- a/target/ppc/user_only_helper.c
+++ b/target/ppc/user_only_helper.c
@@ -7,7 +7,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/rx/insns.decode b/target/rx/insns.decode
index 232a61f..ca9334b 100644
--- a/target/rx/insns.decode
+++ b/target/rx/insns.decode
@@ -7,7 +7,7 @@
 # This library is free software; you can redistribute it and/or
 # modify it under the terms of the GNU Lesser General Public
 # License as published by the Free Software Foundation; either
-# version 2 of the License, or (at your option) any later version.
+# version 2.1 of the License, or (at your option) any later version.
 #
 # This library is distributed in the hope that it will be useful,
 # but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/sparc/cc_helper.c b/target/sparc/cc_helper.c
index a410a0b..7ad5b9b 100644
--- a/target/sparc/cc_helper.c
+++ b/target/sparc/cc_helper.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index cf21efd..701e794 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/sparc/fop_helper.c b/target/sparc/fop_helper.c
index e6dd3fc..f54fa9b 100644
--- a/target/sparc/fop_helper.c
+++ b/target/sparc/fop_helper.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/sparc/gdbstub.c b/target/sparc/gdbstub.c
index 78dc8dc..5d1e808 100644
--- a/target/sparc/gdbstub.c
+++ b/target/sparc/gdbstub.c
@@ -7,7 +7,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/sparc/helper.c b/target/sparc/helper.c
index 07d87ef..c7bcaa3 100644
--- a/target/sparc/helper.c
+++ b/target/sparc/helper.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/sparc/int32_helper.c b/target/sparc/int32_helper.c
index 9a71e1a..e1c4f9f 100644
--- a/target/sparc/int32_helper.c
+++ b/target/sparc/int32_helper.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/sparc/int64_helper.c b/target/sparc/int64_helper.c
index f3e7f32..ba95bf2 100644
--- a/target/sparc/int64_helper.c
+++ b/target/sparc/int64_helper.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/sparc/ldst_helper.c b/target/sparc/ldst_helper.c
index e91cfde..22327d7 100644
--- a/target/sparc/ldst_helper.c
+++ b/target/sparc/ldst_helper.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/sparc/mmu_helper.c b/target/sparc/mmu_helper.c
index afbfba7..a44473a 100644
--- a/target/sparc/mmu_helper.c
+++ b/target/sparc/mmu_helper.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 1a4efd4..e78bf00 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -1,21 +1,21 @@
 /*
-   SPARC translation
-
-   Copyright (C) 2003 Thomas M. Ogrisegg <tom@fnord.at>
-   Copyright (C) 2003-2005 Fabrice Bellard
-
-   This library is free software; you can redistribute it and/or
-   modify it under the terms of the GNU Lesser General Public
-   License as published by the Free Software Foundation; either
-   version 2 of the License, or (at your option) any later version.
-
-   This library is distributed in the hope that it will be useful,
-   but WITHOUT ANY WARRANTY; without even the implied warranty of
-   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-   Lesser General Public License for more details.
-
-   You should have received a copy of the GNU Lesser General Public
-   License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ * SPARC translation
+ *
+ * Copyright (C) 2003 Thomas M. Ogrisegg <tom@fnord.at>
+ * Copyright (C) 2003-2005 Fabrice Bellard
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #include "qemu/osdep.h"
diff --git a/target/sparc/vis_helper.c b/target/sparc/vis_helper.c
index 8a9b763..f917e59 100644
--- a/target/sparc/vis_helper.c
+++ b/target/sparc/vis_helper.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/sparc/win_helper.c b/target/sparc/win_helper.c
index 8290a21..5b57892 100644
--- a/target/sparc/win_helper.c
+++ b/target/sparc/win_helper.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/tilegx/cpu.h b/target/tilegx/cpu.h
index c194c1a..7d8e44d 100644
--- a/target/tilegx/cpu.h
+++ b/target/tilegx/cpu.h
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/tricore/gdbstub.c b/target/tricore/gdbstub.c
index 0f4e612..3ce55ab 100644
--- a/target/tricore/gdbstub.c
+++ b/target/tricore/gdbstub.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/target/xtensa/gdbstub.c b/target/xtensa/gdbstub.c
index 4d43f13..b669606 100644
--- a/target/xtensa/gdbstub.c
+++ b/target/xtensa/gdbstub.c
@@ -7,7 +7,7 @@
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


