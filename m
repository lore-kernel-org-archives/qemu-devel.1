Received: from eggs.gnu.org ([2001:4830:134:3::10]:53289)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dWD23-0007Bo-2R
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 22:42:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dWD22-0002WP-3q
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 22:42:11 -0400
Date: Sat, 15 Jul 2017 12:39:43 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170715023943.GG17539@umbus.fritz.box>
References: <20170714061521.28300-1-david@gibson.dropbear.id.au>
	<CAFEAcA9H7td0EogiAcp3rL6CB46fvq8fJbDBCZw1R3Z8Ch0AvA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="8bBEDOJVaa9YlTAt"
Content-Disposition: inline
In-Reply-To: <CAFEAcA9H7td0EogiAcp3rL6CB46fvq8fJbDBCZw1R3Z8Ch0AvA@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL 00/18] ppc-for-2.10 queue 20170714
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Alexander Graf <agraf@suse.de>, QEMU Developers <qemu-devel@nongnu.org>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, Greg Kurz <groug@kaod.org>, Suraj Jitindar Singh <sjitindarsingh@gmail.com>, sbobroff@au1.ibm.com, Laurent Vivier <lvivier@redhat.com>


--8bBEDOJVaa9YlTAt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 14, 2017 at 11:25:01AM +0100, Peter Maydell wrote:
> On 14 July 2017 at 07:15, David Gibson <david@gibson.dropbear.id.au> wrot=
e:
> > The following changes since commit 49bcce4b9c11759678fd223aefb48691c495=
9d4f:
> >
> >   Merge remote-tracking branch 'remotes/armbru/tags/pull-qapi-2017-07-1=
2' into staging (2017-07-13 16:56:06 +0100)
> >
> > are available in the git repository at:
> >
> >   git://github.com/dgibson/qemu.git tags/ppc-for-2.10-20170714
> >
> > for you to fetch changes up to e11134d2ac7744569d7c387102368c507d340c30:
> >
> >   pseries: Allow HPT resizing with KVM (2017-07-14 09:28:30 +1000)
> >
> > ----------------------------------------------------------------
> > ppc patch queue 2017-07-14
> >
> > Two major batches in this set, rather than the usual collection of
> > assorted fixes.
> >
> >     * More DRC cleanup.  This gets the state management into a state
> >       which should fix many of the hotplug+migration problems we've
> >       had.  Plus it gets the migration stream format into something
> >       well defined and pretty minimal which we can reasonably support
> >       into the future.
> >
> >     * Hashed Page Table resizing.  It's been a while since this was
> >       posted, but it's been through several previous rounds of review.
> >       The kernel parts (both guest and host) are merged in 4.11, so
> >       this is the only remaining piece left to allow resizing of the
> >       HPT in a running guest.
> >
> > There are also a handful of unrelated fixes.
>=20
> I see Alex Graf's update to the e500 u-boot image didn't make
> it in to this -- are you planning to send that separately
> or should I pick it up directly? (I definitely would like to
> see that in the 2.10 release, because it fixes a problem where
> our u-boot sources are (a) very old and (b) not even the version
> corresponding to the binary blob we ship...)

Oh, I didn't spot that one.  Can you take it directly?

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--8bBEDOJVaa9YlTAt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAllpgG8ACgkQbDjKyiDZ
s5Kexw/+KdIBH75dXmCItBPGcldSl6bRaEA6LnrP3mfQhO8DOuzxKFjRV9WobT3f
xFdrL4ELDUoSEgR5WUJfouGbNlQ081p2mPBAGiXdg7Tl6Z2UEZ+y9rTie+tYDvRz
HMuvX6Z4X8iTUuINXH6u3eNu8rjd8F81AeNq84FU9z/lQg7gEmMh9BmRYijO65oG
mRap4KtFCuacR2HNOJ8rp3v+HRAxQfrfyfu67Y7PKk+EBEn1sWFesAbUiTOME2UQ
IZF3x+xY4Y7Bs21i2BuGjdiNsTeemkZZm39mOo8v+NK7LGShASj8djrd0AeYMzQq
yGI7hEZFT1MjRCCN8KP/yPQgQ09mSxHuZHpa/pf56CPgUXB8iyzh7MR9XKnJQjtn
XooCixD39KmJJDXii8uHBBAufLuykSaqvjjaAxwwz/SYp37WyLlzo7H9Bi4glq8Z
TblWVvj3U9jLKSfUB5J9yf6uejywm36yNG5l+Jq4HghqXyJiKP8YzGoY5Z8p1QPj
MMOMavNJrsMGsZkn+8G0rtZX5nQonu3jo0y2/HXuu9ZOYLmc93TJtr0OkZEYVav5
SSwpM9FwvGNnhlIb9VI8yl+NEnAgM9GSlk88nAtr0XqCSR2Iq3rNzJzqhSViuPhd
+v3YuKD/PWhh9vlKlYTYN+TfDql1aqOQAkXvBEA87y3cytqdg3w=
=1SSi
-----END PGP SIGNATURE-----

--8bBEDOJVaa9YlTAt--
