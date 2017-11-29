Received: from eggs.gnu.org ([2001:4830:134:3::10]:32924)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eK9Su-0007yu-IA
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 16:00:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eK9Sq-0002ku-L0
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 16:00:20 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:38611)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eK9Sq-0002kd-94
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 16:00:16 -0500
Received: by mail-wm0-x241.google.com with SMTP id 64so8549855wme.3
	for <qemu-devel@nongnu.org>; Wed, 29 Nov 2017 13:00:16 -0800 (PST)
References: <20171129202701.16117-1-david@redhat.com>
	<20171129202701.16117-8-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <7aeef32e-7cf9-a1ce-e900-375b186beb75@linaro.org>
Date: Wed, 29 Nov 2017 21:00:12 +0000
MIME-Version: 1.0
In-Reply-To: <20171129202701.16117-8-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 for-2.12 07/16] s390x: handle exceptions
 during s390_cpu_virt_mem_rw() correctly (TCG)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>

On 11/29/2017 08:26 PM, David Hildenbrand wrote:
> s390_cpu_virt_mem_rw() must always return, so callers can react on
> an exception (e.g. see ioinst_handle_stcrw()).
> 
> However, for TCG we always have to exit the cpu loop (and restore the
> cpu state before that) if we injected a program interrupt. So let's
> introduce and use s390_cpu_virt_mem_handle_exc() in code that is not
> purely KVM.
> 
> Directly pass the retaddr we already have available in these functions.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  hw/s390x/s390-pci-inst.c  |  7 +++++++
>  target/s390x/cpu.h        |  1 +
>  target/s390x/ioinst.c     | 20 +++++++++++++++++---
>  target/s390x/mmu_helper.c | 14 ++++++++++++++
>  4 files changed, 39 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
