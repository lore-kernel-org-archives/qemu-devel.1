Received: from eggs.gnu.org ([209.51.188.92]:35382)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gmc8N-00035S-D5
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 05:21:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gmbtO-0004JF-H9
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 05:05:52 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:56015)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1gmbtM-0003kU-HB
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 05:05:49 -0500
Received: by mail-wm1-x342.google.com with SMTP id y139so2409700wmc.5
	for <qemu-devel@nongnu.org>; Thu, 24 Jan 2019 02:05:35 -0800 (PST)
Date: Thu, 24 Jan 2019 10:05:32 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190124100532.GB4764@stefanha-x1.localdomain>
References: <20190122143113.20331-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="p4qYPpj5QlsIQJ0K"
Content-Disposition: inline
In-Reply-To: <20190122143113.20331-1-vsementsov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH] qemu-coroutine-sleep: drop CoSleepCB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, stefanha@redhat.com


--p4qYPpj5QlsIQJ0K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 22, 2019 at 05:31:13PM +0300, Vladimir Sementsov-Ogievskiy wrot=
e:
> Drop CoSleepCB structure. It's actually unused.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  util/qemu-coroutine-sleep.c | 27 ++++++++++-----------------
>  1 file changed, 10 insertions(+), 17 deletions(-)

Thanks, applied to my block tree:
https://github.com/stefanha/qemu/commits/block

Stefan

--p4qYPpj5QlsIQJ0K
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcSY3sAAoJEJykq7OBq3PI460H/isWe5o0jrpZu93CJ9IWZCDQ
H4g556Z42TBR9aFcmqx6aMz9Rugt9QYJI58dG6Myy46JCeffgpGnsjCZK3aqpv3v
G6hCVLRH3gmvjdt+nmZ+eHjrycb48mnrCo/UYj3kMi6GowApHh/kZa0THZa9EXvR
Tvp/THoPUGU8SUtfqaavab5POlQbVZMd9oMVRHUV3M12BmNgeXF02aYbHQbgiwHI
t2Pbhl8V0vMXSal/vGJLXOLBl45a7+dDEaCrc+YI0ygSwltBPMgISPRRpAVoFKHU
zPLNNJ397lW9elRiNHiwozhdfP2UuQIC2pW+uZ2WBUiYVFZVJR0HNigKJsrMxwE=
=y7NG
-----END PGP SIGNATURE-----

--p4qYPpj5QlsIQJ0K--
