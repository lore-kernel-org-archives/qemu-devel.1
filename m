Received: from eggs.gnu.org ([2001:4830:134:3::10]:49095)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dUvMI-0002OS-NR
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 09:37:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dUvMF-0003YI-Fi
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 09:37:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35370)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dUvMF-0003Xj-8T
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 09:37:43 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E1DF5C058EA9
	for <qemu-devel@nongnu.org>; Tue, 11 Jul 2017 13:37:39 +0000 (UTC)
Date: Tue, 11 Jul 2017 14:37:34 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170711133734.GU17792@stefanha-x1.localdomain>
References: <20170710072027.7948-1-famz@redhat.com>
	<20170710072027.7948-4-famz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="i483Pv/KqyjCUwB1"
Content-Disposition: inline
In-Reply-To: <20170710072027.7948-4-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH RFC 3/5] iothread: Extract iothread_start
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com


--i483Pv/KqyjCUwB1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 10, 2017 at 03:20:25PM +0800, Fam Zheng wrote:
> This is the "create and start the thread" part of iothread spawning.
>=20
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  include/sysemu/iothread.h |  1 +
>  iothread.c                | 33 +++++++++++++++++++--------------
>  2 files changed, 20 insertions(+), 14 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--i483Pv/KqyjCUwB1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZZNSeAAoJEJykq7OBq3PIA8YH/2F+BJgsScvEVnNW3c1eA25U
D1DloCTwDpAn3EkExCHVyQ6BVaOR68ufGOa6tDspLlvpLhjqB0jchgrcHgwj6Gt8
4ZcxnvNmxU39OuvybcOYsVWrFeJ0Srp/tYXAdjT1M/l6mILGF2ercA+17XlHcbA+
n3d8TFXru9znlBVhN63P8+YOFoJc4lzR/KdjtUGs3s1jiKcZr4Bwl0hEouFD9I70
VFX3KdpIg3c69bq+l7X7eCVQ0lr3EO5bNgClYqAA+XZjnWHQMNKu/gUTYaFvGa+7
ZA6OLll/lIgSPx+bOk8mibASEEj/JbYs79337uTvzq2yEsC2yFuZE6DZxHSA3Bk=
=Rdmj
-----END PGP SIGNATURE-----

--i483Pv/KqyjCUwB1--
