Received: from eggs.gnu.org ([2001:4830:134:3::10]:41911)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d1IWU-0005YX-5J
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 16:17:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d1IWT-0004Nb-4s
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 16:17:50 -0400
References: <1492719341-11476-1-git-send-email-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e45dd3f2-29c2-ea77-10c6-2fe5e845b2bf@redhat.com>
Date: Thu, 20 Apr 2017 15:17:39 -0500
MIME-Version: 1.0
In-Reply-To: <1492719341-11476-1-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="n1qLTMFqCnDOoPepAMO0FOpXfEgTtL6T9"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] qemu-iotests: Remove
 PERL_PROG and BC_PROG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: ymankad@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--n1qLTMFqCnDOoPepAMO0FOpXfEgTtL6T9
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: ymankad@redhat.com, qemu-devel@nongnu.org
Message-ID: <e45dd3f2-29c2-ea77-10c6-2fe5e845b2bf@redhat.com>
Subject: Re: [Qemu-block] [PATCH] qemu-iotests: Remove PERL_PROG and BC_PROG
References: <1492719341-11476-1-git-send-email-kwolf@redhat.com>
In-Reply-To: <1492719341-11476-1-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/20/2017 03:15 PM, Kevin Wolf wrote:
> We test for the presence of perl and bc and save their path in the
> variables PERL_PROG and BC_PROG, but never actually make use of them.
> Remove the checks and assignments so qemu-iotests can run even when
> bc isn't installed.
>=20
> Reported-by: Yash Mankad <ymankad@redhat.com>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  tests/qemu-iotests/common.config | 6 ------
>  1 file changed, 6 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--n1qLTMFqCnDOoPepAMO0FOpXfEgTtL6T9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY+RdjAAoJEKeha0olJ0NqITQIAIe97Me07GGQHGqE4Yet3ckv
+avnns5yXbw699Mjd2AyrG7ob5pyViirolCMOsUijwtqCTe8/H8lItHUPNUc8DEL
a/ZIxQTUZg+1ODJXJ3IXrcYa75x/Ws6LcxkG4FKmkcHcFzf0BnUpIA0hiUYPmVDU
NhofFZR09/rWclOa/aHkZaMvBIDzABhCP5S3V2uuKeDjTgHv5uiugGYUPO/uCaaS
pKdlK44jjH0BpdOlgRII2avJfeMHdrkc0wQZXymJRLeoWu+vFEI360losm+UdwEt
UGsPSi3z9JfFZTqpA5OG0KmlcqjLsZqv35vcPyO0t77vutGoW5p+eHqmxcBPDuE=
=jlZc
-----END PGP SIGNATURE-----

--n1qLTMFqCnDOoPepAMO0FOpXfEgTtL6T9--
