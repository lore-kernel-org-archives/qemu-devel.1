Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D97DCC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 16:08:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6F99206F0
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 16:08:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GlU0QmVp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6F99206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jv103-00013L-0S
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 12:08:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53940)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jv0zB-0000Yz-Hm; Mon, 13 Jul 2020 12:07:22 -0400
Received: from mail-il1-x144.google.com ([2607:f8b0:4864:20::144]:42322)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jv0z9-000125-0c; Mon, 13 Jul 2020 12:07:21 -0400
Received: by mail-il1-x144.google.com with SMTP id t27so11602237ill.9;
 Mon, 13 Jul 2020 09:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=HpNwDkjbAjSXBiPl0FouqOW2uw+pxK/VxO7S+jX4ZS4=;
 b=GlU0QmVpHJ4uDJJ+w93sYtHjcLLH7kFM8hzdiCkYnS81L1ffWskK/Wql8wDwN0P5EN
 eXi47/6CQ4ZzsbrF5axBVLrriicnR35DUx5FjknecqozBiYAhI9ssrDzr5Eyckf7blsG
 PQ1sCDzIMpbO1cfDYBZMSSYCKCDEiY8wrM0RWJtGtZzygtk7zznAqNTkqceLbSAoxfi0
 pCYFv9u9YCDPAu8RgeWETFV1UVIhwqofIqvSW29lzmGyqNOR7TVd18CPiGQzKEgPLXYO
 BI6EFnntSwO0PsF9+OibSRsO7pW20IKYBSxEgjQnR2CrQ/vU72FIeSug8JVRVoBimLEo
 mnog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=HpNwDkjbAjSXBiPl0FouqOW2uw+pxK/VxO7S+jX4ZS4=;
 b=pIGH+YLlTvqOJqS4UB6njgVIrniZeS/Oqr4JJWV27gMJzPb551l7TgWotsChhHPvqz
 3Qel0Ys3cRC3RpKxjepwomhdWUx6/cE1KL+aKte3D3y7IboyOfn6cySO2zL01vjc095f
 949eWczVPNmXWUX/VBHczZizDYCmL5rluCe+mI0bfrrLoedXk0XdUj8lCgtyeRcCK09z
 TTfKjDuvwUUNY/i5/9tLw1uU1bIg+GcMQaoE9VpEbuXQWNzSlZhxxKuVB/5WHMOdAGji
 iIS+ryBB8KlcMxZuE1VlibuYx7lJMS+IolrGOeUXb4gpQ708alpeYZDqQ4iJMWm1G0Gq
 J1bQ==
X-Gm-Message-State: AOAM533EQZB88eCXRH9tDQpT4eV9lYBjyt+P8AqDxpFUkJoySdraCaPX
 bWB5NXoub51OhfxZ0/VHHd/T/gtR7mzKXSnuiS0=
X-Google-Smtp-Source: ABdhPJzF9C64BKYuYbqrHztblyhP/FTVGXLzp/QTaaTLCDqiTO0d4N1EWg9+MgX9JCr9OISEYJT0sn79O22Ry7/+eTY=
X-Received: by 2002:a92:bb84:: with SMTP id x4mr402400ilk.177.1594656437199;
 Mon, 13 Jul 2020 09:07:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200710104920.13550-1-frank.chang@sifive.com>
 <CAKmqyKPtKtD=G+tXcd2Y-TM2go1TWbETHK2e3vdN-ehHyHU9-w@mail.gmail.com>
 <CAE_xrPhEW_VSRQVkthwu0NmBQYBZ11phLRgSbFqqFc9wZZ38Xg@mail.gmail.com>
In-Reply-To: <CAE_xrPhEW_VSRQVkthwu0NmBQYBZ11phLRgSbFqqFc9wZZ38Xg@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 13 Jul 2020 08:57:19 -0700
Message-ID: <CAKmqyKO8Hw+RmcjycODbpW18z+3MTxR3wKMz0i3dD0WBS+YFwA@mail.gmail.com>
Subject: Re: [RFC 00/65] target/riscv: support vector extension v0.9
To: Frank Chang <frank.chang@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::144;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x144.google.com
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

On Sun, Jul 12, 2020 at 7:02 PM Frank Chang <frank.chang@sifive.com> wrote:
>
> On Sat, Jul 11, 2020 at 5:53 AM Alistair Francis <alistair23@gmail.com> wrote:
>>
>> On Fri, Jul 10, 2020 at 5:59 AM <frank.chang@sifive.com> wrote:
>> >
>> > From: Frank Chang <frank.chang@sifive.com>
>> >
>> > This patchset implements the vector extension v0.9 for RISC-V on QEMU.
>> >
>> > This patchset is sent as RFC because RVV v0.9 is still in draft state.
>> > However, as RVV v1.0 should be ratified soon and there shouldn't be
>> > critical changes between RVV v1.0 and RVV v0.9. We would like to have
>> > the community to review RVV v0.9 implementations. Once RVV v1.0 is
>> > ratified, we will then upgrade to RVV v1.0.
>> >
>> > You can change the cpu argument: vext_spec to v0.9 (i.e. vext_spec=v0.9)
>> > to run with RVV v0.9 instructions.
>>
>> Hello,
>>
>> First off thanks for the patches!
>>
>> QEMU has a policy of accepting draft specs as experimental. We
>> currently support the v0.7.1 Vector extension for example, so this
>> does not need to be an RFC and can be a full patch series that can be
>> merged into master.
>>
>> I have applied the first few patches (PR should be out next week) and
>> they should be in the QEMU 5.1 release. QEMU is currently in a freeze
>> so I won't be able to merge this series for 5.1. In saying that please
>> feel free to continue to send patches to the list, they can still be
>> reviewed.
>>
>> In general we would need to gracefully handle extension upgrades and
>> maintain backwards compatibility. This same principle doesn't apply to
>> experimental features though (such as the vector extension) so you are
>> free to remove support for the v0.7.1. For users who want v0.7.1
>> support they can always use the QEMU 5.1. release. Just make sure that
>> your series does not break bisectability.
>>
>> Thanks again for the patches!
>>
>> Alistair
>
>
> Hi Alistair,
>
> Thanks for the review.
>
> Currently I would prefer to drop 0.7.1 support because I don't know if there's
> a good way to keep both 0.7.1 and 0.9 opcodes. I'm afraid it would cause the
> encoding overlap while compiling with decodetree.

That's fine. The plan was always to only support one version of a
draft extension (and none when the final spec is frozen).

>
> Does decodetree support any feature for multi-version opcodes?

I'm not sure, but we don't want to deal with the maintenance burden of
two draft extensions anyway.

> Or if it can use something like C macros to compile with the opcodes by the vspec
> user assigned? If there's any good way to keep both versions, then I can try to rearrange
> my codes to support both vspecs.
>
> Otherwise, I'll keep on my current approach to drop the support of v0.7.1 as the way
> Richard has mentioned:
> If you don't want to simultaneously support 0.7.1 and 0.9/1.0, then you should
> simply remove 0.7.1 in the first patch, so that there's no confusion.

That sounds good :)

Alistair

>
> Any suggestion would be appreciated.
>
> Thanks
> --
> Frank Chang
>
>>
>> >
>> > Chih-Min Chao (2):
>> >   fpu: fix float16 nan check
>> >   fpu: add api to handle alternative sNaN propagation
>> >
>> > Frank Chang (58):
>> >   target/riscv: fix rsub gvec tcg_assert_listed_vecop assertion
>> >   target/riscv: correct the gvec IR called in gen_vec_rsub16_i64()
>> >   target/riscv: fix return value of do_opivx_widen()
>> >   target/riscv: fix vill bit index in vtype register
>> >   target/riscv: remove vsll.vi, vsrl.vi, vsra.vi insns from using gvec
>> >   target/riscv: rvv-0.9: remove MLEN calculations
>> >   target/riscv: rvv-0.9: add fractional LMUL, VTA and VMA
>> >   target/riscv: rvv-0.9: update check functions
>> >   target/riscv: rvv-0.9: configure instructions
>> >   target/riscv: rvv-0.9: stride load and store instructions
>> >   target/riscv: rvv-0.9: index load and store instructions
>> >   target/riscv: rvv-0.9: fix address index overflow bug of indexed
>> >     load/store insns
>> >   target/riscv: rvv-0.9: fault-only-first unit stride load
>> >   target/riscv: rvv-0.9: amo operations
>> >   target/riscv: rvv-0.9: load/store whole register instructions
>> >   target/riscv: rvv-0.9: update vext_max_elems() for load/store insns
>> >   target/riscv: rvv-0.9: take fractional LMUL into vector max elements
>> >     calculation
>> >   target/riscv: rvv-0.9: floating-point square-root instruction
>> >   target/riscv: rvv-0.9: floating-point classify instructions
>> >   target/riscv: rvv-0.9: mask population count instruction
>> >   target/riscv: rvv-0.9: find-first-set mask bit instruction
>> >   target/riscv: rvv-0.9: set-X-first mask bit instructions
>> >   target/riscv: rvv-0.9: iota instruction
>> >   target/riscv: rvv-0.9: element index instruction
>> >   target/riscv: rvv-0.9: integer scalar move instructions
>> >   target/riscv: rvv-0.9: floating-point scalar move instructions
>> >   target/riscv: rvv-0.9: whole register move instructions
>> >   target/riscv: rvv-0.9: integer extension instructions
>> >   target/riscv: rvv-0.9: single-width averaging add and subtract
>> >     instructions
>> >   target/riscv: rvv-0.9: integer add-with-carry/subtract-with-borrow
>> >   target/riscv: rvv-0.9: narrowing integer right shift instructions
>> >   target/riscv: rvv-0.9: widening integer multiply-add instructions
>> >   target/riscv: rvv-0.9: quad-widening integer multiply-add instructions
>> >   target/riscv: rvv-0.9: integer merge and move instructions
>> >   target/riscv: rvv-0.9: single-width saturating add and subtract
>> >     instructions
>> >   target/riscv: rvv-0.9: integer comparison instructions
>> >   target/riscv: rvv-0.9: floating-point compare instructions
>> >   target/riscv: rvv-0.9: single-width integer reduction instructions
>> >   target/riscv: rvv-0.9: widening integer reduction instructions
>> >   target/riscv: rvv-0.9: mask-register logical instructions
>> >   target/riscv: rvv-0.9: register gather instructions
>> >   target/riscv: rvv-0.9: slide instructions
>> >   target/riscv: rvv-0.9: floating-point slide instructions
>> >   target/riscv: rvv-0.9: narrowing fixed-point clip instructions
>> >   target/riscv: rvv-0.9: floating-point move instructions
>> >   target/riscv: rvv-0.9: floating-point/integer type-convert
>> >     instructions
>> >   target/riscv: rvv-0.9: single-width floating-point reduction
>> >   target/riscv: rvv-0.9: widening floating-point reduction instructions
>> >   target/riscv: rvv-0.9: single-width scaling shift instructions
>> >   target/riscv: rvv-0.9: remove widening saturating scaled multiply-add
>> >   target/riscv: rvv-0.9: remove vmford.vv and vmford.vf
>> >   target/riscv: rvv-0.9: remove integer extract instruction
>> >   target/riscv: rvv-0.9: floating-point min/max instructions
>> >   target/riscv: rvv-0.9: widening floating-point/integer type-convert
>> >   target/riscv: rvv-0.9: narrowing floating-point/integer type-convert
>> >   softfloat: add fp16 and uint8/int8 interconvert functions
>> >   target/riscv: use softfloat lib float16 comparison functions
>> >   target/riscv: bump to RVV 0.9
>> >
>> > Kito Cheng (1):
>> >   fpu: implement full set compare for fp16
>> >
>> > LIU Zhiwei (4):
>> >   target/riscv: rvv-0.9: add vcsr register
>> >   target/riscv: rvv-0.9: add vector context status
>> >   target/riscv: rvv-0.9: update mstatus_vs by tb_flags
>> >   target/riscv: rvv-0.9: add vlenb register
>> >
>> >  fpu/softfloat-specialize.inc.c          |    4 +-
>> >  fpu/softfloat.c                         |  342 +++-
>> >  include/fpu/softfloat.h                 |   22 +
>> >  target/riscv/cpu.c                      |    9 +-
>> >  target/riscv/cpu.h                      |   68 +-
>> >  target/riscv/cpu_bits.h                 |    9 +
>> >  target/riscv/cpu_helper.c               |   13 +
>> >  target/riscv/csr.c                      |   53 +-
>> >  target/riscv/helper.h                   |  507 +++--
>> >  target/riscv/insn32-64.decode           |   18 +-
>> >  target/riscv/insn32.decode              |  282 +--
>> >  target/riscv/insn_trans/trans_rvv.inc.c | 2468 ++++++++++++++---------
>> >  target/riscv/internals.h                |   18 +-
>> >  target/riscv/translate.c                |   43 +-
>> >  target/riscv/vector_helper.c            | 2349 +++++++++++----------
>> >  15 files changed, 3833 insertions(+), 2372 deletions(-)
>> >
>> > --
>> > 2.17.1
>> >
>> >

