Received: from eggs.gnu.org ([2001:4830:134:3::10]:58864)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1dc9t9-0008PO-ID
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 08:33:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1dc9t6-0003bd-DN
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 08:33:35 -0400
Received: from mga09.intel.com ([134.134.136.24]:43541)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1dc9t6-0003aE-3K
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 08:33:32 -0400
Message-ID: <597F2439.5070309@intel.com>
Date: Mon, 31 Jul 2017 20:36:09 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <59686EEB.8080805@intel.com>
	<20170723044036-mutt-send-email-mst@kernel.org>
	<59781119.8010200@intel.com>
	<20170726155856-mutt-send-email-mst@kernel.org>
	<597954E3.2070801@intel.com>
	<20170729020231-mutt-send-email-mst@kernel.org>
	<597C83CC.7060702@intel.com>
	<20170730043922-mutt-send-email-mst@kernel.org>
	<286AC319A985734F985F78AFA26841F739288D85@shsmsx102.ccr.corp.intel.com>
	<20170730191735-mutt-send-email-mst@kernel.org>
	<20170730191911-mutt-send-email-mst@kernel.org>
In-Reply-To: <20170730191911-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v12 5/8] virtio-balloon: VIRTIO_BALLOON_F_SG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "david@redhat.com" <david@redhat.com>, "cornelia.huck@de.ibm.com" <cornelia.huck@de.ibm.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "mgorman@techsingularity.net" <mgorman@techsingularity.net>, "aarcange@redhat.com" <aarcange@redhat.com>, "amit.shah@redhat.com" <amit.shah@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "liliang.opensource@gmail.com" <liliang.opensource@gmail.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "yang.zhang.wz@gmail.com" <yang.zhang.wz@gmail.com>, "quan.xu@aliyun.com" <quan.xu@aliyun.com>

On 07/31/2017 12:20 AM, Michael S. Tsirkin wrote:
> On Sun, Jul 30, 2017 at 07:18:33PM +0300, Michael S. Tsirkin wrote:
>> On Sun, Jul 30, 2017 at 05:59:17AM +0000, Wang, Wei W wrote:
>> That's a hypervisor implementation detail. From guest point of view,
>> discarding contents can not be distinguished from writing old contents.
>>
> Besides, ignoring the free page tricks, consider regular ballooning.
> We map page with DONTNEED then back with WILLNEED. Result is
> getting a zero page. So at least one of deflate/inflate should be input.
> I'd say both for symmetry.
>

OK, I see the point. Thanks.

Best,
Wei
