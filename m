Received: from eggs.gnu.org ([209.51.188.92]:44089)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gzQ4s-00042g-4I
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 13:06:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gzQ4r-0005WF-6b
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 13:06:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54300)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gzQ4q-0005Ub-IJ
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 13:06:37 -0500
Date: Thu, 28 Feb 2019 18:06:29 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190228180629.GI9217@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <155136636659.26299.15306206822524053043.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <155136636659.26299.15306206822524053043.stgit@bahia.lan>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] crypto/block: Fix build with gcc 9
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>

On Thu, Feb 28, 2019 at 04:06:06PM +0100, Greg Kurz wrote:
> Build fails with gcc 9:
>=20
> crypto/block-luks.c:689:18: error: taking address of packed member of =E2=
=80=98struct QCryptoBlockLUKSHeader=E2=80=99 may result in an unaligned p=
ointer value [-Werror=3Daddress-of-packed-member]
>   689 |     be32_to_cpus(&luks->header.payload_offset);
>       |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> crypto/block-luks.c:690:18: error: taking address of packed member of =E2=
=80=98struct QCryptoBlockLUKSHeader=E2=80=99 may result in an unaligned p=
ointer value [-Werror=3Daddress-of-packed-member]
>   690 |     be32_to_cpus(&luks->header.key_bytes);
>       |                  ^~~~~~~~~~~~~~~~~~~~~~~
> crypto/block-luks.c:691:18: error: taking address of packed member of =E2=
=80=98struct QCryptoBlockLUKSHeader=E2=80=99 may result in an unaligned p=
ointer value [-Werror=3Daddress-of-packed-member]
>   691 |     be32_to_cpus(&luks->header.master_key_iterations);
>       |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>=20
> ... a bunch of similar errors...
>=20
> crypto/block-luks.c:1288:22: error: taking address of packed member of =
=E2=80=98struct QCryptoBlockLUKSKeySlot=E2=80=99 may result in an unalign=
ed pointer value [-Werror=3Daddress-of-packed-member]
>  1288 |         be32_to_cpus(&luks->header.key_slots[i].stripes);
>       |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
>=20
> All members of the QCryptoBlockLUKSKeySlot and QCryptoBlockLUKSHeader a=
re
> naturally aligned and we already check at build time there isn't any
> unwanted padding. Drop the QEMU_PACKED attribute.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  crypto/block-luks.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

I'll queue this one.


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
