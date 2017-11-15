Received: from eggs.gnu.org ([2001:4830:134:3::10]:42847)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eEvkn-0007Gf-7e
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 06:21:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eEvkj-0002qn-8N
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 06:21:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57376)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1eEvkj-0002qW-1x
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 06:21:09 -0500
References: <20171106203520.7880-1-michael.nawrocki@gtri.gatech.edu>
	<20171106203520.7880-3-michael.nawrocki@gtri.gatech.edu>
	<ce62c001-2273-c850-88f8-592fc58766c9@weilnetz.de>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <a54278b1-9a33-9b23-a9b9-e01a270df120@redhat.com>
Date: Wed, 15 Nov 2017 19:20:54 +0800
MIME-Version: 1.0
In-Reply-To: <ce62c001-2273-c850-88f8-592fc58766c9@weilnetz.de>
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
To: Stefan Weil <sw@weilnetz.de>, Mike Nawrocki <michael.nawrocki@gtri.gatech.edu>, qemu-devel@nongnu.org
Cc: marcel@redhat.com, mst@redhat.com



On 2017=E5=B9=B411=E6=9C=8815=E6=97=A5 05:41, Stefan Weil wrote:
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
> Sorry that I missed this patch.
> I think I should have an entry for eepro100 in MAINTAINERS.

Yes, please send a patch for this.

Thanks

>
> Mike, which hardware uses i82559a with PCI device id 0x1030?
>
> https://www.intel.com/content/www/us/en/support/articles/000005612/netw=
ork-and-i-o/ethernet-products.html
> only lists devices with
> 0x1229.
>
> Thanks,
> Stefan
