Received: from eggs.gnu.org ([2001:4830:134:3::10]:60321)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1fqgqB-0001fx-Sg
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 11:39:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1fqgq9-0001ni-7f
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 11:39:07 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:37477)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1fqgq9-0001nY-17
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 11:39:05 -0400
Received: by mail-wm0-x241.google.com with SMTP id n11-v6so7732773wmc.2
	for <qemu-devel@nongnu.org>; Fri, 17 Aug 2018 08:39:04 -0700 (PDT)
References: <1533625449-14989-1-git-send-email-jing2.liu@linux.intel.com>
	<893d9264-7908-4e2c-ae1d-7e46eed6e6a0@redhat.com>
	<e06b10e0-d0b6-d190-6673-f97199bebb72@redhat.com>
	<efc99631-454d-4377-8551-0594fc763c94@gmail.com>
	<f3278023-80a7-6a51-fb97-f8223bd72ceb@linux.intel.com>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <d8ec93cb-a374-5921-a7ab-4b9e237b40be@gmail.com>
Date: Fri, 17 Aug 2018 18:39:01 +0300
MIME-Version: 1.0
In-Reply-To: <f3278023-80a7-6a51-fb97-f8223bd72ceb@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
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
To: "Liu, Jing2" <jing2.liu@linux.intel.com>, Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, anthony.xu@intel.com, mst@redhat.com



On 08/14/2018 12:32 PM, Liu, Jing2 wrote:
>
>
> On 8/12/2018 3:11 PM, Marcel Apfelbaum wrote:
> [...]
>
>>> I don't know what to suggest for the new capability's
>>> teardown, in pci_bridge_dev_exitfn()  -- should we just ignore it (as
>>> suggested by this patch)?
>>
>> No, we should remove it properly.
>>
>> I think it is not considered a "big" issue since adding/removing PCI 
>> capabilities
>> is not an operation that deals with resources, we only edit an array 
>> (the config space)
>> that will not be used anyway if the device init sequence failed.
>>
>> That does not mean the code should not be clean.
> I just search some PCI_CAP_ID_* to see what they do for exitfn/uninit.
> It's weird that some more capabilities aren't being deleted, like 
> pci_ich9_uninit().
>

I agree it does not look good. As I pointed out  above,
if the capability does not require extra resources, the array representing
the configuration space for the device gets "deleted" anyway when we
dispose of the device.

Thanks,
Marcel

> Thanks,
> Jing
>
>>
>> Thanks,
>> Marcel
>>
>>>
>>> Thanks
>>> Laszlo
>>>
>>
