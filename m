Received: from eggs.gnu.org ([2001:4830:134:3::10]:41630)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dWp7v-0000TK-L9
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 15:22:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dWp7s-00010G-HN
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 15:22:47 -0400
Received: from chuckie.co.uk ([82.165.15.123]:47363
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1dWp7s-0000zd-A3
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 15:22:44 -0400
References: <1499809473-28481-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<6d3baced-070b-908a-95b0-7784e2f0ca4e@ilande.co.uk>
	<2f0d3ed6-5aa3-851e-3e9f-c08532ca1120@redhat.com>
	<b8946b8c-6409-e904-451f-5bf4eeb50595@ilande.co.uk>
	<85b75513-9516-db30-cf56-cb1542d494c4@redhat.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <0bf6be3a-50cc-1166-53c5-272b3c919393@ilande.co.uk>
Date: Sun, 16 Jul 2017 20:22:30 +0100
MIME-Version: 1.0
In-Reply-To: <85b75513-9516-db30-cf56-cb1542d494c4@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCHv2 0/2] pci: allow PCI bus slots to be
 marked as reserved
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel@redhat.com>, qemu-devel@nongnu.org, mst@redhat.com, armbru@redhat.com

On 16/07/17 08:28, Marcel Apfelbaum wrote:

>>> As in prev version, other than the minor comment
>>> on replacing "if (...) return true; else return false"
>>> with the actual value, I am OK with it.
>>
>> Okay great! So change pci_bus_devfn_available() to something like this?
>>
>> static bool pci_bus_devfn_available(PCIBus *bus, int devfn)
>> {
>>      return !(bus->devices[devfn]);
>> }
>>
> 
> Yes, thanks.

Great, I'll send a v3 with the above modification shortly.

>>> I believe Michael asked to see the series using this feature,
>>> can you add a link to it, or post it with the dependency on this one?
>>
>> Sure, I posted the link earlier in the week:
>> https://lists.nongnu.org/archive/html/qemu-devel/2017-07/msg03045.html.
>> Or more specifically:
>>
>> https://lists.nongnu.org/archive/html/qemu-devel/2017-07/msg03041.html
>>
> 
> Hi Michael,
> Can you please have a look to the above patch using
> the 'reserved slots' patch?

I should add that if this patch isn't suitable for freeze then it's
likely I'll drop the sun4u patchset for 2.10 since otherwise using
-device places devices on the PCI root bus.

For existing users this means that the machine will start up with their
existing command lines but any extra devices added on the command line
via -device, e.g. virtio will be silently broken because the interrupt
routing is incorrect.

At least with this patch the user will get an error, and thus it's easy
to update the wiki to explain that moving forward it is necessary to add
"bus=pciB" for extra devices to function correctly.


ATB,

Mark.
