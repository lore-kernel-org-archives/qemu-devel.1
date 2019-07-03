Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E049DC5B578
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 06:19:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BBB321880
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 06:19:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="NO9FyLKZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BBB321880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiYc3-0008LM-MW
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 02:19:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46425)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hiYVz-0003YE-N7
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 02:13:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hiYVy-0006Ad-GX
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 02:13:11 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:52229 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hiYVu-0005yE-Ml; Wed, 03 Jul 2019 02:13:08 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45drPZ6Mrlz9sBp; Wed,  3 Jul 2019 16:12:50 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1562134370;
 bh=6ZeVFtJXdKv+qhxGyrt4C4iCBoFsd1gvXMOOjiH5Yvs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=NO9FyLKZEEaCPHueubn2zF3+//O7iL/FQ3o8Jivf1HW9+lGfXwIUh6ufYjbISJPYP
 qIM3bimxljyc1YdksILqcYrxwyIOU5fmVaHhHS5kWyuIjjwlJeA+aOU0K6ZhBKO2XH
 s7etIotmPuSMpTvq8YX5n9wyFy0DnMReQTluTn2Q=
Date: Wed, 3 Jul 2019 13:05:29 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <20190703030529.GG9442@umbus.fritz.box>
References: <20190703023950.123474-1-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="WkfBGePaEyrk4zXB"
Content-Disposition: inline
In-Reply-To: <20190703023950.123474-1-aik@ozlabs.ru>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [GIT PULL for qemu-pseries] pseries: Update SLOF
 firmware image
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--WkfBGePaEyrk4zXB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 03, 2019 at 12:39:50PM +1000, Alexey Kardashevskiy wrote:
> The following changes since commit 506179e42112be77bfd071f050b15762d3b2cd=
43:
>=20
>   Merge remote-tracking branch 'remotes/dgibson/tags/ppc-for-4.1-20190702=
' into staging (2019-07-02 18:56:44 +0100)
>=20
> are available in the Git repository at:
>=20
>   git@github.com:aik/qemu.git tags/qemu-slof-20190703
>=20
> for you to fetch changes up to cb20f6ca4faf79895ebbe279d1176344e0638b37:
>=20
>   pseries: Update SLOF firmware image (2019-07-03 12:32:19 +1000)

Merged, thanks.

>=20
> ----------------------------------------------------------------
> Alexey Kardashevskiy (1):
>       pseries: Update SLOF firmware image
>=20
>  pc-bios/README   |   2 +-
>  pc-bios/slof.bin | Bin 926392 -> 926432 bytes
>  roms/SLOF        |   2 +-
>  3 files changed, 2 insertions(+), 2 deletions(-)
>=20
>=20
> *** Note: this is not for master, this is for pseries
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--WkfBGePaEyrk4zXB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl0cG3kACgkQbDjKyiDZ
s5JpKRAAwkgzHc/AqMo7i6mYYL75i1ICHob5jciOYuj6L3QWadZztrWKHbc3wwH8
NEIKiVnktG2xFN7B1Nd8tHdkYY+64uM9D6eRe8yKUVmhKIV+uT26XxyTvqL5Jb5f
SqrATVesim+O26C1YLHxbAK9u3B9faO42bZ2oAwFwaJR1rRnzNRe9QOgP/jrliKp
PFZTy2Lo//qiIwo6nw8+aSMQU1kaj69yXxsim7PJhdYgPbWOG5O6lUMFi+hdV9sM
FVWioP/QBE7/wE6++HAUX13pxMA+wc98hJuYz0zsXQ+vfus7OunqSjq1596YF2TW
Tpe08CQ4vqXapIXLNHV7CLS+VY0ZcOTVCE7cj/mMb71oi9i+MFDiWjooy/H7Mkvn
jNwAIgSp+hNntnnN7oCtQtYEkOveai5L1DbC7djIBqfn2S1NNS1vcPVKEZ8XX9nB
YSUXS0lSPIzt0nHLjogCkD9mtFZ8NTwhQBOb6liXH7s1TtiAPuzx0shS1GuM/cNU
QW8teyZabCM+fNiIFP0bRptEJQirxr+jM3815cFZH3QMf5SoI6sJoGazDPJQrLrp
27imsRy6+wNYmRkmS75Kj/0dwpHWJy2we6ufxnevqZ7g4RVfnSgaoF0baPoyMFD0
WHwDqSAG70x4zf0PGLgvdP+EwxLCjQWwWg5c8nqSRK02+S9JXJk=
=bcGP
-----END PGP SIGNATURE-----

--WkfBGePaEyrk4zXB--

