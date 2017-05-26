Received: from eggs.gnu.org ([2001:4830:134:3::10]:46727)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dEMzk-0008Co-Os
	for qemu-devel@nongnu.org; Fri, 26 May 2017 17:42:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dEMzj-0000xN-So
	for qemu-devel@nongnu.org; Fri, 26 May 2017 17:42:04 -0400
References: <1495830130-30611-1-git-send-email-kwolf@redhat.com>
	<1495830130-30611-8-git-send-email-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <631e77cd-2bb5-18c7-cde3-cae9790c65e4@redhat.com>
Date: Fri, 26 May 2017 16:41:53 -0500
MIME-Version: 1.0
In-Reply-To: <1495830130-30611-8-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="QLBSQbnEecTkNXDDB8B7SdJd29DLUX5lV"
Subject: Re: [Qemu-devel] [PATCH 07/29] qed: Make
 qed_copy_from_backing_file() synchronous
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
--QLBSQbnEecTkNXDDB8B7SdJd29DLUX5lV
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com,
 mreitz@redhat.com
Message-ID: <631e77cd-2bb5-18c7-cde3-cae9790c65e4@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 07/29] qed: Make qed_copy_from_backing_file()
 synchronous
References: <1495830130-30611-1-git-send-email-kwolf@redhat.com>
 <1495830130-30611-8-git-send-email-kwolf@redhat.com>
In-Reply-To: <1495830130-30611-8-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/26/2017 03:21 PM, Kevin Wolf wrote:
> Note that this code is generally not running in coroutine context, so
> this is an actual blocking synchronous operation. We'll fix this in a
> moment.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/qed.c | 78 +++++++++++++++++++++++------------------------------=
--------
>  1 file changed, 29 insertions(+), 49 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--QLBSQbnEecTkNXDDB8B7SdJd29DLUX5lV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZKKEhAAoJEKeha0olJ0Nq1U0H/RjBYWNXTtwu43JMtMQHZs23
Vx1lqu2rX+93czZTEaeD/GmtoAYLYVt05nuLahDsIiJ8E6uOGlgLRA6v9k2iHAgL
22Zv6B8rtVTAO77r8Mj2Px/u2mITBS5h33F8wnGjfkmS/aqBSywZ5DeMse/Ro8jy
G+5Q1UaOscP9XtrabKasQ2Jk+Oo2XSi8j/jlwt0YC0VmspwPzORTSmJ8NxLhy7dU
Qie3sDpqPwMs1CtfC1g1t4JKquuIe1V1Zqp2P+cntknketE829h9vYhtpA/2ggbL
qBTpu2x00kJ2mX3pss14LMNZs673dD5XyRP88+oh844gK8I3p1fRU8Br4GrX3L4=
=fiTD
-----END PGP SIGNATURE-----

--QLBSQbnEecTkNXDDB8B7SdJd29DLUX5lV--
