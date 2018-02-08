Received: from eggs.gnu.org ([2001:4830:134:3::10]:48869)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1ejesE-0005oe-0s
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 00:35:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1ejes9-0007F3-3v
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 00:35:54 -0500
Received: from mga11.intel.com ([192.55.52.93]:2795)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1ejes8-0007EX-P3
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 00:35:49 -0500
Message-ID: <5A7BE253.8050306@intel.com>
Date: Thu, 08 Feb 2018 13:38:27 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1517915299-15349-1-git-send-email-wei.w.wang@intel.com>
	<20180207015803-mutt-send-email-mst@kernel.org>
In-Reply-To: <20180207015803-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 0/3] virtio-balloon: free page hint
 reporting support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, quintela@redhat.com, dgilbert@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com, riel@redhat.com

On 02/07/2018 08:02 AM, Michael S. Tsirkin wrote:
> On Tue, Feb 06, 2018 at 07:08:16PM +0800, Wei Wang wrote:
>> This is the deivce part implementation to add a new feature,
>> VIRTIO_BALLOON_F_FREE_PAGE_HINT to the virtio-balloon device. The device
>> receives the guest free page hints from the driver and clears the
>> corresponding bits in the dirty bitmap, so that those free pages are
>> not transferred by the migration thread to the destination.
>>
>> Please see the driver patch link for test results:
>> https://lkml.org/lkml/2018/2/4/60
>>
>> ChangeLog:
>> v1->v2:
>>      1) virtio-balloon
>>          - use subsections to save free_page_report_cmd_id;
>>          - poll the free page vq after sending a cmd id to the driver;
>>          - change the free page vq size to VIRTQUEUE_MAX_SIZE;
>>          - virtio_balloon_poll_free_page_hints: handle the corner case
>>            that the free page block reported from the driver may cross
>>            the RAMBlock boundary.
>>      2) migration/ram.c
>>          - use balloon_free_page_poll to start the optimization
>>
>> Wei Wang (3):
>>    virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT
>>    migration: use the free page reporting feature from balloon
>>    virtio-balloon: add a timer to limit the free page report waiting time
> This feature needs in-tree documentation about possible ways to use it,
> tradeoffs involved etc.

OK. I plan to add the documentation in later versions after we mostly 
finalize the QEMU part design.

Best,
Wei
