Received: from eggs.gnu.org ([2001:4830:134:3::10]:57964)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d8uok-0000Gf-RG
	for qemu-devel@nongnu.org; Thu, 11 May 2017 16:36:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d8uoh-0004uy-NL
	for qemu-devel@nongnu.org; Thu, 11 May 2017 16:36:10 -0400
Date: Thu, 11 May 2017 16:36:04 -0400
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170511203604.GS24584@stefanha-x1.localdomain>
References: <20170419094356.19826-1-famz@redhat.com>
	<20170419094356.19826-17-famz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vEk28Nl/eckWL8CC"
Content-Disposition: inline
In-Reply-To: <20170419094356.19826-17-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 16/16] tests: Add test case for
 BLK_PERM_AIO_CONTEXT_CHANGE
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


--vEk28Nl/eckWL8CC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 19, 2017 at 05:43:56PM +0800, Fam Zheng wrote:
> +static void test_aio_context_failure(void)
> +{
> +    Error *local_err = NULL;
> +    BlockBackend *blk1 = blk_new(BLK_PERM_AIO_CONTEXT_CHANGE,
> +                                 BLK_PERM_ALL & ~BLK_PERM_AIO_CONTEXT_CHANGE);
> +    BlockBackend *blk2 = blk_new(BLK_PERM_AIO_CONTEXT_CHANGE, BLK_PERM_ALL);
> +    BlockDriverState *bs = bdrv_open("null-co://", NULL, NULL, 0, &error_abort);
> +
> +    blk_insert_bs(blk1, bs, &error_abort);
> +    blk_insert_bs(blk2, bs, &local_err);
> +
> +    g_assert_nonnull(local_err);

The following asserts and also frees the Error object to prevent leaking
memory:

error_free_or_abort(local_err);

--vEk28Nl/eckWL8CC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZFMs0AAoJEJykq7OBq3PI3SYH/1x0Ig07RI3kOmLuYTKM6wk3
5WLdFh4NdakyAdg+4Mp436O4IsG+ROhTcPzPodi4j8zz9sYIxJwxnW7A22H2bQ/O
Mtnrm7arxkt8kUZ/gy5ExFicaD6TJXeJg3If+KBTgqSjfwSFEo+0xjGOvmEM2iPY
gC7a8v+mTncZxmTwmrAF1pzio7xU/26jzUkx2bkBWYFxC5hEqtG/aaRH/Qx2a/Xx
wdKKYXC8fMAnEXjAfsdc7wmfqfWDYvQxH+yCvQR2xiICB4dmjabh/tEd8WTMNjkT
yladjiM4eMvOE6VH7YCOrSgMMRfWYRH2gV11GieIm0YI+SLvSL7tU+9OrVwJ9Ns=
=Gg8e
-----END PGP SIGNATURE-----

--vEk28Nl/eckWL8CC--
