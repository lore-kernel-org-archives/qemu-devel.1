Received: from eggs.gnu.org ([209.51.188.92]:33447)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jing2.liu@linux.intel.com>) id 1gvaTb-00069W-PO
	for qemu-devel@nongnu.org; Sun, 17 Feb 2019 23:24:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jing2.liu@linux.intel.com>) id 1gvaTZ-0006zP-Om
	for qemu-devel@nongnu.org; Sun, 17 Feb 2019 23:24:19 -0500
Received: from mga05.intel.com ([192.55.52.43]:46578)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jing2.liu@linux.intel.com>)
	id 1gvaTW-0006tN-1G
	for qemu-devel@nongnu.org; Sun, 17 Feb 2019 23:24:15 -0500
References: <49127da6-814d-4675-21a5-48a8aa764e34@linux.intel.com>
	<20190205164716.79b9cd08@Igors-MacBook-Pro.local>
	<c6e1d704-e0da-215e-40c7-6db3daa66da1@linux.intel.com>
	<20190214123140.53d3cdf6@redhat.com>
	<6cd527d2-b8d8-0eb9-78eb-a59c3ee4ccc7@gmail.com>
	<20190214151520.2763805d@redhat.com>
	<ff00462b-a46f-a937-d9f0-cc37ab4957b9@gmail.com>
From: "Liu, Jing2" <jing2.liu@linux.intel.com>
Message-ID: <f991498e-3d3f-ddae-f4b5-f592dcdee466@linux.intel.com>
Date: Mon, 18 Feb 2019 12:24:02 +0800
MIME-Version: 1.0
In-Reply-To: <ff00462b-a46f-a937-d9f0-cc37ab4957b9@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Issues] PCI hotplug does not work well on pc
 platform?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Igor Mammedov <imammedo@redhat.com>
Cc: yang.zhong@intel.com, qemu-devel <qemu-devel@nongnu.org>

Hi Marcel and Igor,

Thanks very much for your help!

On 2/14/2019 10:42 PM, Marcel Apfelbaum wrote:
> 
> 
[...]
>>>>>>> I have two questions.
>>>>>>> 1. PCI hotplug on pci.0 must manually rescan in guest. The ACPI 
>>>>>>> hotplug
>>>>>>> handler sends the GPE event to guest but it seems guest doesn't 
>>>>>>> receive
>>>>>>> it? I tried to open ACPI debug level/layer to 0xffffffff, in 
>>>>>>> order to
>>>>>>> see if there is any message after device_add in monitor, but no 
>>>>>>> message
>>>>>>> comes out until I manually rescan. Also tried printk in
>>>>>>> acpi_ev_gpe_xrupt_handler() and acpi_ev_sci_xrupt_handler(). No 
>>>>>>> output
>>>>>>> in dmesg.
>>>>>>> (I'm sure that CONFIG_HOTPLUG_PCI_PCIE=y, CONFIG_HOTPLUG_PCI_CPCI=y,
>>>>>>> CONFIG_HOTPLUG_PCI=y, CONFIG_HOTPLUG_PCI_ACPI=y)
>>> What about |CONFIG_HOTPLUG_PCI_SHPC=y ?
>>>

Thanks and I finally found it is because I set hardware reduced acpi 
before and now it is correct.

>>> |
>>>>>>> Whether this is a kind of design or a known issue? Does guest 
>>>>>>> receive
>>>>>>> the request, where can I find the
>>>>>> does it work with known to work kernels (RHEL7)?
>>>>>>
>>>>>> Also sharing used QEMU version and command line could help.
>>>>> Is there any key config of kernel in guest, besides those I listed 
>>>>> above?
>>>> Maybe Marcel knows something about it
>>>> (CCed)
>>> May I ask why do you need SHPC hotplug and not the ACPI based hotplug?
Oh, it is some customer's requests. And the method to set PIIX4_PM 
property works.


Thanks!
Jing
