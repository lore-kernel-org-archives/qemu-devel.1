Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URI_HEX autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A54E5C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 17:41:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60CF6207BC
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 17:41:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="IOkUUEQH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60CF6207BC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAzQd-0001lz-Ks
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 13:41:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41606)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1kAzP5-0000aG-72
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 13:40:07 -0400
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c]:33849)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1kAzP2-0000nK-2P
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 13:40:06 -0400
Received: by mail-ot1-x32c.google.com with SMTP id k20so2199189otr.1
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2020 10:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=1TccKe2pe0QfOjVkUMoetMrxKzlE2O2XzxvDsE+RStk=;
 b=IOkUUEQHwxJZ8KSDnYS8lahRn7vNqTGpKzqjZYhWf8HKJMLMNNJU3vRnIAcV2pPppB
 IN72eASa7I6ZmhCBvddj/vkZOfi+34j4WTOBopl+IpRG1//n1NebSUV4ofY4cF/qklZv
 jMnZ5Ep0yg0Hkq3D3I6uGs0pGr2u6cKELccqvrDwm0M6dizdtURfmStAosHQlvi1NQLX
 ezxn1m1uVJ+XlLZYKvtOqkyf1xwmVwu5RyATYbBpU4o3qxemkedmctKtenvi4gcnxwrw
 qEfp0W/77uu1obL9D2SERYDRebedPwhMH8QMhVWcRwiJmJHU0gL2mpzkDU+ZrhhSRWnQ
 kYfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=1TccKe2pe0QfOjVkUMoetMrxKzlE2O2XzxvDsE+RStk=;
 b=i2TkBcfZaDwKTn9ePhTGRLlIS9zzNjY9riIvGzzpuW9ajzs7qATjdhrQgR6b1JV8eV
 dXxbCuVfp0YWWiF1aj/ec3sWKItt4LyHB+aqmLnZSWf7bYs9JasEt4yoSKdqArDNZIZZ
 v7SKo1uok7viz83hWHJugv7n1gYoz4rBw06KYvfp9W2dCf+hEQNEBGdMKU68upqHMc+m
 2bIgvIo0qJyYHlzfSp1P1H+wrmkT1XaiMOWfeQ59xL6jpjofbyMWUhlBO2qwnzTKgJmJ
 fH2rHMZXlIql7mSs6UyzZav642MSxQBj9fDdRHSSlgxVcL/DN66/sqiigeSyg/ZVGuFK
 jmdg==
X-Gm-Message-State: AOAM532h3bB6yb3ZOzCvNHrt5GW33mEK5uvafEc445NECXCrvBX2NCgl
 1wFcXY2ra/ds+10dVgRO9lGBYET9cmZo8jlZJNzmkA==
X-Google-Smtp-Source: ABdhPJx4FJkN2UewUe2meCMqTH35SQPqpSRfd5Jdp3LLiTJgnLwTaAvR6Gs4s6NG+QxEyiNBQ4N7D0ss8+4tj59y8JE=
X-Received: by 2002:a9d:2:: with SMTP id 2mr9763549ota.175.1598463598839; Wed,
 26 Aug 2020 10:39:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200817084955.28793-1-frank.chang@sifive.com>
 <CAE_xrPjmrmwVW3YOTXLVuVpvT=mT+gnwKJy+yYjo6t24xC8ZDg@mail.gmail.com>
 <CAKmqyKOU8MUAaiCadAEp4YwArJOpsPRbd_sQmmTDO8g=v-Nw2g@mail.gmail.com>
In-Reply-To: <CAKmqyKOU8MUAaiCadAEp4YwArJOpsPRbd_sQmmTDO8g=v-Nw2g@mail.gmail.com>
From: Frank Chang <frank.chang@sifive.com>
Date: Thu, 27 Aug 2020 01:39:47 +0800
Message-ID: <CAE_xrPhcp74tJNqsRzOe++4PboVxEv0O4dEK9yEaK4CWn_VRHQ@mail.gmail.com>
Subject: Re: [RFC v4 00/70] support vector extension v1.0
To: Alistair Francis <alistair23@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000fee3cf05adcb4e90"
Received-SPF: pass client-ip=2607:f8b0:4864:20::32c;
 envelope-from=frank.chang@sifive.com; helo=mail-ot1-x32c.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URI_HEX=0.1 autolearn=unavailable autolearn_force=no
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

--000000000000fee3cf05adcb4e90
Content-Type: text/plain; charset="UTF-8"

On Thu, Aug 27, 2020 at 12:56 AM Alistair Francis <alistair23@gmail.com>
wrote:

> On Tue, Aug 25, 2020 at 1:29 AM Frank Chang <frank.chang@sifive.com>
> wrote:
> >
> > On Mon, Aug 17, 2020 at 4:50 PM <frank.chang@sifive.com> wrote:
> >>
> >> From: Frank Chang <frank.chang@sifive.com>
> >>
> >> This patchset implements the vector extension v1.0 for RISC-V on QEMU.
> >>
> >> This patchset is sent as RFC because RVV v1.0 is still in draft state.
> >> v2 patchset was sent for RVV v0.9 and bumped to RVV v1.0 since v3
> patchset.
> >>
> >> The port is available here:
> >> https://github.com/sifive/qemu/tree/rvv-1.0-upstream-v4
> >>
> >> You can change the cpu argument: vext_spec to v1.0 (i.e. vext_spec=v1.0)
> >> to run with RVV v1.0 instructions.
> >>
> >> Note: This patchset depends on two other patchsets listed in Based-on
> >>       section below so it might not able to be built unless those two
> >>       patchsets are applied.
> >>
> >> Changelog:
> >>
> >> v4
> >>   * remove explicit float flmul variable in DisasContext.
> >>   * replace floating-point calculations with shift operations to
> >>     improve performance.
> >>   * relax RV_VLEN_MAX to 512-bits.
> >>
> >> v3
> >>   * apply nan-box helpers from Richard Henderson.
> >>   * remove fp16 api changes as they are sent independently in another
> >>     pathcset by Chih-Min Chao.
> >>   * remove all tail elements clear functions as tail elements can
> >>     retain unchanged for either VTA set to undisturbed or agnostic.
> >>   * add fp16 nan-box check generator function.
> >>   * add floating-point rounding mode enum.
> >>   * replace flmul arithmetic with shifts to avoid floating-point
> >>     conversions.
> >>   * add Zvqmac extension.
> >>   * replace gdbstub vector register xml files with dynamic generator.
> >>   * bumped to RVV v1.0.
> >>   * RVV v1.0 related changes:
> >>     * add vl<nf>re<eew>.v and vs<nf>r.v vector whole register
> >>       load/store instructions
> >>     * add vrgatherei16 instruction.
> >>     * rearranged bits in vtype to make vlmul bits into a contiguous
> >>       field.
> >>
> >> v2
> >>   * drop v0.7.1 support.
> >>   * replace invisible return check macros with functions.
> >>   * move mark_vs_dirty() to translators.
> >>   * add SSTATUS_VS flag for s-mode.
> >>   * nan-box scalar fp register for floating-point operations.
> >>   * add gdbstub files for vector registers to allow system-mode
> >>     debugging with GDB.
> >>
> >> Based-on: <20200724002807.441147-1-richard.henderson@linaro.org/>
> >> Based-on: <1596102747-20226-1-git-send-email-chihmin.chao@sifive.com/>
> >>
> >> Frank Chang (62):
> >>   target/riscv: drop vector 0.7.1 and add 1.0 support
> >>   target/riscv: Use FIELD_EX32() to extract wd field
> >>   target/riscv: rvv-1.0: introduce writable misa.v field
> >>   target/riscv: rvv-1.0: remove rvv related codes from fcsr registers
> >>   target/riscv: rvv-1.0: check MSTATUS_VS when accessing vector csr
> >>     registers
> >>   target/riscv: rvv-1.0: remove MLEN calculations
> >>   target/riscv: rvv-1.0: add fractional LMUL
> >>   target/riscv: rvv-1.0: add VMA and VTA
> >>   target/riscv: rvv-1.0: update check functions
> >>   target/riscv: introduce more imm value modes in translator functions
> >>   target/riscv: rvv:1.0: add translation-time nan-box helper function
> >>   target/riscv: rvv-1.0: configure instructions
> >>   target/riscv: rvv-1.0: stride load and store instructions
> >>   target/riscv: rvv-1.0: index load and store instructions
> >>   target/riscv: rvv-1.0: fix address index overflow bug of indexed
> >>     load/store insns
> >>   target/riscv: rvv-1.0: fault-only-first unit stride load
> >>   target/riscv: rvv-1.0: amo operations
> >>   target/riscv: rvv-1.0: load/store whole register instructions
> >>   target/riscv: rvv-1.0: update vext_max_elems() for load/store insns
> >>   target/riscv: rvv-1.0: take fractional LMUL into vector max elements
> >>     calculation
> >>   target/riscv: rvv-1.0: floating-point square-root instruction
> >>   target/riscv: rvv-1.0: floating-point classify instructions
> >>   target/riscv: rvv-1.0: mask population count instruction
> >>   target/riscv: rvv-1.0: find-first-set mask bit instruction
> >>   target/riscv: rvv-1.0: set-X-first mask bit instructions
> >>   target/riscv: rvv-1.0: iota instruction
> >>   target/riscv: rvv-1.0: element index instruction
> >>   target/riscv: rvv-1.0: allow load element with sign-extended
> >>   target/riscv: rvv-1.0: register gather instructions
> >>   target/riscv: rvv-1.0: integer scalar move instructions
> >>   target/riscv: rvv-1.0: floating-point move instruction
> >>   target/riscv: rvv-1.0: floating-point scalar move instructions
> >>   target/riscv: rvv-1.0: whole register move instructions
> >>   target/riscv: rvv-1.0: integer extension instructions
> >>   target/riscv: rvv-1.0: single-width averaging add and subtract
> >>     instructions
> >>   target/riscv: rvv-1.0: single-width bit shift instructions
> >>   target/riscv: rvv-1.0: integer add-with-carry/subtract-with-borrow
> >>   target/riscv: rvv-1.0: narrowing integer right shift instructions
> >>   target/riscv: rvv-1.0: widening integer multiply-add instructions
> >>   target/riscv: rvv-1.0: add Zvqmac extension
> >>   target/riscv: rvv-1.0: quad-widening integer multiply-add instructions
> >>   target/riscv: rvv-1.0: single-width saturating add and subtract
> >>     instructions
> >>   target/riscv: rvv-1.0: integer comparison instructions
> >>   target/riscv: use softfloat lib float16 comparison functions
> >>   target/riscv: rvv-1.0: floating-point compare instructions
> >>   target/riscv: rvv-1.0: mask-register logical instructions
> >>   target/riscv: rvv-1.0: slide instructions
> >>   target/riscv: rvv-1.0: floating-point slide instructions
> >>   target/riscv: rvv-1.0: narrowing fixed-point clip instructions
> >>   target/riscv: rvv-1.0: single-width floating-point reduction
> >>   target/riscv: rvv-1.0: widening floating-point reduction instructions
> >>   target/riscv: rvv-1.0: single-width scaling shift instructions
> >>   target/riscv: rvv-1.0: remove widening saturating scaled multiply-add
> >>   target/riscv: rvv-1.0: remove vmford.vv and vmford.vf
> >>   target/riscv: rvv-1.0: remove integer extract instruction
> >>   target/riscv: rvv-1.0: floating-point min/max instructions
> >>   target/riscv: introduce floating-point rounding mode enum
> >>   target/riscv: rvv-1.0: floating-point/integer type-convert
> >>     instructions
> >>   target/riscv: rvv-1.0: widening floating-point/integer type-convert
> >>   target/riscv: add "set round to odd" rounding mode helper function
> >>   target/riscv: rvv-1.0: narrowing floating-point/integer type-convert
> >>   target/riscv: rvv-1.0: relax RV_VLEN_MAX to 512-bits
> >>
> >> Greentime Hu (2):
> >>   target/riscv: rvv-1.0: add vlenb register
> >>   target/riscv: gdb: support vector registers for rv32
> >>
> >> Hsiangkai Wang (2):
> >>   target/riscv: gdb: modify gdb csr xml file to align with csr register
> >>     map
> >>   target/riscv: gdb: support vector registers for rv64
> >>
> >> LIU Zhiwei (4):
> >>   target/riscv: rvv-1.0: add mstatus VS field
> >>   target/riscv: rvv-1.0: add sstatus VS field
> >>   target/riscv: rvv-1.0: add translation-time vector context status
> >>   target/riscv: rvv-1.0: add vcsr register
> >>
> >>  gdb-xml/riscv-32bit-csr.xml             |   18 +-
> >>  gdb-xml/riscv-64bit-csr.xml             |   18 +-
> >>  target/riscv/cpu.c                      |   12 +-
> >>  target/riscv/cpu.h                      |   97 +-
> >>  target/riscv/cpu_bits.h                 |   10 +
> >>  target/riscv/cpu_helper.c               |   16 +-
> >>  target/riscv/csr.c                      |   73 +-
> >>  target/riscv/fpu_helper.c               |   17 +-
> >>  target/riscv/gdbstub.c                  |  126 +-
> >>  target/riscv/helper.h                   |  523 ++--
> >>  target/riscv/insn32-64.decode           |   18 +-
> >>  target/riscv/insn32.decode              |  295 +-
> >>  target/riscv/insn_trans/trans_rvv.inc.c | 2366 ++++++++++------
> >>  target/riscv/internals.h                |   19 +-
> >>  target/riscv/translate.c                |   68 +-
> >>  target/riscv/vector_helper.c            | 3269 +++++++++++------------
> >>  16 files changed, 4051 insertions(+), 2894 deletions(-)
> >>
> >> --
> >> 2.17.1
> >>
> >
> > ping~
>
> I wasn't really following too closely, but didn't Richard give comments?
>
> Alistair
>

Yeah, they were given in v3 patchset and I've made the changes
based on Richard's comments in this v4 patchset.

Frank Chang

--000000000000fee3cf05adcb4e90
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Thu, Aug 27, 2020 at 12:56 AM Alistair=
 Francis &lt;<a href=3D"mailto:alistair23@gmail.com">alistair23@gmail.com</=
a>&gt; wrote:<br></div><div class=3D"gmail_quote"><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">On Tue, Aug 25, 2020 at 1:29 AM Frank Chang &lt;<a=
 href=3D"mailto:frank.chang@sifive.com" target=3D"_blank">frank.chang@sifiv=
e.com</a>&gt; wrote:<br>
&gt;<br>
&gt; On Mon, Aug 17, 2020 at 4:50 PM &lt;<a href=3D"mailto:frank.chang@sifi=
ve.com" target=3D"_blank">frank.chang@sifive.com</a>&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt; From: Frank Chang &lt;<a href=3D"mailto:frank.chang@sifive.com" ta=
rget=3D"_blank">frank.chang@sifive.com</a>&gt;<br>
&gt;&gt;<br>
&gt;&gt; This patchset implements the vector extension v1.0 for RISC-V on Q=
EMU.<br>
&gt;&gt;<br>
&gt;&gt; This patchset is sent as RFC because RVV v1.0 is still in draft st=
ate.<br>
&gt;&gt; v2 patchset was sent for RVV v0.9 and bumped to RVV v1.0 since v3 =
patchset.<br>
&gt;&gt;<br>
&gt;&gt; The port is available here:<br>
&gt;&gt; <a href=3D"https://github.com/sifive/qemu/tree/rvv-1.0-upstream-v4=
" rel=3D"noreferrer" target=3D"_blank">https://github.com/sifive/qemu/tree/=
rvv-1.0-upstream-v4</a><br>
&gt;&gt;<br>
&gt;&gt; You can change the cpu argument: vext_spec to v1.0 (i.e. vext_spec=
=3Dv1.0)<br>
&gt;&gt; to run with RVV v1.0 instructions.<br>
&gt;&gt;<br>
&gt;&gt; Note: This patchset depends on two other patchsets listed in Based=
-on<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0section below so it might not able to be=
 built unless those two<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0patchsets are applied.<br>
&gt;&gt;<br>
&gt;&gt; Changelog:<br>
&gt;&gt;<br>
&gt;&gt; v4<br>
&gt;&gt;=C2=A0 =C2=A0* remove explicit float flmul variable in DisasContext=
.<br>
&gt;&gt;=C2=A0 =C2=A0* replace floating-point calculations with shift opera=
tions to<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0improve performance.<br>
&gt;&gt;=C2=A0 =C2=A0* relax RV_VLEN_MAX to 512-bits.<br>
&gt;&gt;<br>
&gt;&gt; v3<br>
&gt;&gt;=C2=A0 =C2=A0* apply nan-box helpers from Richard Henderson.<br>
&gt;&gt;=C2=A0 =C2=A0* remove fp16 api changes as they are sent independent=
ly in another<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0pathcset by Chih-Min Chao.<br>
&gt;&gt;=C2=A0 =C2=A0* remove all tail elements clear functions as tail ele=
ments can<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0retain unchanged for either VTA set to undistur=
bed or agnostic.<br>
&gt;&gt;=C2=A0 =C2=A0* add fp16 nan-box check generator function.<br>
&gt;&gt;=C2=A0 =C2=A0* add floating-point rounding mode enum.<br>
&gt;&gt;=C2=A0 =C2=A0* replace flmul arithmetic with shifts to avoid floati=
ng-point<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0conversions.<br>
&gt;&gt;=C2=A0 =C2=A0* add Zvqmac extension.<br>
&gt;&gt;=C2=A0 =C2=A0* replace gdbstub vector register xml files with dynam=
ic generator.<br>
&gt;&gt;=C2=A0 =C2=A0* bumped to RVV v1.0.<br>
&gt;&gt;=C2=A0 =C2=A0* RVV v1.0 related changes:<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0* add vl&lt;nf&gt;re&lt;eew&gt;.v and vs&lt;nf&=
gt;r.v vector whole register<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0load/store instructions<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0* add vrgatherei16 instruction.<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0* rearranged bits in vtype to make vlmul bits i=
nto a contiguous<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0field.<br>
&gt;&gt;<br>
&gt;&gt; v2<br>
&gt;&gt;=C2=A0 =C2=A0* drop v0.7.1 support.<br>
&gt;&gt;=C2=A0 =C2=A0* replace invisible return check macros with functions=
.<br>
&gt;&gt;=C2=A0 =C2=A0* move mark_vs_dirty() to translators.<br>
&gt;&gt;=C2=A0 =C2=A0* add SSTATUS_VS flag for s-mode.<br>
&gt;&gt;=C2=A0 =C2=A0* nan-box scalar fp register for floating-point operat=
ions.<br>
&gt;&gt;=C2=A0 =C2=A0* add gdbstub files for vector registers to allow syst=
em-mode<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0debugging with GDB.<br>
&gt;&gt;<br>
&gt;&gt; Based-on: &lt;<a href=3D"http://20200724002807.441147-1-richard.he=
nderson@linaro.org/" rel=3D"noreferrer" target=3D"_blank">20200724002807.44=
1147-1-richard.henderson@linaro.org/</a>&gt;<br>
&gt;&gt; Based-on: &lt;<a href=3D"http://1596102747-20226-1-git-send-email-=
chihmin.chao@sifive.com/" rel=3D"noreferrer" target=3D"_blank">1596102747-2=
0226-1-git-send-email-chihmin.chao@sifive.com/</a>&gt;<br>
&gt;&gt;<br>
&gt;&gt; Frank Chang (62):<br>
&gt;&gt;=C2=A0 =C2=A0target/riscv: drop vector 0.7.1 and add 1.0 support<br=
>
&gt;&gt;=C2=A0 =C2=A0target/riscv: Use FIELD_EX32() to extract wd field<br>
&gt;&gt;=C2=A0 =C2=A0target/riscv: rvv-1.0: introduce writable misa.v field=
<br>
&gt;&gt;=C2=A0 =C2=A0target/riscv: rvv-1.0: remove rvv related codes from f=
csr registers<br>
&gt;&gt;=C2=A0 =C2=A0target/riscv: rvv-1.0: check MSTATUS_VS when accessing=
 vector csr<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0registers<br>
&gt;&gt;=C2=A0 =C2=A0target/riscv: rvv-1.0: remove MLEN calculations<br>
&gt;&gt;=C2=A0 =C2=A0target/riscv: rvv-1.0: add fractional LMUL<br>
&gt;&gt;=C2=A0 =C2=A0target/riscv: rvv-1.0: add VMA and VTA<br>
&gt;&gt;=C2=A0 =C2=A0target/riscv: rvv-1.0: update check functions<br>
&gt;&gt;=C2=A0 =C2=A0target/riscv: introduce more imm value modes in transl=
ator functions<br>
&gt;&gt;=C2=A0 =C2=A0target/riscv: rvv:1.0: add translation-time nan-box he=
lper function<br>
&gt;&gt;=C2=A0 =C2=A0target/riscv: rvv-1.0: configure instructions<br>
&gt;&gt;=C2=A0 =C2=A0target/riscv: rvv-1.0: stride load and store instructi=
ons<br>
&gt;&gt;=C2=A0 =C2=A0target/riscv: rvv-1.0: index load and store instructio=
ns<br>
&gt;&gt;=C2=A0 =C2=A0target/riscv: rvv-1.0: fix address index overflow bug =
of indexed<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0load/store insns<br>
&gt;&gt;=C2=A0 =C2=A0target/riscv: rvv-1.0: fault-only-first unit stride lo=
ad<br>
&gt;&gt;=C2=A0 =C2=A0target/riscv: rvv-1.0: amo operations<br>
&gt;&gt;=C2=A0 =C2=A0target/riscv: rvv-1.0: load/store whole register instr=
uctions<br>
&gt;&gt;=C2=A0 =C2=A0target/riscv: rvv-1.0: update vext_max_elems() for loa=
d/store insns<br>
&gt;&gt;=C2=A0 =C2=A0target/riscv: rvv-1.0: take fractional LMUL into vecto=
r max elements<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0calculation<br>
&gt;&gt;=C2=A0 =C2=A0target/riscv: rvv-1.0: floating-point square-root inst=
ruction<br>
&gt;&gt;=C2=A0 =C2=A0target/riscv: rvv-1.0: floating-point classify instruc=
tions<br>
&gt;&gt;=C2=A0 =C2=A0target/riscv: rvv-1.0: mask population count instructi=
on<br>
&gt;&gt;=C2=A0 =C2=A0target/riscv: rvv-1.0: find-first-set mask bit instruc=
tion<br>
&gt;&gt;=C2=A0 =C2=A0target/riscv: rvv-1.0: set-X-first mask bit instructio=
ns<br>
&gt;&gt;=C2=A0 =C2=A0target/riscv: rvv-1.0: iota instruction<br>
&gt;&gt;=C2=A0 =C2=A0target/riscv: rvv-1.0: element index instruction<br>
&gt;&gt;=C2=A0 =C2=A0target/riscv: rvv-1.0: allow load element with sign-ex=
tended<br>
&gt;&gt;=C2=A0 =C2=A0target/riscv: rvv-1.0: register gather instructions<br=
>
&gt;&gt;=C2=A0 =C2=A0target/riscv: rvv-1.0: integer scalar move instruction=
s<br>
&gt;&gt;=C2=A0 =C2=A0target/riscv: rvv-1.0: floating-point move instruction=
<br>
&gt;&gt;=C2=A0 =C2=A0target/riscv: rvv-1.0: floating-point scalar move inst=
ructions<br>
&gt;&gt;=C2=A0 =C2=A0target/riscv: rvv-1.0: whole register move instruction=
s<br>
&gt;&gt;=C2=A0 =C2=A0target/riscv: rvv-1.0: integer extension instructions<=
br>
&gt;&gt;=C2=A0 =C2=A0target/riscv: rvv-1.0: single-width averaging add and =
subtract<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0instructions<br>
&gt;&gt;=C2=A0 =C2=A0target/riscv: rvv-1.0: single-width bit shift instruct=
ions<br>
&gt;&gt;=C2=A0 =C2=A0target/riscv: rvv-1.0: integer add-with-carry/subtract=
-with-borrow<br>
&gt;&gt;=C2=A0 =C2=A0target/riscv: rvv-1.0: narrowing integer right shift i=
nstructions<br>
&gt;&gt;=C2=A0 =C2=A0target/riscv: rvv-1.0: widening integer multiply-add i=
nstructions<br>
&gt;&gt;=C2=A0 =C2=A0target/riscv: rvv-1.0: add Zvqmac extension<br>
&gt;&gt;=C2=A0 =C2=A0target/riscv: rvv-1.0: quad-widening integer multiply-=
add instructions<br>
&gt;&gt;=C2=A0 =C2=A0target/riscv: rvv-1.0: single-width saturating add and=
 subtract<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0instructions<br>
&gt;&gt;=C2=A0 =C2=A0target/riscv: rvv-1.0: integer comparison instructions=
<br>
&gt;&gt;=C2=A0 =C2=A0target/riscv: use softfloat lib float16 comparison fun=
ctions<br>
&gt;&gt;=C2=A0 =C2=A0target/riscv: rvv-1.0: floating-point compare instruct=
ions<br>
&gt;&gt;=C2=A0 =C2=A0target/riscv: rvv-1.0: mask-register logical instructi=
ons<br>
&gt;&gt;=C2=A0 =C2=A0target/riscv: rvv-1.0: slide instructions<br>
&gt;&gt;=C2=A0 =C2=A0target/riscv: rvv-1.0: floating-point slide instructio=
ns<br>
&gt;&gt;=C2=A0 =C2=A0target/riscv: rvv-1.0: narrowing fixed-point clip inst=
ructions<br>
&gt;&gt;=C2=A0 =C2=A0target/riscv: rvv-1.0: single-width floating-point red=
uction<br>
&gt;&gt;=C2=A0 =C2=A0target/riscv: rvv-1.0: widening floating-point reducti=
on instructions<br>
&gt;&gt;=C2=A0 =C2=A0target/riscv: rvv-1.0: single-width scaling shift inst=
ructions<br>
&gt;&gt;=C2=A0 =C2=A0target/riscv: rvv-1.0: remove widening saturating scal=
ed multiply-add<br>
&gt;&gt;=C2=A0 =C2=A0target/riscv: rvv-1.0: remove vmford.vv and vmford.vf<=
br>
&gt;&gt;=C2=A0 =C2=A0target/riscv: rvv-1.0: remove integer extract instruct=
ion<br>
&gt;&gt;=C2=A0 =C2=A0target/riscv: rvv-1.0: floating-point min/max instruct=
ions<br>
&gt;&gt;=C2=A0 =C2=A0target/riscv: introduce floating-point rounding mode e=
num<br>
&gt;&gt;=C2=A0 =C2=A0target/riscv: rvv-1.0: floating-point/integer type-con=
vert<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0instructions<br>
&gt;&gt;=C2=A0 =C2=A0target/riscv: rvv-1.0: widening floating-point/integer=
 type-convert<br>
&gt;&gt;=C2=A0 =C2=A0target/riscv: add &quot;set round to odd&quot; roundin=
g mode helper function<br>
&gt;&gt;=C2=A0 =C2=A0target/riscv: rvv-1.0: narrowing floating-point/intege=
r type-convert<br>
&gt;&gt;=C2=A0 =C2=A0target/riscv: rvv-1.0: relax RV_VLEN_MAX to 512-bits<b=
r>
&gt;&gt;<br>
&gt;&gt; Greentime Hu (2):<br>
&gt;&gt;=C2=A0 =C2=A0target/riscv: rvv-1.0: add vlenb register<br>
&gt;&gt;=C2=A0 =C2=A0target/riscv: gdb: support vector registers for rv32<b=
r>
&gt;&gt;<br>
&gt;&gt; Hsiangkai Wang (2):<br>
&gt;&gt;=C2=A0 =C2=A0target/riscv: gdb: modify gdb csr xml file to align wi=
th csr register<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0map<br>
&gt;&gt;=C2=A0 =C2=A0target/riscv: gdb: support vector registers for rv64<b=
r>
&gt;&gt;<br>
&gt;&gt; LIU Zhiwei (4):<br>
&gt;&gt;=C2=A0 =C2=A0target/riscv: rvv-1.0: add mstatus VS field<br>
&gt;&gt;=C2=A0 =C2=A0target/riscv: rvv-1.0: add sstatus VS field<br>
&gt;&gt;=C2=A0 =C2=A0target/riscv: rvv-1.0: add translation-time vector con=
text status<br>
&gt;&gt;=C2=A0 =C2=A0target/riscv: rvv-1.0: add vcsr register<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 gdb-xml/riscv-32bit-csr.xml=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A018 +-<br>
&gt;&gt;=C2=A0 gdb-xml/riscv-64bit-csr.xml=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A018 +-<br>
&gt;&gt;=C2=A0 target/riscv/cpu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A012 +-<br>
&gt;&gt;=C2=A0 target/riscv/cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A097 +-<br>
&gt;&gt;=C2=A0 target/riscv/cpu_bits.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A010 +<br>
&gt;&gt;=C2=A0 target/riscv/cpu_helper.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A016 +-<br>
&gt;&gt;=C2=A0 target/riscv/csr.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A073 +-<br>
&gt;&gt;=C2=A0 target/riscv/fpu_helper.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A017 +-<br>
&gt;&gt;=C2=A0 target/riscv/gdbstub.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 126 +-<br>
&gt;&gt;=C2=A0 target/riscv/helper.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 523 ++--<br>
&gt;&gt;=C2=A0 target/riscv/insn32-64.decode=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 =C2=A018 +-<br>
&gt;&gt;=C2=A0 target/riscv/insn32.decode=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 |=C2=A0 295 +-<br>
&gt;&gt;=C2=A0 target/riscv/insn_trans/trans_rvv.inc.c | 2366 ++++++++++---=
---<br>
&gt;&gt;=C2=A0 target/riscv/internals.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A019 +-<br>
&gt;&gt;=C2=A0 target/riscv/translate.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A068 +-<br>
&gt;&gt;=C2=A0 target/riscv/vector_helper.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 | 3269 +++++++++++------------<br>
&gt;&gt;=C2=A0 16 files changed, 4051 insertions(+), 2894 deletions(-)<br>
&gt;&gt;<br>
&gt;&gt; --<br>
&gt;&gt; 2.17.1<br>
&gt;&gt;<br>
&gt;<br>
&gt; ping~<br>
<br>
I wasn&#39;t really following too closely, but didn&#39;t Richard give comm=
ents?<br>
<br>
Alistair<br></blockquote><div><br></div><div>Yeah, they were given in v3 pa=
tchset and I&#39;ve made the changes</div><div>based on Richard&#39;s comme=
nts in this v4 patchset.</div><div><br></div><div>Frank Chang=C2=A0</div></=
div></div>

--000000000000fee3cf05adcb4e90--

