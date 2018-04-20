Received: from eggs.gnu.org ([2001:4830:134:3::10]:58482)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@redhat.com>) id 1f9KSW-0004gb-5h
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 21:03:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@redhat.com>) id 1f9KSS-0002LV-8p
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 21:03:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47570 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@redhat.com>) id 1f9KSS-0002Ju-34
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 21:03:24 -0400
Date: Fri, 20 Apr 2018 11:03:01 +1000
From: David Gibson <dgibson@redhat.com>
Message-ID: <20180420110301.1734899d@umbus.fritz.box>
In-Reply-To: <d032dfe2-bfab-5a12-c867-a5229f303f5f@redhat.com>
References: <20180417224054.26363-1-lersek@redhat.com>
	<20180418060243.iafg4wj5gwsruop5@sirius.home.kraxel.org>
	<b9c7d767-39c4-065f-f487-34c0c682bd85@redhat.com>
	<20180419100900.7b66fde0@umbus.fritz.box>
	<d032dfe2-bfab-5a12-c867-a5229f303f5f@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	boundary="Sig_/OcicRh1/0_jXM_u.vM/a/MM";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [qemu RFC v2] qapi: add "firmware.json"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org, libvir-list@redhat.com, "Daniel P. Berrange" <berrange@redhat.com>, Alexander Graf <agraf@suse.de>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Eric Blake <eblake@redhat.com>, Gary Ching-Pang Lin <glin@suse.com>, Kashyap Chamarthy <kchamart@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Michal Privoznik <mprivozn@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Krempa <pkrempa@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>

--Sig_/OcicRh1/0_jXM_u.vM/a/MM
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 19 Apr 2018 10:09:30 +0200
Laszlo Ersek <lersek@redhat.com> wrote:

> On 04/19/18 02:09, David Gibson wrote:
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
>=20
> Thank you -- I will replace SLOF with "openfirmware".
>=20
> This also implies I shouldn't add "openbios" separately, which was
> suggested earlier by Gerd -- according to
> <https://en.wikipedia.org/wiki/OpenBIOS>, OpenBIOS is another
> implementation of OFW.

Right.  Although I think OpenBIOS and SLOF support a disjoint set of
machines.  Openhackware which is (was?) used on some machines is yet
another (very partial) openfirmware implementation.

>=20
>  [...] =20
>=20
> Right, this is about interfaces, so I'll keep "uboot".

Ok.  More specifically I guess this is about firmware <-> guest OS, and
firmware <-> interactive user interfaces.  Firmware <-> qemu interfaces
(fw_cfg, device tree) are a different question.

--=20
David Gibson <dgibson@redhat.com>
Principal Software Engineer, Virtualization, Red Hat

--Sig_/OcicRh1/0_jXM_u.vM/a/MM
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlrZPEUACgkQbDjKyiDZ
s5LRxhAAp3eI2K1/JcwjNxwmQ+aMMBL/sKbOrBs/OQzrRVAhmx76vEeuw7G8fwPM
Rt4bL9o1ahNaP8cH1ijVBM6C4vdBtGdGiYLk2sQxUTIDNjeEAgjmUeMLW5+gZHWf
h+1eFaoAWwXv1NzJgY51l0wkk175Ib4B5RBX1tZnIQY4qHp4FDgxbC5E5MyP/RU7
iBxT6VH4f1vpgxx089uYFqFhAZttG3QffDvvbSvU4RungUGowmU2ymRjfIRE500u
5ydT9Z/kH34K37/1liFdsLritcgFQAu65Wagx0Q2mkA8r41Qq25pbcW77OXvgsaB
eEbiUHyZ79XdepkMOewBCKWTZy+UvUVTyfifYV3v4ZvYPE8z3pyLqB+uRgP00g2A
fjsgscg9ljexlJulMLgjIBPYMP4ekWsKng6b9BD0A9MlPN0IRucvYzdC9wwxp2dt
xa8Utd8sayAB/hlM4FHof/RuL/oJPii4xN1A34KypFvxBtMCDY7CjRXjI92iAQAz
N2KuZcTW/Hs2plGc4swoQORCSZEikrmx6L3jSxqEz6JYdhVFGdOcyWWco/UcgAYB
gDonHcv1XqP9L6L/96mwjHrA7/hch41zic5WtVoOtWZG4TZcKxrcWWZaBSCSAEN0
9n3Gzmv5Sqewy6lST0aHqRSG/H7cJvoL84WcKfnfEqNSZgpEmFk=
=T9t6
-----END PGP SIGNATURE-----

--Sig_/OcicRh1/0_jXM_u.vM/a/MM--
