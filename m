Received: from eggs.gnu.org ([2001:4830:134:3::10]:51542)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eCpA8-00074y-S1
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 10:54:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eCpA4-0006Hv-UT
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 10:54:40 -0500
References: <20171109154049.42386-1-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a84d3d68-6823-d504-f4cb-5d52be9563c0@redhat.com>
Date: Thu, 9 Nov 2017 09:54:31 -0600
MIME-Version: 1.0
In-Reply-To: <20171109154049.42386-1-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="DqXWWp1E2HWkXWDhe85nXf4KdaQ0iSHNl"
Subject: Re: [Qemu-devel] [PATCH 0/2] add qmp nbd-server-remove
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DqXWWp1E2HWkXWDhe85nXf4KdaQ0iSHNl
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, kwolf@redhat.com, mreitz@redhat.com,
 armbru@redhat.com, den@openvz.org
Message-ID: <a84d3d68-6823-d504-f4cb-5d52be9563c0@redhat.com>
Subject: Re: [PATCH 0/2] add qmp nbd-server-remove
References: <20171109154049.42386-1-vsementsov@virtuozzo.com>
In-Reply-To: <20171109154049.42386-1-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/09/2017 09:40 AM, Vladimir Sementsov-Ogievskiy wrote:
> Add command to remove nbd export, pair to nbd-server-add.
> The whole thing and description are in patch 02.
>=20
> Vladimir Sementsov-Ogievskiy (2):
>   nbd/server: add additional assert to nbd_export_put
>   qmp: add nbd-server-remove
>=20
>  qapi/block.json | 20 ++++++++++++++++++++
>  blockdev-nbd.c  | 27 +++++++++++++++++++++++++++
>  nbd/server.c    |  1 +
>  3 files changed, 48 insertions(+)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--DqXWWp1E2HWkXWDhe85nXf4KdaQ0iSHNl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAloEejcACgkQp6FrSiUn
Q2qLLQf/W9KQGKAmj0bllTpoKpRpDPTfhfo00WCi/y0xkuCeCvXsVAGj8TEotmYa
IZ3q0BYMXJbVCMFA6qT1LU8W12uqwxtZyjzOdriO2ZWdtSx9by1zvOaEVNurADaS
Niw4sGxh9zHPZoRbecE2ChYRNRvLTrz6npz93t6YqmvvIDG8ihavLhc+YlpbI5sr
/eY1p9fV2SwTUx4WJNiDmnXeKDIw2Rj3HaFootRgbqxwK+AWrEjaWhnriAo+9UII
J2Of/K2MVUbMALOU3olKo0n1q5GVUCQrig37bqoJkfSYDPmNdTQEgIMXjgIEjXaB
FArYQ/hBiClmGAoueMiUtxz4zILpGw==
=Dy6E
-----END PGP SIGNATURE-----

--DqXWWp1E2HWkXWDhe85nXf4KdaQ0iSHNl--
