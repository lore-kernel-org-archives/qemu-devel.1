Return-Path: <SRS0=DnLG=2S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FA9EC2D0C8
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Dec 2019 23:12:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FEE72168B
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Dec 2019 23:12:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qiAIn3bK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FEE72168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ilLGU-0005Ya-1T
	for qemu-devel@archiver.kernel.org; Sat, 28 Dec 2019 18:12:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38739)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ilLFE-0004Do-Tv
 for qemu-devel@nongnu.org; Sat, 28 Dec 2019 18:11:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ilLFB-0003CI-7O
 for qemu-devel@nongnu.org; Sat, 28 Dec 2019 18:11:40 -0500
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:38953)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ilLFA-00037C-VH
 for qemu-devel@nongnu.org; Sat, 28 Dec 2019 18:11:37 -0500
Received: by mail-pl1-x642.google.com with SMTP id g6so10250666plp.6
 for <qemu-devel@nongnu.org>; Sat, 28 Dec 2019 15:11:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=bgWTTY8z0xp+JXJD0z4cLIj82JxbQOWmMs5uOXXKMys=;
 b=qiAIn3bKTkkg5MPlL/K5oC49KUI0enIxAr7iIwh+lL6ZJidJsVto1jGebImP9S8L2H
 AqWsj4GZ+oDj14zcHsN2RcZDzxigT9tuUNKNI4XWUZc2t5lKGvKxNd8QqDBQ+pgWRNTh
 sGjKdEw9kE/FrewmCcBlpS/oDuKa/U5vahFIuHgRNiiMPLxv0ApkEQvYQGKaCmtAKbqR
 mhEOrD25WyhRvOWxTfZ/joqc2n49k9dsjPvd8aGK/hW3vVlEIQq5nP0ta526bH3vuJHq
 VaPe+ikeTxYZRFoVLNJHhz5WqolK1q7aekLU89xdHMGLuu2tMOt0K+gQ+1I2azJaSdLt
 5XOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=bgWTTY8z0xp+JXJD0z4cLIj82JxbQOWmMs5uOXXKMys=;
 b=RoDclc96R/g+C41bcyNTwL2Ns6AybcSPOBYlHoZ0TceHEGHOjcFF/hGJm3a1FW/OSr
 Gf/rsTaPrZpsFHPvpfU6ksjyWuUyup87weREyK9axQaryzW5SvfWGJJkssZS+uAhaGUb
 YTKlSuvkTNVua7dYE33xg7fazzkkP/XDrgX+DuMhQd5E4bmmSmoZr3DUwt7fiMNpdZ9u
 kUC/cfNznDzC6z+QB71rpCF1hyXi1yhaFofZS0X1mGwQMf0x8dkeHyLHjLoYA7S0l2/j
 tYcoJ3565NeINbMogKpvjgJcpoImfPrYGcrJ5jOU6+MYgx6NkQRRBmOVSATTOGmorhfp
 pB5Q==
X-Gm-Message-State: APjAAAWAZw8nsVxtUyB/E25oWH+MdAr73ysOfr9+PnXWoUGEaUKl/8ga
 ZAkuzn/Ug9ltK7PpOQ8y9+NNZ6Kb2ks=
X-Google-Smtp-Source: APXvYqzZhh4E09ulUNDOsZh/BdTQzP2vtRWSs6WgVNnSY1wEa520T9gWUrC3NzbZmz+qoFWU7ou4nQ==
X-Received: by 2002:a17:902:8d95:: with SMTP id
 v21mr59852918plo.61.1577574695464; 
 Sat, 28 Dec 2019 15:11:35 -0800 (PST)
Received: from localhost.localdomain (194-223-58-9.tpgi.com.au. [194.223.58.9])
 by smtp.gmail.com with ESMTPSA id c18sm21077186pfr.40.2019.12.28.15.11.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Dec 2019 15:11:34 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 00/29] cputlb: Remove support for MMU_MODE*_SUFFIX
Date: Sun, 29 Dec 2019 10:10:55 +1100
Message-Id: <20191228231124.18307-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
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
Cc: Marek Vasut <marex@denx.de>, Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>,
 Chris Wulff <crwulff@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Guan Xuetao <gxt@mprc.pku.edu.cn>, Aurelien Jarno <aurelien@aurel32.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is part of a project to raise the limit on NB_MMU_MODES.

One of those is in cpu_ldst.h, in support of MMU_MODE*_SUFFIX.
While this could be extended, it's not the best interface for
such things.  Better is a single interface that allows a variable
mmu_idx.  The best exemplars of that is the usage in target/mips
and target/ppc.

In the process, I tried to clean up the implementation of these
functions for softmmu and user-only.

Aleksander asked about code size changes.  They vary between
a minor size increase (e.g. for qemu-system-alpha, where there
are in fact no uses of the functions, which are now present as
out-of-line functions rather than eliminated inline functions),
to a minor size decrease (e.g. -79k/-1.6% for qemu-system-i386).
See below for details.

Changes for v3:
  * Add patch to avoid breaking build for --enable-plugins.
  * Rebase on master and resolve conflicts.

Changes for v2:
  * Significantly revised docs/devel/loads-stores.rst.
  * m68k and s390x dropped #defines and use *_mmuidx_ra directly.

Patches lacking review:
0009-plugins-Include-trace-mem.h-in-api.c.patch
0010-cputlb-Move-body-of-cpu_ldst_template.h-out-of-li.patch


r~


Cc: Aleksandar Markovic <amarkovic@wavecomp.com>
Cc: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
Cc: Aurelien Jarno <aurelien@aurel32.net>
Cc: Chris Wulff <crwulff@gmail.com>
Cc: David Gibson <david@gibson.dropbear.id.au>
Cc: David Hildenbrand <david@redhat.com>
Cc: Edgar E. Iglesias <edgar.iglesias@gmail.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: Guan Xuetao <gxt@mprc.pku.edu.cn>
Cc: Laurent Vivier <laurent@vivier.eu>
Cc: Marek Vasut <marex@denx.de>
Cc: Max Filippov <jcmvbkbc@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>

Richard Henderson (29):
  target/xtensa: Use probe_access for itlb_hit_test
  cputlb: Use trace_mem_get_info instead of trace_mem_build_info
  trace: Remove trace_mem_build_info_no_se_[bl]e
  target/s390x: Include tcg.h in mem_helper.c
  target/arm: Include tcg.h in sve_helper.c
  accel/tcg: Include tcg.h in tcg-runtime.c
  linux-user: Include tcg.h in syscall.c
  linux-user: Include trace-root.h in syscall-trace.h
  plugins: Include trace/mem.h in api.c
  cputlb: Move body of cpu_ldst_template.h out of line
  translator: Use cpu_ld*_code instead of open-coding
  cputlb: Rename helper_ret_ld*_cmmu to cpu_ld*_code
  cputlb: Provide cpu_(ld,st}*_mmuidx_ra for user-only
  target/i386: Use cpu_*_mmuidx_ra instead of templates
  cputlb: Expand cpu_ldst_useronly_template.h in user-exec.c
  target/nios2: Remove MMU_MODE{0,1}_SUFFIX
  target/alpha: Remove MMU_MODE{0,1}_SUFFIX
  target/cris: Remove MMU_MODE{0,1}_SUFFIX
  target/i386: Remove MMU_MODE{0,1,2}_SUFFIX
  target/microblaze: Remove MMU_MODE{0,1,2}_SUFFIX
  target/sh4: Remove MMU_MODE{0,1}_SUFFIX
  target/unicore32: Remove MMU_MODE{0,1}_SUFFIX
  target/xtensa: Remove MMU_MODE{0,1,2,3}_SUFFIX
  target/m68k: Use cpu_*_mmuidx_ra instead of MMU_MODE{0,1}_SUFFIX
  target/mips: Use cpu_*_mmuidx_ra instead of MMU_MODE*_SUFFIX
  target/s390x: Use cpu_*_mmuidx_ra instead of MMU_MODE*_SUFFIX
  target/ppc: Use cpu_*_mmuidx_ra instead of MMU_MODE*_SUFFIX
  cputlb: Remove support for MMU_MODE*_SUFFIX
  cputlb: Expand cpu_ldst_template.h in cputlb.c

 accel/tcg/atomic_template.h               |  67 ++--
 include/exec/cpu_ldst.h                   | 444 +++++++---------------
 include/exec/cpu_ldst_template.h          | 211 ----------
 include/exec/cpu_ldst_useronly_template.h | 159 --------
 include/exec/translator.h                 |  48 +--
 include/user/syscall-trace.h              |   2 +
 target/alpha/cpu.h                        |   2 -
 target/cris/cpu.h                         |   2 -
 target/i386/cpu.h                         |   3 -
 target/m68k/cpu.h                         |   2 -
 target/microblaze/cpu.h                   |   3 -
 target/mips/cpu.h                         |   4 -
 target/nios2/cpu.h                        |   2 -
 target/ppc/cpu.h                          |   2 -
 target/s390x/cpu.h                        |   5 -
 target/sh4/cpu.h                          |   2 -
 target/unicore32/cpu.h                    |   2 -
 target/xtensa/cpu.h                       |   4 -
 tcg/tcg.h                                 |  29 --
 trace/mem-internal.h                      |  17 -
 accel/tcg/cputlb.c                        | 315 +++++++++++----
 accel/tcg/tcg-runtime.c                   |   1 +
 accel/tcg/user-exec.c                     | 236 ++++++++++++
 linux-user/syscall.c                      |   1 +
 plugins/api.c                             |   2 +
 target/arm/sve_helper.c                   |   1 +
 target/i386/seg_helper.c                  |  56 +--
 target/m68k/op_helper.c                   |  77 ++--
 target/mips/op_helper.c                   | 182 +++------
 target/ppc/mem_helper.c                   |  11 +-
 target/s390x/mem_helper.c                 |  11 +-
 target/xtensa/mmu_helper.c                |   5 +-
 docs/devel/loads-stores.rst               | 215 ++++++++---
 33 files changed, 961 insertions(+), 1162 deletions(-)
 delete mode 100644 include/exec/cpu_ldst_template.h
 delete mode 100644 include/exec/cpu_ldst_useronly_template.h

-- 
2.20.1


