Received: from eggs.gnu.org ([2001:4830:134:3::10]:43225)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eleqJ-0005fB-LY
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 12:58:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eleqG-0001eW-HO
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 12:58:11 -0500
Date: Tue, 13 Feb 2018 18:57:45 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180213185745.6f695120.cohuck@redhat.com>
In-Reply-To: <20180213161240.19891-1-david@redhat.com>
References: <20180213161240.19891-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1] s390x/tcg: fix disabling/enabling DAT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>

On Tue, 13 Feb 2018 17:12:40 +0100
David Hildenbrand <david@redhat.com> wrote:

> Currently, all memory accesses go via the MMU of the address space
> (primary, secondary, ...). This is bad, because we don't flush the TLB
> when disabling/enabling DAT. So we could add a tlb flush. However it
> is easier to simply select the MMU we already have in place for real
> memory access.
> 
> All we have to do is point at the right MMU and allow to execute these
> pages.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
> 
> This is necessary to make the upcomming kvm-unit-tests with vmalloc support
> pass under TCG.
> 
>  target/s390x/cpu.h        |  7 ++++++-
>  target/s390x/mmu_helper.c |  2 +-
>  target/s390x/translate.c  | 10 +++++++---
>  3 files changed, 14 insertions(+), 5 deletions(-)

Thanks, applied (with tabs removed).
