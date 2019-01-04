Received: from eggs.gnu.org ([208.118.235.92]:34128)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gfVt0-0002qJ-6f
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 15:16:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gfVsw-0004Pn-VM
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 15:16:06 -0500
References: <20190104181208.7809-1-philmd@redhat.com>
	<20190104181208.7809-3-philmd@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <791f6b8e-c488-7d72-956f-91e9748c74b8@redhat.com>
Date: Fri, 4 Jan 2019 14:15:49 -0600
MIME-Version: 1.0
In-Reply-To: <20190104181208.7809-3-philmd@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="U6mMksGBEI6Y1Yf8MkJsA8179rEGiP5wO"
Subject: Re: [Qemu-devel] [PATCH v2 2/3] util/cutils: Move ctype macros to
 "cutils.h"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-devel@nongnu.org
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, qemu-trivial@nongnu.org, Cornelia Huck <cohuck@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Markus Armbruster <armbru@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Paolo Bonzini <pbonzini@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, Richard Henderson <rth@twiddle.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--U6mMksGBEI6Y1Yf8MkJsA8179rEGiP5wO
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 David Hildenbrand <david@redhat.com>, qemu-trivial@nongnu.org,
 Cornelia Huck <cohuck@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Markus Armbruster <armbru@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefano Garzarella
 <sgarzare@redhat.com>, Richard Henderson <rth@twiddle.net>
Message-ID: <791f6b8e-c488-7d72-956f-91e9748c74b8@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/3] util/cutils: Move ctype macros to
 "cutils.h"
References: <20190104181208.7809-1-philmd@redhat.com>
 <20190104181208.7809-3-philmd@redhat.com>
In-Reply-To: <20190104181208.7809-3-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/4/19 12:12 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> Introduced in cd390083ad1, these macros don't need to be in
> a generic header.
> Add documentation to justify their use.
>=20
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---

> +++ b/include/qemu/cutils.h
> @@ -3,6 +3,31 @@
> =20
>  #include "qemu/fprintf-fn.h"
> =20
> +/**
> + * unsigned ctype macros:
> + *
> + * The standards require that the argument for these functions
> + * is either EOF or a value that is representable in the type
> + * unsigned char. If the argument is of type char, it must be
> + * cast to unsigned char. This is what these macros do,
> + * avoiding 'signed to unsigned' conversion warnings.

I would also mention that these macros are ONLY intended for use with
char arguments (as they CANNOT handle EOF); if you are doing int c =3D
getchar() or similar, you still want to call the original ctype macro.

Otherwise, the move and added comments makes sense to me.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--U6mMksGBEI6Y1Yf8MkJsA8179rEGiP5wO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEY3OaSlgimHGqKqRv3g5py3orov0FAlwvvvYACgkQ3g5py3or
ov2lOAf+PRxOQGnw4rAIKrcvzydUFWGyTLA1OaZtrGLjtgMQdDviQK4sP35+Or0i
TKS5PUHLmWtOY2TP+ABlaF8elTfL7p5XX8QAMPrPhQvp3uk+SLCC1GMdfKhNKJc4
s2l8zZh+y6qMCJWzQlsYavle1BdLvGcZWLLC+hQJfwghPODxnQgk/bkzJKvYjQr4
NVQ1kSigVcy4j3yOOF4aE2W14ikvbr8nDRVeSrfrD4/p34tYutBlKV2YLCMO9PN2
zS2P1JRYcnQVWpgAqSbkaJOplG+G0u+4av0Bf50reNpOoYyIghJ8qE4TftODBq9j
J3AB1gyTMf/cqTp/DLkLW6VAdkHhhw==
=vrPr
-----END PGP SIGNATURE-----

--U6mMksGBEI6Y1Yf8MkJsA8179rEGiP5wO--
