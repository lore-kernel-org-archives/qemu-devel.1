Received: from eggs.gnu.org ([2001:4830:134:3::10]:47105)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <atsushi.nemoto@sord.co.jp>) id 1gSDXc-0004lz-1i
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 23:03:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <atsushi.nemoto@sord.co.jp>) id 1gSDXW-0003bt-UH
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 23:03:03 -0500
Received: from ms2.toshiba-tops.co.jp ([61.200.21.4]:57175
	helo=dmz-ms2.toshiba-tops.co.jp)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <atsushi.nemoto@sord.co.jp>) id 1gSDXW-0003XP-Hg
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 23:02:58 -0500
Date: Thu, 29 Nov 2018 13:02:27 +0900
Message-ID: <20181129.130227.311149561952416025.atsushi.nemoto@sord.co.jp>
From: Atsushi Nemoto <atsushi.nemoto@sord.co.jp>
In-Reply-To: <7329ea70-1ae9-4084-0f65-b5ad252348bb@redhat.com>
References: <20181128.181700.1038782556965887223.atsushi.nemoto@sord.co.jp>
	<7329ea70-1ae9-4084-0f65-b5ad252348bb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] memory: update coalesced_range on
 transaction_commit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com
Cc: qemu-devel@nongnu.org

On Wed, 28 Nov 2018 17:30:59 +0100, Paolo Bonzini <pbonzini@redhat.com> wrote:
>> The e1000 driver calls memory_region_add_coalescing but
>> kvm_coalesce_mmio_region never been called for those regions.
>> 
>> Update coalesced_range on memory_region_transaction_commit to fix this.
>> 
>> It seems very old bug since memory region API
>> was merged on commit 093bc2cd885e ("Hierarchical memory region API").
>> 
>> Signed-off-by: Atsushi Nemoto <atsushi.nemoto@sord.co.jp>
> 
> I attach the patch I came up with.  What do you think?

Thank you for the alternative fix.
It works well and looks good to me.

---
Atsushi Nemoto
