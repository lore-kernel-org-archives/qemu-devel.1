Received: from eggs.gnu.org ([2001:4830:134:3::10]:51762)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mail@sebastianbauer.info>) id 1fVE9P-00042R-Pj
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 06:46:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mail@sebastianbauer.info>) id 1fVE9P-0005KG-2F
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 06:46:15 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Tue, 19 Jun 2018 12:46:01 +0200
From: Sebastian Bauer <mail@sebastianbauer.info>
In-Reply-To: <alpine.BSF.2.21.1806191218120.6476@zero.eik.bme.hu>
References: <20180618215601.8974-1-mail@sebastianbauer.info>
	<20180618235557.GB25461@umbus.fritz.box>
	<73dd5b26b622e6c59776976aa2c7a3a0@sebastianbauer.info>
	<20180619043631.GC11674@umbus.fritz.box>
	<alpine.BSF.2.21.1806191218120.6476@zero.eik.bme.hu>
Message-ID: <a4d4ed6dd28280922d3444364da28de0@sebastianbauer.info>
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
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: David Gibson <david@gibson.dropbear.id.au>, thuth@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

Am 2018-06-19 12:23, schrieb BALATON Zoltan:
> On Tue, 19 Jun 2018, David Gibson wrote:
>> Ok.  However, your patch doesn't apply against the ppc-for-3.0 tree.
>> It looks like you've made it against a tree including some of BALATON
>> Zoltan's proposed but not yet merged patches.
> I've sent those patches as well. But if this also works with pseries
> maybe it does not have to be in the For sam460ex part of the config
> but could be on it's own with a comment saying that multiple machines
> can use it.

In my opinion, it should be added to pci.mak (and removed from all 
present configs that include pci.mak). There is also CONFIG_VGA_PCI 
there, a bunch of network cards and other stuff. The Cirrus VGA is just 
another PCI card that one could plug into any systems that has a PCI(e) 
bus, also on physical hardware (whether it is supported by which guests 
is a different question).

However, I wanted to be conservative with my change so I added it only 
to the 32 bit PPC branch, because this is the platform that I can easily 
test. Does anybody know why CONFIG_VGA_CIRRUS is selectively enabled for 
PCI-based systems? What would speak against adding it to pci.mak?

Bye
Sebastian
