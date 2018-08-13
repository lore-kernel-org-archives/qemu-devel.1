Received: from eggs.gnu.org ([2001:4830:134:3::10]:42688)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fpFph-0003cv-3B
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 12:36:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fpFpg-0000Vy-7c
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 12:36:41 -0400
References: <20180803005015.5116-1-programmingkidx@gmail.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <c9658407-b1f5-de88-44d4-1b977812de77@redhat.com>
Date: Mon, 13 Aug 2018 18:36:27 +0200
MIME-Version: 1.0
In-Reply-To: <20180803005015.5116-1-programmingkidx@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="SUNe8qXqDIebUIEEnN5121q0UQspJyD2S"
Subject: Re: [Qemu-devel] [PATCH] qemu-img.c: Add examples section
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Arbuckle <programmingkidx@gmail.com>, kwolf@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SUNe8qXqDIebUIEEnN5121q0UQspJyD2S
From: Max Reitz <mreitz@redhat.com>
To: John Arbuckle <programmingkidx@gmail.com>, kwolf@redhat.com,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Message-ID: <c9658407-b1f5-de88-44d4-1b977812de77@redhat.com>
Subject: Re: [PATCH] qemu-img.c: Add examples section
References: <20180803005015.5116-1-programmingkidx@gmail.com>
In-Reply-To: <20180803005015.5116-1-programmingkidx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-08-03 02:50, John Arbuckle wrote:
> Add an examples section to the help output.
>=20
> Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
> ---
>  qemu-img.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>=20
> diff --git a/qemu-img.c b/qemu-img.c
> index 1acddf693c..f77c82695d 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c
> @@ -199,6 +199,17 @@ static void QEMU_NORETURN help(void)
> =20
>      printf("%s\nSupported formats:", help_msg);
>      bdrv_iterate_format(format_print, NULL);
> +
> +    printf("\n\nExamples:\n\n"
> +           "Create: qemu-img create -f qcow2 image.qcow2 10G\n\n"
> +           "Info: qemu-img info image.qcow2\n\n"
> +           "Resize: qemu-img resize image.qcow2 20G\n\n"
> +           "Convert: qemu-img convert -f raw -O qcow2 image.img image.=
qcow2\n\n"
> +           "Check: qemu-img check image.qcow2\n\n"
> +           "Map: qemu-img map -f qcow2 --output=3Dhuman image.qcow2\n\=
n"
> +           "Rebase: qemu-img rebase -b new_backing_file.qcow2 image.qc=
ow2"
> +           );
> +

The examples look good!

I have to agree with Fam, though, that since all the rest of the help
text is rather dense, this should be condensed as well.  I would vote
for replacing all \n\n" by \n" and indenting the example lines by two
spaces.

(I personally am a fan of not-so-dense info, but then again, this is a
--help text, so there is a point in making it dense.)

Also, I think it would be better to order the examples alphabetically.

Max

>      printf("\n\n" QEMU_HELP_BOTTOM "\n");
>      exit(EXIT_SUCCESS);
>  }
>=20



--SUNe8qXqDIebUIEEnN5121q0UQspJyD2S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAltxs4sACgkQ9AfbAGHV
z0A4FAf/QhV9mZpIfA8yk+gOmhs6wyRucO/TtSZkfVHHlN+ZiuhkJ3hbj0sqjV8U
oTLABJ5glmN+sWNN0qZdfuhirzb3Ui2Y+04wv+//PSbP7f4AMYctWyCUJRATTi1S
uVhD0HRfSmdUc3okRBS1o632ap8Sg+4aSv68YC4AE+YUMJGOlPPF7A5ouFFwmzRb
4Mp+EYURGZYpzdQ5cU0WP+puOYILqhph9t23HtHylTNFA5vdjEP5cDdyGxv/uOpJ
5rEj2MOLXeeOk/90A3ag00VdmhVg6ca7HBafCygO6D7LWwsGOKTdkxlPeGTfOtOo
O1CRkWqGGBoTA3O0nXJngvGk1JpE0w==
=WipB
-----END PGP SIGNATURE-----

--SUNe8qXqDIebUIEEnN5121q0UQspJyD2S--
