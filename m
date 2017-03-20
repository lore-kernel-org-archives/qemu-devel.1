Received: from eggs.gnu.org ([2001:4830:134:3::10]:36861)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cpuqw-0001kL-Jd
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 06:47:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cpuqv-00086y-Kq
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 06:47:54 -0400
Date: Mon, 20 Mar 2017 10:47:43 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170320104743.GE17887@stefanha-x1.localdomain>
References: <20170313214001.26339-1-mreitz@redhat.com>
	<20170313214045.26857-2-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="G6nVm6DDWH/FONJq"
Content-Disposition: inline
In-Reply-To: <20170313214045.26857-2-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10 04/16] qemu-img: Expose
 PreallocMode for resizing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org


--G6nVm6DDWH/FONJq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 13, 2017 at 10:40:33PM +0100, Max Reitz wrote:
> @@ -3429,8 +3442,16 @@ static int img_resize(int argc, char **argv)
>          goto out;
>      }
> =20
> +    current_size =3D blk_getlength(blk);
> +    if (current_size < 0) {
> +        error_report("Failed to inquire current image length: %s\n",

Spurious newline, error_report() doesn't need it.

--G6nVm6DDWH/FONJq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYz7NPAAoJEJykq7OBq3PIPS8H/Rn7W1wDAeokLuqTWr3iJ2o9
WH+qc63rXI7k7jxXPtyYmr6CSPh/JAm2pbeIj0ZYUvg4r6zo0B/83vZ5YMblBOwq
LmWuqO07i5IF/l3C9vJGmJFrFLAbOhf8UwqfdepYYKmg47KVtUdkO7cVRG3TECHk
/fmal6N2lMckrnXxXze20D7/Aa8EYUL968Ci2ELWJZO3rUAgxpXfN0zG43FwO1KI
05OuoO/YtCDFHR7T+iZoAhJP03GPeA9J5wuCA9Np5C262Rja/VaxZsj8IksDOUWc
Df/Kl3m0joKp6MeMbB9vOqvH8/bFcESMKW4sgJTxZK98QIMPgp77jaRnggkdzvs=
=VcRb
-----END PGP SIGNATURE-----

--G6nVm6DDWH/FONJq--
