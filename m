Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8A57C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 14:47:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E69A20717
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 14:47:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E69A20717
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxtYh-0006n5-SC
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 10:47:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42482)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jxtY5-0006Mm-4z
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 10:47:17 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:48265)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jxtY3-0007ii-0a
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 10:47:16 -0400
Received: from [192.168.100.1] ([82.252.135.186]) by mrelayeu.kundenserver.de
 (mreue107 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1M1qfu-1k05P53XVQ-002Gj4; Tue, 21 Jul 2020 16:47:12 +0200
To: Filip Bozuta <Filip.Bozuta@syrmia.com>, qemu-devel@nongnu.org
References: <20200713095058.106624-1-Filip.Bozuta@syrmia.com>
 <20200713095058.106624-5-Filip.Bozuta@syrmia.com>
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
Subject: Re: [PATCH v2 4/4] linux-user: Add strace support for printing
 arguments of some clock and time functions
Message-ID: <021890a4-1a82-f709-1815-06e854042e75@vivier.eu>
Date: Tue, 21 Jul 2020 16:47:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200713095058.106624-5-Filip.Bozuta@syrmia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:TGot7vFvuhHzePZQlE+rmj9xt/Yt2ivlclHIdfqimUimE69PjjW
 IIZ5g5ussnwbGKIIA9qNyDWt63r9jZwY4WGPeBdY8NWK/KYO/iGnZdnCErM1zPgu6XeG/0q
 aeyp/NlTfL6Kr4i7kHOeThpBDE9HuuPD6tZ+8cTcQIRx3Gp/8YIAd2pl6c778fUTGEoy14+
 dLEbeCxiIrNmd9dutDyog==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4r6gcfyPOLw=:xSdxbSdiYTzI6NCqZ2C6Il
 S0Xvr8FlgtmMVlPwVITGpx07FpcLYhnyeUaFXKgF63waEqR0x5mr4M2/bClpKEBzjAub0g2gX
 IBFxdeYo80WCqk9rfJp8TV4lNkkYx/1CHcguj6r/ixVJ8Q4JhOZ+/FqrsY9ljBj/BVe1bb3Fi
 cI4tV4c9i0AO0NMXBg3wotOmKa2dQbHx0pxLKOxt8BAjM0xgTqucUxTOBSuNrnI+KHYxcW8If
 zvlbMhJKbZ2yYMNqFCQ62VKj5rn6RXm3jIms8Xr5CbUh9Jyk+89aWCAvmadIB+UOiA7OpBE/E
 IyNWjy7lCcAHc9fgPLush9F7PFLxWFDA3sa9IPJWm5UubMIq1phKr2Vj2nu+wGGSP5qqR1Zm9
 cwfUp/TtAj2x/SvXLYTr/9x8GRwgy7GH39/MIPcJGupwRfOzMqNegCDCZA6gTQVjgmJjuW1y7
 S/t6R8eiiJZRt5XoXt5Kd1ZipAV+vgmtx/0Ys2iSauO6zxfJVEEBXFKm532RlUHM64IGzt9az
 VZmOA+R9eG1Y+1dFjvYNdsHgTOmBxkjIpU0DskgL52EzX3uAY6Gj2AerLWxTH5RnpBiZpbmCi
 85qdMNJBEWiMvObBU99RL+0UH5WSJci6yQrdkVXZSd/By2Pc++nwD+AVjdSRtkMoqMN4shQay
 LtVtzrGFROCZmv1BeUSJ0jcH/2gosYTKv9oxcG6rWyRIQKVxBNz0aRAu8G9CiP+wizsmt7CZP
 RmTPM8Q4wEE20DxPTajr/+mSvDaM3RAGSTR9etdc2fq/mVUqt584rUfIIZ7WQdp9sSkI80Gp7
 Q2nyl5Dtdaq4sfOs+tq3+rjy6We1iWagg2KjDwCVAXt2l+Z0aGrn4XfzHMIvERBefWbhxQd
Received-SPF: none client-ip=217.72.192.75; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 10:22:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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

Le 13/07/2020 à 11:50, Filip Bozuta a écrit :
> This patch implements strace argument printing functionality for following syscalls:
> 
>     * clock_getres, clock_gettime, clock_settime - clock and time functions
> 
>         int clock_getres(clockid_t clockid, struct timespec *res)
>         int clock_gettime(clockid_t clockid, struct timespec *tp)
>         int clock_settime(clockid_t clockid, const struct timespec *tp)
>         man page: https://man7.org/linux/man-pages/man2/clock_getres.2.html
> 
>     * gettimeofday - get time
> 
>         int gettimeofday(struct timeval *tv, struct timezone *tz)
>         man page: https://man7.org/linux/man-pages/man2/gettimeofday.2.html
> 
>     * getitimer, setitimer - get or set value of an interval timer
> 
>         int getitimer(int which, struct itimerval *curr_value)
>         int setitimer(int which, const struct itimerval *new_value,
>                       struct itimerval *old_value)
>         man page: https://man7.org/linux/man-pages/man2/getitimer.2.html
> 
> Implementation notes:
> 
>     All of the syscalls have some structue types as argument types and thus
>     a separate printing function was stated in file "strace.list" for each
>     of them. All of these functions use existing functions for their
>     appropriate structure types ("print_timeval()" and "print_timezone()").
>     Functions "print_timespec()" and "print_itimerval()" were added in this
>     patch so that they can be used to print types "struct timespec" and
>     "struct itimerval" used by some of the syscalls. Function "print_itimerval()"
>     uses the existing function "print_timeval()" to print fields of the
>     structure "struct itimerval" that are of type "struct timeval".
>     Function "print_itimer_type()" was added to print the type of the interval
>     typer which is the firt argument of "getitimer()" and "setitimer()".
>     Also, the existing function "print_timeval()" was changed a little so
>     that it prints the field names beside the values. Syscalls "clock_getres()"
>     and "clocK_gettime()" have the same number and types of arguments and
>     thus their print functions "print_clock_getres" and "print_clock_gettime"
>     shate a common definition in file "strace.c".
> 
> Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
> ---
>  linux-user/strace.c    | 208 ++++++++++++++++++++++++++++++++++++++++-
>  linux-user/strace.list |  17 ++--
>  2 files changed, 217 insertions(+), 8 deletions(-)
> 
> diff --git a/linux-user/strace.c b/linux-user/strace.c
> index 0d95cc6089..9bdee3b495 100644
> --- a/linux-user/strace.c
> +++ b/linux-user/strace.c
> @@ -64,7 +64,10 @@ UNUSED static void print_string(abi_long, int);
>  UNUSED static void print_buf(abi_long addr, abi_long len, int last);
>  UNUSED static void print_raw_param(const char *, abi_long, int);
>  UNUSED static void print_timeval(abi_ulong, int);
> +UNUSED static void print_timespec(abi_ulong, int);
>  UNUSED static void print_timezone(abi_ulong, int);
> +UNUSED static void print_itimer_type(abi_ulong, int);
> +UNUSED static void print_itimerval(abi_ulong, int);
>  UNUSED static void print_number(abi_long, int);
>  UNUSED static void print_signal(abi_ulong, int);
>  UNUSED static void print_sockaddr(abi_ulong, abi_long, int);
> @@ -829,6 +832,89 @@ print_syscall_ret_adjtimex(void *cpu_env, const struct syscallname *name,
>  }
>  #endif
>  
> +#if defined(TARGET_NR_clock_gettime) || defined(TARGET_NR_clock_getres)
> +static void
> +print_syscall_ret_clock_gettime(void *cpu_env, const struct syscallname *name,
> +                                abi_long ret, abi_long arg0, abi_long arg1,
> +                                abi_long arg2, abi_long arg3, abi_long arg4,
> +                                abi_long arg5)
> +{
> +    print_syscall_err(ret);
> +
> +    if (ret >= 0) {

The series needs to be rebased to use:

    if (!print_syscall_err(ret)) {

> +        qemu_log(TARGET_ABI_FMT_ld, ret);
> +        qemu_log(" (");
> +        print_timespec(arg1, 1);
> +        qemu_log(")");
> +    }
> +
> +    qemu_log("\n");
> +}
> +#define print_syscall_ret_clock_getres     print_syscall_ret_clock_gettime
> +#endif
> +
> +#ifdef TARGET_NR_gettimeofday
> +static void
> +print_syscall_ret_gettimeofday(void *cpu_env, const struct syscallname *name,
> +                               abi_long ret, abi_long arg0, abi_long arg1,
> +                               abi_long arg2, abi_long arg3, abi_long arg4,
> +                               abi_long arg5)
> +{
> +    print_syscall_err(ret);
> +
> +    if (ret >= 0) {

    if (!print_syscall_err(ret)) {

> +        qemu_log(TARGET_ABI_FMT_ld, ret);
> +        qemu_log(" (");
> +        print_timeval(arg0, 0);
> +        print_timezone(arg1, 1);
> +        qemu_log(")");
> +    }
> +
> +    qemu_log("\n");
> +}
> +#endif
> +
> +#ifdef TARGET_NR_getitimer
> +static void
> +print_syscall_ret_getitimer(void *cpu_env, const struct syscallname *name,
> +                            abi_long ret, abi_long arg0, abi_long arg1,
> +                            abi_long arg2, abi_long arg3, abi_long arg4,
> +                            abi_long arg5)
> +{
> +    print_syscall_err(ret);
> +
> +    if (ret >= 0) {

    if (!print_syscall_err(ret)) {

> +        qemu_log(TARGET_ABI_FMT_ld, ret);
> +        qemu_log(" (");
> +        print_itimerval(arg1, 1);
> +        qemu_log(")");
> +    }
> +
> +    qemu_log("\n");
> +}
> +#endif
> +
> +
> +#ifdef TARGET_NR_getitimer
> +static void
> +print_syscall_ret_setitimer(void *cpu_env, const struct syscallname *name,
> +                            abi_long ret, abi_long arg0, abi_long arg1,
> +                            abi_long arg2, abi_long arg3, abi_long arg4,
> +                            abi_long arg5)
> +{
> +    print_syscall_err(ret);
> +
> +    if (ret >= 0) {

    if (!print_syscall_err(ret)) {

> +        qemu_log(TARGET_ABI_FMT_ld, ret);
> +        qemu_log(" (old_value = ");
> +        print_itimerval(arg2, 1);
> +        qemu_log(")");
> +    }
> +
> +    qemu_log("\n");
> +}
> +#endif
> +
...

All the other changes seem ok.

Thanks,
Laurent


