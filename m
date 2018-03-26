Received: from eggs.gnu.org ([2001:4830:134:3::10]:42770)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1f0Pmc-0003Md-NJ
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 06:55:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1f0PmX-0003SM-D3
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 06:55:22 -0400
Received: from mga09.intel.com ([134.134.136.24]:42873)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1f0PmX-0003RR-3G
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 06:55:17 -0400
Message-ID: <5AB8D24F.8020304@intel.com>
Date: Mon, 26 Mar 2018 18:58:23 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1521197309-13544-1-git-send-email-wei.w.wang@intel.com>
	<1521197309-13544-5-git-send-email-wei.w.wang@intel.com>
	<20180316165319-mutt-send-email-mst@kernel.org>
	<5AAE4124.5010602@intel.com>
	<20180319062023-mutt-send-email-mst@kernel.org>
	<5AAF7C72.5070403@intel.com>
	<20180320004900-mutt-send-email-mst@kernel.org>
	<5AB06EE9.1030306@intel.com>
	<20180320045134-mutt-send-email-mst@kernel.org>
	<5AB07D7F.90205@intel.com>
	<20180320051840-mutt-send-email-mst@kernel.org>
	<5AB31F68.8000605@intel.com>
In-Reply-To: <5AB31F68.8000605@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [virtio-dev] Re: [PATCH v5 4/5] virtio-balloon:
 VIRTIO_BALLOON_F_FREE_PAGE_HINT
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

On 03/22/2018 11:13 AM, Wei Wang wrote:
>
> OK. I've tried to implement it this way: create an iothread via the 
> qemu cmdline option: --device 
> virtio-balloon,free-page-hint=true,iothread=iothread10, and schedule a 
> BH to run in the iothread context when free_page_start() is called.
>
> I think the drawback of this method is that the iothread exists during 
> the whole QEMU lifetime, which wastes CPU cycles (e.g. when live 
> migration isn't in progress). The method in v5 is like migration 
> thread, which comes only when the migration request is received and 
> goes when migration is done. Any thought?
>

Hi Michael,

Would it be acceptable to go with the thread creation method for now? I 
would prefer that method for the above reasons. If you are very 
confident about the iothread method, I can also send out the patches 
with that implementation. Hope we could finish this feature soon. Thanks.

Best,
Wei
