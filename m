Received: from eggs.gnu.org ([2001:4830:134:3::10]:37630)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dCt26-0003Z2-Hr
	for qemu-devel@nongnu.org; Mon, 22 May 2017 15:30:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dCt22-0006MC-Ll
	for qemu-devel@nongnu.org; Mon, 22 May 2017 15:30:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:4743)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dCt22-0006M4-Cb
	for qemu-devel@nongnu.org; Mon, 22 May 2017 15:30:18 -0400
References: <1495186480-114192-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1495186480-114192-5-git-send-email-anton.nefedov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b2e896f2-363b-9ce0-9ae3-d814c2d503fd@redhat.com>
Date: Mon, 22 May 2017 14:29:53 -0500
MIME-Version: 1.0
In-Reply-To: <1495186480-114192-5-git-send-email-anton.nefedov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Tiik5WQ4WBV81Basb8xqoPfbfuQmb16mQ"
Subject: Re: [Qemu-devel] [PATCH v1 04/13] qcow2: preallocation at image
 expand
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, "Denis V. Lunev" <den@openvz.org>, den@virtuozzo.com, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Tiik5WQ4WBV81Basb8xqoPfbfuQmb16mQ
From: Eric Blake <eblake@redhat.com>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, "Denis V. Lunev" <den@openvz.org>, den@virtuozzo.com,
 mreitz@redhat.com
Message-ID: <b2e896f2-363b-9ce0-9ae3-d814c2d503fd@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v1 04/13] qcow2: preallocation at image
 expand
References: <1495186480-114192-1-git-send-email-anton.nefedov@virtuozzo.com>
 <1495186480-114192-5-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1495186480-114192-5-git-send-email-anton.nefedov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/19/2017 04:34 AM, Anton Nefedov wrote:
> From: "Denis V. Lunev" <den@openvz.org>
>=20
> This patch adds image preallocation at expand to provide better localit=
y
> of QCOW2 image file and optimize this procedure for some distributed
> storages where this procedure is slow.
>=20
> Image expand requests have to be suspended until the allocation is
> performed which is done via special QCowL2Meta.
> This meta is invisible to handle_dependencies() code.
> This is the main reason for also calling preallocation before metadata
> write: it might intersect with preallocation triggered by another IO,
> and has to yield

How does this interact with Max's work on preallocated truncate?
https://lists.gnu.org/archive/html/qemu-devel/2017-04/msg00267.html

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--Tiik5WQ4WBV81Basb8xqoPfbfuQmb16mQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZIzwxAAoJEKeha0olJ0Nq/XgH/R0VT/dPQneXlCMtfD/+uorD
74eFmrCn26u32kpIpap/Ij2VFLaU83Y4JtnoV2CLWWQ6SBE5gdUT719MpWF9EZlZ
br4VgFggrRNKPXorvfMBIrOtrpFZs5eMJfOtzHU6wzeqYMW2H6y/sxB7ebpMR07f
FfSL9QpHD88TrJiu9W4OFvDSWbx4JY9CD1QKW7qRhdIXbcU9kt6V1bLIdbDfq+Yb
mrFTz66Nw/NlVlRdmcR4V8d6OFCVAAw2RH3WCJumZSLxRF/54La3p+CHbV6OmN+s
vY2JeqhSgcqTEjDnjoIaqe+zZWe101SkmHA0CmkROA8mEk1Qj71iK4vC+uAeWhw=
=VMBb
-----END PGP SIGNATURE-----

--Tiik5WQ4WBV81Basb8xqoPfbfuQmb16mQ--
