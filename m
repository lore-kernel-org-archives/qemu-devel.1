Received: from eggs.gnu.org ([2001:4830:134:3::10]:36746)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e0JCl-0002ME-4A
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 23:21:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e0JCg-0005Db-Se
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 23:21:39 -0400
Date: Fri, 6 Oct 2017 13:57:45 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171006025745.GD3260@umbus.fritz.box>
References: <1507220690-265042-1-git-send-email-imammedo@redhat.com>
	<1507220690-265042-2-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="YgGp9RfepglW4nsE"
Content-Disposition: inline
In-Reply-To: <1507220690-265042-2-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 01/23] qom: update doc comment for
 type_register[_static]()
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


--YgGp9RfepglW4nsE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 05, 2017 at 06:24:28PM +0200, Igor Mammedov wrote:
> type_register()/type_register_static() functions in current impl.
> can't fail returning 0, also none of the users check for error
> so update doc comment to reflect current behaviour.
>=20
> Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  include/qom/object.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/include/qom/object.h b/include/qom/object.h
> index e0d9824..a707b67 100644
> --- a/include/qom/object.h
> +++ b/include/qom/object.h
> @@ -773,7 +773,7 @@ const char *object_get_typename(const Object *obj);
>   * @info and all of the strings it points to should exist for the life t=
ime
>   * that the type is registered.
>   *
> - * Returns: 0 on failure, the new #Type on success.
> + * Returns: the new #Type.
>   */
>  Type type_register_static(const TypeInfo *info);
> =20
> @@ -784,7 +784,7 @@ Type type_register_static(const TypeInfo *info);
>   * Unlike type_register_static(), this call does not require @info or its
>   * string members to continue to exist after the call returns.
>   *
> - * Returns: 0 on failure, the new #Type on success.
> + * Returns: the new #Type.
>   */
>  Type type_register(const TypeInfo *info);
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--YgGp9RfepglW4nsE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnW8ScACgkQbDjKyiDZ
s5KbNg/+NpFGayuDj8WHXxGvf4KkrhWB0LZbMtSv0CBjfSGfI4XYUcwmS0/LJcdR
2yoFGWGUyWPBczroCALtY2vvWko4tRBQrXRuDXF87P/NvBTaVrGYNxxjyQ7g0E67
bHhpjcNDZVz7YrjkSUKxTaMQpD1e5yqMj8qe2BD74sjhRC1JQdTdhfTWK+eIxWSi
8yd7Z2o/ejub7iOmSPNZykQJK7O9kjU+JjNozEI5jHL5bZ3Fhwrcq13iMB9dTVmL
prq4k4hOu3R9TYgV4EGI8b6qSy+w7NKWA97Vl07TiaJ+VUbSBUCCphDPz11RR/4w
HMFUmD7GnTHOHU4VQdUDezRU1CitdUph3vdJ6Hi6RGEu+rxDIoNq4uKth34RE+Uj
iWS+DMPsE0jLZyQUdNQO4MT9poEDK5t6G9EQcKCu5XYsLp06u+c/H9+ALA8DAyYO
72PGX8ZG6wcvZLqvMWUsT/rNwH726ANn8k/oEn95f2bpeDTgdkdV7IyhP4G6P5WN
6/pCHoZjLIrXb1xwqdvHE1L5Y8QdiNAYI3X5BurCsT6QECg1ZJg1GEb6YKTPSJy9
9Yug8pst2BlQqg+W4MUYzI9/5bmdENch8aJOuBqcIC8sUM3VNmw96ndKooQNj+Q0
ovLLKENm76efxqLLFJlPbyxXROFn5hbkiOum6EvmQgXEUOM6mCQ=
=CxQH
-----END PGP SIGNATURE-----

--YgGp9RfepglW4nsE--
