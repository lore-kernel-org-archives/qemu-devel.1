Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 148B4C55189
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 08:01:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D22F5206E9
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 08:01:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="WEO9K45l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D22F5206E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRAJh-0007nM-VR
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 04:01:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42916)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jRAIW-0007II-0w
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 03:59:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jRAIV-0006eu-1U
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 03:59:55 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:44947 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jRAIT-0005uu-0H
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 03:59:54 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 496Xs92zvmz9sSK; Wed, 22 Apr 2020 17:59:41 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1587542381;
 bh=w+yyx2tNGPrRwrE1II/l2hGYcVa2MPw8V525sIEKfsY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=WEO9K45lcWHFnZGDcG5LZYqS1ryNc+NDiv+5vi2xiURlbEi/w+oElbxwJWRNJKv2l
 XuOtyfUngmYxrLlDgfsCcfEKEvNqA6xrbIjCjByZNaWH23rRW5MR+IotS6Pz4ZxIHJ
 BCUSKx9dnotcv/Lk/IFkoYpy1VGvcY1532/b9KUo=
Date: Wed, 22 Apr 2020 17:58:42 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 3/7] target/ppc: Use tcg_gen_gvec_dup_imm
Message-ID: <20200422075842.GA92618@umbus.fritz.box>
References: <20200418150411.1831-1-richard.henderson@linaro.org>
 <20200418150411.1831-4-richard.henderson@linaro.org>
 <87368yfntf.fsf@linaro.org>
 <81b5dff6-b7f3-a536-87a0-778ec26d20cb@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="jI8keyz6grp/JLjh"
Content-Disposition: inline
In-Reply-To: <81b5dff6-b7f3-a536-87a0-778ec26d20cb@linaro.org>
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2401:3900:2:1::2
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
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, zhiwei_liu@c-sky.com,
 david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 21, 2020 at 10:50:25AM -0700, Richard Henderson wrote:
> On 4/20/20 3:34 AM, Alex Benn=E9e wrote:
> >> +GEN_VXFORM_VSPLTI(vspltisb, MO_8, 6, 12);
> >> +GEN_VXFORM_VSPLTI(vspltish, MO_16, 6, 13);
> >> +GEN_VXFORM_VSPLTI(vspltisw, MO_32, 6, 14);
> >=20
> > There are unused parameters opc2/opc3 parameters here.
>=20
> Yes, but all of the other GEN_* macros retain them as well.
> Without looking at the actual history, I'd say once upon a time they were
> actually used, but we've now split opcode from implementation.
>=20
> > With the removed extra unused macro params:
> >=20
> > Reviewed-by: Alex Benn=E9e <alex.bennee@linaro.org>
>=20
> I wouldn't do that without David's approval.  And possibly stripping out =
the
> opcodes everywhere else.

Yeah.  Sounds like one of a nearly infinite number of global cleanups
that the target-ppc tcg code could do with.  Patches welcome.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--jI8keyz6grp/JLjh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl6f+TAACgkQbDjKyiDZ
s5KvexAAxo5vXLUDdy/7pQQ8/RsFWwx/QoU4Eu/CJsPZ90DEpBkbxmza5M8IQMwg
XdRJkcY0v8ez/MVFbXHFZ1HY0nIAruNQgulxQGfE6fD4wMloaaE6D1Ip0PefV/16
Y0rquHiuw2vujyVXP8JXLB2rUReKy7xsP82UZ7Awqf8YXGqHZ3r31aZninU99PCs
zfJFJQ4ERIRufzkQ0RtftkJnO80ltI8jxQMSaVluUis81BafhCrIcvBvtCukQYnt
GZFEuh8sxZ8vPQfAAdaHmCGpkcD6j6UuSRvthtGPYAFFtZF1SIY+z3mTiZfn0QtF
4VqG6kBZZ/PWAENe628r5xYTH66WPKDoumrqdOu7zYD1wDFmz4S+e336kfI27q/l
9KrvZvzgjLxLl+xugMXQCxn+FU06udh+cQjhJqHKxd3/ceexyqFgPpQj0wVtKCt2
V+EaQocMhJlrh3OVbe3C9xVbwm5h0aDAZSyXtVfuspAYeWZzSY7lMAu34OrTCADS
PmDQbox6OLLnvVNlmUPv429YbM+RAeSUyT1FikOx8bMuOeMomT06qjt+3bW8rUw4
l7hjmV5hVkfFe1awozIsz7WM3xiAM0CahfrLHrvJJmmahtvJdArU6/LenQWb+wFl
vJV6b7H0G+mu4d4Awjc54KAKLl1lOHPvzZ3dAy7LqTLxmRW+SjY=
=8NIZ
-----END PGP SIGNATURE-----

--jI8keyz6grp/JLjh--

