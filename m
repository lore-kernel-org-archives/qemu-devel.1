Return-Path: <SRS0=OEAU=5Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56B99C2BB54
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 02:37:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23AFF20730
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 02:37:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="BtNyw5SV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23AFF20730
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jM0aV-0001RH-3a
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 22:37:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50567)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jM0Za-0000Fs-1t
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 22:36:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jM0ZY-0003wp-HO
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 22:36:13 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:55353 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1jM0ZW-0003mr-3z; Tue, 07 Apr 2020 22:36:12 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48xpLD1B1qz9sSr; Wed,  8 Apr 2020 12:36:04 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1586313364;
 bh=Cc9g3ZmOCGoeB+xR43eqST2kwnQ9z6FBWqPy0eWgQcM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=BtNyw5SVYMnQKQbx2mgLQuFFctsGdzMNziWqr87NDUDE3Wn1wuylNc2awbaS7ifOf
 /nVm9sPyDBAhQqOCpPqIlh57ClX61gGgbzo9WHkThfCRgcy1UFm3jEesVy0P+8voek
 +qBd5/0iAYSNDk7I0s8Mj1xgNW0HVIGnMZYq2tMg=
Date: Wed, 8 Apr 2020 12:10:06 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH for-5.0?] linux-user/ppc: Fix padding in mcontext_t for
 ppc64
Message-ID: <20200408021006.GB44664@umbus.fritz.box>
References: <20200407032105.26711-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="H1spWtNR+x+ondvy"
Content-Disposition: inline
In-Reply-To: <20200407032105.26711-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
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
Cc: alex.bennee@linaro.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--H1spWtNR+x+ondvy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 06, 2020 at 08:21:05PM -0700, Richard Henderson wrote:
> The padding that was added in 95cda4c44ee was added to a union,
> and so it had no effect.  This fixes misalignment errors detected
> by clang sanitizers for ppc64 and ppc64le.
>=20
> In addition, only ppc64 allocates space for VSX registers, so do
> not save them for ppc32.  The kernel only has references to
> CONFIG_SPE in signal_32.c, so do not attempt to save them for ppc64.
>=20
> Fixes: 95cda4c44ee
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Applied to ppc-for-5.0, thanks.

> ---
>=20
> Note that ppc64abi32 is *not* fixed by this patch.  It looks to
> me that all of the defined(TARGET_PPC64) tests in this file are
> incorrect, and that we should instead be testing TARGET_ABI_BITS
> vs 32/64.  In addition, virtually all of the target_ulong structure
> members would need to be abi_ulong.
>=20
> Should we in fact disable ppc64abi32?
> I can't see how it could work enough to be useful as-is.

Yeah, I think so.  Last time we had a problem in this area, I couldn't
even figure out what ppc64abi32 was supposed to *be*, let alone what
the use case for it is.  Given that, it's hard to imagine it's been
working (whatever that means) any time recently.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--H1spWtNR+x+ondvy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl6NMnsACgkQbDjKyiDZ
s5IoZA/7BGtlfpWcQIXwbVNRaEDkxCDB1NXTzZwx7A1W75t9sMSzf7f/w+QnjRio
u/6vQXXammauT5mMjQ3m5wiBNKQtsOKYG4A/aUJ0bFpLCAH/f3Mk01zC7cyEMY0b
elbGOqzhrVS6LHV8ucOkmqbg2M8PXD0UqZIFoKTKxLXr79O9jazl5pLD/eLWPOM/
ZzeVEo5tnV+DbnqqPFWNX/saB4/+AAviLflhhi91mpp6PFunVxmmMsqouJelPSeV
USj2MTgwqS95ND/i4WdmvboZaz+gHYtUmhw9A4hq4sEROJMr2lISX0AMjyURGyeS
8Q5LphcJAhcmUridMfRVITbk3sqYSvRXQ3SfmAr9hqSEXJpz1xLUqsmHXXRr1jUW
qZQe0kHXYTJQ+JXW9eSqa2A8PwD8Vooo7FyelW059/U/kd61wqNXnN/vu+Ciq9Bz
/NCQ6qefs/hi0oajOv3evO5crkQXLy1/zdVkXKCFYpoDGQyhmu2fZuWY/VJINWyu
bRNzuCB99QZlYaOMZxjfFBDA7x5Y0rMy/oGAGuzxt85K34w8G/rnnmEDhgz0CY6S
m+PeRLMxyADFRix3zFayPPDnfgj8Nl5Y1sVeFYmAO17aA5er3BQS3NsEX8XwoW9f
d/cpuGuh5SA/8UZGSpLu98OXj02maU1OOWub1UdBbq3yzKYwyTo=
=ncLW
-----END PGP SIGNATURE-----

--H1spWtNR+x+ondvy--

