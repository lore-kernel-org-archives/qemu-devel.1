Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F7C6C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:18:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78B7522D2C
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:18:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="iUe9Zysy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78B7522D2C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3dSS-0002l3-NR
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 06:49:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39902)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k3dQe-0000NE-4M
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 06:47:20 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429]:36486)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k3dQb-0007eD-DM
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 06:47:19 -0400
Received: by mail-pf1-x429.google.com with SMTP id m8so17860499pfh.3
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2020 03:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=JAl88y0xPmjeTU2KFmFTabUFrFyw6bXjO0tOtAZjqr8=;
 b=iUe9ZysypzuQgwEYor7/effGmmD2UuT0OEJpnYXvx01jfpkKg+Qu4bh7gHD607o6lE
 EiI3WIQ7JD+Dbm37hyhUOpl4c4zXqkeWdCWE6qhdiix7TJUyBfnXnngllCj546OrHr91
 ZOExh2/VELj4qo/XeaVRjJEccOTj3gL6TAx79CBWfIhyBFAbemERGrfSI0KWtBdEXVaW
 SLAB9Bn0UFY4eiOq+ecw2GCQzpLsrUoECBddsAjCLJyx8iVU4wx7g+VURca6dl/1q/uR
 uNQMK3DwKajYbFx9hU7106btXnJJ8e7CQtLreUIMO5Ovro0GVFYnR82e6G/K+yAjl7QB
 zQ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=JAl88y0xPmjeTU2KFmFTabUFrFyw6bXjO0tOtAZjqr8=;
 b=sn/9V0iuerW+vTlt+gWtysZlZn9tJ88bmXj+nyDXAANJGnh8wH9U3J2A1AUf5T4vD6
 V2oEBSoN5IO/s+966InRNeaHBysgST7R36i15URXyR1pbXoEVSFotiwYoxbF8gMim46a
 uO2+dvsO/KBEaxZ3mIp7zGyxlUTY20kOrhihcrBfVEg6iVU7jEcCqoWkryLKsTRbVF3J
 l5XfmyREF0SRbxsv2wElo2J+juDWTXvxYlOfkKf7PmqZXhl4paWNXaFUC6br9ilk0Pkr
 DGfab40l9hPYyCCgINqkgoEPjBaahO2S9+ZpYG6s1ue2e79oK2MkO9E1aPN5viaUIm1j
 HoVg==
X-Gm-Message-State: AOAM533re8agkdz+nVrGfKIMuxHn8utEV/7s2Qa8JwiJbsk4zaKrihFc
 MNzgj5KVJKfnjpIV3Hb35UxD0/4kINc=
X-Google-Smtp-Source: ABdhPJzGoCptZv2Otd+06/Z+ZqNmYtzLeZn3agBWbA5xAdkOUx1UPSFHeLU/vPLStE0z7vSLXbZ7AQ==
X-Received: by 2002:a63:6f02:: with SMTP id k2mr420505pgc.207.1596710834962;
 Thu, 06 Aug 2020 03:47:14 -0700 (PDT)
Received: from frankchang-ThinkPad-T490.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id f18sm6567309pgv.84.2020.08.06.03.47.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2020 03:47:14 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v3 00/71] target/riscv: support vector extension v1.0
Date: Thu,  6 Aug 2020 18:45:57 +0800
Message-Id: <20200806104709.13235-1-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=frank.chang@sifive.com; helo=mail-pf1-x429.google.com
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

This patchset implements the vector extension v1.0 for RISC-V on QEMU.

This patchset is sent as RFC because RVV v1.0 is still in draft state.
v2 patchset was sent for RVV v0.9. However, in order to relieve the
burden for the community to maintain multi-version of vector drafts.
v3 patchset is updated and bump to RVV v1.0 for review.

You can change the cpu argument: vext_spec to v1.0 (i.e. vext_spec=v1.0)
to run with RVV v1.0 instructions.

Note: This patchset depends on two other patchsets listed in Based-on
      section below so it might not able to be built unless those two
      patchsets are applied.

Changelog:

v3
  * apply nan-box helpers from Richard Henderson.
  * remove fp16 api changes as they are sent independently in another
    pathcset by Chih-Min Chao.
  * remove all tail elements clear functions as tail elements can
    retain unchanged for either VTA set to undisturbed or agnostic.
  * add fp16 nan-box check generator function.
  * add floating-point rounding mode enum.
  * replace flmul arithmetic with shifts to avoid floating-point
    conversions.
  * add Zvqmac extension.
  * replace gdbstub vector register xml files with dynamic generator.
  * RVV v1.0 related changes:
    * add vl<nf>re<eew>.v and vs<nf>r.v vector whole register
      load/store instructions
    * add vrgatherei16 instruction.
    * rearranged bits in vtype to make vlmul bits into a contiguous
      field.

v2
  * drop v0.7.1 support.
  * replace invisible return check macros with functions.
  * move mark_vs_dirty() to translators.
  * add SSTATUS_VS flag for s-mode.
  * nan-box scalar fp register for floating-point operations.
  * add gdbstub files for vector registers to allow system-mode
    debugging with GDB.

Based-on: <20200724002807.441147-1-richard.henderson@linaro.org/>
Based-on: <1596102747-20226-1-git-send-email-chihmin.chao@sifive.com/>

Frank Chang (63):
  target/riscv: drop vector 0.7.1 and add 1.0 support
  target/riscv: Use FIELD_EX32() to extract wd field
  target/riscv: rvv-1.0: introduce writable misa.v field
  target/riscv: rvv-1.0: remove vxrm and vxsat fields from fcsr register
  target/riscv: rvv-1.0: check MSTATUS_VS when accessing vector csr
    registers
  target/riscv: rvv-1.0: remove MLEN calculations
  target/riscv: rvv-1.0: add fractional LMUL
  target/riscv: rvv-1.0: add VMA and VTA
  target/riscv: rvv-1.0: update check functions
  target/riscv: introduce more imm value modes in translator functions
  target/riscv: add fp16 nan-box check generator function
  target/riscv: rvv:1.0: add translation-time nan-box helper function
  target/riscv: rvv-1.0: apply nanbox helper in opfvf_trans
  target/riscv: rvv-1.0: configure instructions
  target/riscv: rvv-1.0: stride load and store instructions
  target/riscv: rvv-1.0: index load and store instructions
  target/riscv: rvv-1.0: fix address index overflow bug of indexed
    load/store insns
  target/riscv: rvv-1.0: fault-only-first unit stride load
  target/riscv: rvv-1.0: amo operations
  target/riscv: rvv-1.0: load/store whole register instructions
  target/riscv: rvv-1.0: update vext_max_elems() for load/store insns
  target/riscv: rvv-1.0: take fractional LMUL into vector max elements
    calculation
  target/riscv: rvv-1.0: floating-point square-root instruction
  target/riscv: rvv-1.0: floating-point classify instructions
  target/riscv: rvv-1.0: mask population count instruction
  target/riscv: rvv-1.0: find-first-set mask bit instruction
  target/riscv: rvv-1.0: set-X-first mask bit instructions
  target/riscv: rvv-1.0: iota instruction
  target/riscv: rvv-1.0: element index instruction
  target/riscv: rvv-1.0: allow load element with sign-extended
  target/riscv: rvv-1.0: register gather instructions
  target/riscv: rvv-1.0: integer scalar move instructions
  target/riscv: rvv-1.0: floating-point move instruction
  target/riscv: rvv-1.0: floating-point scalar move instructions
  target/riscv: rvv-1.0: whole register move instructions
  target/riscv: rvv-1.0: integer extension instructions
  target/riscv: rvv-1.0: single-width averaging add and subtract
    instructions
  target/riscv: rvv-1.0: single-width bit shift instructions
  target/riscv: rvv-1.0: integer add-with-carry/subtract-with-borrow
  target/riscv: rvv-1.0: narrowing integer right shift instructions
  target/riscv: rvv-1.0: widening integer multiply-add instructions
  target/riscv: rvv-1.0: add Zvqmac extension
  target/riscv: rvv-1.0: quad-widening integer multiply-add instructions
  target/riscv: rvv-1.0: single-width saturating add and subtract
    instructions
  target/riscv: rvv-1.0: integer comparison instructions
  target/riscv: use softfloat lib float16 comparison functions
  target/riscv: rvv-1.0: floating-point compare instructions
  target/riscv: rvv-1.0: mask-register logical instructions
  target/riscv: rvv-1.0: slide instructions
  target/riscv: rvv-1.0: floating-point slide instructions
  target/riscv: rvv-1.0: narrowing fixed-point clip instructions
  target/riscv: rvv-1.0: single-width floating-point reduction
  target/riscv: rvv-1.0: widening floating-point reduction instructions
  target/riscv: rvv-1.0: single-width scaling shift instructions
  target/riscv: rvv-1.0: remove widening saturating scaled multiply-add
  target/riscv: rvv-1.0: remove vmford.vv and vmford.vf
  target/riscv: rvv-1.0: remove integer extract instruction
  target/riscv: rvv-1.0: floating-point min/max instructions
  target/riscv: introduce floating-point rounding mode enum
  target/riscv: rvv-1.0: floating-point/integer type-convert
    instructions
  target/riscv: rvv-1.0: widening floating-point/integer type-convert
  target/riscv: add "set round to odd" rounding mode helper function
  target/riscv: rvv-1.0: narrowing floating-point/integer type-convert

Greentime Hu (2):
  target/riscv: rvv-1.0: add vlenb register
  target/riscv: gdb: support vector registers for rv32

Hsiangkai Wang (2):
  target/riscv: gdb: modify gdb csr xml file to align with csr register
    map
  target/riscv: gdb: support vector registers for rv64

LIU Zhiwei (4):
  target/riscv: rvv-1.0: add mstatus VS field
  target/riscv: rvv-1.0: add sstatus VS field
  target/riscv: rvv-1.0: add translation-time vector context status
  target/riscv: rvv-1.0: add vcsr register

 gdb-xml/riscv-32bit-csr.xml             |   18 +-
 gdb-xml/riscv-64bit-csr.xml             |   18 +-
 target/riscv/cpu.c                      |   12 +-
 target/riscv/cpu.h                      |   95 +-
 target/riscv/cpu_bits.h                 |   10 +
 target/riscv/cpu_helper.c               |   16 +-
 target/riscv/csr.c                      |   69 +-
 target/riscv/fpu_helper.c               |   17 +-
 target/riscv/gdbstub.c                  |  126 +-
 target/riscv/helper.h                   |  523 ++--
 target/riscv/insn32-64.decode           |   18 +-
 target/riscv/insn32.decode              |  295 +-
 target/riscv/insn_trans/trans_rvv.inc.c | 2335 +++++++++++-----
 target/riscv/internals.h                |   20 +-
 target/riscv/translate.c                |   55 +-
 target/riscv/vector_helper.c            | 3367 +++++++++++------------
 16 files changed, 4076 insertions(+), 2918 deletions(-)

--
2.17.1


