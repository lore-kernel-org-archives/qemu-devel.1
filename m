Received: from eggs.gnu.org ([2001:4830:134:3::10]:44908)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1e55pI-0007ua-Jr
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 04:05:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1e55pD-0004bo-0h
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 04:05:12 -0400
Received: from mga11.intel.com ([192.55.52.93]:45861)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1e55pC-0004bI-MU
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 04:05:06 -0400
Message-ID: <59E85D2A.1060407@intel.com>
Date: Thu, 19 Oct 2017 16:07:06 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1506744354-20979-1-git-send-email-wei.w.wang@intel.com>
	<1506744354-20979-6-git-send-email-wei.w.wang@intel.com>
	<20171001060305-mutt-send-email-mst@kernel.org>
	<286AC319A985734F985F78AFA26841F73932025A@shsmsx102.ccr.corp.intel.com>
	<20171010180636-mutt-send-email-mst@kernel.org>
	<59DDB428.4020208@intel.com>
	<20171011161912-mutt-send-email-mst@kernel.org>
	<59DEE790.5040809@intel.com>
	<20171013163503-mutt-send-email-mst@kernel.org>
In-Reply-To: <20171013163503-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v16 5/5] virtio-balloon:
 VIRTIO_BALLOON_F_CTRL_VQ
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "mhocko@kernel.org" <mhocko@kernel.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "mawilcox@microsoft.com" <mawilcox@microsoft.com>, "david@redhat.com" <david@redhat.com>, "cornelia.huck@de.ibm.com" <cornelia.huck@de.ibm.com>, "mgorman@techsingularity.net" <mgorman@techsingularity.net>, "aarcange@redhat.com" <aarcange@redhat.com>, "amit.shah@redhat.com" <amit.shah@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "willy@infradead.org" <willy@infradead.org>, "liliang.opensource@gmail.com" <liliang.opensource@gmail.com>, "yang.zhang.wz@gmail.com" <yang.zhang.wz@gmail.com>, "quan.xu@aliyun.com" <quan.xu@aliyun.com>

On 10/13/2017 09:38 PM, Michael S. Tsirkin wrote:
> On Thu, Oct 12, 2017 at 11:54:56AM +0800, Wei Wang wrote:
>>> But I think flushing is very fragile. You will easily run into races
>>> if one of the actors gets out of sync and keeps adding data.
>>> I think adding an ID in the free vq stream is a more robust
>>> approach.
>>>
>> Adding ID to the free vq would need the device to distinguish whether it
>> receives an ID or a free page hint,
> Not really.  It's pretty simple: a 64 bit buffer is an ID. A 4K and bigger one
> is a page.

I think we can also use the previous method, free page via in_buf, and 
id via out_buf.

Best,
Wei
