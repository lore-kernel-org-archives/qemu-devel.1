Received: from eggs.gnu.org ([209.51.188.92]:60110)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jing2.liu@linux.intel.com>) id 1gopVW-0002mA-3N
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 08:02:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jing2.liu@linux.intel.com>) id 1gopVV-0000iW-56
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 08:02:22 -0500
Received: from mga02.intel.com ([134.134.136.20]:25585)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jing2.liu@linux.intel.com>)
	id 1gopVU-0000eg-T4
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 08:02:21 -0500
From: "Liu, Jing2" <jing2.liu@linux.intel.com>
Message-ID: <49127da6-814d-4675-21a5-48a8aa764e34@linux.intel.com>
Date: Wed, 30 Jan 2019 21:02:10 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [Issues] PCI hotplug does not work well on pc platform?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: yang.zhong@intel.com

Hi everyone,

I have two questions.
1. PCI hotplug on pci.0 must manually rescan in guest. The ACPI hotplug 
handler sends the GPE event to guest but it seems guest doesn't receive 
it? I tried to open ACPI debug level/layer to 0xffffffff, in order to 
see if there is any message after device_add in monitor, but no message 
comes out until I manually rescan. Also tried printk in 
acpi_ev_gpe_xrupt_handler() and acpi_ev_sci_xrupt_handler(). No output 
in dmesg.
(I'm sure that CONFIG_HOTPLUG_PCI_PCIE=y, CONFIG_HOTPLUG_PCI_CPCI=y, 
CONFIG_HOTPLUG_PCI=y, CONFIG_HOTPLUG_PCI_ACPI=y)

Whether this is a kind of design or a known issue? Does guest receive 
the request, where can I find the

2. I want to try hotplugging on pci-bridge on pc platform, using shpc. I 
set shpc=on, but when I do device_add, qemu still calls 
acpi_pcihp_device_plug_cb? Why it does not call pci_bridge_dev_hotplug_cb?
(CONFIG_HOTPLUG_PCI_SHPC=y)

Thanks very much!
Jing
