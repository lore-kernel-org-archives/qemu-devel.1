Received: from eggs.gnu.org ([2001:4830:134:3::10]:44820)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dave.hansen@intel.com>) id 1dKQ2t-0005qV-9j
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 10:10:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dave.hansen@intel.com>) id 1dKQ2p-0007FF-96
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 10:10:19 -0400
Received: from mga07.intel.com ([134.134.136.100]:39192)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dave.hansen@intel.com>)
	id 1dKQ2o-0007Ek-W1
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 10:10:15 -0400
References: <1497004901-30593-1-git-send-email-wei.w.wang@intel.com>
	<1497004901-30593-5-git-send-email-wei.w.wang@intel.com>
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <b92af473-f00e-b956-ea97-eb4626601789@intel.com>
Date: Mon, 12 Jun 2017 07:10:12 -0700
MIME-Version: 1.0
In-Reply-To: <1497004901-30593-5-git-send-email-wei.w.wang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v11 4/6] mm: function to offer a page block
 on the free list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Wang <wei.w.wang@intel.com>, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mst@redhat.com, david@redhat.com, cornelia.huck@de.ibm.com, akpm@linux-foundation.org, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com

Please stop cc'ing me on things also sent to closed mailing lists
(virtio-dev@lists.oasis-open.org).  I'm happy to review things on open
lists, but I'm not fond of the closed lists bouncing things at me.

On 06/09/2017 03:41 AM, Wei Wang wrote:
> Add a function to find a page block on the free list specified by the
> caller. Pages from the page block may be used immediately after the
> function returns. The caller is responsible for detecting or preventing
> the use of such pages.

This description doesn't tell me very much about what's going on here.
Neither does the comment.

"Pages from the page block may be used immediately after the
 function returns".

Used by who?  Does the "may" here mean that it is OK, or is it a warning
that the contents will be thrown away immediately?

The hypervisor is going to throw away the contents of these pages,
right?  As soon as the spinlock is released, someone can allocate a
page, and put good data in it.  What keeps the hypervisor from throwing
away good data?
