Received: from eggs.gnu.org ([2001:4830:134:3::10]:33655)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1egWOT-0001af-Lt
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 08:56:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1egWOP-0002WE-Hj
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 08:56:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58246)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1egWOP-0002Vj-9s
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 08:56:09 -0500
References: <151730107324.755.12264321256439401751.stgit@bahia.lan>
From: Eric Blake <eblake@redhat.com>
Message-ID: <290cc563-b4a3-70d4-59a5-66ad63cd7abc@redhat.com>
Date: Tue, 30 Jan 2018 07:56:01 -0600
MIME-Version: 1.0
In-Reply-To: <151730107324.755.12264321256439401751.stgit@bahia.lan>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="MWcUztg0vKSNfHIGl7titFA5B5iJ6Y0OZ"
Subject: Re: [Qemu-devel] [PATCH] tests/virtio-9p: explicitely handle
 potential integer overflows
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--MWcUztg0vKSNfHIGl7titFA5B5iJ6Y0OZ
From: Eric Blake <eblake@redhat.com>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <290cc563-b4a3-70d4-59a5-66ad63cd7abc@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] tests/virtio-9p: explicitely handle
 potential integer overflows
References: <151730107324.755.12264321256439401751.stgit@bahia.lan>
In-Reply-To: <151730107324.755.12264321256439401751.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/30/2018 02:32 AM, Greg Kurz wrote:
> Signed-off-by: Greg Kurz <groug@kaod.org>

In the subject: s/explicitely/explicitly/

> ---
>  tests/virtio-9p-test.c |   31 +++++++++++++++++++++----------
>  1 file changed, 21 insertions(+), 10 deletions(-)
>=20
> This is based on SHA1 2eab02aa260ac5405e1e51c9cc1b4c3aa23fc45a from my
> 9p-next branch:
>=20
> https://github.com/gkurz/qemu/commits/9p-next

I don't think patchew recognizes those sorts of references yet; better
might be:

Based-on: <151675071042.29381.16225631028845063799.stgit@bahia.lan>
([PATCH 0/7] tests: virtio-9p: test request cancellation)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--MWcUztg0vKSNfHIGl7titFA5B5iJ6Y0OZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpweXEACgkQp6FrSiUn
Q2oROggAmTEFFc8dbp/o7JO1xA9XS8tsUFnp+v9/z4y8EEJKVu1XHzIEonR4JwMX
Hix2WZ8dDHcdFjPvzuvCwCEB+IyAoEckN1EihXxrjXU36sqhszEEDUYDz8DMPq6p
EXexic8kIx7/y64jHxftYEVnxQ7BPEJ6H6Ttsbm5bpmkZWH5lbDMOqB4E4r7HSsX
sQWuNWInpvu+YYjL556HK4RGViO7Ezpfy/d+T/IJoTB1bXiPN05Fg47VSgvGm55J
pLTSjXUk6gO3NH80vinvLa+MByCxRCXVFARB3Euv+4HAXocSlIT9cPTjadeSMcLi
9z0+luGIPF0GAfwA073xRlIlMRLWmQ==
=zvgK
-----END PGP SIGNATURE-----

--MWcUztg0vKSNfHIGl7titFA5B5iJ6Y0OZ--
