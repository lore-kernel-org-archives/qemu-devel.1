Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E53BEC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 21:14:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1ACD2067C
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 21:14:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1ACD2067C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAJnM-0002OI-A9
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 17:14:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39546)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kAJls-0001uZ-BF
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 17:12:52 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:38399)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kAJlm-0003He-Uh
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 17:12:52 -0400
Received: from [192.168.100.1] ([82.252.135.186]) by mrelayeu.kundenserver.de
 (mreue010 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MuDLZ-1kTU533vrh-00uXTI; Mon, 24 Aug 2020 23:12:37 +0200
Subject: Re: [PATCH v3 2/2] linux-user: Add support for
 'mq_timedsend_time64()' and 'mq_timedreceive_time64()'
To: Filip Bozuta <Filip.Bozuta@syrmia.com>, qemu-devel@nongnu.org
References: <20200824193752.67950-1-Filip.Bozuta@syrmia.com>
 <20200824193752.67950-3-Filip.Bozuta@syrmia.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <8219b84f-013c-4474-3cda-4daf9d1fd79c@vivier.eu>
Date: Mon, 24 Aug 2020 23:12:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200824193752.67950-3-Filip.Bozuta@syrmia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:LpHjv7VrtxsdGIeVZVCFonw/fKteMG+j145Q5thxRewTcBHrW/9
 xJFdIoJbETDy39JkPvWsvUbvioB9kAdlxqplpruC6yrRLfiLwMW7SsqfNOqWNmxQjTYbHwO
 NvsbrDtTvrzWu9Yx+S9vQpbdGWTCGsQBBbXKgX3JjStVvhsHmLnei0kO+4j3rTqEG1LzNIa
 a8MEAy6BSno64dLKv7gVA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:TfV5bzTvTv0=:pl5qJ87Hi1vEc/zE+5c9Ju
 yBoqws2yxYTF+SJRehNOKbC/6A/NJaD0TOs+mJWC8dyMIfUNH+utyjPfOH2MP8yDYzH9XC+6X
 B4uqOE1S2xxfvUEDdn4EJv16pJY2rPmBUSS0vCPfnMGihVT1SWqQRmknR6p+2j5KdthkAMlGc
 jBU3QocZ3yS7ic5r9kwW+fTIwbtLkH4SL3M0gR4kDNGsnIb3DZ8wKuDWHiufoJCqKxi90GBg3
 yVGW4PE4dEkNEUx6cauKmutOFEoWXBSi1KpM0P5i+6Fc15RJs6xjF/Vu3MuVyxjuQgqy7o9IC
 OAplMMlbSvcC/oxw6bs6C501wEWtXdeXD1pfCapJ1b3kxODlWNQHH7xF9aYTG31+2YSiV+hJa
 1h+TAEYmwp33bjQR2roFS7w1pr1afqvd287TpERXfjbN3h3yKBTbk0G460nkxkFEdFqDdxzYT
 RpZS042hgOkA+cQbnqM1PI6fVEtj24pSSpMS2eeIU6Wk0WOgxbloYN0Zi4d4YVR0jyaAbaLDn
 8stKgawIUX6L03FRrCtcZ1fnoEhMLC6rFEzRJ0dihoY43jaHm0498lN/ShPu1pwaGcR1VY2oE
 ekiNg7t7757Nb0GVTod5TBWd4EgByy9o+TkFcCH220xmlBH5EYcur+nGC+uwz8ajilDWDedB0
 LpYGtaj/WhQxdx90/C7CeKSBIdKdl+QYEwWYn3Gpbd96ZnpB3aSadxojjTzgKrq53Z+8DKtmR
 fTPrvhpjURUf/AnKpo7vN/tIBfWUCVBkV3wGHrFmBSJTd3JWcE3oNrhvuMZozGTUE60Eq/llt
 lsR5SzRkRvTtlD8bgeifNqKWdgSScaA8NfFdizIjr0CplEajMIO4ejhasY7c0ycGC44XUtX
Received-SPF: none client-ip=212.227.126.135; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/24 16:46:45
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

Le 24/08/2020 à 21:37, Filip Bozuta a écrit :
> This patch implements functionality for following time64 syscalls:
> 
> *mq_timedsend_time64()
> 
>     This is a year 2038 safe vairant of syscall:
> 
>     int mq_timedsend(mqd_t mqdes, const char *msg_ptr,
>                      size_t msg_len, unsigned int msg_prio,
>                      const struct timespec *abs_timeout)
>     --send a message to a message queue--
>     man page: https://www.man7.org/linux/man-pages/man2/mq_timedsend.2.html
> 
> *mq_timedreceive_time64()
> 
>     This is a year 2038 safe variant of syscall:
> 
>     ssize_t mq_timedreceive(mqd_t mqdes, char *msg_ptr,
>                             size_t msg_len, unsigned int *msg_prio,
>                             const struct timespec *abs_timeout)
>     --receive a message from a message queue--
>     man page: https://man7.org/linux/man-pages/man3/mq_receive.3.html
> 
> Implementation notes:
> 
>     These syscalls were implemented in similar ways like
>     'mq_timedsend()' and 'mq_timedreceive' except that
>     functions 'target_to_host_timespec64()' and
>     'host_to_target_timespec64()' were used to convert
>     values of 'struct timespec' between host and target.
> 
> Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
> Reviewed-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  linux-user/syscall.c | 58 +++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 55 insertions(+), 3 deletions(-)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 4ee1de6e65..3331ec9fea 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -829,11 +829,13 @@ safe_syscall5(int, msgrcv, int, msgid, void *, msgp, size_t, sz,
>  safe_syscall4(int, semtimedop, int, semid, struct sembuf *, tsops,
>                unsigned, nsops, const struct timespec *, timeout)
>  #endif
> -#ifdef TARGET_NR_mq_timedsend
> +#if defined(TARGET_NR_mq_timedsend) || \
> +    defined(TARGET_NR_mq_timedsend_time64)
>  safe_syscall5(int, mq_timedsend, int, mqdes, const char *, msg_ptr,
>                size_t, len, unsigned, prio, const struct timespec *, timeout)
>  #endif
> -#ifdef TARGET_NR_mq_timedreceive
> +#if defined(TARGET_NR_mq_timedreceive) || \
> +    defined(TARGET_NR_mq_timedreceive_time64)
>  safe_syscall5(int, mq_timedreceive, int, mqdes, char *, msg_ptr,
>                size_t, len, unsigned *, prio, const struct timespec *, timeout)
>  #endif
> @@ -1243,7 +1245,9 @@ static inline abi_long target_to_host_timespec(struct timespec *host_ts,
>  }
>  #endif
>  
> -#if defined(TARGET_NR_clock_settime64) || defined(TARGET_NR_futex_time64)
> +#if defined(TARGET_NR_clock_settime64) || defined(TARGET_NR_futex_time64) || \
> +    defined(TARGET_NR_mq_timedsend_time64) || \
> +    defined(TARGET_NR_mq_timedreceive_time64)
>  static inline abi_long target_to_host_timespec64(struct timespec *host_ts,
>                                                   abi_ulong target_addr)
>  {
> @@ -11831,6 +11835,27 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>          }
>          return ret;
>  #endif
> +#ifdef TARGET_NR_mq_timedsend_time64
> +    case TARGET_NR_mq_timedsend_time64:
> +        {
> +            struct timespec ts;
> +
> +            p = lock_user(VERIFY_READ, arg2, arg3, 1);
> +            if (arg5 != 0) {
> +                if (target_to_host_timespec64(&ts, arg5)) {
> +                    return -TARGET_EFAULT;
> +                }
> +                ret = get_errno(safe_mq_timedsend(arg1, p, arg3, arg4, &ts));
> +                if (!is_error(ret) && host_to_target_timespec64(arg5, &ts)) {
> +                    return -TARGET_EFAULT;
> +                }
> +            } else {
> +                ret = get_errno(safe_mq_timedsend(arg1, p, arg3, arg4, NULL));
> +            }
> +            unlock_user(p, arg2, arg3);
> +        }
> +        return ret;
> +#endif
>  
>  #ifdef TARGET_NR_mq_timedreceive
>      case TARGET_NR_mq_timedreceive:
> @@ -11858,6 +11883,33 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>          }
>          return ret;
>  #endif
> +#ifdef TARGET_NR_mq_timedreceive_time64
> +    case TARGET_NR_mq_timedreceive_time64:
> +        {
> +            struct timespec ts;
> +            unsigned int prio;
> +
> +            p = lock_user(VERIFY_READ, arg2, arg3, 1);
> +            if (arg5 != 0) {
> +                if (target_to_host_timespec64(&ts, arg5)) {
> +                    return -TARGET_EFAULT;
> +                }
> +                ret = get_errno(safe_mq_timedreceive(arg1, p, arg3,
> +                                                     &prio, &ts));
> +                if (!is_error(ret) && host_to_target_timespec64(arg5, &ts)) {
> +                    return -TARGET_EFAULT;
> +                }
> +            } else {
> +                ret = get_errno(safe_mq_timedreceive(arg1, p, arg3,
> +                                                     &prio, NULL));
> +            }
> +            unlock_user(p, arg2, arg3);
> +            if (arg4 != 0) {
> +                put_user_u32(prio, arg4);
> +            }
> +        }
> +        return ret;
> +#endif
>  
>      /* Not implemented for now... */
>  /*     case TARGET_NR_mq_notify: */
> 

Applied to my linux-user-for-5.2 branch.

Thanks,
Laurent


