Received: from eggs.gnu.org ([2001:4830:134:3::10]:51683)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d8qo4-0002nI-KK
	for qemu-devel@nongnu.org; Thu, 11 May 2017 12:19:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d8qo3-0002yK-Jc
	for qemu-devel@nongnu.org; Thu, 11 May 2017 12:19:12 -0400
References: <20170511150337.21470-1-berto@igalia.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <29c88225-35e5-0daa-7983-4cf81e1dc1da@redhat.com>
Date: Thu, 11 May 2017 11:19:04 -0500
MIME-Version: 1.0
In-Reply-To: <20170511150337.21470-1-berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="7StQNSEgs5sdEjgoo0VokgKxhw7oHVwUk"
Subject: Re: [Qemu-devel] [PATCH] qcow2: remove extra local_error variable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7StQNSEgs5sdEjgoo0VokgKxhw7oHVwUk
From: Eric Blake <eblake@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Message-ID: <29c88225-35e5-0daa-7983-4cf81e1dc1da@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qcow2: remove extra local_error variable
References: <20170511150337.21470-1-berto@igalia.com>
In-Reply-To: <20170511150337.21470-1-berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/11/2017 10:03 AM, Alberto Garcia wrote:
> Commit d7086422b1c1e75e320519cfe26176db6ec97a37 added a local_err
> variable global to the qcow2_amend_options() function, so there's no
> need to have this other one.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/qcow2.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>



--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--7StQNSEgs5sdEjgoo0VokgKxhw7oHVwUk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZFI74AAoJEKeha0olJ0NqOHYIAI26Q09FkGiSGLcBw17o2+Gb
ZrvzyVW6DDjey+baxtjNwbwB8/yvWC7eI06E34Dbq/HmfDjNFR5v949NnzMBPOLu
cgiC49tCifL+ZXsnS9Gu4NYGNuoch5fb5g0SLr4U+cIzF20OPv3qzPYwTaLWZirX
8ww30Id070nKIPupP6lnYloksUmgSDoFMZT0uvETkPqFHHT2gggX3h00TCaV9Vgd
2zAXVPqskALT8aG1pSbSPeoehWlhqk3SK0w+Ng+8PqyPS/VUew/pczihz/a0mpoF
8NzNTIspVi4RtKETM0/O65au9ztbRzeGySAA7Ser0UgTrCsSyuoIgsQX4C6dyRQ=
=nSt5
-----END PGP SIGNATURE-----

--7StQNSEgs5sdEjgoo0VokgKxhw7oHVwUk--
