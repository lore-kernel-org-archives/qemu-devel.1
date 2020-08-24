Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BA73C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 17:21:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3174C20738
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 17:21:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3174C20738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAGAB-0004cx-FG
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 13:21:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41308)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kAG9N-0004Au-U1
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 13:20:53 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:58597)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kAG9L-00063f-OC
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 13:20:53 -0400
Received: from [192.168.100.1] ([82.252.135.186]) by mrelayeu.kundenserver.de
 (mreue011 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1Mati7-1kkhYf0WOx-00cURv; Mon, 24 Aug 2020 19:20:42 +0200
To: Filip Bozuta <Filip.Bozuta@syrmia.com>, qemu-devel@nongnu.org
References: <20200812135703.39404-1-Filip.Bozuta@syrmia.com>
 <20200812135703.39404-3-Filip.Bozuta@syrmia.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Subject: Re: [PATCH 2/2] linux-user: Add support for 'utimensat_time64()' and
 'semtimedop_time64()'
Message-ID: <09ef09fe-dd22-4b54-95a9-52f300b8eb4a@vivier.eu>
Date: Mon, 24 Aug 2020 19:20:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200812135703.39404-3-Filip.Bozuta@syrmia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:q23KCc7++VIKqgmsf/uLwKyVAs70IA8Y81LEN+AxpN/+MaMbpcH
 k1lLmyDXuC5BA5GIG8boFQAF01gJ3WM0PNflfLHYTdsP4nMqVSfCkpIwzpQYTep371kAVJ9
 zwNInOlmGENULRb++4q3esbYmV+04/EjZtX/cbnuVOOZD3Yio6dLDVrbLpitNm1CRoR/6Ok
 TLa3r3cCLVJu07PkaFIew==
X-UI-Out-Filterresults: notjunk:1;V03:K0:k+S5mrr6tSQ=:+3SRqYL7idOafcZ1+Jn2pk
 P+GC9TOqltXgMxdeynUbKoshNHFJPSfp31HxlNnntVAgb06nNQX/UsZUv2deloTWRMLxiOv+A
 DMcXWhDFHv8VBfs5KmaCf6NfMh5k0rr0Gf3CCxH5s+ZzrQEgnwGl3GB6A/UzTLg5qEEyZR+Y+
 2Qv4erQyzI7Z5vepECtjAG6EndhSFUcUkn8eBbU1qxMUK2cGSVWSbSS8MXHmd/ObMTji5vV4j
 MWBaio5Ghe9nVT6DpFmhE1xLiisW4v40tqk0a8WJ17jlnxt4ThtK0QZRcGpHc0yvLMZElFNmp
 vvlc5jXd8jzH2NzLBkdoHQ1ZYZVYf6tcJBIDIGkJVVHmSirgl9NikbTg71rmZzRY9jGW3HPSR
 BK78uYRSF9GqRvbYEXwsF1eaoEekG/YF/+6paStmuYLGOiEmGlESDbS5pBAVjt9jrII6kDETm
 oBB24DYwNxKBwgni3jVu4RR+Puc40PhRAot3YakmD3hb180DlHrI33+v+DkE2AKz+yFGxI5gt
 Ah+dib6ar+z3sJSZbedZepwugI4BEAoDBE5XcQv4+pbgHXOLUGrHTQZ7owCbAsz9Xe30BCEZh
 fkRpE5oJznc1jB7nIa0jt9a7as4wLWNSDYhSUyx88pbW7UvcEIw84Sc2ayQc85IPtuivSraod
 qwdNqzpyZJSaxnBpg+5QnnmtUcQ0IHpYQ9DoMtWfPwJsOLKFSW7IvH5JlNIDjB/fzztCVSqSO
 qZHD3C3UNARUMor1L9MJMBllye+nsPi3zLsXD3L8MMda3SSF91F9XGLI876YvYiOAcWuX/zYP
 202xN96z966sgdCe7ipfj9LeaK3nNjQfQSAskdBrPB+0iwka+5F8kvpjWCDzSehfyMOhCD/
Received-SPF: none client-ip=212.227.126.187; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/24 12:40:59
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

Le 12/08/2020 à 15:57, Filip Bozuta a écrit :
> This patch introduces functionality for following time64 syscalls:
> 
> *utimensat_time64()
> 
>     int utimensat(int dirfd, const char *pathname,
>                   const struct timespec times[2], int flags);
>     -- change file timestamps with nanosecond precision --
>     man page: https://man7.org/linux/man-pages/man2/utimensat.2.html
> 
> *semtimedop_time64()
> 
>     int semtimedop(int semid, struct sembuf *sops, size_t nsops,
>                    const struct timespec *timeout);
>     -- System V semaphore operations --
>     man page: https://www.man7.org/linux/man-pages/man2/semtimedop.2.html
> 
> Implementation notes:
> 
>    Syscall 'utimensat_time64()' is implemented in similar way as its
>    regular variants only difference being that time64 converting function
>    is used to convert values of 'struct timespec' between host and target
>    ('target_to_host_timespec64()').
> 
>    For syscall 'semtimedop_time64()' and additional argument is added
>    in function 'do_semtimedop()' through which the aproppriate 'struct timespec'
>    converting function is called (0 for regular target_to_host_timespec()
>    and anything else for target_to_host_timespec64()). For 'do_ipc()' an
>    check was added as that additional argument: 'TARGET_ABI_BITS == 64'.
> 
> Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
> ---
>  linux-user/syscall.c | 55 ++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 46 insertions(+), 9 deletions(-)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 8f63a46f58..44a13c5ec2 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -1253,7 +1253,8 @@ static inline abi_long target_to_host_timespec(struct timespec *host_ts,
>  #endif
>  
>  #if defined(TARGET_NR_clock_settime64) || defined(TARGET_NR_futex_time64) || \
> -    defined(TARGET_NR_pselect6_time64) || defined(TARGET_NR_ppoll_time64)
> +    defined(TARGET_NR_pselect6_time64) || defined(TARGET_NR_ppoll_time64) || \
> +    defined(TARGET_NR_utimensat_time64) || defined(TARGET_NR_semtimedop_time64)
>  static inline abi_long target_to_host_timespec64(struct timespec *host_ts,
>                                                   abi_ulong target_addr)
>  {
> @@ -3886,7 +3887,7 @@ static inline abi_long target_to_host_sembuf(struct sembuf *host_sembuf,
>  }
>  
>  #if defined(TARGET_NR_ipc) || defined(TARGET_NR_semop) || \
> -    defined(TARGET_NR_semtimedop)
> +    defined(TARGET_NR_semtimedop) || defined(TARGET_NR_semtimedop_time64)
>  
>  /*
>   * This macro is required to handle the s390 variants, which passes the
> @@ -3903,7 +3904,7 @@ static inline abi_long target_to_host_sembuf(struct sembuf *host_sembuf,
>  static inline abi_long do_semtimedop(int semid,
>                                       abi_long ptr,
>                                       unsigned nsops,
> -                                     abi_long timeout)
> +                                     abi_long timeout, int time64)

"bool time64" would be cleaner

>  {
>      struct sembuf sops[nsops];
>      struct timespec ts, *pts = NULL;
> @@ -3911,7 +3912,10 @@ static inline abi_long do_semtimedop(int semid,
>  
>      if (timeout) {
>          pts = &ts;
> -        if (target_to_host_timespec(pts, timeout)) {
> +        if (!time64 && target_to_host_timespec(pts, timeout)) {
> +            return -TARGET_EFAULT;
> +        }
> +        if (time64 && target_to_host_timespec64(pts, timeout)) {
>              return -TARGET_EFAULT;
>          }

why not:

    if (time64) {
        if (target_to_host_timespec64(pts, timeout)) {
            return -TARGET_EFAULT;
        }
    } else {
        if (target_to_host_timespec(pts, timeout)) {
              return -TARGET_EFAULT;
        }
    }

I think it's clearer.

With that fixed:

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

