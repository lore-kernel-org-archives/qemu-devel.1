Received: from eggs.gnu.org ([2001:4830:134:3::10]:45368)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dDC0z-0001l3-To
	for qemu-devel@nongnu.org; Tue, 23 May 2017 11:46:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dDC0z-0003G6-0U
	for qemu-devel@nongnu.org; Tue, 23 May 2017 11:46:29 -0400
References: <1495548064-10926-1-git-send-email-kwolf@redhat.com>
	<1495548064-10926-5-git-send-email-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b56cd2ae-8793-4b61-e867-73d66baba45b@redhat.com>
Date: Tue, 23 May 2017 10:46:17 -0500
MIME-Version: 1.0
In-Reply-To: <1495548064-10926-5-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="XCvi4QrAwW5JC7JsQwqTqSDVichT5ewae"
Subject: Re: [Qemu-devel] [PATCH 4/4] qemu-iotests: Block migration test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: famz@redhat.com, quintela@redhat.com, qemu-devel@nongnu.org, dgilbert@redhat.com, mreitz@redhat.com, stefanha@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XCvi4QrAwW5JC7JsQwqTqSDVichT5ewae
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: famz@redhat.com, quintela@redhat.com, qemu-devel@nongnu.org,
 dgilbert@redhat.com, mreitz@redhat.com, stefanha@redhat.com
Message-ID: <b56cd2ae-8793-4b61-e867-73d66baba45b@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 4/4] qemu-iotests: Block migration test
References: <1495548064-10926-1-git-send-email-kwolf@redhat.com>
 <1495548064-10926-5-git-send-email-kwolf@redhat.com>
In-Reply-To: <1495548064-10926-5-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/23/2017 09:01 AM, Kevin Wolf wrote:
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  tests/qemu-iotests/183     | 121 +++++++++++++++++++++++++++++++++++++=
++++++++
>  tests/qemu-iotests/183.out |  48 ++++++++++++++++++
>  tests/qemu-iotests/group   |   1 +
>  3 files changed, 170 insertions(+)
>  create mode 100755 tests/qemu-iotests/183
>  create mode 100644 tests/qemu-iotests/183.out
>=20

Does this test gracefully skip when coupled with the efforts for a
configure option to disable block migration?
https://lists.gnu.org/archive/html/qemu-devel/2017-05/msg04398.html

> +echo
> +echo =3D=3D=3D Do block migration to destination =3D=3D=3D
> +echo
> +
> +_send_qemu_cmd $src "migrate -b unix:${MIG_SOCKET}" "(qemu)"

I don't see any earlier checks, so it looks like you'd choke here if -b
is not compiled in.

Should we also check the use of -i?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--XCvi4QrAwW5JC7JsQwqTqSDVichT5ewae
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZJFlJAAoJEKeha0olJ0NqSQsH/i+tcVmSXHhOTnYhtQ161dGD
16uMjqClPefIpNN71nEkho0uO6cLysY2fyowHCLK/i5O/tLdGxcewEyosLpWRgX4
Uk1p0ZcpbuPDV+SfhLGqivv050eKn1AFCNwlqhKFz1vKYCI1eUyeE/nCTPHfzcHm
yaBcPfOBkAObcxE0PuZxeThYro6v4H9Gr+1I1KLFhV51JN7RDtm4zAfdBPJ4qYxj
C4EIF+sVFhEG1+bLp3YUIQSMP/dBx0SMHjUaa2iYAZzuKyTcVZ+mwb+YUqJFD1xH
1Vi/iLPCo85XmEjKiqf23TPwb9dCoGraap8KRaRQ+YlFfJddodmlHd2pe+9iavA=
=4IYm
-----END PGP SIGNATURE-----

--XCvi4QrAwW5JC7JsQwqTqSDVichT5ewae--
