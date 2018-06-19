Received: from eggs.gnu.org ([2001:4830:134:3::10]:46732)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fVDn9-0006Uy-EU
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 06:23:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fVDn4-0006ip-JB
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 06:23:15 -0400
Date: Tue, 19 Jun 2018 12:23:08 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <20180619043631.GC11674@umbus.fritz.box>
Message-ID: <alpine.BSF.2.21.1806191218120.6476@zero.eik.bme.hu>
References: <20180618215601.8974-1-mail@sebastianbauer.info>
	<20180618235557.GB25461@umbus.fritz.box>
	<73dd5b26b622e6c59776976aa2c7a3a0@sebastianbauer.info>
	<20180619043631.GC11674@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
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
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Sebastian Bauer <mail@sebastianbauer.info>, thuth@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On Tue, 19 Jun 2018, David Gibson wrote:
> On Tue, Jun 19, 2018 at 06:32:55AM +0200, Sebastian Bauer wrote:
>> Am 2018-06-19 01:55, schrieb David Gibson:
>>> Have you checked the Cirrus VGA actually works on a ppc machine?
>>
>> Yes, it works for AmigaOS guests. Better than the sm501 for
>> instance.
>
> Ok.  However, your patch doesn't apply against the ppc-for-3.0 tree.
> It looks like you've made it against a tree including some of BALATON
> Zoltan's proposed but not yet merged patches.

I've sent those patches as well. But if this also works with pseries maybe 
it does not have to be in the For sam460ex part of the config but could be 
on it's own with a comment saying that multiple machines can use it.

Also what about ppcemb-softmmu? It's deprecated but do we still want to 
update it until it's removed or deprecated means no new features are added 
to it? I've also updated ppcemb config in my other patches to keep 
sam460ex working there the same as with ppc-softmmu.

Regards,
BALATON Zoltan
