Received: from eggs.gnu.org ([2001:4830:134:3::10]:51515)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cotDj-0006i8-HA
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 10:51:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cotDi-00027C-Oz
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 10:51:11 -0400
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <bd7cb196-0779-42ad-ce9c-5871d307adce@kamp.de>
	<82d604c8-068a-aff4-6037-e3cd247b3588@redhat.com>
	<819af057-3777-dffc-4670-895b8265fd01@kamp.de>
	<d41d1428-4c8b-7e2f-b197-8d45b834776d@redhat.com>
	<20170317112446.GH13125@lemon.lan>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d60bca20-c76b-696f-06d6-766d2d42ed77@redhat.com>
Date: Fri, 17 Mar 2017 15:51:01 +0100
MIME-Version: 1.0
In-Reply-To: <20170317112446.GH13125@lemon.lan>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] callout to *file in bdrv_co_get_block_status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: Peter Lieven <pl@kamp.de>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, qemu block <qemu-block@nongnu.org>



On 17/03/2017 12:24, Fam Zheng wrote:
> On Fri, 03/17 12:16, Paolo Bonzini wrote:
>>
>>
>> On 17/03/2017 12:11, Peter Lieven wrote:
>>>>> like VMDK or QCOW2 shouldn't we trust the information from the l2 tables in the VMDK or QCOW2?
>>>> It provides additional information, for example it works better with
>>>> prealloc=metadata.
>>> Okay, understood. Can you imagine of a away to conditionally avoid this second callout? In my case we have an additional
>>> lseek for each cluster. For a 20GB file this are approx. 327k calls to lseek. And if the file has no preallocated metadata
>>> it will likely not improve anything. And even if the metadata is prealloced what is the allocation status of the clusters?
>>
>> If the metadata is preallocated, cluster will (or should) show up as
>> zero, speeding up the copy.
> 
> I think from qemu-img convert's perspective, it doesn't care about the *file
> status if the metadata already speaks, because, like you said, the data shows up
> as zeroes.

That's already the case: *file is only examined if the metadata  says
BDRV_BLOCK_DATA=1, BDRV_BLOCK_ZERO=0.

Paolo
