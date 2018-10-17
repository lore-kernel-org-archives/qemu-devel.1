Received: from eggs.gnu.org ([2001:4830:134:3::10]:43678)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gCi9o-0003oL-Fz
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 05:30:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gCi9j-0002L0-UX
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 05:30:24 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:33341)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1gCi9j-0002Jz-JU
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 05:30:19 -0400
Received: by mail-wr1-x442.google.com with SMTP id e4-v6so28834876wrs.0
	for <qemu-devel@nongnu.org>; Wed, 17 Oct 2018 02:30:19 -0700 (PDT)
Date: Wed, 17 Oct 2018 10:30:16 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20181017093016.GF22755@stefanha-x1.localdomain>
References: <20181016175236.5840-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="O98KdSgI27dgYlM5"
Content-Disposition: inline
In-Reply-To: <20181016175236.5840-1-peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [PATCH] hw/acpi/nvdimm: Don't take address of
 fields in packed structs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, patches@linaro.org


--O98KdSgI27dgYlM5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 16, 2018 at 06:52:36PM +0100, Peter Maydell wrote:
> Taking the address of a field in a packed struct is a bad idea, because
> it might not be actually aligned enough for that pointer type (and
> thus cause a crash on dereference on some host architectures). Newer
> versions of clang warn about this. Avoid the bug by not using the
> "modify in place" byte swapping functions.
>=20
> Patch produced with scripts/coccinelle/inplace-byteswaps.cocci.
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Automatically generated patch, tested with "make check" only.
>=20
>  hw/acpi/nvdimm.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--O98KdSgI27dgYlM5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbxwEoAAoJEJykq7OBq3PIlkcIAMAViIMt1/NKNn1WCGMR31Q9
WXvfptsnnBqd0xamrAV1V6+5CKAZ6IjfkrP1hA7i4QXj7mo9PZFCxRhx14PbZOjF
3uRURdlBwfZXwMXb1+XsiOKZHk9hljkjZfR2nbshiXrC2DZ8eeRcUjwxDLkcjeri
oepOJgWixfNBL3LoS57LHwU9n0ebtjfXmx8dqjqvJ8eMiNF74oD72uCynzp66ikM
BoLEsRosnZHo4kw5EwfvdnEfXQTcW7BwUrA34jzFi+/s5H/AsDwluyDjlxnLdv4D
HZUgi0DsJv59w8w+YNgXCpodmxHjsDJjKwRDZaoAVcMz/Igwcp974cyGpPIjCZA=
=iGRu
-----END PGP SIGNATURE-----

--O98KdSgI27dgYlM5--
