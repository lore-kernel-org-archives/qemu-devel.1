Received: from eggs.gnu.org ([209.51.188.92]:49461)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ghIaN-0007W7-FZ
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 13:28:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ghIaM-0001RE-Or
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 13:28:15 -0500
References: <20190109041452.31240-1-eblake@redhat.com>
	<20190109041452.31240-6-eblake@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b06b29fb-720d-146a-8488-5a0ff460bab0@redhat.com>
Date: Wed, 9 Jan 2019 12:27:58 -0600
MIME-Version: 1.0
In-Reply-To: <20190109041452.31240-6-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="uefdlqQN0zxwo19NtRy57tEhUycWD4Xw8"
Subject: Re: [Qemu-devel] [PATCH 5/5] qemu-nbd: Add --bitmap=NAME option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: vsementsov@virtuozzo.com, jsnow@redhat.com, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--uefdlqQN0zxwo19NtRy57tEhUycWD4Xw8
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: vsementsov@virtuozzo.com, jsnow@redhat.com, qemu-block@nongnu.org
Message-ID: <b06b29fb-720d-146a-8488-5a0ff460bab0@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 5/5] qemu-nbd: Add --bitmap=NAME option
References: <20190109041452.31240-1-eblake@redhat.com>
 <20190109041452.31240-6-eblake@redhat.com>
In-Reply-To: <20190109041452.31240-6-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/8/19 10:14 PM, Eric Blake wrote:
> Having to fire up qemu, then use QMP commands for nbd-server-start
> and nbd-server-add, just to expose a persistent dirty bitmap, is
> rather tedious.  Make it possible to expose a dirty bitmap using
> just qemu-nbd (of course, for now this only works when qemu-nbd is
> visiting a BDS formatted as qcow2).
>=20
> For now, I play it safe and only allow a bitmap to be exposed on
> a read-only image.  We may relax it in the future.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  qemu-nbd.texi |  5 +++++
>  qemu-nbd.c    | 16 ++++++++++++++--
>  2 files changed, 19 insertions(+), 2 deletions(-)
>=20

> @@ -1015,7 +1027,7 @@ int main(int argc, char **argv)
>          }
>      }
>=20
> -    exp =3D nbd_export_new(bs, dev_offset, fd_size, export_name, NULL,=
 NULL,
> +    exp =3D nbd_export_new(bs, dev_offset, fd_size, export_name, bitma=
p, NULL,
>                           export_description, nbdflags, nbd_export_clos=
ed,
>                           writethrough, NULL, &error_fatal);

The cover letter DID warn that this was only lightly tested.  For it to
even work, you have to s/bitmap, NULL/NULL, bitmap/ or else swap the
meaning of the --bitmap and --description command line options.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--uefdlqQN0zxwo19NtRy57tEhUycWD4Xw8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEY3OaSlgimHGqKqRv3g5py3orov0FAlw2PS4ACgkQ3g5py3or
ov3kHQf/XQXUQpdLQ4GDcVhD0OSDQ43jbKFTPB17BLFpyEHOXZzwaddZrECCxqiW
+Z69WmFm9GqqNXpqWYbjzWf1dZod4jBY5b4GsckTktJHLBMIhI+HAb0jv3x97Rcu
B4Ex/t0wNPqf6HMNNV9OuvutuptSsL8n8difoYQf3PUdwEeymjIfffQsDG5eoUNJ
JN0I1gq4bjcC2TEU2ghHLiuW7Ij/8P2HaFMbjfnJmUwxZSDkN0VoUymz5HP0/Ehd
5+G6qh5PfsiH576YrOluOJmP2B39gnS2v+2bDwA3/hMSDm8XCO9ymjq+wJ7qbOq6
AKcUpnUW+6xs0+OSMm/m6rIg3LSuUQ==
=P3MT
-----END PGP SIGNATURE-----

--uefdlqQN0zxwo19NtRy57tEhUycWD4Xw8--
