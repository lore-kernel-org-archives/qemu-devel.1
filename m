Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EA10C4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 18:10:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33D2522456
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 18:10:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K8yuIFjc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33D2522456
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52618 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVIYy-0004oZ-I4
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 14:10:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54280)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kVICC-0006Km-3q
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 13:46:45 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:35272)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kVIC8-0007qT-Px
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 13:46:42 -0400
Received: by mail-wr1-x444.google.com with SMTP id n15so4112689wrq.2
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2020 10:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=3VbJA+1nBSntIUhT99eRWLIrheQR0iNHPQZZ9kWVVAQ=;
 b=K8yuIFjcJZWA1pJHAuUhIB6xCkeLN7XCj1AJLfLhS2GhAweVSpsF17UL9H8vctqbyb
 wjD55EKgscKjGAxOv3Thbm5biz/AbKnPwhgDgNDzvD7FK1xF5QNjX1xHN/LSbgDzblq+
 KvE7DIBpzok13/HFZVv3JKbAo3CGCJUfE0ljCvS8q0lzuiJItlYAPIBNGv5zyZ/qZq+L
 xeUpcMjqd0ka/Zs6yP6RQO3Db1cLIvhT6XFAYtJKwajGTCDkQJ2ltBxhYwaonEjyScIt
 16Z/vb41DJgXArgru6b2Ce22VpGOia/qpzP0R0wtfMSOn6ZOa4iBWRl7eBR7T6NyoCNK
 purA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=3VbJA+1nBSntIUhT99eRWLIrheQR0iNHPQZZ9kWVVAQ=;
 b=mLUtlO1/BYKfJHdqnxzMnpwRSRFTExj0k0WPvFx7MbPrMQ2PkGFK2I0/VKPI2vQzlu
 BjlHSnQA2mvleEj5spjmQpM2w29bHwg/BSUIwSnx11iRcunANYcRjc8QxJG+vLEjI+sp
 xQA43ahDBznuSO66da6flGbMyDvRZ2igOQq1bxngB7RO9iJ0wBG6OkOFcrWN0Y+iA2u5
 1JXI41VshR9djnHkBC0cSTo5Srv4csIk68AAOam4sMI4CMSGV1yU1oCXE5H/B199QIlQ
 ChiWW/Zc2JqjfpVY/a6Pax4to9UVnxLs+LAAIUxTWd7iyQvo4SGJ3e1J0LP1MzCikNr5
 u+Cg==
X-Gm-Message-State: AOAM533xAN2PUB3Rtbif8vOKg3Ut3JCsscVNl4pmP4zQphItEFeKkEqz
 R4SP6z37ht3Tz1v2yL+cP50IFQ==
X-Google-Smtp-Source: ABdhPJy9L81KHbnL2tEtvfS+37Raf0EIjNOCE/sMVN1BA4PSUVHbKr86Uqm4s1Txu/HogT9wNScQWA==
X-Received: by 2002:adf:bbc6:: with SMTP id z6mr6040052wrg.298.1603302398569; 
 Wed, 21 Oct 2020 10:46:38 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id o129sm4581179wmb.25.2020.10.21.10.46.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2020 10:46:37 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C7E171FF7E;
 Wed, 21 Oct 2020 18:46:36 +0100 (BST)
References: <20201021045149.1582203-1-richard.henderson@linaro.org>
User-agent: mu4e 1.5.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [RFC PATCH 00/15] softfloat: alternate conversion of
 float128_addsub
In-reply-to: <20201021045149.1582203-1-richard.henderson@linaro.org>
Date: Wed, 21 Oct 2020 18:46:36 +0100
Message-ID: <87o8kvv5dv.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> Hi Alex,
>
> Here's my first adjustment to your conversion for 128-bit floats.
>
> The Idea is to use a set of macros and an include file so that we
> can re-use the same large chunk of code that performs the basic
> operations on various fraction lengths.  It's ugly, but without
> proper language support it seems to be less ugly than most.
>
> While I've just gone and added lots of stuff to int128... I have
> had another idea, half-baked because I'm tired and it's late:
>
> typedef struct {
>     FloatClass cls;
>     int exp;
>     bool sign;
>     uint64_t frac[];
> } FloatPartsBase;
>
> typedef struct {
>     FloatPartsBase base;
>     uint64_t frac;
> } FloatParts64;
>
> typedef struct {
>     FloatPartsBase base;
>     uint64_t frac_hi, frac_lo;
> } FloatParts128;
>
> typedef struct {
>     FloatPartsBase base;
>     uint64_t frac[4]; /* big endian word ordering */
> } FloatParts256;
>
> This layout, with the big-endian ordering, means that storage
> can be shared between them, just by ignoring the least significant
> words of the fraction as needed.  Which may make muladd more
> understandable.

Would the big-endian formatting hamper the compiler on x86 where it can
do extra wide operations?

I am still seeing a multi MFlop drop in performance when converting the
float128_addsub to the new code. If this allows the compiler to do
better on the code I can live with it.

>
> E.g.
>
> static void muladd_floats64(FloatParts128 *r, FloatParts64 *a,
>                             FloatParts64 *b, FloatParts128 *c, ...)
> {
>     // handle nans
>     // produce 128-bit product into r
>     // handle p vs c special cases.
>     // zero-extend c to 128-bits
>     c->frac[1] =3D 0;
>     // perform 128-bit fractional addition
>     addsub_floats128(r, c, ...);
>     // fold 128-bit fraction to 64-bit sticky bit.
>     r->frac[0] |=3D r->frac[1] !=3D 0;
> }
>
> float64 float64_muladd(float64 a, float64 b, float64 c, ...)
> {
>     FloatParts64 pa, pb;
>     FloatParts128 pc, pr;
>
>     float64_unpack_canonical(&pa.base, a, status);
>     float64_unpack_canonical(&pb.base, b, status);
>     float64_unpack_canonical(&pc.base, c, status);
>     muladd_floats64(&pr, &pa, &pb, &pc, flags, status);
>
>     return float64_round_pack_canonical(&pr.base, status);
> }
>
> Similarly, muladd_floats128 would use addsub_floats256.
>
> However, the big-endian word ordering means that Int128
> cannot be used directly; so a set of wrappers are needed.
> If added the Int128 routine just for use here, then it's
> probably easier to bypass Int128 and just code it here.

Are you talking about all our operations? Will we still need to#ifdef
CONFIG_INT128 in the softfloat code?

>
> Thoughts?
>
>
> r~
>
>
> Richard Henderson (15):
>   qemu/int128: Add int128_or
>   qemu/int128: Add int128_clz, int128_ctz
>   qemu/int128: Rename int128_rshift, int128_lshift
>   qemu/int128: Add int128_shr
>   qemu/int128: Add int128_geu
>   softfloat: Use mulu64 for mul64To128
>   softfloat: Use int128.h for some operations
>   softfloat: Tidy a * b + inf return
>   softfloat: Add float_cmask and constants
>   softfloat: Inline float_raise
>   Test split to softfloat-parts.c.inc
>   softfloat: Streamline FloatFmt
>   Test float128_addsub
>   softfloat: Use float_cmask for addsub_floats
>   softfloat: Improve subtraction of equal exponent
>
>  include/fpu/softfloat-macros.h |  89 ++--
>  include/fpu/softfloat.h        |   5 +-
>  include/qemu/int128.h          |  61 ++-
>  fpu/softfloat.c                | 802 ++++++++++-----------------------
>  softmmu/physmem.c              |   4 +-
>  target/ppc/int_helper.c        |   4 +-
>  tests/test-int128.c            |  44 +-
>  fpu/softfloat-parts.c.inc      | 339 ++++++++++++++
>  fpu/softfloat-specialize.c.inc |  45 +-
>  9 files changed, 716 insertions(+), 677 deletions(-)
>  create mode 100644 fpu/softfloat-parts.c.inc


--=20
Alex Benn=C3=A9e

