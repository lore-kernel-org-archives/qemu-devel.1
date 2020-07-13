Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C4D8C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 02:03:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A64B2068F
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 02:03:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="bx7Jllvi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A64B2068F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1junoX-000288-3Y
	for qemu-devel@archiver.kernel.org; Sun, 12 Jul 2020 22:03:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33938)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1junnr-0001Mu-20
 for qemu-devel@nongnu.org; Sun, 12 Jul 2020 22:02:47 -0400
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236]:34819)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1junno-00073n-48
 for qemu-devel@nongnu.org; Sun, 12 Jul 2020 22:02:46 -0400
Received: by mail-oi1-x236.google.com with SMTP id k4so9758012oik.2
 for <qemu-devel@nongnu.org>; Sun, 12 Jul 2020 19:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=9KCoK88gpzBtqmTq5EC1fc00IBdi2FABzlZ6Q5EHL4k=;
 b=bx7JllviB7lXgD4AvbgS35G33skhdVu+maw41Ihrla1C6vmJk5ozY7c2Aq0GcH3bNk
 S6ilGdbPdcE7oU63hQqdA8G1sHvAldubABQU0Vq7B8WpND3QG70QjPdu8jIS+5foBowW
 DtQhTMHLem+4wRDMGnNGVkLNr65aOJdXUSjVrdiwbimqZQB8TpGlPm9KNpZjp0zbAnhA
 O2v+Su+7Qefg8gWYxeHe6oRRIyWvipuXiQyT+nuGmJ9LLrgbMCL6FSwRv6XmQ56qHBtR
 siWoZk0HrhTwfgMTkorb2K5KdsbG5QCJlm9Lb7NRp5Uppv9m95DMBUNf4qqVTQTIqLIN
 5w/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9KCoK88gpzBtqmTq5EC1fc00IBdi2FABzlZ6Q5EHL4k=;
 b=F7lE93GntnnN7F2ZsKr5Bgoz1HN+bbY99MKbHAgZGo7434+/YDEuinzb0B92AnqEng
 4RaCr1x6D6wOFuFWmmWuLcgh7xfFyU6hUkU+AtME7T+a9M0kKDmIKa3TSC7IslT6/KBZ
 KtjHiq5ZaXVZxlwyEATA1mooHNRGRpj4mhSOr0APj0LVIQIcakEMolregkQm/FAr3b5O
 x9d8P8JbokW+mdFKrP2mgAmPqgaJT8cPMPuvHcZkqsztAYMOQCBiqFe4qWes/gNAEiKC
 rO8+Bv9MsTjKnUCLSVDX76ARnR2oLr45cfNOp2tcGXxUXm6vzmFcD3/QNBQqcrM0PqXK
 jY/g==
X-Gm-Message-State: AOAM530BgxbhjvKI45aIujEUYOEvJxSHw2AlDW2C4VDvt4QMuCcb9WnI
 20tsOdCHeQS+hgiqXvcEhLqbtnXAoRqZSP7NAFfCFg==
X-Google-Smtp-Source: ABdhPJwaj+citAkihP9hJqL7lHUeSQGZv9aP+ztsSnR5VV2evtTAMdmsQsjDzE5996S3Y3m1h+cfX2SSyKSkb4vxgaA=
X-Received: by 2002:aca:b203:: with SMTP id b3mr11907824oif.118.1594605762169; 
 Sun, 12 Jul 2020 19:02:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200710104920.13550-1-frank.chang@sifive.com>
 <CAKmqyKPtKtD=G+tXcd2Y-TM2go1TWbETHK2e3vdN-ehHyHU9-w@mail.gmail.com>
In-Reply-To: <CAKmqyKPtKtD=G+tXcd2Y-TM2go1TWbETHK2e3vdN-ehHyHU9-w@mail.gmail.com>
From: Frank Chang <frank.chang@sifive.com>
Date: Mon, 13 Jul 2020 10:02:31 +0800
Message-ID: <CAE_xrPhEW_VSRQVkthwu0NmBQYBZ11phLRgSbFqqFc9wZZ38Xg@mail.gmail.com>
Subject: Re: [RFC 00/65] target/riscv: support vector extension v0.9
To: Alistair Francis <alistair23@gmail.com>
Content-Type: multipart/alternative; boundary="00000000000002e3f705aa4916b0"
Received-SPF: pass client-ip=2607:f8b0:4864:20::236;
 envelope-from=frank.chang@sifive.com; helo=mail-oi1-x236.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
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

--00000000000002e3f705aa4916b0
Content-Type: text/plain; charset="UTF-8"

On Sat, Jul 11, 2020 at 5:53 AM Alistair Francis <alistair23@gmail.com>
wrote:

> On Fri, Jul 10, 2020 at 5:59 AM <frank.chang@sifive.com> wrote:
> >
> > From: Frank Chang <frank.chang@sifive.com>
> >
> > This patchset implements the vector extension v0.9 for RISC-V on QEMU.
> >
> > This patchset is sent as RFC because RVV v0.9 is still in draft state.
> > However, as RVV v1.0 should be ratified soon and there shouldn't be
> > critical changes between RVV v1.0 and RVV v0.9. We would like to have
> > the community to review RVV v0.9 implementations. Once RVV v1.0 is
> > ratified, we will then upgrade to RVV v1.0.
> >
> > You can change the cpu argument: vext_spec to v0.9 (i.e. vext_spec=v0.9)
> > to run with RVV v0.9 instructions.
>
> Hello,
>
> First off thanks for the patches!
>
> QEMU has a policy of accepting draft specs as experimental. We
> currently support the v0.7.1 Vector extension for example, so this
> does not need to be an RFC and can be a full patch series that can be
> merged into master.
>
> I have applied the first few patches (PR should be out next week) and
> they should be in the QEMU 5.1 release. QEMU is currently in a freeze
> so I won't be able to merge this series for 5.1. In saying that please
> feel free to continue to send patches to the list, they can still be
> reviewed.
>
> In general we would need to gracefully handle extension upgrades and
> maintain backwards compatibility. This same principle doesn't apply to
> experimental features though (such as the vector extension) so you are
> free to remove support for the v0.7.1. For users who want v0.7.1
> support they can always use the QEMU 5.1. release. Just make sure that
> your series does not break bisectability.
>
> Thanks again for the patches!
>
> Alistair
>

Hi Alistair,

Thanks for the review.

Currently I would prefer to drop 0.7.1 support because I don't know if
there's
a good way to keep both 0.7.1 and 0.9 opcodes. I'm afraid it would cause the
encoding overlap while compiling with decodetree.

Does decodetree support any feature for multi-version opcodes?
Or if it can use something like C macros to compile with the opcodes by the
vspec
user assigned? If there's any good way to keep both versions, then I can
try to rearrange
my codes to support both vspecs.

Otherwise, I'll keep on my current approach to drop the support of v0.7.1
as the way
Richard has mentioned:
*If you don't want to simultaneously support 0.7.1 and 0.9/1.0, then you
should*
*simply remove 0.7.1 in the first patch, so that there's no confusion.*

Any suggestion would be appreciated.

Thanks
--
Frank Chang


> >
> > Chih-Min Chao (2):
> >   fpu: fix float16 nan check
> >   fpu: add api to handle alternative sNaN propagation
> >
> > Frank Chang (58):
> >   target/riscv: fix rsub gvec tcg_assert_listed_vecop assertion
> >   target/riscv: correct the gvec IR called in gen_vec_rsub16_i64()
> >   target/riscv: fix return value of do_opivx_widen()
> >   target/riscv: fix vill bit index in vtype register
> >   target/riscv: remove vsll.vi, vsrl.vi, vsra.vi insns from using gvec
> >   target/riscv: rvv-0.9: remove MLEN calculations
> >   target/riscv: rvv-0.9: add fractional LMUL, VTA and VMA
> >   target/riscv: rvv-0.9: update check functions
> >   target/riscv: rvv-0.9: configure instructions
> >   target/riscv: rvv-0.9: stride load and store instructions
> >   target/riscv: rvv-0.9: index load and store instructions
> >   target/riscv: rvv-0.9: fix address index overflow bug of indexed
> >     load/store insns
> >   target/riscv: rvv-0.9: fault-only-first unit stride load
> >   target/riscv: rvv-0.9: amo operations
> >   target/riscv: rvv-0.9: load/store whole register instructions
> >   target/riscv: rvv-0.9: update vext_max_elems() for load/store insns
> >   target/riscv: rvv-0.9: take fractional LMUL into vector max elements
> >     calculation
> >   target/riscv: rvv-0.9: floating-point square-root instruction
> >   target/riscv: rvv-0.9: floating-point classify instructions
> >   target/riscv: rvv-0.9: mask population count instruction
> >   target/riscv: rvv-0.9: find-first-set mask bit instruction
> >   target/riscv: rvv-0.9: set-X-first mask bit instructions
> >   target/riscv: rvv-0.9: iota instruction
> >   target/riscv: rvv-0.9: element index instruction
> >   target/riscv: rvv-0.9: integer scalar move instructions
> >   target/riscv: rvv-0.9: floating-point scalar move instructions
> >   target/riscv: rvv-0.9: whole register move instructions
> >   target/riscv: rvv-0.9: integer extension instructions
> >   target/riscv: rvv-0.9: single-width averaging add and subtract
> >     instructions
> >   target/riscv: rvv-0.9: integer add-with-carry/subtract-with-borrow
> >   target/riscv: rvv-0.9: narrowing integer right shift instructions
> >   target/riscv: rvv-0.9: widening integer multiply-add instructions
> >   target/riscv: rvv-0.9: quad-widening integer multiply-add instructions
> >   target/riscv: rvv-0.9: integer merge and move instructions
> >   target/riscv: rvv-0.9: single-width saturating add and subtract
> >     instructions
> >   target/riscv: rvv-0.9: integer comparison instructions
> >   target/riscv: rvv-0.9: floating-point compare instructions
> >   target/riscv: rvv-0.9: single-width integer reduction instructions
> >   target/riscv: rvv-0.9: widening integer reduction instructions
> >   target/riscv: rvv-0.9: mask-register logical instructions
> >   target/riscv: rvv-0.9: register gather instructions
> >   target/riscv: rvv-0.9: slide instructions
> >   target/riscv: rvv-0.9: floating-point slide instructions
> >   target/riscv: rvv-0.9: narrowing fixed-point clip instructions
> >   target/riscv: rvv-0.9: floating-point move instructions
> >   target/riscv: rvv-0.9: floating-point/integer type-convert
> >     instructions
> >   target/riscv: rvv-0.9: single-width floating-point reduction
> >   target/riscv: rvv-0.9: widening floating-point reduction instructions
> >   target/riscv: rvv-0.9: single-width scaling shift instructions
> >   target/riscv: rvv-0.9: remove widening saturating scaled multiply-add
> >   target/riscv: rvv-0.9: remove vmford.vv and vmford.vf
> >   target/riscv: rvv-0.9: remove integer extract instruction
> >   target/riscv: rvv-0.9: floating-point min/max instructions
> >   target/riscv: rvv-0.9: widening floating-point/integer type-convert
> >   target/riscv: rvv-0.9: narrowing floating-point/integer type-convert
> >   softfloat: add fp16 and uint8/int8 interconvert functions
> >   target/riscv: use softfloat lib float16 comparison functions
> >   target/riscv: bump to RVV 0.9
> >
> > Kito Cheng (1):
> >   fpu: implement full set compare for fp16
> >
> > LIU Zhiwei (4):
> >   target/riscv: rvv-0.9: add vcsr register
> >   target/riscv: rvv-0.9: add vector context status
> >   target/riscv: rvv-0.9: update mstatus_vs by tb_flags
> >   target/riscv: rvv-0.9: add vlenb register
> >
> >  fpu/softfloat-specialize.inc.c          |    4 +-
> >  fpu/softfloat.c                         |  342 +++-
> >  include/fpu/softfloat.h                 |   22 +
> >  target/riscv/cpu.c                      |    9 +-
> >  target/riscv/cpu.h                      |   68 +-
> >  target/riscv/cpu_bits.h                 |    9 +
> >  target/riscv/cpu_helper.c               |   13 +
> >  target/riscv/csr.c                      |   53 +-
> >  target/riscv/helper.h                   |  507 +++--
> >  target/riscv/insn32-64.decode           |   18 +-
> >  target/riscv/insn32.decode              |  282 +--
> >  target/riscv/insn_trans/trans_rvv.inc.c | 2468 ++++++++++++++---------
> >  target/riscv/internals.h                |   18 +-
> >  target/riscv/translate.c                |   43 +-
> >  target/riscv/vector_helper.c            | 2349 +++++++++++----------
> >  15 files changed, 3833 insertions(+), 2372 deletions(-)
> >
> > --
> > 2.17.1
> >
> >
>

--00000000000002e3f705aa4916b0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Sat, Jul 11, 2020 at 5:53 AM Alistair =
Francis &lt;<a href=3D"mailto:alistair23@gmail.com">alistair23@gmail.com</a=
>&gt; wrote:<br></div><div class=3D"gmail_quote"><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex">On Fri, Jul 10, 2020 at 5:59 AM &lt;<a href=3D"mail=
to:frank.chang@sifive.com" target=3D"_blank">frank.chang@sifive.com</a>&gt;=
 wrote:<br>
&gt;<br>
&gt; From: Frank Chang &lt;<a href=3D"mailto:frank.chang@sifive.com" target=
=3D"_blank">frank.chang@sifive.com</a>&gt;<br>
&gt;<br>
&gt; This patchset implements the vector extension v0.9 for RISC-V on QEMU.=
<br>
&gt;<br>
&gt; This patchset is sent as RFC because RVV v0.9 is still in draft state.=
<br>
&gt; However, as RVV v1.0 should be ratified soon and there shouldn&#39;t b=
e<br>
&gt; critical changes between RVV v1.0 and RVV v0.9. We would like to have<=
br>
&gt; the community to review RVV v0.9 implementations. Once RVV v1.0 is<br>
&gt; ratified, we will then upgrade to RVV v1.0.<br>
&gt;<br>
&gt; You can change the cpu argument: vext_spec to v0.9 (i.e. vext_spec=3Dv=
0.9)<br>
&gt; to run with RVV v0.9 instructions.<br>
<br>
Hello,<br>
<br>
First off thanks for the patches!<br>
<br>
QEMU has a policy of accepting draft specs as experimental. We<br>
currently support the v0.7.1 Vector extension for example, so this<br>
does not need to be an RFC and can be a full patch series that can be<br>
merged into master.<br>
<br>
I have applied the first few patches (PR should be out next week) and<br>
they should be in the QEMU 5.1 release. QEMU is currently in a freeze<br>
so I won&#39;t be able to merge this series for 5.1. In saying that please<=
br>
feel free to continue to send patches to the list, they can still be<br>
reviewed.<br>
<br>
In general we would need to gracefully handle extension upgrades and<br>
maintain backwards compatibility. This same principle doesn&#39;t apply to<=
br>
experimental features though (such as the vector extension) so you are<br>
free to remove support for the v0.7.1. For users who want v0.7.1<br>
support they can always use the QEMU 5.1. release. Just make sure that<br>
your series does not break bisectability.<br>
<br>
Thanks again for the patches!<br>
<br>
Alistair<br></blockquote><div><br></div><div>Hi Alistair,</div><div><br></d=
iv><div>Thanks for the review.</div><div><br></div><div>Currently I would p=
refer to drop 0.7.1 support because I don&#39;t know if there&#39;s</div><d=
iv>a good way to keep both 0.7.1 and 0.9 opcodes. I&#39;m afraid it would c=
ause the</div><div>encoding overlap while compiling with decodetree.</div><=
div><br></div><div>Does decodetree support any feature for multi-version op=
codes?</div><div>Or if it can use something like C macros to compile with t=
he opcodes by the vspec</div><div>user assigned? If there&#39;s any good wa=
y to keep both versions, then I can try to rearrange</div><div>my codes to =
support both vspecs.</div><div><br></div><div>Otherwise, I&#39;ll keep on m=
y current approach to drop the support of v0.7.1 as the way</div><div>Richa=
rd has mentioned:</div><div><i>If you don&#39;t want to simultaneously supp=
ort 0.7.1 and 0.9/1.0, then you should</i><br></div><div><i>simply remove 0=
.7.1 in the first patch, so that there&#39;s no confusion.</i><br></div><di=
v><br></div><div>Any suggestion would be appreciated.</div><div><br></div><=
div>Thanks</div><div>--</div><div>Frank Chang</div><div><br></div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">
<br>
&gt;<br>
&gt; Chih-Min Chao (2):<br>
&gt;=C2=A0 =C2=A0fpu: fix float16 nan check<br>
&gt;=C2=A0 =C2=A0fpu: add api to handle alternative sNaN propagation<br>
&gt;<br>
&gt; Frank Chang (58):<br>
&gt;=C2=A0 =C2=A0target/riscv: fix rsub gvec tcg_assert_listed_vecop assert=
ion<br>
&gt;=C2=A0 =C2=A0target/riscv: correct the gvec IR called in gen_vec_rsub16=
_i64()<br>
&gt;=C2=A0 =C2=A0target/riscv: fix return value of do_opivx_widen()<br>
&gt;=C2=A0 =C2=A0target/riscv: fix vill bit index in vtype register<br>
&gt;=C2=A0 =C2=A0target/riscv: remove <a href=3D"http://vsll.vi" rel=3D"nor=
eferrer" target=3D"_blank">vsll.vi</a>, <a href=3D"http://vsrl.vi" rel=3D"n=
oreferrer" target=3D"_blank">vsrl.vi</a>, <a href=3D"http://vsra.vi" rel=3D=
"noreferrer" target=3D"_blank">vsra.vi</a> insns from using gvec<br>
&gt;=C2=A0 =C2=A0target/riscv: rvv-0.9: remove MLEN calculations<br>
&gt;=C2=A0 =C2=A0target/riscv: rvv-0.9: add fractional LMUL, VTA and VMA<br=
>
&gt;=C2=A0 =C2=A0target/riscv: rvv-0.9: update check functions<br>
&gt;=C2=A0 =C2=A0target/riscv: rvv-0.9: configure instructions<br>
&gt;=C2=A0 =C2=A0target/riscv: rvv-0.9: stride load and store instructions<=
br>
&gt;=C2=A0 =C2=A0target/riscv: rvv-0.9: index load and store instructions<b=
r>
&gt;=C2=A0 =C2=A0target/riscv: rvv-0.9: fix address index overflow bug of i=
ndexed<br>
&gt;=C2=A0 =C2=A0 =C2=A0load/store insns<br>
&gt;=C2=A0 =C2=A0target/riscv: rvv-0.9: fault-only-first unit stride load<b=
r>
&gt;=C2=A0 =C2=A0target/riscv: rvv-0.9: amo operations<br>
&gt;=C2=A0 =C2=A0target/riscv: rvv-0.9: load/store whole register instructi=
ons<br>
&gt;=C2=A0 =C2=A0target/riscv: rvv-0.9: update vext_max_elems() for load/st=
ore insns<br>
&gt;=C2=A0 =C2=A0target/riscv: rvv-0.9: take fractional LMUL into vector ma=
x elements<br>
&gt;=C2=A0 =C2=A0 =C2=A0calculation<br>
&gt;=C2=A0 =C2=A0target/riscv: rvv-0.9: floating-point square-root instruct=
ion<br>
&gt;=C2=A0 =C2=A0target/riscv: rvv-0.9: floating-point classify instruction=
s<br>
&gt;=C2=A0 =C2=A0target/riscv: rvv-0.9: mask population count instruction<b=
r>
&gt;=C2=A0 =C2=A0target/riscv: rvv-0.9: find-first-set mask bit instruction=
<br>
&gt;=C2=A0 =C2=A0target/riscv: rvv-0.9: set-X-first mask bit instructions<b=
r>
&gt;=C2=A0 =C2=A0target/riscv: rvv-0.9: iota instruction<br>
&gt;=C2=A0 =C2=A0target/riscv: rvv-0.9: element index instruction<br>
&gt;=C2=A0 =C2=A0target/riscv: rvv-0.9: integer scalar move instructions<br=
>
&gt;=C2=A0 =C2=A0target/riscv: rvv-0.9: floating-point scalar move instruct=
ions<br>
&gt;=C2=A0 =C2=A0target/riscv: rvv-0.9: whole register move instructions<br=
>
&gt;=C2=A0 =C2=A0target/riscv: rvv-0.9: integer extension instructions<br>
&gt;=C2=A0 =C2=A0target/riscv: rvv-0.9: single-width averaging add and subt=
ract<br>
&gt;=C2=A0 =C2=A0 =C2=A0instructions<br>
&gt;=C2=A0 =C2=A0target/riscv: rvv-0.9: integer add-with-carry/subtract-wit=
h-borrow<br>
&gt;=C2=A0 =C2=A0target/riscv: rvv-0.9: narrowing integer right shift instr=
uctions<br>
&gt;=C2=A0 =C2=A0target/riscv: rvv-0.9: widening integer multiply-add instr=
uctions<br>
&gt;=C2=A0 =C2=A0target/riscv: rvv-0.9: quad-widening integer multiply-add =
instructions<br>
&gt;=C2=A0 =C2=A0target/riscv: rvv-0.9: integer merge and move instructions=
<br>
&gt;=C2=A0 =C2=A0target/riscv: rvv-0.9: single-width saturating add and sub=
tract<br>
&gt;=C2=A0 =C2=A0 =C2=A0instructions<br>
&gt;=C2=A0 =C2=A0target/riscv: rvv-0.9: integer comparison instructions<br>
&gt;=C2=A0 =C2=A0target/riscv: rvv-0.9: floating-point compare instructions=
<br>
&gt;=C2=A0 =C2=A0target/riscv: rvv-0.9: single-width integer reduction inst=
ructions<br>
&gt;=C2=A0 =C2=A0target/riscv: rvv-0.9: widening integer reduction instruct=
ions<br>
&gt;=C2=A0 =C2=A0target/riscv: rvv-0.9: mask-register logical instructions<=
br>
&gt;=C2=A0 =C2=A0target/riscv: rvv-0.9: register gather instructions<br>
&gt;=C2=A0 =C2=A0target/riscv: rvv-0.9: slide instructions<br>
&gt;=C2=A0 =C2=A0target/riscv: rvv-0.9: floating-point slide instructions<b=
r>
&gt;=C2=A0 =C2=A0target/riscv: rvv-0.9: narrowing fixed-point clip instruct=
ions<br>
&gt;=C2=A0 =C2=A0target/riscv: rvv-0.9: floating-point move instructions<br=
>
&gt;=C2=A0 =C2=A0target/riscv: rvv-0.9: floating-point/integer type-convert=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0instructions<br>
&gt;=C2=A0 =C2=A0target/riscv: rvv-0.9: single-width floating-point reducti=
on<br>
&gt;=C2=A0 =C2=A0target/riscv: rvv-0.9: widening floating-point reduction i=
nstructions<br>
&gt;=C2=A0 =C2=A0target/riscv: rvv-0.9: single-width scaling shift instruct=
ions<br>
&gt;=C2=A0 =C2=A0target/riscv: rvv-0.9: remove widening saturating scaled m=
ultiply-add<br>
&gt;=C2=A0 =C2=A0target/riscv: rvv-0.9: remove vmford.vv and vmford.vf<br>
&gt;=C2=A0 =C2=A0target/riscv: rvv-0.9: remove integer extract instruction<=
br>
&gt;=C2=A0 =C2=A0target/riscv: rvv-0.9: floating-point min/max instructions=
<br>
&gt;=C2=A0 =C2=A0target/riscv: rvv-0.9: widening floating-point/integer typ=
e-convert<br>
&gt;=C2=A0 =C2=A0target/riscv: rvv-0.9: narrowing floating-point/integer ty=
pe-convert<br>
&gt;=C2=A0 =C2=A0softfloat: add fp16 and uint8/int8 interconvert functions<=
br>
&gt;=C2=A0 =C2=A0target/riscv: use softfloat lib float16 comparison functio=
ns<br>
&gt;=C2=A0 =C2=A0target/riscv: bump to RVV 0.9<br>
&gt;<br>
&gt; Kito Cheng (1):<br>
&gt;=C2=A0 =C2=A0fpu: implement full set compare for fp16<br>
&gt;<br>
&gt; LIU Zhiwei (4):<br>
&gt;=C2=A0 =C2=A0target/riscv: rvv-0.9: add vcsr register<br>
&gt;=C2=A0 =C2=A0target/riscv: rvv-0.9: add vector context status<br>
&gt;=C2=A0 =C2=A0target/riscv: rvv-0.9: update mstatus_vs by tb_flags<br>
&gt;=C2=A0 =C2=A0target/riscv: rvv-0.9: add vlenb register<br>
&gt;<br>
&gt;=C2=A0 fpu/softfloat-specialize.inc.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 |=C2=A0 =C2=A0 4 +-<br>
&gt;=C2=A0 fpu/softfloat.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 342 +++-<br>
&gt;=C2=A0 include/fpu/softfloat.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A022 +<br>
&gt;=C2=A0 target/riscv/cpu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 9 +-<br>
&gt;=C2=A0 target/riscv/cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A068 +-<br>
&gt;=C2=A0 target/riscv/cpu_bits.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 9 +<br>
&gt;=C2=A0 target/riscv/cpu_helper.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A013 +<br>
&gt;=C2=A0 target/riscv/csr.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A053 +-<br>
&gt;=C2=A0 target/riscv/helper.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 507 +++--<br>
&gt;=C2=A0 target/riscv/insn32-64.decode=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 =C2=A018 +-<br>
&gt;=C2=A0 target/riscv/insn32.decode=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 |=C2=A0 282 +--<br>
&gt;=C2=A0 target/riscv/insn_trans/trans_rvv.inc.c | 2468 ++++++++++++++---=
------<br>
&gt;=C2=A0 target/riscv/internals.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A018 +-<br>
&gt;=C2=A0 target/riscv/translate.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A043 +-<br>
&gt;=C2=A0 target/riscv/vector_helper.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 | 2349 +++++++++++----------<br>
&gt;=C2=A0 15 files changed, 3833 insertions(+), 2372 deletions(-)<br>
&gt;<br>
&gt; --<br>
&gt; 2.17.1<br>
&gt;<br>
&gt;<br>
</blockquote></div></div>

--00000000000002e3f705aa4916b0--

