Received: from eggs.gnu.org ([2001:4830:134:3::10]:53523)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fVEJ4-0007Gq-9d
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 06:56:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fVEJ1-0000S1-9O
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 06:56:14 -0400
References: <20180618215601.8974-1-mail@sebastianbauer.info>
	<20180618235557.GB25461@umbus.fritz.box>
	<73dd5b26b622e6c59776976aa2c7a3a0@sebastianbauer.info>
	<20180619043631.GC11674@umbus.fritz.box>
	<alpine.BSF.2.21.1806191218120.6476@zero.eik.bme.hu>
	<a4d4ed6dd28280922d3444364da28de0@sebastianbauer.info>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <b9819788-d8c9-d5a3-1210-9788b7e20d01@redhat.com>
Date: Tue, 19 Jun 2018 12:56:04 +0200
MIME-Version: 1.0
In-Reply-To: <a4d4ed6dd28280922d3444364da28de0@sebastianbauer.info>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH] ppc: Include vga cirrus card
 into the compiling process
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sebastian Bauer <mail@sebastianbauer.info>, BALATON Zoltan <balaton@eik.bme.hu>
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>

On 19.06.2018 12:46, Sebastian Bauer wrote:
[...]
> In my opinion, it should be added to pci.mak (and removed from all
> present configs that include pci.mak). There is also CONFIG_VGA_PCI
> there, a bunch of network cards and other stuff. The Cirrus VGA is just
> another PCI card that one could plug into any systems that has a PCI(e)
> bus, also on physical hardware (whether it is supported by which guests
> is a different question).
> 
> However, I wanted to be conservative with my change so I added it only
> to the 32 bit PPC branch, because this is the platform that I can easily
> test. Does anybody know why CONFIG_VGA_CIRRUS is selectively enabled for
> PCI-based systems? What would speak against adding it to pci.mak?

I've got no real clue, but I think the Cirrus card is rather considered
as ugly legacy these days, e.g. see:

https://www.kraxel.org/blog/2014/10/qemu-using-cirrus-considered-harmful/

So I think it should not be added to boards that do not really need it.

 Thomas
