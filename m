Received: from eggs.gnu.org ([2001:4830:134:3::10]:54438)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1dhDM2-00028v-9x
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 07:16:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1dhDLz-0000fa-3V
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 07:16:18 -0400
Date: Mon, 14 Aug 2017 13:16:13 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <20170814044233.GF3452@umbus.fritz.box>
Message-ID: <alpine.BSF.2.21.1708141306530.10227@zero.eik.bme.hu>
References: <cover.1502643878.git.balaton@eik.bme.hu>
	<9a1b25fc97fa35cd8c6294b1014931d832ef8240.1502643878.git.balaton@eik.bme.hu>
	<20170814044233.GF3452@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: Re: [Qemu-devel] [RFC PATCH 08/12] hw/ide: Emulate SiI3112 SATA
 controller
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Alexander Graf <agraf@suse.de>, Francois Revol <revol@free.fr>

On Mon, 14 Aug 2017, David Gibson wrote:
> On Sun, Aug 13, 2017 at 07:04:38PM +0200, BALATON Zoltan wrote:
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>
> Needs a commit message: where does this controller appear? what's
> distinctive about it? is there a link to a datasheet or programming manual?

This is just a generic PCI SATA controller, quite common and also used in 
PCs. Nothing special about it apart from guests running on Sam460ex 
usually have a driver for it (unlike other already emulated SATA 
controllers) and it is simpler to implement than the on board SATA 
controller of the 460EX and also has two ports instead of one so more 
useful to have.

I could add this as commit message if you think that would be better or 
just submit it separately through the IDE branch then use from these 
patch series.

Regards,
BALATON Zoltan
