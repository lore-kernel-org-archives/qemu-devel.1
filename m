Received: from eggs.gnu.org ([209.51.188.92]:58025)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1gr2Xo-00065T-Jk
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 10:21:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1gr2Xn-00019l-J8
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 10:21:52 -0500
References: <1549371525-29899-1-git-send-email-thuth@redhat.com>
From: Luc Michel <luc.michel@greensocs.com>
Message-ID: <50ea8b3e-cd8e-c6e9-86dc-2e50b78646c5@greensocs.com>
Date: Tue, 5 Feb 2019 16:21:30 +0100
MIME-Version: 1.0
In-Reply-To: <1549371525-29899-1-git-send-email-thuth@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="9wZUNnmWASyVq9YFg4GIaYz4yiwRwBoHb"
Subject: Re: [Qemu-devel] [PATCH] hw/cpu/cluster: Mark the cpu-cluster
 device with user_creatable = false
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair.francis@wdc.com>, qemu-trivial@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9wZUNnmWASyVq9YFg4GIaYz4yiwRwBoHb
From: Luc Michel <luc.michel@greensocs.com>
To: Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-trivial@nongnu.org
Message-ID: <50ea8b3e-cd8e-c6e9-86dc-2e50b78646c5@greensocs.com>
Subject: Re: [PATCH] hw/cpu/cluster: Mark the cpu-cluster device with
 user_creatable = false
References: <1549371525-29899-1-git-send-email-thuth@redhat.com>
In-Reply-To: <1549371525-29899-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 2/5/19 1:58 PM, Thomas Huth wrote:
> The device can not be instantiated by the user and QEMU currently
> aborts when you try to use it:
>=20
> $ x86_64-softmmu/qemu-system-x86_64 -device cpu-cluster
> qemu-system-x86_64: hw/cpu/cluster.c:73: cpu_cluster_realize:
>  Assertion `cbdata.cpu_count > 0' failed.
> Aborted (core dumped)
>=20
> Since this is an internal device only, mark it with user_creatable =3D =
false.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Luc Michel <luc.michel@greensocs.com>

> ---
>  hw/cpu/cluster.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/hw/cpu/cluster.c b/hw/cpu/cluster.c
> index 25f9070..6f5f037 100644
> --- a/hw/cpu/cluster.c
> +++ b/hw/cpu/cluster.c
> @@ -79,6 +79,9 @@ static void cpu_cluster_class_init(ObjectClass *klass=
, void *data)
> =20
>      dc->props =3D cpu_cluster_properties;
>      dc->realize =3D cpu_cluster_realize;
> +
> +    /* This is not directly for users, CPU children must be attached b=
y code */
> +    dc->user_creatable =3D false;
>  }
> =20
>  static const TypeInfo cpu_cluster_type_info =3D {
>=20


--9wZUNnmWASyVq9YFg4GIaYz4yiwRwBoHb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEUvSC0Bi15mxw2PT5d8knW3QnTr4FAlxZqfoACgkQd8knW3Qn
Tr4UXw/+KacuNQlSF+GZaCSvZUOFBCr4bHc5/vn8mzJ2VA2A8PTNgh5RR6coHvdi
mMZmgTw7bosc+DKYkzClqkGFTP+LGxxdUOpTaMexL+Bee05Rbi8koCI1cpnoqnpD
OW1jwlUJHoA7Q3eceiWvu84mpoF4sDSA+HobLqddSbve1wj8v9EOzT6IxzfcZoik
KSIS052lvMrkCr6jL5XmoDj0R5whq6LhKxQZH8gndG3NR/aGinJPEwdBVqe0W2VY
gmhDv0s4VooarIm786a08syI3TrfvMsDCHWtTKrhaLBzt8jUEN9FuJL3RyGml2ki
h0QYAHid1KkkOTDL6CmZmYoZYGwswLq2tFuwiaP3TakSlWrBu9DptDDCMD5SblCY
KJZ5+YG/tMEtKZrRlEQaapTy2jeThwfu4i+XOjMuVBrIAUQm8t6PYjN+kqgqJZTf
EUmCgSUn0OO5qonTapyGDUlyU/3O5X5gLiwnr919Z3H4YdSl9D3e0MR6+kXeIU0E
y7PmHjnWYf+c4SIZ12LG3YnsP7fP6Ov/moY5Vema2H13m3g31dkwamr/yvxvf3ic
7PmlrTqy8S44CH/RHE9sFJ5hN4IIwnTUJQfIBg9a6raVZ4Ao9oawvvKitkQHrqjz
8ZQ2IYhWWWZJbQN0TqTb8qmRZatlqtAM7EwJ0DtsC9QCXKg31XQ=
=++bs
-----END PGP SIGNATURE-----

--9wZUNnmWASyVq9YFg4GIaYz4yiwRwBoHb--
