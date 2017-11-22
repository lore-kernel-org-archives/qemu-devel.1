Received: from eggs.gnu.org ([2001:4830:134:3::10]:53068)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eHd3h-0005Ae-N4
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 16:59:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eHd3g-0007Wu-Rt
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 16:59:53 -0500
References: <20171122101958.17065-1-vsementsov@virtuozzo.com>
	<20171122101958.17065-4-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2ab4c650-e5c3-8751-aa20-af328cd9308d@redhat.com>
Date: Wed, 22 Nov 2017 15:59:44 -0600
MIME-Version: 1.0
In-Reply-To: <20171122101958.17065-4-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="MQumIE1mklTtUiTV5Sbdgb80OgmfxIpOq"
Subject: Re: [Qemu-devel] [PATCH 3/5] nbd/server: add helper nbd_opt_invalid
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, kwolf@redhat.com, mreitz@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--MQumIE1mklTtUiTV5Sbdgb80OgmfxIpOq
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, kwolf@redhat.com, mreitz@redhat.com, den@openvz.org
Message-ID: <2ab4c650-e5c3-8751-aa20-af328cd9308d@redhat.com>
Subject: Re: [PATCH 3/5] nbd/server: add helper nbd_opt_invalid
References: <20171122101958.17065-1-vsementsov@virtuozzo.com>
 <20171122101958.17065-4-vsementsov@virtuozzo.com>
In-Reply-To: <20171122101958.17065-4-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/22/2017 04:19 AM, Vladimir Sementsov-Ogievskiy wrote:
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  nbd/server.c | 74 +++++++++++++++++++++++++++++++++++++---------------=
--------
>  1 file changed, 46 insertions(+), 28 deletions(-)
>=20

> +/* nbd_opt_invalid
> + * Drop reminded option data and reply with NBD_REP_ERR_INVALID

s/reminded/the remainder of/

In fact, if we generalize this just a bit more, and let the caller
choose whether to use NBD_REP_ERR_INVALID or NBD_REP_ERR_TLS_REQD or
NBD_REP_ERR_UNSUP, then we can merge this functionality directly into
nbd_opt_drop() instead of adding another function.  I guess I'll have to
merge that into the counter-proposal I have in mind (but at this point,
the counter-proposal won't be posted any sooner than 2.11-rc3, in part
because I'm almost on my Thanksgiving vacation).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--MQumIE1mklTtUiTV5Sbdgb80OgmfxIpOq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAloV81AACgkQp6FrSiUn
Q2paPwgAiCITX1YGYRA32MNRzJyPII47XP7q92ypCLMRCk8OiBv3R15X5FFM37g9
e9qHPn3qOb1UoBIXJUvFUG/e48CRtCnYQZVtIQ3zJWhNokQAgSgbokM6evSsV1hc
u7LC6Efqg40Ut62jFSgUPvMuK0FkRyG1tDoS72di8u5shnX1ImAADsWRZ3WIulz6
cy/Kmqk85rC9MFTydizFesCBXRjZ85v9q2vHxadktqIR35jZXcsHaL1WNIoZWc3a
ERRgxTZFtk58i7Hk5Ho9fQRC8CunbgFROMBJz3QGNXgC2gWFG66gBqU39nPhO8G5
q8GzRLLRaTLuRkFnfwmuZdjBnfUd9Q==
=dnxQ
-----END PGP SIGNATURE-----

--MQumIE1mklTtUiTV5Sbdgb80OgmfxIpOq--
