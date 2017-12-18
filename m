Received: from eggs.gnu.org ([208.118.235.92]:48422)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1eQxKp-0008Up-Mm
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 10:28:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1eQxKe-0002MC-Dv
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 10:28:07 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56072
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1eQxKe-0002Ln-8a
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 10:27:56 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vBIFPdLn065082
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 10:27:52 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2exekc5n0e-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 10:27:52 -0500
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Mon, 18 Dec 2017 15:27:50 -0000
References: <1512545840-10256-1-git-send-email-longpeng2@huawei.com>
	<1512545840-10256-2-git-send-email-longpeng2@huawei.com>
	<0209e49f-3d81-cbc9-eb07-13654a288a22@linux.vnet.ibm.com>
	<5A2E8067.4050000@huawei.com>
	<2b7048c1-e2f8-ab40-c4df-afe5efd8f95d@linux.vnet.ibm.com>
	<5A377F94.5000504@huawei.com>
	<968106e0-b839-22fc-e3ce-605b4e58fc97@linux.vnet.ibm.com>
	<20171218153450-mutt-send-email-mst@kernel.org>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Mon, 18 Dec 2017 16:27:42 +0100
MIME-Version: 1.0
In-Reply-To: <20171218153450-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <0cada9eb-60c1-4b71-09a9-fef7db2c4831@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [virtio-dev] Re: [v22 1/2] virtio-crypto: Add
 virtio crypto device specification
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "Longpeng (Mike)" <longpeng2@huawei.com>, virtio-dev@lists.oasis-open.org, Ola.Liljedahl@arm.com, brian.a.keating@intel.com, wangxinxin.wang@huawei.com, xin.zeng@intel.com, jasowang@redhat.com, luonengjun@huawei.com, qemu-devel@nongnu.org, john.griffin@intel.com, agraf@suse.de, arei.gonglei@huawei.com, liang.j.ma@intel.com, stefanha@redhat.com, jianjay.zhou@huawei.com, Cornelia Huck <cohuck@redhat.com>, Varun.Sethi@freescale.com, Jani.Kokkonen@huawei.com, vincent.jardin@6wind.com, denglingli@chinamobile.com, weidong.huang@huawei.com



On 12/18/2017 02:51 PM, Michael S. Tsirkin wrote:
> On Mon, Dec 18, 2017 at 01:29:50PM +0100, Halil Pasic wrote:
[..]
>>
>> It isn't a big structural thing, but inconsistent wording can make
>> difficult to understand stuff even more difficult to understand.
>>
>> This wording stuff is not a show-stopper for me.
> 
> Right. There's a working implementation upstream that people use,
> so at this point we really need a description of that upstream,
> and add wording tweaks on top. And it's too late to change the
> interface drastically, any change must be compatible using
> feature bits for anything we want changed.
> 
> 

I fully agree. Please bear with me if end up complaining about
minor stuff identified while reviewing the spec and cross check
it with the implementation to make sure there is nothing major wrong.

[..]
>>>> * I assume one request is supposed to correspond to one descriptor chain.
>>>> Right? If yes, could you tell me, where is this expressed in the spec.
>>>>
>>
>> You have ignored this one. Michael said it's the default for the whole
>> spec, but I still don't know where is this requirement to be found
>> in the spec.
> 
> I was surprised to find this does not say this explicitly anywhere.
> I this we should add something like the below to the Virtqueues
> chapter:
> 
> 	Driver makes requests available to device by adding an available buffer
> 	to the queue - i.e. adding a buffer describing the request to a
> 	virtqueue, and optionally triggering a driver event - i.e. sending a
> 	notification to the device.  Device executes the requests and - when
> 	complete - adds a used buffer to the queue - i.e. lets the driver know
> 	by marking the buffer as used. Device can then trigger a device event -
> 	i.e. send an interrupt to the driver.

Thanks for verifying this. I can spin a patch addressing the issue, if you like.

If I'm going to do the patch, I would like take your text as a starting
point of (with your kind permission), but I would rather see this as belonging
to "3.2 Device Operation". (It's not about how virtqueues work, but how
virtio devices use virtqueues to do their thing.)

Regards,
Halil
