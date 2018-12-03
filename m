Received: from eggs.gnu.org ([2001:4830:134:3::10]:39978)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1gTjTR-0001oE-LH
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 03:21:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1gTjTM-0000Hk-RO
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 03:21:01 -0500
Received: from mga05.intel.com ([192.55.52.43]:56545)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1gTjTM-0000GT-I8
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 03:20:56 -0500
Message-ID: <5C04E50A.1040603@intel.com>
Date: Mon, 03 Dec 2018 16:10:50 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1543803511-34793-1-git-send-email-wei.w.wang@intel.com>
	<1543803511-34793-6-git-send-email-wei.w.wang@intel.com>
	<20181203052021.GC27620@xz-x1>
In-Reply-To: <20181203052021.GC27620@xz-x1>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v10 5/7] migration/ram.c: add a notifier
 chain for precopy
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, mst@redhat.com, quintela@redhat.com, dgilbert@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com, nilal@redhat.com, riel@redhat.com

On 12/03/2018 01:20 PM, Peter Xu wrote:
> On Mon, Dec 03, 2018 at 10:18:29AM +0800, Wei Wang wrote:
>> This patch adds a notifier chain for the memory precopy. This enables various
>> precopy optimizations to be invoked at specific places.
>>
>> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
>> CC: Dr. David Alan Gilbert <dgilbert@redhat.com>
>> CC: Juan Quintela <quintela@redhat.com>
>> CC: Michael S. Tsirkin <mst@redhat.com>
>> CC: Peter Xu <peterx@redhat.com>
>> ---
> [...]
>
>> +int precopy_notify(PrecopyNotifyReason reason, Error **errp);
> This function could be hidden from include/migration/misc.h, but I
> don't know whether that is a reason for a repost.
>
> And what I meant was that we fail precopy if notifier failed the
> hooks, but warning is fine too anyway no real use case there.

Yes, I was also thinking about this. Failing precopy needs to change
some upper layer functions which are defined with "void".

There is no use case that needs to fail precopy currently, so I chose to
keep the change minimal. But we can make more changes if people think
it's necessary to do.

Best,
Wei
