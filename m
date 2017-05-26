Received: from eggs.gnu.org ([2001:4830:134:3::10]:40406)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dEMbC-0000R9-9M
	for qemu-devel@nongnu.org; Fri, 26 May 2017 17:16:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dEMbB-0008Gz-A6
	for qemu-devel@nongnu.org; Fri, 26 May 2017 17:16:42 -0400
References: <1495830130-30611-1-git-send-email-kwolf@redhat.com>
	<1495830130-30611-5-git-send-email-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <043cc722-c5f0-707b-be16-86d04523b320@redhat.com>
Date: Fri, 26 May 2017 16:16:30 -0500
MIME-Version: 1.0
In-Reply-To: <1495830130-30611-5-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="VV6o5Hpr1X5UGtWBv0nuEu1caopbiFS8d"
Subject: Re: [Qemu-devel] [PATCH 04/29] qed: Remove callback from
 qed_read_l2_table()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VV6o5Hpr1X5UGtWBv0nuEu1caopbiFS8d
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com,
 mreitz@redhat.com
Message-ID: <043cc722-c5f0-707b-be16-86d04523b320@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 04/29] qed: Remove callback from
 qed_read_l2_table()
References: <1495830130-30611-1-git-send-email-kwolf@redhat.com>
 <1495830130-30611-5-git-send-email-kwolf@redhat.com>
In-Reply-To: <1495830130-30611-5-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/26/2017 03:21 PM, Kevin Wolf wrote:
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/qed-cluster.c | 94 ++++++++++++++++++---------------------------=
--------
>  block/qed-table.c   | 15 +++------
>  block/qed.h         |  3 +-
>  3 files changed, 36 insertions(+), 76 deletions(-)

The diffstats show how opaque the code was; the cleanups are a lot
easier to read.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--VV6o5Hpr1X5UGtWBv0nuEu1caopbiFS8d
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZKJsuAAoJEKeha0olJ0NqRqoH/jnrM3nmBoNToqRhXU+N9LJU
Ucrip808ECSxIgJJo+hh18zdnvFFofTpNlOSOsNG02QU2T27/VctyS73RbBKwebY
VaG6vlz6zpbddguNdtvQGHpa891slgOQOuu+VE9euLxd4WnKEM4TyID+NS7zfAAx
1sypi9hN17dFnqAgy4JQ/w3IW/5yztw0eiLON4cgE746dN7V3bdCi+1u/i3IlOr5
e/z9jTHWWroACxFBupP3/F8I31BJOTjwz5ef9pLfQtKYYcqKOjNT4DKfgcL7pdf7
PuGR2ZUiQIwRfg4IUbBTpEToEGVM+LYfIsr5aSHEehmj4mRcpeMvQkYRBA9sxKM=
=YAjN
-----END PGP SIGNATURE-----

--VV6o5Hpr1X5UGtWBv0nuEu1caopbiFS8d--
