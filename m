Received: from eggs.gnu.org ([2001:4830:134:3::10]:35958)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cTsdR-0007II-PH
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 10:58:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cTsdN-00054K-To
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 10:58:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57460)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cTsdN-00053t-OO
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 10:58:49 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CEF853DBDB
	for <qemu-devel@nongnu.org>; Wed, 18 Jan 2017 15:58:49 +0000 (UTC)
Date: Wed, 18 Jan 2017 15:58:46 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170118155846.GN30347@stefanha-x1.localdomain>
References: <20170113131731.1246-1-pbonzini@redhat.com>
	<20170113131731.1246-14-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="K4LMwn8CgX2KMboP"
Content-Disposition: inline
In-Reply-To: <20170113131731.1246-14-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 13/16] block: explicitly acquire aiocontext
 in aio callbacks that need it
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


--K4LMwn8CgX2KMboP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 13, 2017 at 02:17:28PM +0100, Paolo Bonzini wrote:
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  block/archipelago.c    |  3 ---
>  block/block-backend.c  |  7 -------
>  block/curl.c           |  2 +-
>  block/io.c             |  6 +-----
>  block/iscsi.c          |  3 ---
>  block/linux-aio.c      |  5 +----
>  block/mirror.c         | 12 +++++++++---
>  block/null.c           |  8 --------
>  block/qed-cluster.c    |  2 ++
>  block/qed-table.c      | 12 ++++++++++--
>  block/qed.c            |  4 ++--
>  block/rbd.c            |  4 ----
>  block/win32-aio.c      |  3 ---
>  hw/block/virtio-blk.c  | 12 +++++++++++-
>  hw/scsi/scsi-disk.c    | 15 +++++++++++++++
>  hw/scsi/scsi-generic.c | 20 +++++++++++++++++---
>  thread-pool.c          |  4 +++-
>  17 files changed, 72 insertions(+), 50 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--K4LMwn8CgX2KMboP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYf5C2AAoJEJykq7OBq3PIm1QIAIH8LvWaFNGxGI1263zkkkVf
R2L+7YnZ0o3XHEhbms9sP0IWbnE4echoaws0xqmLBtuTKqSCPmvTmU7wQ3znzS4y
U6D1LVJEpxtlzQzeI/g1mN1WSNiomgBt4vFgTl5oFdJH0L+5YILARcejbfMjWAxI
xwE9UaPjNmdMCf9LDgyEYYjNOIyJHN57MoqZ5p9EUTSwzZApD+ydibMvkX4+0hD8
2g6MmPVO2d6/pkXVdUmzcaRd8+hnfVpiYFYkx3T++mhEPyS6o/IUM6DrakDxU/ik
nr0wNRn51Zgr5Vz1gIdw30hExtTt8MeNcXLn0SUinCX9Sr5PnWXPSYoItD4es90=
=kpFe
-----END PGP SIGNATURE-----

--K4LMwn8CgX2KMboP--
