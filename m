Received: from eggs.gnu.org ([2001:4830:134:3::10]:41267)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dn8VF-0001XX-DU
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 15:18:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dn8VE-0000IN-Dz
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 15:18:17 -0400
References: <cover.1504112256.git.jcody@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c533f65d-4550-b083-2072-2af4a409a1fb@redhat.com>
Date: Wed, 30 Aug 2017 14:17:57 -0500
MIME-Version: 1.0
In-Reply-To: <cover.1504112256.git.jcody@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="8OVgkQgPSeMrLLGcT9qm97skMVwgT4d1j"
Subject: Re: [Qemu-devel] [PATCH v2 0/3] Live block optional disable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org
Cc: ehabkost@redhat.com, qemu-block@nongnu.org, dgilbert@redhat.com, peterx@redhat.com, mrezanin@redhat.com, jsnow@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8OVgkQgPSeMrLLGcT9qm97skMVwgT4d1j
From: Eric Blake <eblake@redhat.com>
To: Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org
Cc: ehabkost@redhat.com, qemu-block@nongnu.org, dgilbert@redhat.com,
 peterx@redhat.com, mrezanin@redhat.com, jsnow@redhat.com
Message-ID: <c533f65d-4550-b083-2072-2af4a409a1fb@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/3] Live block optional disable
References: <cover.1504112256.git.jcody@redhat.com>
In-Reply-To: <cover.1504112256.git.jcody@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/30/2017 12:01 PM, Jeff Cody wrote:
> This series adds a configurable option to disable live block operations=
=2E
>=20
> The default is that live block operations are 'enabled'.
>=20
> Jeffrey Cody (3):
>   configure: Add option in configure to disable live block ops
>   block-jobs: Optionally unregister live block operations
>   hmp: Optionally disable live block operations in HMP monitor

That doesn't match the spelling you've used on other contributions (see:
 git shortlog --author=3DCody | grep -v "^ "
for a demonstration); is it intentional, and do you want a .mailmap
entry to merge your contributions under a preferred name?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--8OVgkQgPSeMrLLGcT9qm97skMVwgT4d1j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmnD2UACgkQp6FrSiUn
Q2oDiwgAnywotKm4Z5J+MDlkknFjsld5HxhWArxuL97ntCv9hAnf9T/NoHEEX3Y/
GqCbo8ybEbyi5kn8Zc6I2N1CtNVVsTKSsINe8IZHP+5NiCVrN27Q87F81VI06oJq
5RQjeKITiQtwBp4xVJrR0wuICNPfOydlqImkkWCP/bVNfCOYOFumBr0MXt4evqXT
sjUqgXnV+PL91sjfznd0Bte5e++lLgSycfvKqcx07oVhzILIJjr0VpLaNaNE/e/O
clevGeBTyv6XAb4z4IkMCMOr/QGUeLQG6b4ZUMqSwBBt4YBjQnCUuSCT0EVw/B3A
ohCRBTcQb9Fl+GxbCHeDA5I4EG3EWA==
=mKes
-----END PGP SIGNATURE-----

--8OVgkQgPSeMrLLGcT9qm97skMVwgT4d1j--
