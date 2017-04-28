Received: from eggs.gnu.org ([2001:4830:134:3::10]:39482)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d489k-0007xr-RP
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 11:50:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d489h-0000IH-Qt
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 11:50:04 -0400
Received: from mail-wm0-x22f.google.com ([2a00:1450:400c:c09::22f]:37111)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1d489h-0000I3-Jw
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 11:50:01 -0400
Received: by mail-wm0-x22f.google.com with SMTP id m123so50732139wma.0
	for <qemu-devel@nongnu.org>; Fri, 28 Apr 2017 08:50:01 -0700 (PDT)
Date: Fri, 28 Apr 2017 16:49:58 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170428154958.GD10286@stefanha-x1.localdomain>
References: <149321376763.7874.12797658801011614451.stgit@bahia>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vni90+aGYgRvsTuO"
Content-Disposition: inline
In-Reply-To: <149321376763.7874.12797658801011614451.stgit@bahia>
Subject: Re: [Qemu-devel] [PATCH v2] configure: fix trace backend list for
 out-of-tree builds
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>


--vni90+aGYgRvsTuO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 26, 2017 at 03:36:07PM +0200, Greg Kurz wrote:
> Since commit "c53eeaf75a04 configure: eliminate Python dependency for
> --help", configure --help fails to produce the list of available trace
> backends if invoked out-of-tree. It also spits the following error:
>=20
> grep: scripts/tracetool/backend/*.py: No such file or directory
>=20
> This patch simply adds the missing $source_path to fix it.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
> v2: - use "$source_path" instead of $source_path
> ---
>  configure |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks, applied to my staging tree:
https://github.com/stefanha/qemu/commits/staging

Stefan

--vni90+aGYgRvsTuO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZA2SmAAoJEJykq7OBq3PIhGIH+wWKxow4f7fn3shzlmU108YM
kIcn/9QiUuTTt4yH8BlN8xRPNl85vtDzJ37KElxMkSkNoT9xWX8jtGcNPR4zBX0w
egN/yM3hmUMNsfrT8RVFWS/OZ6wto27VzyhadPXfkhw42HAzHF/qsdJGAtTVYsMj
XpeQRNei06d6y9JEzAQU1pJ+dSVw76yu1I9VPYkC+wNGGrKlttjUYUGuBCjmCt1L
NLiQRMA+lPXvi1CavAb6gON9KetGzdJCQ/16e7Dos1BAfgfJJWIxqSLtlbswLOVm
hDcq8zqMqW2NfFGV04IUSs+drTFyb69wRtoGblg+OPE7Tdlu5oCOq8mr/7o9xNc=
=CURb
-----END PGP SIGNATURE-----

--vni90+aGYgRvsTuO--
