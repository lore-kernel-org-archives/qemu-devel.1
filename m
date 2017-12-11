Received: from eggs.gnu.org ([2001:4830:134:3::10]:46525)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1eOOYd-0004c4-Df
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 08:55:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1eOOYZ-0005bX-Ey
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 08:55:47 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41644)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1eOOYZ-0004lb-5P
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 08:55:43 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vBBDosMA010457
	for <qemu-devel@nongnu.org>; Mon, 11 Dec 2017 08:54:38 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2est05c36u-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 11 Dec 2017 08:54:37 -0500
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Mon, 11 Dec 2017 13:54:32 -0000
References: <1512545840-10256-1-git-send-email-longpeng2@huawei.com>
	<1512545840-10256-2-git-send-email-longpeng2@huawei.com>
	<0209e49f-3d81-cbc9-eb07-13654a288a22@linux.vnet.ibm.com>
	<5A2E8067.4050000@huawei.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Mon, 11 Dec 2017 14:54:25 +0100
MIME-Version: 1.0
In-Reply-To: <5A2E8067.4050000@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <2b7048c1-e2f8-ab40-c4df-afe5efd8f95d@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [v22 1/2] virtio-crypto: Add virtio crypto device
 specification
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Longpeng (Mike)" <longpeng2@huawei.com>
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, luonengjun@huawei.com, mst@redhat.com, cornelia.huck@de.ibm.com, stefanha@redhat.com, denglingli@chinamobile.com, Jani.Kokkonen@huawei.com, Ola.Liljedahl@arm.com, Varun.Sethi@freescale.com, xin.zeng@intel.com, brian.a.keating@intel.com, liang.j.ma@intel.com, john.griffin@intel.com, weidong.huang@huawei.com, agraf@suse.de, jasowang@redhat.com, vincent.jardin@6wind.com, arei.gonglei@huawei.com, wangxinxin.wang@huawei.com, jianjay.zhou@huawei.com



On 12/11/2017 01:56 PM, Longpeng (Mike) wrote:
> 
> 
> On 2017/12/6 19:01, Halil Pasic wrote:
> 
>>
>>
>> On 12/06/2017 08:37 AM, Longpeng(Mike) wrote:
>>> +\field{outcome_len} is the size of struct virtio_crypto_session_input or
>>> +ZERO for the session-destroy operation.
>>
>> This ain't correct. It should have been something like virtio_crypto_destroy_session_input.
>>
> 
> Hi Halil,
> 
> I already fixed this just now.
> Do you have any other comments on v22 ? I'll send v23 tomorrow if no. :)
> 

Did not read the rest of the document. I'm not in the middle of something,
but I wanted to read the operation part these days. I guess, you prefer
sending out v23 over waiting, so I guess I will wait for v23 then.

Some general questions/remarks before you spin v23:

* I'm not convinced about this 'header' and 'extra parameters' terminology.
Please see https://en.wikipedia.org/wiki/Header_(computing) for header.
I don't think it's fitting for the _flf structs. 
Same about the 'extra'. Please see  https://www.merriam-webster.com/dictionary/extra
(a : more than is due, usual, or necessary : additional) the things in
_vlf aren't extra at all. Do you intend to stick with is terminology?
If yes why? Please explain how should I read/understand it so that it makes
sense!

* Do we want/need to specify any alignment requirement for the
stuff in guest storage (for instance the _flf fields) or be explicit
about no alignment should be assumed (e.g virtio_crypto_mac_create_session_flf.algo
ain't necessarily aligned (in guest memory) as required by uint32_t)?

* I assume one request is supposed to correspond to one descriptor chain.
Right? If yes, could you tell me, where is this expressed in the spec.

Halil
