Received: from eggs.gnu.org ([2001:4830:134:3::10]:42265)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1eSfqB-0002LU-3C
	for qemu-devel@nongnu.org; Sat, 23 Dec 2017 04:11:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1eSfq7-00087C-Tb
	for qemu-devel@nongnu.org; Sat, 23 Dec 2017 04:11:35 -0500
Received: from [45.249.212.35] (port=39511 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <longpeng2@huawei.com>)
	id 1eSfq7-000845-HD
	for qemu-devel@nongnu.org; Sat, 23 Dec 2017 04:11:31 -0500
Message-ID: <5A3E1DAA.2030605@huawei.com>
Date: Sat, 23 Dec 2017 17:11:06 +0800
From: "Longpeng (Mike)" <longpeng2@huawei.com>
MIME-Version: 1.0
References: <1512545840-10256-1-git-send-email-longpeng2@huawei.com>
	<1512545840-10256-2-git-send-email-longpeng2@huawei.com>
	<0209e49f-3d81-cbc9-eb07-13654a288a22@linux.vnet.ibm.com>
	<5A2E8067.4050000@huawei.com>
	<2b7048c1-e2f8-ab40-c4df-afe5efd8f95d@linux.vnet.ibm.com>
	<5A377F94.5000504@huawei.com>
	<968106e0-b839-22fc-e3ce-605b4e58fc97@linux.vnet.ibm.com>
In-Reply-To: <968106e0-b839-22fc-e3ce-605b4e58fc97@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [virtio-dev] Re: [virtio-dev] Re: [v22 1/2]
 virtio-crypto: Add virtio crypto device specification
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: virtio-dev@lists.oasis-open.org, Ola.Liljedahl@arm.com, brian.a.keating@intel.com, wangxinxin.wang@huawei.com, mst@redhat.com, xin.zeng@intel.com, jasowang@redhat.com, luonengjun@huawei.com, qemu-devel@nongnu.org, john.griffin@intel.com, agraf@suse.de, arei.gonglei@huawei.com, liang.j.ma@intel.com, stefanha@redhat.com, jianjay.zhou@huawei.com, cornelia.huck@de.ibm.com, Varun.Sethi@freescale.com, Jani.Kokkonen@huawei.com, vincent.jardin@6wind.com, denglingli@chinamobile.com, weidong.huang@huawei.com



On 2017/12/18 20:29, Halil Pasic wrote:

> 
> 
> On 12/18/2017 09:43 AM, Longpeng (Mike) wrote:
>> Hi Halil,
>>
>> On 2017/12/11 21:54, Halil Pasic wrote:
>>
>>>
>>>
>>> On 12/11/2017 01:56 PM, Longpeng (Mike) wrote:
>>>>
>>>>
>>>> On 2017/12/6 19:01, Halil Pasic wrote:
>>>>
>>>>>
>>>>>
>>>>> On 12/06/2017 08:37 AM, Longpeng(Mike) wrote:
>>>>>> +\field{outcome_len} is the size of struct virtio_crypto_session_input or
>>>>>> +ZERO for the session-destroy operation.
>>>>>
>>>>> This ain't correct. It should have been something like virtio_crypto_destroy_session_input.
>>>>>
>>>>
>>>> Hi Halil,
>>>>
>>>> I already fixed this just now.
>>>> Do you have any other comments on v22 ? I'll send v23 tomorrow if no. :)
>>>>
>>>
>>> Did not read the rest of the document. I'm not in the middle of something,
>>> but I wanted to read the operation part these days. I guess, you prefer
>>> sending out v23 over waiting, so I guess I will wait for v23 then.
>>>
>>
>> Sorry, I prefer to wait for more comments on v22.
>>
> 
> OK, then I will read the whole thing.
> 
>>> Some general questions/remarks before you spin v23:
>>>
>>> * I'm not convinced about this 'header' and 'extra parameters' terminology.
>>> Please see https://en.wikipedia.org/wiki/Header_(computing) for header.
>>> I don't think it's fitting for the _flf structs. 
>>> Same about the 'extra'. Please see  https://www.merriam-webster.com/dictionary/extra
>>> (a : more than is due, usual, or necessary : additional) the things in
>>> _vlf aren't extra at all. Do you intend to stick with is terminology?
>>> If yes why? Please explain how should I read/understand it so that it makes
>>> sense!
>>>
>>
>> I use 'fixed-length paramenters' instead of 'header' and 'variable-length
>> parameters' instead of 'extra parameters' in certain places, but other places
>> are forgotten.
>>
>> BTW, I think this isn't a big problem and structural defect, I hope native
>> speakers could help us.
>>
> 
> It isn't a big structural thing, but inconsistent wording can make
> difficult to understand stuff even more difficult to understand.
> 
> This wording stuff is not a show-stopper for me.
> 

Agree, I didn't complain, I just hope native English speakers could give the
correct and normative expression directly.

>>> * Do we want/need to specify any alignment requirement for the
>>> stuff in guest storage (for instance the _flf fields) or be explicit
>>> about no alignment should be assumed (e.g virtio_crypto_mac_create_session_flf.algo
>>> ain't necessarily aligned (in guest memory) as required by uint32_t)?
>>>
>>
>> The _flf fields are all 32bit or 64bit.
>>
> 
> What is your point? Please elaborate!
> 

Sorry, maybe I understand incorrectly, could you give some more detail examples ?

>>> * I assume one request is supposed to correspond to one descriptor chain.
>>> Right? If yes, could you tell me, where is this expressed in the spec.
>>>
> 
> You have ignored this one. Michael said it's the default for the whole
> spec, but I still don't know where is this requirement to be found
> in the spec.
> 

It seems that Michael and you have reached an agreement, so I think we don't
need do anything in the virtio-crypto spec.

>>> Halil
>>>
>>>
>>> ---------------------------------------------------------------------
>>> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
>>> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>>>
>>>
>>> .
>>>
>>
>>
> 
> 
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
> 
> 
> .
> 


-- 
Regards,
Longpeng(Mike)
