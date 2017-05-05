Received: from eggs.gnu.org ([2001:4830:134:3::10]:53870)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d6cmP-0000H6-L1
	for qemu-devel@nongnu.org; Fri, 05 May 2017 08:56:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d6cmM-0006H2-JP
	for qemu-devel@nongnu.org; Fri, 05 May 2017 08:56:17 -0400
Date: Fri, 5 May 2017 13:56:09 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170505125609.GC11350@stefanha-x1.localdomain>
References: <20170420120058.28404-1-pbonzini@redhat.com>
	<20170420120058.28404-18-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hOcCNbCCxyk/YU74"
Content-Disposition: inline
In-Reply-To: <20170420120058.28404-18-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 17/17] block: make accounting
 thread-safe
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org


--hOcCNbCCxyk/YU74
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 20, 2017 at 02:00:58PM +0200, Paolo Bonzini wrote:
> I'm not trying too hard yet.  Later, with multiqueue support,
> this may cause cacheline bouncing.

This patch calls qemu_clock_get_ns() within a spinlock region.  It's
probably just a memory load, rdtsc, and some math but more heavy-weight
code paths are possible too.

Taking the clock reading outside the lock region should be fine and
reduces the chance of contention.

--hOcCNbCCxyk/YU74
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZDHZpAAoJEJykq7OBq3PIxf4H/RfwA17wxLEHvBQsfcgM/PLe
57Raay5GQ3gUxuK+GTCFsQUsZEuJIJD19K1kAHykCPArURZRLHEL4LfQKwm20boW
DdftypLy6fuIf1NyyjdqRKrBVm+3pt2kLg0efBCRTeqwcoYI65FUNwg9aw/4oyCm
vot8Dvh7Hr5WT9aGkRUzK2d4toz3oLfd0PwmoEmrcwgBiV9CkNPxRvd4rd0rTuGv
AlO6jmf1KUnsQLml/MgQfyWIUx8EpRcNKzo59WUlFLmOr7xnB1xPyjxFVHbUuXHl
Oh0TQiYuIrOvu0zahSjoDixBEMjfleEapSy+Wk2PxnvodQfKReUqNWlnA/y2ELQ=
=QkHj
-----END PGP SIGNATURE-----

--hOcCNbCCxyk/YU74--
