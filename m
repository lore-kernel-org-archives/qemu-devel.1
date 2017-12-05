Received: from eggs.gnu.org ([2001:4830:134:3::10]:51839)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eM5Wb-000321-85
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 00:12:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eM5WS-0006QN-0P
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 00:12:03 -0500
Received: from ozlabs.org ([103.22.144.67]:41357)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1eM5WR-0006Q9-Gd
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 00:11:59 -0500
Date: Tue, 5 Dec 2017 16:11:51 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171205051151.GF3057@umbus.fritz.box>
References: <20171129084628.12336-1-david@gibson.dropbear.id.au>
	<151194617493.816.13426298875361921541@bafd83ae6430>
	<20171129091847.GC12220@lemon>
	<20171205064753-mutt-send-email-mst@kernel.org>
	<20171205050558.GA31705@lemon>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ExXT7PjY8AI4Hyfa"
Content-Disposition: inline
In-Reply-To: <20171205050558.GA31705@lemon>
Subject: Re: [Qemu-devel] [for-2.12 0/7] PCI cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, marcel@redhat.com, imammedo@redhat.com, qemu-devel@nongnu.org, ehabkost@redhat.com


--ExXT7PjY8AI4Hyfa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 05, 2017 at 01:05:58PM +0800, Fam Zheng wrote:
> On Tue, 12/05 06:49, Michael S. Tsirkin wrote:
> > On Wed, Nov 29, 2017 at 05:18:47PM +0800, Fam Zheng wrote:
> > > On Wed, 11/29 01:02, no-reply@patchew.org wrote:
> > > > /tmp/cc3Czn0R.s: Fatal error: can't write 3947 bytes to section .de=
bug_str of hw/arm/virt-acpi-build.o because: 'No space left on device'
> > >=20
> > > Hmm, the host is shared and what I have is a normal user account, so =
there is no
> > > control over disk space availability.  Anyway this is completely unre=
lated to
> > > this series. Sorry for the noise.
> > >=20
> > > Fam
> >=20
> > Could you disable this until you have the time to detect disk full
> > errors?  You are training people to ignore this bot, not a good thing.
> >=20
>=20
> Thanks for the suggestion. I've added a string match to the notification
> condition. The problem is disk is only one factor, I dream of an AI that =
can be
> trained to tell which errors are geniune bugs of the patch and which are
> environment failures... :)

Another approach would be to have a "known good" build that runs every
so often.  If the known good build fails, the bot disables itself (and
tells you to investigate).  Obviously there are ways that could not
work as well, but it should catch a fair range of spurious failures.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ExXT7PjY8AI4Hyfa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlomKpUACgkQbDjKyiDZ
s5KU7hAA2e2ktjlJSfXYdq7iPeGBlCy3k1EfzoIAnA2YvwchhZprv7q8Y2sOJdnl
Fy6gwvEj18WbPeluPuLZ0Cj5yD8AcNaL/RJ/zXo3N/i6L7RuYwcGY8TLjUo+cCEY
NJKHNQfC7GvwH8A5dgGMvl3m1uEdhuXeYpvlJtc1vFptl69hFMTflzmWHECSyuZu
zR7M/ZKSs4GvaobCubIKkpC+ActhsIXIPbMd1J3u2BF2gB3fE3AGUMiFAg3KeamJ
gJqFhMQN36dvlb+CLq0gNKigksOymkpyNZW9kezB5nQpMiUov+FfwYgD7VJfqus2
30mBBI1L5nxifxS+1zzrc5y3kU9/NWhnMpSmAf7vUyltHgJTsVPHp2htgX2UD6CG
7vmUjQW6/QtUFHM0ZVxtbsRsdsuisymqOUjX5S2ZD3N4u4KcwULPufqOYuH6xXCa
2Y6ojJfL9cn9BZuzqOuNs75d3uuBaPFGzGq0ge6MDcYjB7NyWcyuhf+oUdhucA3/
8zUejCdyS7/xADrvcqvY8AgomHBvknqzteybTLtC1t2/2Hgnmeoy9ke58xM72cbJ
S0f0soOsYgmb73YGi1/AfGdQxP3eR8qbFD3Cw3t+1gmfuhVdU/V8ykhUoEblTbGO
F/zFhEPCSZzrAVmRbesr8ccmBknd/v78RmGNrD3egdooTQydYww=
=NDh1
-----END PGP SIGNATURE-----

--ExXT7PjY8AI4Hyfa--
