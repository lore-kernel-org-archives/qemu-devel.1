Received: from eggs.gnu.org ([2001:4830:134:3::10]:58608)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1duZCe-0002T3-Sp
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 03:13:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1duZCb-0002Aj-LK
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 03:13:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53628)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1duZCb-0002AP-FC
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 03:13:45 -0400
References: <1503013010-11500-1-git-send-email-zuban32s@gmail.com>
	<1503013010-11500-2-git-send-email-zuban32s@gmail.com>
	<20170919203449.GG21016@localhost.localdomain>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <436365c9-43fc-95be-9bb2-7974f12e84df@redhat.com>
Date: Wed, 20 Sep 2017 10:13:35 +0300
MIME-Version: 1.0
In-Reply-To: <20170919203449.GG21016@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v7 1/4] hw/pci: introduce pcie-pci-bridge
 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, Aleksandr Bezzubikov <zuban32s@gmail.com>
Cc: qemu-devel@nongnu.org, seabios@seabios.org, lersek@redhat.com, mst@redhat.com

On 19/09/2017 23:34, Eduardo Habkost wrote:
> On Fri, Aug 18, 2017 at 02:36:47AM +0300, Aleksandr Bezzubikov wrote:
>> Introduce a new PCIExpress-to-PCI Bridge device,
>> which is a hot-pluggable PCI Express device and
>> supports devices hot-plug with SHPC.
>>
>> This device is intended to replace the DMI-to-PCI Bridge.
>>
>> Signed-off-by: Aleksandr Bezzubikov <zuban32s@gmail.com>
>> Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>
> 
> It's possible to crash QEMU by instantiating this device, with;
> 
>    $ qemu-system-ppc64 -machine prep -device pcie-pci-bridge
>    qemu-system-ppc64: qemu/memory.c:1533: memory_region_finalize: Assertion `!mr->container' failed.
>    Aborted

Hi Edurado,

> 
> I didn't investigate the root cause.
> 

Thanks for reporting it!
Aleksandr, can you have a look? Maybe we should not compile
the device for ppc arch. (x86 and arm is enough)

Appreciated,
Marcel
