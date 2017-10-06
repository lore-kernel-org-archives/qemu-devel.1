Received: from eggs.gnu.org ([2001:4830:134:3::10]:36656)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e0JCi-0002Lx-3A
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 23:21:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e0JCg-0005DS-SA
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 23:21:36 -0400
Date: Fri, 6 Oct 2017 13:58:39 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171006025839.GE3260@umbus.fritz.box>
References: <1507220690-265042-1-git-send-email-imammedo@redhat.com>
	<1507220690-265042-3-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xnH/NIbSm9ew9GxF"
Content-Disposition: inline
In-Reply-To: <1507220690-265042-3-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 02/23] qom: introduce
 type_register_static_array()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, "open list:ppce500" <qemu-ppc@nongnu.org>


--xnH/NIbSm9ew9GxF
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 05, 2017 at 06:24:29PM +0200, Igor Mammedov wrote:
> it will help to remove code duplication of registration
> static types in places that have open coded loop to
> perform batch type registering.
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  include/qom/object.h | 10 ++++++++++
>  qom/object.c         |  9 +++++++++
>  2 files changed, 19 insertions(+)
>=20
> diff --git a/include/qom/object.h b/include/qom/object.h
> index a707b67..9a2369c 100644
> --- a/include/qom/object.h
> +++ b/include/qom/object.h
> @@ -789,6 +789,16 @@ Type type_register_static(const TypeInfo *info);
>  Type type_register(const TypeInfo *info);
> =20
>  /**
> + * type_register_static_array:
> + * @infos: The array of the new type #TypeInfo structures.
> + * @nr_infos: number of entries in @infos
> + *
> + * @infos and all of the strings it points to should exist for the life =
time
> + * that the type is registered.
> + */
> +void type_register_static_array(const TypeInfo *infos, int nr_infos);
> +
> +/**
>   * object_class_dynamic_cast_assert:
>   * @klass: The #ObjectClass to attempt to cast.
>   * @typename: The QOM typename of the class to cast to.
> diff --git a/qom/object.c b/qom/object.c
> index 6a7bd92..c58c52d 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -151,6 +151,15 @@ TypeImpl *type_register_static(const TypeInfo *info)
>      return type_register(info);
>  }
> =20
> +void type_register_static_array(const TypeInfo *infos, int nr_infos)
> +{
> +    int i;
> +
> +    for (i =3D 0; i < nr_infos; i++) {
> +        type_register_static(&infos[i]);
> +    }
> +}
> +
>  static TypeImpl *type_get_by_name(const char *name)
>  {
>      if (name =3D=3D NULL) {

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--xnH/NIbSm9ew9GxF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnW8V8ACgkQbDjKyiDZ
s5Kh0RAA0rH2krZGOnrFAlOMQlw56T4XsbstYbco8LWN9lamIRc6NN4uV33NgRQb
DsUMKO5ViWGmcVYlXHs0AY3ixhxqZwj3bA6RIk5Gywtpv8E5KwjeQ1QuhzO/Uqt8
29BnoFmLtAmkG/eXUiAjCEo7xQHBiE0FHuoahtbBfK2CDIGwsJ9agWTBzaHi6Nyf
0kpty/HWGzeuNWPG4Xsug7TVM82sioy1411b5YtfCjx4rJ1OABto0qDLIZUJ/0nE
zGKt37hna+EpcfWZOUwxYa7ZEq8QkA44eevTs/2OE15+MlMTj82P51bpIsCrbnM8
qJWPh1mSJB5r6J9pXnWNfctnugjPXGZnr97K1SKnHSEgM8+6USD4t2K+EuGUeNWv
0iYMGE4SQ7ZNsKZwKBsDEIsvLU2s3WQ1HySskqA4jkEgpJZy3JRzeND+ZTSIqO2E
0GkNSfdch7ZdkBO1OBP0hqtSs9rL834MVdJjrDhaJgUqYI17l/Gsttsk2Uyu/fH7
VVnj+Xr6nCOFkQmXyskUrePPchjqQl6NSzAR7icBZNPbIift9sF0mEIVqJhhmYgk
PhhlTqJFc0IeuwuEkjxY6zfjtFFFOgWZIW+qmQwPl5k6LLe0ZAR4LtKqWNNMjoOm
o5U4irPiKarQhwwjDcIZv1QJw0Zy0TjriuOF8a6faXprdMVYvPc=
=UhOA
-----END PGP SIGNATURE-----

--xnH/NIbSm9ew9GxF--
