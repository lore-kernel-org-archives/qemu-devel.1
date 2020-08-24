Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E901C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 19:36:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB33A206BE
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 19:36:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB33A206BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAIGr-0002jK-78
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 15:36:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46720)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kAIFw-0002DV-Pi
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 15:35:48 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:38217)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kAIFu-0000Cb-9U
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 15:35:48 -0400
Received: from [192.168.100.1] ([82.252.135.186]) by mrelayeu.kundenserver.de
 (mreue011 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MmlGg-1kruD32Ngk-00jsKx; Mon, 24 Aug 2020 21:35:35 +0200
Subject: Re: [PATCH v3 1/2] linux-user: Add support for
 'clock_nanosleep_time64()' and 'clock_adjtime64()'
To: Filip Bozuta <Filip.Bozuta@syrmia.com>, qemu-devel@nongnu.org
References: <20200824192116.65562-1-Filip.Bozuta@syrmia.com>
 <20200824192116.65562-2-Filip.Bozuta@syrmia.com>
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
Message-ID: <23c02108-6a5d-c4c2-db84-912799a278c5@vivier.eu>
Date: Mon, 24 Aug 2020 21:35:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200824192116.65562-2-Filip.Bozuta@syrmia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:RSNOzfO1QNRY+lDaUr7HhCpD/9fDSpgDr2rdFYTsGe7a/UOyHxs
 uCuVYFDYiEM7/MEe1616jkevXcETtULgGqK8RSlBtq0x9MONEdOKJdQqGjyaWzS9rZpATCh
 tQtESz+W5rQoQ4DkjRe/MCow9Jk2m+RiguvQn4/r4B6PJSXKS9VzUUZ7DMxq1Ce2CnEJ891
 mE3PdduijCjUWvxBdUxSw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5/pgF5PK8/8=:miWyi7q0wQUST3BVfT0ysm
 jEAHKuRjaKl4lAjGPRoNMFbHC5aW9JcTjghc4kzE0LOb/asDJj/BMExe/J0+kiYUyvgkYr/4n
 CJt2h2sgQSyjcSz8rA9M4KYVwFAzJeVN+v6jWvxVK5qe+4ojlNdMYKL3VYwjyEjvrmwALk+ab
 QaRBCjvhNzSFjxGCT2vM/tgxnqng3fRtouFcTFyHHR4vurGgffPp6NwI8cGDOweFkxVd7B+du
 1pTV56AJN3+okRxsI7wFG4JrgRBi5vj7Q/WoYgPxUarRN2PzYL0nI+6ec5fciV62ZiqWUcnQc
 +Amuc8Zp6IoCuEf+M/hx96/wqk7IwmhwLw5a8fpApmYtOAIlGXDgV4gmCtskqVw6D460Ry4RI
 i91BmI2Tk44fGbT+/+i/g56LkA/kdycN+ha1cjNo1ZvBewro4YAwIuW+HqO8FPI+tJ0jM9xnF
 6WULf9GQW+s/qfb0XuYLO67hL2+gFeWpNWzMe3Jv7/V5VuTBIcY/VkJNljcEablGW8pfeHOd5
 OZ5mqsP8SvQyJvjE+vTM08QS7ZtOnk0TQo0Td1GMuBajxTl7XKEp+CoisyqOOh099CyFHHNoe
 iQVHH1aq36B0wTrq1gkDprA+w6qy/wIFfmKefo3Cfo5JpycqyHeve4kerJ0FWGGV+vNjhJtVa
 +iCEG7KbngL/bFwEDfbeXseRmZ55Us+fbqo2rm/HtPDC8HiXQsAsWWM2UBxQKxSziZxnZ3inm
 WLP1kI1ybLViROHGFTqdCBA3t2iBYcXrnAVef26FFiiwyYnFHGp3ZRWblhwuQT6kN8ZvtI/+S
 sjhE7u3CjDAKBVEiwLHVF9/j8JSauFzJu+9FWSpyh0zFvtQ7SA+L47NrY87pRQrkS05pZ/m
Received-SPF: none client-ip=212.227.126.134; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/24 15:35:44
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

Le 24/08/2020 à 21:21, Filip Bozuta a écrit :
> This patch implements functionality for following time64 syscall:
> 
> *clock_nanosleep_time64()
> 
>     This is a year 2038 safe vairant of syscall:
>     int clock_nanosleep(clockid_t clockid, int flags,
>                         const struct timespec *request,
>                         struct timespec *remain)
>     --high-resolution sleep with specifiable clock--
>     man page: https://man7.org/linux/man-pages/man2/clock_nanosleep.2.html
> 
> *clock_adjtime64()
> 
>     This is a year 2038 safe variant of syscall:
>     int clock_adjtime(clockid_t clk_id, struct timex *buf)
>     --tune kernel clock--
>     man page: https://man7.org/linux/man-pages/man2/clock_adjtime.2.html
> 
> Implementation notes:
> 
>     Syscall 'clock_nanosleep_time64()' was implemented similarly
>     to syscall 'clock_nanosleep()' except that 'host_to_target_timespec64()'
>     and 'target_to_host_timespec64()' were used instead of the regular
>     'host_to_target_timespec()' and 'target_to_host_timespec()'.
> 
>     For 'clock_adjtime64()' a 64-bit target kernel version of 'struct timex'
>     was defined in 'syscall_defs.h': 'struct target__kernel_timex'.
>     This type was used to convert the values of 64-bit timex type between
>     host and target. For this purpose a 64-bit timex converting functions
>     'target_to_host_timex64()' and 'host_to_target_timex64()'. An existing
>     function 'copy_to_user_timeval64()' was used to convert the field
>     'time' which if of type 'struct timeval' from host to target.
>     Function 'copy_from_user_timveal64()' was added in this patch and
>     used to convert the 'time' field from target to host.
> 
> Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
> ---
>  linux-user/syscall.c      | 137 +++++++++++++++++++++++++++++++++++++-
>  linux-user/syscall_defs.h |  31 +++++++++
>  2 files changed, 166 insertions(+), 2 deletions(-)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 05f03919ff..a359bd8620 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -809,7 +809,8 @@ safe_syscall4(int, accept4, int, fd, struct sockaddr *, addr, socklen_t *, len,
>  safe_syscall2(int, nanosleep, const struct timespec *, req,
>                struct timespec *, rem)
>  #endif
> -#ifdef TARGET_NR_clock_nanosleep
> +#if defined(TARGET_NR_clock_nanosleep) || \
> +    defined(TARGET_NR_clock_nanosleep_time64)
>  safe_syscall4(int, clock_nanosleep, const clockid_t, clock, int, flags,
>                const struct timespec *, req, struct timespec *, rem)
>  #endif
> @@ -1205,8 +1206,25 @@ static inline abi_long copy_to_user_timeval(abi_ulong target_tv_addr,
>      return 0;
>  }
>  
> +static inline abi_long copy_from_user_timeval64(struct timeval *tv,
> +                                                abi_ulong target_tv_addr)
> +{
> +    struct target__kernel_sock_timeval *target_tv;
> +
> +    if (!lock_user_struct(VERIFY_READ, target_tv, target_tv_addr, 1)) {
> +        return -TARGET_EFAULT;
> +    }
> +
> +    __get_user(tv->tv_sec, &target_tv->tv_sec);
> +    __get_user(tv->tv_usec, &target_tv->tv_usec);
> +
> +    unlock_user_struct(target_tv, target_tv_addr, 0);
> +
> +    return 0;
> +}
> +
>  static inline abi_long copy_to_user_timeval64(abi_ulong target_tv_addr,
> -                                             const struct timeval *tv)
> +                                              const struct timeval *tv)
>  {
>      struct target__kernel_sock_timeval *target_tv;
>  
> @@ -6771,6 +6789,87 @@ static inline abi_long host_to_target_timex(abi_long target_addr,
>  }
>  #endif
>  
> +
> +#if defined(TARGET_NR_clock_adjtime64) && defined(CONFIG_CLOCK_ADJTIME)
> +static inline abi_long target_to_host_timex64(struct timex *host_tx,
> +                                              abi_long target_addr)
> +{
> +    struct target__kernel_timex *target_tx;
> +
> +    if (copy_from_user_timeval64(&host_tx->time, target_addr +
> +                                 offsetof(struct target__kernel_timex,
> +                                          time))) {
> +        return -TARGET_EFAULT;
> +    }
> +
> +    if (!lock_user_struct(VERIFY_READ, target_tx, target_addr, 1)) {
> +        return -TARGET_EFAULT;
> +    }
> +
> +    __get_user(host_tx->modes, &target_tx->modes);
> +    __get_user(host_tx->offset, &target_tx->offset);
> +    __get_user(host_tx->freq, &target_tx->freq);
> +    __get_user(host_tx->maxerror, &target_tx->maxerror);
> +    __get_user(host_tx->esterror, &target_tx->esterror);
> +    __get_user(host_tx->status, &target_tx->status);
> +    __get_user(host_tx->constant, &target_tx->constant);
> +    __get_user(host_tx->precision, &target_tx->precision);
> +    __get_user(host_tx->tolerance, &target_tx->tolerance);
> +    __get_user(host_tx->tick, &target_tx->tick);
> +    __get_user(host_tx->ppsfreq, &target_tx->ppsfreq);
> +    __get_user(host_tx->jitter, &target_tx->jitter);
> +    __get_user(host_tx->shift, &target_tx->shift);
> +    __get_user(host_tx->stabil, &target_tx->stabil);
> +    __get_user(host_tx->jitcnt, &target_tx->jitcnt);
> +    __get_user(host_tx->calcnt, &target_tx->calcnt);
> +    __get_user(host_tx->errcnt, &target_tx->errcnt);
> +    __get_user(host_tx->stbcnt, &target_tx->stbcnt);
> +    __get_user(host_tx->tai, &target_tx->tai);
> +
> +    unlock_user_struct(target_tx, target_addr, 0);
> +    return 0;
> +}
> +
> +static inline abi_long host_to_target_timex64(abi_long target_addr,
> +                                              struct timex *host_tx)
> +{
> +    struct target__kernel_timex *target_tx;
> +
> +   if (copy_to_user_timeval64(target_addr +
> +                              offsetof(struct target__kernel_timex, time),
> +                              &host_tx->time)) {
> +        return -TARGET_EFAULT;
> +    }
> +
> +    if (!lock_user_struct(VERIFY_WRITE, target_tx, target_addr, 0)) {
> +        return -TARGET_EFAULT;
> +    }
> +
> +    __put_user(host_tx->modes, &target_tx->modes);
> +    __put_user(host_tx->offset, &target_tx->offset);
> +    __put_user(host_tx->freq, &target_tx->freq);
> +    __put_user(host_tx->maxerror, &target_tx->maxerror);
> +    __put_user(host_tx->esterror, &target_tx->esterror);
> +    __put_user(host_tx->status, &target_tx->status);
> +    __put_user(host_tx->constant, &target_tx->constant);
> +    __put_user(host_tx->precision, &target_tx->precision);
> +    __put_user(host_tx->tolerance, &target_tx->tolerance);
> +    __put_user(host_tx->tick, &target_tx->tick);
> +    __put_user(host_tx->ppsfreq, &target_tx->ppsfreq);
> +    __put_user(host_tx->jitter, &target_tx->jitter);
> +    __put_user(host_tx->shift, &target_tx->shift);
> +    __put_user(host_tx->stabil, &target_tx->stabil);
> +    __put_user(host_tx->jitcnt, &target_tx->jitcnt);
> +    __put_user(host_tx->calcnt, &target_tx->calcnt);
> +    __put_user(host_tx->errcnt, &target_tx->errcnt);
> +    __put_user(host_tx->stbcnt, &target_tx->stbcnt);
> +    __put_user(host_tx->tai, &target_tx->tai);
> +
> +    unlock_user_struct(target_tx, target_addr, 1);
> +    return 0;
> +}
> +#endif
> +
>  static inline abi_long target_to_host_sigevent(struct sigevent *host_sevp,
>                                                 abi_ulong target_addr)
>  {
> @@ -9726,6 +9825,21 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>              }
>          }
>          return ret;
> +#endif
> +#if defined(TARGET_NR_clock_adjtime64) && defined(CONFIG_CLOCK_ADJTIME)
> +    case TARGET_NR_clock_adjtime64:
> +        {
> +            struct timex htx;
> +
> +            if (target_to_host_timex64(&htx, arg2) != 0) {
> +                return -TARGET_EFAULT;
> +            }
> +            ret = get_errno(clock_adjtime(arg1, &htx));
> +            if (!is_error(ret) && host_to_target_timex64(arg2, &htx)) {
> +                    return -TARGET_EFAULT;
> +            }
> +        }
> +        return ret;
>  #endif
>      case TARGET_NR_getpgid:
>          return get_errno(getpgid(arg1));
> @@ -11684,6 +11798,25 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>          return ret;
>      }
>  #endif
> +#ifdef TARGET_NR_clock_nanosleep_time64
> +    case TARGET_NR_clock_nanosleep_time64:
> +    {
> +        struct timespec ts;
> +
> +        if (target_to_host_timespec64(&ts, arg3)) {
> +            return -TARGET_EFAULT;
> +        }
> +
> +        ret = get_errno(safe_clock_nanosleep(arg1, arg2,
> +                                             &ts, arg4 ? &ts : NULL));
> +
> +        if (ret == -TARGET_EINTR && arg4 && arg2 != TIMER_ABSTIME &&
> +            host_to_target_timespec64(arg4, &ts)) {
> +            return -TARGET_EFAULT;
> +        }
> +        return ret;
> +    }
> +#endif
>  
>  #if defined(TARGET_NR_set_tid_address) && defined(__NR_set_tid_address)
>      case TARGET_NR_set_tid_address:
> diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
> index 152ec637cb..3783c5a07e 100644
> --- a/linux-user/syscall_defs.h
> +++ b/linux-user/syscall_defs.h
> @@ -287,6 +287,37 @@ struct target_timex {
>      abi_int:32; abi_int:32; abi_int:32;
>  };
>  
> +struct target__kernel_timex {
> +    abi_uint modes;               /* Mode selector */
> +    abi_int: 32;                  /* pad */
> +    abi_llong offset;             /* Time offset */
> +    abi_llong freq;               /* Frequency offset */
> +    abi_llong maxerror;           /* Maximum error (microseconds) */
> +    abi_llong esterror;           /* Estimated error (microseconds) */
> +    abi_int status;               /* Clock command/status */
> +    abi_int: 32;                  /* pad */
> +    abi_llong constant;           /* PLL (phase-locked loop) time constant */
> +    abi_llong precision;          /* Clock precision (microseconds, ro) */
> +    abi_llong tolerance;          /* Clock freq. tolerance (ppm, ro) */
> +    struct target__kernel_sock_timeval time;  /* Current time */
> +    abi_llong tick;               /* Microseconds between clock ticks */
> +    abi_llong ppsfreq;            /* PPS (pulse per second) frequency */
> +    abi_llong jitter;             /* PPS jitter (ro); nanoseconds */
> +    abi_int shift;                /* PPS interval duration (seconds) */
> +    abi_int: 32;                  /* pad */
> +    abi_llong stabil;             /* PPS stability */
> +    abi_llong jitcnt;             /* PPS jitter limit exceeded (ro) */
> +    abi_llong calcnt;             /* PPS calibration intervals */
> +    abi_llong errcnt;             /* PPS calibration errors */
> +    abi_llong stbcnt;             /* PPS stability limit exceeded */
> +    abi_int tai;                  /* TAI offset */
> +
> +    /* Further padding bytes to allow for future expansion */
> +    abi_int:32; abi_int:32; abi_int:32; abi_int:32;
> +    abi_int:32; abi_int:32; abi_int:32; abi_int:32;
> +    abi_int:32; abi_int:32; abi_int:32;
> +};
> +
>  typedef abi_long target_clock_t;
>  
>  #define TARGET_HZ 100
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

