Received: from eggs.gnu.org ([2001:4830:134:3::10]:42648)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cgFxa-0006ht-JL
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 14:18:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cgFxW-0004LD-Jm
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 14:18:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42056)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cgFxW-0004Kn-Dz
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 14:18:46 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 653E44E02A
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 19:18:46 +0000 (UTC)
References: <1487363905-9480-1-git-send-email-armbru@redhat.com>
	<1487363905-9480-11-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2781456e-f33d-15db-cebf-f5bbad496425@redhat.com>
Date: Tue, 21 Feb 2017 13:18:43 -0600
MIME-Version: 1.0
In-Reply-To: <1487363905-9480-11-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="8HEcuKDUGvb8t0DbQn1LoRSMgqNbrrNeu"
Subject: Re: [Qemu-devel] [PATCH 10/14] tests: Don't check qobject_type()
 before qobject_to_qint()
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
--8HEcuKDUGvb8t0DbQn1LoRSMgqNbrrNeu
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Message-ID: <2781456e-f33d-15db-cebf-f5bbad496425@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 10/14] tests: Don't check qobject_type()
 before qobject_to_qint()
References: <1487363905-9480-1-git-send-email-armbru@redhat.com>
 <1487363905-9480-11-git-send-email-armbru@redhat.com>
In-Reply-To: <1487363905-9480-11-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/17/2017 02:38 PM, Markus Armbruster wrote:
> qobject_to_qint(obj) returns NULL when obj isn't a QInt.  Check
> that instead of qobject_type(obj) =3D=3D QTYPE_QINT.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  tests/check-qjson.c                 | 24 +++++-------------------
>  tests/test-qobject-output-visitor.c | 28 ++++++++++++----------------
>  2 files changed, 17 insertions(+), 35 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--8HEcuKDUGvb8t0DbQn1LoRSMgqNbrrNeu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYrJKTAAoJEKeha0olJ0NqlfsIAIAqRQcfo9gvbJ2mz/2LmIKD
6ZbovKdmgfLOBDTbC3+t7zUNoX6/71MxvVoME40W/ibluOy1/uH5ioAS+xlWNa+J
1iY5tu3wUipQXDZpraGAvhPqdDWwKeb2zCnh2w9YrKXz91vCCrK0OgfqQBWHyH80
BCswBbzKs0LCN322FTYHHAOLozj7MMNOTcacE/AvgXlda9RZirgQklHrELdgw7ut
4gK6Sklg2FIZmGgDIALS616qtD0aS+izp0UZuXi3fLJswCAlaHRN7k7adDHx6meC
YFoQccFaqi9UATHAs/UUBxF+iL2TAYoorgEk8b7GkzWGXhGK8VzhxVMu9Ohb6NA=
=o09K
-----END PGP SIGNATURE-----

--8HEcuKDUGvb8t0DbQn1LoRSMgqNbrrNeu--
