Received: from eggs.gnu.org ([2001:4830:134:3::10]:58357)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gTNvA-0004tn-V2
	for qemu-devel@nongnu.org; Sun, 02 Dec 2018 04:20:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gTNv8-00050Z-Mc
	for qemu-devel@nongnu.org; Sun, 02 Dec 2018 04:20:12 -0500
Date: Sun, 2 Dec 2018 19:55:12 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181202085512.GL30479@umbus.fritz.box>
References: <20181130151712.2312-1-peter.maydell@linaro.org>
	<20181130151712.2312-3-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="iAzLNm1y1mIRgolD"
Content-Disposition: inline
In-Reply-To: <20181130151712.2312-3-peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [PATCH 02/10] hw/ppc/ppc405_boards: Don't use
 load_image()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, patches@linaro.org, Stefan Hajnoczi <stefanha@redhat.com>, Eric Blake <eblake@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Philip Li <philip.li@intel.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Alexander Graf <agraf@suse.de>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Igor Mammedov <imammedo@redhat.com>, qemu-block@nongnu.org, qemu-ppc@nongnu.org


--iAzLNm1y1mIRgolD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 30, 2018 at 03:17:04PM +0000, Peter Maydell wrote:
> The load_image() function is deprecated, as it does not let the
> caller specify how large the buffer to read the file into is.
> Instead use load_image_size().
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/ppc/ppc405_boards.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/ppc/ppc405_boards.c b/hw/ppc/ppc405_boards.c
> index 3be3fe4432b..1b0a0a8ba3a 100644
> --- a/hw/ppc/ppc405_boards.c
> +++ b/hw/ppc/ppc405_boards.c
> @@ -219,9 +219,11 @@ static void ref405ep_init(MachineState *machine)
>              bios_name =3D BIOS_FILENAME;
>          filename =3D qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
>          if (filename) {
> -            bios_size =3D load_image(filename, memory_region_get_ram_ptr=
(bios));
> +            bios_size =3D load_image_size(filename,
> +                                        memory_region_get_ram_ptr(bios),
> +                                        BIOS_SIZE);
>              g_free(filename);
> -            if (bios_size < 0 || bios_size > BIOS_SIZE) {
> +            if (bios_size < 0) {
>                  error_report("Could not load PowerPC BIOS '%s'", bios_na=
me);
>                  exit(1);
>              }
> @@ -515,9 +517,11 @@ static void taihu_405ep_init(MachineState *machine)
>                                 &error_fatal);
>          filename =3D qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
>          if (filename) {
> -            bios_size =3D load_image(filename, memory_region_get_ram_ptr=
(bios));
> +            bios_size =3D load_image_size(filename,
> +                                        memory_region_get_ram_ptr(bios),
> +                                        BIOS_SIZE);
>              g_free(filename);
> -            if (bios_size < 0 || bios_size > BIOS_SIZE) {
> +            if (bios_size < 0) {
>                  error_report("Could not load PowerPC BIOS '%s'", bios_na=
me);
>                  exit(1);
>              }

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--iAzLNm1y1mIRgolD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwDnfAACgkQbDjKyiDZ
s5KQrg//aWV3KYYTd6xe/VYYgXjy1gcH2rMvEDwIV82j3QQtZwdAQYMo9cJhGJ8R
l2TkR/0u6AkChETXzzA9pztAHFnhz+c+V9LajSpVAzFn3iRrNDDJ3QKZCUYKi1IR
xwf5GMBV3IzIC8EC3sHhKwRhmyIhHBg6cSQXftS5OLVj3ehoxtBV7hlvJLGaiOBu
lkR7+DUDT3gy4gg7jsj5F2uRPUPXNwNjOnTAxpLLLY3497YZrr5bEeu7t+8GG2/W
CmSVuGwEoq5Hk0cm3CrzVOlxTOfgHRzj/ZlvSKcFZ2FT9oJU6LrUDJaS/7HD6kD7
P2gZcK49OovbIpHf7lNyrO78suDMLXAJsvihBkRyeewsIGy4BLyCEsxv0Ik/d3E9
cgw7DTxug7zzoGvvW5o/WR3Bp5zb8h5q8PG/76znB2KpmqP6ArnkQex/toReZKkv
oiNeXSaXva9DzzBz93csycEJfvCA3tidDi/N3J9XJDv4fMgyhzDs6TDe2EhhzGMd
HIIPsfKU4wK5hvXLYY5x70oKzZ1DMVWkXOZH+HIqHMk5Ng2uyaWNkZfZpPkBF/LD
4+YW62wzwUwdmMvxjId/oZkArnqUS70GJ/fqbDfCN2FkXSPEVA0+K1W2xtQFlIT2
t3pA+RnzebNH3lqckNTaq2zZagO52X1a6PbVkXPg4Aq/IvfBXkA=
=qNhJ
-----END PGP SIGNATURE-----

--iAzLNm1y1mIRgolD--
