Received: from eggs.gnu.org ([2001:4830:134:3::10]:59046)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eNFMK-0007Zw-Br
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 04:54:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eNFMH-0001cw-Az
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 04:54:20 -0500
Date: Fri, 8 Dec 2017 09:54:12 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20171208095412.GC23880@stefanha-x1.localdomain>
References: <20171208014456.16635-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ctP54qlpMx3WjD+/"
Content-Disposition: inline
In-Reply-To: <20171208014456.16635-1-famz@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2] qemu-img: Document
 --force-share / -U
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, kchamart@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>


--ctP54qlpMx3WjD+/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 08, 2017 at 09:44:56AM +0800, Fam Zheng wrote:
> +@item --force-share (-U)
> +
> +If specified, @code{qemu-img} will open the image with shared permissions,
> +which makes it less likely to conflict with a running guest's permissions due
> +to image locking. For example, this can be used to get the image information
> +(with 'info' subcommand) when the image is used by a running guest. Note that
> +this could produce inconsistent result because of concurrent metadata changes,
> +etc.

The documentation isn't clear on whether read-write is supported or just
read-only.

Also, should it be declared a legacy option right away to discourage
use in new software?

--ctP54qlpMx3WjD+/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaKmFEAAoJEJykq7OBq3PIoOwIAKAvGA/IDXWVc/qFttdRmWBq
jWUfsg+H2hqpBV7EOzRWsmWkHsbtXTkwkKz8dw6VSuPC0+nPkx2PsQR/h8EzdNIm
iBrOmX29u7cZAaX98Q18TwedcwqaVvPwcYQSx19E6p9k0z9JjQLgHjI9DjX1JpgA
RBDKDOYgqEYghvFIHww9Mg2JUUBJ4VlhsmtvDp69V2cRzx9dA48cuuD8JXwuua94
dGWRLUzNQuqwKlN4h1VAkX9uR11fzP19nywQ60ZHBpt5hfmipSh/EE2+67Bpzc6d
wjKBop61dXXvbuPF4NvbyPRNit8JAxSZUn75qa4eRErf5kxiBWQGCJ0z2ZPf+7I=
=gehw
-----END PGP SIGNATURE-----

--ctP54qlpMx3WjD+/--
