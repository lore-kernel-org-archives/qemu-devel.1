Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D325C18E7D
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 09:41:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3FA4208C3
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 09:41:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3FA4208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39307 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTNkc-00017E-28
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 05:41:34 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47252)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hTNjr-0000ht-0f
	for qemu-devel@nongnu.org; Wed, 22 May 2019 05:40:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hTNjp-0008SN-BO
	for qemu-devel@nongnu.org; Wed, 22 May 2019 05:40:46 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:46737)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hTNjo-0008ND-NC
	for qemu-devel@nongnu.org; Wed, 22 May 2019 05:40:45 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
	(mreue109 [213.165.67.119]) with ESMTPSA (Nemesis) id
	1MTAJl-1h4SVJ22IR-00UaRS; Wed, 22 May 2019 11:40:42 +0200
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190519201953.20161-1-richard.henderson@linaro.org>
	<20190519201953.20161-13-richard.henderson@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <415aa819-08d2-96f6-ea23-381c3ae0382c@vivier.eu>
Date: Wed, 22 May 2019 11:40:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20190519201953.20161-13-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:TLinGuDGi2SKEWIZ1Pet9LeB6iBjk6MnfMGo2kSFl/CsdFkeXdx
	M7CPsr7IdgiGr84ACFE72MAhUItrIbofczGCH1KFW/4VMSWji13zrYS/+J6btaDhBfCceCF
	yStKRzfg5iw+4gUcMAj4HOLq1mOGpoBCu8V2dElUrYFSwiZjUHhivAJ+Ep03XXuVUt9Y/56
	46NVa+mn92n0aibEwvy8w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qUkYa990ma8=:quyj8F2T56XKcpOAVSXg8z
	D9MZHJlLIAEdUundmOvLfduFt4I6nd6TXFKYE8zvucC9Hks1fhhr9X0Q1npwVFOqFzlaZbiTH
	+uwMNF8TPpK2srxsp7mYEDW01Wkr3UELysa+ZVgZe+xiG5yz2Ng8A5/C6joOT4pnn1jw7LNOw
	ykvwtufccxZqzNgbhTdw+zpSQMEKNHDLQIK9dMFlbN6WtK7B5p5MFwYxP13bWql4QK9q0iwfn
	qp2D94KInjBlVfbMUWDbTpYFYYlzc0fe1VQHJQG4f/1lj03f/chiutBeSzAYOz3ex8bpFu2mi
	cdsxFjOtH5fhyAB7rmiUvTdNVqm88am23uECGQSWb4BscBzKfGp3wLyz3hVkGJlWPpeI8aSz2
	w8Gku5csFhMkm24jHOVRvTYC2RpqUyqG46KyN59Vo9Cw/qRGzUlv4P7QppOVqkpjIpEH/VYFY
	QVzkO5hkJaP9x698K39RI0Q5OGcg2iC4Mqr2k3juQHJa6VtwWPI1DqiJfXnM4q+vDzzjk8zVd
	gU7Cpg+0cy1pKXfhKzQv4YWG6Usonhx+XEdxEieEWnbTYCAGSSvEIQBha5teU3hcCyEiHkKy+
	gtgrAkqYIQBjvNgtxCUzQmyGVo+960DcAprT28I+y2cFsYDJtJdCD2BEQaGGzluesCchiP4q+
	F/cyL7xpa+DB9ymUQc5o3/hl9ZiwMsZGcY3UPNWhsLmAAN6lJ8f+/wVNkMauTbU9TjdSE/wdj
	MuOcdzVwDD9CSlLyyKTUjXTSMv9qIvMkazu8Oxm4Qv5TTFh4YIzNx61zSRo=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.13
Subject: Re: [Qemu-devel] [PATCH 12/13] linux-user: Fix shmat emulation by
 honoring host SHMLBA
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 19/05/2019 22:19, Richard Henderson wrote:
> For those hosts with SHMLBA > getpagesize, we don't automatically
> select a guest address that is compatible with the host.  We can
> achieve this by boosting the alignment of guest_base and by adding
> an extra alignment argument to mmap_find_vma.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   linux-user/qemu.h    |  2 +-
>   linux-user/elfload.c | 17 +++++-----
>   linux-user/mmap.c    | 74 +++++++++++++++++++++++---------------------
>   linux-user/syscall.c |  3 +-
>   4 files changed, 52 insertions(+), 44 deletions(-)
> 
> diff --git a/linux-user/qemu.h b/linux-user/qemu.h
> index ef400cb78a..82d33d7e93 100644
> --- a/linux-user/qemu.h
> +++ b/linux-user/qemu.h
> @@ -443,7 +443,7 @@ abi_long target_mremap(abi_ulong old_addr, abi_ulong old_size,
>                          abi_ulong new_addr);
>   extern unsigned long last_brk;
>   extern abi_ulong mmap_next_start;
> -abi_ulong mmap_find_vma(abi_ulong, abi_ulong);
> +abi_ulong mmap_find_vma(abi_ulong, abi_ulong, abi_ulong);
>   void mmap_fork_start(void);
>   void mmap_fork_end(int child);
>   
> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> index ef42e02d82..fe9f07843e 100644
> --- a/linux-user/elfload.c
> +++ b/linux-user/elfload.c
> @@ -3,6 +3,7 @@
>   #include <sys/param.h>
>   
>   #include <sys/resource.h>
> +#include <sys/shm.h>
>   
>   #include "qemu.h"
>   #include "disas/disas.h"
> @@ -2012,6 +2013,8 @@ unsigned long init_guest_space(unsigned long host_start,
>                                  unsigned long guest_start,
>                                  bool fixed)
>   {
> +    /* In order to use host shmat, we must be able to honor SHMLBA.  */
> +    unsigned long align = MAX(SHMLBA, qemu_host_page_size);
>       unsigned long current_start, aligned_start;
>       int flags;
>   
> @@ -2029,7 +2032,7 @@ unsigned long init_guest_space(unsigned long host_start,
>       }
>   
>       /* Setup the initial flags and start address.  */
> -    current_start = host_start & qemu_host_page_mask;
> +    current_start = host_start & -align;
>       flags = MAP_ANONYMOUS | MAP_PRIVATE | MAP_NORESERVE;
>       if (fixed) {
>           flags |= MAP_FIXED;
> @@ -2065,8 +2068,8 @@ unsigned long init_guest_space(unsigned long host_start,
>               return (unsigned long)-1;
>           }
>           munmap((void *)real_start, host_full_size);
> -        if (real_start & ~qemu_host_page_mask) {
> -            /* The same thing again, but with an extra qemu_host_page_size
> +        if (real_start & (align - 1)) {
> +            /* The same thing again, but with extra
>                * so that we can shift around alignment.
>                */
>               unsigned long real_size = host_full_size + qemu_host_page_size;
> @@ -2079,7 +2082,7 @@ unsigned long init_guest_space(unsigned long host_start,
>                   return (unsigned long)-1;
>               }
>               munmap((void *)real_start, real_size);
> -            real_start = HOST_PAGE_ALIGN(real_start);
> +            real_start = ROUND_UP(real_start, align);
>           }
>           current_start = real_start;
>       }
> @@ -2106,7 +2109,7 @@ unsigned long init_guest_space(unsigned long host_start,
>           }
>   
>           /* Ensure the address is properly aligned.  */
> -        if (real_start & ~qemu_host_page_mask) {
> +        if (real_start & (align - 1)) {
>               /* Ideally, we adjust like
>                *
>                *    pages: [  ][  ][  ][  ][  ]
> @@ -2134,7 +2137,7 @@ unsigned long init_guest_space(unsigned long host_start,
>               if (real_start == (unsigned long)-1) {
>                   return (unsigned long)-1;
>               }
> -            aligned_start = HOST_PAGE_ALIGN(real_start);
> +            aligned_start = ROUND_UP(real_start, align);
>           } else {
>               aligned_start = real_start;
>           }
> @@ -2171,7 +2174,7 @@ unsigned long init_guest_space(unsigned long host_start,
>            * because of trouble with ARM commpage setup.
>            */
>           munmap((void *)real_start, real_size);
> -        current_start += qemu_host_page_size;
> +        current_start += align;
>           if (host_start == current_start) {
>               /* Theoretically possible if host doesn't have any suitably
>                * aligned areas.  Normally the first mmap will fail.
> diff --git a/linux-user/mmap.c b/linux-user/mmap.c
> index e0249efe4f..10796b37ac 100644
> --- a/linux-user/mmap.c
> +++ b/linux-user/mmap.c
> @@ -202,49 +202,52 @@ unsigned long last_brk;
>   
>   /* Subroutine of mmap_find_vma, used when we have pre-allocated a chunk
>      of guest address space.  */
> -static abi_ulong mmap_find_vma_reserved(abi_ulong start, abi_ulong size)
> +static abi_ulong mmap_find_vma_reserved(abi_ulong start, abi_ulong size,
> +                                        abi_ulong align)
>   {
> -    abi_ulong addr;
> -    abi_ulong end_addr;
> +    abi_ulong addr, end_addr, incr = qemu_host_page_size;
>       int prot;
> -    int looped = 0;
> +    bool looped = false;
>   
>       if (size > reserved_va) {
>           return (abi_ulong)-1;
>       }
>   
> -    size = HOST_PAGE_ALIGN(size);
> -    end_addr = start + size;
> -    if (end_addr > reserved_va) {
> -        end_addr = reserved_va;
> -    }
> -    addr = end_addr - qemu_host_page_size;
> +    /* Note that start and size have already been aligned by mmap_find_vma. */
>   
> +    end_addr = start + size;
> +    if (start > reserved_va - size) {
> +        /* Start at the top of the address space.  */
> +        end_addr = ((reserved_va - size) & -align) + size;
> +        looped = true;
> +    }
> +
> +    /* Search downward from END_ADDR, checking to see if a page is in use.  */
> +    addr = end_addr;
>       while (1) {
> +        addr -= incr;
>           if (addr > end_addr) {
>               if (looped) {
> +                /* Failure.  The entire address space has been searched.  */
>                   return (abi_ulong)-1;
>               }
> -            end_addr = reserved_va;
> -            addr = end_addr - qemu_host_page_size;
> -            looped = 1;
> -            continue;
> +            /* Re-start at the top of the address space.  */
> +            addr = end_addr = ((reserved_va - size) & -align) + size;
> +            looped = true;
> +        } else {
> +            prot = page_get_flags(addr);
> +            if (prot) {
> +                /* Page in use.  Restart below this page.  */
> +                addr = end_addr = ((addr - size) & -align) + size;
> +            } else if (addr && addr + size == end_addr) {
> +                /* Success!  All pages between ADDR and END_ADDR are free.  */
> +                if (start == mmap_next_start) {
> +                    mmap_next_start = addr;
> +                }
> +                return addr;
> +            }
>           }
> -        prot = page_get_flags(addr);
> -        if (prot) {
> -            end_addr = addr;
> -        }
> -        if (addr && addr + size == end_addr) {
> -            break;
> -        }
> -        addr -= qemu_host_page_size;
>       }
> -
> -    if (start == mmap_next_start) {
> -        mmap_next_start = addr;
> -    }
> -
> -    return addr;
>   }
>   
>   /*
> @@ -253,7 +256,7 @@ static abi_ulong mmap_find_vma_reserved(abi_ulong start, abi_ulong size)
>    * It must be called with mmap_lock() held.
>    * Return -1 if error.
>    */
> -abi_ulong mmap_find_vma(abi_ulong start, abi_ulong size)
> +abi_ulong mmap_find_vma(abi_ulong start, abi_ulong size, abi_ulong align)
>   {
>       void *ptr, *prev;
>       abi_ulong addr;
> @@ -265,11 +268,12 @@ abi_ulong mmap_find_vma(abi_ulong start, abi_ulong size)
>       } else {
>           start &= qemu_host_page_mask;
>       }
> +    start = ROUND_UP(start, align);
>   
>       size = HOST_PAGE_ALIGN(size);
>   
>       if (reserved_va) {
> -        return mmap_find_vma_reserved(start, size);
> +        return mmap_find_vma_reserved(start, size, align);
>       }
>   
>       addr = start;
> @@ -299,7 +303,7 @@ abi_ulong mmap_find_vma(abi_ulong start, abi_ulong size)
>           if (h2g_valid(ptr + size - 1)) {
>               addr = h2g(ptr);
>   
> -            if ((addr & ~TARGET_PAGE_MASK) == 0) {
> +            if ((addr & (align - 1)) == 0) {
>                   /* Success.  */
>                   if (start == mmap_next_start && addr >= TASK_UNMAPPED_BASE) {
>                       mmap_next_start = addr + size;
> @@ -313,12 +317,12 @@ abi_ulong mmap_find_vma(abi_ulong start, abi_ulong size)
>                   /* Assume the result that the kernel gave us is the
>                      first with enough free space, so start again at the
>                      next higher target page.  */
> -                addr = TARGET_PAGE_ALIGN(addr);
> +                addr = ROUND_UP(addr, align);
>                   break;
>               case 1:
>                   /* Sometimes the kernel decides to perform the allocation
>                      at the top end of memory instead.  */
> -                addr &= TARGET_PAGE_MASK;
> +                addr &= -align;
>                   break;
>               case 2:
>                   /* Start over at low memory.  */
> @@ -416,7 +420,7 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int prot,
>       if (!(flags & MAP_FIXED)) {
>           host_len = len + offset - host_offset;
>           host_len = HOST_PAGE_ALIGN(host_len);
> -        start = mmap_find_vma(real_start, host_len);
> +        start = mmap_find_vma(real_start, host_len, TARGET_PAGE_SIZE);
>           if (start == (abi_ulong)-1) {
>               errno = ENOMEM;
>               goto fail;
> @@ -710,7 +714,7 @@ abi_long target_mremap(abi_ulong old_addr, abi_ulong old_size,
>       } else if (flags & MREMAP_MAYMOVE) {
>           abi_ulong mmap_start;
>   
> -        mmap_start = mmap_find_vma(0, new_size);
> +        mmap_start = mmap_find_vma(0, new_size, TARGET_PAGE_SIZE);
>   
>           if (mmap_start == -1) {
>               errno = ENOMEM;
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index f960556bf8..1feb740f66 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -3912,7 +3912,8 @@ static inline abi_ulong do_shmat(CPUArchState *cpu_env,
>       else {
>           abi_ulong mmap_start;
>   
> -        mmap_start = mmap_find_vma(0, shm_info.shm_segsz);
> +        /* In order to use the host shmat, we need to honor host SHMLBA.  */
> +        mmap_start = mmap_find_vma(0, shm_info.shm_segsz, MAX(SHMLBA, shmlba));
>   
>           if (mmap_start == -1) {
>               errno = ENOMEM;
> 

Applied to my linux-user branch.

Thanks,
Laurent

