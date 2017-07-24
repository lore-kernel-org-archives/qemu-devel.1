Received: from eggs.gnu.org ([2001:4830:134:3::10]:54215)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1dZbDD-000387-Mc
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 07:07:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1dZbDA-0001Qu-I9
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 07:07:43 -0400
Message-ID: <1500894439.10674.76.camel@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Mon, 24 Jul 2017 21:07:19 +1000
In-Reply-To: <20170724095052.GO17228@umbus.fritz.box>
References: <1499274819-15607-1-git-send-email-clg@kaod.org>
	<1499274819-15607-9-git-send-email-clg@kaod.org>
	<20170724043624.GE17228@umbus.fritz.box>
	<1500879657.10674.64.camel@kernel.crashing.org>
	<20170724095052.GO17228@umbus.fritz.box>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 08/26] ppc/xive: add flags to the XIVE
 interrupt source
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On Mon, 2017-07-24 at 19:50 +1000, David Gibson wrote:
> On Mon, Jul 24, 2017 at 05:00:57PM +1000, Benjamin Herrenschmidt wrote:
> > On Mon, 2017-07-24 at 14:36 +1000, David Gibson wrote:
> > > On Wed, Jul 05, 2017 at 07:13:21PM +0200, C=C3=A9dric Le Goater wro=
te:
> > > > These flags define some characteristics of the source :
> > > >=20
> > > >  - XIVE_SRC_H_INT_ESB  the Event State Buffer are controlled with=
 a
> > > >                        specific hcall H_INT_ESB
> > >=20
> > > What's the other option?
> >=20
> > Direct MMIO access. Normally all interrupts use normal MMIOs,
> > each interrupts has an associated MMIO page with special MMIOs
> > to control the source state (PQ bits). This is something I added
> > to the PAPR spec (and the OPAL <-> Linux interface) to allow firmware
> > to work around broken HW (which happens on some P9 versions).
>=20
> Ok.. and that's something that can be decided at runtime?

Well, at this point I think nothing will set that flag.... It's there
for workaround around HW bugs on some chips. At least in full emu it
shouldn't happen unless we try to emulate those bugs. Hopefully direct
MMIO will just work.

Ben.
