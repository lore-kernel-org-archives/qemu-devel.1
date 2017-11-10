Received: from eggs.gnu.org ([2001:4830:134:3::10]:49759)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eDHhS-0002aI-Dj
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 17:23:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eDHhR-0001Z8-Ka
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 17:22:58 -0500
References: <20171110221329.24176-1-mreitz@redhat.com>
	<20171110221329.24176-3-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <40c5af3a-9d7c-5040-c719-d69e14c2de3c@redhat.com>
Date: Fri, 10 Nov 2017 16:22:52 -0600
MIME-Version: 1.0
In-Reply-To: <20171110221329.24176-3-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="b9ebkUkh6Supb0LDX777xjXSbp71K4tHB"
Subject: Re: [Qemu-devel] [PATCH for-2.12 2/3] block: Handle null backing
 link
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--b9ebkUkh6Supb0LDX777xjXSbp71K4tHB
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org
Message-ID: <40c5af3a-9d7c-5040-c719-d69e14c2de3c@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.12 2/3] block: Handle null backing link
References: <20171110221329.24176-1-mreitz@redhat.com>
 <20171110221329.24176-3-mreitz@redhat.com>
In-Reply-To: <20171110221329.24176-3-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/10/2017 04:13 PM, Max Reitz wrote:
> Instead of converting all "backing": null instances into "backing": "",=

> handle a null value directly in bdrv_open_inherit().
>=20
> This enables explicitly null backing links for json:{} filenames.
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  block.c                    |  2 +-
>  blockdev.c                 | 14 --------------
>  tests/qemu-iotests/089     | 20 ++++++++++++++++++++
>  tests/qemu-iotests/089.out |  8 ++++++++
>  4 files changed, 29 insertions(+), 15 deletions(-)
>=20

> @@ -3899,19 +3898,6 @@ void qmp_blockdev_add(BlockdevOptions *options, =
Error **errp)
> =20
>      qdict_flatten(qdict);
> =20
> -    /*
> -     * Rewrite "backing": null to "backing": ""
> -     * TODO Rewrite "" to null instead, and perhaps not even here
> -     */

Nice that the TODO told you what to do :)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--b9ebkUkh6Supb0LDX777xjXSbp71K4tHB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAloGJr0ACgkQp6FrSiUn
Q2oZJAgAsElANVNs4fzQxsMDCi8RF2DfUsZrmltz6RBNBRois9121mrE98JFCqgk
U/TvfXID0SKnCPhoELJ94OYajtMPgNx2LS2XJqi593CsQ4G//jN6jDBnJS3geumx
u0VzcwIqsTlLzoxw51OrRAWzkxSyPFuIdPJrFCoNo4rBIT0kpFj8iGXr2CVlTT88
qLalnfVuvZFvBwDj9LEVm5hD0K34E41zdcnpdxXhe5yEVq8nChV7uwRtO1vairkn
7R2Iz/Fq8mZfCp0JXdlf76xEllw9mE2sXQI5DZxKsl8WsI+maS2o5SsI7y2Rj0h7
Drbl7slbBeBG2cSJUQn/u4ulX+00mA==
=4VxM
-----END PGP SIGNATURE-----

--b9ebkUkh6Supb0LDX777xjXSbp71K4tHB--
