Received: from eggs.gnu.org ([209.51.188.92]:53971)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gjlfx-0007N7-FZ
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 08:56:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gjlfw-0006mz-Mb
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 08:56:13 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:51513)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1gjlfw-0006kB-9U
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 08:56:12 -0500
Received: by mail-wm1-x342.google.com with SMTP id b11so2081345wmj.1
	for <qemu-devel@nongnu.org>; Wed, 16 Jan 2019 05:56:12 -0800 (PST)
Date: Wed, 16 Jan 2019 13:56:09 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190116135609.GC16898@stefanha-x1.localdomain>
References: <20181214105642.673-1-cfergeau@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6zdv2QT/q3FMhpsV"
Content-Disposition: inline
In-Reply-To: <20181214105642.673-1-cfergeau@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4] log: Make glib logging go through QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christophe Fergeau <cfergeau@redhat.com>
Cc: qemu-devel@nongnu.org


--6zdv2QT/q3FMhpsV
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 14, 2018 at 11:56:42AM +0100, Christophe Fergeau wrote:
> This commit adds a qemu_init_logging() helper which calls
> g_log_set_default_handler() so that glib logs (g_log, g_warning, ...)
> are handled similarly to other QEMU logs. This means they will get a
> timestamp if timestamps are enabled, and they will go through the
> monitor if one is configured.
> This commit also adds a call to qemu_init_logging() to the binaries
> installed by QEMU.
> glib debug messages are enabled through G_MESSAGES_DEBUG similarly to
> glib default log handler.
>=20
> At the moment, this change will mostly impact SPICE logging if your
> spice version is >=3D 0.14.1. With older spice versions, this is not going
> to work as expected, but will not have any ill effect, so this call is
> not conditional on the SPICE version.
>=20
> Signed-off-by: Christophe Fergeau <cfergeau@redhat.com>
> Reviewed-by: Daniel P. Berrang=E9 <berrange@redhat.com>
> ---
> Changes since v3:
> - Fixed style issue: removed 2 extra spaces before parens
>   (reported by checkpatch)
>=20
>  bsd-user/main.c             |  1 +
>  include/qemu/error-report.h |  2 ++
>  linux-user/main.c           |  1 +
>  qemu-img.c                  |  1 +
>  qemu-io.c                   |  1 +
>  qemu-nbd.c                  |  1 +
>  scsi/qemu-pr-helper.c       |  1 +
>  util/qemu-error.c           | 47 +++++++++++++++++++++++++++++++++++++
>  vl.c                        |  1 +
>  9 files changed, 56 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--6zdv2QT/q3FMhpsV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcPzf5AAoJEJykq7OBq3PIO4IIAK7GAAzCLp+fWmFJYKetS//X
4u6KM8XwnpTDsrD+nzpuz+M0GGXa+kcJv6ON6yaACKFJyJ9aEszd3rPr63CIAE9a
p7e+N0Ct/t2xMkplxiSGaf5JplrSDdz2oQkZmnHnlWi8R6sEGU4QwbpvJFyKNdoM
aAXn10w2Yi23+D9Xn1//sT3CUgzcvAC1PAFRbFohJJPLtT9AeJsp7Vr6wNeTW8Uw
rJiQi3Uwk8nfvB5sxVwMWhUfRT2vaM1DuWDlQEwmkiRRY9eo1RpDVOedMfK3/dDC
X2Tu13d6F5f2B6SM7KePiN0tw4HjUQghDN33HTdlRgbv2N5zXPn97nVy3eICgog=
=twaA
-----END PGP SIGNATURE-----

--6zdv2QT/q3FMhpsV--
