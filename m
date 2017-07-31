Received: from eggs.gnu.org ([2001:4830:134:3::10]:37265)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dcALj-0000Vx-Sf
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 09:03:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dcALf-0007A5-TQ
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 09:03:07 -0400
References: <cover.1501477080.git.jcody@redhat.com>
	<402fccc1212ad053c47110420b9f1c2e751d3d31.1501477080.git.jcody@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <bea61cfc-0426-68c5-3f39-eb2ada5e0bc3@redhat.com>
Date: Mon, 31 Jul 2017 08:02:39 -0500
MIME-Version: 1.0
In-Reply-To: <402fccc1212ad053c47110420b9f1c2e751d3d31.1501477080.git.jcody@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="nXW8s8BOGB6Ogp58QwEaa6Ad2upvhNjiE"
Subject: Re: [Qemu-devel] [PATCH for-2.11 3/3] qemu-iotests: add option to
 save temp files on error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com, stefanha@redhat.com, jsnow@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nXW8s8BOGB6Ogp58QwEaa6Ad2upvhNjiE
From: Eric Blake <eblake@redhat.com>
To: Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org,
 mreitz@redhat.com, stefanha@redhat.com, jsnow@redhat.com
Message-ID: <bea61cfc-0426-68c5-3f39-eb2ada5e0bc3@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.11 3/3] qemu-iotests: add option to
 save temp files on error
References: <cover.1501477080.git.jcody@redhat.com>
 <402fccc1212ad053c47110420b9f1c2e751d3d31.1501477080.git.jcody@redhat.com>
In-Reply-To: <402fccc1212ad053c47110420b9f1c2e751d3d31.1501477080.git.jcody@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/31/2017 12:04 AM, Jeff Cody wrote:
> Now that ./check takes care of cleaning up after each tests, it
> can also selectively not clean up.  Add option to leave all output from=

> tests intact if that test encountered an error.
>=20
> Note: this currently only works for bash tests, as the python tests
> still clean up after themselves manually.
>=20
> Signed-off-by: Jeff Cody <jcody@redhat.com>
> ---
>  tests/qemu-iotests/check  | 5 ++++-
>  tests/qemu-iotests/common | 6 ++++++
>  2 files changed, 10 insertions(+), 1 deletion(-)

Reviewed-by: Eric Blake <eblake@redhat.com>


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--nXW8s8BOGB6Ogp58QwEaa6Ad2upvhNjiE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAll/KnAACgkQp6FrSiUn
Q2qeoQgApHwafZR+DOlyDB+3I6gNmuzw2t472oHP/F9OtGsWaMv746k6tfOw9gHT
sy/eMSlai/KnLG2Pe7km4Uml2+s29M1UEeMurDejf6HVD02//HbwdNjCpN0Srcbl
cQTKdIkWV2K2qT2NxIu2HOsbUd2kt5xEDPbI/sXS3ht9pbrA3WERHnsQQYCzZJr5
o3vkdm9jt3lt7DZS3O3DCURE8peoLVLUrNDEfuRcBuQC5BZhFzuDb5b/NLMEAfuS
4MVPJYXX6gEGHzN2lnXrPWMOFpp73C6U01ZFNUOONFeDLEBwFnd0skgkayPs5eIs
m8QMsdG2PZZRTP6JjtEC4w2jNg7SDw==
=5xUL
-----END PGP SIGNATURE-----

--nXW8s8BOGB6Ogp58QwEaa6Ad2upvhNjiE--
