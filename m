Received: from eggs.gnu.org ([2001:4830:134:3::10]:43058)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1cEBJ4-0005zQ-1G
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 03:40:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1cEBJ0-0004Oe-Vx
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 03:40:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57792)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1cEBJ0-0004OH-QD
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 03:40:54 -0500
References: <1480495397-23225-1-git-send-email-liang.z.li@intel.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <f67ca79c-ad34-59dd-835f-e7bc9dcaef58@redhat.com>
Date: Tue, 6 Dec 2016 09:40:47 +0100
MIME-Version: 1.0
In-Reply-To: <1480495397-23225-1-git-send-email-liang.z.li@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH kernel v5 0/5] Extend virtio-balloon for
 fast (de)inflating & fast live migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Liang Li <liang.z.li@intel.com>, kvm@vger.kernel.org
Cc: virtio-dev@lists.oasis-open.org, mhocko@suse.com, mst@redhat.com, dave.hansen@intel.com, qemu-devel@nongnu.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, kirill.shutemov@linux.intel.com, pbonzini@redhat.com, akpm@linux-foundation.org, virtualization@lists.linux-foundation.org, dgilbert@redhat.com

Am 30.11.2016 um 09:43 schrieb Liang Li:
> This patch set contains two parts of changes to the virtio-balloon.
>
> One is the change for speeding up the inflating & deflating process,
> the main idea of this optimization is to use bitmap to send the page
> information to host instead of the PFNs, to reduce the overhead of
> virtio data transmission, address translation and madvise(). This can
> help to improve the performance by about 85%.

Do you have some statistics/some rough feeling how many consecutive bits 
are usually set in the bitmaps? Is it really just purely random or is 
there some granularity that is usually consecutive?

IOW in real examples, do we have really large consecutive areas or are 
all pages just completely distributed over our memory?

Thanks!

-- 

David
