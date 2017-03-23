Received: from eggs.gnu.org ([2001:4830:134:3::10]:60878)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cr0vr-0000Qu-Ga
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 07:29:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cr0vm-0002P8-Jg
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 07:29:31 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:36289)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cr0vm-0002Np-De
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 07:29:26 -0400
Received: by mail-wm0-x241.google.com with SMTP id x124so15954721wmf.3
	for <qemu-devel@nongnu.org>; Thu, 23 Mar 2017 04:29:26 -0700 (PDT)
Date: Thu, 23 Mar 2017 11:29:22 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170323112922.GB12560@stefanha-x1.localdomain>
References: <148900626714.27090.1616990932333159904.stgit@brijesh-build-machine>
	<148900628810.27090.3461280348833651824.stgit@brijesh-build-machine>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uZ3hkaAS1mZxFaxD"
Content-Disposition: inline
In-Reply-To: <148900628810.27090.3461280348833651824.stgit@brijesh-build-machine>
Subject: Re: [Qemu-devel] [RFC PATCH v4 02/20] memattrs: add debug attribute
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Brijesh Singh <brijesh.singh@amd.com>
Cc: ehabkost@redhat.com, crosthwaite.peter@gmail.com, armbru@redhat.com, mst@redhat.com, p.fedin@samsung.com, qemu-devel@nongnu.org, lcapitulino@redhat.com, pbonzini@redhat.com, rth@twiddle.net, Thomas.Lendacky@amd.com


--uZ3hkaAS1mZxFaxD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 08, 2017 at 03:51:28PM -0500, Brijesh Singh wrote:
> Add a new debug attribute, the attribute should be set when guest memory
> accesses are performed for debug purposes.
> The attribute will be used in SEV guest, where we need to distinguish nor=
mal
> vs debug access to guest memory. In debug mode, we need to use SEV comman=
ds
> to access the guest memory.
>=20
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> ---
>  include/exec/memattrs.h |    4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/include/exec/memattrs.h b/include/exec/memattrs.h
> index e601061..b802073 100644
> --- a/include/exec/memattrs.h
> +++ b/include/exec/memattrs.h
> @@ -37,6 +37,8 @@ typedef struct MemTxAttrs {
>      unsigned int user:1;
>      /* Requester ID (for MSI for example) */
>      unsigned int requester_id:16;
> +    /* Memory access for debug purposes */

What does "debug purposes" mean?  gdbstub?  Can the guest initiate debug
memory accesses or is the purely QEMU-internal?

> +    unsigned int debug:1;
>  } MemTxAttrs;
> =20
>  /* Bus masters which don't specify any attributes will get this,
> @@ -46,4 +48,6 @@ typedef struct MemTxAttrs {
>   */
>  #define MEMTXATTRS_UNSPECIFIED ((MemTxAttrs) { .unspecified =3D 1 })
> =20
> +/* Access the guest memory for debug purposes */
> +#define MEMTXATTRS_DEBUG ((MemTxAttrs) { .debug =3D 1 })
>  #endif
>=20
>=20

--uZ3hkaAS1mZxFaxD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY07GSAAoJEJykq7OBq3PIh1IH/jjXVEz0QDnBNUb/DzXyfi8c
+gOk2UZpkQLUxNH1o/kOvJt3pX8AZe2pQiuYdaxbARCPeCozv10iO2cDnIFp5UJ7
a4kR1KF5qwh0CqZV4cG55ZJzytcEv9L6X3HPxQuOozSLOqG/ocW4UzbW6P2vzdNP
Bs1VFlue/XDOMZZch0+FEUK6wxIuy9bYC2MSKA51bwcCFdn+nYt4HR6LSX++lrKZ
yvuEDsnBrfKjU0abo9houW0OeaAoBX4pKobI676OlMORNAsr+BvHzaa+sxEKfPL4
Klk6zrSSk86j3d+zADMKOc/G/SdJn9aP/fBFmtfbKkyCRL8vSZqYb+B5RNnAkBA=
=19K8
-----END PGP SIGNATURE-----

--uZ3hkaAS1mZxFaxD--
