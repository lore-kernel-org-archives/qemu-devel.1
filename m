Received: from eggs.gnu.org ([2001:4830:134:3::10]:33863)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eQwO7-0008Ay-Al
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 09:27:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eQwO6-0006ml-Fu
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 09:27:27 -0500
Date: Mon, 18 Dec 2017 14:27:15 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171218142715.GK16653@stefanha-x1.localdomain>
References: <20171214005953.8898-1-jsnow@redhat.com>
	<20171214005953.8898-4-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Jtds+vpI57xq70EV"
Content-Disposition: inline
In-Reply-To: <20171214005953.8898-4-jsnow@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/7] blockjob: create block_job_throttle
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: qemu-block@nongnu.org, kwolf@redhat.com, jcody@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com


--Jtds+vpI57xq70EV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 13, 2017 at 07:59:49PM -0500, John Snow wrote:
> +/**
> + * block_job_throttle:
> + * @job: The job that calls the function.
> + *
> + * Yield if it has been SLICE_TIME nanoseconds since the last yield.
> + * Otherwise, check if we need to pause (and update the yield counter).
> + */
> +void block_job_throttle(BlockJob *job);

This name is easily confused with the block-job-set-speed
ratelimit/throttling feature.

I suggest block_job_cpu_relax() or just block_job_relax() to make it
clear we're giving up our CPU time voluntarily - but this isn't
"throttling".

--Jtds+vpI57xq70EV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaN9BDAAoJEJykq7OBq3PIgwkH+weZD++NZkg1wXHURpmNL4Hs
/iD/x6l/0cXJcZzCm4qM2RKKxJFhjCYYMWg1k0VXnk3RrY1QeRNmeGr7gbMxCoC6
FMOssb436CC/5X9kiwBX5ie2fCj6NCj6/rmgo/w+bWtWOvyfEKcireNcfMtu4F23
Z6wEk3KmPsTUEa97+NMobpo686jesRU8/Odpyf1Hqf8zJXZTOAEC6x1Tt/soKsIV
Hr+ddvhFnrO7x3ZDUMk/Lo1aaCm1dXeERdM+POaT+iqOcIU49HCvm4QMisviOl3t
NHV7f9iwLVRvVVcsUtz1upsVyNrwKihH0ANOm8QBthM9Hj4wr2L4/NQ4pyXWYFY=
=pHDr
-----END PGP SIGNATURE-----

--Jtds+vpI57xq70EV--
