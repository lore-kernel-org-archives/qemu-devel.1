Received: from eggs.gnu.org ([209.51.188.92]:33868)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hAuZv-0005Mo-Mm
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 06:54:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hAuZu-00045X-PH
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 06:54:11 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:36613)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1hAuZu-000453-FU
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 06:54:10 -0400
Received: by mail-wr1-x441.google.com with SMTP id y13so11408459wrd.3
	for <qemu-devel@nongnu.org>; Mon, 01 Apr 2019 03:54:10 -0700 (PDT)
Date: Mon, 1 Apr 2019 10:15:21 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190401091521.GC643@stefanha-x1.localdomain>
References: <20190331083917.32176-1-n.alekseev2104@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mvpLiMfbWzRoNl4x"
Content-Disposition: inline
In-Reply-To: <20190331083917.32176-1-n.alekseev2104@gmail.com>
Subject: Re: [Qemu-devel] [PATCH] Add coroutine_fn to bdrv_check_co_entry
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: n.alekseev2104@gmail.com
Cc: qemu-devel@nongnu.org, jusual@mail.ru, kwolf@redhat.com, mreitz@redhat.com


--mvpLiMfbWzRoNl4x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 31, 2019 at 11:39:17AM +0300, n.alekseev2104@gmail.com wrote:
> From: nickaleks <n.alekseev2104@gmail.com>

Hi Nikita,
Thanks for the patch!  Do you want to adjust your email From field
("nickaleks") so it matches your full name and Signed-off-by ("Nikita
Alekseev")?

Stefan

>=20
> bdrv_check_co_entry calls bdrv_co_check, which is a coroutine function.
> Thus, it also needs to be marked as a coroutine.
>=20
> Signed-off-by: Nikita Alekseev <n.alekseev2104@gmail.com>
> ---
>  block.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/block.c b/block.c
> index 0a93ee9ac8..776c43f177 100644
> --- a/block.c
> +++ b/block.c
> @@ -4121,7 +4121,7 @@ typedef struct CheckCo {
>      int ret;
>  } CheckCo;
> =20
> -static void bdrv_check_co_entry(void *opaque)
> +static void coroutine_fn bdrv_check_co_entry(void *opaque)
>  {
>      CheckCo *cco =3D opaque;
>      cco->ret =3D bdrv_co_check(cco->bs, cco->res, cco->fix);
> --=20
> 2.21.0
>=20

--mvpLiMfbWzRoNl4x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcodapAAoJEJykq7OBq3PIxcUH/35etMIjxs4ZIe/sq1WLWT0c
wfbvYRwkA1nIkB9pd+HNc3JlduJtpKLuo5JZ8Y9VveJ1+OU5Pmmx40mvwxS8QZ5W
TDeFouOCmP3gClv2TFFF15z2IMaxUn3ldlNXCj1Wy0tVdpNH+HhYMbrgsCzF2mKF
Cg3z9n6CmakZkO0Q7c44Y067c8n0ACZNjMZvPJhgZ8m9KeNmXxHfiXBW/lCVKMmQ
MBl6gL1kUGXHEHyHKLaJng0O7Yg0eZqlunPbLmp5MepNlFlRQ84BFRJyFAgHEQ/c
CzDQ68vecY+TKpwt6/i6oc2chFn7QlaLlihsc6UVzNbF6+MvOfXMw4h5+7jWb/I=
=sL8p
-----END PGP SIGNATURE-----

--mvpLiMfbWzRoNl4x--
