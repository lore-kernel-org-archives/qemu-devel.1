Received: from eggs.gnu.org ([2001:4830:134:3::10]:44332)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ef9s9-0006Ds-7i
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 14:41:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ef9s8-0002Kh-Cx
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 14:41:13 -0500
References: <cover.1516978645.git.berto@igalia.com>
	<4bd645eb4a81eb2009fab318dfca6d47e657655c.1516978645.git.berto@igalia.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3204fa8a-0bb6-6116-2f9b-635838803fef@redhat.com>
Date: Fri, 26 Jan 2018 13:41:04 -0600
MIME-Version: 1.0
In-Reply-To: <4bd645eb4a81eb2009fab318dfca6d47e657655c.1516978645.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="MDhwZJ1iMdd0po4Stm8utpP6lI3A8h2J9"
Subject: Re: [Qemu-devel] [PATCH v3 28/39] qcow2: Read refcount before L2
 table in expand_zero_clusters_in_l1()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>, "Denis V . Lunev" <den@openvz.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--MDhwZJ1iMdd0po4Stm8utpP6lI3A8h2J9
From: Eric Blake <eblake@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 "Denis V . Lunev" <den@openvz.org>
Message-ID: <3204fa8a-0bb6-6116-2f9b-635838803fef@redhat.com>
Subject: Re: [PATCH v3 28/39] qcow2: Read refcount before L2 table in
 expand_zero_clusters_in_l1()
References: <cover.1516978645.git.berto@igalia.com>
 <4bd645eb4a81eb2009fab318dfca6d47e657655c.1516978645.git.berto@igalia.com>
In-Reply-To: <4bd645eb4a81eb2009fab318dfca6d47e657655c.1516978645.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/26/2018 08:59 AM, Alberto Garcia wrote:
> At the moment it doesn't really make a difference whether we call
> qcow2_get_refcount() before of after reading the L2 table, but if we
> want to support L2 slices we'll need to read the refcount first.
>=20
> This patch simply changes the order of those two operations to prepare
> for that. The patch with the actual semantic changes will be easier to
> read because of this.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/qcow2-cluster.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--MDhwZJ1iMdd0po4Stm8utpP6lI3A8h2J9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlprhFAACgkQp6FrSiUn
Q2rGTQgAk+U8w2saL1nD16ljbCgO5WDlovZef08v72gDImRjKDmUsOpd9qrGegmf
IvpTh0LvZOaD6AIU+EwkN8oQ2LxHn6t2sa9qKhYXLihpn8FLXDkP1nvs9PWA10Uy
eSXAB27SP9uCmdlKuIyE3VjJ8AH+nWh04vuMUamJZTHuAHNy7UuE6nCgs3o4g3KQ
OPGdQ1jSrKNQ2gpJNes41B0JhO4JoCwA1BcDu18hJeRz7DwC9dKjuA9OH9fjnRlf
fItCKr/bR7kC1XypNkoMsebCZ11oQYKQskAGy/zeqVhJpXKuuqXdRavc1kOkzv7F
STbUhyz3+D9Ik3OdgfYvz5IwxAV9lA==
=lsac
-----END PGP SIGNATURE-----

--MDhwZJ1iMdd0po4Stm8utpP6lI3A8h2J9--
