Received: from eggs.gnu.org ([2001:4830:134:3::10]:34760)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1dZtg7-0005T4-Fy
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 02:50:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1dZtg6-0005JR-Kw
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 02:50:47 -0400
Message-ID: <1500961657.10674.105.camel@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 25 Jul 2017 15:47:37 +1000
In-Reply-To: <20170725041841.GA8978@umbus.fritz.box>
References: <1499274819-15607-1-git-send-email-clg@kaod.org>
	<1499274819-15607-9-git-send-email-clg@kaod.org>
	<20170724043624.GE17228@umbus.fritz.box>
	<1500879657.10674.64.camel@kernel.crashing.org>
	<20170724095052.GO17228@umbus.fritz.box>
	<1500894439.10674.76.camel@kernel.crashing.org>
	<20170725041841.GA8978@umbus.fritz.box>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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

On Tue, 2017-07-25 at 14:18 +1000, David Gibson wrote:
> > Well, at this point I think nothing will set that flag.... It's there
> > for workaround around HW bugs on some chips. At least in full emu it
> > shouldn't happen unless we try to emulate those bugs. Hopefully direct
> > MMIO will just work.
> 
> Hm.  That doesn't seem like a good match for a per-irq state
> structure.

The flag is returned to the guest on a per-IRQ basis, so are the LSI
etc... flags, but at the HW level, indeed, they correspond to
attributes of blocks of interrupts.

It might be easier in qemu to keep that in the per-source flags
though.

Especially when we start having actual HW interrupts under the
hood with KVM. it's easier to keep the state self contained
for each of them.

Ben.
