Received: from eggs.gnu.org ([2001:4830:134:3::10]:42932)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Michael.Nawrocki@gtri.gatech.edu>)
	id 1eExSA-0006V5-RI
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 08:10:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Michael.Nawrocki@gtri.gatech.edu>)
	id 1eExS0-0003cD-Ti
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 08:10:06 -0500
Received: from relay2.gtri.gatech.edu ([130.207.199.168]:50714)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Michael.Nawrocki@gtri.gatech.edu>)
	id 1eExS0-0003ZZ-Mc
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 08:09:56 -0500
References: <20171106203520.7880-1-michael.nawrocki@gtri.gatech.edu>
	<20171106203520.7880-3-michael.nawrocki@gtri.gatech.edu>
	<ce62c001-2273-c850-88f8-592fc58766c9@weilnetz.de>
From: Michael Nawrocki <michael.nawrocki@gtri.gatech.edu>
Message-ID: <7bb60d60-28d4-3c37-2740-fd16d7c6856a@gtri.gatech.edu>
Date: Wed, 15 Nov 2017 08:09:53 -0500
MIME-Version: 1.0
In-Reply-To: <ce62c001-2273-c850-88f8-592fc58766c9@weilnetz.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 2/2] Add new PCI ID for i82559a
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Weil <sw@weilnetz.de>, qemu-devel@nongnu.org
Cc: marcel@redhat.com, jasowang@redhat.com, mst@redhat.com

On 11/14/2017 04:41 PM, Stefan Weil wrote:
> Am 06.11.2017 um 21:35 schrieb Mike Nawrocki:
>> Adds a new PCI ID for the i82559a (0x8086 0x1030) interface. Enables
>> this ID with a new property "use-alt-device-id" to preserve
>> compatibility.
>>
>> Signed-off-by: Mike Nawrocki <michael.nawrocki@gtri.gatech.edu>
>> ---
>>   hw/net/eepro100.c    | 12 ++++++++++++
>>   include/hw/pci/pci.h |  1 +
>>   qemu-options.hx      |  2 +-
>>   3 files changed, 14 insertions(+), 1 deletion(-)
> 
> 
> Sorry that I missed this patch.
> I think I should have an entry for eepro100 in MAINTAINERS.
> 
> Mike, which hardware uses i82559a with PCI device id 0x1030?
> 
> https://www.intel.com/content/www/us/en/support/articles/000005612/network-and-i-o/ethernet-products.html
> only lists devices with
> 0x1229.
> 
> Thanks,
> Stefan
> 

Hi Stefan,

I've got a VxWorks driver binary that explicitly looks for device ID 
0x1030 (which is admittedly not ideal). It seems like the "82559 
InBusiness 10/100" hardware uses this, though I've had trouble finding 
an official source. The following documents reference that ID:

https://pci-ids.ucw.cz/read/PC/8086/1030
http://ks.pams.ncsu.edu/pub/ncsuscyld/i386/misc/src/trees/hdstg2/modules/pcitable
https://cateee.net/lkddb/web-lkddb/E100.html

And I found a similar post on a different mailing list that might shed 
some light:
http://www.beowulf.org/pipermail/eepro100/2000-January/000760.html

It looks like the 8255x series of devices have a number of potential 
IDs; maybe a property to set a specific PCI device ID would work?

Thanks,
Mike
