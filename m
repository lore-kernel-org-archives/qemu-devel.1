Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D2CEC433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 09:18:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8E2A20729
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 09:18:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Kflan8my"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8E2A20729
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57062 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyAt0-0005rh-W6
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 05:18:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52454)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jyAs5-0004XZ-Sz
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 05:17:06 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d]:40498)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jyArz-00059M-VV
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 05:17:05 -0400
Received: by mail-pj1-x102d.google.com with SMTP id t15so859791pjq.5
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2020 02:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=rOp6YSrx5ear3r2vr5z2v8mQ11+Ffd42dKwAlwR1PgQ=;
 b=Kflan8mymvg8QofwJ/8q7/BxinyP/AY9t67rgcj8+rUR7TyaueouyxmHrCUsYKgZr2
 4lKnlmrosC/SnncMwoBA5ciJfxq1vk/HT+d27YZWNcuQVkA5lOHWbeOBs8Fb7MDZBrl5
 SI7YVF+XocZViG5LiqeWX28ZIULVGl9sSR6U9Q95/KQ6O6rTLh9XiVWxf8Z5OsRt0XZB
 xytXrtjGBZQ7SDpFzRV6H89hV7hlgXmwKFS7G7yvq+43udvok5s6JEH8wWgrr1OyZmaa
 Xs93H+eRugEcBHWp8IlHXcx2djemMSM9Er7yN6hDZmv4481KP5fXLF+z1WF7E8nWggQs
 jmvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=rOp6YSrx5ear3r2vr5z2v8mQ11+Ffd42dKwAlwR1PgQ=;
 b=mgQ9zty4Yf3Zc0PZqhS5MQStAsjd19Yd4WA2VGsSt+tniArojF7xXwSqvsKGBwsRJX
 XFyQ2xOE5JobpTllCE//2fea9eYkQAOoIDickF3cYN42dMPwEK0yZBDufHnpDDSqV+05
 wVqv1yKE3ivQBCGUB34jzF1PX36AYI/ciJj/77gloKG1gtWuoPYDrUldPjSMi8B0vull
 PNhdU4GxnfKg6w3O8aTuiYle3OQbtPPISHZM0wmYM9IdYxTcizmefmueUSwwhg3t2VmG
 csyUpzcayMcq9IU3Avvj2hHAMfCTSLC1P77Qv9yB6zF4tFBGPNPzuIBGSCIZ4aXKjoAM
 +jZA==
X-Gm-Message-State: AOAM532CzoUHgXBpi6elNwc4bSbyxfQXYf3UA12GuSXN443QR//18ez9
 3v8FFAmLcfqyO3VPRvqjb/BJaih8L4I=
X-Google-Smtp-Source: ABdhPJyyCH2RHjr37GN6PDWvWmGWPCbljsvIQuUHBNBRl69SueAGTmz0OZGYfVT3/iRLM+5MUrk87Q==
X-Received: by 2002:a17:90a:2562:: with SMTP id
 j89mr8653303pje.218.1595409417901; 
 Wed, 22 Jul 2020 02:16:57 -0700 (PDT)
Received: from frankchang-ThinkPad-T490.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id c125sm22301879pfa.119.2020.07.22.02.16.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2020 02:16:57 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v2 00/76] target/riscv: support vector extension v0.9
Date: Wed, 22 Jul 2020 17:15:23 +0800
Message-Id: <20200722091641.8834-1-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=frank.chang@sifive.com; helo=mail-pj1-x102d.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=unavailable autolearn_force=no
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
Cc: Frank Chang <frank.chang@sifive.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Frank Chang <frank.chang@sifive.com>

This patchset implements the vector extension v0.9 for RISC-V on QEMU.

This patchset is sent as RFC because RVV v0.9 is still in draft state.
However, as RVV v1.0 should be ratified soon and there shouldn't be
critical changes between RVV v1.0 and RVV v0.9. We would like to have
the community to review RVV v0.9 implementations. Once RVV v1.0 is
ratified, we will then upgrade to RVV v1.0.

You can change the cpu argument: vext_spec to v0.9 (i.e. vext_spec=v0.9)
to run with RVV v0.9 instructions.

Changelog:

v2
  * drop v0.7.1 support.
  * replace invisible return check macros with functions.
  * move mark_vs_dirty() to translators.
  * add SSTATUS_VS flag for s-mode.
  * nan-box scalar fp register for floating-point operations.
  * add gdbstub files for vector registers to allow system-mode
    debugging with GDB.

Chih-Min Chao (2):
  fpu: add api to handle alternative sNaN propagation
  fpu: fix float16 nan check

Frank Chang (65):
  target/riscv: drop vector 0.7.1 support
  target/riscv: rvv-0.9: support vector 0.9
  target/riscv: fix rsub gvec tcg_assert_listed_vecop assertion
  target/riscv: correct the gvec IR called in gen_vec_rsub16_i64()
  target/riscv: fix return value of do_opivx_widen()
  target/riscv: fix vill bit index in vtype register
  target/riscv: Use FIELD_EX32() to extract wd field
  target/riscv: rvv-0.9: remove vxrm and vxsat fields from fcsr register
  target/riscv: rvv-0.9: remove MLEN calculations
  target/riscv: rvv-0.9: add fractional LMUL
  target/riscv: rvv-0.9: add VMA and VTA
  target/riscv: rvv-0.9: update check functions
  target/riscv: introduce more imm value modes in translator functions
  target/riscv: rvv-0.9: add narrower_nanbox_fpr helper
  target/riscv: rvv-0.9: apply narrower nanbox helper in opfvf_trans
  target/riscv: rvv-0.9: configure instructions
  target/riscv: rvv-0.9: stride load and store instructions
  target/riscv: rvv-0.9: index load and store instructions
  target/riscv: rvv-0.9: fix address index overflow bug of indexed
    load/store insns
  target/riscv: rvv-0.9: fault-only-first unit stride load
  target/riscv: rvv-0.9: amo operations
  target/riscv: rvv-0.9: load/store whole register instructions
  target/riscv: rvv-0.9: update vext_max_elems() for load/store insns
  target/riscv: rvv-0.9: take fractional LMUL into vector max elements
    calculation
  target/riscv: rvv-0.9: floating-point square-root instruction
  target/riscv: rvv-0.9: floating-point classify instructions
  target/riscv: rvv-0.9: mask population count instruction
  target/riscv: rvv-0.9: find-first-set mask bit instruction
  target/riscv: rvv-0.9: set-X-first mask bit instructions
  target/riscv: rvv-0.9: iota instruction
  target/riscv: rvv-0.9: element index instruction
  target/riscv: rvv-0.9: allow load element with sign-extended
  target/riscv: rvv-0.9: register gather instructions
  target/riscv: rvv-0.9: integer scalar move instructions
  target/riscv: rvv-0.9: floating-point move instruction
  target/riscv: rvv-0.9: floating-point scalar move instructions
  target/riscv: rvv-0.9: whole register move instructions
  target/riscv: rvv-0.9: integer extension instructions
  target/riscv: rvv-0.9: single-width averaging add and subtract
    instructions
  target/riscv: rvv-0.9: single-width bit shift instructions
  target/riscv: rvv-0.9: integer add-with-carry/subtract-with-borrow
  target/riscv: rvv-0.9: narrowing integer right shift instructions
  target/riscv: rvv-0.9: widening integer multiply-add instructions
  target/riscv: rvv-0.9: quad-widening integer multiply-add instructions
  target/riscv: rvv-0.9: single-width saturating add and subtract
    instructions
  target/riscv: rvv-0.9: integer comparison instructions
  target/riscv: use softfloat lib float16 comparison functions
  target/riscv: rvv-0.9: floating-point compare instructions
  target/riscv: rvv-0.9: single-width integer reduction instructions
  target/riscv: rvv-0.9: widening integer reduction instructions
  target/riscv: rvv-0.9: mask-register logical instructions
  target/riscv: rvv-0.9: slide instructions
  target/riscv: rvv-0.9: floating-point slide instructions
  target/riscv: rvv-0.9: narrowing fixed-point clip instructions
  target/riscv: rvv-0.9: floating-point/integer type-convert
    instructions
  target/riscv: rvv-0.9: single-width floating-point reduction
  target/riscv: rvv-0.9: widening floating-point reduction instructions
  target/riscv: rvv-0.9: single-width scaling shift instructions
  target/riscv: rvv-0.9: remove widening saturating scaled multiply-add
  target/riscv: rvv-0.9: remove vmford.vv and vmford.vf
  target/riscv: rvv-0.9: remove integer extract instruction
  target/riscv: rvv-0.9: floating-point min/max instructions
  softfloat: add fp16 and uint8/int8 interconvert functions
  target/riscv: rvv-0.9: widening floating-point/integer type-convert
  target/riscv: rvv-0.9: narrowing floating-point/integer type-convert

Greentime Hu (2):
  target/riscv: rvv-0.9: add vlenb register
  target/riscv: gdb: support vector registers for rv32

Hsiangkai Wang (2):
  target/riscv: gdb: modify gdb csr xml file to align with csr register
    map
  target/riscv: gdb: support vector registers for rv64

Kito Cheng (1):
  fpu: implement full set compare for fp16

LIU Zhiwei (4):
  target/riscv: rvv-0.9: add mstatus VS field
  target/riscv: rvv-0.9: add sstatus VS field
  target/riscv: rvv-0.9: add translation-time vector context status
  target/riscv: rvv-0.9: add vcsr register

 configure                               |    4 +-
 fpu/softfloat-specialize.inc.c          |    4 +-
 fpu/softfloat.c                         |  137 +-
 gdb-xml/riscv-32bit-csr.xml             |   11 +-
 gdb-xml/riscv-64bit-csr.xml             |   18 +-
 gdb-xml/riscv-64bit-vector-128b.xml     |   59 +
 gdb-xml/riscv-64bit-vector-256b.xml     |   59 +
 gdb-xml/riscv-64bit-vector-512b.xml     |   59 +
 include/fpu/softfloat.h                 |   55 +
 target/riscv/cpu.c                      |   10 +-
 target/riscv/cpu.h                      |   67 +-
 target/riscv/cpu_bits.h                 |   10 +
 target/riscv/cpu_helper.c               |   16 +-
 target/riscv/csr.c                      |   63 +-
 target/riscv/gdbstub.c                  |   62 +-
 target/riscv/helper.h                   |  507 +++--
 target/riscv/insn32-64.decode           |   18 +-
 target/riscv/insn32.decode              |  282 +--
 target/riscv/insn_trans/trans_rvv.inc.c | 2291 +++++++++++++++-------
 target/riscv/internals.h                |   18 +-
 target/riscv/translate.c                |   43 +-
 target/riscv/vector_helper.c            | 2367 +++++++++++++----------
 22 files changed, 3993 insertions(+), 2167 deletions(-)
 create mode 100644 gdb-xml/riscv-64bit-vector-128b.xml
 create mode 100644 gdb-xml/riscv-64bit-vector-256b.xml
 create mode 100644 gdb-xml/riscv-64bit-vector-512b.xml

--
2.17.1


