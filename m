Received: from eggs.gnu.org ([2001:4830:134:3::10]:47274)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eFA02-0002xz-6Y
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 21:33:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eF9zx-0002du-RW
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 21:33:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35306)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1eF9zx-0002cK-Lt
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 21:33:49 -0500
References: <20171106203520.7880-1-michael.nawrocki@gtri.gatech.edu>
	<20171106203520.7880-3-michael.nawrocki@gtri.gatech.edu>
	<ce62c001-2273-c850-88f8-592fc58766c9@weilnetz.de>
	<7bb60d60-28d4-3c37-2740-fd16d7c6856a@gtri.gatech.edu>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <cf647f5f-2add-e570-9735-66af3c0c8b34@redhat.com>
Date: Thu, 16 Nov 2017 10:33:38 +0800
MIME-Version: 1.0
In-Reply-To: <7bb60d60-28d4-3c37-2740-fd16d7c6856a@gtri.gatech.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 2/2] Add new PCI ID for i82559a
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Nawrocki <michael.nawrocki@gtri.gatech.edu>, Stefan Weil <sw@weilnetz.de>, qemu-devel@nongnu.org
Cc: marcel@redhat.com, mst@redhat.com



On 2017=E5=B9=B411=E6=9C=8815=E6=97=A5 21:09, Michael Nawrocki wrote:
> On 11/14/2017 04:41 PM, Stefan Weil wrote:
>> Am 06.11.2017 um 21:35 schrieb Mike Nawrocki:
>>> Adds a new PCI ID for the i82559a (0x8086 0x1030) interface. Enables
>>> this ID with a new property "use-alt-device-id" to preserve
>>> compatibility.
>>>
>>> Signed-off-by: Mike Nawrocki <michael.nawrocki@gtri.gatech.edu>
>>> ---
>>> =C2=A0 hw/net/eepro100.c=C2=A0=C2=A0=C2=A0 | 12 ++++++++++++
>>> =C2=A0 include/hw/pci/pci.h |=C2=A0 1 +
>>> =C2=A0 qemu-options.hx=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
>>> =C2=A0 3 files changed, 14 insertions(+), 1 deletion(-)
>>
>>
>> Sorry that I missed this patch.
>> I think I should have an entry for eepro100 in MAINTAINERS.
>>
>> Mike, which hardware uses i82559a with PCI device id 0x1030?
>>
>> https://www.intel.com/content/www/us/en/support/articles/000005612/net=
work-and-i-o/ethernet-products.html=20
>>
>> only lists devices with
>> 0x1229.
>>
>> Thanks,
>> Stefan
>>
>
> Hi Stefan,
>
> I've got a VxWorks driver binary that explicitly looks for device ID=20
> 0x1030 (which is admittedly not ideal). It seems like the "82559=20
> InBusiness 10/100" hardware uses this, though I've had trouble finding=20
> an official source. The following documents reference that ID:
>
> https://pci-ids.ucw.cz/read/PC/8086/1030
> http://ks.pams.ncsu.edu/pub/ncsuscyld/i386/misc/src/trees/hdstg2/module=
s/pcitable=20
>
> https://cateee.net/lkddb/web-lkddb/E100.html
>
> And I found a similar post on a different mailing list that might shed=20
> some light:
> http://www.beowulf.org/pipermail/eepro100/2000-January/000760.html
>
> It looks like the 8255x series of devices have a number of potential=20
> IDs; maybe a property to set a specific PCI device ID would work?

Maybe we should use the same method as used in e1000 which can have=20
different ids depends on types.

Thanks

>
> Thanks,
> Mike
