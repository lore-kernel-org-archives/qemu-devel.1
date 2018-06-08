Received: from eggs.gnu.org ([2001:4830:134:3::10]:59745)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1fRBoi-0001GC-2v
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 03:28:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1fRBoe-0001MN-Vi
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 03:28:12 -0400
Received: from mga18.intel.com ([134.134.136.126]:58319)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1fRBoe-0001Km-PO
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 03:28:08 -0400
Message-ID: <5B1A30ED.6040906@intel.com>
Date: Fri, 08 Jun 2018 15:31:57 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <20180529181221-mutt-send-email-mst@kernel.org>
	<5B0E6AE9.2030505@intel.com>
	<20180530154325-mutt-send-email-mst@kernel.org>
	<5B14F2A3.9010805@intel.com> <20180605065857.GC9216@xz-mi>
	<5B168EAB.7090607@intel.com> <20180606054227.GA7815@xz-mi>
	<5B17B1A7.8060307@intel.com> <20180606110217.GF7815@xz-mi>
	<5B18C18D.3070007@intel.com> <20180607063241.GA750@xz-mi>
In-Reply-To: <20180607063241.GA750@xz-mi>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v7 4/5] virtio-balloon:
 VIRTIO_BALLOON_F_FREE_PAGE_HINT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, quintela@redhat.com, dgilbert@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com, riel@redhat.com, zhang.zhanghailiang@huawei.com

On 06/07/2018 02:32 PM, Peter Xu wrote:
>>>> Btw, the migration_state_notifiers is already there, but seems not really
>>>> used (I only tracked spice-core.c called
>>>> add_migration_state_change_notifier). I thought adding new migration states
>>>> can reuse all that we have.
>>>> What's your real concern about that? (not sure how defining new events would
>>>> make a difference)
>>> Migration state is exposed via control path (QMP).  Adding new states
>>> mean that the QMP clients will see more.  IMO that's not really
>>> anything that a QMP client will need to know, instead we can keep it
>>> internally.  That's a reason from compatibility pov.
>>>
>>> Meanwhile, it's not really a state-thing at all for me.  It looks
>>> really more like hook or event (start/stop of sync).
>> Thanks for sharing your concerns in detail, which are quite helpful for the
>> discussion. To reuse 99a0db9b, we can also add sub-states (or say events),
>> instead of new migration states.
>> For example, we can still define "enum RamSaveState" as above, which can be
>> an indication for the notifier queued on the 99a0db9b notider_list to decide
>> whether to call start or stop.
>> Does this solve your concern?
> Frankly speaking I don't fully understand how you would add that
> sub-state.  If you are confident with the idea, maybe you can post
> your new version with the change, then I can read the code.

Reusing 99a0db9b functions well, but I find it is more clear to let ram 
save state have it's own notifier list..will show how that works in v8.

Best,
Wei
