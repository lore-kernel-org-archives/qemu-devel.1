Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0907C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 11:17:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74A9F2075D
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 11:17:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74A9F2075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41274 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k40Np-0005mH-Me
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 07:17:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53726)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1k40N0-0004pJ-3m
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 07:17:06 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:42865)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1k40My-0007SM-6d
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 07:17:05 -0400
Received: from [192.168.100.1] ([82.252.135.186]) by mrelayeu.kundenserver.de
 (mreue108 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1M7JrG-1k55EW0IBg-007iqa; Fri, 07 Aug 2020 13:17:00 +0200
Subject: Re: [PATCH v2 1/2] linux-user: Modify
 'target_to_host/host_to_target_itimerspec()'
To: Filip Bozuta <Filip.Bozuta@syrmia.com>, qemu-devel@nongnu.org
References: <20200722153421.295411-1-Filip.Bozuta@syrmia.com>
 <20200722153421.295411-2-Filip.Bozuta@syrmia.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <3a556a64-513f-f6ed-16ca-a8c73aceb8d1@vivier.eu>
Date: Fri, 7 Aug 2020 13:16:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200722153421.295411-2-Filip.Bozuta@syrmia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:kuo4TYQ+5BhKlU9Wm9sEB7Cxhx7HFBzGFvqLPJmjb7P1lb+CAQ3
 u2/tc+wxMFY+pru8HRPXciOTX/z9PAWc7qIshpCE9wBFSQ/Jlk+WZooTMkf+yFfUkA3t3VG
 14x5EBGpLPUNo3Y9p755xCKO/bDLGjnJ1Pih2k+4fKjxY7TxMLDEhHNvuLJT/guR3e0NdMD
 z366n9mzHvEXetewtsG0A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0ZBs8Bid85s=:9JmPh/CJvS33j8RC9F8cvB
 oKmbxs+fM8ebbUDNogdCf5sFVZPad3cImK6+Rcp6NETBjTDaH3gLFNJW1HtJKnWi0SOzVTpV7
 fWFAy4pCSsq9ETosimlstfXomcl4F1PhtowqjBoYw/3pzJcV8o4iZsiXuJZ6HOUn/BBbjWGMv
 K/w6ymohfwCLcg8JYI0Pb5q9Y1/XLThUUHWUlyhULIRvsGAKQYAe+wn0D0usFOHR7TqY52Hog
 cUbV6fzd8on5nnMp1GVriX2n1WrZhIlCIfM+AmPG5v7sZlST6Jyw4TN7OyuPzoATqbgeOZNcv
 /2ztCXE9CCjFHK7xF0evBpHRdB3K1JTFL1LGMc7OubNENvITsycN5xBBfCtIYRSzwnXhX4hSR
 kxfQyFa/3vYO9ilClx0iE9CQC8m/vZ0X/sfD4MYnEIKWMXytUnTZnzboJqQcAuxYk8a/wBa0Q
 h4IWQac0l1gYtXzKflBOliOXwFKSW8UT2kPyf5tRZngmh/J8Zw+WZiy0nhRCSbmPEipKta/EI
 KENtUx3/RTIoTZZf7VKoYcV9qEy2wjWzb6aIPJi1z3ankYppBtzOzABrWXPwinzv+9LboOuKE
 g5X39vkcNwuKZ+Ffml3C/zHWHXl889qeU76KV0NMrrf3MRgP2wswWEBMC6/m0qtjxZsz59a1T
 wp2Z0a9eFxnEK5CmFk2RQhMUIyFa2MdaIhEqnBZ5YBNncWzagA1c9D4Y5+8QavgwgQG/Qd8CY
 /9MMzlm5xb8aZFOzu491/ZnDKGEnahERMZm5YfcZ6plm+62tdGXt7PkaxrKLq1QZmH+x3lqXj
 WapFOylXsU/KakTktT+GjxS4+K7Kyn7Y39zLev0fk8w2CAHwpbVObRq0zhupSNu4HxW/6zx
Received-SPF: none client-ip=217.72.192.74; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/07 07:17:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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

Le 22/07/2020 à 17:34, Filip Bozuta a écrit :
> Functions 'target_to_host_itimerspec()' and 'host_to_target_itimerspec()'
> are used to convert values of type 'struct itimerspec' between target and
> host. This type has 'struct timespec' as its fields. That is the reason
> why this patch introduces a little modification to the converting functions
> to be implemented using already existing functions that convert 'struct timespec':
> 'target_to_host_timespec()' and 'host_to_target_timespec()'. This makes the
> code of 'target_to_host_itimerspec()' and 'host_to_target_itimerspec()' more
> clean and readable.
> 
> Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
> ---
>  linux-user/syscall.c | 46 ++++++++++++++++++--------------------------
>  1 file changed, 19 insertions(+), 27 deletions(-)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 1211e759c2..b1baed346c 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -1236,7 +1236,9 @@ static inline abi_long copy_to_user_timeval64(abi_ulong target_tv_addr,
>      defined(TARGET_NR_nanosleep) || defined(TARGET_NR_clock_settime) || \
>      defined(TARGET_NR_utimensat) || defined(TARGET_NR_mq_timedsend) || \
>      defined(TARGET_NR_mq_timedreceive) || defined(TARGET_NR_ipc) || \
> -    defined(TARGET_NR_semop) || defined(TARGET_NR_semtimedop)
> +    defined(TARGET_NR_semop) || defined(TARGET_NR_semtimedop) || \
> +    defined(TARGET_NR_timer_settime) || \
> +    (defined(TARGET_NR_timerfd_settime) && defined(CONFIG_TIMERFD))
>  static inline abi_long target_to_host_timespec(struct timespec *host_ts,
>                                                 abi_ulong target_addr)
>  {
> @@ -6790,46 +6792,36 @@ static inline abi_long target_ftruncate64(void *cpu_env, abi_long arg1,
>  
>  #if defined(TARGET_NR_timer_settime) || \
>      (defined(TARGET_NR_timerfd_settime) && defined(CONFIG_TIMERFD))
> -static inline abi_long target_to_host_itimerspec(struct itimerspec *host_itspec,
> +static inline abi_long target_to_host_itimerspec(struct itimerspec *host_its,
>                                                   abi_ulong target_addr)
>  {
> -    struct target_itimerspec *target_itspec;
> -
> -    if (!lock_user_struct(VERIFY_READ, target_itspec, target_addr, 1)) {
> +    if (target_to_host_timespec(&host_its->it_interval, target_addr +
> +                                offsetof(struct target_itimerspec,
> +                                         it_interval)) ||
> +        target_to_host_timespec(&host_its->it_value, target_addr +
> +                                offsetof(struct target_itimerspec,
> +                                         it_value))) {
>          return -TARGET_EFAULT;
>      }
>  
> -    host_itspec->it_interval.tv_sec =
> -                            tswapal(target_itspec->it_interval.tv_sec);
> -    host_itspec->it_interval.tv_nsec =
> -                            tswapal(target_itspec->it_interval.tv_nsec);
> -    host_itspec->it_value.tv_sec = tswapal(target_itspec->it_value.tv_sec);
> -    host_itspec->it_value.tv_nsec = tswapal(target_itspec->it_value.tv_nsec);
> -
> -    unlock_user_struct(target_itspec, target_addr, 1);
>      return 0;
>  }
>  #endif
>  
>  #if ((defined(TARGET_NR_timerfd_gettime) || \
>        defined(TARGET_NR_timerfd_settime)) && defined(CONFIG_TIMERFD)) || \
> -    defined(TARGET_NR_timer_gettime) || defined(TARGET_NR_timer_settime)
> +      defined(TARGET_NR_timer_gettime) || defined(TARGET_NR_timer_settime)
>  static inline abi_long host_to_target_itimerspec(abi_ulong target_addr,
> -                                               struct itimerspec *host_its)
> -{
> -    struct target_itimerspec *target_itspec;
> -
> -    if (!lock_user_struct(VERIFY_WRITE, target_itspec, target_addr, 0)) {
> +                                                 struct itimerspec *host_its)
> +{
> +    if (host_to_target_timespec(target_addr + offsetof(struct target_itimerspec,
> +                                                       it_interval),
> +                                &host_its->it_interval) ||
> +        host_to_target_timespec(target_addr + offsetof(struct target_itimerspec,
> +                                                       it_value),
> +                                &host_its->it_value)) {
>          return -TARGET_EFAULT;
>      }
> -
> -    target_itspec->it_interval.tv_sec = tswapal(host_its->it_interval.tv_sec);
> -    target_itspec->it_interval.tv_nsec = tswapal(host_its->it_interval.tv_nsec);
> -
> -    target_itspec->it_value.tv_sec = tswapal(host_its->it_value.tv_sec);
> -    target_itspec->it_value.tv_nsec = tswapal(host_its->it_value.tv_nsec);
> -
> -    unlock_user_struct(target_itspec, target_addr, 0);
>      return 0;
>  }
>  #endif
> 

Applied to my linux-user-for-5.2 branch.

Thanks,
Laurent


