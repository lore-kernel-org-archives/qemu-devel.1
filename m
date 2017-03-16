Received: from eggs.gnu.org ([2001:4830:134:3::10]:42292)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1coMUe-0001qL-Ri
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 23:54:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1coMUb-0007JT-PG
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 23:54:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58652)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1coMUb-0007JJ-JM
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 23:54:25 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3B110C05680F
	for <qemu-devel@nongnu.org>; Thu, 16 Mar 2017 03:54:25 +0000 (UTC)
Date: Thu, 16 Mar 2017 11:54:20 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170316035420.GO11074@stefanha-x1.localdomain>
References: <20170315123421.28815-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vNrHrykRFvLVX6W3"
Content-Disposition: inline
In-Reply-To: <20170315123421.28815-1-berrange@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] trace: ensure $(tracetool-y) is defined
 in top level makefile
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>


--vNrHrykRFvLVX6W3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 15, 2017 at 12:34:21PM +0000, Daniel P. Berrange wrote:
> The build rules for trace files have a dependancy on $(tracetool-y).
> This variable populated in the trace/Makefile.objs file and thus its
> definition gets pulled into the top level makefile. This happens too
> late in the process though, so by the time $(tracetool-y) is defined,
> make has already evaluated $(tracetool-y) in the dependancies and
> found it to be empty. The result is that when the tracetool source
> is changed, the generated files are not rebuilt. The solution is to
> define the variable in the top level makefile too
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  Makefile            | 3 +++
>  trace/Makefile.objs | 8 --------
>  2 files changed, 3 insertions(+), 8 deletions(-)

Thanks, applied to my tracing tree:
https://github.com/stefanha/qemu/commits/tracing

Stefan

--vNrHrykRFvLVX6W3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYygxsAAoJEJykq7OBq3PIa28H/jGA0X1QtWpcMeOCAJ3C2jRb
zSO2y3Wko3zykQzxMxb5qAvD9UXbL06OB59Oxfq931koNUdMi/RUlWwP839HX0yt
vxp8me4EHVRXKCvvb3SaFmL7pQalvkb/UfrE7+2aLVk0sIjadSOC2ViY2txUBodN
mDW/UPcV/xgzQIDjJ5idDynCqJUdmXnuskF/5rhhjemffs6ZvEmGMZhHyy1wO/Rc
FTz45TuPNa3EQeI7Csk7Ha79jxEfmrnlJpiJgwBPhKHXcGLYHjeNpRSxIw8ESWCR
4H2KsMQSfagBd2D/pyChx8AoGmfA75/4IbwJ4LHufJxUsM3Pa6WCg4VKa/RgCEE=
=FtBJ
-----END PGP SIGNATURE-----

--vNrHrykRFvLVX6W3--
