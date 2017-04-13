Received: from eggs.gnu.org ([2001:4830:134:3::10]:60462)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cyij0-0005zZ-PJ
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 13:40:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cyiiw-00006U-83
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 13:40:06 -0400
References: <1492104214-29994-1-git-send-email-kwolf@redhat.com>
	<1492104214-29994-2-git-send-email-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a635dc96-283e-3704-59cb-248eb065bf2b@redhat.com>
Date: Thu, 13 Apr 2017 12:39:54 -0500
MIME-Version: 1.0
In-Reply-To: <1492104214-29994-2-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="mGQNurKQGhCKU1LsGhqQnBkpwmX69ktbm"
Subject: Re: [Qemu-devel] [PATCH 1/3] migration: Call
 blk_resume_after_migration() for postcopy
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, quintela@redhat.com, dgilbert@redhat.com, stefanha@redhat.com, lvivier@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mGQNurKQGhCKU1LsGhqQnBkpwmX69ktbm
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, quintela@redhat.com, dgilbert@redhat.com,
 stefanha@redhat.com, lvivier@redhat.com, qemu-devel@nongnu.org
Message-ID: <a635dc96-283e-3704-59cb-248eb065bf2b@redhat.com>
Subject: Re: [PATCH 1/3] migration: Call blk_resume_after_migration() for
 postcopy
References: <1492104214-29994-1-git-send-email-kwolf@redhat.com>
 <1492104214-29994-2-git-send-email-kwolf@redhat.com>
In-Reply-To: <1492104214-29994-2-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/13/2017 12:23 PM, Kevin Wolf wrote:
> Commit d35ff5e6 ('block: Ignore guest dev permissions during incoming
> migration') added blk_resume_after_migration() to the precopy migration=

> path, but neglected to add it to the duplicated code that is used for
> postcopy migration. This means that the guest device doesn't request th=
e
> necessary permissions, which ultimately led to failing assertions.
>=20
> Add the missing blk_resume_after_migration() to the postcopy path.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  migration/savevm.c | 8 ++++++++
>  1 file changed, 8 insertions(+)

Reviewed-by: Eric Blake <eblake@redhat.com>

Are we targetting this for 2.9-rc5, or is it 2.10 material?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--mGQNurKQGhCKU1LsGhqQnBkpwmX69ktbm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY77fqAAoJEKeha0olJ0Nqw/MH/isqQWQfwE3naHkA54MpZb8i
LLwpuyXTWO3bXUrUVXSABvKpyAcsaI8PFzAinxx2PivttMW3OjuOZr5YctV7vHq6
2Pq7K8n8Xo8FaFhlmvPWYJOQ+OtL/izVyU4bW85CUOqj9ZmwsIG8/cYqsWxVqqkG
/uWAnEeqv9TPAUwhqXeBUcLRfy9oXevjNZvOhR26NJWTND2J51OvToxXAlZ3SP+s
R/1cZpClY7MiKuLWQwxiuYmQ/NQK6QdFkjBP28rdGxQi0tWNHM760hI+ulH7GG7Q
xFVdl6gS+Ioxn75Q213L7vwabn344bWeGxu0vpEFU8zoPUrmidVVUdvCmKpVQPo=
=LkwF
-----END PGP SIGNATURE-----

--mGQNurKQGhCKU1LsGhqQnBkpwmX69ktbm--
