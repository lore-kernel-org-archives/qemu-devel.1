Received: from eggs.gnu.org ([2001:4830:134:3::10]:60527)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dc6r8-0007zn-U1
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 05:19:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dc6r3-0008DB-SQ
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 05:19:18 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:36499)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dc6r3-0008An-Ls
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 05:19:13 -0400
Received: by mail-wm0-x244.google.com with SMTP id d40so5745131wma.3
	for <qemu-devel@nongnu.org>; Mon, 31 Jul 2017 02:19:12 -0700 (PDT)
Date: Mon, 31 Jul 2017 10:19:08 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170731091908.GB11830@stefanha-x1.localdomain>
References: <20170729131159.24949-1-vsementsov@virtuozzo.com>
	<20170729131159.24949-2-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rJwd6BRFiFCcLxzm"
Content-Disposition: inline
In-Reply-To: <20170729131159.24949-2-vsementsov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/4] coding_style: add point about 0x in
 trace-events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, eblake@redhat.com, mreitz@redhat.com, jsnow@redhat.com, den@openvz.org, peter.maydell@linaro.org, berrange@redhat.com


--rJwd6BRFiFCcLxzm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 29, 2017 at 04:11:56PM +0300, Vladimir Sementsov-Ogievskiy wrot=
e:
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  CODING_STYLE | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>=20
> diff --git a/CODING_STYLE b/CODING_STYLE
> index 2fa0c0b65b..2e6a0507be 100644
> --- a/CODING_STYLE
> +++ b/CODING_STYLE
> @@ -123,3 +123,26 @@ We use traditional C-style /* */ comments and avoid =
// comments.
> =20
>  Rationale: The // form is valid in C99, so this is purely a matter of
>  consistency of style. The checkpatch script will warn you about this.
> +
> +8. trace-events style
> +
> +In trace-events files use '0x' prefix to specify hex numbers, as in:

s/use '0x' prefix/use a '0x' prefix/

> +
> +some_trace(unsigned x, uint64_t y) "x 0x%x y 0x" PRIx64
> +
> +The exclusion is a group of numbers, separated by symbols '.', '/', ':',=
 ' ':

A little bit more background helps make this exception clearer:

"An exception is made for groups of numbers that are hexadecimal by
convention and separated by the symbols '.', '/', ':', or ' ' (such as
PCI bus addresses):"

> +
> +some_other_trace(unsigned a, unsigned b, unsigned c) "num %x.%x.%x"
> +
> +However, you can use '0x' for such groups if you want. Anyway, be sure t=
hat
> +it is obvious that numbers are in hex, ex.:
> +
> +data_dump(uint8_t c1, uint8_t c2, uint8_t c3) "bytes (in hex): %02x %02x=
 %02x"
> +
> +For consistency do not use printf flag '#', like '%#x'.
> +
> +Rationale: hex numbers are hard to read in logs when there no 0x prefix,

s/there no/there is no/

> +especially when (occasionally) the representation doesn't contain any le=
tters
> +and especially in one line with other decimal numbers. Number groups are
> +allowed to not use '0x' because for some things notations like %x.%x.%x =
are
> +used not only in Qemu. Also dumping raw data bytes with '0x' is less rea=
dable.
> --=20
> 2.11.1
>=20

--rJwd6BRFiFCcLxzm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZfvYMAAoJEJykq7OBq3PIkeIH/3a/OQmdniSmJf/oVXlHeQpn
eXAO5NNzibqmryaGQI7puIx53AwKwd8MMnprSyp4IDRqFix5V4dGzAKaY7w662C8
svmZnTDjkwWekBCnpduieEeBKjDmPwMiNhPjZjfFOEU4wUJiKp0xr+sKWsltNgIB
7kvTs5HJXKO5PDNlg82wO8gOAcMiTMlTa7hthrbJkITo0cw3rdGAYYQ0W/Q3NXB0
okZ1QCvjaJeCaupieJRXSsd+YCZ0Y6iRjbGrHTaLkAu5ulc5+JzIftJtvH+r6XKd
4nvWOwa2cQ8gt7m7VJWhUPlBdzb9sngDUE+KO4G3WZoXBakbw9BqP9fyjgm57JY=
=SkGt
-----END PGP SIGNATURE-----

--rJwd6BRFiFCcLxzm--
