Received: from eggs.gnu.org ([2001:4830:134:3::10]:54862)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dYZxL-00048Q-20
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 11:35:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dYZxK-0003Ix-6G
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 11:35:07 -0400
References: <1500649820-30450-1-git-send-email-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5bd70af1-1f4d-9e73-86e6-b8b546c12dc9@redhat.com>
Date: Fri, 21 Jul 2017 10:34:59 -0500
MIME-Version: 1.0
In-Reply-To: <1500649820-30450-1-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="dmcKPqSMxHO58c8g8jxj0L4kwxABSIJmk"
Subject: Re: [Qemu-devel] [PATCH] qemu-iotests: Avoid unnecessary sleeps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dmcKPqSMxHO58c8g8jxj0L4kwxABSIJmk
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org
Message-ID: <5bd70af1-1f4d-9e73-86e6-b8b546c12dc9@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qemu-iotests: Avoid unnecessary sleeps
References: <1500649820-30450-1-git-send-email-kwolf@redhat.com>
In-Reply-To: <1500649820-30450-1-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/21/2017 10:10 AM, Kevin Wolf wrote:
> Test cases 030, 041 and 055 used to sleep for a second after calling
> block-job-pause to make sure that the block job had time to actually
> get into paused state. We can instead poll its status and use that one
> second only as a timeout.
>=20
> The tests also slept a second for checking that the block jobs don't
> make progress while being paused. Half a second is more than enough for=

> this.
>=20
> These changes reduce the total time for the three tests by 25 seconds o=
n
> my laptop (from 155 seconds to 130).

Nice!

>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--dmcKPqSMxHO58c8g8jxj0L4kwxABSIJmk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAllyHyMACgkQp6FrSiUn
Q2qXqwgAil5bT5pyIFNMZuSILCrlgwaQFBwAA96fGql4vMbar4D9CX55+zUPDRov
PREr1T+WTCx6R5bz/wDTyy89gCsjaAByp6bCicsOs+sjPSMuHX0GhTALdZD3BuOz
8g+cCuBmThckJrYtEg8omJ3fpC9pSomeUyoZGu0Nx4nmvuW5Qn0A4WViEPKtvu4x
O8wwdp9gu4C07cnt6vi4l1wDeHJBJLtc25W3EAGDsuZzXyAZPzrpvS43cCx8ARg5
DhMC0Tty8puBNv8IoE15JeNSwP46yRyRfYE6Mlu0armIRzLN3c4kZF7OVmArqIqd
jkF8Vu8YKFqgptxP0gbbkv8m8BBAIQ==
=pwXi
-----END PGP SIGNATURE-----

--dmcKPqSMxHO58c8g8jxj0L4kwxABSIJmk--
