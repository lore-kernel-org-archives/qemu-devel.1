Received: from eggs.gnu.org ([2001:4830:134:3::10]:57071)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1cQ8fK-0008VB-29
	for qemu-devel@nongnu.org; Sun, 08 Jan 2017 03:17:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1cQ8fG-00042J-V0
	for qemu-devel@nongnu.org; Sun, 08 Jan 2017 03:17:22 -0500
References: <20170106050451.11793-1-david@gibson.dropbear.id.au>
	<53dcb2da-fa15-63b0-5849-325b6edcac83@redhat.com>
	<20170106214052-mutt-send-email-mst@kernel.org>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <9cc108a2-4e56-e5ed-9ba4-4e0e0faac072@redhat.com>
Date: Sun, 8 Jan 2017 10:17:12 +0200
MIME-Version: 1.0
In-Reply-To: <20170106214052-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC] pxb: Restrict to x86
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: David Gibson <david@gibson.dropbear.id.au>, ehabkost@redhat.com, thuth@redhat.com, lvivier@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 01/06/2017 09:41 PM, Michael S. Tsirkin wrote:
> On Fri, Jan 06, 2017 at 08:13:11AM +0200, Marcel Apfelbaum wrote:
>> On 01/06/2017 07:04 AM, David Gibson wrote:
>>> The PCI Expander Bridge (PXB) device is essentially a hack to allow
>>> different PCIe devices to be assigned to different NUMA nodes on x86.  Each
>>> PXB is sort-of a separate PCI host bridge, except that its config space
>>> is shared with the config space of the main PCI host bridge, rather than
>>> being independent.
>>>
>>
>> Hi David,
>>
>>> This is only necessary if the platform doesn't (easily) allow truly
>>> independent PCI host bridges.  AFAIK that's just x86.
>>>
>>
>> Indeed, it is possible to support independent PCI host bridges on x86 by
>> using a separate MMCONFIG space for each one and enable separate PCI domains.
>> We simply didn't need this until now, but maybe will be implemented it in the future.
>
> In fact I would say that's the cleanest way to do this on q35.
>

Message received :)

Thanks,
Marcel


>>> This patch makes it possible to configure PXB out of the build, and adjusts
>>> the default configs so it's only included on x86 targets.
>>>
>>

[...]
