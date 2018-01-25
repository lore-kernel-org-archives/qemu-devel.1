Received: from eggs.gnu.org ([2001:4830:134:3::10]:57556)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eeoHK-0004UQ-BC
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 15:37:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eeoHG-0007R4-Av
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 15:37:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57498)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eeoHG-0007QQ-2v
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 15:37:42 -0500
References: <1516898620-9486-1-git-send-email-a.perevalov@samsung.com>
	<CGME20180125164415eucas1p11691d02bf89c112ff25cfc43c400b5b2@eucas1p1.samsung.com>
	<1516898620-9486-2-git-send-email-a.perevalov@samsung.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1dbf8f1d-2b4a-6ad3-9c84-619d42f2be33@redhat.com>
Date: Thu, 25 Jan 2018 14:37:33 -0600
MIME-Version: 1.0
In-Reply-To: <1516898620-9486-2-git-send-email-a.perevalov@samsung.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="0GPnLwJtwBNY2rOzLsBW4dieSoxa6o27w"
Subject: Re: [Qemu-devel] [PATCH v1] migration: change blocktime type to
 uint32_t
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Perevalov <a.perevalov@samsung.com>, qemu-devel@nongnu.org, dgilbert@redhat.com
Cc: lvivier@redhat.com, quintela@redhat.com, ash.billore@samsung.com, f4bug@amsat.org, peterx@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0GPnLwJtwBNY2rOzLsBW4dieSoxa6o27w
From: Eric Blake <eblake@redhat.com>
To: Alexey Perevalov <a.perevalov@samsung.com>, qemu-devel@nongnu.org,
 dgilbert@redhat.com
Cc: lvivier@redhat.com, quintela@redhat.com, ash.billore@samsung.com,
 f4bug@amsat.org, peterx@redhat.com
Message-ID: <1dbf8f1d-2b4a-6ad3-9c84-619d42f2be33@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v1] migration: change blocktime type to
 uint32_t
References: <1516898620-9486-1-git-send-email-a.perevalov@samsung.com>
 <CGME20180125164415eucas1p11691d02bf89c112ff25cfc43c400b5b2@eucas1p1.samsung.com>
 <1516898620-9486-2-git-send-email-a.perevalov@samsung.com>
In-Reply-To: <1516898620-9486-2-git-send-email-a.perevalov@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/25/2018 10:43 AM, Alexey Perevalov wrote:
> Initially int64_t was used, but on PowerPC architecture,
> clang doesn't have atomic_*_8 function, so it produces
> link time error.
>=20
> QEMU is working with time as with 64bit value, but by
> fact 32 bit is enough with CLOCK_REALTIME. In this case
> blocktime will keep only 1200 hours time interval.
>=20
> Signed-off-by: Alexey Perevalov <a.perevalov@samsung.com>
> ---

> +++ b/qapi/migration.json
> @@ -175,8 +175,8 @@
>             '*setup-time': 'int',
>             '*cpu-throttle-percentage': 'int',
>             '*error-desc': 'str',
> -           '*postcopy-blocktime' : 'int64',
> -           '*postcopy-vcpu-blocktime': ['int64']} }
> +           '*postcopy-blocktime' : 'uint32',
> +           '*postcopy-vcpu-blocktime': ['uint32']} }

Questionable to change types if this had been released already - but
these fields are marked 'since 2.12' so you can change them at will up
until the release.

Acked-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--0GPnLwJtwBNY2rOzLsBW4dieSoxa6o27w
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpqQA0ACgkQp6FrSiUn
Q2pXNAf/ax9QbRkXPFujEU+1/CIDFMTs7A3MR0HGcSpvUQNAxgiuPjc/dL+U4bsH
mWo7kJCgSrOqWGh4kaRJU/b9G29YTe8OING8JGAe19o2xpVVYW09Ez4jKNm9lLEm
CUc0ALTyI5evbgCbIGpjdlREPxlHv5uGR6yshJTWxlL2ce++1zm8a1KlFnOMrW6J
krDxnoYMJRhhVRmSVXww8KTysyX0vo/Ln1AWl+y7erS+/fGoL3j3P1K11Ck8jfp0
GKvN2O8Zo3l3L1zLieZI1Lwfj0JxQnMuHN1IjS4JY9Wp+9bl9jOymlHlyBnEPtee
2fvEIN1waLITsWi+5Wh9zCNBsArRmA==
=vKSO
-----END PGP SIGNATURE-----

--0GPnLwJtwBNY2rOzLsBW4dieSoxa6o27w--
