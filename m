Received: from eggs.gnu.org ([2001:4830:134:3::10]:37295)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fB63A-0004nN-Jx
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 18:04:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fB639-0006GG-Qn
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 18:04:36 -0400
References: <20180424152515.25664-1-kwolf@redhat.com>
	<20180424152515.25664-6-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c6a84282-f830-cf27-9c86-e1f6ad575317@redhat.com>
Date: Tue, 24 Apr 2018 17:04:19 -0500
MIME-Version: 1.0
In-Reply-To: <20180424152515.25664-6-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="iklYLp7XW9JLrWCoJvE75lvkWI6YX4aAm"
Subject: Re: [Qemu-devel] [RFC PATCH 05/33] blockjob: Add block_job_driver()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, jsnow@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--iklYLp7XW9JLrWCoJvE75lvkWI6YX4aAm
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, jsnow@redhat.com, qemu-devel@nongnu.org,
 mreitz@redhat.com
Message-ID: <c6a84282-f830-cf27-9c86-e1f6ad575317@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 05/33] blockjob: Add block_job_driver()
References: <20180424152515.25664-1-kwolf@redhat.com>
 <20180424152515.25664-6-kwolf@redhat.com>
In-Reply-To: <20180424152515.25664-6-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/24/2018 10:24 AM, Kevin Wolf wrote:
> The backup block job directly accesses the driver field in BlockJob. Ad=
d
> a wrapper for getting it.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  include/block/blockjob.h | 7 +++++++
>  block/backup.c           | 8 +++++---
>  blockjob.c               | 5 +++++
>  3 files changed, 17 insertions(+), 3 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--iklYLp7XW9JLrWCoJvE75lvkWI6YX4aAm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrfqeMACgkQp6FrSiUn
Q2rSnwf/Ycd6btPEO+tX9nx0o4Ey/UVP4D7QiSJ1aBuvVXNkuoVe01bZGO6Jx7jA
h/dFKJdpKI545qUrzSJeSLMpqde0BOdPhr3sHPAB3iUOZg7q8t+hvsb0ymOM1sSl
kKMuwl8XkGpNt+0C8ErfNykLZDzxr2tOJM0uU5ZLwNFG2+41XRKMVQ+FGSOU7SdE
Ruvu3BNvsPro7CbCt8fLPGZ6xcF6WzQqqfcl5oWi+tPDF1C51ADuBNihsXswFK+f
kfzALhKJFDNLD2H1hBQqMrSb1BL+sMK02LBwoPFKZbIdEKSulZVJ4Vf8XmiajC1Y
UYksCS75r89SeC9ufm6VFp+/jO7jOg==
=0vMe
-----END PGP SIGNATURE-----

--iklYLp7XW9JLrWCoJvE75lvkWI6YX4aAm--
