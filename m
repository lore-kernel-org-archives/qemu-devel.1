Received: from eggs.gnu.org ([2001:4830:134:3::10]:49139)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f96Ai-0007GJ-3a
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 05:48:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f96Ah-0004aj-2w
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 05:48:08 -0400
Date: Thu, 19 Apr 2018 19:47:45 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180419094745.GL2317@umbus.fritz.box>
References: <1524061685-83305-1-git-send-email-imammedo@redhat.com>
	<1524061685-83305-3-git-send-email-imammedo@redhat.com>
	<20180419041520.GJ2317@umbus.fritz.box>
	<20180419103019.39f8850a@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="DN8g+DOX2TxGxleI"
Content-Disposition: inline
In-Reply-To: <20180419103019.39f8850a@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.13 v2 2/5] ppc: e500: switch E500
 based machines to full machine definition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, eric.auger@redhat.com, Alexander Graf <agraf@suse.de>, "open list:e500" <qemu-ppc@nongnu.org>


--DN8g+DOX2TxGxleI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 19, 2018 at 10:30:19AM +0200, Igor Mammedov wrote:
> On Thu, 19 Apr 2018 14:15:20 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > On Wed, Apr 18, 2018 at 04:28:02PM +0200, Igor Mammedov wrote:
> > > Convert PPCE500Params to PCCE500MachineClass which it essentially is,
> > > and introduce PCCE500MachineState to keep track of E500 specific
> > > state instead of adding global variables or extra parameters to
> > > functions when we need to keep data beyond machine init
> > > (i.e. make it look like typical fully defined machine).
> > >=20
> > > It's pretty shallow conversion instead of currently used trivial
> > > DEFINE_MACHINE() macro. It adds extra 60LOC of boilerplate code
> > > of full machine definition.
> > >=20
> > > The patch on top[1] will use PCCE500MachineState to keep track of
> > > platform_bus device and add E500Plate specific machine class
> > > to use HOTPLUG_HANDLER for explicitly initializing dynamic
> > > sysbus devices at the time they are added instead of delaying
> > > it to machine done time by platform_bus_init_notify() which is
> > > being removed.
> > >=20
> > > 1)  <1523551221-11612-3-git-send-email-imammedo@redhat.com>
> > >=20
> > > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > > Suggested-by: David Gibson <david@gibson.dropbear.id.au> =20
> >=20
> > As noted elsewhere, I've already merged this into my ppc-for-2.13
> > tree.  However, don't let that stop you from posting and/or queueing
> > it elsewhere.  Whoever ends up merging first once 2.13 opens, it
> > should be easy to resolve.
> Yep, that's been intention, i.e. have whole series on list so
> reader won't have to hunt for queued dependencies in different trees.
> After all it's trivial to fix merge conflict when path is merged
> in several trees.

Right, I figured.  Just making sure it was clear that me merging it
didn't mean I wanted you to exclude it from your own queue.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--DN8g+DOX2TxGxleI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlrYZbsACgkQbDjKyiDZ
s5LFFRAA5Z8F1NFJOFnX/sfhoF79+ECjJubBvFOQV/xnzTwBeDqDcguyJIAx27bA
xbp5RFs7e2E7aaGf49vINGrdR6vVygoOEXfXtSDYkBzAK7e3gm3sldSTj/KFRlaP
h1FBzMme4tSmFYkEFD6xgNvY05VG27PEpv/9oEzTAPWwSpWRBorG0eFchsieySNu
IBPgEiDO3DFHZVfYLyEOzhPMoZBoHlnekpWllRhx00ARpY8twRXk8dma4qu5mt7+
0pHJrQ206Bi6xeHKYdYJovZfu+YhCogkvoXM+P7TKVq0AEAzy8ly9urDy2H4sscc
N9vPI87RDL0aKkKph8k6tn3pjg0DckGTI8iqWjvmlCV4GE8yHQyI4/9GClYbq2pC
bUdnPZe4O/RZfhW499bXfDJny89bun9JXv0rbLPbPYYm6o8/cQmEf7Q177eJGh2p
7/2mTJsLcSsK7FH8y47eHiO+XAGKw2v3CgOlnq6yol5Moyp9zayuIGvpj7bVjJdY
2IzeVsXMQDWslpBxRYh2JehDS57djygwKWwCFFeiUxUdKOOiHpSzrEDhr0f70Z9S
CpdPZ4639U7bhv4qbT5lp/0Vuszt1bOoh6XzmJwdOErh88aFeFxIXYYzq/v19nKt
VQ90KpEK6Ri6zpz04nJLNMS3RCQtFGwoCXKMcRFQbB6p301WSJk=
=yfHk
-----END PGP SIGNATURE-----

--DN8g+DOX2TxGxleI--
