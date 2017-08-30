Received: from eggs.gnu.org ([2001:4830:134:3::10]:40449)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dn6nO-0000n6-Hf
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 13:28:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dn6nJ-0001XC-Jx
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 13:28:54 -0400
Received: from 16.mo6.mail-out.ovh.net ([87.98.139.208]:52133)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dn6nJ-0001WC-DV
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 13:28:49 -0400
Received: from player735.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id C8BE9108051
	for <qemu-devel@nongnu.org>; Wed, 30 Aug 2017 19:28:45 +0200 (CEST)
Date: Wed, 30 Aug 2017 19:28:38 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170830192838.5bb5a45c@bahia>
In-Reply-To: <47171733.403781.1504103700042@mail.yahoo.com>
References: <1915302638.2814146.1504030043465.ref@mail.yahoo.com>
	<1915302638.2814146.1504030043465@mail.yahoo.com>
	<14033890-2a35-666c-2fa7-5a8727090801@tuxfamily.org>
	<1075529669.195794.1504079702032@mail.yahoo.com>
	<bc7bacd9-fec7-c193-6de0-99d1f7fd0f6f@tuxfamily.org>
	<2061420835.208824.1504085337258@mail.yahoo.com>
	<20170830121109.7fab5559@bahia>
	<61cd0715-27e4-7e50-1e85-9da3b4a48bb1@posteo.de>
	<47171733.403781.1504103700042@mail.yahoo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/FT4_bUoxHO6wMMpa0+BDj8K";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [Qemu-discuss] Accessing a shared folder
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mahmood <nt_mahmood@yahoo.com>
Cc: Thomas Huth <th.huth@posteo.de>, Thomas Huth <huth@tuxfamily.org>, QEMU Developers <qemu-devel@nongnu.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, "qemu-discuss@nongnu.org" <qemu-discuss@nongnu.org>

--Sig_/FT4_bUoxHO6wMMpa0+BDj8K
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 30 Aug 2017 14:35:00 +0000 (UTC)
Mahmood <nt_mahmood@yahoo.com> wrote:

> OK. I reconfigured 2.9.0 with --enable-virtfs. Please note:
> 1- If I use -virtfs option, I get=20
> =C2=A0=C2=A0=C2=A0=C2=A0 qemu-option.c:547: opt_set: Assertion `opt->str'=
 failed
>=20

If you use the local fsdriver, security_model is mandatory with -virtfs just
like it is with -fsdev.

> 2- If I use -fsdev and -device, then I *must* use security_model
>=20

True, as indicated in the QEMU manpage:

"Security model is mandatory only for local fsdriver.
 Other fsdrivers (like handle, proxy) don't take security model
 as a parameter."

> 3- If I use -fsdev and -device and security_model, then the guest boots n=
ormally.
>=20
> I haven't tried to see if I am able to access the shared folder nor not. =
Do you have any note on the above items?
>=20
>=20
> Regards,
> Mahmood
>=20

Cheers,

--
Greg

--Sig_/FT4_bUoxHO6wMMpa0+BDj8K
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQQr1DtEU17Ap5iU26IC/DrrAQHbwgUCWab1xgAKCRAC/DrrAQHb
wl7UAJ4k/Vo1bM1aOqFWf6hYO0p0EAc0BACffrDC+4JIB/9yh3TFkMRCUw1aWDo=
=ZsEP
-----END PGP SIGNATURE-----

--Sig_/FT4_bUoxHO6wMMpa0+BDj8K--
