Received: from eggs.gnu.org ([2001:4830:134:3::10]:34120)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1fE8uE-0006KU-As
	for qemu-devel@nongnu.org; Thu, 03 May 2018 03:43:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1fE8uB-0001GD-Nl
	for qemu-devel@nongnu.org; Thu, 03 May 2018 03:43:58 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60208 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1fE8uB-0001Fx-Iu
	for qemu-devel@nongnu.org; Thu, 03 May 2018 03:43:55 -0400
References: <20180425045129.17449-9-peterx@redhat.com>
	<2b05e076-0af9-0ee9-c076-7acc29714913@redhat.com>
	<AADFC41AFE54684AB9EE6CBC0274A5D19113B5D2@SHSMSX101.ccr.corp.intel.com>
	<20180427072810.GB13269@xz-mi>
	<AADFC41AFE54684AB9EE6CBC0274A5D19113C1C9@SHSMSX101.ccr.corp.intel.com>
	<20180427095527.GE13269@xz-mi> <20180427114029.GF13269@xz-mi>
	<AADFC41AFE54684AB9EE6CBC0274A5D19113D318@SHSMSX101.ccr.corp.intel.com>
	<20180503060442.GB2378@xz-mi>
	<547a97a1-0ac0-21b2-af00-036b795b06cc@redhat.com>
	<20180503072828.GA29580@xz-mi>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <8cbed1d0-1f4e-db6d-bd83-1042f724827a@redhat.com>
Date: Thu, 3 May 2018 15:43:35 +0800
MIME-Version: 1.0
In-Reply-To: <20180503072828.GA29580@xz-mi>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 08/10] intel-iommu: maintain per-device
 iova ranges
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, "Michael S . Tsirkin" <mst@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Jintack Lim <jintack@cs.columbia.edu>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>



On 2018=E5=B9=B405=E6=9C=8803=E6=97=A5 15:28, Peter Xu wrote:
> On Thu, May 03, 2018 at 03:20:11PM +0800, Jason Wang wrote:
>>
>> On 2018=E5=B9=B405=E6=9C=8803=E6=97=A5 14:04, Peter Xu wrote:
>>> IMHO the guest can't really detect this, but it'll found that the
>>> device is not working functionally if it's doing something like what
>>> Jason has mentioned.
>>>
>>> Actually now I have had an idea if we really want to live well even
>>> with Jason's example: maybe we'll need to identify PSI/DSI.  For DSI,
>>> we don't remap for mapped pages; for PSI, we unmap and remap the
>>> mapped pages.  That'll complicate the stuff a bit, but it should
>>> satisfy all the people.
>>>
>>> Thanks,
>> So it looks like there will be still unnecessary unamps.
> Could I ask what do you mean by "unecessary unmaps"?

It's for "for PSI, we unmap and remap the mapped pages". So for the=20
first "unmap" how do you know it was really necessary without knowing=20
the state of current shadow page table?

>> How about record the mappings in the tree too?
> As I mentioned, for L1 guest (e.g., DPDK applications running in L1)
> it'll be fine.  But I'm just afraid we will have other use cases, like
> the L2 guests. That might need tons of the mapping entries in the
> worst case scenario.
>

Yes, but that's the price of shadow page tables.

Thanks
