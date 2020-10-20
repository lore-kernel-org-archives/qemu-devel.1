Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	URI_HEX autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 242FEC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 07:44:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCFF82224F
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 07:44:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="WXO+z76S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCFF82224F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50350 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUmJO-0003Jl-01
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 03:44:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34798)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1kUmIW-0002qx-5x
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 03:43:08 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:37015)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1kUmIT-0008Cq-0l
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 03:43:07 -0400
Received: by mail-oi1-x241.google.com with SMTP id t77so1220306oie.4
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 00:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=gShXWo/bDtlscAj+EiatQ3eUn1H4LW9IUkRywMEnaGI=;
 b=WXO+z76SXSGDU3PULT89xHzqi0i5wQPiJKH9XNOf9AI6fFu1niHmCONa8qM5hWX7lg
 61+bUMircZOgD3BERSB1MP1+nsN+Lq05ZxMvlXOtEQXCAhrCTMnbkWIA3GQYwVaNnHJJ
 ncOFGE7eh1w+Tfr1sQfmc4ei+wLst4sOkzxmD9dBAtz4aojH8qph8WK4GO8rfaPjHbTe
 ijy6w8/5uW+TBglO8mjyC74agPkr2lQpEE7+r0wh4sH4B42hy1rabVcN+PyNikVFbXiN
 5ZKTL32bUab3SEXjxfAu6VmewE1qLs7Ktdx+quLPDzeatwWS8IcgO4ZrewM7ciowW6T6
 jEsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=gShXWo/bDtlscAj+EiatQ3eUn1H4LW9IUkRywMEnaGI=;
 b=VqCUMN2djjOe7FTvE/yx8hJKJfgMhoVtHGxe5VXjc6lz2kvW11HUt23f+eR2BCOQez
 aXVattjuTEDDl4XYD454F7fIGdQ3USEj+7KZ+Gpj3Ck6z8AlwQ/h6aFe1y6OIQQ/rjS8
 VA1yZeolimWaOiG5LQhUWdnvfE4guYN9oEFEXUXAI+ToEvW1d+xmRsRQaxnfsH3rsAF+
 M95gQcdbO1FwrPxLIrvTmchh294eJz5meEvEVHO5X5AuBX2L3jt4m8rgElN2AoivPhVl
 dUGvkyCDYK8GTRoooWe9zqWE7eAojGKZ6iLmJw9dBzVR0KQzFzp+vZOLKAJytRw3knIv
 KHIg==
X-Gm-Message-State: AOAM531BOb2p5lB3JLuRl3IvwLumVVHeh88lyNgrTuvoikhqCcLdTlWS
 5oiamwDLigQp0yYQVGvG+U+Ts0w6AUYIqdedxzGTXhIsJEI=
X-Google-Smtp-Source: ABdhPJwPz9K4V0YFjxaHuKbM3mQXhgBbnaBTgOmwrcubzZ+i5d5lKO0d7bgM1LB49yfT2nhxeif82SBk6EhYt018yyI=
X-Received: by 2002:a05:6808:88:: with SMTP id s8mr941090oic.118.1603179783205; 
 Tue, 20 Oct 2020 00:43:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200929190448.31116-1-frank.chang@sifive.com>
In-Reply-To: <20200929190448.31116-1-frank.chang@sifive.com>
From: Frank Chang <frank.chang@sifive.com>
Date: Tue, 20 Oct 2020 15:42:52 +0800
Message-ID: <CAE_xrPgMu=o5ArbRW1t-YFnZMDo0zGmwvPARB-HtpXHiLqvawQ@mail.gmail.com>
Subject: Re: [RFC v5 00/68] support vector extension v1.0
To: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>
Content-Type: multipart/alternative; boundary="0000000000007d46a605b2156189"
Received-SPF: pass client-ip=2607:f8b0:4864:20::241;
 envelope-from=frank.chang@sifive.com; helo=mail-oi1-x241.google.com
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

--0000000000007d46a605b2156189
Content-Type: text/plain; charset="UTF-8"

On Wed, Sep 30, 2020 at 3:04 AM <frank.chang@sifive.com> wrote:

> From: Frank Chang <frank.chang@sifive.com>
>
> This patchset implements the vector extension v1.0 for RISC-V on QEMU.
>
> This patchset is sent as RFC because RVV v1.0 is still in draft state.
> v2 patchset was sent for RVV v0.9 and bumped to RVV v1.0 since v3 patchset.
>
> The port is available here:
> https://github.com/sifive/qemu/tree/rvv-1.0-upstream-v5
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
> v5
>   * refactor RVV v1.0 check functions.
>     (Thanks to Richard Henderson's bitwise tricks.)
>   * relax RV_VLEN_MAX to 1024-bits.
>   * implement vstart CSR's behaviors.
>   * trigger illegal instruction exception if frm is not valid for
>     vector floating-point instructions.
>   * rebase on riscv-to-apply.next.
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
> Based-on: <20200909001647.532249-1-richard.henderson@linaro.org/>
> Based-on: <1596102747-20226-1-git-send-email-chihmin.chao@sifive.com/>
>
> Frank Chang (62):
>   target/riscv: drop vector 0.7.1 and add 1.0 support
>   target/riscv: Use FIELD_EX32() to extract wd field
>   target/riscv: rvv-1.0: introduce writable misa.v field
>   target/riscv: rvv-1.0: add translation-time vector context status
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
>   target/riscv: rvv-1.0: single-width saturating add and subtract
>     instructions
>   target/riscv: rvv-1.0: integer comparison instructions
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
>   target/riscv: rvv-1.0: relax RV_VLEN_MAX to 1024-bits
>   target/riscv: implement vstart CSR
>   target/riscv: trigger illegal instruction exception if frm is not
>     valid
>
> Greentime Hu (1):
>   target/riscv: rvv-1.0: add vlenb register
>
> Hsiangkai Wang (2):
>   target/riscv: gdb: modify gdb csr xml file to align with csr register
>     map
>   target/riscv: gdb: support vector registers for rv64 & rv32
>
> LIU Zhiwei (3):
>   target/riscv: rvv-1.0: add mstatus VS field
>   target/riscv: rvv-1.0: add sstatus VS field
>   target/riscv: rvv-1.0: add vcsr register
>
>  gdb-xml/riscv-32bit-csr.xml             |   18 +-
>  gdb-xml/riscv-64bit-csr.xml             |   18 +-
>  target/riscv/cpu.c                      |   11 +-
>  target/riscv/cpu.h                      |   95 +-
>  target/riscv/cpu_bits.h                 |   10 +
>  target/riscv/cpu_helper.c               |   16 +-
>  target/riscv/csr.c                      |   79 +-
>  target/riscv/fpu_helper.c               |   17 +-
>  target/riscv/gdbstub.c                  |  172 +-
>  target/riscv/helper.h                   |  495 ++--
>  target/riscv/insn32-64.decode           |   18 +-
>  target/riscv/insn32.decode              |  288 +-
>  target/riscv/insn_trans/trans_rvv.c.inc | 2430 +++++++++++------
>  target/riscv/internals.h                |   22 +-
>  target/riscv/translate.c                |   72 +-
>  target/riscv/vector_helper.c            | 3316 +++++++++++------------
>  16 files changed, 4118 insertions(+), 2959 deletions(-)
>
> --
> 2.17.1
>
>
ping~

--0000000000007d46a605b2156189
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Wed, Sep 30, 2020 at 3:04 AM &lt;<a hr=
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
<a href=3D"https://github.com/sifive/qemu/tree/rvv-1.0-upstream-v5" rel=3D"=
noreferrer" target=3D"_blank">https://github.com/sifive/qemu/tree/rvv-1.0-u=
pstream-v5</a><br>
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
v5<br>
=C2=A0 * refactor RVV v1.0 check functions.<br>
=C2=A0 =C2=A0 (Thanks to Richard Henderson&#39;s bitwise tricks.)<br>
=C2=A0 * relax RV_VLEN_MAX to 1024-bits.<br>
=C2=A0 * implement vstart CSR&#39;s behaviors.<br>
=C2=A0 * trigger illegal instruction exception if frm is not valid for<br>
=C2=A0 =C2=A0 vector floating-point instructions.<br>
=C2=A0 * rebase on riscv-to-apply.next.<br>
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
Based-on: &lt;<a href=3D"http://20200909001647.532249-1-richard.henderson@l=
inaro.org/" rel=3D"noreferrer" target=3D"_blank">20200909001647.532249-1-ri=
chard.henderson@linaro.org/</a>&gt;<br>
Based-on: &lt;<a href=3D"http://1596102747-20226-1-git-send-email-chihmin.c=
hao@sifive.com/" rel=3D"noreferrer" target=3D"_blank">1596102747-20226-1-gi=
t-send-email-chihmin.chao@sifive.com/</a>&gt;<br>
<br>
Frank Chang (62):<br>
=C2=A0 target/riscv: drop vector 0.7.1 and add 1.0 support<br>
=C2=A0 target/riscv: Use FIELD_EX32() to extract wd field<br>
=C2=A0 target/riscv: rvv-1.0: introduce writable misa.v field<br>
=C2=A0 target/riscv: rvv-1.0: add translation-time vector context status<br=
>
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
=C2=A0 target/riscv: rvv-1.0: single-width saturating add and subtract<br>
=C2=A0 =C2=A0 instructions<br>
=C2=A0 target/riscv: rvv-1.0: integer comparison instructions<br>
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
=C2=A0 target/riscv: rvv-1.0: relax RV_VLEN_MAX to 1024-bits<br>
=C2=A0 target/riscv: implement vstart CSR<br>
=C2=A0 target/riscv: trigger illegal instruction exception if frm is not<br=
>
=C2=A0 =C2=A0 valid<br>
<br>
Greentime Hu (1):<br>
=C2=A0 target/riscv: rvv-1.0: add vlenb register<br>
<br>
Hsiangkai Wang (2):<br>
=C2=A0 target/riscv: gdb: modify gdb csr xml file to align with csr registe=
r<br>
=C2=A0 =C2=A0 map<br>
=C2=A0 target/riscv: gdb: support vector registers for rv64 &amp; rv32<br>
<br>
LIU Zhiwei (3):<br>
=C2=A0 target/riscv: rvv-1.0: add mstatus VS field<br>
=C2=A0 target/riscv: rvv-1.0: add sstatus VS field<br>
=C2=A0 target/riscv: rvv-1.0: add vcsr register<br>
<br>
=C2=A0gdb-xml/riscv-32bit-csr.xml=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 =C2=A018 +-<br>
=C2=A0gdb-xml/riscv-64bit-csr.xml=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 =C2=A018 +-<br>
=C2=A0target/riscv/cpu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A011 +-<br>
=C2=A0target/riscv/cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A095 +-<br>
=C2=A0target/riscv/cpu_bits.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A010 +<br>
=C2=A0target/riscv/cpu_helper.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 =C2=A016 +-<br>
=C2=A0target/riscv/csr.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A079 +-<br>
=C2=A0target/riscv/fpu_helper.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 =C2=A017 +-<br>
=C2=A0target/riscv/gdbstub.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 172 +-<br>
=C2=A0target/riscv/helper.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0|=C2=A0 495 ++--<br>
=C2=A0target/riscv/insn32-64.decode=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 =C2=A018 +-<br>
=C2=A0target/riscv/insn32.decode=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 288 +-<br>
=C2=A0target/riscv/insn_trans/trans_rvv.c.inc | 2430 +++++++++++------<br>
=C2=A0target/riscv/internals.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 |=C2=A0 =C2=A022 +-<br>
=C2=A0target/riscv/translate.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 |=C2=A0 =C2=A072 +-<br>
=C2=A0target/riscv/vector_helper.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 | 3316 +++++++++++------------<br>
=C2=A016 files changed, 4118 insertions(+), 2959 deletions(-)<br>
<br>
--<br>
2.17.1<br>
<br></blockquote><div><br></div><div>ping~=C2=A0</div></div></div>

--0000000000007d46a605b2156189--

