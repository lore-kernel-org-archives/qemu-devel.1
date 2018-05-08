Received: from eggs.gnu.org ([2001:4830:134:3::10]:33843)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fG1Jf-0002xt-DX
	for qemu-devel@nongnu.org; Tue, 08 May 2018 08:02:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fG1JW-0006fG-1G
	for qemu-devel@nongnu.org; Tue, 08 May 2018 08:01:59 -0400
Date: Tue, 8 May 2018 13:01:46 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180508120146.GJ19710@stefanha-x1.localdomain>
References: <20180503090532.3113-1-joel@jms.id.au>
	<20180503090532.3113-2-joel@jms.id.au>
	<CAFEAcA_4EiWXdSNdbiEWO_Q2Sac7qzNduhyWVNwW-crc5=w_nA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZG+WKzXzVby2T9Ro"
Content-Disposition: inline
In-Reply-To: <CAFEAcA_4EiWXdSNdbiEWO_Q2Sac7qzNduhyWVNwW-crc5=w_nA@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] arm: Add Nordic Semiconductor nRF51 SoC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Joel Stanley <joel@jms.id.au>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Andrew Jeffery <andrew@aj.id.au>, Jim Mussared <jim.mussared@gmail.com>


--ZG+WKzXzVby2T9Ro
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 03, 2018 at 10:17:51AM +0100, Peter Maydell wrote:
> On 3 May 2018 at 10:05, Joel Stanley <joel@jms.id.au> wrote:
> I'm a bit reluctant to take these patches until we have an
> actual cortex-m0 model, because anything we take into QEMU
> master is then something we have to support. My rule of thumb
> is that it's ok to have board models that are missing
> functionality, but we should avoid models that have wrong
> functionality (like the wrong CPU) where we can.

For the purposes of the micro:bit emulation project we're not sure yet
how far the M3 model will take us.  The M0 is a subset of the M3 and we
intend to use it during bring-up...and even afterwards if software runs
okay with it.

If you don't want to merge this into qemu.git/master we'll have to
maintain a "microbit" project branch on which Julia and Steffen (and
others) can work during the Google Summer of Code and Outreachy period.

My concern about keeping it out-of-tree is that we want Julia and
Steffen to participate in the upstream community and get their patches
merged.  Anything out-of-tree could still be rejected at a later date
:(.

Can we mark the machine type "experimental" and merge it in
qemu.git/master with the understanding that it may be removed if there
is no active development?

Stefan

--ZG+WKzXzVby2T9Ro
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJa8ZGqAAoJEJykq7OBq3PIaE0H/3cns7lplbrLFQTQcgi2VTvl
SDz1njVbhEGY0FzzH/oiNUiGDSt4NwjKXRD0od/N5xb/Bb6a/NqpnRUCILpr3eQ+
520mmazWazsiqgmCbdHiONSKatDKJKiXTPztnVgAHH2l/7i/DhfmGwZl+rSTArY2
mYFBbKXgf9qXoGjwx7dPSsNsDrI5P6IHAr8EZOfxF0lo4afMdabP54qhcdZiZu4M
8NjoDl2eEJ/0AgwuFyktg/lGK1DjrQF3sml8i5Sm+dVfISPFAvM1IyrGHBqjQbHL
w5EoMO0dEl7Hp244cNARx1xUSg2Um1jI2mllCxRBr21mUO/uHOJ2T5+Xl3eC120=
=DqKL
-----END PGP SIGNATURE-----

--ZG+WKzXzVby2T9Ro--
