Received: from eggs.gnu.org ([2001:4830:134:3::10]:58712)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1egXzu-0002Tb-AK
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 10:39:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1egXzr-0007kh-Fm
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 10:38:58 -0500
Date: Tue, 30 Jan 2018 12:14:59 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180130121459.GD15551@stefanha-x1.localdomain>
References: <20180130063433.11605-1-famz@redhat.com>
	<20180130063433.11605-3-famz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Xm/fll+QQv+hsKip"
Content-Disposition: inline
In-Reply-To: <20180130063433.11605-3-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 2/2] qemu-img: Document --force-share /
 -U
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, kchamart@redhat.com, Kevin Wolf <kwolf@redhat.com>, eblake@redhat.com, Max Reitz <mreitz@redhat.com>


--Xm/fll+QQv+hsKip
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2018 at 02:34:33PM +0800, Fam Zheng wrote:
> Signed-off-by: Fam Zheng <famz@redhat.com>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  qemu-img.texi | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/qemu-img.texi b/qemu-img.texi
> index 60a0e080c6..ec7e2f5d1e 100644
> --- a/qemu-img.texi
> +++ b/qemu-img.texi
> @@ -86,6 +86,13 @@ exclusive with the @var{-O} parameters. It is currentl=
y required to also use
>  the @var{-n} parameter to skip image creation. This restriction may be r=
elaxed
>  in a future release.
> =20
> +@item --force-share (-U)
> +If specified, @code{qemu-img} will open the image in shared mode, allowi=
ng
> +concurrent writers.

This wording confuses me.  It makes me think of multiple processes
writing to the image at the same time...

> This option is only allowed when opening images in read-only mode.

=2E..but later it turns out "concurrent writers" means there can be at
most 1 writing process and multiple reading processes.

How about merging the two statements?

"If specified, allows @code{qemu-img} to open the image in read-only
mode even if another process already has it open for writing."

--Xm/fll+QQv+hsKip
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJacGHDAAoJEJykq7OBq3PIIZwH/3L88WaO7EjmPzMI/l2fA2i9
Ro+hKSQBlIbQ/FBnELUlLBk7/ujoUnAZ9Clyf1CrdXEaShR2CnciobF2MvmF+gE/
LcV6Fnn9SrAiZimlcCDys3wTTRLdsbYbHg5ZgEbx5orwMEjXFtk3sSXA30BGXQ/h
lwqDsWZxwjR+lzYzqBUBKfDK+b5ABYz7Vh2hDNCM4YQ3NfDaee4SOcmcoxHaeMcu
OF5A5oCqjWO122eitTf8p34oEhRO5p4oXkBUeEY5Glbc808+5c3+0xaABcJxBu5U
tT1IA3orZhutcsxhZs4tnl3TaXbeWBLMhmNzTWZ0vktansX9RUhjiiqAxymDHZI=
=k8o+
-----END PGP SIGNATURE-----

--Xm/fll+QQv+hsKip--
