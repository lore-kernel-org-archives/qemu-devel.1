Received: from eggs.gnu.org ([2001:4830:134:3::10]:35280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evpQz-0002t4-6I
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 15:18:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evpQv-0003EL-Up
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 15:18:05 -0400
References: <20180212051954.GE11634@umbus.fritz.box>
	<0a57f0ec-4300-f4f3-3957-4bced8b57e14@ozlabs.ru>
	<20180212090653.42bdd2e2@w520.home>
	<0c594a0b-488c-b5f8-e8ed-ffa8f4a98088@ozlabs.ru>
	<20180213053630.GL11634@umbus.fritz.box>
	<20180213054124.GN11634@umbus.fritz.box>
	<8282d070-b2d3-7e43-3da9-b17c77b99a67@ozlabs.ru>
	<20180214013323.GA5247@umbus.fritz.box>
	<843efd62-7a39-8536-91ad-1abea2beb190@ozlabs.ru>
	<20180214085541.5491705f@w520.home>
	<20180216052824.GI2074@umbus.fritz.box>
	<c11af933-3f08-f2c8-0552-ce43ac8f5741@ozlabs.ru>
	<a29658e8-d2da-161d-d9b8-41f186969927@ozlabs.ru>
	<821596dc-35b0-60cf-3e1f-3df0809b2f8e@ozlabs.ru>
	<8e909bd8-2c24-abde-aa42-fd3f46ff649e@ozlabs.ru>
	<20180313105606.18d0d8af@w520.home>
	<f081b19e-b80d-b889-e916-ad0e361c9512@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f670a57f-0972-7a91-b2e7-314c9e3608e2@redhat.com>
Date: Tue, 13 Mar 2018 14:17:40 -0500
MIME-Version: 1.0
In-Reply-To: <f081b19e-b80d-b889-e916-ad0e361c9512@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH qemu v7 2/4] vfio/pci: Relax DMA map errors
 for MMIO regions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Auger Eric <eric.auger@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

[Making a meta-comment that I've pointed out to others before]

On 03/13/2018 12:13 PM, Auger Eric wrote:
> Hi Alex,
...

>>>>>>>>>>>>>>>>> On Fri, Feb 09, 2018 at 06:55:01PM +1100, Alexey Kardashevskiy wrote:
>>>>>>>>>>>>>>>>>> At the moment if vfio_memory_listener is registered in the system memory

17 levels of '>' before I even began my reply.  And several screenfuls 
of content that I'm snipping...

>> Clearly llsize needs to be wrapped in int128_get64() here.  Should I
>> presume that testing of this patch is equally lacking?  Eric, have you
>> done any testing of this?  I think this was fixing a mapping issue you
>> reported.  Thanks,
> not that version unfortunately. I don't have access to the HW on which I
> had the issue anymore. Maybe I could by the beg of next week?

before getting to the 2-line meat of the message.  It's okay to snip 
portions of the quoted content that are no longer relevant to the 
immediate message, as it helps improve the signal-to-noise ratio (we 
have list archives, for when referring to prior context is needed)

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
