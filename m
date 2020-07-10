Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE6DEC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 21:54:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 847B420725
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 21:54:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t7giLv8n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 847B420725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ju0yD-0007b7-RY
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 17:54:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59412)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ju0xW-00075U-BM; Fri, 10 Jul 2020 17:53:30 -0400
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:37794)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ju0xU-0006H7-Fl; Fri, 10 Jul 2020 17:53:30 -0400
Received: by mail-io1-xd43.google.com with SMTP id v6so7574453iob.4;
 Fri, 10 Jul 2020 14:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=iILW2C0CZbd0qowWzJCMVpU4Tnx9A8dYXb0tFkk7hbU=;
 b=t7giLv8nCrXRfGwUoUnqbgcodn/+306NXdpfZkF6Zhpd3WlMO2b+GjOHKxS7RkYwIz
 CnZBfalq0oo5oS9gYoZ7PP8FLoJpwq0t8b1faWKt5+4UFLQ9vNP62TUYD0d05AepQhyO
 V0Gwcc/6AKyYRN3mDbkYBVeytwqnUZUPyH38ZVED8D0v8QBe6yQMSC+fPPsk3hvjf3Bh
 +j+140Vj9oaL4P2SnjdAbwQdKtlWb96n4G3f0siDYJX1TeJAmHZCbpByZ5GXqSXY1BdA
 eNnM6aSbaQ/DKkCp1sh9eNWivI1w9Pmj3btVjy32bBie/IReKKnRAs1clr1dacRXXYSR
 sztw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=iILW2C0CZbd0qowWzJCMVpU4Tnx9A8dYXb0tFkk7hbU=;
 b=Y8bN4sxpY3N/FvDkKWoOs57Hn6BowP35aYBIazyIDM2H/jaUPs4uGWVh2FiAuC0FA6
 EMrnKwvegt3Iv3mF02m2jHxH/L+1uYEseXCeZTjlnjAStRlQvPF1IUmhEZz8ltwNTMxC
 0Cerkd4ibsYsBwwhulgigeto8xgEtI5hL0IqLIve5+Z/rGCbfPOSxnhSwnYSfs1SM4gy
 Ebwh5U/K7CexoUlCo7u85nJ5z+TNHT/hshoYN2DuBzwn8JVnKvZXR+axl7iB/+oswXbj
 akgqHz/kzeNcf+tR9DWAgNytdKOlHwnNQ+E+7eK+rfaNSkRSR0hqg2oizzt9kpV8ednF
 F3BA==
X-Gm-Message-State: AOAM5332y15NdDscq/fSkk+HDoCf/QcVoO832KWZHmQtJWowr4aRHZ/M
 kJ093S8XIxUFj7Hsi+65LdN1Wgp/gk5CZK1QFZWHXsRt+g4=
X-Google-Smtp-Source: ABdhPJyE+L3gOUdRLmq1yB+gtJqrnJzV07rTt2rkzkMVqpeMFifZtmZkaCIJqobc0XgqH3bOa91qi+THTQPNtTSXIBw=
X-Received: by 2002:a02:878b:: with SMTP id t11mr976365jai.106.1594418006632; 
 Fri, 10 Jul 2020 14:53:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200710104920.13550-1-frank.chang@sifive.com>
In-Reply-To: <20200710104920.13550-1-frank.chang@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 10 Jul 2020 14:43:32 -0700
Message-ID: <CAKmqyKPtKtD=G+tXcd2Y-TM2go1TWbETHK2e3vdN-ehHyHU9-w@mail.gmail.com>
Subject: Re: [RFC 00/65] target/riscv: support vector extension v0.9
To: frank.chang@sifive.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d43;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd43.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jul 10, 2020 at 5:59 AM <frank.chang@sifive.com> wrote:
>
> From: Frank Chang <frank.chang@sifive.com>
>
> This patchset implements the vector extension v0.9 for RISC-V on QEMU.
>
> This patchset is sent as RFC because RVV v0.9 is still in draft state.
> However, as RVV v1.0 should be ratified soon and there shouldn't be
> critical changes between RVV v1.0 and RVV v0.9. We would like to have
> the community to review RVV v0.9 implementations. Once RVV v1.0 is
> ratified, we will then upgrade to RVV v1.0.
>
> You can change the cpu argument: vext_spec to v0.9 (i.e. vext_spec=v0.9)
> to run with RVV v0.9 instructions.

Hello,

First off thanks for the patches!

QEMU has a policy of accepting draft specs as experimental. We
currently support the v0.7.1 Vector extension for example, so this
does not need to be an RFC and can be a full patch series that can be
merged into master.

I have applied the first few patches (PR should be out next week) and
they should be in the QEMU 5.1 release. QEMU is currently in a freeze
so I won't be able to merge this series for 5.1. In saying that please
feel free to continue to send patches to the list, they can still be
reviewed.

In general we would need to gracefully handle extension upgrades and
maintain backwards compatibility. This same principle doesn't apply to
experimental features though (such as the vector extension) so you are
free to remove support for the v0.7.1. For users who want v0.7.1
support they can always use the QEMU 5.1. release. Just make sure that
your series does not break bisectability.

Thanks again for the patches!

Alistair

>
> Chih-Min Chao (2):
>   fpu: fix float16 nan check
>   fpu: add api to handle alternative sNaN propagation
>
> Frank Chang (58):
>   target/riscv: fix rsub gvec tcg_assert_listed_vecop assertion
>   target/riscv: correct the gvec IR called in gen_vec_rsub16_i64()
>   target/riscv: fix return value of do_opivx_widen()
>   target/riscv: fix vill bit index in vtype register
>   target/riscv: remove vsll.vi, vsrl.vi, vsra.vi insns from using gvec
>   target/riscv: rvv-0.9: remove MLEN calculations
>   target/riscv: rvv-0.9: add fractional LMUL, VTA and VMA
>   target/riscv: rvv-0.9: update check functions
>   target/riscv: rvv-0.9: configure instructions
>   target/riscv: rvv-0.9: stride load and store instructions
>   target/riscv: rvv-0.9: index load and store instructions
>   target/riscv: rvv-0.9: fix address index overflow bug of indexed
>     load/store insns
>   target/riscv: rvv-0.9: fault-only-first unit stride load
>   target/riscv: rvv-0.9: amo operations
>   target/riscv: rvv-0.9: load/store whole register instructions
>   target/riscv: rvv-0.9: update vext_max_elems() for load/store insns
>   target/riscv: rvv-0.9: take fractional LMUL into vector max elements
>     calculation
>   target/riscv: rvv-0.9: floating-point square-root instruction
>   target/riscv: rvv-0.9: floating-point classify instructions
>   target/riscv: rvv-0.9: mask population count instruction
>   target/riscv: rvv-0.9: find-first-set mask bit instruction
>   target/riscv: rvv-0.9: set-X-first mask bit instructions
>   target/riscv: rvv-0.9: iota instruction
>   target/riscv: rvv-0.9: element index instruction
>   target/riscv: rvv-0.9: integer scalar move instructions
>   target/riscv: rvv-0.9: floating-point scalar move instructions
>   target/riscv: rvv-0.9: whole register move instructions
>   target/riscv: rvv-0.9: integer extension instructions
>   target/riscv: rvv-0.9: single-width averaging add and subtract
>     instructions
>   target/riscv: rvv-0.9: integer add-with-carry/subtract-with-borrow
>   target/riscv: rvv-0.9: narrowing integer right shift instructions
>   target/riscv: rvv-0.9: widening integer multiply-add instructions
>   target/riscv: rvv-0.9: quad-widening integer multiply-add instructions
>   target/riscv: rvv-0.9: integer merge and move instructions
>   target/riscv: rvv-0.9: single-width saturating add and subtract
>     instructions
>   target/riscv: rvv-0.9: integer comparison instructions
>   target/riscv: rvv-0.9: floating-point compare instructions
>   target/riscv: rvv-0.9: single-width integer reduction instructions
>   target/riscv: rvv-0.9: widening integer reduction instructions
>   target/riscv: rvv-0.9: mask-register logical instructions
>   target/riscv: rvv-0.9: register gather instructions
>   target/riscv: rvv-0.9: slide instructions
>   target/riscv: rvv-0.9: floating-point slide instructions
>   target/riscv: rvv-0.9: narrowing fixed-point clip instructions
>   target/riscv: rvv-0.9: floating-point move instructions
>   target/riscv: rvv-0.9: floating-point/integer type-convert
>     instructions
>   target/riscv: rvv-0.9: single-width floating-point reduction
>   target/riscv: rvv-0.9: widening floating-point reduction instructions
>   target/riscv: rvv-0.9: single-width scaling shift instructions
>   target/riscv: rvv-0.9: remove widening saturating scaled multiply-add
>   target/riscv: rvv-0.9: remove vmford.vv and vmford.vf
>   target/riscv: rvv-0.9: remove integer extract instruction
>   target/riscv: rvv-0.9: floating-point min/max instructions
>   target/riscv: rvv-0.9: widening floating-point/integer type-convert
>   target/riscv: rvv-0.9: narrowing floating-point/integer type-convert
>   softfloat: add fp16 and uint8/int8 interconvert functions
>   target/riscv: use softfloat lib float16 comparison functions
>   target/riscv: bump to RVV 0.9
>
> Kito Cheng (1):
>   fpu: implement full set compare for fp16
>
> LIU Zhiwei (4):
>   target/riscv: rvv-0.9: add vcsr register
>   target/riscv: rvv-0.9: add vector context status
>   target/riscv: rvv-0.9: update mstatus_vs by tb_flags
>   target/riscv: rvv-0.9: add vlenb register
>
>  fpu/softfloat-specialize.inc.c          |    4 +-
>  fpu/softfloat.c                         |  342 +++-
>  include/fpu/softfloat.h                 |   22 +
>  target/riscv/cpu.c                      |    9 +-
>  target/riscv/cpu.h                      |   68 +-
>  target/riscv/cpu_bits.h                 |    9 +
>  target/riscv/cpu_helper.c               |   13 +
>  target/riscv/csr.c                      |   53 +-
>  target/riscv/helper.h                   |  507 +++--
>  target/riscv/insn32-64.decode           |   18 +-
>  target/riscv/insn32.decode              |  282 +--
>  target/riscv/insn_trans/trans_rvv.inc.c | 2468 ++++++++++++++---------
>  target/riscv/internals.h                |   18 +-
>  target/riscv/translate.c                |   43 +-
>  target/riscv/vector_helper.c            | 2349 +++++++++++----------
>  15 files changed, 3833 insertions(+), 2372 deletions(-)
>
> --
> 2.17.1
>
>

