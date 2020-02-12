Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76C99C352A4
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 21:10:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3917C21739
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 21:10:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3917C21739
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1zHO-0004fn-C6
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 16:10:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47786)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1j1zGa-000441-6n
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 16:09:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1j1zGY-0001SC-2l
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 16:09:52 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:40335)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1j1zGX-0001Qp-Pu
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 16:09:50 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue107 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MfZDK-1jhvir2lnE-00fwbC; Wed, 12 Feb 2020 22:09:21 +0100
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
References: <1580818058-16159-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1580818058-16159-6-git-send-email-aleksandar.markovic@rt-rk.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 mQINBFYFJhkBEAC2me7w2+RizYOKZM+vZCx69GTewOwqzHrrHSG07MUAxJ6AY29/+HYf6EY2
 WoeuLWDmXE7A3oJoIsRecD6BXHTb0OYS20lS608anr3B0xn5g0BX7es9Mw+hV/pL+63EOCVm
 SUVTEQwbGQN62guOKnJJJfphbbv82glIC/Ei4Ky8BwZkUuXd7d5NFJKC9/GDrbWdj75cDNQx
 UZ9XXbXEKY9MHX83Uy7JFoiFDMOVHn55HnncflUncO0zDzY7CxFeQFwYRbsCXOUL9yBtqLer
 Ky8/yjBskIlNrp0uQSt9LMoMsdSjYLYhvk1StsNPg74+s4u0Q6z45+l8RAsgLw5OLtTa+ePM
 JyS7OIGNYxAX6eZk1+91a6tnqfyPcMbduxyBaYXn94HUG162BeuyBkbNoIDkB7pCByed1A7q
 q9/FbuTDwgVGVLYthYSfTtN0Y60OgNkWCMtFwKxRaXt1WFA5ceqinN/XkgA+vf2Ch72zBkJL
 RBIhfOPFv5f2Hkkj0MvsUXpOWaOjatiu0fpPo6Hw14UEpywke1zN4NKubApQOlNKZZC4hu6/
 8pv2t4HRi7s0K88jQYBRPObjrN5+owtI51xMaYzvPitHQ2053LmgsOdN9EKOqZeHAYG2SmRW
 LOxYWKX14YkZI5j/TXfKlTpwSMvXho+efN4kgFvFmP6WT+tPnwARAQABtCJMYXVyZW50IFZp
 dmllciA8bGF1cmVudEB2aXZpZXIuZXU+iQI4BBMBAgAiBQJWBTDeAhsDBgsJCAcDAgYVCAIJ
 CgsEFgIDAQIeAQIXgAAKCRDzDDi9Py++PCEdD/oD8LD5UWxhQrMQCsUgLlXCSM7sxGLkwmmF
 ozqSSljEGRhffxZvO35wMFcdX9Z0QOabVoFTKrT04YmvbjsErh/dP5zeM/4EhUByeOS7s6Yl
 HubMXVQTkak9Wa9Eq6irYC6L41QNzz/oTwNEqL1weV1+XC3TNnht9B76lIaELyrJvRfgsp9M
 rE+PzGPo5h7QHWdL/Cmu8yOtPLa8Y6l/ywEJ040IoiAUfzRoaJs2csMXf0eU6gVBhCJ4bs91
 jtWTXhkzdl4tdV+NOwj3j0ukPy+RjqeL2Ej+bomnPTOW8nAZ32dapmu7Fj7VApuQO/BSIHyO
 NkowMMjB46yohEepJaJZkcgseaus0x960c4ua/SUm/Nm6vioRsxyUmWd2nG0m089pp8LPopq
 WfAk1l4GciiMepp1Cxn7cnn1kmG6fhzedXZ/8FzsKjvx/aVeZwoEmucA42uGJ3Vk9TiVdZes
 lqMITkHqDIpHjC79xzlWkXOsDbA2UY/P18AtgJEZQPXbcrRBtdSifCuXdDfHvI+3exIdTpvj
 BfbgZAar8x+lcsQBugvktlQWPfAXZu4Shobi3/mDYMEDOE92dnNRD2ChNXg2IuvAL4OW40wh
 gXlkHC1ZgToNGoYVvGcZFug1NI+vCeCFchX+L3bXyLMg3rAfWMFPAZLzn42plIDMsBs+x2yP
 +bkCDQRWBSYZARAAvFJBFuX9A6eayxUPFaEczlMbGXugs0mazbOYGlyaWsiyfyc3PStHLFPj
 rSTaeJpPCjBJErwpZUN4BbpkBpaJiMuVO6egrC8Xy8/cnJakHPR2JPEvmj7Gm/L9DphTcE15
 92rxXLesWzGBbuYxKsj8LEnrrvLyi3kNW6B5LY3Id+ZmU8YTQ2zLuGV5tLiWKKxc6s3eMXNq
 wrJTCzdVd6ThXrmUfAHbcFXOycUyf9vD+s+WKpcZzCXwKgm7x1LKsJx3UhuzT8ier1L363RW
 ZaJBZ9CTPiu8R5NCSn9V+BnrP3wlFbtLqXp6imGhazT9nJF86b5BVKpF8Vl3F0/Y+UZ4gUwL
 d9cmDKBcmQU/JaRUSWvvolNu1IewZZu3rFSVgcpdaj7F/1aC0t5vLdx9KQRyEAKvEOtCmP4m
 38kU/6r33t3JuTJnkigda4+Sfu5kYGsogeYG6dNyjX5wpK5GJIJikEhdkwcLM+BUOOTi+I9u
 tX03BGSZo7FW/J7S9y0l5a8nooDs2gBRGmUgYKqQJHCDQyYut+hmcr+BGpUn9/pp2FTWijrP
 inb/Pc96YDQLQA1q2AeAFv3Rx3XoBTGl0RCY4KZ02c0kX/dm3eKfMX40XMegzlXCrqtzUk+N
 8LeipEsnOoAQcEONAWWo1HcgUIgCjhJhBEF0AcELOQzitbJGG5UAEQEAAYkCHwQYAQIACQUC
 VgUmGQIbDAAKCRDzDDi9Py++PCD3D/9VCtydWDdOyMTJvEMRQGbx0GacqpydMEWbE3kUW0ha
 US5jz5gyJZHKR3wuf1En/3z+CEAEfP1M3xNGjZvpaKZXrgWaVWfXtGLoWAVTfE231NMQKGoB
 w2Dzx5ivIqxikXB6AanBSVpRpoaHWb06tPNxDL6SVV9lZpUn03DSR6gZEZvyPheNWkvz7bE6
 FcqszV/PNvwm0C5Ju7NlJA8PBAQjkIorGnvN/vonbVh5GsRbhYPOc/JVwNNr63P76rZL8Gk/
 hb3xtcIEi5CCzab45+URG/lzc6OV2nTj9Lg0SNcRhFZ2ILE3txrmI+aXmAu26+EkxLLfqCVT
 ohb2SffQha5KgGlOSBXustQSGH0yzzZVZb+HZPEvx6d/HjQ+t9sO1bCpEgPdZjyMuuMp9N1H
 ctbwGdQM2Qb5zgXO+8ZSzwC+6rHHIdtcB8PH2j+Nd88dVGYlWFKZ36ELeZxD7iJflsE8E8yg
 OpKgu3nD0ahBDqANU/ZmNNarBJEwvM2vfusmNnWm3QMIwxNuJghRyuFfx694Im1js0ZY3LEU
 JGSHFG4ZynA+ZFUPA6Xf0wHeJOxGKCGIyeKORsteIqgnkINW9fnKJw2pgk8qHkwVc3Vu+wGS
 ZiJK0xFusPQehjWTHn9WjMG1zvQ5TQQHxau/2FkP45+nRPco6vVFQe8JmgtRF8WFJA==
Subject: Re: [PATCH 5/9] linux-user: mips: Update syscall numbers to kernel
 5.5 level
Message-ID: <92f1a3ae-ed61-693f-f619-6a63c39e66a2@vivier.eu>
Date: Wed, 12 Feb 2020 22:09:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <1580818058-16159-6-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:qt0mT7IAByDsngalIpombBQyWDTS4VS3G5BYivdg56P/dyqWA3Y
 aEd7QyoBe3FT0cjDDM83Zw+HIlg42bLsuYD/Rb8iWE57KsBVnfnTqgw3M/U8ryXvucinZSp
 LeMxPIDyE6AyZ86gyXvEptQjdaw1tadIUrTMKR8QkDgnN151miGduF3CrYiqJELcGq3GrIU
 OtEwHkVTUQa/ln6bhIj8A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Yfc2YarhrAw=:x/3E1EQ4aEOu28b3jGPssV
 iePJxiNAjWgTGZ7EIywq0aLxH/ERq2JcskYpBVWZhKeohJdMoWgPUWTspiSGzlfiuHqm6R4dc
 4E1Wbbz3VvxRxayW+hsTFnefI1TIjDx++gHlxNuJsC/UaoqLNWsbv4e4lVQ94cNBU4elDWVBk
 yBhuzM94DD3zTQtCMTIuvIGkRAv2vacPA8Zq7ECqu5ByS17z86sskWEueAxqPQRrMUeYF1XGN
 avpuKl5qzNYlZy4NhywoQE/81VjS1zKq8AaHqZx7i8alsivEkipyV7ITeJHuiA3IX2Mm4Vvzj
 LtBATB26MMnkRP3iK1XX+OTt8rSJr/SW7LrBTZFPo8thzQb93PcGwXX0HXrOtK3nmkJd1HNgR
 yU+21EbYVYrj+BoJscxuM6xG/GJsJY4rePprG+IN6BSTetWFKT4ZrNCcomViXbcEaz0WQzzdt
 QwHu0h5qeHnLUaqqdZt1BuggshFjD6UNjEUC/52OSBXxdROENOheHznvOYoYm41g+1mduda3P
 BHPUab9Ym36HEoZH2wkY/wi/rGdXMdj3sY9L62h/z6uBua0BFPuv7UYC3+iHjHodzVWB8FG+N
 mkq55FzQ0OGZkcz5UmnXo001B6DqMK52hb/INgZrVCAHKvBKAtYe7JIsMbD4NyT4yrVtTEB22
 KTw+vm+x+PdBcs6wA6VwylptzNgr+Kw8LaDwG8qGksLoga4iaYUh4Hc8RgxgtK48j0tsZ++sJ
 G7vgKmmzMOuknVZKIl55oYG7tRL+V3P2vTItyayR882KDJfzqzZH7/7dw4r1hJmWw+xrw5F5X
 WDynon4+oE97afzyIwK09Wqat/AKXSZjYdwQ/rPxm0Hwc9V8tKlXo0TpIZdTX5o6ttVXxCy
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.10
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>, amarkovic@wavecomp.com,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 04/02/2020 à 13:07, Aleksandar Markovic a écrit :
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
> 
> Update mips syscall numbers based on Linux kernel tag v5.5.
> 
> CC: Aurelien Jarno <aurelien@aurel32.net>
> CC: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---
>  linux-user/mips/cpu_loop.c     | 78 +++++++++++++++++++++++++++++++++++++++++-
>  linux-user/mips/syscall_nr.h   | 45 ++++++++++++++++++++++++
>  linux-user/mips64/syscall_nr.h | 13 +++++++
>  3 files changed, 135 insertions(+), 1 deletion(-)
> 
> diff --git a/linux-user/mips/cpu_loop.c b/linux-user/mips/cpu_loop.c
> index 39915b3..b81479b 100644
> --- a/linux-user/mips/cpu_loop.c
> +++ b/linux-user/mips/cpu_loop.c
> @@ -25,8 +25,9 @@
>  #include "internal.h"
>  
>  # ifdef TARGET_ABI_MIPSO32
> +#  define MIPS_SYSCALL_NUMBER_UNUSED -1
>  #  define MIPS_SYS(name, args) args,
> -static const uint8_t mips_syscall_args[] = {
> +static const int8_t mips_syscall_args[] = {
>          MIPS_SYS(sys_syscall    , 8)    /* 4000 */
>          MIPS_SYS(sys_exit       , 1)
>          MIPS_SYS(sys_fork       , 0)
> @@ -390,6 +391,75 @@ static const uint8_t mips_syscall_args[] = {
>          MIPS_SYS(sys_copy_file_range, 6) /* 360 */
>          MIPS_SYS(sys_preadv2, 6)
>          MIPS_SYS(sys_pwritev2, 6)
> +        MIPS_SYS(sys_pkey_mprotect, 4)
> +        MIPS_SYS(sys_pkey_alloc, 2)
> +        MIPS_SYS(sys_pkey_free, 1)                 /* 365 */
> +        MIPS_SYS(sys_statx, 5)
> +        MIPS_SYS(sys_rseq, 4)
> +        MIPS_SYS(sys_io_pgetevents, 6)
> +        MIPS_SYSCALL_NUMBER_UNUSED,
> +        MIPS_SYSCALL_NUMBER_UNUSED,                /* 370 */
> +        MIPS_SYSCALL_NUMBER_UNUSED,
> +        MIPS_SYSCALL_NUMBER_UNUSED,
> +        MIPS_SYSCALL_NUMBER_UNUSED,
> +        MIPS_SYSCALL_NUMBER_UNUSED,
> +        MIPS_SYSCALL_NUMBER_UNUSED,                /* 375 */
> +        MIPS_SYSCALL_NUMBER_UNUSED,
> +        MIPS_SYSCALL_NUMBER_UNUSED,
> +        MIPS_SYSCALL_NUMBER_UNUSED,
> +        MIPS_SYSCALL_NUMBER_UNUSED,
> +        MIPS_SYSCALL_NUMBER_UNUSED,                /* 380 */
> +        MIPS_SYSCALL_NUMBER_UNUSED,
> +        MIPS_SYSCALL_NUMBER_UNUSED,
> +        MIPS_SYSCALL_NUMBER_UNUSED,
> +        MIPS_SYSCALL_NUMBER_UNUSED,
> +        MIPS_SYSCALL_NUMBER_UNUSED,                /* 385 */
> +        MIPS_SYSCALL_NUMBER_UNUSED,
> +        MIPS_SYSCALL_NUMBER_UNUSED,
> +        MIPS_SYSCALL_NUMBER_UNUSED,
> +        MIPS_SYSCALL_NUMBER_UNUSED,
> +        MIPS_SYSCALL_NUMBER_UNUSED,                /* 390 */
> +        MIPS_SYSCALL_NUMBER_UNUSED,
> +        MIPS_SYSCALL_NUMBER_UNUSED,
> +        MIPS_SYS(sys_semget, 3)
> +        MIPS_SYS(sys_semctl, 4)
> +        MIPS_SYS(sys_shmget, 3)                    /* 395 */
> +        MIPS_SYS(sys_shmctl, 3)
> +        MIPS_SYS(sys_shmat, 3)
> +        MIPS_SYS(sys_shmdt, 1)
> +        MIPS_SYS(sys_msgget, 2)
> +        MIPS_SYS(sys_msgsnd, 4)                    /* 400 */
> +        MIPS_SYS(sys_msgrcv, 5)
> +        MIPS_SYS(sys_msgctl, 3)
> +        MIPS_SYS(sys_timer_gettime64, 2)
> +        MIPS_SYS(sys_timer_settime64, 4)
> +        MIPS_SYS(sys_timerfd_gettime64, 2)         /* 410 */
> +        MIPS_SYS(sys_timerfd_settime64, 4)

These have different names in the kernel:

clock_gettime64                  403
clock_settime64                  404
clock_adjtime64                  405
clock_getres_time64              406
clock_nanosleep_time64           407

> +        MIPS_SYS(sys_utimensat_time64, 4)
> +        MIPS_SYS(sys_pselect6_time64, 6)
> +        MIPS_SYS(sys_ppoll_time64, 5)
> +        MIPS_SYSCALL_NUMBER_UNUSED,                /* 415 */
> +        MIPS_SYS(sys_io_pgetevents_time64, 6)
> +        MIPS_SYS(sys_recvmmsg_time64, 5)
> +        MIPS_SYS(sys_mq_timedsend_time64, 5)
> +        MIPS_SYS(sys_mq_timedreceive_time64, 5)
> +        MIPS_SYS(sys_semtimedop_time64, 4)         /* 420 */
> +        MIPS_SYS(sys_rt_sigtimedwait_time64, 4)
> +        MIPS_SYS(sys_futex_time64, 6)
> +        MIPS_SYS(sys_sched_rr_get_interval_time64, 2)
> +        MIPS_SYS(sys_pidfd_send_signal, 4)
> +        MIPS_SYS(sys_io_uring_setup, 2)            /* 425 */
> +        MIPS_SYS(sys_io_uring_enter, 6)
> +        MIPS_SYS(sys_io_uring_register, 4)
> +        MIPS_SYS(sys_open_tree, 3)
> +        MIPS_SYS(sys_move_mount, 5)
> +        MIPS_SYS(sys_fsopen, 2)                    /* 430 */
> +        MIPS_SYS(sys_fsconfig, 5)
> +        MIPS_SYS(sys_fsmount, 3)
> +        MIPS_SYS(sys_fspick, 3)
> +        MIPS_SYS(sys_pidfd_open, 2)
> +        MIPS_SYS(sys_clone3, 2)                    /* 435 */

This comes from arch/mips/kernel/syscalls/syscall_o32.tbl for the
syscall number.

Where do you find the number of the arguments in the kernel?

> +
>  };
>  #  undef MIPS_SYS
>  # endif /* O32 */
> @@ -447,8 +517,14 @@ void cpu_loop(CPUMIPSState *env)
>  # ifdef TARGET_ABI_MIPSO32
>              syscall_num = env->active_tc.gpr[2] - 4000;
>              if (syscall_num >= sizeof(mips_syscall_args)) {
> +                /* syscall_num is larger that any defined for MIPS O32 */
> +                ret = -TARGET_ENOSYS;
> +            } else if (mips_syscall_args[syscall_num] ==
> +                       MIPS_SYSCALL_NUMBER_UNUSED) {
> +                /* syscall_num belongs to the range not defined for MIPS O32 */
>                  ret = -TARGET_ENOSYS;
>              } else {
> +                /* syscall_num is valid */
>                  int nb_args;
>                  abi_ulong sp_reg;
>                  abi_ulong arg5 = 0, arg6 = 0, arg7 = 0, arg8 = 0;
> diff --git a/linux-user/mips/syscall_nr.h b/linux-user/mips/syscall_nr.h
> index 7fa7fa5..0be3af1 100644
> --- a/linux-user/mips/syscall_nr.h
> +++ b/linux-user/mips/syscall_nr.h
> @@ -376,5 +376,50 @@
>  #define TARGET_NR_statx                 (TARGET_NR_Linux + 366)
>  #define TARGET_NR_rseq                  (TARGET_NR_Linux + 367)
>  #define TARGET_NR_io_pgetevents         (TARGET_NR_Linux + 368)
> +/* room for arch specific calls */
> +#define TARGET_NR_semget                (TARGET_NR_Linux + 393)
> +#define TARGET_NR_semctl                (TARGET_NR_Linux + 394)
> +#define TARGET_NR_shmget                (TARGET_NR_Linux + 395)
> +#define TARGET_NR_shmctl                (TARGET_NR_Linux + 396)
> +#define TARGET_NR_shmat                 (TARGET_NR_Linux + 397)
> +#define TARGET_NR_shmdt                 (TARGET_NR_Linux + 398)
> +#define TARGET_NR_msgget                (TARGET_NR_Linux + 399)
> +#define TARGET_NR_msgsnd                (TARGET_NR_Linux + 400)
> +#define TARGET_NR_msgrcv                (TARGET_NR_Linux + 401)
> +#define TARGET_NR_msgctl                (TARGET_NR_Linux + 402)
> +/* 403-423 common for 32-bit archs */
> +#define TARGET_NR_clock_gettime64              (TARGET_NR_Linux + 403)
> +#define TARGET_NR_clock_settime64              (TARGET_NR_Linux + 404)
> +#define TARGET_NR_clock_adjtime64              (TARGET_NR_Linux + 405)
> +#define TARGET_NR_clock_getres_time64          (TARGET_NR_Linux + 406)
> +#define TARGET_NR_clock_nanosleep_time64       (TARGET_NR_Linux + 407)
> +#define TARGET_NR_timer_gettime64              (TARGET_NR_Linux + 408)
> +#define TARGET_NR_timer_settime64              (TARGET_NR_Linux + 409)
> +#define TARGET_NR_timerfd_gettime64            (TARGET_NR_Linux + 410)
> +#define TARGET_NR_timerfd_settime64            (TARGET_NR_Linux + 411)
> +#define TARGET_NR_utimensat_time64             (TARGET_NR_Linux + 412)
> +#define TARGET_NR_pselect6_time64              (TARGET_NR_Linux + 413)
> +#define TARGET_NR_ppoll_time64                 (TARGET_NR_Linux + 414)
> +#define TARGET_NR_io_pgetevents_time64         (TARGET_NR_Linux + 416)
> +#define TARGET_NR_recvmmsg_time64              (TARGET_NR_Linux + 417)
> +#define TARGET_NR_mq_timedsend_time64          (TARGET_NR_Linux + 418)
> +#define TARGET_NR_mq_timedreceive_time64       (TARGET_NR_Linux + 419)
> +#define TARGET_NR_semtimedop_time64            (TARGET_NR_Linux + 420)
> +#define TARGET_NR_rt_sigtimedwait_time64       (TARGET_NR_Linux + 421)
> +#define TARGET_NR_futex_time64                 (TARGET_NR_Linux + 422)
> +#define TARGET_NR_sched_rr_get_interval_time64 (TARGET_NR_Linux + 423)
> +/* 424 onwards common for all archs */
> +#define TARGET_NR_pidfd_send_signal            (TARGET_NR_Linux + 424)
> +#define TARGET_NR_io_uring_setup               (TARGET_NR_Linux + 425)
> +#define TARGET_NR_io_uring_enter               (TARGET_NR_Linux + 426)
> +#define TARGET_NR_io_uring_register            (TARGET_NR_Linux + 427)
> +#define TARGET_NR_open_tree                    (TARGET_NR_Linux + 428)
> +#define TARGET_NR_move_mount                   (TARGET_NR_Linux + 429)
> +#define TARGET_NR_fsopen                       (TARGET_NR_Linux + 430)
> +#define TARGET_NR_fsconfig                     (TARGET_NR_Linux + 431)
> +#define TARGET_NR_fsmount                      (TARGET_NR_Linux + 432)
> +#define TARGET_NR_fspick                       (TARGET_NR_Linux + 433)
> +#define TARGET_NR_pidfd_open                   (TARGET_NR_Linux + 434)
> +#define TARGET_NR_clone3                       (TARGET_NR_Linux + 435)

These values come from linux/arch/mips/kernel/syscalls/syscall_o32.tbl

>  #endif
> diff --git a/linux-user/mips64/syscall_nr.h b/linux-user/mips64/syscall_nr.h
> index db40f69..c86943a 100644
> --- a/linux-user/mips64/syscall_nr.h
> +++ b/linux-user/mips64/syscall_nr.h
> @@ -674,6 +674,19 @@
>  #define TARGET_NR_statx                 (TARGET_NR_Linux + 326)
>  #define TARGET_NR_rseq                  (TARGET_NR_Linux + 327)
>  #define TARGET_NR_io_pgetevents         (TARGET_NR_Linux + 328)
> +/* 329 through 423 are reserved to sync up with other architectures */
> +#define TARGET_NR_pidfd_send_signal     (TARGET_NR_Linux + 424)
> +#define TARGET_NR_io_uring_setup        (TARGET_NR_Linux + 425)
> +#define TARGET_NR_io_uring_enter        (TARGET_NR_Linux + 426)
> +#define TARGET_NR_io_uring_register     (TARGET_NR_Linux + 427)
> +#define TARGET_NR_open_tree             (TARGET_NR_Linux + 428)
> +#define TARGET_NR_move_mount            (TARGET_NR_Linux + 429)
> +#define TARGET_NR_fsopen                (TARGET_NR_Linux + 430)
> +#define TARGET_NR_fsconfig              (TARGET_NR_Linux + 431)
> +#define TARGET_NR_fsmount               (TARGET_NR_Linux + 432)
> +#define TARGET_NR_fspick                (TARGET_NR_Linux + 433)
> +#define TARGET_NR_pidfd_open            (TARGET_NR_Linux + 434)
> +#define TARGET_NR_clone3                (TARGET_NR_Linux + 435)
>  #endif

These values come from linux/arch/mips/kernel/syscalls/syscall_n64.tbl

So why don't you update the value for
arch/mips/kernel/syscalls/syscall_n32.tbl (also in mips64/syscall_nr.h,
enclosed in TARGET_ABI32)?

clock_gettime64                  403
clock_settime64                  404
clock_adjtime64                  405
clock_getres_time64              406
clock_nanosleep_time64           407
timer_gettime64                  408
timer_settime64                  409
timerfd_gettime64                410
timerfd_settime64                411
utimensat_time64                 412
pselect6_time64                  413
ppoll_time64                     414
io_pgetevents_time64             416
recvmmsg_time64                  417
mq_timedsend_time64              418
mq_timedreceive_time64           419
semtimedop_time64                420
rt_sigtimedwait_time64           421
futex_time64                     422
sched_rr_get_interval_time64     423
pidfd_send_signal                424
io_uring_setup                   425
io_uring_enter                   426
io_uring_register                427
open_tree                        428
move_mount                       429
fsopen                           430
fsconfig                         431
fsmount                          432
fspick                           433
pidfd_open                       434
clone3                           435

Thanks,
Laurent

