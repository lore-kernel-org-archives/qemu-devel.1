Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E82DAC43331
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 10:32:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A23AC222CD
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 10:32:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ThSqFBRY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A23AC222CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUpx5-0006JK-SL
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 05:32:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51708)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iUpvl-0005oc-Ua
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 05:31:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iUpvj-0002G7-V0
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 05:31:21 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:35286)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iUpvj-0002FZ-Lx
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 05:31:19 -0500
Received: by mail-wr1-x42b.google.com with SMTP id s5so1736727wrw.2
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2019 02:31:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=2XTN6HFZHpvi9fJyVA+vFEHbMc3hZWiH6h6HZ+XSY6o=;
 b=ThSqFBRYYLdzMbubWkeWSAAojZniuLZhevXM0fNZZ70FOk/OaLTY7oBJLPi4FuFmmO
 ljqd97ZnUOYDuK0C01N0Dh0iLS8sGlUxzNB0MnFkaH6lfuMRNBgq29gLEKjN1nHEXpDH
 +fFpOKOg3CTALMJuFn6OARQtloYQIVDAbQ9Ac4q/Vlult6imISXEWtc4/qECzdw3BbPq
 uOqu1ZM6CO16iF/vk5hqZe4UESKPSspa+i3rwWETBVT70rd4w0V2+grGJW4af4QHIzKF
 sufLap3/RgcT2jQMotu8cJvvUSfKytp1wUlQkI6QN5MUYiYRGqx2BGjFEt1cBDmEBscS
 4dFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=2XTN6HFZHpvi9fJyVA+vFEHbMc3hZWiH6h6HZ+XSY6o=;
 b=VCVWJqiTHf56b57ts31mNhRiRDBXXucsuDDCNCReIpj3GtTDQreWbIuZMOgY3DLBPE
 2l8U1sXki98aA8tYEdbtJ+Myx7Sk+giSL6xKyE5T7bMARRqDi5elvyRUDlawi7Q7rl86
 d/4t9+l+F0lktkXoi34oMMzXE5fXaNWPxUjZf9aZHaJLXswSB0ePa+gg/2WaMg93IQVy
 R0aU4BZMkCq3YnTZ+Woh1MZ8S2k8hNDiNVPPnMaM5eE6xqLhDwLRuSbxOWzWCz/XhJ8d
 AJQlnR7TEvUmb/kHumzrULBbsR5xeg53lk1euGhAU/7IKVCGL/v9DlpMqqquW7DHVk4g
 kXZQ==
X-Gm-Message-State: APjAAAXUH3cgq4gS0mTT7uBVTi512dirZ/w/gvV4NgL94Dat6xQv8brd
 A31arwjpIXzjKq6OvNd3kG/DSw==
X-Google-Smtp-Source: APXvYqwJqxG1tee1h9V1TAKD+fN8v3XT4XXE0SC6j4iDUnF12H88a55QCrZ3nNI8sYUTv7GRR9Bfbg==
X-Received: by 2002:adf:e911:: with SMTP id f17mr2209758wrm.300.1573641078126; 
 Wed, 13 Nov 2019 02:31:18 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id w81sm2159615wmg.5.2019.11.13.02.31.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Nov 2019 02:31:16 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 25A291FF87;
 Wed, 13 Nov 2019 10:31:16 +0000 (GMT)
References: <BYAPR02MB48863165DEE32E5C563E93F4DE650@BYAPR02MB4886.namprd02.prod.outlook.com>
 <CAL1e-=jvmJNiZR4iLDL-97qm=v+2s0cwn5YTzJQ=JZ_gwOe4tQ@mail.gmail.com>
 <BYAPR02MB4886C8D82898F1E406C124F8DE7E0@BYAPR02MB4886.namprd02.prod.outlook.com>
 <BYAPR02MB48865884056A88B660B620FCDE770@BYAPR02MB4886.namprd02.prod.outlook.com>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: Re: QEMU for Qualcomm Hexagon - KVM Forum talk and code available
In-reply-to: <BYAPR02MB48865884056A88B660B620FCDE770@BYAPR02MB4886.namprd02.prod.outlook.com>
Date: Wed, 13 Nov 2019 10:31:16 +0000
Message-ID: <87d0dw83uz.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42b
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
Cc: Alessandro Di Federico <ale@rev.ng>, Taylor Simpson <tsimpson@quicinc.com>,
 "nizzo@rev.ng" <nizzo@rev.ng>,
 =?utf-8?Q?Niccol=C3=B2?= Izzo <izzoniccolo@gmail.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Taylor Simpson <tsimpson@quicinc.com> writes:

> I had discussions with several people at the KVM Forum, and I=E2=80=99ve =
been thinking about how to divide up the code for community review.  Here i=
s my proposal for the steps.
>
>   1.  linux-user changes + linux-user/hexagon + skeleton of target/hexagon
> This is the minimum amount to build and run a very simple program.  I
>   have an assembly program that prints =E2=80=9CHello=E2=80=9D and exits.=
  It is
>   constructed to use very few instructions that can be added brute
>   force in the Hexagon back end.

I'm hoping most of the linux-user changes are in the hexagon runloop?
There has been quite a bit of work splitting up and cleaning up the
#ifdef mess in linux-user over the last few years.

>   2.  Add the code that is imported from the Hexagon simulator and the qe=
mu helper generator
> This will allow the scalar ISA to be executed.  This will grow the set
> of programs that could execute, but there will still be limitations.
> In particular, there can be no packets which means the C library won=E2=
=80=99t
> work .  We have to build with -nostdlib

You could run -nostdlib system TCG tests (hello and memory) but that
would require modelling some sort of hardware and assumes you have a
simple serial port or semihosting solution. That said a bunch of the
MIPS tests are linux-user and -nostdlib so that isn't a major problem in
getting some of the tests running.

When you say code imported from the hexagon simulator I was under the
impression you were generating code from the instruction description.
Otherwise you'll need to be very clear about your licensing grants.

>   3.  Add support for packet semantics
> At this point, we will be able to execute full programs linked with
> the C library.  This will include the check-tcg tests.

I think the interesting question is if the roll-back semantics of the
hexagon are something we might need for other emulated architectures or
is a particularly specific solution for Hexagon (I'm guessing the later).

>   4.  Add support for the wide vector extensions
>   5.  Add the helper overrides for performance optimization
> Some of these will be written by hand, and we=E2=80=99ll work with rev.ng=
 to
>   integrate their flex/bison generator.

One thing to nail down will be will we include the generated code in the
source tree with a tool to regenerate (much like we do for
linux-headers) or if we want to add the dependency and regenerate each
time from scratch. I don't see including flex/bison as a dependency
being a major issue (in fact we have it in our docker images so I guess
something uses it). However it might be trickier depending on
libclang which was also being discussed.

>
> I would love some feedback on this proposal.  Hopefully, that is enough d=
etail so that people can comment.  If anything isn=E2=80=99t clear, please =
ask questions.
>
>
> Thanks,
> Taylor
>
>
> From: Qemu-devel <qemu-devel-bounces+tsimpson=3Dquicinc.com@nongnu.org> O=
n Behalf Of Taylor Simpson
> Sent: Tuesday, November 5, 2019 10:33 AM
> To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
> Cc: Alessandro Di Federico <ale@rev.ng>; nizzo@rev.ng; qemu-devel@nongnu.=
org; Niccol=C3=B2 Izzo <izzoniccolo@gmail.com>
> Subject: RE: QEMU for Qualcomm Hexagon - KVM Forum talk and code available
>
> Hi Aleksandar,
>
> Thank you =E2=80=93 We=E2=80=99re glad you enjoyed the talk.
>
> One point of clarification on SIMD in Hexagon.  What we refer to as the =
=E2=80=9Cscalar=E2=80=9D core does have some SIMD operations.  Register pai=
rs are 8 bytes, and there are several SIMD instructions.  The example we sh=
owed in the talk included a VADDH instruction.  It treats the register pair=
 as 4 half-words and does a vector add.  Then there are the Hexagon Vector =
eXtensions (HVX) instructions that operate on 128-byte vectors.  There is a=
 wide variety of instructions in this set.  As you mentioned, some of them =
are pure SIMD and others are very complex.
>
> For the helper generator, the vast majority of these are implemented with=
 helpers.  There are only 2 vector instructions in the scalar core that hav=
e a TCG override, and all of the HVX instructions are implemented with help=
ers.  If you are interested in a deeper dive, see below.
>
> Alessandro and Niccolo can comment on the flex/bison implementation.
>
> Thanks,
> Taylor
>
>
> Now for the deeper dive in case anyone is interested.  Look at the genptr=
.c file in target/hexagon.
>
> The first vector instruction that is with an override is A6_vminub_RdP.  =
It does a byte-wise comparison of two register pairs and sets a predicate r=
egister indicating whether the byte in the left or right operand is greater=
.  Here is the TCG code.
> #define fWRAP_A6_vminub_RdP(GENHLPR, SHORTCODE) \
> { \
>     TCGv BYTE =3D tcg_temp_new(); \
>     TCGv left =3D tcg_temp_new(); \
>     TCGv right =3D tcg_temp_new(); \
>     TCGv tmp =3D tcg_temp_new(); \
>     int i; \
>     tcg_gen_movi_tl(PeV, 0); \
>     tcg_gen_movi_i64(RddV, 0); \
>     for (i =3D 0; i < 8; i++) { \
>         fGETUBYTE(i, RttV); \
>         tcg_gen_mov_tl(left, BYTE); \
>         fGETUBYTE(i, RssV); \
>         tcg_gen_mov_tl(right, BYTE); \
>         tcg_gen_setcond_tl(TCG_COND_GT, tmp, left, right); \
>         fSETBIT(i, PeV, tmp); \
>         fMIN(tmp, left, right); \
>         fSETBYTE(i, RddV, tmp); \
>     } \
>     tcg_temp_free(BYTE); \
>     tcg_temp_free(left); \
>     tcg_temp_free(right); \
>     tcg_temp_free(tmp); \
> }
>
> The second instruction is S2_vsplatrb.  It takes the byte from the operan=
d and replicates it 4 times into the destination register.  Here is the TCG=
 code.
> #define fWRAP_S2_vsplatrb(GENHLPR, SHORTCODE) \
> { \
>     TCGv tmp =3D tcg_temp_new(); \
>     int i; \
>     tcg_gen_movi_tl(RdV, 0); \
>     tcg_gen_andi_tl(tmp, RsV, 0xff); \
>     for (i =3D 0; i < 4; i++) { \
>         tcg_gen_shli_tl(RdV, RdV, 8); \
>         tcg_gen_or_tl(RdV, RdV, tmp); \
>     } \
>     tcg_temp_free(tmp); \
> }
>
>
> From: Aleksandar Markovic <aleksandar.m.mail@gmail.com<mailto:aleksandar.=
m.mail@gmail.com>>
> Sent: Monday, November 4, 2019 6:05 PM
> To: Taylor Simpson <tsimpson@quicinc.com<mailto:tsimpson@quicinc.com>>
> Cc: qemu-devel@nongnu.org<mailto:qemu-devel@nongnu.org>; Alessandro Di Fe=
derico <ale@rev.ng<mailto:ale@rev.ng>>; nizzo@rev.ng<mailto:nizzo@rev.ng>; =
Niccol=C3=B2 Izzo <izzoniccolo@gmail.com<mailto:izzoniccolo@gmail.com>>
> Subject: Re: QEMU for Qualcomm Hexagon - KVM Forum talk and code available
>
>
> CAUTION: This email originated from outside of the organization.
>
>
> On Friday, October 25, 2019, Taylor Simpson <tsimpson@quicinc.com<mailto:=
tsimpson@quicinc.com>> wrote:
> We would like inform the you that we will be doing a talk at the KVM Foru=
m next week on QEMU for Qualcomm Hexagon.  Alessandro Di Federico, Niccolo =
Izzo, and I have been working independently on implementations of the Hexag=
on target.  We plan to merge the implementations, have a community review, =
and ultimately have Hexagon be an official target in QEMU.  Our code is ava=
ilable at the links below.
> https://github.com/revng/qemu-hexagon
> https://github.com/quic/qemu
> If anyone has any feedback on the code as it stands today or guidance on =
how best to prepare it for review, please let us know.
>
>
> Hi, Taylor, Niccolo (and Alessandro too).
>
> I didn't have a chance to take a look at neither the code nor the docs, b=
ut I did attend you presentation at KVM Forum, and I found it superb and at=
tractive, one of the best on the conference, if not the very best.
>
> I just have a couple of general questions:
>
> - Regarding the code you plan to upstream, are all SIMD instructions impl=
emented via tcg API, or perhaps some of them remain being implemented using=
 helpers?
>
> - Most of SIMD instructions can be viewed simply as several paralel eleme=
ntary operations. However, for a given SIMD instruction set, usually not al=
l of them fit into this pattern. For example, "horizontal add" (addind data=
 elements from the same SIMD register), various "pack/unpack/interleave/mer=
ge" operations, and more general "shuffle/permute" operations as well (here=
 I am not sure which of these are included in Hexagon SIMD set, but there m=
ust be some). How did you deal with them?
>
> - What were the most challenging Hexagon SIMD instructions you came accro=
ss while developing your solution?
>
> Sincerely,
> Aleksandar
>
>
>
>
> Thanks,
> Taylor


--
Alex Benn=C3=A9e

