Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D909C32771
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 01:41:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBCE820723
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 01:41:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EYeWn2pr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBCE820723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iruAF-0003nb-Vs
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 20:41:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38881)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iru9d-0003Nc-HC
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 20:41:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iru9b-0006wz-0O
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 20:41:01 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:33221)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iru9Z-0006w5-M5
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 20:40:58 -0500
Received: by mail-pf1-x443.google.com with SMTP id z16so9404936pfk.0
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2020 17:40:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=056HDOqBW4S89DzFV+nVe/lBjeRwncmyfq9hgOx4+bg=;
 b=EYeWn2prSX9gMF3T79oBi6c2lSbqQFDoQSgZUhEdoZDItoNGqaAOozmURYf5jmQbZN
 IRaseMahh0DE6qMCD2TgS9Tu1J6srhee301beAmhSWQUIot7fL0DHhoXaLDxqQ8wh8nQ
 D5kbirZIaEQvC1lsi9nWRKSCNj3kxZ1wjBVjRtKkBj8JP4Wm9gMyfTYlLBPMJ/OXv16L
 Qi9Yh8AcOUsS89ZzFl18eWS8BB0GA+ltRWv4w2qFcnjRg6GVy5tuhUkQjBSNYsvhjfYZ
 jh7ch3Jj0xl+d3e3zGDVTjkwsaOBgGzlkQ0OK6DFAB6vUvZ5owq0lF7lUjqQrePa620a
 zfbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=056HDOqBW4S89DzFV+nVe/lBjeRwncmyfq9hgOx4+bg=;
 b=da27Vh4RhpjtNeDqbMyHn15gR6TtO658gIXGRfbTa05n8Soo9SyLRbaNCHnpU5sU/2
 D1NnJUf8tLhoICi0e8kHRamL7BW0k/o+YQ9Q4N/dbKgOzYy8a70rEK90I1MTXB0LVHXe
 I7yHdAEARapc65+V6m/usqqgT3GW9foDA2HEMPPiW5A8cfRTinVyOQKk0j31EkXXT22X
 6bVVHWx9tzYONc9ZjvGeL5rgjfqJVdRa8oUXrEV2rX2VWkKRZAZKkVHdITBd3XRiAJNK
 BD6tBxrUNFQUN6LPIA/kq2B4cfL8PHG64esRlM2Na9hWS5JKVc3DKr0lWz2CA75P+MMk
 OOjA==
X-Gm-Message-State: APjAAAVPCmEv3sGeOyV0jsYi2uVnuSbU2kV8RyEM74XbiTf+0wn5CVE1
 aLLyOhJ3gbk8PY83IjHMewCzKfRZsvI=
X-Google-Smtp-Source: APXvYqxhCpLpnExoeV5t02+iiSh+SLMST9uO6vQGIfY7fuSO2E9ruMpFVqqbtW+1oxkQ06x5F2PdDA==
X-Received: by 2002:a63:e911:: with SMTP id i17mr36589982pgh.42.1579138855725; 
 Wed, 15 Jan 2020 17:40:55 -0800 (PST)
Received: from cloudburst.ASUS (rrcs-66-91-136-155.west.biz.rr.com.
 [66.91.136.155])
 by smtp.gmail.com with ESMTPSA id b19sm22598271pfo.56.2020.01.15.17.40.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2020 17:40:54 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL v2 00/34] tcg patch queue
Date: Wed, 15 Jan 2020 15:40:52 -1000
Message-Id: <20200116014052.17069-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

For version 2, drop the -static and -pie changes,
i.e. patches 1-7 from version 1.

I'll come back to those after the required linux-user changes are
upstream.  In the meantime, it's still a large enough set of patches.


r~



The following changes since commit 3a63b24a1bbf166e6f455fe43a6bbd8dea413d92:

  Merge remote-tracking branch 'remotes/kraxel/tags/ui-20200114-pull-request' into staging (2020-01-14 16:00:31 +0000)

are available in the Git repository at:

  https://github.com/rth7680/qemu.git tags/pull-tcg-20200115

for you to fetch changes up to 3e5a01ef0268ee4c9d342a26dbf6624d6b5b20d6:

  MAINTAINERS: Replace Claudio Fontana for tcg/aarch64 (2020-01-15 15:13:10 -1000)

----------------------------------------------------------------
Add cpu_{ld,st}*_mmuidx_ra
Remove MMU_MODE*_SUFFIX
Move tcg headers under include/

----------------------------------------------------------------
Philippe Mathieu-Daudé (4):
      tcg: Search includes from the project root source directory
      tcg: Search includes in the parent source directory
      tcg: Move TCG headers to include/tcg/
      configure: Remove tcg/ from the preprocessor include search list

Richard Henderson (30):
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
      MAINTAINERS: Replace Claudio Fontana for tcg/aarch64

 accel/tcg/atomic_template.h               |  67 ++---
 include/exec/cpu_ldst.h                   | 446 +++++++++---------------------
 include/exec/cpu_ldst_template.h          | 211 --------------
 include/exec/cpu_ldst_useronly_template.h | 159 -----------
 include/exec/translator.h                 |  48 +---
 {tcg => include/tcg}/tcg-gvec-desc.h      |   0
 {tcg => include/tcg}/tcg-mo.h             |   0
 {tcg => include/tcg}/tcg-op-gvec.h        |   0
 {tcg => include/tcg}/tcg-op.h             |   2 +-
 {tcg => include/tcg}/tcg-opc.h            |   0
 {tcg => include/tcg}/tcg.h                |  33 +--
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
 tcg/i386/tcg-target.h                     |   2 +-
 trace/mem-internal.h                      |  17 --
 accel/tcg/cpu-exec.c                      |   2 +-
 accel/tcg/cputlb.c                        | 315 ++++++++++++++++-----
 accel/tcg/tcg-runtime-gvec.c              |   2 +-
 accel/tcg/tcg-runtime.c                   |   1 +
 accel/tcg/translate-all.c                 |   2 +-
 accel/tcg/user-exec.c                     | 238 +++++++++++++++-
 bsd-user/main.c                           |   2 +-
 cpus.c                                    |   2 +-
 exec.c                                    |   2 +-
 linux-user/main.c                         |   2 +-
 linux-user/syscall.c                      |   1 +
 plugins/api.c                             |   1 +
 target/alpha/translate.c                  |   2 +-
 target/arm/helper-a64.c                   |   2 +-
 target/arm/sve_helper.c                   |   1 +
 target/arm/translate-a64.c                |   4 +-
 target/arm/translate-sve.c                |   6 +-
 target/arm/translate.c                    |   4 +-
 target/cris/translate.c                   |   2 +-
 target/hppa/translate.c                   |   2 +-
 target/i386/mem_helper.c                  |   2 +-
 target/i386/seg_helper.c                  |  56 ++--
 target/i386/translate.c                   |   2 +-
 target/lm32/translate.c                   |   2 +-
 target/m68k/op_helper.c                   |  77 ++++--
 target/m68k/translate.c                   |   2 +-
 target/microblaze/translate.c             |   2 +-
 target/mips/op_helper.c                   | 182 ++++--------
 target/mips/translate.c                   |   2 +-
 target/moxie/translate.c                  |   2 +-
 target/nios2/translate.c                  |   2 +-
 target/openrisc/translate.c               |   2 +-
 target/ppc/mem_helper.c                   |  13 +-
 target/ppc/translate.c                    |   4 +-
 target/riscv/cpu_helper.c                 |   2 +-
 target/riscv/translate.c                  |   2 +-
 target/s390x/mem_helper.c                 |  11 +-
 target/s390x/translate.c                  |   4 +-
 target/sh4/translate.c                    |   2 +-
 target/sparc/ldst_helper.c                |   2 +-
 target/sparc/translate.c                  |   2 +-
 target/tilegx/translate.c                 |   2 +-
 target/tricore/translate.c                |   2 +-
 target/unicore32/translate.c              |   2 +-
 target/xtensa/mmu_helper.c                |   5 +-
 target/xtensa/translate.c                 |   2 +-
 tcg/aarch64/tcg-target.inc.c              |   4 +-
 tcg/arm/tcg-target.inc.c                  |   4 +-
 tcg/i386/tcg-target.inc.c                 |   4 +-
 tcg/mips/tcg-target.inc.c                 |   2 +-
 tcg/optimize.c                            |   2 +-
 tcg/ppc/tcg-target.inc.c                  |   4 +-
 tcg/riscv/tcg-target.inc.c                |   4 +-
 tcg/s390/tcg-target.inc.c                 |   4 +-
 tcg/sparc/tcg-target.inc.c                |   2 +-
 tcg/tcg-common.c                          |   2 +-
 tcg/tcg-op-gvec.c                         |   8 +-
 tcg/tcg-op-vec.c                          |   6 +-
 tcg/tcg-op.c                              |   6 +-
 tcg/tcg.c                                 |   2 +-
 tcg/tci.c                                 |   2 +-
 MAINTAINERS                               |   4 +-
 configure                                 |   1 -
 docs/devel/loads-stores.rst               | 215 ++++++++++----
 90 files changed, 1037 insertions(+), 1240 deletions(-)
 delete mode 100644 include/exec/cpu_ldst_template.h
 delete mode 100644 include/exec/cpu_ldst_useronly_template.h
 rename {tcg => include/tcg}/tcg-gvec-desc.h (100%)
 rename {tcg => include/tcg}/tcg-mo.h (100%)
 rename {tcg => include/tcg}/tcg-op-gvec.h (100%)
 rename {tcg => include/tcg}/tcg-op.h (99%)
 rename {tcg => include/tcg}/tcg-opc.h (100%)
 rename {tcg => include/tcg}/tcg.h (96%)

