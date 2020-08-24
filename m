Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85FD8C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 16:45:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 596732067C
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 16:45:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 596732067C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53392 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAFas-00039l-LN
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 12:45:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58912)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kAFZF-0000jJ-GH
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 12:43:33 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:57303)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kAFZD-0008Mx-Ft
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 12:43:33 -0400
Received: from [192.168.100.1] ([82.252.135.186]) by mrelayeu.kundenserver.de
 (mreue011 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MN5Nt-1jtP8V20Dl-00J1qw; Mon, 24 Aug 2020 18:43:26 +0200
Subject: Re: [PATCH v2 2/2] linux-user: Add support for
 'rt_sigtimedwait_time64()' and 'sched_rr_get_interval_time64()'
To: Filip Bozuta <Filip.Bozuta@syrmia.com>, qemu-devel@nongnu.org
References: <20200727112307.343608-1-Filip.Bozuta@syrmia.com>
 <20200727112307.343608-3-Filip.Bozuta@syrmia.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <98a62001-b6df-fe1c-0e8d-7407086f6005@vivier.eu>
Date: Mon, 24 Aug 2020 18:43:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200727112307.343608-3-Filip.Bozuta@syrmia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:k29VK0gDnrV7jf1JWh/h3IXBNb53I/FSXjzvQb92iTjW76ztnd1
 v1kYnjNpDBEQUeuY8ua3+fFbdUFTRvLBYpUABj9S6qLicx4k0/VP3b1Xal+s33b8eNuIJgF
 J7gCJaqf1ugtAULiTzhASiF6lpjxLqohv/LJB8qbIQ6rpcqeVB/3hKuTbLfhEMoEomozKOL
 nSPHjBeUXtR83u6COMakQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:85xsMvRTBIo=:cIxRjwjmqLOzARszj44AYq
 9BEbSSpesxAxxBbaklDPdtv4bJEm7U6TAsD816fO4N8MD+B5LzpYXfS/et1B98Va1nvsW9L8P
 wiJnghCS1fZEghqYpH8JgLh0ry0QjrAUX04ju1WYLcEQdU0LiTvP0EsZb8oCEmDD/Zvdzi6qv
 wP1ZeXaGNdOGVMuk16ris21ChLoLbR6A+hfc9qYYcw8m0HTJk+z2CqIUgIA47r0bODA+9wUwi
 bmteu+x0hroYZKGkanVKPMIRzvOKsI+GMf+b+qHEyAyGGiuRuAQfeKtVsgJ+QLqC5QpQJgj2s
 qQiLihHRhw6QeYWWQLWUBTyurWXHyqyjWRoUto7FRrGuUunvRpJFTLD9utv2fRpzil+R+U82h
 RAsGohAPerRolzJb0A492ycyrISYogK2S7pI9B9k0Yt9m30ZQl7p8uaeUbmhda7qTsiMVwOgU
 jE54/vnzvRx+WmFOss5yufoMnX8RGt8HPr5yxpC8TUPKAYF4sPQVoRVwt4TYw7/KWURvhX7Al
 +qIrikMFcHjeEclgZl1dEdBa5I7U6im4SLbH99zY8TWS1Ib9F5xCcqn4hR1mJKN+y+eFqUAJ8
 Ax77yUgx67VvGWcGAXmJI1MmJe0scwuaIY4VuHtRJiYvQohgi+DkU8biVO4fo7W8ek4ANbvNm
 FHcSIJInIpEOLK60gQS2wcZ1OhvzNoWTNoHHjCGt2oIB5S1VUIH8sENVQ9G5C3yJupxIEQCVU
 Inmpoz7MvDvKWpFhnda2Asr7YH+nh9OxJqVZGKvk/AOWTRpZVwyhCqWS0rO+XkCwNvqSG2gTp
 m7xj7uh6rvMyTSYxRNTE3Lme7rLP1jw7D71xCvYHXE2y+vvQZmGob7NZWCZ7hlwE8Nx3n7F
Received-SPF: none client-ip=212.227.126.131; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/24 11:24:39
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
Cc: Riku Voipio <riku.voipio@iki.fi>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 27/07/2020 à 13:23, Filip Bozuta a écrit :
> This patch implements functionality for following time64 syscalls:
> 
> *rt_sigtimedwait_time64()
> 
>     This is a year 2038 safe variant of syscall:
> 
>     int rt_sigtimedwait(const sigset_t *set, siginfo_t *info,
>                         const struct timespec *timeout, size_t sigsetsize)
>     --synchronously wait for queued signals--
>     man page: https://man7.org/linux/man-pages/man2/rt_sigtimedwait.2.html
> 
> *sched_rr_get_interval_time64()
> 
>     This is a year 2038 safe variant of syscall:
> 
>     int sched_rr_get_interval(pid_t pid, struct timespec *tp)
>     --get  the  SCHED_RR  interval  for the named process--
>     man page: https://man7.org/linux/man-pages/man2/sched_rr_get_interval.2.html
> 
> Implementation notes:
> 
>     These syscalls were implemented in similar ways like
>     'rt_sigtimedwait()' and 'sched_rr_get_interval()' except
>     that functions 'target_to_host_timespec64()' and
>     'host_to_target_timespec64()' were used to convert values
>     of 'struct timespec' between host and target.
> 
> Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
> ---
>  linux-user/syscall.c | 53 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index c1b36ea698..35f6dded81 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -8831,6 +8831,48 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>              }
>          }
>          return ret;
> +#endif
> +#ifdef TARGET_NR_rt_sigtimedwait_time64
> +    case TARGET_NR_rt_sigtimedwait_time64:
> +        {
> +            sigset_t set;
> +            struct timespec uts, *puts;
> +            siginfo_t uinfo;
> +
> +            if (arg4 != sizeof(target_sigset_t)) {
> +                return -TARGET_EINVAL;
> +            }
> +
> +            p = lock_user(VERIFY_READ, arg1, sizeof(target_sigset_t), 1);
> +            if (!p) {
> +                return -TARGET_EFAULT;
> +            }
> +            target_to_host_sigset(&set, p);
> +            unlock_user(p, arg1, 0);
> +            if (arg3) {
> +                puts = &uts;
> +                if (target_to_host_timespec64(puts, arg3)) {
> +                    return -TARGET_EFAULT;
> +                }
> +            } else {
> +                puts = NULL;
> +            }
> +            ret = get_errno(safe_rt_sigtimedwait(&set, &uinfo, puts,
> +                                                 SIGSET_T_SIZE));
> +            if (!is_error(ret)) {
> +                if (arg2) {
> +                    p = lock_user(VERIFY_WRITE, arg2,
> +                                  sizeof(target_siginfo_t), 0);
> +                    if (!p) {
> +                        return -TARGET_EFAULT;
> +                    }
> +                    host_to_target_siginfo(p, &uinfo);
> +                    unlock_user(p, arg2, sizeof(target_siginfo_t));
> +                }
> +                ret = host_to_target_signal(ret);
> +            }
> +        }
> +        return ret;
>  #endif
>      case TARGET_NR_rt_sigqueueinfo:
>          {
> @@ -10353,6 +10395,17 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>          }
>          return ret;
>  #endif
> +#ifdef TARGET_NR_sched_rr_get_interval_time64
> +    case TARGET_NR_sched_rr_get_interval_time64:
> +        {
> +            struct timespec ts;
> +            ret = get_errno(sched_rr_get_interval(arg1, &ts));
> +            if (!is_error(ret)) {
> +                ret = host_to_target_timespec64(arg2, &ts);
> +            }
> +        }
> +        return ret;
> +#endif
>  #if defined(TARGET_NR_nanosleep)
>      case TARGET_NR_nanosleep:
>          {
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

