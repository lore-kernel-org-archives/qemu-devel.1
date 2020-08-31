Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83A2DC433E6
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 16:07:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E89A20767
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 16:07:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pRjC4QcN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E89A20767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCmKt-00052g-DD
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 12:07:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33396)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCmJx-0003PQ-6Y
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 12:06:13 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a]:43992)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCmJt-0005tm-Bi
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 12:06:12 -0400
Received: by mail-pg1-x52a.google.com with SMTP id d19so824297pgl.10
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 09:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=wCkbxWg1oiL1CpJwGfdvNlRiEgbiK2MdnjElLHXtWQI=;
 b=pRjC4QcNKxHQHHgKXVFUXoDS8g2UHIzRAU8RVeQ31J4clReMtV8t7AhqWNBLkH2KQZ
 TTglh1T58pRDmlj9/C9JdfQH36D8D4EiM/efXpc+rf6PmNJSoy/3/knN/M5tsxwiMnhM
 qO5Lv0Ozav2+oB1ic+ChUdYH4Pk5OKYgktliV5qcNqoPV2l4BLy72cOB8yx8rvD45Yr2
 MqJRIbk/vI9Ny6iWV4qbDtnEr5fNyXWSnv9TMjX/QZKISJ4LYSTdKzBeetYk1rX5OaIZ
 O4LJjV3L9k9g8LH2mfY6VJXlZiVgw0HO0FlHtJMQskh5so/YFSVaqsluddwq3SSK3Mod
 P+TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=wCkbxWg1oiL1CpJwGfdvNlRiEgbiK2MdnjElLHXtWQI=;
 b=Ou5lan1rBfUUCjRFek7JMNGAPEeTi1s9r01yA5Dvv3kXOURgfjf1adLH2bcyL66fyH
 kWl0Bt16ef8jiEQxZ3WH9Uo0KESGM7rzI3vv2fUDVuqtOgomZzSvkuebMWJUpWED5XH0
 hjHYhhNZ7c0CKfQBmRIL/+L77p6lMCq5mYkQ4UMAXb3J/2Njc12tMtGuWN5MSYCvKfos
 S9wgTPJpPnlLSbI3beypw0o/COzFYnqP0kYJo2mXEo/7D3nd9Nq9B46W7qJSd9Lb4nk1
 vWIWhUUkr3WTsHdmGTuMF+t5W8YtO4L04Y4sUPfXkYb5np9k9gSeLVIttUe1T4JMj5oy
 tsFw==
X-Gm-Message-State: AOAM533y72BO96O2B5tYxf3+vH+R6VSWtUb/iEwBtOekDWeCLJYApZ1D
 6lfDuWKgzJbp5xB5l/rPyUS4oZKL3ooTvQ==
X-Google-Smtp-Source: ABdhPJwxK4zFB3iHMfAm4UwEORYwzjfrd3SZCTi1UwzHBLuqk5TkAUCgDlwV9ojvatCbiP3amtbfHA==
X-Received: by 2002:a63:e157:: with SMTP id h23mr1824828pgk.239.1598889964419; 
 Mon, 31 Aug 2020 09:06:04 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id gt13sm17218pjb.43.2020.08.31.09.06.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2020 09:06:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/76] target/microblaze improvements
Date: Mon, 31 Aug 2020 09:04:45 -0700
Message-Id: <20200831160601.833692-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52a.google.com
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

At Edgar's request, generating the pull-request for this.

r~



The following changes since commit 39335fab59e11cfda9b7cf63929825db2dd3a3e0:

  Merge remote-tracking branch 'remotes/vivier2/tags/linux-user-for-5.2-pull-request' into staging (2020-08-28 22:30:11 +0100)

are available in the Git repository at:

  https://github.com/rth7680/qemu.git tags/pull-mb-20200831

for you to fetch changes up to 7233c0d0b0f5b65fcf6d6423de069ddf9f916392:

  target/microblaze: Reduce linux-user address space to 32-bit (2020-08-31 08:45:45 -0700)

----------------------------------------------------------------
Convert microblaze to generic translator loop
Convert microblaze to decodetree
Fix mb_cpu_transaction_failed
Other misc cleanups

----------------------------------------------------------------
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
 target/microblaze/insns.decode        |  256 +++
 linux-user/elfload.c                  |    9 +-
 linux-user/microblaze/cpu_loop.c      |   26 +-
 linux-user/microblaze/signal.c        |    8 +-
 target/microblaze/cpu.c               |    9 +-
 target/microblaze/gdbstub.c           |  193 +-
 target/microblaze/helper.c            |  164 +-
 target/microblaze/mmu.c               |    4 +-
 target/microblaze/op_helper.c         |  194 +-
 target/microblaze/translate.c         | 3223 +++++++++++++++++----------------
 tests/tcg/multiarch/float_convs.c     |    2 +
 tests/tcg/multiarch/float_madds.c     |    2 +
 target/microblaze/meson.build         |    3 +
 tests/tcg/configure.sh                |    2 +-
 20 files changed, 2292 insertions(+), 2025 deletions(-)
 delete mode 100644 target/microblaze/microblaze-decode.h
 create mode 100644 target/microblaze/insns.decode

