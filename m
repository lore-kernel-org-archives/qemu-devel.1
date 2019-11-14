Return-Path: <SRS0=NHD5=ZG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73CEEC432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 18:06:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A60720709
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 18:06:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A60720709
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=keithp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60418 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVJVz-0003IH-Al
	for qemu-devel@archiver.kernel.org; Thu, 14 Nov 2019 13:06:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43654)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <keithp@keithp.com>) id 1iVJV2-0002gR-R8
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 13:05:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <keithp@keithp.com>) id 1iVJV1-00017n-8q
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 13:05:44 -0500
Received: from home.keithp.com ([63.227.221.253]:38050 helo=elaine.keithp.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <keithp@keithp.com>) id 1iVJV0-00017O-Ul
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 13:05:43 -0500
Received: from localhost (localhost [127.0.0.1])
 by elaine.keithp.com (Postfix) with ESMTP id D741F3F29ADC;
 Thu, 14 Nov 2019 10:05:40 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at keithp.com
Received: from elaine.keithp.com ([127.0.0.1])
 by localhost (elaine.keithp.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id WsVXyEzGYqFJ; Thu, 14 Nov 2019 10:05:40 -0800 (PST)
Received: from keithp.com (koto.keithp.com [10.0.0.2])
 by elaine.keithp.com (Postfix) with ESMTPSA id 862B13F29ADB;
 Thu, 14 Nov 2019 10:05:40 -0800 (PST)
Received: by keithp.com (Postfix, from userid 1000)
 id 694C4158212B; Thu, 14 Nov 2019 10:05:40 -0800 (PST)
From: "Keith Packard" <keithp@keithp.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] Semihost SYS_READC implementation (v4)
In-Reply-To: <CAFEAcA-MRtr9WUpqqwJiX9kc+ybGdgfv7ZB5Tc6_q9xwHwebsQ@mail.gmail.com>
References: <89ada4b1-ee3d-a512-07c2-9bc1ba5806da@redhat.com>
 <20191024224622.12371-1-keithp@keithp.com> <8736fhm9tw.fsf@linaro.org>
 <87pnik4w9n.fsf@keithp.com>
 <CAFEAcA-g+RkvYjseDE=1Z=gnLum0Cjvn_7bqB3ti+cBq9UZ3Eg@mail.gmail.com>
 <87mudo4owu.fsf@keithp.com>
 <CAFEAcA-MRtr9WUpqqwJiX9kc+ybGdgfv7ZB5Tc6_q9xwHwebsQ@mail.gmail.com>
Date: Thu, 14 Nov 2019 10:05:40 -0800
Message-ID: <87zhgytjt7.fsf@keithp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha256; protocol="application/pgp-signature"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 63.227.221.253
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Peter Maydell <peter.maydell@linaro.org> writes:

> I had an idle glance at this implementation, and this:
>
>    uint32_t pre =3D opcode_at(&ctx->base, ctx->base.pc_next - 4);
>    uint32_t ebreak =3D opcode_at(&ctx->base, ctx->base.pc_next);
>    uint32_t post =3D opcode_at(&ctx->base, ctx->base.pc_next + 4);
>
> (where opcode_at() is a wrapper for cpu_ldl_code()) has
> some unfortunate side effects: if the previous instruction
> is in the previous MMU page, or the following instruction
> is in the next MMU page, you might incorrectly trigger
> an exception (where QEMU will just longjmp straight out of
> the cpu_ldl_code()) if that other page isn't actually mapped
> in the guest's page table. You need to be careful not to access
> code outside the page you're actually on unless you're really
> going to execute it and are OK with it faulting.

I can't even find the implementation of cpu_ldl_code; the qemu source
code is somewhat obscure in this area. But, longjmp'ing out of the
middle of that seems like a bad idea.

> Does your semihosting spec expect to have the semihosting
> call work if the sequence crosses a page boundary, the
> code is being executed by a userspace process, and one of
> the two pages has been paged out by the OS ?

You've seen the entirety of the RISC-V semihosting spec already.  For
now, perhaps we should limit RISC-V semihosting support to devices
without paging support and await a more complete spec.

As you suggest, disallowing the sequence from crossing a page boundary
would be a simple fix, but that would require wording changes to the
spec.

=2D-=20
=2Dkeith

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEw4O3eCVWE9/bQJ2R2yIaaQAAABEFAl3Nl3QACgkQ2yIaaQAA
ABGlwg//TAcJHVRvndaaijM8BxzYLoJCyoqxt2t5GF9gDIoR2f7ZrPvCC8q6qjOJ
CvgRoR42vxGM3CwITyBh0Kh8F7F3fgUfnPYXGGJOBIMYk9wJ22Sgbc0bpEuNOis7
4q16j0atmJ86JauaqwNI5MpVvVHGJNzqJH1z52naRedRe0w+lbfaV3SGj3YPg4op
4D59vkhdedhBR6wCYdy9hk187HGYGo/bDEMLDIQmCPnbFd+Rpt1D3kkze81nnXY0
FV7pl+/99b3u8nRS9XqehrhuViysyzOTGpHc+6hUl2sNbIprAYEkwxHXw5ljNx2F
SqlxlA2+SCZhhBK1P6SGYaDZ9AdCEDdsU84sZEDojhqraI5eU1BxznSLRc92niJF
cDgDN4kkQXDVQ+KDSEssKtVjqtEXu1/4puEBDtL53MvEPMN6QxwrxUFi7U+YBSxz
dA8d76iGg6Eds5dNdPjGtvcZ+Tp5bhsogxFwwbrppZurrX97iqIwIR87n1wALfEJ
/HaYyT47Bklcyp97xM0ZCmql2cZixOxNpKG57F5jhMFMZjav2FN/9cepmI2h0ToZ
uQHncCh7ZfQUJAR4idCPj1b14JqFrRt0k1MKN4n4wkYf+Q15ETQzXeNXcDtUfdtY
vOCrrEm5MIuFwlD38pSugizZH+qWAxF00K2blWjexSHifFNADfY=
=Tq5S
-----END PGP SIGNATURE-----
--=-=-=--

