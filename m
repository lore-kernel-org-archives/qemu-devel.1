Received: from eggs.gnu.org ([2001:4830:134:3::10]:43784)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1fArbv-0004wm-I7
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 02:39:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1fArbr-0001cW-4z
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 02:39:31 -0400
Received: from mga07.intel.com ([134.134.136.100]:19659)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1fArbq-0001cG-3Y
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 02:39:27 -0400
Message-ID: <5ADED1EA.2000608@intel.com>
Date: Tue, 24 Apr 2018 14:42:50 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1524550428-27173-1-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1524550428-27173-1-git-send-email-wei.w.wang@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v7 0/5] virtio-balloon: free page hint
 reporting support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, mst@redhat.com, quintela@redhat.com, dgilbert@redhat.com
Cc: pbonzini@redhat.com, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com, riel@redhat.com

On 04/24/2018 02:13 PM, Wei Wang wrote:
> This is the deivce part implementation to add a new feature,
> VIRTIO_BALLOON_F_FREE_PAGE_HINT to the virtio-balloon device. The device
> receives the guest free page hints from the driver and clears the
> corresponding bits in the dirty bitmap, so that those free pages are
> not transferred by the migration thread to the destination.
>
> - Test Environment
>      Host: Intel(R) Xeon(R) CPU E5-2699 v4 @ 2.20GHz
>      Guest: 8G RAM, 4 vCPU
>      Migration setup: migrate_set_speed 100G, migrate_set_downtime 2 second
>
> - Test Results
>      - Idle Guest Live Migration Time (results are averaged over 10 runs):
>          - Optimization v.s. Legacy = 271ms vs 1769ms --> ~86% reduction
>      - Guest with Linux Compilation Workload (make bzImage -j4):
>          - Live Migration Time (average)
>            Optimization v.s. Legacy = 1265ms v.s. 2634ms --> ~51% reduction
>          - Linux Compilation Time
>            Optimization v.s. Legacy = 4min56s v.s. 5min3s
>            --> no obvious difference
>
> - Source Code
>      - QEMU:  https://github.com/wei-w-wang/qemu-free-page-lm.git
>      - Linux: https://github.com/wei-w-wang/linux-free-page-lm.git
>
> ChangeLog:
> v6->v7:
>        virtio-balloon/virtio_balloo_poll_free_page_hints:
>            - add virtio_notify() at the end to notify the driver that
>              the optimization is done, which indicates that the entries
>              have all been put back to the vq and ready to detach them.

Hi Dave,

Thanks for reviewing this patch series. Do you have more comments on 
them? If no, would it be possible to get your reviewed-by?
The current kernel part is done already. Hope we could finish the QEMU 
part soon, and have people start to use this feature. Thanks.

Best,
Wei
