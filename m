Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DD38C35646
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 12:07:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27BA2207FD
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 12:07:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="hOcyIWkU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27BA2207FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56008 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j575g-0002lD-Cw
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 07:07:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44835)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1j5755-0002GA-F3
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 07:06:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1j5753-0006QG-Oh
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 07:06:55 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:46363 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1j5752-0006PM-Oo; Fri, 21 Feb 2020 07:06:53 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48P9DT21MHz9sRl; Fri, 21 Feb 2020 23:06:49 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1582286809;
 bh=7yiE9tM4tZSUoIHyLnqj8IMvNXIyLkJ0rmHI3PDnCbI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=hOcyIWkUO6P1JGuuiRgPQxoEKVXI/aPXtg9TtHNKHzCSFEiGpvgSAA1ykm6U2jRYD
 L6JfueGq6HOQabLaTFTWWbpI3ADiJymQ4t0mQM01mMZKBs76X0rwU4rHO6tPZgQjNb
 PoSEtdGZWfSxy36FfUQTu/QlcjVObW0x2jrV5So8=
Date: Fri, 21 Feb 2020 16:43:57 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PULL SUBSYSTEM qemu-pseries] pseries: Update SLOF firmware image
Message-ID: <20200221054357.GE2298@umbus.fritz.box>
References: <20200217021217.95766-1-aik@ozlabs.ru>
 <60c5712e-beb7-e536-1252-642dcf88beec@redhat.com>
 <0beab4e0-da3d-48fb-062a-de7a6c244c3f@redhat.com>
 <20200217224647.GA26464@umbus.fritz.box>
 <38cfa5c3-2563-7aaa-b1db-c7dd2f053d3c@redhat.com>
 <7f9d26fe-1ad0-9ccf-dd00-9aad7491d36d@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="AsxXAMtlQ5JHofzM"
Content-Disposition: inline
In-Reply-To: <7f9d26fe-1ad0-9ccf-dd00-9aad7491d36d@ozlabs.ru>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 203.11.71.1
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
Cc: qemu-ppc@nongnu.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--AsxXAMtlQ5JHofzM
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2020 at 03:09:46PM +1100, Alexey Kardashevskiy wrote:
>=20
>=20
> On 18/02/2020 16:48, Philippe Mathieu-Daud=E9 wrote:
> > On 2/17/20 11:46 PM, David Gibson wrote:
> >> On Mon, Feb 17, 2020 at 11:24:11AM +0100, Philippe Mathieu-Daud=E9 wro=
te:
> >>> On 2/17/20 10:26 AM, Philippe Mathieu-Daud=E9 wrote:
> >>>> Hi Alexey,
> >>>>
> >>>> On 2/17/20 3:12 AM, Alexey Kardashevskiy wrote:
> >>>>> The following changes since commit
> >>>>> 05943fb4ca41f626078014c0327781815c6584c5:
> >>>>>
> >>>>> =A0=A0=A0 ppc: free 'fdt' after reset the machine (2020-02-17 11:27=
:23
> >>>>> +1100)
> >>>>>
> >>>>> are available in the Git repository at:
> >>>>>
> >>>>> =A0=A0=A0 git@github.com:aik/qemu.git tags/qemu-slof-20200217
> >>>>>
> >>>>> for you to fetch changes up to
> >>>>> ea9a03e5aa023c5391bab5259898475d0298aac2:
> >>>>>
> >>>>> =A0=A0=A0 pseries: Update SLOF firmware image (2020-02-17 13:08:59 =
+1100)
> >>>>>
> >>>>> ----------------------------------------------------------------
> >>>>> Alexey Kardashevskiy (1):
> >>>>> =A0=A0=A0=A0=A0=A0=A0 pseries: Update SLOF firmware image
> >>>>>
> >>>>> =A0=A0 pc-bios/README=A0=A0 |=A0=A0 2 +-
> >>>>> =A0=A0 pc-bios/slof.bin | Bin 931032 -> 968560 bytes
> >>>>> =A0=A0 roms/SLOF=A0=A0=A0=A0=A0=A0=A0 |=A0=A0 2 +-
> >>>>> =A0=A0 3 files changed, 2 insertions(+), 2 deletions(-)
> >>>>
> >>>> I only received the cover, not the patch, have you posted it?
> >>>
> >>> OK I see the SLOF binary is almost 1MB. Maybe this got blocked by spam
> >>> filter. FYI you can use 'git-format-patch --no-binary' to emit the pa=
tch
> >>> with the commit description but without the content.
> >>
> >> Generally Alexey sends SLOF updates to me just as pull requests
> >> without patches in full, because a huge slab of base64 encoded
> >> firmware isn't particularly illuminating.
> >=20
> > I understand, this is why I later suggested Alexey to use
> > 'git-format-patch --no-binary', because Laszlo uses it for EDK2
> > submodule, this allow to quickly review the change on the list (without
> > posting the base64), see:
> >=20
> > https://www.mail-archive.com/qemu-devel@nongnu.org/msg624429.html
> > (pull-request cover)
> >=20
> > https://www.mail-archive.com/qemu-devel@nongnu.org/msg624432.html
> > "roms/edk2: update submodule"
> >=20
> > https://www.mail-archive.com/qemu-devel@nongnu.org/msg624435.html
> > "pc-bios: refresh edk2 build artifacts"
>=20
> I am not quite sure where to fit this "git-format-patch". I run now "git
> request-pull" and "git send-email" so am I expected to run format-patch
> and post it as a patchset but with the pull request mail as a cover
> letter? This does not seem very useful though. For today, I'll add the
> change log to the pull request mail. Thanks,

Most git format-patch options can also be passed to git send-email,
and it will pass them through.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--AsxXAMtlQ5JHofzM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl5PbhsACgkQbDjKyiDZ
s5LPSg//ZLjow2phXk1pj056eHAZUlboeQS5gD9/s5kZGplbgD5MDyLscNzZG2Jk
ckVPCPxkpfoQObuzpqo5aKiqP9MTAFl2f5CUBEZKbKEAYJSNb3JjlqHm2Kgk8WHS
MKAMLH5Fo3MMqWAdWLoY0hrag3AIgC5ziinfb+XWtkQVKeGfyhyQytnduXm/sUPm
PWRPXMxJ2v1s5K4DgT8w1DoIWvljNc3I6jiIb6IQLcLF7TnJL4hu0XSKtnfKSAcA
t0uDJ+7pLFezuRJHt+VYR3BNGM1VILbTsUS18wGQO/yVTMG17vqJR0gfxTEXZq8+
eqXK9a8NT6fNw60t8omhv/dFAOwe1gGJ7Ioo+gFxCvrTbTcHQu50VjLyK+c6P0iY
SlRqz7QkhnO5/1JuwebQipKYKDQwijRDJapiNH5fn/TOJTjAeuYJ2tW0BwwEPqVe
zUeJPwXm94JNQtNQOq1B8FNyIrNVWbP5mpDVz23wmjBlloLwLn8smnqM6uRq5KSW
mfNDTlJ7CWblip9TpF7GkQf8REumhymYUdfSWK0YZGbmMd+vu7YiR1KHtXni3zTX
p/l1KcG5EnJhkLMr/s+ZBglKLXXIOGwmxKIRZ2C7VHAB1HhjGzdKoC8qFWmb9AnJ
xVCOxW5jlfaMVDXr1E+alqs/RdKjjSdoONkhiNwdW3o8BcFW3RA=
=wTsQ
-----END PGP SIGNATURE-----

--AsxXAMtlQ5JHofzM--

