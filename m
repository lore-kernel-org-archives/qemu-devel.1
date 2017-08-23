Received: from eggs.gnu.org ([2001:4830:134:3::10]:57367)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dkWAW-0002J7-0o
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 09:58:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dkWAT-0001rn-Eg
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 09:58:04 -0400
Message-ID: <1503496678.16071.22.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 23 Aug 2017 15:57:58 +0200
In-Reply-To: <20170821041847.GG12356@umbus.fritz.box>
References: <cover.1503249785.git.balaton@eik.bme.hu>
	<e6021f12f4e245dc2162a6ab479d416374efc799.1503249785.git.balaton@eik.bme.hu>
	<20170821041847.GG12356@umbus.fritz.box>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 04/15] ehci: Add ppc4xx-ehci for the USB
 2.0 controller in embedded PPC SoCs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Alexander Graf <agraf@suse.de>, Francois Revol <revol@free.fr>

On Mon, 2017-08-21 at 14:18 +1000, David Gibson wrote:
> On Sun, Aug 20, 2017 at 07:23:05PM +0200, BALATON Zoltan wrote:
> > Some PPC SoCs have an EHCI with OHCI companion USB controller. Add
> > a
> > new type for this similar to types used for other embedded SoCs.
> > 
> > Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> 
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> 
> Gerd, again, if it's convenient to you, I can queue this for 2.11.

Yes please.  I think merging this way it is easier, patches later in
this series probably depend on these two usb patches.

Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>

cheers,
  Gerd
