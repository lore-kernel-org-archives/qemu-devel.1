Received: from eggs.gnu.org ([2001:4830:134:3::10]:60955)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dosUa-000583-J9
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 10:36:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dosUV-0002ld-Sx
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 10:36:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35432)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dosUV-0002jX-J0
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 10:36:43 -0400
References: <20170904142608.4897-1-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7c228b52-f5bf-929b-9acf-07e705ec0198@redhat.com>
Date: Mon, 4 Sep 2017 09:36:39 -0500
MIME-Version: 1.0
In-Reply-To: <20170904142608.4897-1-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ii1WxNP7GOrRQbQ1L3C5NELWiCPi9agMI"
Subject: Re: [Qemu-devel] [PATCH web 0/2] Secure the download links and more
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ii1WxNP7GOrRQbQ1L3C5NELWiCPi9agMI
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7c228b52-f5bf-929b-9acf-07e705ec0198@redhat.com>
Subject: Re: [Qemu-devel] [PATCH web 0/2] Secure the download links and more
References: <20170904142608.4897-1-berrange@redhat.com>
In-Reply-To: <20170904142608.4897-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/04/2017 09:26 AM, Daniel P. Berrange wrote:
> which gives the $BAD guys plenty chance to compromise your
> download. Fix this to link to https:// sites exclusively
> and use the preferred qemu.org domani too. All links are
> fixed to use https, not merely download site links.

We should also patch include/qemu-common.h, which lists http:// rather
than https:// for the --help output (because at the time the patch was
first written, we did not have https:// fully working yet)

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--ii1WxNP7GOrRQbQ1L3C5NELWiCPi9agMI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmtZPcACgkQp6FrSiUn
Q2rpugf9F/1K476RwbEQyW/wqnq/s22+T4hO5aVJKn2/Jt0h7IEEXgf9KtTkyzDo
sF1SVA964EmM0HvCAa1BqwSHPX5DKWdlOeKIg/iXqEOzLaOj1mQCPeAGRCRP74R9
H3M8eEUEziM4W8gz5klGnY7mhyv+OxgK19hq1YNExXxDcRofrRA97pzqfj0zaydN
fqBHUnsEB7Rbt1Hz4KQLQ2AZuW+JepasSf//WMMamT6WbB+YxJplCy9BbPVYHyBE
I1LRdoBoKXh8Xhjmn/ElfZrj4IKyJZ8Xqsg04qp73zqkEYh377nSMUScwmVQkD3Z
ibxWrr5SKOrwpCePh5/XYeTUw/ncyA==
=tl15
-----END PGP SIGNATURE-----

--ii1WxNP7GOrRQbQ1L3C5NELWiCPi9agMI--
