Received: from eggs.gnu.org ([2001:4830:134:3::10]:47757)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dQgMc-0007GR-Ez
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 16:48:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dQgMY-0000dk-6S
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 16:48:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52066)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dQgMX-0000dQ-Ta
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 16:48:30 -0400
References: <cover.1498761179.git.alistair.francis@xilinx.com>
	<453bac0f21aa525d7c9de38d4c8c509b44c4ecda.1498761179.git.alistair.francis@xilinx.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <df960468-b202-d523-d390-6d246a4091aa@redhat.com>
Date: Thu, 29 Jun 2017 15:48:26 -0500
MIME-Version: 1.0
In-Reply-To: <453bac0f21aa525d7c9de38d4c8c509b44c4ecda.1498761179.git.alistair.francis@xilinx.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="91XUNNmhbVet5SS7ihS8J3vexojhhXS91"
Subject: Re: [Qemu-devel] [RFC v2 3/3] char-socket: Report TCP socket
 waiting as information
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, qemu-devel@nongnu.org
Cc: alistair23@gmail.com, philippe@mathieu-daude.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--91XUNNmhbVet5SS7ihS8J3vexojhhXS91
From: Eric Blake <eblake@redhat.com>
To: Alistair Francis <alistair.francis@xilinx.com>, qemu-devel@nongnu.org
Cc: alistair23@gmail.com, philippe@mathieu-daude.net
Message-ID: <df960468-b202-d523-d390-6d246a4091aa@redhat.com>
Subject: Re: [Qemu-devel] [RFC v2 3/3] char-socket: Report TCP socket waiting
 as information
References: <cover.1498761179.git.alistair.francis@xilinx.com>
 <453bac0f21aa525d7c9de38d4c8c509b44c4ecda.1498761179.git.alistair.francis@xilinx.com>
In-Reply-To: <453bac0f21aa525d7c9de38d4c8c509b44c4ecda.1498761179.git.alistair.francis@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/29/2017 02:42 PM, Alistair Francis wrote:
> When QEMU is waiting for a TCP socket connection it reports that messag=
e as
> an error. This isn't an error it is just informaiton so let's change th=
e
> report to use report() instead.
>=20
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
> ---
>=20
>  chardev/char-socket.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> index ccc499cfa1..ad1b3d6e93 100644
> --- a/chardev/char-socket.c
> +++ b/chardev/char-socket.c
> @@ -765,7 +765,7 @@ static int tcp_chr_wait_connected(Chardev *chr, Err=
or **errp)
>       * in TLS and telnet cases, only wait for an accepted socket */
>      while (!s->ioc) {
>          if (s->is_listen) {
> -            error_report("QEMU waiting for connection on: %s",
> +            report(INFO, "QEMU waiting for connection on: %s",
>                           chr->filename);

Indentation looks off now; I'd scoot chr->filename to live right under IN=
FO.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--91XUNNmhbVet5SS7ihS8J3vexojhhXS91
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZVWeaAAoJEKeha0olJ0NqixkIAIn9vC0UxUoGOiloBdV7ZXIS
Ga2pBM9rIBkGjH5jCmsch9DhspHTEc/9ID1kaebTGaUasEDmK18Txxcyfc7AGajE
HJIPVy5F354XU4LIS9v6amByWol3r4sueCsPFRe4e1tlV6AwaK0QzIq6CtEa/UyM
EM2/qIzk4SZfHZZ90tGl4QcWjpG3otbKINAd6ISqtkBh5EccvBsBzx4BRZth9Hgo
TTjJpQ600q+NS4V/fTleMAlG0Qrak3Mtug81brHwCAHEpbifK6ylE8OCrZwEePCx
ShdzSItTQn+WWENUKU7d5ZULtRdDFIiQDescHiAPOKWe3z1uxsUTg0ow9VynXog=
=FIKo
-----END PGP SIGNATURE-----

--91XUNNmhbVet5SS7ihS8J3vexojhhXS91--
