Received: from eggs.gnu.org ([2001:4830:134:3::10]:45675)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cdTpB-0003Qi-LI
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 22:30:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cdTp8-0004Lb-Bh
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 22:30:41 -0500
Date: Tue, 14 Feb 2017 14:23:48 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170214032348.GE2169@umbus.fritz.box>
References: <4c44ad5045020be90edfdc8787002e09691db1d3.1479770377.git.sam.bobroff@au1.ibm.com>
	<20170213053340.GC25381@umbus>
	<602f2661-0d45-d135-e3f8-64426329a736@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/2994txjAzEdQwm5"
Content-Disposition: inline
In-Reply-To: <602f2661-0d45-d135-e3f8-64426329a736@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v3 1/1] hw/net/spapr_llan: 6
 byte mac address device tree entry
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Sam Bobroff <sam.bobroff@au1.ibm.com>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--/2994txjAzEdQwm5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 13, 2017 at 08:36:45AM +0100, Thomas Huth wrote:
> On 13.02.2017 06:33, David Gibson wrote:
> > On Tue, Nov 22, 2016 at 10:19:38AM +1100, Sam Bobroff wrote:
> >> The spapr-vlan device in QEMU has always presented it's MAC address in
> >> the device tree as an 8 byte value, even though PAPR requires it to be
> >> 6 bytes.  This is because, at the time, AIX required the value to be 8
> >> bytes.  However, modern versions of AIX support the (correct) 6
> >> byte value so they no longer require the workaround.
> >>
> >> It would be neatest to always provide a 6 byte value but that would
> >> cause a problem with old Linux kernel ibmveth drivers, so the old 8
> >> byte value is still presented when necessary.
> >>
> >> Since commit 13f85203e (3.10, May 2013) the driver has been able to
> >> handle 6 or 8 byte addresses so versions after that don't need to be
> >> considered specially.
> >>
> >> Drivers from kernels before that can also handle either type of
> >> address, but not always:
> >> * If the first byte's lowest bits are 10, the address must be 6 bytes.
> >> * Otherwise, the address must be 8 bytes.
> >> (The two bits in question are significant in a MAC address: they
> >> indicate a locally-administered unicast address.)
> >>
> >> So to maintain compatibility the old 8 byte value is presented when
> >> the lowest two bits of the first byte are not 10.
> >>
> >> Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>
> >=20
> > Sorry, I didn't see this one until now.
> >=20
> > Since we need a workaround for the workaround, is it actually worth
> > going to the 6-byte property?
>=20
> 8-byte addresses are just wrong, all other network devices and the
> standard use 6-byte MAC addresses instead. So we should use 6-byte
> addresses in QEMU whenever it is possible, too. Unfortunately there are
> still guests in the field that use this bad assumption with 8 byte
> addresses, so I think this work-around is the best we can and should do
> right now.

Hm, yes, good point.  Applied to ppc-for-2.9.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--/2994txjAzEdQwm5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYonhCAAoJEGw4ysog2bOS2F4QAJTePCsmPjWybnds9fLSxi90
7qdwzpUBclu9UxOMF3K6AVN0lmOaws6+wiUGhdeYRXH2yXkXIReenZYF4HFuQseL
XmF9P1emHbmxh8oECyZ3+AraFyQGvjxzEwnm8SPXH+wIEvO93h/aWoAZosEYvvq5
LyAGcPCGTklGfSxMLAQz4OdvR/o8PlQJnJ423MWWRluFt8XZkGRh4poKKd32WZuX
fpxLCmEK7XD642v8IU4P19nU7hQrG332Ehet/zrzJDirBjgCRN8pcQpq7Aa6XVNm
Yx1PRrS/xwXbTT7PM8VruizYATt7BkRve5TS9g5cjbZrKd7TreN1n8coBDpRvUA+
sHjmWjThSPibXn218nZWCXhLya+ChjGTzoILKusyhNzVglAG4MxlvPPUG15PPuYW
xg9kK06q5E34mNRphoUO18lBTzy0mPdKZUlBRe52NjuaSFXir5FEreUI3WxwxKJP
H26EaDGGDvTHQmAlBZDTjtaKcRpeOvyDrxcnh6GHLTNIV5kqSNhm6rfWe+VYKITZ
mZfhqXwve/ev6F1w3w8jtbWSYaXeTJqKJZdEoBBw15RWjABGzEdvf9LrvtTqfAX5
zF6+SYmvnFJftFzZVlabMAmsyxfD/FGKTW5zApGLVbe9CjGZiaCTmiO3bkkcG1LR
3dgTBNyc75eBe5NjKCYM
=s2kC
-----END PGP SIGNATURE-----

--/2994txjAzEdQwm5--
