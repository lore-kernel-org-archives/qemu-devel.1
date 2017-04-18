Received: from eggs.gnu.org ([2001:4830:134:3::10]:45561)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d0UUA-0005OX-P3
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 10:52:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d0UU7-00089R-Fk
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 10:52:06 -0400
Received: from mail-wm0-x233.google.com ([2a00:1450:400c:c09::233]:37130)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1d0UU7-00088n-8C
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 10:52:03 -0400
Received: by mail-wm0-x233.google.com with SMTP id u2so57240199wmu.0
	for <qemu-devel@nongnu.org>; Tue, 18 Apr 2017 07:52:03 -0700 (PDT)
Date: Tue, 18 Apr 2017 15:52:00 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170418145200.GK21261@stefanha-x1.localdomain>
References: <CAGKXQyeSAEHTnkvbjK8gSWf2GXH7Sqxp71N10r2sUdJubFC+RA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EVcIhgQsEzAXu06J"
Content-Disposition: inline
In-Reply-To: <CAGKXQyeSAEHTnkvbjK8gSWf2GXH7Sqxp71N10r2sUdJubFC+RA@mail.gmail.com>
Subject: Re: [Qemu-devel] help for code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: ali saeedi <ali.saeedi56@gmail.com>
Cc: qemu-devel@nongnu.org


--EVcIhgQsEzAXu06J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 12, 2017 at 04:36:58PM +0430, ali saeedi wrote:
> I am new in qemu vm live migration. why we have this condition
> "current_time >= initial_time + BUFFER_DELAY" in qemu?

BUFFER_DELAY is used for rate-limiting.  The maximum network throughput
can be set by the user so that QEMU doesn't hog the network link.

Rate-limit calculations are done every BUFFER_DELAY time interval.

Stefan

--EVcIhgQsEzAXu06J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY9igQAAoJEJykq7OBq3PI3QIH/3DB7B/c2KVviOLr0ZZbvJjt
G33IoqgK8aQy7eO//PSrvRGADw0Z2qnnXI/SQEG2vM+9HYZbS/DyDWIVuRzkz0Yl
oRDAtYL+gwe5pQJ7zXxMt9WsYCoP0uLNqzFnGZUyLGTduB9w6KA0BS+wq7B7AFle
fTkWrlbuHNNkxAZZpenXoy2O3+nZ2xfr6vOsp/ddARt2Ei9nDnIS+QfGM9KsLMRT
/nV0DRNhC1F5Q5vHM3FDzoYcyL+wzfBUpuVKYuNMCju+uho8lAuGc4LWEoInw1fD
Znwryfb6SyE1EtMpPNFt1pTIh1X/f66eAIG53ocnfcTcnhVOV9WYHQObXI8DBsE=
=1k+1
-----END PGP SIGNATURE-----

--EVcIhgQsEzAXu06J--
