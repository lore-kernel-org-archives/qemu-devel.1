Received: from eggs.gnu.org ([2001:4830:134:3::10]:56057)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cRMDW-00062g-HJ
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 11:57:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cRMDR-00033f-KL
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 11:57:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59012)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cRMDR-00033Y-Eb
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 11:57:37 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 96B1C4AEA8
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 16:57:37 +0000 (UTC)
Date: Wed, 11 Jan 2017 16:57:32 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170111165732.GE9269@stefanha-x1.localdomain>
References: <20170104132625.28059-1-pbonzini@redhat.com>
	<20170104132625.28059-6-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SWTRyWv/ijrBap1m"
Content-Disposition: inline
In-Reply-To: <20170104132625.28059-6-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 05/10] aio-posix: split
 aio_dispatch_handlers out of aio_dispatch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com


--SWTRyWv/ijrBap1m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 04, 2017 at 02:26:20PM +0100, Paolo Bonzini wrote:
> This simplifies the handling of dispatch_fds.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  aio-posix.c | 43 +++++++++++++++++++++++++------------------
>  1 file changed, 25 insertions(+), 18 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--SWTRyWv/ijrBap1m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYdmP8AAoJEJykq7OBq3PIt64H/jPTr7GrshGCIj2HuQ518aeN
drUtiX33zDEU1rrYImzTYkST6Xs3kDfhkWOzI6bKB2yu22K6ZoKDtpNYGl6hYvau
azfUZd70B+Z4L9feW7hGNvSTlGfpFqwiL+fhfQsXJuLv5avDK2aiIAdTXsE/bl66
6eyqqNnmQu0x1svsyTre/ojv2FEHjIZV/JjhRX6amvfiiXItaYSvfBeQ8fuC8Nel
aafv3U4eDYRjICKps8D9O75CGMvOCaUiU5IqnQdvcqV7+4QMHtzyXOSxkJcI0pxF
deDp1qP/HVCSHtuy2JRsn+Flg6h+LSduc80ckOWraVOyuyErokLi0IlZXQHkcR4=
=7LgL
-----END PGP SIGNATURE-----

--SWTRyWv/ijrBap1m--
