Received: from eggs.gnu.org ([2001:4830:134:3::10]:38806)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1faxGX-0006ae-HF
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 01:57:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1faxGU-0000Ve-Fj
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 01:57:17 -0400
Received: from 10.mo7.mail-out.ovh.net ([178.33.250.56]:41580)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1faxGU-0008PG-6r
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 01:57:14 -0400
Received: from player793.ha.ovh.net (unknown [10.109.122.120])
	by mo7.mail-out.ovh.net (Postfix) with ESMTP id 54E8FB7492
	for <qemu-devel@nongnu.org>; Thu,  5 Jul 2018 07:57:04 +0200 (CEST)
References: <20180701171953.9921-1-clg@kaod.org> <20180702035726.GK2455@xz-mi>
	<b5f38492-22a4-aa8a-ab42-f7e06c28c753@kaod.org>
	<20180704022648.GA2568@xz-mi>
	<f67c2a72-b3ac-fe8d-52c9-b03f58556caa@kaod.org>
	<95fe81b1-13ee-5c82-22e2-e5ef4abd1168@redhat.com>
	<20180704095520.GD2568@xz-mi>
	<9e9c51da-f7aa-c3d1-0beb-4dbfaf31a592@redhat.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <16ec29ab-a5ec-a68a-91d0-2c63838d0695@kaod.org>
Date: Thu, 5 Jul 2018 07:56:54 +0200
MIME-Version: 1.0
In-Reply-To: <9e9c51da-f7aa-c3d1-0beb-4dbfaf31a592@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] exec.c: check RAMBlock validity before
 changing its flag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

Hello Paolo,

On 07/04/2018 02:16 PM, Paolo Bonzini wrote:
> On 04/07/2018 11:55, Peter Xu wrote:
>>>     commit b0e56e0b63f350691b52d3e75e89bb64143fbeff
>>>     Author: Hu Tao <hutao@cn.fujitsu.com>
>>>     Date:   Wed Apr 2 15:13:27 2014 +0800
>>>
>>>     unset RAMBlock idstr when unregister MemoryRegion
>>>
>>>     Signed-off-by: Hu Tao <hutao@cn.fujitsu.com>
>>>     Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>>>
>>> whose commit message is a bit lacking, but
>>> http://lists.gnu.org/archive/html/qemu-devel/2014-04/msg00282.html helps
>>> more.  It seems like the original bug was a reference count issue.
>>>
>>> Clearing the new migratable flag should also be unnecessary.
>> But even if we get rid of vmstate_unregister_ram(), the leak could
>> still be there?
>>
>> I'm not sure what was leaked when b0e56e0b6 was introduced, I feel
>> like it's the RAMBlock of the memdev.  Here I think the ROM memory
>> region seems to be leaked as well (along with the RAMBlock inside)?
> 
> The leak would be another bug that vmstate_unregister_ram is just
> papering over.  We need to test memory unplug with
> vmstate_unregister_ram removed, and fix bugs if any.

So for the time being, you would just get rid of pci_del_option_rom()
which only does vmstate_unregister_ram() ? 

Thanks,

C.
