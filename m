Received: from eggs.gnu.org ([2001:4830:134:3::10]:37849)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dcevv-0005Di-AT
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 17:42:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dcevu-0008Ku-Eh
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 17:42:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47500)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dcevu-0008KW-5Q
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 17:42:30 -0400
References: <1501623438-31419-1-git-send-email-mst@redhat.com>
	<1501623438-31419-7-git-send-email-mst@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <05e5690f-de93-109b-6c16-47f28ab0a320@redhat.com>
Date: Tue, 1 Aug 2017 16:42:23 -0500
MIME-Version: 1.0
In-Reply-To: <1501623438-31419-7-git-send-email-mst@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="lT1Mj9b2CMO4Tlwgd3B1ffOiEdMbFFVdn"
Subject: Re: [Qemu-devel] [PULL 06/10] accel: cleanup error output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Laurent Vivier <lvivier@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, Peter Xu <peterx@redhat.com>, Yang Zhong <yang.zhong@intel.com>, Anand J <anand.indukala@gmail.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lT1Mj9b2CMO4Tlwgd3B1ffOiEdMbFFVdn
From: Eric Blake <eblake@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Peter Xu <peterx@redhat.com>, Yang Zhong <yang.zhong@intel.com>,
 Anand J <anand.indukala@gmail.com>
Message-ID: <05e5690f-de93-109b-6c16-47f28ab0a320@redhat.com>
Subject: Re: [PULL 06/10] accel: cleanup error output
References: <1501623438-31419-1-git-send-email-mst@redhat.com>
 <1501623438-31419-7-git-send-email-mst@redhat.com>
In-Reply-To: <1501623438-31419-7-git-send-email-mst@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/01/2017 04:37 PM, Michael S. Tsirkin wrote:
> From: Laurent Vivier <lvivier@redhat.com>
>=20
> Only emit "XXX accelerator not found", if there are not
> further accelerators listed. eg
>=20
>    accel=3Dkvm:tcg
>=20
> doesn't print a "KVM accelerator not found" warning
> when it falls back to tcg, but a
>=20
>    accel=3Dkvm
>=20
> prints a warning, since no fallback is given.

Already merged as d73f0247; but git should do the right thing as long as
your two pull requests don't introduce any conflicts.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--lT1Mj9b2CMO4Tlwgd3B1ffOiEdMbFFVdn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmA9b8ACgkQp6FrSiUn
Q2qy3wf+IGuC3WcY1ErURsCilbsXC4rfEazKdLXhhVVhqMdd2u5h6YXDCuZbBbAz
QRhQ9hQ0ADV+1gR0NP/DvKM8nRYA3KRO0iBTJYvi0nVbRAyuUjOFGc/gBj2YMtfD
CHWZN0dQVU1r+Ck553hRhMg31JSFQ77fJ8JFsmQbYhcY9vsR5VIAhBHs0NlYkweK
g1f2fQf4U/3UND51UZ/F015OoLDWdEXGRYykdEw3unbv1GvK5RDnnv73RRE5jo67
N1lWJZrnnyy0Gkf8vc6aDIGHbosthrEv3PizR9yRCq1tinwC+hw0SRhHraH5XPkU
OaaBDhdCUr5mYRrzR8qC8d6Jgs23CQ==
=3jxf
-----END PGP SIGNATURE-----

--lT1Mj9b2CMO4Tlwgd3B1ffOiEdMbFFVdn--
