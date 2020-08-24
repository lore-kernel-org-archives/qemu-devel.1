Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10CCEC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 17:02:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6C75205CB
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 17:02:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6C75205CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51814 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAFrR-00079e-Vq
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 13:02:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35834)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kAFqm-0006ir-LB
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 13:01:40 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:40177)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kAFqj-0003H8-UQ
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 13:01:40 -0400
Received: from [192.168.100.1] ([82.252.135.186]) by mrelayeu.kundenserver.de
 (mreue012 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MiuGK-1konnj1vVs-00exTK; Mon, 24 Aug 2020 19:01:31 +0200
Subject: Re: [PATCH v4 5/5] linux-user: Add strace support for printing
 arguments of some clock and time functions
To: Filip Bozuta <Filip.Bozuta@syrmia.com>, qemu-devel@nongnu.org
References: <20200811164553.27713-1-Filip.Bozuta@syrmia.com>
 <20200811164553.27713-6-Filip.Bozuta@syrmia.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <167cbd1f-1b1b-2d43-fc3c-2f22a5820895@vivier.eu>
Date: Mon, 24 Aug 2020 19:01:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200811164553.27713-6-Filip.Bozuta@syrmia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:6Sc6LfzAOArg70PuTJL8iiTfk5ldfevqJdneQKcCsHBFZEf+wj0
 VKH0uTKIN/wB5AKy8sVUuAGZsfT85gF2ktKS/AUW8BqtB4fhc4DfCv4EGbnJTtOIf9Vh983
 XgIRH9glJUb9ZM0t/dySIn8zu9xG0kuwmjIJln7Sas9iw5PcrvczigXUeBJU6yEeCE6OjBI
 xh3WPHZlJAEA3Eh7jOYNw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:T1FK4ZXhnDk=:H0aeNdiFzO8MRV4yV6DfgP
 +U4/20y7G4PtMGP3gN9aIwyczHH3QG/N7AStbev5fKnt9UZEzG617MTtAWJxySPJq50/rTEv+
 u3F1eabCXleH8hlXvbSdjucwZFaSBdC9gbijnxMyeeT3qHjYPf1A2R5F3VbQQ3qydNtNoxPRW
 WymDYhwXpAB/UIxY16kLMt5LhXisE+GZccckr7ki1HvUDy49Fub+fv6C25vIaqwOS+3nZC7XV
 eAxZP0VhBEea5JxoG9Vjc5ggHBwQKFmWwGrAuTq9NrQrnXuwRevDlclEUSDmzyFgNHg898uDu
 s8PDSenmXlP6g/UtnqiiYETBmpeurFKoFeITxbmMbqNhrREo83xbyTSxy0jQGKpxYTMqXTb5Y
 aJvXsLQeWBLud7zLJXr5JycS0rAKmhEmqGdsSZLskKF4nbFfmdspvYd1ks1IL4uqcAAKZBxn1
 uRAU69RQOVhPWjG8HLasAVt0B5QgLa7N7YObr7G73MLNEZc+EZ//zMo6UEtXuIXLZEDeqUDSl
 g7DJjEiITWAAAJxlT6kbZyvIwTEFpU98HxobzDu1yLKhftNfz0WS41Nlmrcz8EbS81EiUMxkX
 UoQwj7XeanXIldpoRD0Rcx0vLc595z/1ztzq76E54SCsIdXHvYuC1r89ez5uZss0FLvpuz1rN
 594RCq6xGjXGZpfwqOvlAE1PDbll2YKle3O9E4Jc7grVFND8VO4y/4XI6/K4dXOv2wNDNAzc8
 g/ZRyALqAvJaA0b+OJ1fKq2oW6E/zSxWio52r7HY80K5trl9T5uGMzzK19/IwceY+PloSILSw
 nu1pszVIEz/MoJFFkvGVeG5Dkty4+y5Ig4xDgWj1TnCC0LmsYQgKnul1fUDsZgjIgumovXw
Received-SPF: none client-ip=212.227.126.134; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/24 13:01:36
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
> 
>     Functions "print_timespec()" and "print_itimerval()" were added in this
>     patch so that they can be used to print types "struct timespec" and
>     "struct itimerval" used by some of the syscalls. Function "print_itimerval()"
>     uses the existing function "print_timeval()" to print fields of the
>     structure "struct itimerval" that are of type "struct timeval".
> 
>     Function "print_enums()", which was introduced in the previous patch, is used
>     to print the interval timer type which is the first argument of "getitimer()"
>     and "setitimer()". Also, this function is used to print the clock id which
>     is the first argument of "clock_getres()" and "clock_gettime()". For that
>     reason, the existing function "print_clockid()" was removed in this patch.
>     Existing function "print_clock_adjtime()" was also changed for this reason
>     to use "print_enums()".
> 
>     The existing function "print_timeval()" was changed a little so that it
>     prints the field names beside the values.
> 
>     Syscalls "clock_getres()" and "clock_gettime()" have the same number
>     and types of arguments and thus their print functions "print_clock_getres"
>     and "print_clock_gettime" share a common definition in file "strace.c".
> 
> Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
> ---
>  linux-user/strace.c    | 287 +++++++++++++++++++++++++++++++----------
>  linux-user/strace.list |  17 ++-
>  2 files changed, 232 insertions(+), 72 deletions(-)
> 
> diff --git a/linux-user/strace.c b/linux-user/strace.c
> index def92c4d73..1a5c4c820a 100644
> --- a/linux-user/strace.c
> +++ b/linux-user/strace.c
> @@ -78,7 +78,9 @@ UNUSED static void print_string(abi_long, int);
>  UNUSED static void print_buf(abi_long addr, abi_long len, int last);
>  UNUSED static void print_raw_param(const char *, abi_long, int);
>  UNUSED static void print_timeval(abi_ulong, int);
> +UNUSED static void print_timespec(abi_ulong, int);
>  UNUSED static void print_timezone(abi_ulong, int);
> +UNUSED static void print_itimerval(abi_ulong, int);
>  UNUSED static void print_number(abi_long, int);
>  UNUSED static void print_signal(abi_ulong, int);
>  UNUSED static void print_sockaddr(abi_ulong, abi_long, int);
> @@ -578,69 +580,6 @@ print_fdset(int n, abi_ulong target_fds_addr)
>  }
>  #endif
>  
> -#ifdef TARGET_NR_clock_adjtime
> -/* IDs of the various system clocks */
> -#define TARGET_CLOCK_REALTIME              0
> -#define TARGET_CLOCK_MONOTONIC             1
> -#define TARGET_CLOCK_PROCESS_CPUTIME_ID    2
> -#define TARGET_CLOCK_THREAD_CPUTIME_ID     3
> -#define TARGET_CLOCK_MONOTONIC_RAW         4
> -#define TARGET_CLOCK_REALTIME_COARSE       5
> -#define TARGET_CLOCK_MONOTONIC_COARSE      6
> -#define TARGET_CLOCK_BOOTTIME              7
> -#define TARGET_CLOCK_REALTIME_ALARM        8
> -#define TARGET_CLOCK_BOOTTIME_ALARM        9
> -#define TARGET_CLOCK_SGI_CYCLE             10
> -#define TARGET_CLOCK_TAI                   11
> -
> -static void
> -print_clockid(int clockid, int last)
> -{
> -    switch (clockid) {
> -    case TARGET_CLOCK_REALTIME:
> -        qemu_log("CLOCK_REALTIME");
> -        break;
> -    case TARGET_CLOCK_MONOTONIC:
> -        qemu_log("CLOCK_MONOTONIC");
> -        break;
> -    case TARGET_CLOCK_PROCESS_CPUTIME_ID:
> -        qemu_log("CLOCK_PROCESS_CPUTIME_ID");
> -        break;
> -    case TARGET_CLOCK_THREAD_CPUTIME_ID:
> -        qemu_log("CLOCK_THREAD_CPUTIME_ID");
> -        break;
> -    case TARGET_CLOCK_MONOTONIC_RAW:
> -        qemu_log("CLOCK_MONOTONIC_RAW");
> -        break;
> -    case TARGET_CLOCK_REALTIME_COARSE:
> -        qemu_log("CLOCK_REALTIME_COARSE");
> -        break;
> -    case TARGET_CLOCK_MONOTONIC_COARSE:
> -        qemu_log("CLOCK_MONOTONIC_COARSE");
> -        break;
> -    case TARGET_CLOCK_BOOTTIME:
> -        qemu_log("CLOCK_BOOTTIME");
> -        break;
> -    case TARGET_CLOCK_REALTIME_ALARM:
> -        qemu_log("CLOCK_REALTIME_ALARM");
> -        break;
> -    case TARGET_CLOCK_BOOTTIME_ALARM:
> -        qemu_log("CLOCK_BOOTTIME_ALARM");
> -        break;
> -    case TARGET_CLOCK_SGI_CYCLE:
> -        qemu_log("CLOCK_SGI_CYCLE");
> -        break;
> -    case TARGET_CLOCK_TAI:
> -        qemu_log("CLOCK_TAI");
> -        break;
> -    default:
> -        qemu_log("%d", clockid);
> -        break;
> -    }
> -    qemu_log("%s", get_comma(last));
> -}
> -#endif
> -
>  /*
>   * Sysycall specific output functions
>   */
> @@ -839,6 +778,81 @@ print_syscall_ret_adjtimex(void *cpu_env, const struct syscallname *name,
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
> +    if (!print_syscall_err(ret)) {
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
> +    if (!print_syscall_err(ret)) {
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
> +    if (!print_syscall_err(ret)) {
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
> +    if (!print_syscall_err(ret)) {
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
>  #if defined(TARGET_NR_listxattr) || defined(TARGET_NR_llistxattr) \
>   || defined(TARGGET_NR_flistxattr)
>  static void
> @@ -1217,6 +1231,43 @@ UNUSED static struct flags mlockall_flags[] = {
>      FLAG_END,
>  };
>  
> +/* IDs of the various system clocks */
> +#define TARGET_CLOCK_REALTIME              0
> +#define TARGET_CLOCK_MONOTONIC             1
> +#define TARGET_CLOCK_PROCESS_CPUTIME_ID    2
> +#define TARGET_CLOCK_THREAD_CPUTIME_ID     3
> +#define TARGET_CLOCK_MONOTONIC_RAW         4
> +#define TARGET_CLOCK_REALTIME_COARSE       5
> +#define TARGET_CLOCK_MONOTONIC_COARSE      6
> +#define TARGET_CLOCK_BOOTTIME              7
> +#define TARGET_CLOCK_REALTIME_ALARM        8
> +#define TARGET_CLOCK_BOOTTIME_ALARM        9
> +#define TARGET_CLOCK_SGI_CYCLE             10
> +#define TARGET_CLOCK_TAI                   11
> +
> +UNUSED static struct enums clockids[] = {
> +    ENUM_TARGET(CLOCK_REALTIME),
> +    ENUM_TARGET(CLOCK_MONOTONIC),
> +    ENUM_TARGET(CLOCK_PROCESS_CPUTIME_ID),
> +    ENUM_TARGET(CLOCK_THREAD_CPUTIME_ID),
> +    ENUM_TARGET(CLOCK_MONOTONIC_RAW),
> +    ENUM_TARGET(CLOCK_REALTIME_COARSE),
> +    ENUM_TARGET(CLOCK_MONOTONIC_COARSE),
> +    ENUM_TARGET(CLOCK_BOOTTIME),
> +    ENUM_TARGET(CLOCK_REALTIME_ALARM),
> +    ENUM_TARGET(CLOCK_BOOTTIME_ALARM),
> +    ENUM_TARGET(CLOCK_SGI_CYCLE),
> +    ENUM_TARGET(CLOCK_TAI),
> +    ENUM_END,
> +};
> +
> +UNUSED static struct enums itimer_types[] = {
> +    ENUM_GENERIC(ITIMER_REAL),
> +    ENUM_GENERIC(ITIMER_VIRTUAL),
> +    ENUM_GENERIC(ITIMER_PROF),
> +    ENUM_END,
> +};
> +
>  /*
>   * print_xxx utility functions.  These are used to print syscall
>   * parameters in certain format.  All of these have parameter
> @@ -1435,13 +1486,34 @@ print_timeval(abi_ulong tv_addr, int last)
>              print_pointer(tv_addr, last);
>              return;
>          }
> -        qemu_log("{" TARGET_ABI_FMT_ld "," TARGET_ABI_FMT_ld "}%s",
> -            tswapal(tv->tv_sec), tswapal(tv->tv_usec), get_comma(last));
> +        qemu_log("{tv_sec = " TARGET_ABI_FMT_ld
> +                 ",tv_usec = " TARGET_ABI_FMT_ld "}%s",
> +                 tswapal(tv->tv_sec), tswapal(tv->tv_usec), get_comma(last));
>          unlock_user(tv, tv_addr, 0);
>      } else
>          qemu_log("NULL%s", get_comma(last));
>  }
>  
> +static void
> +print_timespec(abi_ulong ts_addr, int last)
> +{
> +    if (ts_addr) {
> +        struct target_timespec *ts;
> +
> +        ts = lock_user(VERIFY_READ, ts_addr, sizeof(*ts), 1);
> +        if (!ts) {
> +            print_pointer(ts_addr, last);
> +            return;
> +        }
> +        qemu_log("{tv_sec = " TARGET_ABI_FMT_ld
> +                 ",tv_nsec = " TARGET_ABI_FMT_ld "}%s",
> +                 tswapal(ts->tv_sec), tswapal(ts->tv_nsec), get_comma(last));
> +        unlock_user(ts, ts_addr, 0);
> +    } else {
> +        qemu_log("NULL%s", get_comma(last));
> +    }
> +}
> +
>  static void
>  print_timezone(abi_ulong tz_addr, int last)
>  {
> @@ -1461,6 +1533,22 @@ print_timezone(abi_ulong tz_addr, int last)
>      }
>  }
>  
> +static void
> +print_itimerval(abi_ulong it_addr, int last)
> +{
> +    if (it_addr) {
> +        qemu_log("{it_interval=");
> +        print_timeval(it_addr +
> +                      offsetof(struct target_itimerval, it_interval), 0);
> +        qemu_log("it_value=");
> +        print_timeval(it_addr +
> +                      offsetof(struct target_itimerval, it_value), 0);
> +        qemu_log("}%s", get_comma(last));
> +    } else {
> +        qemu_log("NULL%s", get_comma(last));
> +    }
> +}
> +
>  #undef UNUSED
>  
>  #ifdef TARGET_NR_accept
> @@ -1573,7 +1661,7 @@ print_clock_adjtime(void *cpu_env, const struct syscallname *name,
>                      abi_long arg3, abi_long arg4, abi_long arg5)
>  {
>      print_syscall_prologue(name);
> -    print_clockid(arg0, 0);
> +    print_enums(clockids, arg0, 0);
>      print_pointer(arg1, 1);
>      print_syscall_epilogue(name);
>  }
> @@ -1903,6 +1991,19 @@ print_futimesat(void *cpu_env, const struct syscallname *name,
>  }
>  #endif
>  
> +#ifdef TARGET_NR_gettimeofday
> +static void
> +print_gettimeofday(void *cpu_env, const struct syscallname *name,
> +                   abi_long arg0, abi_long arg1, abi_long arg2,
> +                   abi_long arg3, abi_long arg4, abi_long arg5)
> +{
> +    print_syscall_prologue(name);
> +    print_pointer(arg0, 0);
> +    print_pointer(arg1, 1);
> +    print_syscall_epilogue(name);
> +}
> +#endif
> +
>  #ifdef TARGET_NR_settimeofday
>  static void
>  print_settimeofday(void *cpu_env, const struct syscallname *name,
> @@ -1916,6 +2017,60 @@ print_settimeofday(void *cpu_env, const struct syscallname *name,
>  }
>  #endif
>  
> +#if defined(TARGET_NR_clock_gettime) || defined(TARGET_NR_clock_getres)
> +static void
> +print_clock_gettime(void *cpu_env, const struct syscallname *name,
> +                    abi_long arg0, abi_long arg1, abi_long arg2,
> +                    abi_long arg3, abi_long arg4, abi_long arg5)
> +{
> +    print_syscall_prologue(name);
> +    print_enums(clockids, arg0, 0);
> +    print_pointer(arg1, 1);
> +    print_syscall_epilogue(name);
> +}
> +#define print_clock_getres     print_clock_gettime
> +#endif
> +
> +#ifdef TARGET_NR_clock_settime
> +static void
> +print_clock_settime(void *cpu_env, const struct syscallname *name,
> +                    abi_long arg0, abi_long arg1, abi_long arg2,
> +                    abi_long arg3, abi_long arg4, abi_long arg5)
> +{
> +    print_syscall_prologue(name);
> +    print_enums(clockids, arg0, 0);
> +    print_timespec(arg1, 1);
> +    print_syscall_epilogue(name);
> +}
> +#endif
> +
> +#ifdef TARGET_NR_getitimer
> +static void
> +print_getitimer(void *cpu_env, const struct syscallname *name,
> +                abi_long arg0, abi_long arg1, abi_long arg2,
> +                abi_long arg3, abi_long arg4, abi_long arg5)
> +{
> +    print_syscall_prologue(name);
> +    print_enums(itimer_types, arg0, 0);
> +    print_pointer(arg1, 1);
> +    print_syscall_epilogue(name);
> +}
> +#endif
> +
> +#ifdef TARGET_NR_setitimer
> +static void
> +print_setitimer(void *cpu_env, const struct syscallname *name,
> +                abi_long arg0, abi_long arg1, abi_long arg2,
> +                abi_long arg3, abi_long arg4, abi_long arg5)
> +{
> +    print_syscall_prologue(name);
> +    print_enums(itimer_types, arg0, 0);
> +    print_itimerval(arg1, 0);
> +    print_pointer(arg2, 1);
> +    print_syscall_epilogue(name);
> +}
> +#endif
> +
>  #ifdef TARGET_NR_link
>  static void
>  print_link(void *cpu_env, const struct syscallname *name,
> diff --git a/linux-user/strace.list b/linux-user/strace.list
> index d0ea7f3464..084048ab96 100644
> --- a/linux-user/strace.list
> +++ b/linux-user/strace.list
> @@ -83,16 +83,18 @@
>  { TARGET_NR_clock_adjtime, "clock_adjtime" , NULL, print_clock_adjtime, NULL },
>  #endif
>  #ifdef TARGET_NR_clock_getres
> -{ TARGET_NR_clock_getres, "clock_getres" , NULL, NULL, NULL },
> +{ TARGET_NR_clock_getres, "clock_getres" , NULL, print_clock_getres,
> +                          print_syscall_ret_clock_getres },
>  #endif
>  #ifdef TARGET_NR_clock_gettime
> -{ TARGET_NR_clock_gettime, "clock_gettime" , NULL, NULL, NULL },
> +{ TARGET_NR_clock_gettime, "clock_gettime" , NULL, print_clock_gettime,
> +                           print_syscall_ret_clock_gettime },
>  #endif
>  #ifdef TARGET_NR_clock_nanosleep
>  { TARGET_NR_clock_nanosleep, "clock_nanosleep" , NULL, NULL, NULL },
>  #endif
>  #ifdef TARGET_NR_clock_settime
> -{ TARGET_NR_clock_settime, "clock_settime" , NULL, NULL, NULL },
> +{ TARGET_NR_clock_settime, "clock_settime" , NULL, print_clock_settime, NULL },
>  #endif
>  #ifdef TARGET_NR_clone
>  { TARGET_NR_clone, "clone" , NULL, print_clone, NULL },
> @@ -315,7 +317,8 @@
>  { TARGET_NR_gethostname, "gethostname" , NULL, NULL, NULL },
>  #endif
>  #ifdef TARGET_NR_getitimer
> -{ TARGET_NR_getitimer, "getitimer" , NULL, NULL, NULL },
> +{ TARGET_NR_getitimer, "getitimer" , NULL, print_getitimer,
> +                       print_syscall_ret_getitimer },
>  #endif
>  #ifdef TARGET_NR_get_kernel_syms
>  { TARGET_NR_get_kernel_syms, "get_kernel_syms" , NULL, NULL, NULL },
> @@ -388,7 +391,8 @@
>  { TARGET_NR_gettid, "gettid" , "%s()", NULL, NULL },
>  #endif
>  #ifdef TARGET_NR_gettimeofday
> -{ TARGET_NR_gettimeofday, "gettimeofday" , NULL, NULL, NULL },
> +{ TARGET_NR_gettimeofday, "gettimeofday" , NULL, print_gettimeofday,
> +                          print_syscall_ret_gettimeofday },
>  #endif
>  #ifdef TARGET_NR_getuid
>  { TARGET_NR_getuid, "getuid" , "%s()", NULL, NULL },
> @@ -1291,7 +1295,8 @@
>  { TARGET_NR_sethostname, "sethostname" , NULL, NULL, NULL },
>  #endif
>  #ifdef TARGET_NR_setitimer
> -{ TARGET_NR_setitimer, "setitimer" , NULL, NULL, NULL },
> +{ TARGET_NR_setitimer, "setitimer" , NULL, print_setitimer,
> +                       print_syscall_ret_setitimer },
>  #endif
>  #ifdef TARGET_NR_set_mempolicy
>  { TARGET_NR_set_mempolicy, "set_mempolicy" , NULL, NULL, NULL },
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

