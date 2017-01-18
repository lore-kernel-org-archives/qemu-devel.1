Received: from eggs.gnu.org ([2001:4830:134:3::10]:54498)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cTs8G-0006PY-QB
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 10:26:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cTs8D-00071h-MG
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 10:26:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43787)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cTs8D-00071P-Fd
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 10:26:37 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9F9BEC00DE0D
	for <qemu-devel@nongnu.org>; Wed, 18 Jan 2017 15:26:37 +0000 (UTC)
Date: Wed, 18 Jan 2017 15:26:35 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170118152635.GH30347@stefanha-x1.localdomain>
References: <20170113131731.1246-1-pbonzini@redhat.com>
	<20170113131731.1246-8-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ik0NlRzMGhMnxrMX"
Content-Disposition: inline
In-Reply-To: <20170113131731.1246-8-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 07/16] coroutine-lock: reschedule coroutine
 on the AioContext it was running on
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


--ik0NlRzMGhMnxrMX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 13, 2017 at 02:17:22PM +0100, Paolo Bonzini wrote:
> As a small step towards the introduction of multiqueue, we want
> coroutines to remain on the same AioContext that started them,
> unless they are moved explicitly with e.g. aio_co_schedule.  This patch
> avoids that coroutines switch AioContext when they use a CoMutex.
> For now it does not make much of a difference, because the CoMutex
> is not thread-safe and the AioContext itself is used to protect the
> CoMutex from concurrent access.  However, this is going to change.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  util/qemu-coroutine-lock.c | 5 ++---
>  util/trace-events          | 1 -
>  2 files changed, 2 insertions(+), 4 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--ik0NlRzMGhMnxrMX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYf4krAAoJEJykq7OBq3PI0YwIAKDqoPW7JWN0Bs2vKZTJ8SYL
qMRq4N30hCS72yrZ8i38cCqo73lX2gZiRMAa4Fg3FtneXuyHbP9NQg1ZPjfANyAi
c/h9HQHlsQVzWOu14AdcCqMbdVo2qI2enchhGRJ4xVv+Lvwn56gRpCo6PSSx1fP+
OiDARwz+jHwFvp9qHrOwYhmdV8+nm+eZy4nu0uRZgP7olrW/i33KEwU8AiivFTD7
MoiGi+HTXIPnrKBwAVlYDxiSP3C9sHs/LQseRm+qDDXsBcoSNZ4RLP+I8zA5jikh
719tmiaxhGSSNHsDB59iLv8KH5InVWnwh8pASu3w7TXvBWGBDpj+RGRqcu9CLto=
=ohxq
-----END PGP SIGNATURE-----

--ik0NlRzMGhMnxrMX--
