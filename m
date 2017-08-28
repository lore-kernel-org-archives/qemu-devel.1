Received: from eggs.gnu.org ([2001:4830:134:3::10]:35854)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dmFbJ-0003Ip-Qc
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 04:40:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dmFbE-0006bm-VU
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 04:40:53 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20170825193922.GN27715@localhost.localdomain>
References: <20170823221445.15243-1-ehabkost@redhat.com>
	<20170823221445.15243-5-ehabkost@redhat.com>
	<20170825193922.GN27715@localhost.localdomain>
Date: Mon, 28 Aug 2017 10:40:10 +0200
Message-ID: <w51y3q4ulud.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 4/5] pci: Add INTERFACE_LEGACY_PCI_DEVICE
 to legacy PCI devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: xen-devel@lists.xenproject.org, qemu-block@nongnu.org, qemu-ppc@nongnu.org, qemu-arm@nongnu.org

On Fri 25 Aug 2017 09:39:22 PM CEST, Eduardo Habkost wrote:
> CCing maintainers of affected devices (sorry for not CCing you
> before).

>> diff --git a/hw/ipack/tpci200.c b/hw/ipack/tpci200.c
>> index 4dfa6b3..e380378 100644
>> --- a/hw/ipack/tpci200.c
>> +++ b/hw/ipack/tpci200.c
>> @@ -646,6 +646,10 @@ static const TypeInfo tpci200_info = {
>>      .parent        = TYPE_PCI_DEVICE,
>>      .instance_size = sizeof(TPCI200State),
>>      .class_init    = tpci200_class_init,
>> +    .interfaces = (InterfaceInfo[]) {
>> +        { INTERFACE_LEGACY_PCI_DEVICE },
>> +        { },
>> +    },
>>  };

Acked-by: Alberto Garcia <berto@igalia.com>

Berto
