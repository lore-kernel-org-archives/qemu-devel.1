Received: from eggs.gnu.org ([2001:4830:134:3::10]:38307)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1drmvC-0002AF-H5
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 11:16:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1drmv9-00024G-AR
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 11:16:18 -0400
Received: from mout.gmx.net ([212.227.15.19]:64469)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <n54@gmx.com>) id 1drmv8-000232-Tw
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 11:16:15 -0400
References: <20170830165650.1528-1-n54@gmx.com>
From: Kamil Rytarowski <n54@gmx.com>
Message-ID: <b0271f28-fd7d-95d9-445e-b815faf530ee@gmx.com>
Date: Tue, 12 Sep 2017 17:18:30 +0200
MIME-Version: 1.0
In-Reply-To: <20170830165650.1528-1-n54@gmx.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="se5r6jMNSfsAF4jwVDUUkDPpVJTsuRPpv"
Subject: Re: [Qemu-devel] [PATCH] Add BSD systems to the download section
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--se5r6jMNSfsAF4jwVDUUkDPpVJTsuRPpv
From: Kamil Rytarowski <n54@gmx.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Message-ID: <b0271f28-fd7d-95d9-445e-b815faf530ee@gmx.com>
Subject: Re: [PATCH] Add BSD systems to the download section
References: <20170830165650.1528-1-n54@gmx.com>
In-Reply-To: <20170830165650.1528-1-n54@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

ping

On 30.08.2017 18:56, Kamil Rytarowski wrote:
> Add basic notes about FreeBSD, NetBSD and OpenBSD.
>=20
> Add BSD link to source code subsection.
>=20
> Signed-off-by: Kamil Rytarowski <n54@gmx.com>
> ---
>  _download/bsd.md      | 19 +++++++++++++++++++
>  _download/source.html |  1 +
>  download.html         |  8 ++++++++
>  3 files changed, 28 insertions(+)
>  create mode 100644 _download/bsd.md
>=20
> diff --git a/_download/bsd.md b/_download/bsd.md
> new file mode 100644
> index 0000000..bbbd8a0
> --- /dev/null
> +++ b/_download/bsd.md
> @@ -0,0 +1,19 @@
> +QEMU is packaged by modern BSD systems.
> +
> +Installation can be performed from prebuilt packages or from package b=
uild system (aka ports).
> +
> +Prebuilt binary packages:
> +
> +* <strong>FreeBSD</strong> `pkg install qemu`
> +
> +* <strong>NetBSD</strong> `pkgin install qemu`
> +
> +* <strong>OpenBSD</strong> `pkg_add qemu`
> +
> +Package build system:
> +
> +* <strong>FreeBSD</strong> `cd /usr/ports/emulators/qemu && make insta=
ll`
> +
> +* <strong>NetBSD</strong> `cd /usr/pkgsrc/emulators/qemu && make insta=
ll`
> +
> +* <strong>OpenBSD</strong> `cd /usr/ports/emulators/qemu && make insta=
ll`
> diff --git a/_download/source.html b/_download/source.html
> index d090a5e..6949daa 100644
> --- a/_download/source.html
> +++ b/_download/source.html
> @@ -2,6 +2,7 @@
>  	<p>Grab the source code for the latest releases and compile it yourse=
lf!
>  	Detailed compilation instructions can be found in the wiki for
>  		<a href=3D"http://wiki.qemu-project.org/Hosts/Linux">Linux</a>,
> +		<a href=3D"http://wiki.qemu-project.org/Hosts/BSD">BSD</a>,
>  		<a href=3D"http://wiki.qemu-project.org/Hosts/Windows">Win32</a> and=

>  		<a href=3D"http://wiki.qemu-project.org/Hosts/Mac">macOS</a>.</p>
> =20
> diff --git a/download.html b/download.html
> index 5a1e4ea..2dd0044 100644
> --- a/download.html
> +++ b/download.html
> @@ -6,6 +6,7 @@ permalink: /download/
>  <div class=3D"horiz-menu">
>  <ul style=3D"display: none;">
>  <li><a href=3D"#linux">Linux</a></li>
> +<li><a href=3D"#bsd">BSD</a></li>
>  <li><a href=3D"#macos">macOS</a></li>
>  <li><a href=3D"#windows">Windows</a></li>
>  <li><a href=3D"#source">Source code</a></li>
> @@ -18,6 +19,13 @@ permalink: /download/
>  	{% markdown_relative _download/linux.md %}
>  </article>
> =20
> +<article id=3D"bsd" class=3D"active">
> +	<header>
> +	<h2>BSD</h2>
> +	</header>
> +	{% markdown_relative _download/bsd.md %}
> +</article>
> +
>  <article id=3D"macos" class=3D"active">
>  	<header>
>  	<h2>macOS</h2>
>=20



--se5r6jMNSfsAF4jwVDUUkDPpVJTsuRPpv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZt/rTAAoJEEuzCOmwLnZsVKgQAKdvR5W07zX4Bb9UHOryv0x8
b/GGgUF1Bnn4PMDn4Zskt9IGwPabZM0v+RimR+m5hfKPW1wY4cLxDdhNsDLIA2WT
QR1Eb86vryd8LfEEedPlE4WkLYcJ775uNmLEFMlkqhB0hK+pkLKOvt0FkXZgUQzg
FYUiA/+8BITzUqlEgyS4VN7aZ7M0pDlAPkprFHOmxT2AAKETjpQe3uD6FZrKOfXY
yNaejLvP8wjgg+uZvuHB4QFchQ3mf0t7USLJOvKAUbGw+jnYenNwKIvujZxrPOgX
uZmIT9cJDU4clNwObI10tTj4tEnkm6PfC2Fvc/UAoEI8tQ0hAsdPbaTEOBKUrmvF
Enf8Yg8evJMINpQOJ2djVOEMyHinWNobGENiHRSL1Y31kaeA/eiaBXwEhzbUMsMa
IZzKCiBsmkJJjwfQwLxG0VysLxAsUkPti1LEbFhXOA63x4wGy5sBhWtVoj00I+Pg
PM1bgHHrTPCwRXaEj66Ehrn6IbrHuvmt7OM0OMd+ovmzDWYnwIgmV/PUAYyYImqi
5F1GD709ZMpC0RsxNMPQwq9A/H9TldtHQ2B42R2/llsuboAOQucsXWMmWNuwWjJv
pJ+4SvuR8Vb8c+b36WbLvaGJkOpGitooSbVCkNUlvmEJ8HCGrUMrkkNbOKgygi0T
7KQoHz0U/LyFIJXc1vGO
=vjXo
-----END PGP SIGNATURE-----

--se5r6jMNSfsAF4jwVDUUkDPpVJTsuRPpv--
