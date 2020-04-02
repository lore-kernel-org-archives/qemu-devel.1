Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3498C2D0F4
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 04:04:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A59E720747
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 04:04:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A59E720747
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJr5r-0001KV-OG
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 00:04:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50721)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <teawaterz@linux.alibaba.com>) id 1jJr4W-0000sR-Kh
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 00:03:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <teawaterz@linux.alibaba.com>) id 1jJr4P-0004pA-3Z
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 00:03:10 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:58504)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <teawaterz@linux.alibaba.com>)
 id 1jJr4O-0004CV-PD
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 00:03:09 -0400
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R171e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04357; MF=teawaterz@linux.alibaba.com;
 NM=1; PH=DS; RN=12; SR=0; TI=SMTPD_---0TuNonMf_1585800168; 
Received: from 127.0.0.1(mailfrom:teawaterz@linux.alibaba.com
 fp:SMTPD_---0TuNonMf_1585800168) by smtp.aliyun-inc.com(127.0.0.1);
 Thu, 02 Apr 2020 12:02:53 +0800
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: [RFC for Linux] virtio_balloon: Add VIRTIO_BALLOON_F_THP_ORDER to
 handle THP spilt issue
From: teawater <teawaterz@linux.alibaba.com>
In-Reply-To: <5e0e0659-5f70-2162-96be-5fcd0d3f46ad@redhat.com>
Date: Thu, 2 Apr 2020 12:02:47 +0800
Content-Transfer-Encoding: quoted-printable
Message-Id: <07AF0005-2711-4137-A96D-DA264A05C302@linux.alibaba.com>
References: <20200326031817-mutt-send-email-mst@kernel.org>
 <C4C6BAF7-C040-403D-997C-48C7AB5A7D6B@redhat.com>
 <20200326054554-mutt-send-email-mst@kernel.org>
 <f26dc94a-7296-90c9-56cd-4586b78bc03d@redhat.com>
 <20200331091718-mutt-send-email-mst@kernel.org>
 <02a393ce-c4b4-ede9-7671-76fa4c19097a@redhat.com>
 <20200331093300-mutt-send-email-mst@kernel.org>
 <b69796e0-fa41-a219-c3e5-a11e9f5f18bf@redhat.com>
 <20200331100359-mutt-send-email-mst@kernel.org>
 <85f699d4-459a-a319-0a8f-96c87d345c49@redhat.com>
 <BABD09DC-217E-4F00-9C05-74ABB4B1E13D@vmware.com>
 <5e0e0659-5f70-2162-96be-5fcd0d3f46ad@redhat.com>
To: David Hildenbrand <david@redhat.com>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 47.88.44.36
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "pagupta@redhat.com" <pagupta@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "mojha@codeaurora.org" <mojha@codeaurora.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 LKML <linux-kernel@vger.kernel.org>, Nadav Amit <namit@vmware.com>,
 Alexander Duyck <alexander.h.duyck@linux.intel.com>,
 Linux Virtualization <virtualization@lists.linux-foundation.org>,
 Andrew Morton <akpm@linux-foundation.org>, Hui Zhu <teawater@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> 2020=E5=B9=B44=E6=9C=881=E6=97=A5 17:48=EF=BC=8CDavid Hildenbrand =
<david@redhat.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On 31.03.20 18:37, Nadav Amit wrote:
>>> On Mar 31, 2020, at 7:09 AM, David Hildenbrand <david@redhat.com> =
wrote:
>>>=20
>>> On 31.03.20 16:07, Michael S. Tsirkin wrote:
>>>> On Tue, Mar 31, 2020 at 04:03:18PM +0200, David Hildenbrand wrote:
>>>>> On 31.03.20 15:37, Michael S. Tsirkin wrote:
>>>>>> On Tue, Mar 31, 2020 at 03:32:05PM +0200, David Hildenbrand =
wrote:
>>>>>>> On 31.03.20 15:24, Michael S. Tsirkin wrote:
>>>>>>>> On Tue, Mar 31, 2020 at 12:35:24PM +0200, David Hildenbrand =
wrote:
>>>>>>>>> On 26.03.20 10:49, Michael S. Tsirkin wrote:
>>>>>>>>>> On Thu, Mar 26, 2020 at 08:54:04AM +0100, David Hildenbrand =
wrote:
>>>>>>>>>>>> Am 26.03.2020 um 08:21 schrieb Michael S. Tsirkin =
<mst@redhat.com>:
>>>>>>>>>>>>=20
>>>>>>>>>>>> =EF=BB=BFOn Thu, Mar 12, 2020 at 09:51:25AM +0100, David =
Hildenbrand wrote:
>>>>>>>>>>>>>> On 12.03.20 09:47, Michael S. Tsirkin wrote:
>>>>>>>>>>>>>> On Thu, Mar 12, 2020 at 09:37:32AM +0100, David =
Hildenbrand wrote:
>>>>>>>>>>>>>>> 2. You are essentially stealing THPs in the guest. So =
the fastest
>>>>>>>>>>>>>>> mapping (THP in guest and host) is gone. The guest won't =
be able to make
>>>>>>>>>>>>>>> use of THP where it previously was able to. I can =
imagine this implies a
>>>>>>>>>>>>>>> performance degradation for some workloads. This needs a =
proper
>>>>>>>>>>>>>>> performance evaluation.
>>>>>>>>>>>>>>=20
>>>>>>>>>>>>>> I think the problem is more with the alloc_pages API.
>>>>>>>>>>>>>> That gives you exactly the given order, and if there's
>>>>>>>>>>>>>> a larger chunk available, it will split it up.
>>>>>>>>>>>>>>=20
>>>>>>>>>>>>>> But for balloon - I suspect lots of other users,
>>>>>>>>>>>>>> we do not want to stress the system but if a large
>>>>>>>>>>>>>> chunk is available anyway, then we could handle
>>>>>>>>>>>>>> that more optimally by getting it all in one go.
>>>>>>>>>>>>>>=20
>>>>>>>>>>>>>>=20
>>>>>>>>>>>>>> So if we want to address this, IMHO this calls for a new =
API.
>>>>>>>>>>>>>> Along the lines of
>>>>>>>>>>>>>>=20
>>>>>>>>>>>>>>  struct page *alloc_page_range(gfp_t gfp, unsigned int =
min_order,
>>>>>>>>>>>>>>                  unsigned int max_order, unsigned int =
*order)
>>>>>>>>>>>>>>=20
>>>>>>>>>>>>>> the idea would then be to return at a number of pages in =
the given
>>>>>>>>>>>>>> range.
>>>>>>>>>>>>>>=20
>>>>>>>>>>>>>> What do you think? Want to try implementing that?
>>>>>>>>>>>>>=20
>>>>>>>>>>>>> You can just start with the highest order and decrement =
the order until
>>>>>>>>>>>>> your allocation succeeds using alloc_pages(), which would =
be enough for
>>>>>>>>>>>>> a first version. At least I don't see the immediate need =
for a new
>>>>>>>>>>>>> kernel API.
>>>>>>>>>>>>=20
>>>>>>>>>>>> OK I remember now.  The problem is with reclaim. Unless =
reclaim is
>>>>>>>>>>>> completely disabled, any of these calls can sleep. After it =
wakes up,
>>>>>>>>>>>> we would like to get the larger order that has become =
available
>>>>>>>>>>>> meanwhile.
>>>>>>>>>>>=20
>>>>>>>>>>> Yes, but that=E2=80=98s a pure optimization IMHO.
>>>>>>>>>>> So I think we should do a trivial implementation first and =
then see what we gain from a new allocator API. Then we might also be =
able to justify it using real numbers.
>>>>>>>>>>=20
>>>>>>>>>> Well how do you propose implement the necessary semantics?
>>>>>>>>>> I think we are both agreed that alloc_page_range is more or
>>>>>>>>>> less what's necessary anyway - so how would you approximate =
it
>>>>>>>>>> on top of existing APIs?
>>>>>>>>> diff --git a/include/linux/balloon_compaction.h =
b/include/linux/balloon_compaction.h
>>>>>>=20
>>>>>> .....
>>>>>>=20
>>>>>>=20
>>>>>>>>> diff --git a/mm/balloon_compaction.c b/mm/balloon_compaction.c
>>>>>>>>> index 26de020aae7b..067810b32813 100644
>>>>>>>>> --- a/mm/balloon_compaction.c
>>>>>>>>> +++ b/mm/balloon_compaction.c
>>>>>>>>> @@ -112,23 +112,35 @@ size_t balloon_page_list_dequeue(struct =
balloon_dev_info *b_dev_info,
>>>>>>>>> EXPORT_SYMBOL_GPL(balloon_page_list_dequeue);
>>>>>>>>>=20
>>>>>>>>> /*
>>>>>>>>> - * balloon_page_alloc - allocates a new page for insertion =
into the balloon
>>>>>>>>> - *			page list.
>>>>>>>>> + * balloon_pages_alloc - allocates a new page (of at most the =
given order)
>>>>>>>>> + * 			 for insertion into the balloon page =
list.
>>>>>>>>> *
>>>>>>>>> * Driver must call this function to properly allocate a new =
balloon page.
>>>>>>>>> * Driver must call balloon_page_enqueue before definitively =
removing the page
>>>>>>>>> * from the guest system.
>>>>>>>>> *
>>>>>>>>> + * Will fall back to smaller orders if allocation fails. The =
order of the
>>>>>>>>> + * allocated page is stored in page->private.
>>>>>>>>> + *
>>>>>>>>> * Return: struct page for the allocated page or NULL on =
allocation failure.
>>>>>>>>> */
>>>>>>>>> -struct page *balloon_page_alloc(void)
>>>>>>>>> +struct page *balloon_pages_alloc(int order)
>>>>>>>>> {
>>>>>>>>> -	struct page *page =3D =
alloc_page(balloon_mapping_gfp_mask() |
>>>>>>>>> -				       __GFP_NOMEMALLOC | =
__GFP_NORETRY |
>>>>>>>>> -				       __GFP_NOWARN);
>>>>>>>>> -	return page;
>>>>>>>>> +	struct page *page;
>>>>>>>>> +
>>>>>>>>> +	while (order >=3D 0) {
>>>>>>>>> +		page =3D alloc_pages(balloon_mapping_gfp_mask() =
|
>>>>>>>>> +				   __GFP_NOMEMALLOC | =
__GFP_NORETRY |
>>>>>>>>> +				   __GFP_NOWARN, order);
>>>>>>>>> +		if (page) {
>>>>>>>>> +			set_page_private(page, order);
>>>>>>>>> +			return page;
>>>>>>>>> +		}
>>>>>>>>> +		order--;
>>>>>>>>> +	}
>>>>>>>>> +	return NULL;
>>>>>>>>> }
>>>>>>>>> -EXPORT_SYMBOL_GPL(balloon_page_alloc);
>>>>>>>>> +EXPORT_SYMBOL_GPL(balloon_pages_alloc);
>>>>>>>>>=20
>>>>>>>>> /*
>>>>>>>>> * balloon_page_enqueue - inserts a new page into the balloon =
page list.
>>>>>>>>=20
>>>>>>>>=20
>>>>>>>> I think this will try to invoke direct reclaim from the first =
iteration
>>>>>>>> to free up the max order.
>>>>>>>=20
>>>>>>> %__GFP_NORETRY: The VM implementation will try only very =
lightweight
>>>>>>> memory direct reclaim to get some memory under memory pressure =
(thus it
>>>>>>> can sleep). It will avoid disruptive actions like OOM killer.
>>>>>>>=20
>>>>>>> Certainly good enough for a first version I would say, no?
>>>>>>=20
>>>>>> Frankly how well that behaves would depend a lot on the workload.
>>>>>> Can regress just as well.
>>>>>>=20
>>>>>> For the 1st version I'd prefer something that is the least =
disruptive,
>>>>>> and that IMHO means we only trigger reclaim at all in the same =
configuration
>>>>>> as now - when we can't satisfy the lowest order allocation.
>>>>>=20
>>>>> Agreed.
>>>>>=20
>>>>>> Anything else would be a huge amount of testing with all kind of
>>>>>> workloads.
>>>>>=20
>>>>> So doing a "& ~__GFP_RECLAIM" in case order > 0? (as done in
>>>>> GFP_TRANSHUGE_LIGHT)
>>>>=20
>>>> That will improve the situation when reclaim is not needed, but =
leave
>>>> the problem in place for when it's needed: if reclaim does trigger, =
we
>>>> can get a huge free page and immediately break it up.
>>>>=20
>>>> So it's ok as a first step but it will make the second step harder =
as
>>>> we'll need to test with reclaim :).
>>>=20
>>> I expect the whole "steal huge pages from your guest" to be =
problematic,
>>> as I already mentioned to Alex. This needs a performance evaluation.
>>>=20
>>> This all smells like a lot of workload dependent fine-tuning. :)
>>=20
>> AFAIK the hardware overheads of keeping huge-pages in the guest and =
backing
>> them with 4KB pages are non-negligible. Did you take those into =
account?
>=20
> Of course, the fastest mapping will be huge pages in host and guest.
> Having huge pages in your guest but not in your host cannot really be
> solved using ballooning AFAIKs. Hopefully THP in the host will be =
doing
> its job properly :)
>=20
> ... however, so far, we haven't done any performance comparisons at =
all.
> The only numbers from Hui Zhu that I can spot are number of THP in the
> host, which is not really expressing actual guest performance IMHO. =
That
> definitely has to be done to evaluate the different optimizations we
> might want to try out.
>=20

I did some tests with vm-scalability on Monday comparing their =
performance in VM:
//4 processes random r/w
usemem -R -a -Z  -n 4 1g

write:
hugepage: 146367 KB/s
thp:	  133550 KB/s
normal:   124248 KB/s

read:
hugepage: 103969 KB/s
thp:	  100622 KB/s
normal:   88755 KB/s

Best,
Hui


> --=20
> Thanks,
>=20
> David / dhildenb


