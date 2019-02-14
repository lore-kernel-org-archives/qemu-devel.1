Received: from eggs.gnu.org ([209.51.188.92]:41770)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1guHxd-0002WI-5m
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 09:25:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1guHnQ-0004AP-OJ
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 09:15:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41966)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1guHnP-00047i-Rw
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 09:15:24 -0500
Date: Thu, 14 Feb 2019 15:15:20 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190214151520.2763805d@redhat.com>
In-Reply-To: <6cd527d2-b8d8-0eb9-78eb-a59c3ee4ccc7@gmail.com>
References: <49127da6-814d-4675-21a5-48a8aa764e34@linux.intel.com>
	<20190205164716.79b9cd08@Igors-MacBook-Pro.local>
	<c6e1d704-e0da-215e-40c7-6db3daa66da1@linux.intel.com>
	<20190214123140.53d3cdf6@redhat.com>
	<6cd527d2-b8d8-0eb9-78eb-a59c3ee4ccc7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
To: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: "Liu, Jing2" <jing2.liu@linux.intel.com>, yang.zhong@intel.com, qemu-devel <qemu-devel@nongnu.org>

On Thu, 14 Feb 2019 15:12:35 +0200
Marcel Apfelbaum <marcel.apfelbaum@gmail.com> wrote:

> Hi Igor, Jing
> 
> On 2/14/19 1:31 PM, Igor Mammedov wrote:
> > On Wed, 13 Feb 2019 15:40:57 +0800
> > "Liu, Jing2" <jing2.liu@linux.intel.com> wrote:
> >  
> >> Hi Igor,
> >>
> >> Thanks for your reply!
> >>
> >> On 2/5/2019 11:47 PM, Igor Mammedov wrote:  
> >>> On Wed, 30 Jan 2019 21:02:10 +0800
> >>> "Liu, Jing2" <jing2.liu@linux.intel.com> wrote:
> >>>      
> >>>> Hi everyone,
> >>>>
> >>>> I have two questions.
> >>>> 1. PCI hotplug on pci.0 must manually rescan in guest. The ACPI hotplug
> >>>> handler sends the GPE event to guest but it seems guest doesn't receive
> >>>> it? I tried to open ACPI debug level/layer to 0xffffffff, in order to
> >>>> see if there is any message after device_add in monitor, but no message
> >>>> comes out until I manually rescan. Also tried printk in
> >>>> acpi_ev_gpe_xrupt_handler() and acpi_ev_sci_xrupt_handler(). No output
> >>>> in dmesg.
> >>>> (I'm sure that CONFIG_HOTPLUG_PCI_PCIE=y, CONFIG_HOTPLUG_PCI_CPCI=y,
> >>>> CONFIG_HOTPLUG_PCI=y, CONFIG_HOTPLUG_PCI_ACPI=y)  
> 
> What about |CONFIG_HOTPLUG_PCI_SHPC=y ?
> 
> |
> >>>> Whether this is a kind of design or a known issue? Does guest receive
> >>>> the request, where can I find the  
> >>> does it work with known to work kernels (RHEL7)?
> >>>
> >>> Also sharing used QEMU version and command line could help.
> >>>      
> >> Is there any key config of kernel in guest, besides those I listed above?  
> > Maybe Marcel knows something about it
> > (CCed)  
> 
> May I ask why do you need SHPC hotplug and not the ACPI based hotplug?
I'd say SHPC one is preferred one, ACPI hotplug is rather complicated
QEMU hack to make legacy Windows guest support hotplug of PCI devices.
 
[...]
