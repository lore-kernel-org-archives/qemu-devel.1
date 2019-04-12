Received: from eggs.gnu.org ([209.51.188.92]:37472)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1hEwVM-0004Rr-Mz
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 09:46:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1hEwVL-0007o4-Pq
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 09:46:08 -0400
Date: Fri, 12 Apr 2019 14:45:49 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190412134549.GA30090@stefanha-x1.localdomain>
References: <20190402121908.44081-1-slp@redhat.com>
	<20190409112608.GD16944@stefanha-x1.localdomain>
	<87bm1diz23.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5vNYLRcllDrimb99"
Content-Disposition: inline
In-Reply-To: <87bm1diz23.fsf@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [RFC PATCH] aio: Add a knob to always
 poll if there are in-flight requests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sergio Lopez <slp@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-block@nongnu.org, kwolf@redhat.com, fam@euphon.net, qemu-devel@nongnu.org, mreitz@redhat.com, pbonzini@redhat.com


--5vNYLRcllDrimb99
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 10, 2019 at 06:51:16PM +0200, Sergio Lopez wrote:
> Perhaps it'd be worth doing a simple PoC outside QEMU, using the
> vhost-user-blk example server to avoid the block layer complexity and
> evaluate the raw benefits with different kinds of backends and
> workloads.

Sure, it's worth experimenting with.

libvirt is on top of QEMU.  oVirt or OpenStack is on top of libvirt.
It's hard for the user or management tools to set low-level tuning
options like this.  We either need smart defaults or self-tuning - knobs
are mostly useful for benchmarking and for a very small number of expert
users.

Stefan

--5vNYLRcllDrimb99
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcsJaNAAoJEJykq7OBq3PIM7cH/RiaZqwn9jCm38GW2PZ1Sdx4
Vjb0DZTStSoaPwJSKpBxC+UCoabCOV6lDC2iw9WCMXb1mFgsavayaeeMM+EIDwpp
LOyKmL/KOO8JWduYVP4NzMu32dcBAREeblocsJGfqLg6y7kcJ5RzvNZw6ExVA9NA
Xk8JvicEaGpnmSirAbovPXWWhJ1765dzXtkdKHIRJKEdPNU0bbW7zAfqIa3l00Mx
+nEZrR4//i0op+9PhPLTwHfTVPMm4A3pwbCCwxRxGzGQI+1vPZA8vtkjuO3NO9Ko
XxjOwkTCxthX20oYfufLkCLW1hfk5N0OKcHkuW6Ik4BVHPPyWD+DfuBnelkZ9kE=
=Ul9J
-----END PGP SIGNATURE-----

--5vNYLRcllDrimb99--
