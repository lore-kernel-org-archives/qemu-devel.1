Received: from eggs.gnu.org ([2001:4830:134:3::10]:60166)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cjcgj-00084D-5f
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 21:11:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cjcgg-0003Mt-0r
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 21:11:21 -0500
Date: Fri, 3 Mar 2017 10:11:09 +0800
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170303021109.GA11833@stefanha-x1.localdomain>
References: <20170301115026.22621-1-stefanha@redhat.com>
	<20170301222748.2c7a3ead@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="u3/rZRmxL6MmkK24"
Content-Disposition: inline
In-Reply-To: <20170301222748.2c7a3ead@bahia.lan>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v3 0/3] throttle: improve
 command-line parameter documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Nini Gu <ngu@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 01, 2017 at 10:27:48PM +0100, Greg Kurz wrote:
> On Wed,  1 Mar 2017 11:50:23 +0000
> Stefan Hajnoczi <stefanha@redhat.com> wrote:
>=20
> > v3:
> >  * Added Patch 2 to fix invalid test parameters
> >  * Switched to nicer max < avg check [Berto]
> > v2:
> >  * Fixed s/bps/iops/ copy-paste error in Patch 1 [Berto]
> >  * Rephrased warning about guest hangs and errors [Berto]
> >  * Added Patch 2 to hide the internal .max value from the monitor
> >=20
> > Patch 1 fleshes out the documentation for I/O throttling command-line
> > parameters.
> >=20
> > Patch 2 hides an internal value that was being exposed to users via the
> > monitor and caused confusion.
> >=20
> > I ended up not adding QMP-style throttling.* names to the command-line
> > documentation because the names are very long and unlikely to be used. =
 I
> > couldn't see a nice way of adding them while still keeping the document=
ation
> > readable.
> >=20
>=20
> I only see this series now and it's a bit unfortunate... throttling optio=
ns
> are now also available for fsdev. Only QMP-style names were added though,
> and they appear in the documentation. I agree the names are long, and the
> result isn't pretty on 80 columns, but it is readable still.
>=20
> I don't really want to add code, just to have shorter names and a prettier
> output. But it would be a good thing for fsdev to benefit from this new
> documentation... any suggestion how to do that ?

I think another patch series would be good to:
1. Document QMP-style names for -drive
2. Reference throttling parameter documention in a common place for both
   -fsdev and -drive.

I'll do that.  This is QEMU 2.10 material anyway (it has missed the
freeze deadline), so there's no time pressure.

Stefan

--u3/rZRmxL6MmkK24
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYuNC9AAoJEJykq7OBq3PILKMIAJ/mPkF1JB1OR5GHzKma9Sjv
tqpFBW4D1GGNCXXHHrpcGcE0upYRdw61R+RBmNGW9RxZI4f53yRkZRje++ghvxe5
XITJY0t7mmJhKkhRzrrDXucbGYJ8ycUvZcj7OoprjjF0Ims3amDsfq/GZR40LkzX
Hkv2E3m9tlkZHCl4rFAQg2En5T08hLMy87/w110b11ktI2XF+bWorJ7bpnKbd0dH
Rygsme2doDMhxgPSPjcVhZ2bOEUEWgPCQ5x3djiD/jrhKacR++alPm2B1Y/OfSUs
db0Xx8DuH5xFW9bxcxCI25f75JdlI0ZNFPA62mwXMmlvfK12gdx6N/YIgK1E6OI=
=mJgz
-----END PGP SIGNATURE-----

--u3/rZRmxL6MmkK24--
