Received: from eggs.gnu.org ([2001:4830:134:3::10]:43653)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cojWD-0007EO-TC
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 00:29:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cojW9-0001P2-PD
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 00:29:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36200)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cojW9-0001Ob-IW
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 00:29:33 -0400
Date: Fri, 17 Mar 2017 12:29:26 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170317042926.GD7540@stefanha-x1.localdomain>
References: <1489642893-4504-1-git-send-email-rimjhim0107@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8nsIa27JVQLqB7/C"
Content-Disposition: inline
In-Reply-To: <1489642893-4504-1-git-send-email-rimjhim0107@gmail.com>
Subject: Re: [Qemu-devel] [PATCH v2] puv3: always compile-check debug printf
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anishka0107 <rimjhim0107@gmail.com>
Cc: qemu-devel@nongnu.org, jsnow@redhat.com


--8nsIa27JVQLqB7/C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 16, 2017 at 11:11:33AM +0530, Anishka0107 wrote:
>      To prevent bitrot of the format string of the debug statement, files=
 with
>      conditional debug statements should ensure that printf is compiled a=
lways,
>      and enclosed within if(0) statements and not in #ifdef.
>=20
> Signed-off-by: Anishka Gupta <rimjhim0107@gmail.com>
> ---
>  include/hw/unicore32/puv3.h | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/include/hw/unicore32/puv3.h b/include/hw/unicore32/puv3.h
> index e268484..9fdf0a1 100644
> --- a/include/hw/unicore32/puv3.h
> +++ b/include/hw/unicore32/puv3.h
> @@ -46,8 +46,7 @@
>  #define DPRINTF(fmt, ...)
>      if (DEBUG_PUV3) {
>          fprintf(stderr, "%s: " fmt , __func__, ## __VA_ARGS__)
> -    }
> -    else {
> +    } else {

Hi Anishka,
I think something went wrong with this patch submission.  The patch
seems to fix coding style but the surrounding code is not in qemu.git.
Please send another revision with your full code changes.

I also notice that the macro in the surrounding code will not work: you
need to use backslash ('\') so the preprocessor joins lines:

#define foo(x) \
    do { \
        printf("foo %d\n", x); \
    } while (0)

If you forget the backslashes there will be compilation errors.

Stefan

--8nsIa27JVQLqB7/C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYy2YmAAoJEJykq7OBq3PINfcIAIX+/uIoTyl1puldKnViXDSw
Nv294vBgDGtUbGAaw6HVlq0krfAFkhzHgIgB2B63PkM7Sw12djxVAZSoYGTSkpyX
ss70cfHE094B7x/cnRyUQ9Gjqf5RLWp1kY8yDmkfdfclBZGXys+s0Fm4XZQcG4Jm
f63mUVp5s4eqpF+1f9kXheZqWZh6a8ClKgkNPhfqzYGsGsTSD7qKZB1el6ZmfNMp
rbe8RsMYfI2LQlGWmNPWfyBwM/rbQGpY1PHQ9fgyAbnVphNaaev2S2upKf3CEOBI
bLnDyL95LDDtb5CYCNGNESHd22aBOberNqdFw3Kxugth8imIcCeAkTHc2YY36HY=
=QrsB
-----END PGP SIGNATURE-----

--8nsIa27JVQLqB7/C--
