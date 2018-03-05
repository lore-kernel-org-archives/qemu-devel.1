Received: from eggs.gnu.org ([2001:4830:134:3::10]:46611)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1esvQm-0008IQ-9Y
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 14:05:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1esvQl-0001Qx-Ht
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 14:05:52 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180305112732.26471-1-f4bug@amsat.org>
	<20180305112732.26471-22-f4bug@amsat.org>
	<d0a41a33-45c0-92bf-7fa1-e5cad644b4fe@suse.cz>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <7fb5baea-61e7-8daa-e05e-3a99c7276898@amsat.org>
Date: Mon, 5 Mar 2018 16:05:48 -0300
MIME-Version: 1.0
In-Reply-To: <d0a41a33-45c0-92bf-7fa1-e5cad644b4fe@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 21/30] hw/misc: use the BYTE-based
 definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jiri Slaby <jslaby@suse.cz>, qemu-trivial@nongnu.org
Cc: qemu-devel@nongnu.org

Hi Jiri,

On 03/05/2018 04:02 PM, Jiri Slaby wrote:
> On 03/05/2018, 12:27 PM, Philippe Mathieu-Daudé wrote:
>> --- a/hw/misc/auxbus.c
>> +++ b/hw/misc/auxbus.c
>> @@ -68,7 +68,7 @@ AUXBus *aux_init_bus(DeviceState *parent, const char *name)
>>  
>>      /* Memory related. */
>>      bus->aux_io = g_malloc(sizeof(*bus->aux_io));
>> -    memory_region_init(bus->aux_io, OBJECT(bus), "aux-io", (1 << 20));
>> +    memory_region_init(bus->aux_io, OBJECT(bus), "aux-io", 2 * M_BYTE);
> 
> Only M_BYTE, not "2 *".

Yes! I totally missed this :/

> 
>>      address_space_init(&bus->aux_addr_space, bus->aux_io, "aux-io");
>>      return bus;
>>  }
>> diff --git a/hw/misc/edu.c b/hw/misc/edu.c
>> index 34eb05d213..ce8235dfc4 100644
>> --- a/hw/misc/edu.c
>> +++ b/hw/misc/edu.c
>> @@ -357,7 +357,7 @@ static void pci_edu_realize(PCIDevice *pdev, Error **errp)
>>                         edu, QEMU_THREAD_JOINABLE);
>>  
>>      memory_region_init_io(&edu->mmio, OBJECT(edu), &edu_mmio_ops, edu,
>> -                    "edu-mmio", 1 << 20);
>> +                    "edu-mmio", 1 * M_BYTE);
> 
> "1 * " is superfluous

I kept "1 * " to be consistent with the other uses, I find it easier to
review (or modify).

Thanks for your review!

Phil.
