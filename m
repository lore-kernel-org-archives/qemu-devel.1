Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19A2DC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 16:57:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8D0F2078B
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 16:57:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jBniptIC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8D0F2078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAyjM-000265-3q
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 12:57:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57380)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kAyiZ-0001Wu-M1; Wed, 26 Aug 2020 12:56:11 -0400
Received: from mail-il1-x143.google.com ([2607:f8b0:4864:20::143]:45778)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kAyiW-0003Bn-V4; Wed, 26 Aug 2020 12:56:11 -0400
Received: by mail-il1-x143.google.com with SMTP id k4so2365219ilr.12;
 Wed, 26 Aug 2020 09:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=1yctldKr0wzYTBMSQmLZXZK7xKPnrNzao1VcYREm7EA=;
 b=jBniptICDuPEWiigXMZg6ofwiWoUzUBsTGb4CHLNx226xOrvqcK5Ui3fPZtGC9EfJ3
 HC8TT/ZT52FvqLnWo/zFRRb4Hfx1Tu6bPqrBIv6PWLUGbjA3cDq4r8KnOTjdM5fxTf/s
 nkBW6xYoiHJGfSc3jFA3/50y0R6JorP4G0sylrez8HnAJxUrDG72MvxPBwmcbKd+zzq+
 qs6wXCSAJbM5+LlQ5aDFEtsDX9Cy2QSQgqQb13oJ45UfpB5vj9+ij6dT2de6b0SZVE/C
 +pa+/9eqKDZ/KUzj0wxdk2OyJYTgkiGepPGupEqdoW52GiR98LYRsGIbICl+L73on26X
 4asg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=1yctldKr0wzYTBMSQmLZXZK7xKPnrNzao1VcYREm7EA=;
 b=P/KgtZVhjSRDqM9HDpev1RIXzIo+65Nk8KPKMxb4J6Iopa/8CHdlsBoKkhySghodWg
 yrz/YIqDOKAKXqzhSjvXtb8LgdXKFZRfNeKPUs5DQ+ReyxyEhRWWJ+0C3A/QKd4L9izt
 LpNOyvGiXVBLlvCclkIVD3snEnGE+YcwoZOWRll8jWyJZJyqXavDdN0C6yxz8vVZoY00
 rx+YgX7G5jxx7xeu5w3jJg6or2ezdO3Vs4E/HKDJGo1wBs2kpxsoqrgrjS1VYNP2scZ/
 2N4V7rMfUxIrYP+PPQOa75WVCNWnrx7P7ex1cW6vOA3oxGczCJyr/mwGfYMNy+wfWc/s
 ifUA==
X-Gm-Message-State: AOAM5303wvaANc9E3VrWoL9pThXyp+Gd1eQbkXesf13KaKz2QABl02ds
 WsuKObMh5t4FnGl8D3aNklWoP1Y9Faox5PLC6Z4=
X-Google-Smtp-Source: ABdhPJx9Y3T0Gz0Ny6XIs4fhZeXVLFKdNlBzaJ6bD/PT8K11nW70BXBRAndgAb0fRXU6MlC8XsW+Lg4zcJnBtcQDL9s=
X-Received: by 2002:a92:c7d4:: with SMTP id g20mr14214722ilk.40.1598460966560; 
 Wed, 26 Aug 2020 09:56:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200817084955.28793-1-frank.chang@sifive.com>
 <CAE_xrPjmrmwVW3YOTXLVuVpvT=mT+gnwKJy+yYjo6t24xC8ZDg@mail.gmail.com>
In-Reply-To: <CAE_xrPjmrmwVW3YOTXLVuVpvT=mT+gnwKJy+yYjo6t24xC8ZDg@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 26 Aug 2020 09:45:22 -0700
Message-ID: <CAKmqyKOU8MUAaiCadAEp4YwArJOpsPRbd_sQmmTDO8g=v-Nw2g@mail.gmail.com>
Subject: Re: [RFC v4 00/70] support vector extension v1.0
To: Frank Chang <frank.chang@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::143;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x143.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Aug 25, 2020 at 1:29 AM Frank Chang <frank.chang@sifive.com> wrote:
>
> On Mon, Aug 17, 2020 at 4:50 PM <frank.chang@sifive.com> wrote:
>>
>> From: Frank Chang <frank.chang@sifive.com>
>>
>> This patchset implements the vector extension v1.0 for RISC-V on QEMU.
>>
>> This patchset is sent as RFC because RVV v1.0 is still in draft state.
>> v2 patchset was sent for RVV v0.9 and bumped to RVV v1.0 since v3 patchset.
>>
>> The port is available here:
>> https://github.com/sifive/qemu/tree/rvv-1.0-upstream-v4
>>
>> You can change the cpu argument: vext_spec to v1.0 (i.e. vext_spec=v1.0)
>> to run with RVV v1.0 instructions.
>>
>> Note: This patchset depends on two other patchsets listed in Based-on
>>       section below so it might not able to be built unless those two
>>       patchsets are applied.
>>
>> Changelog:
>>
>> v4
>>   * remove explicit float flmul variable in DisasContext.
>>   * replace floating-point calculations with shift operations to
>>     improve performance.
>>   * relax RV_VLEN_MAX to 512-bits.
>>
>> v3
>>   * apply nan-box helpers from Richard Henderson.
>>   * remove fp16 api changes as they are sent independently in another
>>     pathcset by Chih-Min Chao.
>>   * remove all tail elements clear functions as tail elements can
>>     retain unchanged for either VTA set to undisturbed or agnostic.
>>   * add fp16 nan-box check generator function.
>>   * add floating-point rounding mode enum.
>>   * replace flmul arithmetic with shifts to avoid floating-point
>>     conversions.
>>   * add Zvqmac extension.
>>   * replace gdbstub vector register xml files with dynamic generator.
>>   * bumped to RVV v1.0.
>>   * RVV v1.0 related changes:
>>     * add vl<nf>re<eew>.v and vs<nf>r.v vector whole register
>>       load/store instructions
>>     * add vrgatherei16 instruction.
>>     * rearranged bits in vtype to make vlmul bits into a contiguous
>>       field.
>>
>> v2
>>   * drop v0.7.1 support.
>>   * replace invisible return check macros with functions.
>>   * move mark_vs_dirty() to translators.
>>   * add SSTATUS_VS flag for s-mode.
>>   * nan-box scalar fp register for floating-point operations.
>>   * add gdbstub files for vector registers to allow system-mode
>>     debugging with GDB.
>>
>> Based-on: <20200724002807.441147-1-richard.henderson@linaro.org/>
>> Based-on: <1596102747-20226-1-git-send-email-chihmin.chao@sifive.com/>
>>
>> Frank Chang (62):
>>   target/riscv: drop vector 0.7.1 and add 1.0 support
>>   target/riscv: Use FIELD_EX32() to extract wd field
>>   target/riscv: rvv-1.0: introduce writable misa.v field
>>   target/riscv: rvv-1.0: remove rvv related codes from fcsr registers
>>   target/riscv: rvv-1.0: check MSTATUS_VS when accessing vector csr
>>     registers
>>   target/riscv: rvv-1.0: remove MLEN calculations
>>   target/riscv: rvv-1.0: add fractional LMUL
>>   target/riscv: rvv-1.0: add VMA and VTA
>>   target/riscv: rvv-1.0: update check functions
>>   target/riscv: introduce more imm value modes in translator functions
>>   target/riscv: rvv:1.0: add translation-time nan-box helper function
>>   target/riscv: rvv-1.0: configure instructions
>>   target/riscv: rvv-1.0: stride load and store instructions
>>   target/riscv: rvv-1.0: index load and store instructions
>>   target/riscv: rvv-1.0: fix address index overflow bug of indexed
>>     load/store insns
>>   target/riscv: rvv-1.0: fault-only-first unit stride load
>>   target/riscv: rvv-1.0: amo operations
>>   target/riscv: rvv-1.0: load/store whole register instructions
>>   target/riscv: rvv-1.0: update vext_max_elems() for load/store insns
>>   target/riscv: rvv-1.0: take fractional LMUL into vector max elements
>>     calculation
>>   target/riscv: rvv-1.0: floating-point square-root instruction
>>   target/riscv: rvv-1.0: floating-point classify instructions
>>   target/riscv: rvv-1.0: mask population count instruction
>>   target/riscv: rvv-1.0: find-first-set mask bit instruction
>>   target/riscv: rvv-1.0: set-X-first mask bit instructions
>>   target/riscv: rvv-1.0: iota instruction
>>   target/riscv: rvv-1.0: element index instruction
>>   target/riscv: rvv-1.0: allow load element with sign-extended
>>   target/riscv: rvv-1.0: register gather instructions
>>   target/riscv: rvv-1.0: integer scalar move instructions
>>   target/riscv: rvv-1.0: floating-point move instruction
>>   target/riscv: rvv-1.0: floating-point scalar move instructions
>>   target/riscv: rvv-1.0: whole register move instructions
>>   target/riscv: rvv-1.0: integer extension instructions
>>   target/riscv: rvv-1.0: single-width averaging add and subtract
>>     instructions
>>   target/riscv: rvv-1.0: single-width bit shift instructions
>>   target/riscv: rvv-1.0: integer add-with-carry/subtract-with-borrow
>>   target/riscv: rvv-1.0: narrowing integer right shift instructions
>>   target/riscv: rvv-1.0: widening integer multiply-add instructions
>>   target/riscv: rvv-1.0: add Zvqmac extension
>>   target/riscv: rvv-1.0: quad-widening integer multiply-add instructions
>>   target/riscv: rvv-1.0: single-width saturating add and subtract
>>     instructions
>>   target/riscv: rvv-1.0: integer comparison instructions
>>   target/riscv: use softfloat lib float16 comparison functions
>>   target/riscv: rvv-1.0: floating-point compare instructions
>>   target/riscv: rvv-1.0: mask-register logical instructions
>>   target/riscv: rvv-1.0: slide instructions
>>   target/riscv: rvv-1.0: floating-point slide instructions
>>   target/riscv: rvv-1.0: narrowing fixed-point clip instructions
>>   target/riscv: rvv-1.0: single-width floating-point reduction
>>   target/riscv: rvv-1.0: widening floating-point reduction instructions
>>   target/riscv: rvv-1.0: single-width scaling shift instructions
>>   target/riscv: rvv-1.0: remove widening saturating scaled multiply-add
>>   target/riscv: rvv-1.0: remove vmford.vv and vmford.vf
>>   target/riscv: rvv-1.0: remove integer extract instruction
>>   target/riscv: rvv-1.0: floating-point min/max instructions
>>   target/riscv: introduce floating-point rounding mode enum
>>   target/riscv: rvv-1.0: floating-point/integer type-convert
>>     instructions
>>   target/riscv: rvv-1.0: widening floating-point/integer type-convert
>>   target/riscv: add "set round to odd" rounding mode helper function
>>   target/riscv: rvv-1.0: narrowing floating-point/integer type-convert
>>   target/riscv: rvv-1.0: relax RV_VLEN_MAX to 512-bits
>>
>> Greentime Hu (2):
>>   target/riscv: rvv-1.0: add vlenb register
>>   target/riscv: gdb: support vector registers for rv32
>>
>> Hsiangkai Wang (2):
>>   target/riscv: gdb: modify gdb csr xml file to align with csr register
>>     map
>>   target/riscv: gdb: support vector registers for rv64
>>
>> LIU Zhiwei (4):
>>   target/riscv: rvv-1.0: add mstatus VS field
>>   target/riscv: rvv-1.0: add sstatus VS field
>>   target/riscv: rvv-1.0: add translation-time vector context status
>>   target/riscv: rvv-1.0: add vcsr register
>>
>>  gdb-xml/riscv-32bit-csr.xml             |   18 +-
>>  gdb-xml/riscv-64bit-csr.xml             |   18 +-
>>  target/riscv/cpu.c                      |   12 +-
>>  target/riscv/cpu.h                      |   97 +-
>>  target/riscv/cpu_bits.h                 |   10 +
>>  target/riscv/cpu_helper.c               |   16 +-
>>  target/riscv/csr.c                      |   73 +-
>>  target/riscv/fpu_helper.c               |   17 +-
>>  target/riscv/gdbstub.c                  |  126 +-
>>  target/riscv/helper.h                   |  523 ++--
>>  target/riscv/insn32-64.decode           |   18 +-
>>  target/riscv/insn32.decode              |  295 +-
>>  target/riscv/insn_trans/trans_rvv.inc.c | 2366 ++++++++++------
>>  target/riscv/internals.h                |   19 +-
>>  target/riscv/translate.c                |   68 +-
>>  target/riscv/vector_helper.c            | 3269 +++++++++++------------
>>  16 files changed, 4051 insertions(+), 2894 deletions(-)
>>
>> --
>> 2.17.1
>>
>
> ping~

I wasn't really following too closely, but didn't Richard give comments?

Alistair

