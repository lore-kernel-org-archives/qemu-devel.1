Received: from eggs.gnu.org ([2001:4830:134:3::10]:42103)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1cZO9i-0002iW-JB
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 15:38:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1cZO9f-0007Nx-6I
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 15:38:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34220)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1cZO9f-0007JW-0c
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 15:38:55 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3E0C180F9E
	for <qemu-devel@nongnu.org>; Thu,  2 Feb 2017 20:38:52 +0000 (UTC)
References: <1485969640-8149-1-git-send-email-abologna@redhat.com>
	<25c8a78b-1d81-2a62-61ac-722d22999c41@redhat.com>
	<1486048853.3484.21.camel@redhat.com>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <5ccdd7af-1217-47c8-bfc7-1c1b1265abda@redhat.com>
Date: Thu, 2 Feb 2017 22:38:40 +0200
MIME-Version: 1.0
In-Reply-To: <1486048853.3484.21.camel@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] q35: Improve sample configuration files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrea Bolognani <abologna@redhat.com>, qemu-devel@nongnu.org
Cc: kraxel@redhat.com, drjones@redhat.com

On 02/02/2017 05:20 PM, Andrea Bolognani wrote:
> On Thu, 2017-02-02 at 16:42 +0200, Marcel Apfelbaum wrote:
> [...]
>>> +[device "ich9-pcie-port-1"]
>>
>> I would use the new generic root port.
>
> This sample configuration (q35-emulated.cfg) is supposed to
> match physical hardware as closely as possible, so we should
> stick with ioh3420s.
>

Good point.

> [...]
>>> +[device "pci.1"]
>>> +  driver = "ioh3420"
>>
>> Same here, maybe we can use the new generic port.
>
> These sample configuration files (q35-virtio-*.cfg) should
> probably use the generic ports instead, yes. It's just that
> they were not merged yet when I started working on this :)
>

Indeed, they've been merged only today. So good timing :)

> [...]
>>> +[device "ich9-pci-bridge"]
>>> +  driver = "i82801b11-bridge"
>>> +  bus = "pcie.0"
>>> +  addr = "1e.0"
>>
>> I am not sure about having the DMI-PCI bridge "by default".
>> Users can understand is actually a good idea to have it by default
>> while we don't really want them to use legacy PCI devices on Q35;
>> and even if so, they should use them as Integrated Endpoints.
>> They don't have hotplug for the DMI-PCI bridge anyway.
>
> Not sure about this one. It doesn't show up on my laptop,

Do you have a Q35 laptop ? Good for you, I thought Q35 machines are lost in time.
I have a really old PC with Q35 chipset and I thought I am "special".

> so it's not like every single q35-based physical machine has

That was my point.

> it. I'd be okay with dropping it, but I leave the decision
> to Gerd.
>

Sure

> [...]
>> Thanks for taking your time to update the configuration files!
>> Marcel
>>
>>
>> I personally don't use them because every time I try, I
>> find something with no config support....
>
> Is that so? Can you please test these new ones and see
> whether they work for you?
>

Well, I am sure they work :), I'll give them a try (I'll beon PTO next week),
but their purpose is to be a template for more complex configurations.
Once I start to tweak them for my needs I hit a dead end.
I don't remember anything specific though.

Thanks,
Marcel

> --
> Andrea Bolognani / Red Hat / Virtualization
>
