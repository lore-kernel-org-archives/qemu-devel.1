Received: from eggs.gnu.org ([2001:4830:134:3::10]:37613)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gJx5l-000331-Cd
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 03:52:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gJwxh-0004qY-NG
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 03:43:53 -0500
References: <20181105102044.20547-1-david@redhat.com>
	<20181105102044.20547-2-david@redhat.com>
	<20181106060306.GB3539@umbus.fritz.box>
From: David Hildenbrand <david@redhat.com>
Message-ID: <b48f862e-e4d0-29ca-5cfe-4e444f37e6da@redhat.com>
Date: Tue, 6 Nov 2018 09:43:36 +0100
MIME-Version: 1.0
In-Reply-To: <20181106060306.GB3539@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 01/10] pci/pcie: rename hotplug handler
 callbacks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Alexander Graf <agraf@suse.de>, Eduardo Habkost <ehabkost@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Richard Henderson <rth@twiddle.net>, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org

On 06.11.18 07:03, David Gibson wrote:
> On Mon, Nov 05, 2018 at 11:20:35AM +0100, David Hildenbrand wrote:
>> The callbacks are also called for cold plugged devices. Drop the "hot"
>> to better match the actual callback names.
>>
>> While at it, also rename  pcie_cap_slot_hotplug_common() to
>> pcie_cap_slot_check_common().
> 
> Uh.. this part of the message doesn't appear to be accurate any more.
> 

Indeed, after renaming it 10 times I think I forgot to update the
description :)

Thanks!

>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
> 
> Apart from that,
> 
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> 


-- 

Thanks,

David / dhildenb
