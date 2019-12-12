Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD9AAC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 04:05:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7CF62173E
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 04:05:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mQVHAd+B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7CF62173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifFjV-000666-CP
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 23:05:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47375)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ifFeh-0000mb-Ar
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 23:00:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ifFed-0003py-VG
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 23:00:47 -0500
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535]:39057)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ifFed-0003mp-GP
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 23:00:43 -0500
Received: by mail-pg1-x535.google.com with SMTP id b137so431644pga.6
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2019 20:00:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=W/IrtrUk4g6Dwcqz2tLntq918adD2bGYeEMjuC4fyfU=;
 b=mQVHAd+BwxgklYnel0XpxkwrERfid/9HfybVC3HaJm8FnxS7kMlcu4DnX7g//WlySr
 5i3larzYs+uM172LVd4V18X+aRnzlrhV6nH2jhGmEg9+bB+kW4jGToduMfgk90T+rgdX
 kYg+6EcELxmEC/1f0si+U4WBaD04T2rhIeJZIL3bubS0Ym8YvhYQZEo5/UL/TBZ8+L1q
 j0RtuGneZ+MOLfDKJlPDGwG+iSFnWk6Vi7fRMODirY4xGKNyOIerpshbnf5vQcGD0/r0
 urI7yFsxwcm+YEbyM9SKQICKotaps1MtklWy/av/tjvHrxv7vizGZqA4VQv05DKyaU4i
 dDBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=W/IrtrUk4g6Dwcqz2tLntq918adD2bGYeEMjuC4fyfU=;
 b=gxewESHs3oSmU8lKy8ayq184xjMJIZvkqjjfg32ADOI4uz2+dwkpp3pVmVbJmG8+rc
 bHwN1rhC7o3sxBhz7bSZ9zlZWm24Msoo4BBueVnVGW3kmPvEagCeLWmGS36FKesHo0Q+
 BfEvlJ0T3drtVLDNIhc6nOfU5zZEuDpzKU2jTc/c+2CLZo5HUODExGURNfxRYEkg4+UA
 uq4C0DfcUftjmuln5kIHPMqp86sbLJ/cZ3SYjRz3EGSFUzY7+H+JtlkFnw1HAqaZnOMf
 bvhaUbjV2WcTzvGzhih1QFbD0W7j9jCFl7Unpu8KlT1L7seSdplXmnd1JExBpyBlt/P/
 Lupg==
X-Gm-Message-State: APjAAAXmFpP0q5gle6hpxi7o6RBLD+zQWnZF3msLR3G6b2z8OlvlDtqA
 3+bCo6DbDZSKfDIRMt6p6ElYbBFJlFo=
X-Google-Smtp-Source: APXvYqz4ARl5h2k+YBfYYvs3T2t5v90E/pjzrQjPRVGrNNWdyw7uDzBS1CRf5Xl8IshK5QweKQreog==
X-Received: by 2002:a62:b402:: with SMTP id h2mr7541642pfn.55.1576123241427;
 Wed, 11 Dec 2019 20:00:41 -0800 (PST)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id z130sm4666391pgz.6.2019.12.11.20.00.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2019 20:00:40 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 00/28] cputlb: Remove support for MMU_MODE*_SUFFIX
Date: Wed, 11 Dec 2019 20:00:11 -0800
Message-Id: <20191212040039.26546-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::535
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


Richard Henderson (28):
  target/xtensa: Use probe_access for itlb_hit_test
  cputlb: Use trace_mem_get_info instead of trace_mem_build_info
  trace: Remove trace_mem_build_info_no_se_[bl]e
  cputlb: Move body of cpu_ldst_template.h out of line
  translator: Use cpu_ld*_code instead of open-coding
  cputlb: Rename helper_ret_ld*_cmmu to cpu_ld*_code
  cputlb: Provide cpu_(ld,st}*_mmuidx_ra for user-only
  target/i386: Use cpu_*_mmuidx_ra instead of templates
  target/s390x: Include tcg.h in mem_helper.c
  target/arm: Include tcg.h in sve_helper.c
  accel/tcg: Include tcg.h in tcg-runtime.c
  linux-user: Include tcg.h in syscall.c
  linux-user: Include trace-root.h in syscall-trace.h
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
 include/exec/cpu_ldst.h                   | 448 +++++++---------------
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
 target/arm/sve_helper.c                   |   1 +
 target/i386/seg_helper.c                  |  75 ++--
 target/m68k/op_helper.c                   |   5 +
 target/mips/op_helper.c                   | 182 +++------
 target/ppc/mem_helper.c                   |  11 +-
 target/s390x/mem_helper.c                 |   6 +
 target/xtensa/mmu_helper.c                |   5 +-
 docs/devel/loads-stores.rst               |   4 +-
 32 files changed, 788 insertions(+), 1068 deletions(-)
 delete mode 100644 include/exec/cpu_ldst_template.h
 delete mode 100644 include/exec/cpu_ldst_useronly_template.h

-- 
2.20.1


