Received: from eggs.gnu.org ([2001:4830:134:3::10]:34303)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d9EW1-0000cN-DW
	for qemu-devel@nongnu.org; Fri, 12 May 2017 13:38:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d9EW0-0002X7-F6
	for qemu-devel@nongnu.org; Fri, 12 May 2017 13:38:09 -0400
References: <1494513181-7900-1-git-send-email-kwolf@redhat.com>
	<1494513181-7900-6-git-send-email-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <a4c0213e-7a34-1abe-55bb-89ca7660ef3a@redhat.com>
Date: Fri, 12 May 2017 19:37:53 +0200
MIME-Version: 1.0
In-Reply-To: <1494513181-7900-6-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="SQ7W0lVW20CEp2Nbme2GBVfrcRKacp1TD"
Subject: Re: [Qemu-devel] [Qemu-block] [PULL 05/58] qemu-img: Update
 documentation for -U
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SQ7W0lVW20CEp2Nbme2GBVfrcRKacp1TD
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>
Message-ID: <a4c0213e-7a34-1abe-55bb-89ca7660ef3a@redhat.com>
Subject: Re: [Qemu-block] [PULL 05/58] qemu-img: Update documentation for -U
References: <1494513181-7900-1-git-send-email-kwolf@redhat.com>
 <1494513181-7900-6-git-send-email-kwolf@redhat.com>
In-Reply-To: <1494513181-7900-6-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-05-11 16:32, Kevin Wolf wrote:
> From: Fam Zheng <famz@redhat.com>
>=20
> Signed-off-by: Fam Zheng <famz@redhat.com>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  qemu-img-cmds.hx | 36 ++++++++++++++++++------------------
>  1 file changed, 18 insertions(+), 18 deletions(-)
>=20
> diff --git a/qemu-img-cmds.hx b/qemu-img-cmds.hx
> index bf4ce59..e5bc28f 100644
> --- a/qemu-img-cmds.hx
> +++ b/qemu-img-cmds.hx

[...]

>  DEF("convert", img_convert,
> -    "convert [--object objectdef] [--image-opts] [-c] [-p] [-q] [-n] [=
-f fmt] [-t cache] [-T src_cache] [-O output_fmt] [-B backing_file] [-o o=
ptions] [-s snapshot_id_or_name] [-l snapshot_param] [-S sparse_size] [-m=
 num_coroutines] [-W] filename [filename2 [...]] output_filename")
> +    "convert [--object objectdef] [--image-opts] [-U] [-c] [-p] [-q] [=
-n] [-f fmt] [-t cache] [-T src_cache] [-O output_fmt] [-o options] [-s s=
napshot_id_or_name] [-l snapshot_param] [-S sparse_size] [-m num_coroutin=
es] [-W] filename [filename2 [...]] output_filename")
>  STEXI
> -@item convert [--object @var{objectdef}] [--image-opts] [-c] [-p] [-q]=
 [-n] [-f @var{fmt}] [-t @var{cache}] [-T @var{src_cache}] [-O @var{outpu=
t_fmt}] [-B @var{backing_file}] [-o @var{options}] [-s @var{snapshot_id_o=
r_name}] [-l @var{snapshot_param}] [-S @var{sparse_size}] [-m @var{num_co=
routines}] [-W] @var{filename} [@var{filename2} [...]] @var{output_filena=
me}
> +@item convert [--object @var{objectdef}] [--image-opts] [-U] [-c] [-p]=
 [-q] [-n] [-f @var{fmt}] [-t @var{cache}] [-T @var{src_cache}] [-O @var{=
output_fmt}] [-o @var{options}] [-s @var{snapshot_id_or_name}] [-l @var{s=
napshot_param}] [-S @var{sparse_size}] [-m @var{num_coroutines}] [-W] @va=
r{filename} [@var{filename2} [...]] @var{output_filename}

Soo... Who gets to add the -B documentation back?

Max


--SQ7W0lVW20CEp2Nbme2GBVfrcRKacp1TD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZFfLxEhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQO4u
CACOuYuNP+oSiiaUW4awhbytH7g8c7+s4n1mylgBfM/KOfhLQKpX8fEY0kF52WAE
FDUQWWBOGSx5uetT8WPmsgP/fGJHu1J37CRXC8mZnFdFygRM7thFHl/JpSDtX3+s
nKggyQnHl5euBiAtyY2DC4FY7jxaI1fo/tzPODkNAA+Ffrbtbh9gvw1Zb1/TWLBg
y5UxOcWg46kWY8gMlevSwZ6vZmDPU0Lz0BSSRkyHOsfZa4b7l2rAl6pMDnOCe3tC
WiDMP8Bi+t3cRERyeILMOkJvKxjWsljf8ZHt73V72yBNb07r8ShKHUtnytKd6VnI
CplWZiVXI+9eC+4USB+KDC/h
=X3W6
-----END PGP SIGNATURE-----

--SQ7W0lVW20CEp2Nbme2GBVfrcRKacp1TD--
