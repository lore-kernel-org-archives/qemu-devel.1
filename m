Received: from eggs.gnu.org ([2001:4830:134:3::10]:53110)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <willy@infradead.org>) id 1eRzkN-0008Vw-IY
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 07:14:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <willy@infradead.org>) id 1eRzkK-0005H4-8z
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 07:14:47 -0500
Received: from bombadil.infradead.org ([65.50.211.133]:59494)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <willy@infradead.org>) id 1eRzkJ-0005Fn-W1
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 07:14:44 -0500
Date: Thu, 21 Dec 2017 04:14:37 -0800
From: Matthew Wilcox <willy@infradead.org>
Message-ID: <20171221121437.GA22405@bombadil.infradead.org>
References: <1513685879-21823-1-git-send-email-wei.w.wang@intel.com>
	<201712192305.AAE21882.MtQHJOFFSFVOLO@I-love.SAKURA.ne.jp>
	<5A3A3CBC.4030202@intel.com>
	<20171220122547.GA1654@bombadil.infradead.org>
	<286AC319A985734F985F78AFA26841F73938CC3E@shsmsx102.ccr.corp.intel.com>
	<20171220171019.GA12236@bombadil.infradead.org>
	<5A3B2148.8050306@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5A3B2148.8050306@intel.com>
Subject: Re: [Qemu-devel] [PATCH v20 0/7] Virtio-balloon Enhancement
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Wang <wei.w.wang@intel.com>
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "mst@redhat.com" <mst@redhat.com>, "mhocko@kernel.org" <mhocko@kernel.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "mawilcox@microsoft.com" <mawilcox@microsoft.com>, "david@redhat.com" <david@redhat.com>, "cornelia.huck@de.ibm.com" <cornelia.huck@de.ibm.com>, "mgorman@techsingularity.net" <mgorman@techsingularity.net>, "aarcange@redhat.com" <aarcange@redhat.com>, "amit.shah@redhat.com" <amit.shah@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "liliang.opensource@gmail.com" <liliang.opensource@gmail.com>, "yang.zhang.wz@gmail.com" <yang.zhang.wz@gmail.com>, "quan.xu0@gmail.com" <quan.xu0@gmail.com>, "nilal@redhat.com" <nilal@redhat.com>, "riel@redhat.com" <riel@redhat.com>

On Thu, Dec 21, 2017 at 10:49:44AM +0800, Wei Wang wrote:
> On 12/21/2017 01:10 AM, Matthew Wilcox wrote:
> One more question is about the return value, why would it be ambiguous? I
> think it is the same as find_next_bit() which returns the found bit or size
> if not found.

Because find_next_bit doesn't reasonably support a bitmap which is
ULONG_MAX in size.  The point of XBitmap is to support a bitmap which
is ULONG_MAX in size, so every possible return value is a legitimate
"we found a bit here".  There's no value which can possibly be used for
"no bit was found".
