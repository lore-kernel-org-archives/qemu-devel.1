Received: from eggs.gnu.org ([2001:4830:134:3::10]:43662)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aviadye@dev.mellanox.co.il>) id 1fJDcT-0006On-Qu
	for qemu-devel@nongnu.org; Thu, 17 May 2018 03:46:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aviadye@dev.mellanox.co.il>) id 1fJDcQ-0007sI-KC
	for qemu-devel@nongnu.org; Thu, 17 May 2018 03:46:37 -0400
Received: from mail-wm0-x22e.google.com ([2a00:1450:400c:c09::22e]:55324)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aviadye@dev.mellanox.co.il>)
	id 1fJDcQ-0007qV-9d
	for qemu-devel@nongnu.org; Thu, 17 May 2018 03:46:34 -0400
Received: by mail-wm0-x22e.google.com with SMTP id a8-v6so6645612wmg.5
	for <qemu-devel@nongnu.org>; Thu, 17 May 2018 00:46:34 -0700 (PDT)
References: <20180508184035.GT2500@work-vm>
	<CAOGPPbdy+198Nxd=ttOtm+mNy7_u4iJxYVhLqYyeK1JJytuZEQ@mail.gmail.com>
	<20180511180335.GH2720@work-vm>
	<CAOGPPbdZX9gnp2BcwaizzyLGxN+T3wdSM_6wzVmGAYDgC+zFqQ@mail.gmail.com>
	<20180514192723.GH2497@work-vm>
	<CAOGPPbfqiKsfd+qW9ik-NzTox5eQTSpGsKgSi8bULjfesWgQug@mail.gmail.com>
	<20180516093944.GA2531@work-vm>
	<CAOGPPbemRCtRTmYaWSfQPTXZkGOX2RqAAb_HcdOCncCZ1d9Jqw@mail.gmail.com>
	<20180516095344.GB2531@work-vm>
	<CAOGPPbdjb6x-7Lgtw-xDA7qT=qfGHPwibeu2q+v08G21HUmKyQ@mail.gmail.com>
	<20180516131327.GF2531@work-vm>
	<AM6PR05MB4360C1A885C2B052583F47C7C2920@AM6PR05MB4360.eurprd05.prod.outlook.com>
	<be4b48b2-22b3-9a69-92ed-dbc9ae59b4e6@dev.mellanox.co.il>
	<CAOGPPbenO1P9VbdpDVD5_SNJeoF4eHxkLg=rF7LM9HpbyoR0uw@mail.gmail.com>
	<68c2aa43-89ab-c72d-8bd1-09c95a6cc95a@dev.mellanox.co.il>
	<CAOGPPbcxTQ_3tcbZX-VVDrcLDTSY6BKXnAhestqyg-=ub4o=Ng@mail.gmail.com>
From: Aviad Yehezkel <aviadye@dev.mellanox.co.il>
Message-ID: <def963bd-e64a-320a-b534-c3766274dfe3@dev.mellanox.co.il>
Date: Thu, 17 May 2018 10:46:30 +0300
MIME-Version: 1.0
In-Reply-To: <CAOGPPbcxTQ_3tcbZX-VVDrcLDTSY6BKXnAhestqyg-=ub4o=Ng@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] FW: [PATCH 2/2] migration: not wait
 RDMA_CM_EVENT_DISCONNECTED event after rdma_disconnect
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: 858585 jemmy <jemmy858585@gmail.com>
Cc: Aviad Yehezkel <aviadye@mellanox.com>, Juan Quintela <quintela@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Gal Shachaf <galsha@mellanox.com>, Adi Dotan <adido@mellanox.com>, Lidong Chen <lidongchen@tencent.com>



On 5/17/2018 10:41 AM, 858585 jemmy wrote:
> On Thu, May 17, 2018 at 3:31 PM, Aviad Yehezkel
> <aviadye@dev.mellanox.co.il> wrote:
>>
>> On 5/17/2018 5:42 AM, 858585 jemmy wrote:
>>> On Wed, May 16, 2018 at 11:11 PM, Aviad Yehezkel
>>> <aviadye@dev.mellanox.co.il> wrote:
>>>> Hi Lidong and David,
>>>> Sorry for the late response, I had to ramp up on migration code and build
>>>> a
>>>> setup on my side.
>>>>
>>>> PSB my comments for this patch below.
>>>> For the RDMA post-copy patches I will comment next week after testing on
>>>> Mellanox side too.
>>>>
>>>> Thanks!
>>>>
>>>> On 5/16/2018 5:21 PM, Aviad Yehezkel wrote:
>>>>>
>>>>> -----Original Message-----
>>>>> From: Dr. David Alan Gilbert [mailto:dgilbert@redhat.com]
>>>>> Sent: Wednesday, May 16, 2018 4:13 PM
>>>>> To: 858585 jemmy <jemmy858585@gmail.com>
>>>>> Cc: Aviad Yehezkel <aviadye@mellanox.com>; Juan Quintela
>>>>> <quintela@redhat.com>; qemu-devel <qemu-devel@nongnu.org>; Gal Shachaf
>>>>> <galsha@mellanox.com>; Adi Dotan <adido@mellanox.com>; Lidong Chen
>>>>> <lidongchen@tencent.com>
>>>>> Subject: Re: [PATCH 2/2] migration: not wait RDMA_CM_EVENT_DISCONNECTED
>>>>> event after rdma_disconnect
>>>>>
>>>>> * 858585 jemmy (jemmy858585@gmail.com) wrote:
>>>>>
>>>>> <snip>
>>>>>
>>>>>>>>>>> I wonder why dereg_mr takes so long - I could understand if
>>>>>>>>>>> reg_mr took a long time, but why for dereg, that sounds like the
>>>>>>>>>>> easy side.
>>>>>>>>>> I use perf collect the information when ibv_dereg_mr is invoked.
>>>>>>>>>>
>>>>>>>>>> -   9.95%  client2  [kernel.kallsyms]  [k] put_compound_page
>>>>>>>>>>                                                              `
>>>>>>>>>>       - put_compound_page
>>>>>>>>>>          - 98.45% put_page
>>>>>>>>>>               __ib_umem_release
>>>>>>>>>>               ib_umem_release
>>>>>>>>>>               dereg_mr
>>>>>>>>>>               mlx5_ib_dereg_mr
>>>>>>>>>>               ib_dereg_mr
>>>>>>>>>>               uverbs_free_mr
>>>>>>>>>>               remove_commit_idr_uobject
>>>>>>>>>>               _rdma_remove_commit_uobject
>>>>>>>>>>               rdma_remove_commit_uobject
>>>>>>>>>>               ib_uverbs_dereg_mr
>>>>>>>>>>               ib_uverbs_write
>>>>>>>>>>               vfs_write
>>>>>>>>>>               sys_write
>>>>>>>>>>               system_call_fastpath
>>>>>>>>>>               __GI___libc_write
>>>>>>>>>>               0
>>>>>>>>>>          + 1.55% __ib_umem_release
>>>>>>>>>> +   8.31%  client2  [kernel.kallsyms]  [k]
>>>>>>>>>> compound_unlock_irqrestore
>>>>>>>>>> +   7.01%  client2  [kernel.kallsyms]  [k] page_waitqueue
>>>>>>>>>> +   7.00%  client2  [kernel.kallsyms]  [k] set_page_dirty
>>>>>>>>>> +   6.61%  client2  [kernel.kallsyms]  [k] unlock_page
>>>>>>>>>> +   6.33%  client2  [kernel.kallsyms]  [k] put_page_testzero
>>>>>>>>>> +   5.68%  client2  [kernel.kallsyms]  [k] set_page_dirty_lock
>>>>>>>>>> +   4.30%  client2  [kernel.kallsyms]  [k] __wake_up_bit
>>>>>>>>>> +   4.04%  client2  [kernel.kallsyms]  [k] free_pages_prepare
>>>>>>>>>> +   3.65%  client2  [kernel.kallsyms]  [k] release_pages
>>>>>>>>>> +   3.62%  client2  [kernel.kallsyms]  [k] arch_local_irq_save
>>>>>>>>>> +   3.35%  client2  [kernel.kallsyms]  [k] page_mapping
>>>>>>>>>> +   3.13%  client2  [kernel.kallsyms]  [k]
>>>>>>>>>> get_pageblock_flags_group
>>>>>>>>>> +   3.09%  client2  [kernel.kallsyms]  [k] put_page
>>>>>>>>>>
>>>>>>>>>> the reason is __ib_umem_release will loop many times for each page.
>>>>>>>>>>
>>>>>>>>>> static void __ib_umem_release(struct ib_device *dev, struct
>>>>>>>>>> ib_umem *umem, int dirty) {
>>>>>>>>>>        struct scatterlist *sg;
>>>>>>>>>>        struct page *page;
>>>>>>>>>>        int i;
>>>>>>>>>>
>>>>>>>>>>        if (umem->nmap > 0)
>>>>>>>>>>             ib_dma_unmap_sg(dev, umem->sg_head.sgl,
>>>>>>>>>>                                            umem->npages,
>>>>>>>>>>                                            DMA_BIDIRECTIONAL);
>>>>>>>>>>
>>>>>>>>>>             for_each_sg(umem->sg_head.sgl, sg, umem->npages, i) {
>>>>>>>>>> <<
>>>>>>>>>> loop a lot of times for each page.here
>>>>>>>>> Why 'lot of times for each page'?  I don't know this code at all,
>>>>>>>>> but I'd expected once per page?
>>>>>>>> sorry, once per page, but a lot of page for a big size virtual
>>>>>>>> machine.
>>>>>>> Ah OK; so yes it seems best if you can find a way to do the release
>>>>>>> in the migration thread then;  still maybe this is something some of
>>>>>>> the kernel people could look at speeding up?
>>>>>> The kernel code seem is not complex, and I have no idea how to speed
>>>>>> up.
>>>>> Me neither; but I'll ask around.
>>>> I will ask internally and get back on this one.
>>>>>
>>>>>>>>> With your other kernel fix, does the problem of the missing
>>>>>>>>> RDMA_CM_EVENT_DISCONNECTED events go away?
>>>>>>>> Yes, after kernel and qemu fixed, this issue never happens again.
>>>>>>> I'm confused; which qemu fix; my question was whether the kernel fix
>>>>>>> by itself fixed the problem of the missing event.
>>>>>> this qemu fix:
>>>>>> migration: update index field when delete or qsort RDMALocalBlock
>>>>> OK good; so then we shouldn't need this 2/2 patch.
>>>> It is good that the qemu fix solved this issue but me and my colleagues
>>>> think we need 2/2 patch anyway.
>>>> According to IB Spec once active side send DREQ message he should wait
>>>> for
>>>> DREP message and only once it arrived it should trigger a DISCONNECT
>>>> event.
>>>> DREP message can be dropped due to network issues.
>>>> For that case the spec defines a DREP_timeout state in the CM state
>>>> machine,
>>>> if the DREP is dropped we should get a timeout and a TIMEWAIT_EXIT event
>>>> will be trigger.
>>>> Unfortunately the current kernel CM implementation doesn't include the
>>>> DREP_timeout state and in above scenario we will not get DISCONNECT or
>>>> TIMEWAIT_EXIT events.
>>>> (Similar scenario exists also for passive side).
>>>> We think it is best to apply this patch until we will enhance the kernel
>>>> code.
>>>>
>>> Hi Aviad:
>>>       How long about the DREP_timeout state?
>>>       Do RDMA have some tools like tcpdump? then I can use to confirm
>>> whether
>>>       DREP message has received.
>>>
>>>       Thanks.
>> Are you running IB or RoCE?
> RoCE v2.
Than download the latest wireshark, it should have RDMA RoCE support.
Capture packets on the associated Ethernet interface.
Let me know if you need help.
>
>>>>>> this issue also cause by some ram block is not released. but I do not
>>>>>> find the root cause.
>>>>> Hmm, we should try and track that down.
>>>>>
>>>>>>>> Do you think we should remove rdma_get_cm_event after
>>>>>>>> rdma_disconnect?
>>>>>>> I don't think so; if 'rdma_disconnect' is supposed to generate the
>>>>>>> event I think we're supposed to wait for it to know that the
>>>>>>> disconnect is really complete.
>>>>>> After move qemu_fclose to migration thread, it will not block the main
>>>>>> thread when wait the disconnection event.
>>>>> I'm not sure about moving the fclose to the migration thread; it worries
>>>>> me with the interaction with cancel and other failures.
>>>>>
>>>>> Dave
>>>>>
>>>>>>> Dave
>>>>>>>
>>>>>>>>> Dave
>>>>>>>>>
>>>>>>>>>>                  page = sg_page(sg);
>>>>>>>>>>                  if (umem->writable && dirty)
>>>>>>>>>>                      set_page_dirty_lock(page);
>>>>>>>>>>                  put_page(page);
>>>>>>>>>>             }
>>>>>>>>>>
>>>>>>>>>>             sg_free_table(&umem->sg_head);
>>>>>>>>>>             return;
>>>>>>>>>> }
>>>>>>>>>>
>>>>>>>>>>> Dave
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>>>> Dave
>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> Anyway, it should not invoke rdma_get_cm_event in main
>>>>>>>>>>>>>>>> thread, and the event channel is also destroyed in
>>>>>>>>>>>>>>>> qemu_rdma_cleanup.
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> Signed-off-by: Lidong Chen <lidongchen@tencent.com>
>>>>>>>>>>>>>>>> ---
>>>>>>>>>>>>>>>>     migration/rdma.c       | 12 ++----------
>>>>>>>>>>>>>>>>     migration/trace-events |  1 -
>>>>>>>>>>>>>>>>     2 files changed, 2 insertions(+), 11 deletions(-)
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> diff --git a/migration/rdma.c b/migration/rdma.c index
>>>>>>>>>>>>>>>> 0dd4033..92e4d30 100644
>>>>>>>>>>>>>>>> --- a/migration/rdma.c
>>>>>>>>>>>>>>>> +++ b/migration/rdma.c
>>>>>>>>>>>>>>>> @@ -2275,8 +2275,7 @@ static int
>>>>>>>>>>>>>>>> qemu_rdma_write(QEMUFile *f, RDMAContext *rdma,
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>     static void qemu_rdma_cleanup(RDMAContext *rdma)  {
>>>>>>>>>>>>>>>> -    struct rdma_cm_event *cm_event;
>>>>>>>>>>>>>>>> -    int ret, idx;
>>>>>>>>>>>>>>>> +    int idx;
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>         if (rdma->cm_id && rdma->connected) {
>>>>>>>>>>>>>>>>             if ((rdma->error_state ||
>>>>>>>>>>>>>>>> @@ -2290,14 +2289,7 @@ static void
>>>>>>>>>>>>>>>> qemu_rdma_cleanup(RDMAContext *rdma)
>>>>>>>>>>>>>>>>                 qemu_rdma_post_send_control(rdma, NULL,
>>>>>>>>>>>>>>>> &head);
>>>>>>>>>>>>>>>>             }
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> -        ret = rdma_disconnect(rdma->cm_id);
>>>>>>>>>>>>>>>> -        if (!ret) {
>>>>>>>>>>>>>>>> -
>>>>>>>>>>>>>>>> trace_qemu_rdma_cleanup_waiting_for_disconnect();
>>>>>>>>>>>>>>>> -            ret = rdma_get_cm_event(rdma->channel,
>>>>>>>>>>>>>>>> &cm_event);
>>>>>>>>>>>>>>>> -            if (!ret) {
>>>>>>>>>>>>>>>> -                rdma_ack_cm_event(cm_event);
>>>>>>>>>>>>>>>> -            }
>>>>>>>>>>>>>>>> -        }
>>>>>>>>>>>>>>>> +        rdma_disconnect(rdma->cm_id);
>>>>>>>>>>>>>>> I'm worried whether this change could break stuff:
>>>>>>>>>>>>>>> The docs say for rdma_disconnect that it flushes any posted
>>>>>>>>>>>>>>> work
>>>>>>>>>>>>>>> requests to the completion queue;  so unless we wait for the
>>>>>>>>>>>>>>> event
>>>>>>>>>>>>>>> do we know the stuff has been flushed?   In the normal
>>>>>>>>>>>>>>> non-cancel case
>>>>>>>>>>>>>>> I'm worried that means we could lose something.
>>>>>>>>>>>>>>> (But I don't know the rdma/infiniband specs well enough to
>>>>>>>>>>>>>>> know
>>>>>>>>>>>>>>> if it's
>>>>>>>>>>>>>>> really a problem).
>>>>>>>>>>>>>> In qemu_fclose function, it invoke qemu_fflush(f) before invoke
>>>>>>>>>>>>>> f->ops->close.
>>>>>>>>>>>>>> so I think it's safe for normal migration case.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> For the root cause why not receive RDMA_CM_EVENT_DISCONNECTED
>>>>>>>>>>>>>> event
>>>>>>>>>>>>>> after rdma_disconnect,
>>>>>>>>>>>>>> I loop in Aviad Yehezkel<aviadye@mellanox.com>, Aviad will help
>>>>>>>>>>>>>> us
>>>>>>>>>>>>>> find the root cause.
>>>>
>>>> Regarding previous discussion on that thread:
>>>> rdma_disconnect can be invoke even without invoking ib_dreg_mr first.
>>>>
>>>> common teardown flow:
>>>>
>>>> rdma_disconnect
>>>>     <-- here resources like QPs are still alive and can DMA to RAM
>>>> rdma_destroy_cm_id
>>>>     <-- All resources are destroyed by MR can be still active
>>>> rdma_dreg_mr
>>>>
>>>>
>>>>
>>>>>>>>>>>>>>> Dave
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>             trace_qemu_rdma_cleanup_disconnect();
>>>>>>>>>>>>>>>>             rdma->connected = false;
>>>>>>>>>>>>>>>>         }
>>>>>>>>>>>>>>>> diff --git a/migration/trace-events b/migration/trace-events
>>>>>>>>>>>>>>>> index d6be74b..64573ff 100644
>>>>>>>>>>>>>>>> --- a/migration/trace-events
>>>>>>>>>>>>>>>> +++ b/migration/trace-events
>>>>>>>>>>>>>>>> @@ -125,7 +125,6 @@ qemu_rdma_accept_pin_state(bool pin) "%d"
>>>>>>>>>>>>>>>>     qemu_rdma_accept_pin_verbsc(void *verbs) "Verbs context
>>>>>>>>>>>>>>>> after
>>>>>>>>>>>>>>>> listen: %p"
>>>>>>>>>>>>>>>>     qemu_rdma_block_for_wrid_miss(const char *wcompstr, int
>>>>>>>>>>>>>>>> wcomp, const char *gcompstr, uint64_t req) "A Wanted wrid %s
>>>>>>>>>>>>>>>> (%d) but got %s
>>>>>>>>>>>>>>>> (%" PRIu64 ")"
>>>>>>>>>>>>>>>>     qemu_rdma_cleanup_disconnect(void) ""
>>>>>>>>>>>>>>>> -qemu_rdma_cleanup_waiting_for_disconnect(void) ""
>>>>>>>>>>>>>>>>     qemu_rdma_close(void) ""
>>>>>>>>>>>>>>>>     qemu_rdma_connect_pin_all_requested(void) ""
>>>>>>>>>>>>>>>>     qemu_rdma_connect_pin_all_outcome(bool pin) "%d"
>>>>>>>>>>>>>>>> --
>>>>>>>>>>>>>>>> 1.8.3.1
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> --
>>>>>>>>>>>>>>> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>>>>>>>>>>>>> --
>>>>>>>>>>>>> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>>>>>>>>>>> --
>>>>>>>>>>> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>>>>>>>>> --
>>>>>>>>> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>>>>>>> --
>>>>>>> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>>>>> --
>>>>> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>>>>
