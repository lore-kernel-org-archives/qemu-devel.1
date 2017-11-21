Received: from eggs.gnu.org ([2001:4830:134:3::10]:59955)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eH7Ie-0001Jx-2u
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 07:05:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eH7IY-0008NH-7M
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 07:05:12 -0500
Date: Tue, 21 Nov 2017 10:49:46 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171121104946.GA25265@stefanha-x1.localdomain>
References: <cover.1511230683.git.jcody@redhat.com>
	<d21a7bb5d13a8d8db55bea05e46f5f4e18ed481e.1511230683.git.jcody@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cNdxnHkX5QqsyA0e"
Content-Disposition: inline
In-Reply-To: <d21a7bb5d13a8d8db55bea05e46f5f4e18ed481e.1511230683.git.jcody@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 for-2.11 1/4] blockjob: do not allow
 coroutine double entry or entry-after-completion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com, famz@redhat.com, pbonzini@redhat.com, kwolf@redhat.com


--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 20, 2017 at 09:23:23PM -0500, Jeff Cody wrote:
> @@ -291,10 +291,10 @@ void block_job_start(BlockJob *job)
>  {
>      assert(job && !block_job_started(job) && job->paused &&
>             job->driver && job->driver->start);
> -    job->co = qemu_coroutine_create(block_job_co_entry, job);
>      job->pause_count--;
>      job->busy = true;
>      job->paused = false;
> +    job->co = qemu_coroutine_create(block_job_co_entry, job);
>      bdrv_coroutine_enter(blk_bs(job->blk), job->co);
>  }

Please see discussion on v1 about this hunk.

The rest looks good.

--cNdxnHkX5QqsyA0e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaFATKAAoJEJykq7OBq3PIbhkIAIkYfj1buEF8lroulSMH2W1A
mcXn3Pldhq+LB+hXwgwN+FUe27DsLREs7+d9YYFWDjbcUYFDv3uB3GPUXQwRZxEY
usybz1vI8xAqQw3vN7tiE4Wg3BeN5kz2MZBNIuyG92w8bfAqCfktTEE9U26Je7/s
kbkBMuizMFSroP0/RLkcETrHoahyOGEPW2CE2/51aotOB6MmXaHUteF+zvVgb/R7
0iv9wvkNdjyjme57S8Bkenf6tFZzKdbwLcihnDvA4pqSgNtq+6UZoiTZVfV+//bW
WCbT40O2aBmxWcDImBvqjknspy+gzlxXVTq224VM8HDNMO0VT0a9Kf2l495qXdo=
=1ZOR
-----END PGP SIGNATURE-----

--cNdxnHkX5QqsyA0e--
