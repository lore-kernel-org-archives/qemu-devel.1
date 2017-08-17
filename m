Received: from eggs.gnu.org ([2001:4830:134:3::10]:41983)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1diNgO-0000yK-E9
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 12:30:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1diNgI-0006tN-He
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 12:30:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49898)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1diNgI-0006sU-8L
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 12:30:02 -0400
References: <1502986453-223221-1-git-send-email-imammedo@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2867854c-9a4d-03dd-ec3f-d13c8618f1b4@redhat.com>
Date: Thu, 17 Aug 2017 11:29:59 -0500
MIME-Version: 1.0
In-Reply-To: <1502986453-223221-1-git-send-email-imammedo@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="JIjIpTCXcNMqGfmG8sI2wsRuGUTb6u3nJ"
Subject: Re: [Qemu-devel] [PATCH for-2.10???] fix build failure in
 nbd_read_reply_entry()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, kwolf@redhat.com, mreitz@redhat.com, peter.maydell@linaro.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JIjIpTCXcNMqGfmG8sI2wsRuGUTb6u3nJ
From: Eric Blake <eblake@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, kwolf@redhat.com, mreitz@redhat.com,
 peter.maydell@linaro.org
Message-ID: <2867854c-9a4d-03dd-ec3f-d13c8618f1b4@redhat.com>
Subject: Re: [PATCH for-2.10???] fix build failure in nbd_read_reply_entry()
References: <1502986453-223221-1-git-send-email-imammedo@redhat.com>
In-Reply-To: <1502986453-223221-1-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/17/2017 11:14 AM, Igor Mammedov wrote:
> travis builds fail at HEAD at rc3 master with
>=20
>   block/nbd-client.c: In function =E2=80=98nbd_read_reply_entry=E2=80=99=
:
>   block/nbd-client.c:110:8: error: =E2=80=98ret=E2=80=99 may be used un=
initialized in this function [-Werror=3Duninitialized]
>=20
> fix it by initializing 'ret' to 0
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  block/nbd-client.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

I concur that it is a false positive, introduced by commit 72b6ffc7; and
that it should not affect tarball builds where we do not default to
turning on -Werror (other than an annoying warning). This feels to me to
be in the same category as a couple other patches we have already
identified, where it doesn't deserve spinning up -rc4 by itself, but if
we do have a major bug to fix, then including this one at the same time
is fine.

I'll defer to Peter's judgment on whether to apply it for 2.10;
meanwhile, I'll stick it on my NBD tree for 2.11 if it does not get
applied for 2.10.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--JIjIpTCXcNMqGfmG8sI2wsRuGUTb6u3nJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmVxIcACgkQp6FrSiUn
Q2p57wf8CoEeqCo2CfSu0odAyeSxFRsOa6hmjyllIr2CswwHII2axx7G9lWol0Zv
yWfZVyiSaluDGPmY7KkBQswINxPSxlDWCFg/BQ6lsQL97O8ueQfSLx0MieiFpCqI
0PPpMfxKr2d1ZxZ3YCnJrrsufdjOcXL59+8Gz68AKyUwIHi/sZ/HsdR9Yi7pN4aj
EJmh/F2gYw7urPwza4wLwXUIRslHB/vgsp7+lDt7pkAFFRXSAiq09LUefhJH+lnl
g0guancKilHy80VYIVrMyjQo2esoY4qh9DdvYxW7BVdYt4nWBc5y2rFqLEKMtAQX
1Aemb1BGFETTQ/4OjQljCTMulm3bmg==
=pzq/
-----END PGP SIGNATURE-----

--JIjIpTCXcNMqGfmG8sI2wsRuGUTb6u3nJ--
