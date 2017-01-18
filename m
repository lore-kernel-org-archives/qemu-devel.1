Received: from eggs.gnu.org ([2001:4830:134:3::10]:33878)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cTsUI-0003dL-2j
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 10:49:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cTsUD-0001Hv-7y
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 10:49:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52408)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cTsUD-0001Ha-1s
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 10:49:21 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D0894D561C
	for <qemu-devel@nongnu.org>; Wed, 18 Jan 2017 15:49:20 +0000 (UTC)
Date: Wed, 18 Jan 2017 15:49:18 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170118154918.GL30347@stefanha-x1.localdomain>
References: <20170113131731.1246-1-pbonzini@redhat.com>
	<20170113131731.1246-12-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jtcAeju3WzRmRF+o"
Content-Disposition: inline
In-Reply-To: <20170113131731.1246-12-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 11/16] block: explicitly acquire aiocontext
 in callbacks that need it
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


--jtcAeju3WzRmRF+o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 13, 2017 at 02:17:26PM +0100, Paolo Bonzini wrote:
> This covers both file descriptor callbacks and polling callbacks,
> since they execute related code.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  aio-posix.c           |  7 -------
>  aio-win32.c           |  6 ------
>  block/curl.c          | 16 +++++++++++++---
>  block/iscsi.c         |  4 ++++
>  block/linux-aio.c     |  4 ++++
>  block/nfs.c           |  6 ++++++
>  block/sheepdog.c      | 29 +++++++++++++++--------------
>  block/ssh.c           | 29 +++++++++--------------------
>  block/win32-aio.c     | 10 ++++++----
>  hw/block/virtio-blk.c |  5 ++++-
>  hw/scsi/virtio-scsi.c |  6 ++++++
>  nbd/server.c          |  4 ++++
>  12 files changed, 71 insertions(+), 55 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--jtcAeju3WzRmRF+o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYf45+AAoJEJykq7OBq3PIbqcH/2y61B0bsf54QFtWDuW/s+y0
0U42bfvfy9NpmMiiFf8UEc2OD9IyGukleFxtd0dT8XJXwTtV9ap5T1s4g6Xrh2Zk
Q5w9qddq/gw2zN6LHNSxzp24H3LeRgWeYsYYWFMUZGIr8TRTeGav3IHLMH3DWY/J
Ehsg5/EXibaGH/1b+1ELNFC3qisd3HzJs7LobKFin9wFRVWSG3oqKH7rUZPZr4rd
C5Ofb3WEY1b91I/6DRQPl/B5fq8q9Z+vqmlpZBVdtue3/hiS/e2ojV5uOI7nlZRr
ruX6HDlPPDpV7vors9qBCeUXTY/+FiumejrgUFj4outcZMY5heKhvmJSTard6p8=
=/5Ra
-----END PGP SIGNATURE-----

--jtcAeju3WzRmRF+o--
