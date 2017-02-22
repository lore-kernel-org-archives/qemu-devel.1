Received: from eggs.gnu.org ([2001:4830:134:3::10]:51517)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cgYbh-0001fV-RG
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 10:13:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cgYbe-0002gU-Nt
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 10:13:29 -0500
Date: Wed, 22 Feb 2017 15:13:22 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170222151322.GC10201@stefanha-x1.localdomain>
References: <20170217194028.8398-1-pbonzini@redhat.com>
	<20170217194028.8398-3-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vEao7xgI/oilGqZ+"
Content-Disposition: inline
In-Reply-To: <20170217194028.8398-3-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 2/3] nfs: do not use
 aio_context_acquire/release
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org


--vEao7xgI/oilGqZ+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 17, 2017 at 08:40:27PM +0100, Paolo Bonzini wrote:
> @@ -343,12 +350,14 @@ static int coroutine_fn nfs_co_flush(BlockDriverSta=
te *bs)
> =20
>      nfs_co_init_task(bs, &task);
> =20
> +    qemu_mutex_lock(&client->mutex);
>      if (nfs_fsync_async(client->context, client->fh, nfs_co_generic_cb,
>                          &task) !=3D 0) {
>          return -ENOMEM;

Missing qemu_mutex_unlock().

--vEao7xgI/oilGqZ+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYraqSAAoJEJykq7OBq3PI47sIAJm2xkkxY6+knx+7EAiTwqkU
0Wb/Vq+4I6I6PlutOvC1+wNCkAyYeOmLrMwNikjFecz1uYcuWIjnb2eFjUILsEpa
L67Ip2eH+9Kti1CzpTQCchSDvd8Io7TUpQrFd7c0cYuBO4rW+6Eij/+1kpJ5X33R
l0rGJy6UYbpojMjJSwoSSR6lkFy7LV20z/9LA/G/RNLekf4mIj8X9G2VphQh15t0
F5IaJjChpKETBkvBpMGf24SC7sL2AxC++O7B48Eh1Y0+bgpzaHXKFLsemC8XoWVh
uhA2K2IAmlEYciM8sm7on8rCTRa3EU1YHpplJ14XF0WGssNlVsoZuzCSM0em02A=
=GIKQ
-----END PGP SIGNATURE-----

--vEao7xgI/oilGqZ+--
