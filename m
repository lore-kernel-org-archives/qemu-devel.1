Received: from eggs.gnu.org ([2001:4830:134:3::10]:36588)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cT7AZ-0003VC-1f
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 08:17:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cT7AU-00064I-0k
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 08:17:55 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:32800)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cT7AT-00062j-QA
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 08:17:49 -0500
Received: by mail-wm0-x242.google.com with SMTP id r144so30779802wme.0
	for <qemu-devel@nongnu.org>; Mon, 16 Jan 2017 05:17:49 -0800 (PST)
Date: Mon, 16 Jan 2017 13:17:44 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170116131744.GB14681@stefanha-x1.localdomain>
References: <20161223182641.2718-1-pbonzini@redhat.com>
	<20161223182641.2718-4-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CUfgB8w4ZwR/yMy5"
Content-Disposition: inline
In-Reply-To: <20161223182641.2718-4-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/3] nbd: do not block on partial reply
 header reads
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org


--CUfgB8w4ZwR/yMy5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 23, 2016 at 07:26:41PM +0100, Paolo Bonzini wrote:
> @@ -65,54 +67,34 @@ static void nbd_teardown_connection(BlockDriverState =
*bs)
>      client->ioc =3D NULL;
>  }
> =20
> -static void nbd_reply_ready(void *opaque)
> +static void nbd_read_reply_entry(void *opaque)

Please use the coroutine_fn attribute on all functions that must be
called from coroutine context.

--CUfgB8w4ZwR/yMy5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYfMf4AAoJEJykq7OBq3PIotwIALMKPnQiTk7o7TuiaskXY1bq
xS2D1SGggryIqqisEYwRutv6pUB1M/DMbatalD2Lv62aEhHIjsu80lSt4qYQXG3W
B+5KxGlyS8j2OFQhbKvhxE/I83WQ9AyY/LGBzu3ZA7P6Qjs+ni2TIyLztWHZJv+5
VohRqJEIv07M/xjfS3IXAd29NayhgnGIeTyp3C5QRPhBUWARlECzptlS/o8EkXhl
lWZOdkbYI3m9Nnhgmx5WqsVE2UtMX7+42T/+s/YXt7Ym0roXmXZEYQM+db7J2fgT
3nslISJBUpvOqPIzK+Ggh0oI1xchyY5isvipurBHOAUvn4ibFsQtWxWlUpV4OGQ=
=50o4
-----END PGP SIGNATURE-----

--CUfgB8w4ZwR/yMy5--
