Received: from eggs.gnu.org ([2001:4830:134:3::10]:42805)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1db9is-0005p6-Py
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 14:10:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1db9io-0000mZ-76
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 14:10:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45712)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1db9in-0000m6-Op
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 14:10:46 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B9C66C05159C
	for <qemu-devel@nongnu.org>; Fri, 28 Jul 2017 18:10:44 +0000 (UTC)
References: <1501249552-788-1-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <11d19144-9406-cb9a-d716-2ca60d93a17a@redhat.com>
Date: Fri, 28 Jul 2017 13:10:43 -0500
MIME-Version: 1.0
In-Reply-To: <1501249552-788-1-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="wowUww1FpguXAT5sPpLo4tlSsh9A0X6kt"
Subject: Re: [Qemu-devel] [PATCH 0/3] Don't QAPI without need
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wowUww1FpguXAT5sPpLo4tlSsh9A0X6kt
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Message-ID: <11d19144-9406-cb9a-d716-2ca60d93a17a@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/3] Don't QAPI without need
References: <1501249552-788-1-git-send-email-armbru@redhat.com>
In-Reply-To: <1501249552-788-1-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/28/2017 08:45 AM, Markus Armbruster wrote:
> These are pretty trivial, probably simplest if I take them through my
> tree.
>=20
> Markus Armbruster (3):
>   replay: Define ReplayMode without QAPI
>   COLO: Define COLOMode without QAPI
>   block: Remove unused BlockDeviceMapEntry
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

>  include/migration/colo.h |  6 ++++++
>  include/sysemu/replay.h  |  6 ++++++
>  qapi-schema.json         | 34 ----------------------------------
>  qapi/block-core.json     | 29 -----------------------------
>  4 files changed, 12 insertions(+), 63 deletions(-)
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--wowUww1FpguXAT5sPpLo4tlSsh9A0X6kt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAll7fiMACgkQp6FrSiUn
Q2pKHgf/SRiLo1TfMFmizhOarJoTApaXZ0xoEOY630NhwKMTxPGPNsUKyCCmG+qY
fo8IFBBX+i870jCf8xU2yVCAHJ7qqgTprpOGrdEETKg+O1bXoiMJfR3lKoRssc/M
qYKg+IRkOxO9e0X6+xKZ/n9TNVoBKem6WEOJNV79Jpz7WyRCrk6cIbNGlLVzCZTt
OIM0uImweh/XLvB8GtHZQ4EDyINOHZyV0QmxALm38Jd5wQtUUn65/IWRy3dcZbJC
36GsJlhMToxMkl3y2kSCUj+MxWpYRH0Vo66MmzndX60XdtKU5ldCsz8if8mjmmbj
2vREJ+xH/t0z9dmD36XBVvm5w/vfoQ==
=zOal
-----END PGP SIGNATURE-----

--wowUww1FpguXAT5sPpLo4tlSsh9A0X6kt--
