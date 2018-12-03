Received: from eggs.gnu.org ([2001:4830:134:3::10]:58216)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gTqWx-0004FP-3k
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:53:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gTqWr-0007rK-BW
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:53:07 -0500
Received: from 9.mo6.mail-out.ovh.net ([87.98.171.146]:47504)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gTqWr-0007kS-3I
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:53:01 -0500
Received: from player690.ha.ovh.net (unknown [10.109.143.225])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id 355C41993B0
	for <qemu-devel@nongnu.org>; Mon,  3 Dec 2018 16:52:51 +0100 (CET)
References: <20181116105729.23240-1-clg@kaod.org>
	<20181116105729.23240-28-clg@kaod.org>
	<20181129040917.GF14697@umbus.fritz.box>
	<8416d567-6e9e-6124-7b7c-a620429af8b5@kaod.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <faca523e-aa5a-788e-bd99-66d890e047bc@kaod.org>
Date: Mon, 3 Dec 2018 16:52:46 +0100
MIME-Version: 1.0
In-Reply-To: <8416d567-6e9e-6124-7b7c-a620429af8b5@kaod.org>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 27/36] sysbus: add a sysbus_mmio_unmap()
 helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>

On 11/29/18 5:36 PM, C=E9dric Le Goater wrote:
> On 11/29/18 5:09 AM, David Gibson wrote:
>> On Fri, Nov 16, 2018 at 11:57:20AM +0100, C=E9dric Le Goater wrote:
>>> This will be used to remove the MMIO regions of the POWER9 XIVE
>>> interrupt controller when the sPAPR machine is reseted.
>>>
>>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>>
>> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
>>
>> Since the code looks sane.
>>
>> Hoever, I think using memory_region_set_enabled() would be a better
>> idea for our purposes than actually adding/deleting the subregion.
>=20
> Yes and we might not need this one anymore.=20

As we are destroying the KVM device, we also need to remove the mmap=20
in QEMU, else we will have a VMA with a page fault handler pointing
on a bogus KVM device.  which means destroying the memory region, so
we can not use  memory_region_set_enabled().=20

Anyhow mapping/unmapping works well.

Thanks,

C.
