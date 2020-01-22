Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00F1FC2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 14:03:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAE862465A
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 14:03:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAE862465A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuGbP-0006GW-Rt
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 09:03:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56416)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iuGZM-0004wE-P2
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 09:01:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iuGZK-0002rG-UI
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 09:01:20 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:60653)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iuGZK-0002pr-Ke
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 09:01:18 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue109 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MBltK-1ikPCB0ol2-00CDg5; Wed, 22 Jan 2020 15:01:15 +0100
Subject: Re: [PATCH] linux-user: Reserve space for brk
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200117230245.5040-1-richard.henderson@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <27e64eac-915f-fe58-7402-baf531b3f306@vivier.eu>
Date: Wed, 22 Jan 2020 15:01:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200117230245.5040-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:D4hktJoH8qvNEgwu9mKsPqwa6KmHFnpkiWytC98luVumqFpJDmw
 XmUjPBsfIF21gFCrbUYs5QXI47w8w3vNb3mbnqAdssxRHqLU7mH/lEGL28DIlMK8gkBCdjz
 ejmwlkaGGUrO9wUJbmQzlGXpOEDAwrs0UeHS8XfJyC0YsgzZfo/MBsf/5ViTeEUhZhWypJW
 StV4xGG9shWZ0Lz6IkQoQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:aNumNPssHyw=:8OVCGFZEmmXMlvwf19O7DR
 N3KDEiwXfvE1QZEFgqljU5WKUIErcoycxrz2ECcSgZd1X6HMm8PJIqrTIitQvY6aS6SAh50GQ
 n1tHv9qw8V84AOl8378jD3p/FVfYMYZDPT1dCAFsQwTh5ZzT96+zqUzu+kSTVhDRiB5Qo+qxj
 yEMNtuGyqc1hU5ry+VdphmzUu7M7cZgstG40RKKh2NOExg9zrHHT/a1fp1ZiKaVSb0DzuRJFM
 TQ+RkA2kNxfAU6d0GEQbZuOpw2g519QF6RQMZnoyHH8stvwO3NKVdLLMmnoquZqvSE7xImMZa
 UzJZ2w9j7idakSDywaPARrFNa1rj3FsY/aaYfqynXiEdGlKTOjNw3oym1u2bfy8rvcCCj/800
 P1W9SXS78i2VJWoLRzpFaxx2ZBSdCJx+cLf8h/y+N/9q5ZrNBwtPphfQCqhgtP+NTCufy/zw3
 GTYqU95YtM+Mni7wdYyDdH9LOxHSmXxVs+lwHDy8fTD5ZleLi9fYXwvHUKVTFdtDbj0i4XLaH
 nxAqrAgnKauAv5Qk1ALoLREBsN1QPT2LVhV7Yg532mtDTQFLdt/RvaHsyK9GaMEYtyzZe/A9S
 dqfHr7LA2zEyNw73TAHoLB/2PUrfUOjTh5QJmPMHpAPYkIHe5kplAD51AmWHToOEOxHefJ+Yb
 rhskCIN2FfOSZbl+YaQdYztvxjLY42BwYVEy62XsKDOmslwIBdz++5rOF+1AHubYArjEhl5W0
 3GZS8D7P3z6AGOzeR8egC9L1v32fOa7ndeUQ9gYYL2H9Ex0Odzw8DGBudsX+dVnUgh+T0fnVP
 RidsXQYDWmKSjE+KpQEmfARJNP7ri8F0O5bj/U8zJz7QLpfAwg=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 217.72.192.74
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 18/01/2020 à 00:02, Richard Henderson a écrit :
> With bad luck, we can wind up with no space at all for brk,
> which will generally cause the guest malloc to fail.
> 
> This bad luck is easier to come by with ET_DYN (PIE) binaries,
> where either the stack or the interpreter (ld.so) gets placed
> immediately after the main executable.
> 
> But there's nothing preventing this same thing from happening
> with ET_EXEC (normal) binaries, during probe_guest_base().
> 
> In both cases, reserve some extra space via mmap and release
> it back to the system after loading the interpreter and
> allocating the stack.
> 
> The choice of 16MB is somewhat arbitrary.  It's enough for libc
> to get going, but without being so large that 32-bit guests or
> 32-bit hosts are in danger of running out of virtual address space.
> It is expected that libc will be able to fall back to mmap arenas
> after the limited brk space is exhausted.
> 
> Launchpad: https://bugs.launchpad.net/qemu/+bug/1749393
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> 
> Note that the LP comments mention the fix for this in the kernel,
> and about there being a "guaranteed 128MB gap" for x86_64.  As far
> as I can see, this "gap" is part of the unmapped_area() algorithm.
> For qemu, this would correspond to mmap_find_vma(), except that,
> except when we fall back to mmap_find_vma_reserved(), we are not
> 100% in control over the allocation.
> 
> 
> r~
> 
> ---
>  linux-user/qemu.h    |  1 +
>  linux-user/elfload.c | 73 +++++++++++++++++++++++++++++++++-----------
>  2 files changed, 57 insertions(+), 17 deletions(-)
> 
> diff --git a/linux-user/qemu.h b/linux-user/qemu.h
> index f6f5fe5fbb..560a68090e 100644
> --- a/linux-user/qemu.h
> +++ b/linux-user/qemu.h
> @@ -35,6 +35,7 @@ struct image_info {
>          abi_ulong       end_data;
>          abi_ulong       start_brk;
>          abi_ulong       brk;
> +        abi_ulong       reserve_brk;
>          abi_ulong       start_mmap;
>          abi_ulong       start_stack;
>          abi_ulong       stack_limit;
> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> index 07b16cc0f4..2edb5d5b31 100644
> --- a/linux-user/elfload.c
> +++ b/linux-user/elfload.c
> @@ -10,6 +10,7 @@
>  #include "qemu/path.h"
>  #include "qemu/queue.h"
>  #include "qemu/guest-random.h"
> +#include "qemu/units.h"
>  
>  #ifdef _ARCH_PPC64
>  #undef ARCH_DLINFO
> @@ -2364,24 +2365,51 @@ static void load_elf_image(const char *image_name, int image_fd,
>          }
>      }
>  
> -    load_addr = loaddr;
> -    if (ehdr->e_type == ET_DYN) {
> -        /* The image indicates that it can be loaded anywhere.  Find a
> -           location that can hold the memory space required.  If the
> -           image is pre-linked, LOADDR will be non-zero.  Since we do
> -           not supply MAP_FIXED here we'll use that address if and
> -           only if it remains available.  */
> -        load_addr = target_mmap(loaddr, hiaddr - loaddr, PROT_NONE,
> -                                MAP_PRIVATE | MAP_ANON | MAP_NORESERVE,
> -                                -1, 0);
> -        if (load_addr == -1) {
> -            goto exit_perror;
> +    if (pinterp_name != NULL) {
> +        /*
> +         * This is the main executable.
> +         *
> +         * Reserve extra space for brk.
> +         * We hold on to this space while placing the interpreter
> +         * and the stack, lest they be placed immediately after
> +         * the data segment and block allocation from the brk.
> +         *
> +         * 16MB is chosen as "large enough" without being so large
> +         * as to allow the result to not fit with a 32-bit guest on
> +         * a 32-bit host.
> +         */
> +        info->reserve_brk = 16 * MiB;
> +        hiaddr += info->reserve_brk;
> +
> +        if (ehdr->e_type == ET_EXEC) {
> +            /*
> +             * Make sure that the low address does not conflict with
> +             * MMAP_MIN_ADDR or the QEMU application itself.
> +             */
> +            probe_guest_base(image_name, loaddr, hiaddr);
>          }
> -    } else if (pinterp_name != NULL) {
> -        /* This is the main executable.  Make sure that the low
> -           address does not conflict with MMAP_MIN_ADDR or the
> -           QEMU application itself.  */
> -        probe_guest_base(image_name, loaddr, hiaddr);
> +    }
> +
> +    /*
> +     * Reserve address space for all of this.
> +     *
> +     * In the case of ET_EXEC, we supply MAP_FIXED so that we get
> +     * exactly the address range that is required.
> +     *
> +     * Otherwise this is ET_DYN, and we are searching for a location
> +     * that can hold the memory space required.  If the image is
> +     * pre-linked, LOADDR will be non-zero, and the kernel should
> +     * honor that address if it happens to be free.
> +     *
> +     * In both cases, we will overwrite pages in this range with mappings
> +     * from the executable.
> +     */
> +    load_addr = target_mmap(loaddr, hiaddr - loaddr, PROT_NONE,
> +                            MAP_PRIVATE | MAP_ANON | MAP_NORESERVE |
> +                            (ehdr->e_type == ET_EXEC ? MAP_FIXED : 0),
> +                            -1, 0);
> +    if (load_addr == -1) {
> +        goto exit_perror;
>      }
>      load_bias = load_addr - loaddr;
>  
> @@ -2860,6 +2888,17 @@ int load_elf_binary(struct linux_binprm *bprm, struct image_info *info)
>      bprm->core_dump = &elf_core_dump;
>  #endif
>  
> +    /*
> +     * If we reserved extra space for brk, release it now.
> +     * The implementation of do_brk in syscalls.c expects to be able
> +     * to mmap pages in this space.
> +     */
> +    if (info->reserve_brk) {
> +        abi_ulong start_brk = HOST_PAGE_ALIGN(info->brk);
> +        abi_ulong end_brk = HOST_PAGE_ALIGN(info->brk + info->reserve_brk);
> +        target_munmap(start_brk, end_brk - start_brk);
> +    }
> +
>      return 0;
>  }
>  
> 

Applied to my linux-user branch.

Thanks,
Laurent

