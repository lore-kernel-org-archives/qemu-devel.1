Received: from eggs.gnu.org ([2001:4830:134:3::10]:55972)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eX5QK-0000BK-GK
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 08:19:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eX5QJ-0004cF-OI
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 08:19:08 -0500
Date: Thu, 4 Jan 2018 13:18:58 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180104131858.GE10106@stefanha-x1.localdomain>
References: <1513595351-5899-1-git-send-email-den@openvz.org>
	<1513595351-5899-4-git-send-email-den@openvz.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cPi+lWm09sJ+d57q"
Content-Disposition: inline
In-Reply-To: <1513595351-5899-4-git-send-email-den@openvz.org>
Subject: Re: [Qemu-devel] [PATCH 3/5] block/parallels: move some structures
 into header
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Denis V. Lunev" <den@openvz.org>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Klim Kireev <klim.kireev@virtuozzo.com>


--cPi+lWm09sJ+d57q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 18, 2017 at 02:09:09PM +0300, Denis V. Lunev wrote:
> +#ifndef BLOCK_PARALLELS_H
> +#define BLOCK_PARALLELS_H
> +#include "qemu/module.h"

Does anything in this file require module.h?

Also, the include for CoMutex is missing.  Please make sure this header
file includes necessary dependencies except for "qemu/osdep.h".

--cPi+lWm09sJ+d57q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaTinCAAoJEJykq7OBq3PIr8MH/jPMJnlON+D/Gq9zPSbfE8Hr
Ewx1brXgrAruRl7i9MtyVGBye1ufe8/tSc8+HSmnAvxm1IZ8eirI1N9TazPvln19
gdGo1x4o2xAmBXN4ytGOy9K69Nc+t3f2hmTzg20UVVQBxAf8ZWXMx/hsPI1SDrVc
wS0DimvNczztaFkkzfN3iBk7+TAF2crtp1reuVsN8QHryb+J4D3Bylv3lDb/bwhE
++GuKy/hwLymY9MfuTQ6fWNgEMwyw1ElU4MoY2INf1rCQ/3yPLbOXw/lFrHIAgIA
E41NUkP4bFwkwCa7ZGIWhynI3v1rSihBvkAa92ADIsXkcqjg3rcn/s11ZwTkpK4=
=a4lO
-----END PGP SIGNATURE-----

--cPi+lWm09sJ+d57q--
