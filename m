Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	URI_HEX autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8930BC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 08:29:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 456572067C
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 08:29:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="lnHuPpjQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 456572067C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAUKx-0001rd-H0
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 04:29:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59098)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1kAUKP-0001OF-Dx
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 04:29:13 -0400
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330]:41864)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1kAUKM-0008SG-0c
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 04:29:13 -0400
Received: by mail-ot1-x330.google.com with SMTP id a65so9711698otc.8
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 01:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=lsieEhHpfi/sOOODkJDZUz2fI40g/pY5iZXN8jA19sM=;
 b=lnHuPpjQua8GMj5Ic+9XRaY7LCTfGK1yh88M5e+0rJcQS6zK/e/U1MVHYkI3TmrNtg
 YNgCGpCBBf+2u5mInXTzF7ozgESnczsQb8QWO1BChBy1WQuZ27WouhHgOb46T5aStU+N
 p1EqXukOyTsvsCGN/Rh2+og0yMz70Va1+W7nX2+JnYeJuuUM/MahnmEFNDIZiHBSw+qk
 /xqicHtmn5f58kUT0cyc19wio08sVyNUDW02S7Rkswfg2Gb4jiOfjYULHcpERdfr9Ael
 6mAGUlJk79liTJv7RLH5q1TRiXGpRdzeRfdOOhax8QLwq267V5NO2NDfVJTIVRFmezdh
 3Vng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=lsieEhHpfi/sOOODkJDZUz2fI40g/pY5iZXN8jA19sM=;
 b=dJu0AGz+vY7IhwgJ84TNjQCHGF3JcwYPCe95+LnXU+FaQqkqy4/y2aaaDhLkNlOEkK
 fWSdBQfwTA659YeYZOsIRTeb79xLDp/Hrm2aNmLSIhL4STBAKtEtU+qI9JHuOPcXqw4R
 tDjn59hlVSLUjiWfHhYCwGrcU2Bem0ATkWxa7IZkFj9+P6pv4QvALl1tAuczjLACC3vk
 losxyGX/jSS7M3wkZqzC9ECzDbY3fJqzigs787iVKFmQaWxhiZ4CbAa9BgUjQd1Tg77E
 OXA0IJ4LxmnCmJ+pzwgmo+/42Ivh1ENewyeUTQXp7tW/UOV7VsYtalmcqWxcjqcsXDft
 1FvQ==
X-Gm-Message-State: AOAM533jP5baGsoqQWOOusFmnFVmoLFjxEcuLk1cay13M5uJ/xhdrGhJ
 YM+pOlXAb9LRd0901z7zAyVJqhnESnHGtofZyxr3kZrOKdM=
X-Google-Smtp-Source: ABdhPJxfaEdcvvJR8E0Yk9gLkVtV4Sbv3sqgyUhU4o0ld79yP8L6u1FeyDwXhvliZI9Hd5PVoKzlhVZOyB9+bQ8YASE=
X-Received: by 2002:a9d:2:: with SMTP id 2mr5615850ota.175.1598344148136; Tue,
 25 Aug 2020 01:29:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200817084955.28793-1-frank.chang@sifive.com>
In-Reply-To: <20200817084955.28793-1-frank.chang@sifive.com>
From: Frank Chang <frank.chang@sifive.com>
Date: Tue, 25 Aug 2020 16:28:57 +0800
Message-ID: <CAE_xrPjmrmwVW3YOTXLVuVpvT=mT+gnwKJy+yYjo6t24xC8ZDg@mail.gmail.com>
Subject: Re: [RFC v4 00/70] support vector extension v1.0
To: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>
Content-Type: multipart/alternative; boundary="0000000000002dd60205adaf7fee"
Received-SPF: pass client-ip=2607:f8b0:4864:20::330;
 envelope-from=frank.chang@sifive.com; helo=mail-ot1-x330.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000002dd60205adaf7fee
Content-Type: text/plain; charset="UTF-8"

On Mon, Aug 17, 2020 at 4:50 PM <frank.chang@sifive.com> wrote:

> From: Frank Chang <frank.chang@sifive.com>
>
> This patchset implements the vector extension v1.0 for RISC-V on QEMU.
>
> This patchset is sent as RFC because RVV v1.0 is still in draft state.
> v2 patchset was sent for RVV v0.9 and bumped to RVV v1.0 since v3 patchset.
>
> The port is available here:
> https://github.com/sifive/qemu/tree/rvv-1.0-upstream-v4
>
> You can change the cpu argument: vext_spec to v1.0 (i.e. vext_spec=v1.0)
> to run with RVV v1.0 instructions.
>
> Note: This patchset depends on two other patchsets listed in Based-on
>       section below so it might not able to be built unless those two
>       patchsets are applied.
>
> Changelog:
>
> v4
>   * remove explicit float flmul variable in DisasContext.
>   * replace floating-point calculations with shift operations to
>     improve performance.
>   * relax RV_VLEN_MAX to 512-bits.
>
> v3
>   * apply nan-box helpers from Richard Henderson.
>   * remove fp16 api changes as they are sent independently in another
>     pathcset by Chih-Min Chao.
>   * remove all tail elements clear functions as tail elements can
>     retain unchanged for either VTA set to undisturbed or agnostic.
>   * add fp16 nan-box check generator function.
>   * add floating-point rounding mode enum.
>   * replace flmul arithmetic with shifts to avoid floating-point
>     conversions.
>   * add Zvqmac extension.
>   * replace gdbstub vector register xml files with dynamic generator.
>   * bumped to RVV v1.0.
>   * RVV v1.0 related changes:
>     * add vl<nf>re<eew>.v and vs<nf>r.v vector whole register
>       load/store instructions
>     * add vrgatherei16 instruction.
>     * rearranged bits in vtype to make vlmul bits into a contiguous
>       field.
>
> v2
>   * drop v0.7.1 support.
>   * replace invisible return check macros with functions.
>   * move mark_vs_dirty() to translators.
>   * add SSTATUS_VS flag for s-mode.
>   * nan-box scalar fp register for floating-point operations.
>   * add gdbstub files for vector registers to allow system-mode
>     debugging with GDB.
>
> Based-on: <20200724002807.441147-1-richard.henderson@linaro.org/>
> Based-on: <1596102747-20226-1-git-send-email-chihmin.chao@sifive.com/>
>
> Frank Chang (62):
>   target/riscv: drop vector 0.7.1 and add 1.0 support
>   target/riscv: Use FIELD_EX32() to extract wd field
>   target/riscv: rvv-1.0: introduce writable misa.v field
>   target/riscv: rvv-1.0: remove rvv related codes from fcsr registers
>   target/riscv: rvv-1.0: check MSTATUS_VS when accessing vector csr
>     registers
>   target/riscv: rvv-1.0: remove MLEN calculations
>   target/riscv: rvv-1.0: add fractional LMUL
>   target/riscv: rvv-1.0: add VMA and VTA
>   target/riscv: rvv-1.0: update check functions
>   target/riscv: introduce more imm value modes in translator functions
>   target/riscv: rvv:1.0: add translation-time nan-box helper function
>   target/riscv: rvv-1.0: configure instructions
>   target/riscv: rvv-1.0: stride load and store instructions
>   target/riscv: rvv-1.0: index load and store instructions
>   target/riscv: rvv-1.0: fix address index overflow bug of indexed
>     load/store insns
>   target/riscv: rvv-1.0: fault-only-first unit stride load
>   target/riscv: rvv-1.0: amo operations
>   target/riscv: rvv-1.0: load/store whole register instructions
>   target/riscv: rvv-1.0: update vext_max_elems() for load/store insns
>   target/riscv: rvv-1.0: take fractional LMUL into vector max elements
>     calculation
>   target/riscv: rvv-1.0: floating-point square-root instruction
>   target/riscv: rvv-1.0: floating-point classify instructions
>   target/riscv: rvv-1.0: mask population count instruction
>   target/riscv: rvv-1.0: find-first-set mask bit instruction
>   target/riscv: rvv-1.0: set-X-first mask bit instructions
>   target/riscv: rvv-1.0: iota instruction
>   target/riscv: rvv-1.0: element index instruction
>   target/riscv: rvv-1.0: allow load element with sign-extended
>   target/riscv: rvv-1.0: register gather instructions
>   target/riscv: rvv-1.0: integer scalar move instructions
>   target/riscv: rvv-1.0: floating-point move instruction
>   target/riscv: rvv-1.0: floating-point scalar move instructions
>   target/riscv: rvv-1.0: whole register move instructions
>   target/riscv: rvv-1.0: integer extension instructions
>   target/riscv: rvv-1.0: single-width averaging add and subtract
>     instructions
>   target/riscv: rvv-1.0: single-width bit shift instructions
>   target/riscv: rvv-1.0: integer add-with-carry/subtract-with-borrow
>   target/riscv: rvv-1.0: narrowing integer right shift instructions
>   target/riscv: rvv-1.0: widening integer multiply-add instructions
>   target/riscv: rvv-1.0: add Zvqmac extension
>   target/riscv: rvv-1.0: quad-widening integer multiply-add instructions
>   target/riscv: rvv-1.0: single-width saturating add and subtract
>     instructions
>   target/riscv: rvv-1.0: integer comparison instructions
>   target/riscv: use softfloat lib float16 comparison functions
>   target/riscv: rvv-1.0: floating-point compare instructions
>   target/riscv: rvv-1.0: mask-register logical instructions
>   target/riscv: rvv-1.0: slide instructions
>   target/riscv: rvv-1.0: floating-point slide instructions
>   target/riscv: rvv-1.0: narrowing fixed-point clip instructions
>   target/riscv: rvv-1.0: single-width floating-point reduction
>   target/riscv: rvv-1.0: widening floating-point reduction instructions
>   target/riscv: rvv-1.0: single-width scaling shift instructions
>   target/riscv: rvv-1.0: remove widening saturating scaled multiply-add
>   target/riscv: rvv-1.0: remove vmford.vv and vmford.vf
>   target/riscv: rvv-1.0: remove integer extract instruction
>   target/riscv: rvv-1.0: floating-point min/max instructions
>   target/riscv: introduce floating-point rounding mode enum
>   target/riscv: rvv-1.0: floating-point/integer type-convert
>     instructions
>   target/riscv: rvv-1.0: widening floating-point/integer type-convert
>   target/riscv: add "set round to odd" rounding mode helper function
>   target/riscv: rvv-1.0: narrowing floating-point/integer type-convert
>   target/riscv: rvv-1.0: relax RV_VLEN_MAX to 512-bits
>
> Greentime Hu (2):
>   target/riscv: rvv-1.0: add vlenb register
>   target/riscv: gdb: support vector registers for rv32
>
> Hsiangkai Wang (2):
>   target/riscv: gdb: modify gdb csr xml file to align with csr register
>     map
>   target/riscv: gdb: support vector registers for rv64
>
> LIU Zhiwei (4):
>   target/riscv: rvv-1.0: add mstatus VS field
>   target/riscv: rvv-1.0: add sstatus VS field
>   target/riscv: rvv-1.0: add translation-time vector context status
>   target/riscv: rvv-1.0: add vcsr register
>
>  gdb-xml/riscv-32bit-csr.xml             |   18 +-
>  gdb-xml/riscv-64bit-csr.xml             |   18 +-
>  target/riscv/cpu.c                      |   12 +-
>  target/riscv/cpu.h                      |   97 +-
>  target/riscv/cpu_bits.h                 |   10 +
>  target/riscv/cpu_helper.c               |   16 +-
>  target/riscv/csr.c                      |   73 +-
>  target/riscv/fpu_helper.c               |   17 +-
>  target/riscv/gdbstub.c                  |  126 +-
>  target/riscv/helper.h                   |  523 ++--
>  target/riscv/insn32-64.decode           |   18 +-
>  target/riscv/insn32.decode              |  295 +-
>  target/riscv/insn_trans/trans_rvv.inc.c | 2366 ++++++++++------
>  target/riscv/internals.h                |   19 +-
>  target/riscv/translate.c                |   68 +-
>  target/riscv/vector_helper.c            | 3269 +++++++++++------------
>  16 files changed, 4051 insertions(+), 2894 deletions(-)
>
> --
> 2.17.1
>
>
ping~

--0000000000002dd60205adaf7fee
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Mon, Aug 17, 2020 at 4:50 PM &lt;<a hr=
ef=3D"mailto:frank.chang@sifive.com">frank.chang@sifive.com</a>&gt; wrote:<=
br></div><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">From: Frank Chang &lt;<a href=3D"mailto:frank.chang@sifive.com" =
target=3D"_blank">frank.chang@sifive.com</a>&gt;<br>
<br>
This patchset implements the vector extension v1.0 for RISC-V on QEMU.<br>
<br>
This patchset is sent as RFC because RVV v1.0 is still in draft state.<br>
v2 patchset was sent for RVV v0.9 and bumped to RVV v1.0 since v3 patchset.=
<br>
<br>
The port is available here:<br>
<a href=3D"https://github.com/sifive/qemu/tree/rvv-1.0-upstream-v4" rel=3D"=
noreferrer" target=3D"_blank">https://github.com/sifive/qemu/tree/rvv-1.0-u=
pstream-v4</a><br>
<br>
You can change the cpu argument: vext_spec to v1.0 (i.e. vext_spec=3Dv1.0)<=
br>
to run with RVV v1.0 instructions.<br>
<br>
Note: This patchset depends on two other patchsets listed in Based-on<br>
=C2=A0 =C2=A0 =C2=A0 section below so it might not able to be built unless =
those two<br>
=C2=A0 =C2=A0 =C2=A0 patchsets are applied.<br>
<br>
Changelog:<br>
<br>
v4<br>
=C2=A0 * remove explicit float flmul variable in DisasContext.<br>
=C2=A0 * replace floating-point calculations with shift operations to<br>
=C2=A0 =C2=A0 improve performance.<br>
=C2=A0 * relax RV_VLEN_MAX to 512-bits.<br>
<br>
v3<br>
=C2=A0 * apply nan-box helpers from Richard Henderson.<br>
=C2=A0 * remove fp16 api changes as they are sent independently in another<=
br>
=C2=A0 =C2=A0 pathcset by Chih-Min Chao.<br>
=C2=A0 * remove all tail elements clear functions as tail elements can<br>
=C2=A0 =C2=A0 retain unchanged for either VTA set to undisturbed or agnosti=
c.<br>
=C2=A0 * add fp16 nan-box check generator function.<br>
=C2=A0 * add floating-point rounding mode enum.<br>
=C2=A0 * replace flmul arithmetic with shifts to avoid floating-point<br>
=C2=A0 =C2=A0 conversions.<br>
=C2=A0 * add Zvqmac extension.<br>
=C2=A0 * replace gdbstub vector register xml files with dynamic generator.<=
br>
=C2=A0 * bumped to RVV v1.0.<br>
=C2=A0 * RVV v1.0 related changes:<br>
=C2=A0 =C2=A0 * add vl&lt;nf&gt;re&lt;eew&gt;.v and vs&lt;nf&gt;r.v vector =
whole register<br>
=C2=A0 =C2=A0 =C2=A0 load/store instructions<br>
=C2=A0 =C2=A0 * add vrgatherei16 instruction.<br>
=C2=A0 =C2=A0 * rearranged bits in vtype to make vlmul bits into a contiguo=
us<br>
=C2=A0 =C2=A0 =C2=A0 field.<br>
<br>
v2<br>
=C2=A0 * drop v0.7.1 support.<br>
=C2=A0 * replace invisible return check macros with functions.<br>
=C2=A0 * move mark_vs_dirty() to translators.<br>
=C2=A0 * add SSTATUS_VS flag for s-mode.<br>
=C2=A0 * nan-box scalar fp register for floating-point operations.<br>
=C2=A0 * add gdbstub files for vector registers to allow system-mode<br>
=C2=A0 =C2=A0 debugging with GDB.<br>
<br>
Based-on: &lt;<a href=3D"http://20200724002807.441147-1-richard.henderson@l=
inaro.org/" rel=3D"noreferrer" target=3D"_blank">20200724002807.441147-1-ri=
chard.henderson@linaro.org/</a>&gt;<br>
Based-on: &lt;<a href=3D"http://1596102747-20226-1-git-send-email-chihmin.c=
hao@sifive.com/" rel=3D"noreferrer" target=3D"_blank">1596102747-20226-1-gi=
t-send-email-chihmin.chao@sifive.com/</a>&gt;<br>
<br>
Frank Chang (62):<br>
=C2=A0 target/riscv: drop vector 0.7.1 and add 1.0 support<br>
=C2=A0 target/riscv: Use FIELD_EX32() to extract wd field<br>
=C2=A0 target/riscv: rvv-1.0: introduce writable misa.v field<br>
=C2=A0 target/riscv: rvv-1.0: remove rvv related codes from fcsr registers<=
br>
=C2=A0 target/riscv: rvv-1.0: check MSTATUS_VS when accessing vector csr<br=
>
=C2=A0 =C2=A0 registers<br>
=C2=A0 target/riscv: rvv-1.0: remove MLEN calculations<br>
=C2=A0 target/riscv: rvv-1.0: add fractional LMUL<br>
=C2=A0 target/riscv: rvv-1.0: add VMA and VTA<br>
=C2=A0 target/riscv: rvv-1.0: update check functions<br>
=C2=A0 target/riscv: introduce more imm value modes in translator functions=
<br>
=C2=A0 target/riscv: rvv:1.0: add translation-time nan-box helper function<=
br>
=C2=A0 target/riscv: rvv-1.0: configure instructions<br>
=C2=A0 target/riscv: rvv-1.0: stride load and store instructions<br>
=C2=A0 target/riscv: rvv-1.0: index load and store instructions<br>
=C2=A0 target/riscv: rvv-1.0: fix address index overflow bug of indexed<br>
=C2=A0 =C2=A0 load/store insns<br>
=C2=A0 target/riscv: rvv-1.0: fault-only-first unit stride load<br>
=C2=A0 target/riscv: rvv-1.0: amo operations<br>
=C2=A0 target/riscv: rvv-1.0: load/store whole register instructions<br>
=C2=A0 target/riscv: rvv-1.0: update vext_max_elems() for load/store insns<=
br>
=C2=A0 target/riscv: rvv-1.0: take fractional LMUL into vector max elements=
<br>
=C2=A0 =C2=A0 calculation<br>
=C2=A0 target/riscv: rvv-1.0: floating-point square-root instruction<br>
=C2=A0 target/riscv: rvv-1.0: floating-point classify instructions<br>
=C2=A0 target/riscv: rvv-1.0: mask population count instruction<br>
=C2=A0 target/riscv: rvv-1.0: find-first-set mask bit instruction<br>
=C2=A0 target/riscv: rvv-1.0: set-X-first mask bit instructions<br>
=C2=A0 target/riscv: rvv-1.0: iota instruction<br>
=C2=A0 target/riscv: rvv-1.0: element index instruction<br>
=C2=A0 target/riscv: rvv-1.0: allow load element with sign-extended<br>
=C2=A0 target/riscv: rvv-1.0: register gather instructions<br>
=C2=A0 target/riscv: rvv-1.0: integer scalar move instructions<br>
=C2=A0 target/riscv: rvv-1.0: floating-point move instruction<br>
=C2=A0 target/riscv: rvv-1.0: floating-point scalar move instructions<br>
=C2=A0 target/riscv: rvv-1.0: whole register move instructions<br>
=C2=A0 target/riscv: rvv-1.0: integer extension instructions<br>
=C2=A0 target/riscv: rvv-1.0: single-width averaging add and subtract<br>
=C2=A0 =C2=A0 instructions<br>
=C2=A0 target/riscv: rvv-1.0: single-width bit shift instructions<br>
=C2=A0 target/riscv: rvv-1.0: integer add-with-carry/subtract-with-borrow<b=
r>
=C2=A0 target/riscv: rvv-1.0: narrowing integer right shift instructions<br=
>
=C2=A0 target/riscv: rvv-1.0: widening integer multiply-add instructions<br=
>
=C2=A0 target/riscv: rvv-1.0: add Zvqmac extension<br>
=C2=A0 target/riscv: rvv-1.0: quad-widening integer multiply-add instructio=
ns<br>
=C2=A0 target/riscv: rvv-1.0: single-width saturating add and subtract<br>
=C2=A0 =C2=A0 instructions<br>
=C2=A0 target/riscv: rvv-1.0: integer comparison instructions<br>
=C2=A0 target/riscv: use softfloat lib float16 comparison functions<br>
=C2=A0 target/riscv: rvv-1.0: floating-point compare instructions<br>
=C2=A0 target/riscv: rvv-1.0: mask-register logical instructions<br>
=C2=A0 target/riscv: rvv-1.0: slide instructions<br>
=C2=A0 target/riscv: rvv-1.0: floating-point slide instructions<br>
=C2=A0 target/riscv: rvv-1.0: narrowing fixed-point clip instructions<br>
=C2=A0 target/riscv: rvv-1.0: single-width floating-point reduction<br>
=C2=A0 target/riscv: rvv-1.0: widening floating-point reduction instruction=
s<br>
=C2=A0 target/riscv: rvv-1.0: single-width scaling shift instructions<br>
=C2=A0 target/riscv: rvv-1.0: remove widening saturating scaled multiply-ad=
d<br>
=C2=A0 target/riscv: rvv-1.0: remove vmford.vv and vmford.vf<br>
=C2=A0 target/riscv: rvv-1.0: remove integer extract instruction<br>
=C2=A0 target/riscv: rvv-1.0: floating-point min/max instructions<br>
=C2=A0 target/riscv: introduce floating-point rounding mode enum<br>
=C2=A0 target/riscv: rvv-1.0: floating-point/integer type-convert<br>
=C2=A0 =C2=A0 instructions<br>
=C2=A0 target/riscv: rvv-1.0: widening floating-point/integer type-convert<=
br>
=C2=A0 target/riscv: add &quot;set round to odd&quot; rounding mode helper =
function<br>
=C2=A0 target/riscv: rvv-1.0: narrowing floating-point/integer type-convert=
<br>
=C2=A0 target/riscv: rvv-1.0: relax RV_VLEN_MAX to 512-bits<br>
<br>
Greentime Hu (2):<br>
=C2=A0 target/riscv: rvv-1.0: add vlenb register<br>
=C2=A0 target/riscv: gdb: support vector registers for rv32<br>
<br>
Hsiangkai Wang (2):<br>
=C2=A0 target/riscv: gdb: modify gdb csr xml file to align with csr registe=
r<br>
=C2=A0 =C2=A0 map<br>
=C2=A0 target/riscv: gdb: support vector registers for rv64<br>
<br>
LIU Zhiwei (4):<br>
=C2=A0 target/riscv: rvv-1.0: add mstatus VS field<br>
=C2=A0 target/riscv: rvv-1.0: add sstatus VS field<br>
=C2=A0 target/riscv: rvv-1.0: add translation-time vector context status<br=
>
=C2=A0 target/riscv: rvv-1.0: add vcsr register<br>
<br>
=C2=A0gdb-xml/riscv-32bit-csr.xml=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 =C2=A018 +-<br>
=C2=A0gdb-xml/riscv-64bit-csr.xml=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 =C2=A018 +-<br>
=C2=A0target/riscv/cpu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A012 +-<br>
=C2=A0target/riscv/cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A097 +-<br>
=C2=A0target/riscv/cpu_bits.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A010 +<br>
=C2=A0target/riscv/cpu_helper.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 =C2=A016 +-<br>
=C2=A0target/riscv/csr.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A073 +-<br>
=C2=A0target/riscv/fpu_helper.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 =C2=A017 +-<br>
=C2=A0target/riscv/gdbstub.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 126 +-<br>
=C2=A0target/riscv/helper.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0|=C2=A0 523 ++--<br>
=C2=A0target/riscv/insn32-64.decode=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 =C2=A018 +-<br>
=C2=A0target/riscv/insn32.decode=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 295 +-<br>
=C2=A0target/riscv/insn_trans/trans_rvv.inc.c | 2366 ++++++++++------<br>
=C2=A0target/riscv/internals.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 |=C2=A0 =C2=A019 +-<br>
=C2=A0target/riscv/translate.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 |=C2=A0 =C2=A068 +-<br>
=C2=A0target/riscv/vector_helper.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 | 3269 +++++++++++------------<br>
=C2=A016 files changed, 4051 insertions(+), 2894 deletions(-)<br>
<br>
--<br>
2.17.1<br>
<br></blockquote><div><br></div><div>ping~=C2=A0</div></div></div>

--0000000000002dd60205adaf7fee--

