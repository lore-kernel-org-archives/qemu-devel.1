Received: from eggs.gnu.org ([2001:4830:134:3::10]:50996)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jing2.liu@linux.intel.com>) id 1fqDov-0002sa-EQ
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 04:39:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jing2.liu@linux.intel.com>) id 1fqDop-0006ah-Eh
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 04:39:51 -0400
Received: from mga11.intel.com ([192.55.52.93]:47720)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jing2.liu@linux.intel.com>)
	id 1fqDoj-0006Pu-OH
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 04:39:44 -0400
References: <1533625449-14989-1-git-send-email-jing2.liu@linux.intel.com>
	<893d9264-7908-4e2c-ae1d-7e46eed6e6a0@redhat.com>
	<43bf022f-6059-8e93-f8c3-61a7ecb72178@linux.intel.com>
	<6c406b79-ff47-fbbd-a700-df38f06960db@redhat.com>
From: "Liu, Jing2" <jing2.liu@linux.intel.com>
Message-ID: <86ebb075-5642-2c7e-220c-0194e3b90191@linux.intel.com>
Date: Thu, 16 Aug 2018 16:39:31 +0800
MIME-Version: 1.0
In-Reply-To: <6c406b79-ff47-fbbd-a700-df38f06960db@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] hw/pci: add pci capability to pci-pci
 bridge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, anthony.xu@intel.com, mst@redhat.com



On 8/14/2018 9:27 PM, Laszlo Ersek wrote:
[...]
>>>>    +cap_error:
>>>> +    msi_uninit(dev);
>>>
>>> (4) This error handler doesn't look entirely correct; we can reach it
>>> without having initialized MSI. (MSI setup is conditional; and even if
>>> we attempt it, it is permitted to fail with "msi=auto".) Therefore,
>>> msi_uninit() should be wrapped into "if (msi_present())", same as you
>>> see in pci_bridge_dev_exitfn().
>>
>> sure, can add a pre-check. But I don't understand why we need that,
>> msi_uninit() will check msi_present()?
> 
> Thanks for pointing that out.
> 
> So, I grepped the source code for msi_uninit(). It seems that only one
> location gates it with msi_present() -- in pci_bridge_dev_exitfn() --,
> while 13 other locations just call it unconditionally.
> 
> I don't know what the consistent approach is here. I'll have to defer to
> the PCI maintainers; their taste will decide. Technically your code
> looks correct, then.
Yes, I also grep that. I guess if we directly use msi_uninit, this is 
because msi_init is non-conditional too.
Anyway, I added check in my version two. BTW, other comments are 
included in v2.

Thanks,
Jing

> 
> Thanks
> Laszlo
> 
