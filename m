Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39D7DC433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 15:55:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2A692067D
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 15:55:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2A692067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42776 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsTSl-0004ci-A6
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 11:55:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43708)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jsTSB-0003lA-MR
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 11:54:47 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:46891)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jsTS9-0000na-78
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 11:54:47 -0400
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue010 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MlfGs-1ka5zV1AIc-00in86; Mon, 06 Jul 2020 17:54:35 +0200
To: Filip Bozuta <Filip.Bozuta@syrmia.com>, qemu-devel@nongnu.org
References: <20200626213937.20333-1-Filip.Bozuta@syrmia.com>
 <20200626213937.20333-4-Filip.Bozuta@syrmia.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Subject: Re: [PATCH 3/3] linux-user: Add strace support for printing arguments
 of some clock and time functions
Message-ID: <7ba4fcb7-17bb-0439-63b3-e63ecb45c196@vivier.eu>
Date: Mon, 6 Jul 2020 17:54:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200626213937.20333-4-Filip.Bozuta@syrmia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:jxqWwJFH8UoeL0u68FF+2cdgpn7b9mFPHLddUD5skbkbAuhzS0d
 PNSfG0I30BmGQua2bgwrwpwNfkwKCZf/+yrQRw1lnVgyZfGeVFhS9hwnjIQ1HckcYj+3Ydw
 BngCyS76DEV8ZOEl1rGQfa0d0U5FWgVBo2MHeqCm7I6XBcVYKJoSdh+xYeN/0qlJVr/kaz2
 y9coq+eKdqiL540Q1VBpw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pB2MuxC93SE=:GJ3HREvMxAZPR71XaHG+gx
 3k3Nzu0fLNNXZhHBJEsdzpKnhayNHHdEDtk9T04gcO0vAFUuuRGskJ3DFc3j0ePqxyfYIeKPA
 6UM+eJBKd1+chL/wf5uuJ7ThkKe5el8bK1gP2Wlqg8XZf/JJOX++BaCrM8L5vJCD4ox2zTzMx
 V2HHkvc//5fRHkDq+5SPDUkNbxxa4qjUr/p4XeIxZniw98aQd6l+ybbvWm8UZqqzdJ0m1hYp6
 GD3YfYu6hTVcXjgHSm9PmX3grGjVHqzCjuPFN0FOjnsW0SsnperH6ljWj0+8msawu+Fg5EPwV
 QeBkTAGPC/4ez467R4LbVAt9FJWJGkUyKExMRJvbVjIU3yMrWTTafTq0ySBxN1hyJeAvectHx
 h8uyjOQR9ooOCqEBEpVGQlk8A/NFiU6XzPoWqDlTAo4OpBMDWGfWmWjgMrpfrmMOsNdA56g8I
 tEfW5NU6Ag/u7eFdXffZcLuehj4GH7Egsj/Um+TnvRu0uqcW/Bhsn25P9Rfye6zRIttyDRWwx
 PJpBdZBG7jlW7nfK8KZw5XBZzDXpjuUvHkPV6+eVtQ0yyp86LOjOYWjqRI3FfLROD01OmauX+
 qC37OGEw9kcOy3KGRN6OTgHOqafMTjmckP82bAPcVHAVvRc/sY79t2Cc9b1vp2daO25aXVt5D
 bhCUBoCX61p+ElMYHuASbFHleyTG9SaONxpV82J2gLhXFjWkdsh2qyv1yOC4xOMCN6EepVI8u
 VvveZl8sydIuC4giTPitHFE7vpmEelm26CwFbDNpJsSafkMQQ7hGc2CkM5PVvSu5oq/1xe7NR
 CQWF/Wg7660fIlAyY3HmlHEucNXGWwI4/kfPXGipMaupZpc05q2XKugaK3nV6wkKMKRvg6Q
Received-SPF: none client-ip=212.227.126.187; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/06 11:54:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: riku.voipio@iki.fi
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 26/06/2020 à 23:39, Filip Bozuta a écrit :
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
>     Also, the existing function "print_timeval()" was changed a little so
>     that it prints the field names beside the values. Syscalls "clock_getres()"
>     and "clocK_gettime()" have the same number and types of arguments and
>     thus their print functions "print_clock_getres" and "print_clock_gettime"
>     shate a common definition in file "strace.c".
> 
> Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
> ---
>  linux-user/strace.c    | 186 ++++++++++++++++++++++++++++++++++++++++-
>  linux-user/strace.list |  16 ++--
>  2 files changed, 194 insertions(+), 8 deletions(-)
> 
> diff --git a/linux-user/strace.c b/linux-user/strace.c
> index 1fc4404310..414748d0fa 100644
> --- a/linux-user/strace.c
> +++ b/linux-user/strace.c
> @@ -64,7 +64,9 @@ UNUSED static void print_string(abi_long, int);
>  UNUSED static void print_buf(abi_long addr, abi_long len, int last);
>  UNUSED static void print_raw_param(const char *, abi_long, int);
>  UNUSED static void print_timeval(abi_ulong, int);
> +UNUSED static void print_timespec(abi_ulong, int);
>  UNUSED static void print_timezone(abi_ulong, int);
> +UNUSED static void print_itimerval(abi_ulong, int);
>  UNUSED static void print_number(abi_long, int);
>  UNUSED static void print_signal(abi_ulong, int);
>  UNUSED static void print_sockaddr(abi_ulong, abi_long, int);
> @@ -833,6 +835,65 @@ print_syscall_ret_adjtimex(const struct syscallname *name, abi_long ret,
>  }
>  #endif
>  
> +#if defined(TARGET_NR_clock_gettime) || defined(TARGET_NR_clock_getres)
> +static void
> +print_syscall_ret_clock_gettime(const struct syscallname *name, abi_long ret,
> +                                abi_long arg0, abi_long arg1, abi_long arg2,
> +                                abi_long arg3, abi_long arg4, abi_long arg5)
> +{
> +    print_syscall_err(ret);
> +
> +    if (ret >= 0) {
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
> +print_syscall_ret_gettimeofday(const struct syscallname *name, abi_long ret,
> +                               abi_long arg0, abi_long arg1, abi_long arg2,
> +                               abi_long arg3, abi_long arg4, abi_long arg5)
> +{
> +    print_syscall_err(ret);
> +
> +    if (ret >= 0) {
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
> +print_syscall_ret_getitimer(const struct syscallname *name, abi_long ret,
> +                            abi_long arg0, abi_long arg1, abi_long arg2,
> +                            abi_long arg3, abi_long arg4, abi_long arg5)
> +{
> +    print_syscall_err(ret);
> +
> +    if (ret >= 0) {
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
>  #if defined(TARGET_NR_listxattr) || defined(TARGET_NR_llistxattr) \
>   || defined(TARGGET_NR_flistxattr)
>  static void
> @@ -1371,13 +1432,34 @@ print_timeval(abi_ulong tv_addr, int last)
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
> @@ -1397,6 +1479,21 @@ print_timezone(abi_ulong tz_addr, int last)
>      }
>  }
>  
> +static void
> +print_itimerval(abi_ulong it_addr, int last)
> +{
> +    if (it_addr) {
> +        qemu_log("{it_interval=");
> +        print_timeval(it_addr, 0);
> +        qemu_log("it_value=");
> +        print_timeval(it_addr +
> +                      offsetof(struct target_itimerval, it_value), 1);
> +        qemu_log("}%s", get_comma(last));

It would be cleaner to define a target_itimerval, but as it is already
decoded like that in syscall.c I think we can take this also in strace.c

> +    } else {
> +        qemu_log("NULL%s", get_comma(last));
> +    }
> +}
> +
>  #undef UNUSED
>  
>  #ifdef TARGET_NR_accept
> @@ -1839,6 +1936,19 @@ print_futimesat(const struct syscallname *name,
>  }
>  #endif
>  
> +#ifdef TARGET_NR_gettimeofday
> +static void
> +print_gettimeofday(const struct syscallname *name,
> +    abi_long arg0, abi_long arg1, abi_long arg2,
> +    abi_long arg3, abi_long arg4, abi_long arg5)
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
>  print_settimeofday(const struct syscallname *name,
> @@ -1852,6 +1962,78 @@ print_settimeofday(const struct syscallname *name,
>  }
>  #endif
>  
> +#if defined(TARGET_NR_clock_gettime) || defined(TARGET_NR_clock_getres)
> +static void
> +print_clock_gettime(const struct syscallname *name,
> +    abi_long arg0, abi_long arg1, abi_long arg2,
> +    abi_long arg3, abi_long arg4, abi_long arg5)
> +{
> +    print_syscall_prologue(name);
> +    print_clockid(arg0, 0);
> +    print_pointer(arg1, 1);
> +    print_syscall_epilogue(name);
> +}
> +#define print_clock_getres     print_clock_gettime
> +#endif
> +
> +#ifdef TARGET_NR_clock_settime
> +static void
> +print_clock_settime(const struct syscallname *name,
> +    abi_long arg0, abi_long arg1, abi_long arg2,
> +    abi_long arg3, abi_long arg4, abi_long arg5)
> +{
> +    print_syscall_prologue(name);
> +    print_clockid(arg0, 0);
> +    print_timespec(arg1, 1);
> +    print_syscall_epilogue(name);
> +}
> +#endif
> +
> +#ifdef TARGET_NR_getitimer
> +static void
> +print_getitimer(const struct syscallname *name,
> +    abi_long arg0, abi_long arg1, abi_long arg2,
> +    abi_long arg3, abi_long arg4, abi_long arg5)
> +{
> +    print_syscall_prologue(name);
> +    switch (arg0) {
> +    case ITIMER_REAL:
> +        qemu_log("ITIMER_REAL,"); break;
> +    case ITIMER_VIRTUAL:
> +        qemu_log("ITIMER_VIRTUAL,"); break;
> +    case ITIMER_PROF:
> +        qemu_log("ITIMER_PROF,"); break;
> +    default:
> +        print_raw_param("%#x", arg1, 0);
> +    }

Perhaps you can move the switch to a function and use it in
print_getitimer() and in print_setitimer().

> +    print_pointer(arg1, 1);
> +    print_syscall_epilogue(name);
> +}
> +#endif
> +
> +#ifdef TARGET_NR_setitimer
> +static void
> +print_setitimer(const struct syscallname *name,
> +    abi_long arg0, abi_long arg1, abi_long arg2,
> +    abi_long arg3, abi_long arg4, abi_long arg5)
> +{
> +    print_syscall_prologue(name);
> +    switch (arg0) {
> +    case ITIMER_REAL:
> +        qemu_log("ITIMER_REAL,"); break;
> +    case ITIMER_VIRTUAL:
> +        qemu_log("ITIMER_VIRTUAL,"); break;
> +    case ITIMER_PROF:
> +        qemu_log("ITIMER_PROF,"); break;
> +    default:
> +        print_raw_param("%#x", arg1, 0);
> +    }
> +    print_itimerval(arg1, 0);
> +    print_itimerval(arg2, 1);

arg2 is old value and should be displaye in a ret function.

> +    print_syscall_epilogue(name);
> +}
> +#endif
> +
>  #ifdef TARGET_NR_link
>  static void
>  print_link(const struct syscallname *name,
> diff --git a/linux-user/strace.list b/linux-user/strace.list
> index 822b6be49c..6b5cef149f 100644
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
> @@ -1290,7 +1294,7 @@
>  { TARGET_NR_sethostname, "sethostname" , NULL, NULL, NULL },
>  #endif
>  #ifdef TARGET_NR_setitimer
> -{ TARGET_NR_setitimer, "setitimer" , NULL, NULL, NULL },
> +{ TARGET_NR_setitimer, "setitimer" , NULL, print_setitimer, NULL },
>  #endif
>  #ifdef TARGET_NR_set_mempolicy
>  { TARGET_NR_set_mempolicy, "set_mempolicy" , NULL, NULL, NULL },
> 

Thanks,
Laurent

