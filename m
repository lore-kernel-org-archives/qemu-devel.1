Received: from eggs.gnu.org ([2001:4830:134:3::10]:46685)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1d0TJi-00054G-9d
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 09:37:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1d0TJh-0007C6-8g
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 09:37:14 -0400
References: <20170417215916.12431-1-ehabkost@redhat.com>
	<20170417215916.12431-4-ehabkost@redhat.com>
	<9cbafe84-88bb-ca3c-d85e-dae71af438ff@redhat.com>
	<20170418133005.GL25239@thinpad.lan.raisama.net>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <9fb8997c-0e16-2ded-4cc1-81ba06fe3465@redhat.com>
Date: Tue, 18 Apr 2017 16:36:58 +0300
MIME-Version: 1.0
In-Reply-To: <20170418133005.GL25239@thinpad.lan.raisama.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 3/7] pci: Change pci_bus_new*() parameter to
 PCIHostState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, aik@ozlabs.ru, David Gibson <dgibson@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Laszlo Ersek <lersek@redhat.com>, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org, qemu-arm@nongnu.org

On 04/18/2017 04:30 PM, Eduardo Habkost wrote:
> On Tue, Apr 18, 2017 at 04:27:23PM +0300, Marcel Apfelbaum wrote:
> [...]
>>> @@ -431,7 +430,7 @@ PCIBus *pci_register_bus(DeviceState *parent, const char *name,
>>>  {
>>>      PCIBus *bus;
>>>
>>> -    bus = pci_bus_new(parent, name, address_space_mem,
>>> +    bus = pci_bus_new(PCI_HOST_BRIDGE(parent), name, address_space_mem,
>>
>> If you request the parent to be PCI_HOST_BRIDGE, why don't you change also the signature of
>> pci_register_bus ?
>
> I do it on patch 4/7.
>

Yes, I saw it :). at least it means I am following the patches...

Thanks,
Marcel
