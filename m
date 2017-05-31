Received: from eggs.gnu.org ([2001:4830:134:3::10]:42324)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dG0CA-0004JE-PE
	for qemu-devel@nongnu.org; Wed, 31 May 2017 05:45:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dG0C6-0002m5-OJ
	for qemu-devel@nongnu.org; Wed, 31 May 2017 05:45:38 -0400
Date: Wed, 31 May 2017 10:45:31 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170531094531.GD15666@stefanha-x1.localdomain>
References: <20170524025235.32190-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+B+y8wtTXqdUj1xM"
Content-Disposition: inline
In-Reply-To: <20170524025235.32190-1-famz@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v3 00/16] block: Protect AIO
 context change with perm API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>


--+B+y8wtTXqdUj1xM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 24, 2017 at 10:52:19AM +0800, Fam Zheng wrote:
> v3: Move blk_set_aio_context to the front of mirror_start_job to avoid
>     accessing target without acquiring its aio context. [Stefan]
>     Use error_free_or_abort in test code. [Stefan]

Please include my Reviewed-bys from the previous revision.  That way
they will be included in the commit log and I don't need to look back at
previous revisions when you send the next revision.

I've also left a comment on one of your replies to the previous
revision because I think blockdev-backup's 'target' parameter isn't
protected against AioContext changes.

Thanks!

--+B+y8wtTXqdUj1xM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZLpC7AAoJEJykq7OBq3PIpCMIAMdDZKvbxU2d+/pqmPrNI+YA
UqPgg1ITPd1Xyf01OzANG/zwALMNTPXp4dx+cPwiR7UYdFEnPohfv2Rx3Xmz9dsO
g8L5AxXAolPkUDw44g6nV7xEQIvj9xCGdqZyL0ToEq4gkQjJh8WhXuE9oCCykbOE
Lea/MfqOvfzzc6lSQ83Pxrjh0KwPsG8wFluAfjT8NPSYO8XDPY9AB/13Be6VQ+5M
6wcF484EXsOOuZXHIFSUJDJ98VYx5S/RYd3ArqblQuYiOve2kXlrynrthN/Zghx2
eHy6r+HfGOcUDkuQGAv+1US5QMDIKfRLPYIDTy4VW5RjgRVS29HUwMoC7P+bSKM=
=lQV2
-----END PGP SIGNATURE-----

--+B+y8wtTXqdUj1xM--
