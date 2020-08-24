Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2083BC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 20:46:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D805A2067C
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 20:46:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D805A2067C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAJMO-00045Z-6R
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 16:46:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33264)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kAJLi-0003Nx-Uc
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 16:45:50 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:37773)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kAJLg-0000Ar-J0
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 16:45:50 -0400
Received: from [192.168.100.1] ([82.252.135.186]) by mrelayeu.kundenserver.de
 (mreue012 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MHmuE-1kMw7b3sQg-00Ew2T; Mon, 24 Aug 2020 22:45:46 +0200
Subject: Re: [PATCH v4 2/5] linux-user: Add strace support for printing
 arguments of truncate()/ftruncate() and getsid()
To: Filip Bozuta <Filip.Bozuta@syrmia.com>, qemu-devel@nongnu.org
References: <20200811164553.27713-1-Filip.Bozuta@syrmia.com>
 <20200811164553.27713-3-Filip.Bozuta@syrmia.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <54e7851b-a81c-6514-da5a-00c4fdbbb563@vivier.eu>
Date: Mon, 24 Aug 2020 22:45:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200811164553.27713-3-Filip.Bozuta@syrmia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:7inZZYyIfRoDZJptD4DdDZFpVBuHVkN+eqKhswjyJJNAnnxWqFo
 GdZgmnseS89MJV+4d0mig6Xa0EkIxSblpfglyN4V3U7/gujoEmF7ohE31f4RWMmURAwWQIT
 qlZAGgZlCwZlVU2KG/JLn0oPHF74U1mtW75NNia85SipA/nR6yS9AE+AyMzmGLyRJFj/VOz
 98q9Z6lcsHkmZ3FMlFeQQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:f4xLLqsZFIM=:M09ZTHxRDkkmPrGd7ZmVHB
 M1b5wPLhTyD1vslcz656qYeY8XprumG7fBZlSbBi7hK+MClsck5oN+xop+qe3U4bDg7Af83NM
 VAXpNPKkGhqp9u3dcNHtUTgYLyzhfaXCSfimaB1QHIPHJUCDks+8V6nbTxQyeJGB6kynjotED
 YSb69ndR75toc1I5xoMvj/A6IXvmOMp95r35sb1utQF+JtdzZuZdjlaMLBbqKabJdBNIFWahn
 NapmGILQUr9O51erbenPHLrxVcnw99AKxRL9sbotEEJ/ujSyEsoSDB8NdVxPfDIMvbS3qEl/N
 5rUT+v+FfJAa/a1/MGRqeQbUpIvzEdeOcRSCtkKdWhI79psL2P6fycIcEifjiPg5wnptW6fi/
 Au65RNrVeMOOlHailW9wq4Donnlcu7PzdjvtHOdApnBVp2Aa19mopWBc6dLU4kH+TAmWwx5Uk
 R1PKfW3Jzo6xtop05l1Lp8aGXTmBk7+UWM2EZylXVqv9nKrf7uz/UCOUmDHvffPjrUuo7jSQ0
 PyiLcpEj5XuKnc+w/251t+GWPP30D1kKnFHEoYGKQEk/mt9bNToOB3scgPR1WXtaEgGxrd3Jo
 YYhrP4UngO6BqH4tCdw0rcFf6gq3ly6rKjTtlDg64aBAmX+8UayjOjsXQ4Q+49JGCvotLCHZr
 vewSTExOcPCVrmPHDiQd4oucV5I+beHRHqdJdV259Tv3CpCxvLnwVQtshE2kBknt+VhoJLbpD
 FuYN82hwoGBfv2kT0B7Nc/xm0RHrm3qZTFuP5vpds9SY450K5sJojKf5g1pgfvw+B2EwrCxLt
 3yC1lOxIXFucTfBMszb9R9xsA09PQf+eDBnJYIf9XySruh2t1mP7WL06+N9+Z7djeU6EAt2
Received-SPF: none client-ip=212.227.126.187; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/24 16:45:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.25,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 11/08/2020 à 18:45, Filip Bozuta a écrit :
> This patch implements strace argument printing functionality for following syscalls:
> 
>     * truncate, ftruncate - truncate a file to a specified length
> 
>         int truncate/truncate64(const char *path, off_t length)
>         int ftruncate/ftruncate64(int fd, off_t length)
>         man page: https://man7.org/linux/man-pages/man2/truncate.2.html
> 
>     * getsid - get session ID
> 
>         pid_t getsid(pid_t pid)
>         man page: https://man7.org/linux/man-pages/man2/getsid.2.html
> 
> Implementation notes:
> 
>     Syscalls truncate/truncate64 take string argument types and thus a
>     separate print function "print_truncate/print_truncate64" is stated in
>     file "strace.list". This function is defined and implemented in "strace.c"
>     by using an existing function used to print string arguments: "print_string()".
>     For syscall ftruncate64, a separate printing function was also stated in
>     "strace.c" as it requires a special kind of handling.
>     The other syscalls have only primitive argument types, so the rest of the
>     implementation was handled by stating an appropriate printing format in file
>     "strace.list".
>     Function "regpairs_aligned()" was cut & pasted from "syscall.c" to "qemu.h"
>     as it is used by functions "print_truncate64()" and "print_ftruncate64()"
>     to print the offset arguments of "truncate64()" and "ftruncate64()".
> 
> Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
> Reviewed-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  linux-user/qemu.h      | 35 +++++++++++++++++++++++++++++++
>  linux-user/strace.c    | 47 ++++++++++++++++++++++++++++++++++++++++++
>  linux-user/strace.list | 10 ++++-----
>  linux-user/syscall.c   | 32 ----------------------------
>  4 files changed, 87 insertions(+), 37 deletions(-)
> 
> diff --git a/linux-user/qemu.h b/linux-user/qemu.h
> index 63ddfe86fd..f431805e57 100644
> --- a/linux-user/qemu.h
> +++ b/linux-user/qemu.h
> @@ -706,6 +706,41 @@ static inline uint64_t target_offset64(uint64_t word0, uint64_t word1)
>  }
>  #endif /* TARGET_ABI_BITS != 32 */
>  
> +
> +/* ARM EABI and MIPS expect 64bit types aligned even on pairs or registers */
> +#ifdef TARGET_ARM
> +static inline int regpairs_aligned(void *cpu_env, int num)
> +{
> +    return ((((CPUARMState *)cpu_env)->eabi) == 1) ;
> +}
> +#elif defined(TARGET_MIPS) && (TARGET_ABI_BITS == 32)
> +static inline int regpairs_aligned(void *cpu_env, int num) { return 1; }
> +#elif defined(TARGET_PPC) && !defined(TARGET_PPC64)
> +/*
> + * SysV AVI for PPC32 expects 64bit parameters to be passed on odd/even pairs
> + * of registers which translates to the same as ARM/MIPS, because we start with
> + * r3 as arg1
> + */
> +static inline int regpairs_aligned(void *cpu_env, int num) { return 1; }
> +#elif defined(TARGET_SH4)
> +/* SH4 doesn't align register pairs, except for p{read,write}64 */
> +static inline int regpairs_aligned(void *cpu_env, int num)
> +{
> +    switch (num) {
> +    case TARGET_NR_pread64:
> +    case TARGET_NR_pwrite64:
> +        return 1;
> +
> +    default:
> +        return 0;
> +    }
> +}
> +#elif defined(TARGET_XTENSA)
> +static inline int regpairs_aligned(void *cpu_env, int num) { return 1; }
> +#else
> +static inline int regpairs_aligned(void *cpu_env, int num) { return 0; }
> +#endif
> +
>  /**
>   * preexit_cleanup: housekeeping before the guest exits
>   *
> diff --git a/linux-user/strace.c b/linux-user/strace.c
> index f0624b6206..7dc239b9f1 100644
> --- a/linux-user/strace.c
> +++ b/linux-user/strace.c
> @@ -1958,6 +1958,53 @@ print_lseek(void *cpu_env, const struct syscallname *name,
>  }
>  #endif
>  
> +#ifdef TARGET_NR_truncate
> +static void
> +print_truncate(void *cpu_env, const struct syscallname *name,
> +               abi_long arg0, abi_long arg1, abi_long arg2,
> +               abi_long arg3, abi_long arg4, abi_long arg5)
> +{
> +    print_syscall_prologue(name);
> +    print_string(arg0, 0);
> +    print_raw_param(TARGET_ABI_FMT_ld, arg1, 1);
> +    print_syscall_epilogue(name);
> +}
> +#endif
> +
> +#ifdef TARGET_NR_truncate64
> +static void
> +print_truncate64(void *cpu_env, const struct syscallname *name,
> +                 abi_long arg0, abi_long arg1, abi_long arg2,
> +                 abi_long arg3, abi_long arg4, abi_long arg5)
> +{
> +    print_syscall_prologue(name);
> +    print_string(arg0, 0);
> +    if (regpairs_aligned(cpu_env, TARGET_NR_truncate64)) {
> +        arg1 = arg2;
> +        arg2 = arg3;
> +    }
> +    print_raw_param("%" PRIu64, target_offset64(arg1, arg2), 1);
> +    print_syscall_epilogue(name);
> +}
> +#endif
> +
> +#ifdef TARGET_NR_ftruncate64
> +static void
> +print_ftruncate64(void *cpu_env, const struct syscallname *name,
> +                  abi_long arg0, abi_long arg1, abi_long arg2,
> +                  abi_long arg3, abi_long arg4, abi_long arg5)
> +{
> +    print_syscall_prologue(name);
> +    print_raw_param("%d", arg0, 0);
> +    if (regpairs_aligned(cpu_env, TARGET_NR_ftruncate64)) {
> +        arg1 = arg2;
> +        arg2 = arg3;
> +    }
> +    print_raw_param("%" PRIu64, target_offset64(arg1, arg2), 1);
> +    print_syscall_epilogue(name);
> +}
> +#endif
> +
>  #if defined(TARGET_NR_socket)
>  static void
>  print_socket(void *cpu_env, const struct syscallname *name,
> diff --git a/linux-user/strace.list b/linux-user/strace.list
> index a04706a524..8e5303d035 100644
> --- a/linux-user/strace.list
> +++ b/linux-user/strace.list
> @@ -258,10 +258,10 @@
>  { TARGET_NR_ftime, "ftime" , NULL, NULL, NULL },
>  #endif
>  #ifdef TARGET_NR_ftruncate
> -{ TARGET_NR_ftruncate, "ftruncate" , NULL, NULL, NULL },
> +{ TARGET_NR_ftruncate, "ftruncate" , "%s(%d," TARGET_ABI_FMT_ld ")", NULL, NULL },
>  #endif
>  #ifdef TARGET_NR_ftruncate64
> -{ TARGET_NR_ftruncate64, "ftruncate64" , NULL, NULL, NULL },
> +{ TARGET_NR_ftruncate64, "ftruncate64" , NULL, print_ftruncate64, NULL },
>  #endif
>  #ifdef TARGET_NR_futex
>  { TARGET_NR_futex, "futex" , NULL, print_futex, NULL },
> @@ -372,7 +372,7 @@
>  { TARGET_NR_getrusage, "getrusage" , NULL, NULL, NULL },
>  #endif
>  #ifdef TARGET_NR_getsid
> -{ TARGET_NR_getsid, "getsid" , NULL, NULL, NULL },
> +{ TARGET_NR_getsid, "getsid" , "%s(%d)", NULL, NULL },
>  #endif
>  #ifdef TARGET_NR_getsockname
>  { TARGET_NR_getsockname, "getsockname" , NULL, NULL, NULL },
> @@ -1535,10 +1535,10 @@
>  { TARGET_NR_tkill, "tkill" , NULL, print_tkill, NULL },
>  #endif
>  #ifdef TARGET_NR_truncate
> -{ TARGET_NR_truncate, "truncate" , NULL, NULL, NULL },
> +{ TARGET_NR_truncate, "truncate" , NULL, print_truncate, NULL },
>  #endif
>  #ifdef TARGET_NR_truncate64
> -{ TARGET_NR_truncate64, "truncate64" , NULL, NULL, NULL },
> +{ TARGET_NR_truncate64, "truncate64" , NULL, print_truncate64, NULL },
>  #endif
>  #ifdef TARGET_NR_tuxcall
>  { TARGET_NR_tuxcall, "tuxcall" , NULL, NULL, NULL },
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index cc76ac61ba..1517096a9b 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -501,38 +501,6 @@ static inline int next_free_host_timer(void)
>  }
>  #endif
>  
> -/* ARM EABI and MIPS expect 64bit types aligned even on pairs or registers */
> -#ifdef TARGET_ARM
> -static inline int regpairs_aligned(void *cpu_env, int num)
> -{
> -    return ((((CPUARMState *)cpu_env)->eabi) == 1) ;
> -}
> -#elif defined(TARGET_MIPS) && (TARGET_ABI_BITS == 32)
> -static inline int regpairs_aligned(void *cpu_env, int num) { return 1; }
> -#elif defined(TARGET_PPC) && !defined(TARGET_PPC64)
> -/* SysV AVI for PPC32 expects 64bit parameters to be passed on odd/even pairs
> - * of registers which translates to the same as ARM/MIPS, because we start with
> - * r3 as arg1 */
> -static inline int regpairs_aligned(void *cpu_env, int num) { return 1; }
> -#elif defined(TARGET_SH4)
> -/* SH4 doesn't align register pairs, except for p{read,write}64 */
> -static inline int regpairs_aligned(void *cpu_env, int num)
> -{
> -    switch (num) {
> -    case TARGET_NR_pread64:
> -    case TARGET_NR_pwrite64:
> -        return 1;
> -
> -    default:
> -        return 0;
> -    }
> -}
> -#elif defined(TARGET_XTENSA)
> -static inline int regpairs_aligned(void *cpu_env, int num) { return 1; }
> -#else
> -static inline int regpairs_aligned(void *cpu_env, int num) { return 0; }
> -#endif
> -
>  #define ERRNO_TABLE_SIZE 1200
>  
>  /* target_to_host_errno_table[] is initialized from
> 


Applied to my linux-user-for-5.2 branch.

Thanks,
Laurent


