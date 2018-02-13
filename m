Received: from eggs.gnu.org ([2001:4830:134:3::10]:41050)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1eldO1-0007fa-Ne
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 11:24:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1eldNy-00021Z-Jw
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 11:24:53 -0500
Sender: Richard Henderson <rth7680@gmail.com>
References: <20180213161240.19891-1-david@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <0fcb2902-111e-c32b-1b3e-c7c51740fddf@twiddle.net>
Date: Tue, 13 Feb 2018 08:24:46 -0800
MIME-Version: 1.0
In-Reply-To: <20180213161240.19891-1-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
To: David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>

On 02/13/2018 08:12 AM, David Hildenbrand wrote:
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
