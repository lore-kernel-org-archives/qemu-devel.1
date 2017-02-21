Received: from eggs.gnu.org ([2001:4830:134:3::10]:35333)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cgD2P-0001Pm-Am
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 11:11:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cgD2M-0005AN-1O
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 11:11:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54578)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cgD2L-00059x-R8
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 11:11:33 -0500
References: <20170221104256.5153-1-pbonzini@redhat.com>
	<20170221104256.5153-3-pbonzini@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <464bfeb5-2478-14cd-eafd-6594ffc15dc6@redhat.com>
Date: Tue, 21 Feb 2017 10:11:31 -0600
MIME-Version: 1.0
In-Reply-To: <20170221104256.5153-3-pbonzini@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="oS3EQnuDvPMu7GKFDt24EA3t8KItQoeEh"
Subject: Re: [Qemu-devel] [PATCH 2/3] cpu: implement get_crash_info through
 QOM properties
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: anton.nefedov@virtuozzo.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--oS3EQnuDvPMu7GKFDt24EA3t8KItQoeEh
From: Eric Blake <eblake@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: anton.nefedov@virtuozzo.com, den@openvz.org
Message-ID: <464bfeb5-2478-14cd-eafd-6594ffc15dc6@redhat.com>
Subject: Re: [PATCH 2/3] cpu: implement get_crash_info through QOM properties
References: <20170221104256.5153-1-pbonzini@redhat.com>
 <20170221104256.5153-3-pbonzini@redhat.com>
In-Reply-To: <20170221104256.5153-3-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/21/2017 04:42 AM, Paolo Bonzini wrote:
> Provide a generic implementation for all CPU subclasses.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  include/qom/cpu.h |  1 -
>  qom/cpu.c         | 11 ++++-------
>  target/i386/cpu.c |  2 +-
>  3 files changed, 5 insertions(+), 9 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--oS3EQnuDvPMu7GKFDt24EA3t8KItQoeEh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYrGazAAoJEKeha0olJ0NqIXQH/0COVXxdLCKxhwesiaxyPbdN
fCaYR6ByAoufBdcmAYpR0reIy+C4EvCwDbwSQdR/CLLdvRcShXflPKBOZPaJ/PJb
Lqc/XBOjp3vRU/sQZXyaTNbmB+dSq3OsjmQqrAVgjB0aveUpWdJ43Be0Zi5B7Y96
geaYUgtqAKuQOr9vznwniwQNnCWiy2k822WlDXE3CU+ilVRpk2tNGLnRmoFOMN0J
KCQuvk8mOnzyN2B0HUEEf1Eo+SKGlFaIvBvXUVY8Wohb5usZ/4HQLGH0QDQ0Rn+S
i4hebH+mZqJ8hHG/8elu1sgGRvGFdG+eFqBfjLFo1Va8wmBLDrggisxYCdBnnlk=
=P6MD
-----END PGP SIGNATURE-----

--oS3EQnuDvPMu7GKFDt24EA3t8KItQoeEh--
