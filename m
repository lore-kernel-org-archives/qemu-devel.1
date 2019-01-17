Received: from eggs.gnu.org ([209.51.188.92]:44533)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gkBfH-0006Q3-Nv
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 12:41:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gkBfF-00057e-Uc
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 12:41:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52398)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1gkBfF-00054M-O8
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 12:41:13 -0500
Date: Thu, 17 Jan 2019 17:41:09 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190117174109.GA18457@stefanha-x1.localdomain>
References: <20190117161640.5496-1-jusual@mail.ru>
	<20190117161640.5496-4-jusual@mail.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uAKRQypu60I7Lcqm"
Content-Disposition: inline
In-Reply-To: <20190117161640.5496-4-jusual@mail.ru>
Subject: Re: [Qemu-devel] [PATCH v4 3/3] tests/microbit-test: Check nRF51
 UART functionality
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Julia Suvorova <jusual@mail.ru>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, Steffen =?iso-8859-1?Q?G=F6rtz?= <contrib@steffen-goertz.de>


--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 17, 2019 at 07:16:40PM +0300, Julia Suvorova wrote:
> diff --git a/tests/microbit-test.c b/tests/microbit-test.c
> index afeb6b082a..3da6d9529f 100644
> --- a/tests/microbit-test.c
> +++ b/tests/microbit-test.c
> @@ -19,10 +19,93 @@
>  #include "libqtest.h"
> =20
>  #include "hw/arm/nrf51.h"
> +#include "hw/char/nrf51_uart.h"
>  #include "hw/gpio/nrf51_gpio.h"
>  #include "hw/timer/nrf51_timer.h"
>  #include "hw/i2c/microbit_i2c.h"
> =20
> +#include <sys/socket.h>
> +#include <sys/un.h>

=2E/HACKING "1.2. Include directives" requires putting system header
includes (<>) right after #include "qemu/osdep.h".

But are these includes really needed?  This code doesn't use Sockets API
calls like send(2)/recv(2)/shutdown(2) or UNIX Domain Sockets specifics
like struct sockaddr_un.

I suggest dropping these includes (plus they are pulled in implicitly by
osdep.h anyway).

Peter: If there are no other issues with this patch series, could you
remove these two includes when merging?  Thanks!

--uAKRQypu60I7Lcqm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcQL41AAoJEJykq7OBq3PIWIIH/0DoUjtOzkFK4BmRoC/Ndoz6
10SCOqGycu2irvB5Ffvbo31naQ/cPPHYTe+ivPwONOD+eNNw1SPUmUiCqqczs90q
aHILlQ2PrRPV7Jz+OVoCiCZIfyHNS8+dKdmEgaU2cAC87bhxz/SypDKNCnQ/anOQ
eQn1ng4XczlFT2w3adi3lrcH7rgN/pRuDeeCFoKCfKWa3Nd0yQHr2wcvv++o3l58
GtIWw9XNopfsyWlpfLSWYxSe8O3ciM6paBRFsDM5CgWG5AI2oLyYGFMMNU6NGTFy
6Zzmiz40ha2neKIMFPZX9BohpWV/9xH1D2KgrSIuOVmDz3dlXhh9/eArJ4Emsho=
=tgix
-----END PGP SIGNATURE-----

--uAKRQypu60I7Lcqm--
