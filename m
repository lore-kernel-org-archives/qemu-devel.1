Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D208CC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 13:00:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9574620720
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 13:00:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="DHwtF57a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9574620720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtsdG-0007GN-OW
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 09:00:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36042)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jtqbA-0004Iu-2h
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 06:49:44 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c]:40270)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jtqb8-00066z-1j
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 06:49:43 -0400
Received: by mail-pj1-x102c.google.com with SMTP id t15so2442361pjq.5
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2020 03:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=hIrZ7s6T4K53Z6FOVA3aW8f4cihseKiw2IFviPh2j3E=;
 b=DHwtF57aqntgvmHGT9vW2luzzp73c++phJgD/fkxQZwlGQ2eqf/P1vOF1tkQoeI5VY
 xoVwINEsRvXd66u37KduLS+YOb8BQCszICdvtyH0mm6JP8g+9/Cdmvh2mbUw95NzUPtr
 HCJ9cymk//20MolMiiX9O1CnpT2Q9ZUnjIi+RveCtpgbhuP+13HJU4/jKmZyJ+8u4ml5
 wsR98Sgo6M07kTNGft7v0D62hD+ysfiOlPyqWnVGfhO+hC5qhk4YkkOqNynV/mrdlx95
 HLY41+LaQPHnxdtXE98bNnO6sgJKpNgWy0ppDlZb1I3tZK+iVTD0tNTooBhADo7s/3IH
 wemw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=hIrZ7s6T4K53Z6FOVA3aW8f4cihseKiw2IFviPh2j3E=;
 b=PTJoRZlQEVawRR7l5EU3hMZiKgdNbDNqWRSFMd8vAufIYy+EWzNhWrsqjhdY0XSI1Q
 eCfbPWxlA7iLtg8YkBf0nyEthS4NEVlGWW/vo0sTeLC1kCe3L6VHiROap9O0P/iPFg2w
 70ZypH8WXxFvW8CL/8jCIGhG3NoHbaGYxVwBuQgrSzjDxk4O6kb+Xi88pCtHUooRKZSR
 C2FsLt4R8228TM5eBRrtm7vkVG2Awx3FquLuUFjOVITvlxXsn2OeytQrcjiQGGYIazGH
 lfE+fE9Jxy0Z6ZJp3RQgwVRymbm5vBBsyExwIj6E4V/gbthndyojlW0mV1xeju/I20iv
 on0w==
X-Gm-Message-State: AOAM530ZLPKfM49IoQyv2WayBiHNbnvOzf0p67mv13ItoBSLwGP8omAd
 hzw1uQ9hSNXZQzDEEzTDnEDH/g22ERUTRA==
X-Google-Smtp-Source: ABdhPJzW9frTCA/0Ndw+oB7bA9iJTN9b/zQQcAvDzyjUHOppyZLgR/6TcNzVDeEH6qchal04jZrKjQ==
X-Received: by 2002:a17:90b:94f:: with SMTP id
 dw15mr5082599pjb.199.1594378179745; 
 Fri, 10 Jul 2020 03:49:39 -0700 (PDT)
Received: from frankchang-ThinkPad-T490.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id r191sm5519406pfr.181.2020.07.10.03.49.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2020 03:49:39 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC 00/65] target/riscv: support vector extension v0.9
Date: Fri, 10 Jul 2020 18:48:14 +0800
Message-Id: <20200710104920.13550-1-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=frank.chang@sifive.com; helo=mail-pj1-x102c.google.com
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
X-Mailman-Approved-At: Fri, 10 Jul 2020 08:57:17 -0400
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

Chih-Min Chao (2):
  fpu: fix float16 nan check
  fpu: add api to handle alternative sNaN propagation

Frank Chang (58):
  target/riscv: fix rsub gvec tcg_assert_listed_vecop assertion
  target/riscv: correct the gvec IR called in gen_vec_rsub16_i64()
  target/riscv: fix return value of do_opivx_widen()
  target/riscv: fix vill bit index in vtype register
  target/riscv: remove vsll.vi, vsrl.vi, vsra.vi insns from using gvec
  target/riscv: rvv-0.9: remove MLEN calculations
  target/riscv: rvv-0.9: add fractional LMUL, VTA and VMA
  target/riscv: rvv-0.9: update check functions
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
  target/riscv: rvv-0.9: integer scalar move instructions
  target/riscv: rvv-0.9: floating-point scalar move instructions
  target/riscv: rvv-0.9: whole register move instructions
  target/riscv: rvv-0.9: integer extension instructions
  target/riscv: rvv-0.9: single-width averaging add and subtract
    instructions
  target/riscv: rvv-0.9: integer add-with-carry/subtract-with-borrow
  target/riscv: rvv-0.9: narrowing integer right shift instructions
  target/riscv: rvv-0.9: widening integer multiply-add instructions
  target/riscv: rvv-0.9: quad-widening integer multiply-add instructions
  target/riscv: rvv-0.9: integer merge and move instructions
  target/riscv: rvv-0.9: single-width saturating add and subtract
    instructions
  target/riscv: rvv-0.9: integer comparison instructions
  target/riscv: rvv-0.9: floating-point compare instructions
  target/riscv: rvv-0.9: single-width integer reduction instructions
  target/riscv: rvv-0.9: widening integer reduction instructions
  target/riscv: rvv-0.9: mask-register logical instructions
  target/riscv: rvv-0.9: register gather instructions
  target/riscv: rvv-0.9: slide instructions
  target/riscv: rvv-0.9: floating-point slide instructions
  target/riscv: rvv-0.9: narrowing fixed-point clip instructions
  target/riscv: rvv-0.9: floating-point move instructions
  target/riscv: rvv-0.9: floating-point/integer type-convert
    instructions
  target/riscv: rvv-0.9: single-width floating-point reduction
  target/riscv: rvv-0.9: widening floating-point reduction instructions
  target/riscv: rvv-0.9: single-width scaling shift instructions
  target/riscv: rvv-0.9: remove widening saturating scaled multiply-add
  target/riscv: rvv-0.9: remove vmford.vv and vmford.vf
  target/riscv: rvv-0.9: remove integer extract instruction
  target/riscv: rvv-0.9: floating-point min/max instructions
  target/riscv: rvv-0.9: widening floating-point/integer type-convert
  target/riscv: rvv-0.9: narrowing floating-point/integer type-convert
  softfloat: add fp16 and uint8/int8 interconvert functions
  target/riscv: use softfloat lib float16 comparison functions
  target/riscv: bump to RVV 0.9

Kito Cheng (1):
  fpu: implement full set compare for fp16

LIU Zhiwei (4):
  target/riscv: rvv-0.9: add vcsr register
  target/riscv: rvv-0.9: add vector context status
  target/riscv: rvv-0.9: update mstatus_vs by tb_flags
  target/riscv: rvv-0.9: add vlenb register

 fpu/softfloat-specialize.inc.c          |    4 +-
 fpu/softfloat.c                         |  342 +++-
 include/fpu/softfloat.h                 |   22 +
 target/riscv/cpu.c                      |    9 +-
 target/riscv/cpu.h                      |   68 +-
 target/riscv/cpu_bits.h                 |    9 +
 target/riscv/cpu_helper.c               |   13 +
 target/riscv/csr.c                      |   53 +-
 target/riscv/helper.h                   |  507 +++--
 target/riscv/insn32-64.decode           |   18 +-
 target/riscv/insn32.decode              |  282 +--
 target/riscv/insn_trans/trans_rvv.inc.c | 2468 ++++++++++++++---------
 target/riscv/internals.h                |   18 +-
 target/riscv/translate.c                |   43 +-
 target/riscv/vector_helper.c            | 2349 +++++++++++----------
 15 files changed, 3833 insertions(+), 2372 deletions(-)

--
2.17.1


