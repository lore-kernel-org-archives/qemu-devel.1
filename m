Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9112C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 11:18:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A18912075D
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 11:18:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A18912075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44396 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k40Oo-00074o-Pr
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 07:18:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53778)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1k40NA-000573-3L
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 07:17:16 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:58885)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1k40N7-0007TO-PD
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 07:17:15 -0400
Received: from [192.168.100.1] ([82.252.135.186]) by mrelayeu.kundenserver.de
 (mreue107 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1Mz9EL-1kzfYj37S7-00wBgN; Fri, 07 Aug 2020 13:17:11 +0200
Subject: Re: [PATCH v2 2/2] linux-user: Add support for a group of 2038 safe
 syscalls
To: Filip Bozuta <Filip.Bozuta@syrmia.com>, qemu-devel@nongnu.org
References: <20200722153421.295411-1-Filip.Bozuta@syrmia.com>
 <20200722153421.295411-3-Filip.Bozuta@syrmia.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <efbf25de-834b-6493-0a29-6e54f922ed2c@vivier.eu>
Date: Fri, 7 Aug 2020 13:17:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200722153421.295411-3-Filip.Bozuta@syrmia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:qTHwaOEb+5MGxHcwHsWM2J4RWpmmg1/fIS7kGdLsQiY+UZBoQir
 YZwWMVR2fWxqPAHcRfi+bEqGhFsoTIpgzIg82UOCeCF68BBeWpOevwFTn1BKptWsF7AwV+W
 tKwMk2wNMvHU9ofNo1h81UBhGwyPk9axHhgU4VtkqAvS5YvfdmFo9750KhUscIHIGcVov+R
 1KWuO/3dNCQicHcIbq+ig==
X-UI-Out-Filterresults: notjunk:1;V03:K0:niTjVC2g/XU=:mwLPx1hjl+awde3WMIdhJn
 vbhogzaSixPxIS68RBXIBLJ2S71SrJDliD5tSt0YroyEu+dMS+oYiO+TpdNGwkG7jf+HHvNzP
 5ovi1tfiLqUnwzuPj4BKJnMIRerZa9IUswu4sqmjJI04Vg9NzLQrEXg0pgzOLfL+ERksricHY
 ZU98V7acVbX1LyTRbnW4TFOKxk9Nju0ba329MBg7BzBm/pL8m4Op3JBeIDN044oUYqI2v2O0e
 M30FOBv//D6AGanIgjFw13WbP2CZcYuzFrRJf4cxBaqlXq5Mul2fV4RadadXpiyj5vn1RL+ur
 b+yVv6NNwSa9cHSSdYDi661v4E8Q1FtGpo2fXYt5wxrfGvJp1YVRTpD1dQzlJwoP+HbVRuJ/R
 Mut6bdHZw1DroC6Yh7x1HuKeMN8gMWcbljdKb30LQVOeQ3d05i2d+NcPGoQdMoKbt9Aqq7SLy
 BFMqqU32WNqOuNg05x9MdMYGIeGgjzsih1V4krIT3KucnUKTBcZQDVGF+sTC55TSoVKUSfHNF
 BHXr7iJECrwerCBpeDEM/2RZqQ8o7QUet0KXcz7FajAo5I5Wp2ofBZjcZo9WTKRgzR0BQ4OYs
 KfICjzicWHhSuQNSQc1oTOZSNF/E8NygKyzG2xP0mx+NLOYdQCd6zGi42ZsYXSDZnZKdnNYDc
 By0SjVK6JxLVkgLv8WTChR73svF7ixk5/Kd72X4gN9xYGmDB1bzqUb5Ony9lLeuanC99OAhQu
 u42X5AoyjjPMl/Jb7YW3cGRPvQXpto+Oc6NkgmA0T2J07ioNtdFrzHBQE3rYOxXSDmEwILyad
 0tgTkirXHTT4klYZHY2f8l2U9KJ4QsWSgu5AWVGJ0XPojBg77PL3TdCiP8FAa/LozKtwPIK
Received-SPF: none client-ip=212.227.17.10; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/07 05:44:03
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

Le 22/07/2020 à 17:34, Filip Bozuta a écrit :
> This patch implements functionality for following time64 syscalls:
> 
> *clock_getres_time64
> 
>      This a year 2038 safe variant of syscall:
> 
>      int clock_getres(clockid_t clockid, struct timespec *res)
>      --finding the resoultion of a specified clock--
>      man page: https://man7.org/linux/man-pages/man2/clock_getres.2.html
> 
> *timer_gettime64
> *timer_settime64
> 
>      These are year 2038 safe variants of syscalls:
> 
>      int timer_settime(timer_t timerid, int flags,
>                        const struct itimerspec *new_value,
>                        struct itimerspec *old_value)
>      int timer_gettime(timer_t timerid, struct itimerspec *curr_value)
>      --arming/dissarming and fetching state of POSIX per-process timer--
>      man page: https://man7.org/linux/man-pages/man2/timer_settime.2.html
> 
> *timerfd_gettime64
> *timerfd_settime64
> 
>      These are year 2038 safe variants of syscalls:
> 
>      int timerfd_settime(int fd, int flags,
>                          const struct itimerspec *new_value,
>                          struct itimerspec *old_value)
>      int timerfd_gettime(int fd, struct itimerspec *curr_value)
>      --timers that notify via file descriptor--
>      man page: https://man7.org/linux/man-pages/man2/timerfd_settime.2.html
> 
> Implementation notes:
> 
>      Syscall 'clock_getres_time64' was implemented similarly to 'clock_getres()'.
>      The only difference was that for the conversion of 'struct timespec' from
>      host to target, function 'host_to_target_timespec64()' was used instead of
>      'host_to_target_timespec()'.
> 
>      For other syscalls, new functions 'host_to_target_itimerspec64()' and
>      'target_to_host_itimerspec64()' were added to convert the value of the
>      'struct itimerspec' from host to target and vice versa. A new type
>      'struct target__kernel_itimerspec' was added in 'syscall_defs.h'. This
>      type was defined with fields which are of the already defined type
>      'struct target_timespec'. This new 'struct target__kernel_itimerspec'
>      type is used in these new converting functions. These new functions were
>      defined similarly to 'host_to_target_itimerspec()' and 'target_to_host_itimerspec()'
>      the only difference being that 'target_to_host_timespec64()' and
>      'host_to_target_timespec64()' were used.
> 
> Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
> ---
>  linux-user/syscall.c      | 139 +++++++++++++++++++++++++++++++++++++-
>  linux-user/syscall_defs.h |   5 ++
>  2 files changed, 143 insertions(+), 1 deletion(-)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index b1baed346c..9040e794ec 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -1254,7 +1254,9 @@ static inline abi_long target_to_host_timespec(struct timespec *host_ts,
>  }
>  #endif
>  
> -#if defined(TARGET_NR_clock_settime64) || defined(TARGET_NR_futex_time64)
> +#if defined(TARGET_NR_clock_settime64) || defined(TARGET_NR_futex_time64) || \
> +    defined(TARGET_NR_timer_settime64) || \
> +    (defined(TARGET_NR_timerfd_settime64) && defined(CONFIG_TIMERFD))
>  static inline abi_long target_to_host_timespec64(struct timespec *host_ts,
>                                                   abi_ulong target_addr)
>  {
> @@ -6808,6 +6810,24 @@ static inline abi_long target_to_host_itimerspec(struct itimerspec *host_its,
>  }
>  #endif
>  
> +#if defined(TARGET_NR_timer_settime64) || \
> +    (defined(TARGET_NR_timerfd_settime64) && defined(CONFIG_TIMERFD))
> +static inline abi_long target_to_host_itimerspec64(struct itimerspec *host_its,
> +                                                   abi_ulong target_addr)
> +{
> +    if (target_to_host_timespec64(&host_its->it_interval, target_addr +
> +                                  offsetof(struct target__kernel_itimerspec,
> +                                           it_interval)) ||
> +        target_to_host_timespec64(&host_its->it_value, target_addr +
> +                                  offsetof(struct target__kernel_itimerspec,
> +                                           it_value))) {
> +        return -TARGET_EFAULT;
> +    }
> +
> +    return 0;
> +}
> +#endif
> +
>  #if ((defined(TARGET_NR_timerfd_gettime) || \
>        defined(TARGET_NR_timerfd_settime)) && defined(CONFIG_TIMERFD)) || \
>        defined(TARGET_NR_timer_gettime) || defined(TARGET_NR_timer_settime)
> @@ -6826,6 +6846,26 @@ static inline abi_long host_to_target_itimerspec(abi_ulong target_addr,
>  }
>  #endif
>  
> +#if ((defined(TARGET_NR_timerfd_gettime64) || \
> +      defined(TARGET_NR_timerfd_settime64)) && defined(CONFIG_TIMERFD)) || \
> +      defined(TARGET_NR_timer_gettime64) || defined(TARGET_NR_timer_settime64)
> +static inline abi_long host_to_target_itimerspec64(abi_ulong target_addr,
> +                                                   struct itimerspec *host_its)
> +{
> +    if (host_to_target_timespec64(target_addr +
> +                                  offsetof(struct target__kernel_itimerspec,
> +                                           it_interval),
> +                                  &host_its->it_interval) ||
> +        host_to_target_timespec64(target_addr +
> +                                  offsetof(struct target__kernel_itimerspec,
> +                                           it_value),
> +                                  &host_its->it_value)) {
> +        return -TARGET_EFAULT;
> +    }
> +    return 0;
> +}
> +#endif
> +
>  #if defined(TARGET_NR_adjtimex) || \
>      (defined(TARGET_NR_clock_adjtime) && defined(CONFIG_CLOCK_ADJTIME))
>  static inline abi_long target_to_host_timex(struct timex *host_tx,
> @@ -11816,6 +11856,17 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>          return ret;
>      }
>  #endif
> +#ifdef TARGET_NR_clock_getres_time64
> +    case TARGET_NR_clock_getres_time64:
> +    {
> +        struct timespec ts;
> +        ret = get_errno(clock_getres(arg1, &ts));
> +        if (!is_error(ret)) {
> +            host_to_target_timespec64(arg2, &ts);
> +        }
> +        return ret;
> +    }
> +#endif
>  #ifdef TARGET_NR_clock_nanosleep
>      case TARGET_NR_clock_nanosleep:
>      {
> @@ -12411,6 +12462,32 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>      }
>  #endif
>  
> +#ifdef TARGET_NR_timer_settime64
> +    case TARGET_NR_timer_settime64:
> +    {
> +        target_timer_t timerid = get_timer_id(arg1);
> +
> +        if (timerid < 0) {
> +            ret = timerid;
> +        } else if (arg3 == 0) {
> +            ret = -TARGET_EINVAL;
> +        } else {
> +            timer_t htimer = g_posix_timers[timerid];
> +            struct itimerspec hspec_new = {{0},}, hspec_old = {{0},};
> +
> +            if (target_to_host_itimerspec64(&hspec_new, arg3)) {
> +                return -TARGET_EFAULT;
> +            }
> +            ret = get_errno(
> +                          timer_settime(htimer, arg2, &hspec_new, &hspec_old));
> +            if (arg4 && host_to_target_itimerspec64(arg4, &hspec_old)) {
> +                return -TARGET_EFAULT;
> +            }
> +        }
> +        return ret;
> +    }
> +#endif
> +
>  #ifdef TARGET_NR_timer_gettime
>      case TARGET_NR_timer_gettime:
>      {
> @@ -12434,6 +12511,29 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>      }
>  #endif
>  
> +#ifdef TARGET_NR_timer_gettime64
> +    case TARGET_NR_timer_gettime64:
> +    {
> +        /* args: timer_t timerid, struct itimerspec64 *curr_value */
> +        target_timer_t timerid = get_timer_id(arg1);
> +
> +        if (timerid < 0) {
> +            ret = timerid;
> +        } else if (!arg2) {
> +            ret = -TARGET_EFAULT;
> +        } else {
> +            timer_t htimer = g_posix_timers[timerid];
> +            struct itimerspec hspec;
> +            ret = get_errno(timer_gettime(htimer, &hspec));
> +
> +            if (host_to_target_itimerspec64(arg2, &hspec)) {
> +                ret = -TARGET_EFAULT;
> +            }
> +        }
> +        return ret;
> +    }
> +#endif
> +
>  #ifdef TARGET_NR_timer_getoverrun
>      case TARGET_NR_timer_getoverrun:
>      {
> @@ -12487,6 +12587,20 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>          return ret;
>  #endif
>  
> +#if defined(TARGET_NR_timerfd_gettime64) && defined(CONFIG_TIMERFD)
> +    case TARGET_NR_timerfd_gettime64:
> +        {
> +            struct itimerspec its_curr;
> +
> +            ret = get_errno(timerfd_gettime(arg1, &its_curr));
> +
> +            if (arg2 && host_to_target_itimerspec64(arg2, &its_curr)) {
> +                return -TARGET_EFAULT;
> +            }
> +        }
> +        return ret;
> +#endif
> +
>  #if defined(TARGET_NR_timerfd_settime) && defined(CONFIG_TIMERFD)
>      case TARGET_NR_timerfd_settime:
>          {
> @@ -12510,6 +12624,29 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>          return ret;
>  #endif
>  
> +#if defined(TARGET_NR_timerfd_settime64) && defined(CONFIG_TIMERFD)
> +    case TARGET_NR_timerfd_settime64:
> +        {
> +            struct itimerspec its_new, its_old, *p_new;
> +
> +            if (arg3) {
> +                if (target_to_host_itimerspec64(&its_new, arg3)) {
> +                    return -TARGET_EFAULT;
> +                }
> +                p_new = &its_new;
> +            } else {
> +                p_new = NULL;
> +            }
> +
> +            ret = get_errno(timerfd_settime(arg1, arg2, p_new, &its_old));
> +
> +            if (arg4 && host_to_target_itimerspec64(arg4, &its_old)) {
> +                return -TARGET_EFAULT;
> +            }
> +        }
> +        return ret;
> +#endif
> +
>  #if defined(TARGET_NR_ioprio_get) && defined(__NR_ioprio_get)
>      case TARGET_NR_ioprio_get:
>          return get_errno(ioprio_get(arg1, arg2));
> diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
> index 3c261cff0e..427a25f5bc 100644
> --- a/linux-user/syscall_defs.h
> +++ b/linux-user/syscall_defs.h
> @@ -259,6 +259,11 @@ struct target_itimerspec {
>      struct target_timespec it_value;
>  };
>  
> +struct target__kernel_itimerspec {
> +    struct target__kernel_timespec it_interval;
> +    struct target__kernel_timespec it_value;
> +};
> +
>  struct target_timex {
>      abi_uint modes;              /* Mode selector */
>      abi_long offset;             /* Time offset */
> 

Applied to my linux-user-for-5.2 branch.

Thanks,
Laurent


