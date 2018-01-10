Received: from eggs.gnu.org ([2001:4830:134:3::10]:55591)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eZJK0-0007R9-2H
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 11:33:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eZJJz-0004ff-4i
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 11:33:48 -0500
References: <20171207155102.66622-1-vsementsov@virtuozzo.com>
	<20171207155102.66622-2-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <320843b0-a082-f1e6-ac50-b6abb91bd4b5@redhat.com>
Date: Wed, 10 Jan 2018 10:33:12 -0600
MIME-Version: 1.0
In-Reply-To: <20171207155102.66622-2-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="yfRXLf11QnVq7zmbcsJlX6c9g0cdct49Z"
Subject: Re: [Qemu-devel] [PATCH v2 1/6] nbd/server: add additional assert
 to nbd_export_put
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, dgilbert@redhat.com, pbonzini@redhat.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--yfRXLf11QnVq7zmbcsJlX6c9g0cdct49Z
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, dgilbert@redhat.com, pbonzini@redhat.com,
 mreitz@redhat.com, kwolf@redhat.com, den@openvz.org
Message-ID: <320843b0-a082-f1e6-ac50-b6abb91bd4b5@redhat.com>
Subject: Re: [PATCH v2 1/6] nbd/server: add additional assert to
 nbd_export_put
References: <20171207155102.66622-1-vsementsov@virtuozzo.com>
 <20171207155102.66622-2-vsementsov@virtuozzo.com>
In-Reply-To: <20171207155102.66622-2-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/07/2017 09:50 AM, Vladimir Sementsov-Ogievskiy wrote:
> This place is not obvious, nbd_export_close may theoretically reduce
> refcount to 0. It may happen if someone calls nbd_export_put on named
> export not through nbd_export_set_name when refcount is 1.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Max Reitz <mreitz@redhat.com>
> ---
>  nbd/server.c | 6 ++++++
>  1 file changed, 6 insertions(+)

I'm going ahead and staging this one in my NBD queue now, while still
waiting for resolution on my comments later in the series.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--yfRXLf11QnVq7zmbcsJlX6c9g0cdct49Z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpWQEgACgkQp6FrSiUn
Q2qTAAf/c9Bt79Alk2sVB+k6V8CguXsdz6vy9f7dr0Yor05pErYnH7PZQFnNcbNt
F28lpUNNxOXm8iydYtueUb5NbWqc0nePgcF/oH4dqKnTLAUZ/2IK+nSlE+6+qv4+
0bHSVT35ac2/mnHLk4h3FSwOXHDWk0hWs0rXXh/IYzMnynC+/VALgHfBL2NEGmx9
MnCchudkEadPwKVii1z6zJUZNvYVtYhsvhdwti7PC1V4yw5io2rOkmJz4E/FXeI5
tBnBdftfIUO0tnkxeTUNovtr1OKovrhdMZZJl+ozqZpa8GKiwxOlFPMTUabYBqkV
ju/iSm/kSs7RXRA59gyXrOSZb1nktw==
=6FCx
-----END PGP SIGNATURE-----

--yfRXLf11QnVq7zmbcsJlX6c9g0cdct49Z--
