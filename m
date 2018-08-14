Received: from eggs.gnu.org ([2001:4830:134:3::10]:55417)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jing2.liu@linux.intel.com>) id 1fpVh4-0003Mi-3e
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 05:32:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jing2.liu@linux.intel.com>) id 1fpVgz-0003NS-79
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 05:32:50 -0400
Received: from mga01.intel.com ([192.55.52.88]:29110)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jing2.liu@linux.intel.com>)
	id 1fpVgy-0003NE-Uc
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 05:32:45 -0400
References: <1533625449-14989-1-git-send-email-jing2.liu@linux.intel.com>
	<893d9264-7908-4e2c-ae1d-7e46eed6e6a0@redhat.com>
	<e06b10e0-d0b6-d190-6673-f97199bebb72@redhat.com>
	<efc99631-454d-4377-8551-0594fc763c94@gmail.com>
From: "Liu, Jing2" <jing2.liu@linux.intel.com>
Message-ID: <f3278023-80a7-6a51-fb97-f8223bd72ceb@linux.intel.com>
Date: Tue, 14 Aug 2018 17:32:39 +0800
MIME-Version: 1.0
In-Reply-To: <efc99631-454d-4377-8551-0594fc763c94@gmail.com>
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
To: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, anthony.xu@intel.com, mst@redhat.com



On 8/12/2018 3:11 PM, Marcel Apfelbaum wrote:
[...]

>> I don't know what to suggest for the new capability's
>> teardown, in pci_bridge_dev_exitfn()  -- should we just ignore it (as
>> suggested by this patch)?
> 
> No, we should remove it properly.
> 
> I think it is not considered a "big" issue since adding/removing PCI 
> capabilities
> is not an operation that deals with resources, we only edit an array 
> (the config space)
> that will not be used anyway if the device init sequence failed.
> 
> That does not mean the code should not be clean.
I just search some PCI_CAP_ID_* to see what they do for exitfn/uninit.
It's weird that some more capabilities aren't being deleted, like 
pci_ich9_uninit().

Thanks,
Jing

> 
> Thanks,
> Marcel
> 
>>
>> Thanks
>> Laszlo
>>
> 
