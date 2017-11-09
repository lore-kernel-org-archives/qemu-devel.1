Received: from eggs.gnu.org ([2001:4830:134:3::10]:51514)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eCpA1-0006zf-Ga
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 10:54:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eCpA0-0006Ft-Jy
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 10:54:33 -0500
References: <20171109154049.42386-1-vsementsov@virtuozzo.com>
	<20171109154049.42386-3-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4b34a07a-cfd3-086a-3d49-16653abf46a4@redhat.com>
Date: Thu, 9 Nov 2017 09:54:14 -0600
MIME-Version: 1.0
In-Reply-To: <20171109154049.42386-3-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="4AIv6Tkj3Brg53jkRIBcds8ux0CfjcCx8"
Subject: Re: [Qemu-devel] [PATCH 2/2] qmp: add nbd-server-remove
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
--4AIv6Tkj3Brg53jkRIBcds8ux0CfjcCx8
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, kwolf@redhat.com, mreitz@redhat.com,
 armbru@redhat.com, den@openvz.org
Message-ID: <4b34a07a-cfd3-086a-3d49-16653abf46a4@redhat.com>
Subject: Re: [PATCH 2/2] qmp: add nbd-server-remove
References: <20171109154049.42386-1-vsementsov@virtuozzo.com>
 <20171109154049.42386-3-vsementsov@virtuozzo.com>
In-Reply-To: <20171109154049.42386-3-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/09/2017 09:40 AM, Vladimir Sementsov-Ogievskiy wrote:
> Add command for export removing. It is needed for cases when we
> don't want to keep export after the operation on it was completed.
> The other example is temporary node, created with blockdev-add.
> If we want to delete it we should firstly remove corresponding
> NBD export.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  qapi/block.json | 20 ++++++++++++++++++++
>  blockdev-nbd.c  | 27 +++++++++++++++++++++++++++
>  2 files changed, 47 insertions(+)

It would be nice (okay as a followup patch) to add iotest coverage of
the new command.

>  ##
> +# @nbd-server-remove:
> +#
> +# Stop exporting block node through QEMU's embedded NBD server.
> +#
> +# @device: The device name or node name of the exported node. Should b=
e equal
> +#          to @device parameter for corresponding nbd-server-add comma=
nd call.
> +#
> +# @force: Whether active connections to the export should be closed. I=
f this
> +#         parameter is false the export is only removed from named exp=
orts list,
> +#         so new connetions are impossible and it would be freed after=
 all
> +#         clients are disconnected (default false).
> +#
> +# Returns: error if the server is not running or the device is not mar=
ked for
> +#          export.
> +#
> +# Since: 2.12

You are correct that this is too late for 2.11, but I like the concept.
Once we have some testsuite coverage, I'll queue it for 2.12.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--4AIv6Tkj3Brg53jkRIBcds8ux0CfjcCx8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAloEeiYACgkQp6FrSiUn
Q2qXRAf/Q7dqza2JDwW3lyKn/mjYgBFJyVJ1N+d7dUzEQxOc58mrxCn5c2C+2ACv
xVH+VwqoDDbyH7pNmelgUm7PiDBY3K21FX/4LLiaXCrfMeZ7pdQzBXtEv1HoTe9n
gOPAweDQouT5LmQ+lF/ZwdqkfUat8MM2AYgBKgcu9vylB7uHt723rV8YDKTacq1O
zS12+ptpXHnzEzeUaaQ0MZ5ljxqLY9jWcnwXBql9t3iPfM2vZixkttEkwjI6v8Qo
9mOIYw2nZ+Y/PA2Ydhwy9xIKs7Ieqz9wIUck80O0Cj2lF9KynMNpB8ABW8Xhq/pQ
1Zyk0wIWsXi/EyPwk+TGtF1dz6q+MA==
=gRFO
-----END PGP SIGNATURE-----

--4AIv6Tkj3Brg53jkRIBcds8ux0CfjcCx8--
