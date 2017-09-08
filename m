Received: from eggs.gnu.org ([2001:4830:134:3::10]:53567)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1dqAnI-0006ki-6q
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 00:21:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1dqAnD-0005LT-9I
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 00:21:28 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2254)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1dqAnC-0005FO-Jd
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 00:21:23 -0400
Message-ID: <59B219BF.9020400@huawei.com>
Date: Fri, 8 Sep 2017 12:17:03 +0800
From: "Longpeng (Mike)" <longpeng2@huawei.com>
MIME-Version: 1.0
References: <1503734014-239116-1-git-send-email-longpeng2@huawei.com>
	<59A8AE20.1080409@huawei.com>
	<7f0b8eb2-9e5c-7507-191d-1aab17c6ff0f@linux.vnet.ibm.com>
	<20170906164839-mutt-send-email-mst@kernel.org>
In-Reply-To: <20170906164839-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [virtio-dev] Re: [PATCH v19 0/2] virtio-crypto:
 virtio crypto device specification
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: stefanha@redhat.com, qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, luonengjun@huawei.com, cohuck@redhat.com, denglingli@chinamobile.com, Jani.Kokkonen@huawei.com, Ola.Liljedahl@arm.com, Varun.Sethi@freescale.com, xin.zeng@intel.com, brian.a.keating@intel.com, liang.j.ma@intel.com, john.griffin@intel.com, weidong.huang@huawei.com, mike.caraman@nxp.com, agraf@suse.de, jasowang@redhat.com, nmorey@kalray.eu, vincent.jardin@6wind.com, arei.gonglei@hotmail.com, wangxinxin.wang@huawei.com, Gonglei <arei.gonglei@huawei.com>



On 2017/9/6 21:52, Michael S. Tsirkin wrote:

> On Fri, Sep 01, 2017 at 01:45:45PM +0200, Halil Pasic wrote:
>>
>>
>> On 09/01/2017 02:47 AM, Longpeng (Mike) wrote:
>>> Ping...
>>>
>>> Stefan, Halil, do you have any suggestion ?
>>>
>>
>> Hi Longpeng,
>>
>> I've ran trough your patch, and it reads much better that
>> what I recall v18 used to read like. Because it's been a while
>> since v18 doing a conscious review on this will take a considerable
>> amount of time (my memories of the issues identified back then
>> are very sketchy/vague now). It's on my todo list, but it ain't the
>> only item there.

> 
> I don't think it's a fair reason to delay the merging though.
> No comments in a while says time to merge to me.
> There's always a public review period during which more comments
> can be addressed.
> 
> So I think we should start a ballot on this one.
> Mike - if you agree please open an issue in TC issue
> tracker.  As a reminder here are the guidelines:
> 


Hi Michael,

I've promised Halil to send an implementation based on the v19 this week and I
can complete it in this two days, OTOH, Halil had give some very useful
suggestions on the v18 and we also hope him could closely review the v19 spec.

So I suggest to give Halil enough time(one more week?) to review the v19 if he will.

If everything is ok, we could start a ballot on this one(if no other
suggestions) or the v20(update according with the new suggestions).

-- 
Regards,
Longpeng(Mike)

> 
> --
> 
> When you open an issue (can be fixed afterwards as well):
> 
> 1. Fill in the reporter in the Environment: field.
> 2. Shortly describe the issue in the description field
>    Preferably add a URL to discussion here or
>    in the comments.
>    If the mail was copied to virtio-comment or virtio-dev, you can use
>         mid.gmane.org/<message-id>
>    to quickly locate a mail in the archives.
> 2. Preferably, fill in all affected versions: in
>    "Affects Version/s:".
>    This might not apply to e.g. improvement requests.
> 
> ---
> 
> When you propose the issue before the TC meeting:
> 
> 1. Mark issue as Open
> 2. Fill in a summary of the final proposed change and
>    link to full proposal in "Proposal"
>    field.
>    [any historical abandoned proposals and extra info can go
>     into comments field]
> ---
> 
> Then mail me and the TC and I will start a ballot.
> 
> Thanks!
> 
>> Btw. I like to have a reference implementation at hand when reviewing
>> a spec. What is the status of the (reference) implementation (I mean
>> the new stuff like stateless/mux)? I think it would be nice to provide
>> this info in the cover letter (e.g. next time, should we need another
>> iteration).
>>
>> Regards,
>> Halil
>>
>>
>> ---------------------------------------------------------------------
>> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
>> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
> 
> .
> 


-- 
Regards,
Longpeng(Mike)
