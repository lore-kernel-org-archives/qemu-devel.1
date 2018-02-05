Received: from eggs.gnu.org ([2001:4830:134:3::10]:41868)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eii1r-0004cc-4t
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 09:45:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eii1q-0005SR-Bf
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 09:45:55 -0500
Date: Mon, 5 Feb 2018 14:45:32 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180205144532.GC28241@stefanha-x1.localdomain>
References: <20180202111022.rtnvwmjs4r4jzttq@olga.proxmox.com>
	<89ac21c9-7d29-9333-6fe3-557b13ccf4e6@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xesSdrSSBC0PokLI"
Content-Disposition: inline
In-Reply-To: <89ac21c9-7d29-9333-6fe3-557b13ccf4e6@redhat.com>
Subject: Re: [Qemu-devel] rate limiting issues
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: Wolfgang Bumiller <w.bumiller@proxmox.com>, qemu-devel@nongnu.org, Qemu-block <qemu-block@nongnu.org>, Alberto Garcia <berto@igalia.com>


--xesSdrSSBC0PokLI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 02, 2018 at 04:52:00PM -0500, John Snow wrote:
> CCing qemu-block and Berto

To avoid confusion: ratelimit.h is only used by block jobs.  It is
unrelated to throttle.h, which Berto maintains.

Unifying the two came up in the past as a cleanup task.  No one has
attempted it yet.

--xesSdrSSBC0PokLI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaeG4MAAoJEJykq7OBq3PIqu4IAMGTQjxoXvIjxnMkn9WfZmO4
4wBN+kxFV6vd51qazCCAd4FNdc5QDbGqpa5xQ+1ryBYm+xeW4PVZhP4eaQHze4Lm
GmSlT+Y2Q9QH3YoSGLYoDsbj4nQsaIRLN7bYvP9yu0OW5ffoPPOlFKwRcY8zcPdT
7YrPm/3+FWk+wyYem+ZRZSV0cdGmPkEqfm/V842jHhyNEU/HBshV5q+++nMgkfJ2
SwXynHN3+wT8rq3nsQumWI0Ep2mwzn+5E7UnnPAWqav0qC7XqN/+DKU7YVOluyAA
2tMM8k4BciOl4rOB8jyVBLM488bvkbuKVKi8WRG3b7wbUdah2jHJrKYxcZJz4F4=
=rkfD
-----END PGP SIGNATURE-----

--xesSdrSSBC0PokLI--
