Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24E5BC433E6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 14:20:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E16CB208CA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 14:20:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PW3sdElr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E16CB208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51944 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBfFI-00015y-43
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 10:20:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50752)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBfE8-0007of-Og
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 10:19:36 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430]:38387)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBfE5-00050x-Sm
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 10:19:36 -0400
Received: by mail-pf1-x430.google.com with SMTP id d22so737542pfn.5
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 07:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=KWXiiLPamFSccIBlH9C38JtqLfc5JncB46HJfEEr/R0=;
 b=PW3sdElrR1hmm59q/c7P8ewtEj4Mpej7pQiBsyeJ8GyH2D6MyFj1HFOPAdzBlm5siI
 wdWxb81EYSjO6KXsy/EmiZvPAlLin9po/184F4x8ayUztzKeAvbjEx6twTR7qc8S3Vrs
 /6zt3VJ+OiGgXUZ8ml9r+6hfc4WE/z5uUjvl9qfoekI28uEOiJk9Vfzt0MyVNVhA6M7a
 wyfFF9KUaT7O9M8H71K2Ub+Pdzbatdpcc9sbvPtCLaavojAvxkcxd0QBL0j0dHuLe6Ma
 p58acV9cAoYg4dLYlHe+Hr4m5jrhRRth2DjlL85ZlFQnvKdeIMZedbFr40oR7eN5QfMI
 nZyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=KWXiiLPamFSccIBlH9C38JtqLfc5JncB46HJfEEr/R0=;
 b=DOr1STDS/bGg0uSwR46XNDzk1LFPYlM7GkPko5IWzeaLWPV4qUK+mb6m7/3rgND+X6
 vDdcOMErSUMR/LHCUrChFximyT+UN++xu1VhSL2pDGd3pDcjTdaQdbwZAtntx32yOezK
 7dqFaDqWr04AgZk/qzLN9LkICMzzAtBQnU8XHjUgHiN4XJ1praHIokeqqRs5qGjkyFW5
 O/OPv4REqnrUlmZpedMVzVRX5B+5c/6pc07Adg7vjxyv/ULehwOf/204TWHJDL1Sj5JF
 IHwPal4uWy+7I3w2ij/AvCSDWFqQRLF0YDJcP9Vhn1oTatOZhhDgISCcaH+1fu/8D2F5
 8wWA==
X-Gm-Message-State: AOAM533nb4GMZiazsagpMbVK0JQlK3YmskwjVU/txng53G4fIjkpjoT+
 xTKHhtq3W0A7wzCvyPqj5uJr5r2L9zwTYA==
X-Google-Smtp-Source: ABdhPJyF3k59CgURsNFL9/y+lWhvBIgEWyv3B69e6jIM4R59u8Rc2cOXODVIUxG2UNOuNZA2zt0DNg==
X-Received: by 2002:a65:568b:: with SMTP id v11mr1406823pgs.396.1598624371303; 
 Fri, 28 Aug 2020 07:19:31 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id j3sm1403080pjw.23.2020.08.28.07.19.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 07:19:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 00/76] target/microblaze improvements
Date: Fri, 28 Aug 2020 07:18:13 -0700
Message-Id: <20200828141929.77854-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: edgar.iglesias@xilinx.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Thanks for all the testing and review, Edgar.

Changes in v2:
  * Restored opcode_0_illegal handling.
  * Dropped problematic imm/delay slot tb extension.
  * Dropped tcg_gen_lookup_and_goto_ptr for now.
  * Added fix for mb_cpu_transaction_failed.
  * Removed microblaze-decode.h with old decoder.
  * Removed abort_at_next_insn with old decoder.
  * Fixed mbar.
  * Fixed put.


r~


Richard Henderson (76):
  tests/tcg: Add microblaze to arches filter
  tests/tcg: Do not require FE_TOWARDZERO
  tests/tcg: Do not require FE_* exception bits
  target/microblaze: Tidy gdbstub
  target/microblaze: Split out PC from env->sregs
  target/microblaze: Split out MSR from env->sregs
  target/microblaze: Split out EAR from env->sregs
  target/microblaze: Split out ESR from env->sregs
  target/microblaze: Split out FSR from env->sregs
  target/microblaze: Split out BTR from env->sregs
  target/microblaze: Split out EDR from env->sregs
  target/microblaze: Split the cpu_SR array
  target/microblaze: Fix width of PC and BTARGET
  target/microblaze: Fix width of MSR
  target/microblaze: Fix width of ESR
  target/microblaze: Fix width of FSR
  target/microblaze: Fix width of BTR
  target/microblaze: Fix width of EDR
  target/microblaze: Remove cpu_ear
  target/microblaze: Tidy raising of exceptions
  target/microblaze: Mark raise_exception as noreturn
  target/microblaze: Remove helper_debug and env->debug
  target/microblaze: Rename env_* tcg variables to cpu_*
  target/microblaze: Tidy mb_tcg_init
  target/microblaze: Split out MSR[C] to its own variable
  target/microblaze: Use DISAS_NORETURN
  target/microblaze: Check singlestep_enabled in gen_goto_tb
  target/microblaze: Convert to DisasContextBase
  target/microblaze: Convert to translator_loop
  target/microblaze: Remove SIM_COMPAT
  target/microblaze: Remove DISAS_GNU
  target/microblaze: Remove empty D macros
  target/microblaze: Remove LOG_DIS
  target/microblaze: Ensure imm constant is always available
  target/microblaze: Add decodetree infrastructure
  target/microblaze: Convert dec_add to decodetree
  target/microblaze: Convert dec_sub to decodetree
  target/microblaze: Implement cmp and cmpu inline
  target/microblaze: Convert dec_pattern to decodetree
  target/microblaze: Convert dec_and, dec_or, dec_xor to decodetree
  target/microblaze: Convert dec_mul to decodetree
  target/microblaze: Convert dec_div to decodetree
  target/microblaze: Unwind properly when raising divide-by-zero
  target/microblaze: Convert dec_bit to decodetree
  target/microblaze: Convert dec_barrel to decodetree
  target/microblaze: Convert dec_imm to decodetree
  target/microblaze: Convert dec_fpu to decodetree
  target/microblaze: Fix cpu unwind for fpu exceptions
  target/microblaze: Mark fpu helpers TCG_CALL_NO_WG
  target/microblaze: Replace MSR_EE_FLAG with MSR_EE
  target/microblaze: Cache mem_index in DisasContext
  target/microblaze: Fix cpu unwind for stackprot
  target/microblaze: Convert dec_load and dec_store to decodetree
  target/microblaze: Assert no overlap in flags making up tb_flags
  target/microblaze: Move bimm to BIMM_FLAG
  target/microblaze: Fix no-op mb_cpu_transaction_failed
  target/microblaze: Store "current" iflags in insn_start
  tcg: Add tcg_get_insn_start_param
  target/microblaze: Use cc->do_unaligned_access
  target/microblaze: Replace clear_imm with tb_flags_to_set
  target/microblaze: Replace delayed_branch with tb_flags_to_set
  target/microblaze: Tidy mb_cpu_dump_state
  target/microblaze: Convert brk and brki to decodetree
  target/microblaze: Convert mbar to decodetree
  target/microblaze: Reorganize branching
  target/microblaze: Convert dec_br to decodetree
  target/microblaze: Convert dec_bcc to decodetree
  target/microblaze: Convert dec_rts to decodetree
  target/microblaze: Tidy do_rti, do_rtb, do_rte
  target/microblaze: Convert msrclr, msrset to decodetree
  target/microblaze: Convert dec_msr to decodetree
  target/microblaze: Convert dec_stream to decodetree
  target/microblaze: Remove last of old decoder
  target/microblaze: Remove cpu_R[0]
  target/microblaze: Add flags markup to some helpers
  target/microblaze: Reduce linux-user address space to 32-bit

 include/tcg/tcg.h                     |   15 +
 target/microblaze/cpu-param.h         |   15 +
 target/microblaze/cpu.h               |   67 +-
 target/microblaze/helper.h            |   49 +-
 target/microblaze/microblaze-decode.h |   59 -
 tests/tcg/multiarch/float_helpers.h   |   17 +
 target/microblaze/insns.decode        |  256 ++
 linux-user/elfload.c                  |    9 +-
 linux-user/microblaze/cpu_loop.c      |   26 +-
 linux-user/microblaze/signal.c        |    8 +-
 target/microblaze/cpu.c               |    9 +-
 target/microblaze/gdbstub.c           |  193 +-
 target/microblaze/helper.c            |  164 +-
 target/microblaze/mmu.c               |    4 +-
 target/microblaze/op_helper.c         |  194 +-
 target/microblaze/translate.c         | 3223 +++++++++++++------------
 tests/tcg/multiarch/float_convs.c     |    2 +
 tests/tcg/multiarch/float_madds.c     |    2 +
 target/microblaze/meson.build         |    3 +
 tests/tcg/configure.sh                |    2 +-
 20 files changed, 2292 insertions(+), 2025 deletions(-)
 delete mode 100644 target/microblaze/microblaze-decode.h
 create mode 100644 target/microblaze/insns.decode

-- 
2.25.1


