Received: from eggs.gnu.org ([2001:4830:134:3::10]:39647)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dEMVm-00064i-BY
	for qemu-devel@nongnu.org; Fri, 26 May 2017 17:11:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dEMVk-0006AM-N9
	for qemu-devel@nongnu.org; Fri, 26 May 2017 17:11:05 -0400
References: <1495830130-30611-1-git-send-email-kwolf@redhat.com>
	<1495830130-30611-4-git-send-email-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9af138d1-8d7c-afb1-d0fa-c4cef045289a@redhat.com>
Date: Fri, 26 May 2017 16:10:53 -0500
MIME-Version: 1.0
In-Reply-To: <1495830130-30611-4-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="IU2DlobFEQnSWFTJpGJMv90jGWEKMFUNM"
Subject: Re: [Qemu-devel] [PATCH 03/29] qed: Remove callback from
 qed_read_table()
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
--IU2DlobFEQnSWFTJpGJMv90jGWEKMFUNM
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com,
 mreitz@redhat.com
Message-ID: <9af138d1-8d7c-afb1-d0fa-c4cef045289a@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 03/29] qed: Remove callback from
 qed_read_table()
References: <1495830130-30611-1-git-send-email-kwolf@redhat.com>
 <1495830130-30611-4-git-send-email-kwolf@redhat.com>
In-Reply-To: <1495830130-30611-4-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/26/2017 03:21 PM, Kevin Wolf wrote:
> Instead of passing the return value to a callback, return it to the
> caller so that the callback can be inlined there.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/qed-table.c | 79 ++++++++++++++++++-----------------------------=
--------
>  1 file changed, 25 insertions(+), 54 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--IU2DlobFEQnSWFTJpGJMv90jGWEKMFUNM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZKJneAAoJEKeha0olJ0NqEG4H/2iPnu5rtInpQo/wusxBCdtG
WFt3BsoX43wOuDDkTmIDRgZLhzPR9fzD4rFpcgaSASdaI/HKnBCKi2fvBP7HU79J
y5cSnlJ/pPGuq5laW5ABUs5iL/sXglu9ExSOpkgULmc5cyJ61aet54OCp4V7cpQw
DdQ28ZUBbSeFT/OmiqWDHrrVxmQlKuPpPoAphwvJqV7ky4CBJ9eDJkoI8dlKUoJ8
1+J0jedLmkXO9hLxnzeKRyMBmp+DhKp7t1k28LvEyjFaH6e3f8dZPMIRUHI5R+fU
20FCBVZiwxS9qvNLpT/jJFtERU1tG/VYd4H99diWDZzUJoMPSoM83wZjj98hOPI=
=wRMd
-----END PGP SIGNATURE-----

--IU2DlobFEQnSWFTJpGJMv90jGWEKMFUNM--
