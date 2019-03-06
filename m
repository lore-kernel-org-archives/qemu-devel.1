Received: from eggs.gnu.org ([209.51.188.92]:47888)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1h1THn-0006JH-Ha
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 04:56:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1h1THm-0002wq-LW
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 04:56:27 -0500
Date: Wed, 6 Mar 2019 09:56:15 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190306095615.GG22159@stefanha-x1.localdomain>
References: <5310bd5d152fa36c1828a7cbd19fc893739d1609.camel@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nqkreNcslJAfgyzk"
Content-Disposition: inline
In-Reply-To: <5310bd5d152fa36c1828a7cbd19fc893739d1609.camel@gmail.com>
Subject: Re: [Qemu-devel] [PATCH v4] thunk: fix of malloc to g_new
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Riku Voipio <riku.voipio@iki.fi>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>, Julia Suvorova <jusual@mail.ru>, Peter Maydell <peter.maydell@linaro.org>, Aarushi Mehta <mehta.aaru20@gmail.com>


--nqkreNcslJAfgyzk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 02, 2019 at 01:22:29AM +0530, Aarushi Mehta wrote:
> From 3c1cba63dc5070ab559a126e206557f27fbaea59 Mon Sep 17 00:00:00 2001
> From: Aarushi Mehta <mehta.aaru20@gmail.com>
> Date: Sat, 2 Mar 2019 01:11:42 +0530
> Subject: [PATCH v4] thunk: fix of malloc to g_new
>=20
> Note that since thunking occurs throughout the lifetime of the QEMU
> instance, there is no matching 'free' to correct.
>=20
> Signed-off-by: Aarushi Mehta <mehta.aaru20@gmail.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  thunk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Riku: Will you send a pull request?  Otherwise Peter might be willing to
merge this patch through his tree.

> diff --git a/thunk.c b/thunk.c
> index d5d8645cd4..17f3d320bb 100644
> --- a/thunk.c
> +++ b/thunk.c
> @@ -89,7 +89,7 @@ void thunk_register_struct(int id, const char *name, co=
nst argtype *types)
>      for(i =3D 0;i < 2; i++) {
>          offset =3D 0;
>          max_align =3D 1;
> -        se->field_offsets[i] =3D malloc(nb_fields * sizeof(int));
> +        se->field_offsets[i] =3D g_new(int, nb_fields);
>          type_ptr =3D se->field_types;
>          for(j =3D 0;j < nb_fields; j++) {
>              size =3D thunk_type_size(type_ptr, i);
> --=20
> 2.17.1
>=20
>=20

--nqkreNcslJAfgyzk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcf5k/AAoJEJykq7OBq3PIIQgIAJ/fDj7VduzmgJ0GQy8mUTuN
4RiInNRekzR1TcaR2xwhajma2Wy9homjS0/GQCeNi+hCFk2eXAp/Rpd1RJBre8Km
a2QUxl1SFntz/PMF74HOp4KOa1ZF5J267Y2TRw7dtBKVXod2AqWiIgBkKVwiokwN
oogQifwL+TLUmentvQNiH526iPauUDAPV3m8zJB2N3LnmY8oKm5yDocRe2KukEy0
EC/0AUQKbtOTo3T1t4gnfb+Z4ghVnFsDnEIxvd+W5t/D06hON7357Ju4u1W7UBbN
veKPrbyG/244+jrbUE9FxM48yBxx4f3QAXb04erRyQ8FwdbJsEhMdH+CmUIBvgc=
=TX9f
-----END PGP SIGNATURE-----

--nqkreNcslJAfgyzk--
