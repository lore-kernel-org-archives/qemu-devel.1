Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 171B4C433FF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 13:29:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1890206E0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 13:29:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1890206E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hs5iR-0008AK-6A
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 09:29:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43438)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <laurent@vivier.eu>) id 1hs5i1-0007lZ-Em
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 09:29:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1hs5i0-0008GD-CH
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 09:29:01 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:45891)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hs5i0-0008Et-3e
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 09:29:00 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue107 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1N3KDM-1iZIdd067O-010Jnm; Mon, 29 Jul 2019 15:28:43 +0200
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
References: <1564405791-9147-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1564405791-9147-8-git-send-email-aleksandar.markovic@rt-rk.com>
From: Laurent Vivier <laurent@vivier.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <8037526d-a8c3-bea4-2733-48ed82178c98@vivier.eu>
Date: Mon, 29 Jul 2019 15:28:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1564405791-9147-8-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:iUmmdtly50l6M/STnKUZDOoQyZkIY7y642rEpO04f+CC5H2c6+3
 gFkcO/eV3XlbM2gojiGLzvqSYTQt2G9Y+myebFZo4WH3RE5fM6sKQPeyIUNdXGTyanzC76n
 jt81BA7cqrCRW5BGo9GXdkjCF5CfJe2XEqyaJ79FHrKCTbifM2timmoMeNZoaInDa5pDONo
 ldf7DMWie5P6LuKWZdWUA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mTfj+ZOkDOk=:/lQLSY2gkHJG/F4AhK0qF+
 ocDOJGm7b/xqfA48mGYm9cUJbvndtcNcoVQIcVZSP++emd70ZfQ8swVfowftQ4gwz0Wl5U/AG
 EY/5xYp3VlO34clvwjvfl2YVhGha0McPE/R4m9i6riHrq9nje8Ukn7BBnDd6gd1iBXg1el0Dj
 Vdr2aZqkg0y6T97Ai1+vwb1K1L7sN8wGgAPav6dPaYetQIrSn4v6vIpr7TTgOz7lOYaa6InEf
 7Lqx+PD3dMvv6hN4ngEkBYNTeoYBJYkOG848C38YToVmk4BYP92knloq2LDkqzRgIIDLrx1pd
 ckjlbYRx9NizyanrkG+7pTvjYMtEh8Bx3vwSonpTdM0do+9HWZFDtHEKv1XCC44y79ukI416E
 gPNPJQ6GNSq+wQZsJyozf4bCnAipP7jBln8FtvdC8EU7WjnOdu1JegJIBxTEBpDTfGQlOwx7J
 pMvP5ZnZQ4AlA6V3sEmeLUPvL6oCsv8U+V8Wv6RwB52vWn0Nq5IMDwDkAfTI8giE7S0OT7mYe
 V8IHul+SAWHfmjQzpcKYc/uqUkvHdcoSbGVPfnSmwf+PpDbl4+k7LiTRL/LCyZeaPlNgRkAQA
 6N+KIM0vTlISF6cYWg5sRDOqA5u9SfnBhES5gUJBdNvTnqgwPCqjD+Mz8TINj58RDmvy5nT+U
 tNVZfwtaWqGjbNiEXHu3p0Uc9q7HCegg4Ap15BDRvwbV3pz5DqdwLbfnOQw6RWIm7G4WrCy8C
 raqXhWonzgWN7M/hMxEPKvcs77sDePHLu3IZHWFg3VrrSXtYoS1VxEnjCNs=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.75
Subject: Re: [Qemu-devel] [PATCH for 4.1 v2 7/7] linux-user: Add support for
 semtimedop() syscall
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
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>, amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 29/07/2019 à 15:09, Aleksandar Markovic a écrit :
> From: Aleksandar Rikalo <arikalo@wavecomp.com>
> 
> Add support for semtimedop() emulation. It is based on invocation
> of safe_semtimedop().
> 
> Conversion is left out of safe_semtimedop(), since other safe_xxx()
> usually don't contain similar conversions.
> 
> Signed-off-by: Aleksandar Rikalo <arikalo@wavecomp.com>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---
>  linux-user/syscall.c | 36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index ee80175..c7b08f5 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -6650,7 +6650,39 @@ static inline abi_long host_to_target_statx(struct target_statx *host_stx,
>      return 0;
>  }
>  #endif
> +#ifdef TARGET_NR_semtimedop
> +static inline abi_long do_semtimedop(int semid, abi_long ptr, unsigned nsops,
> +                                     abi_long timeout)
> +{
> +    struct sembuf *sops;
> +    struct timespec ts, *pts;
> +    abi_long ret;
> +
> +    if (timeout) {
> +        pts = &ts;
> +        if (target_to_host_timespec(pts, timeout)) {
> +            return -TARGET_EFAULT;
> +        }
> +    } else {
> +        pts = NULL;
> +    }
>  
> +    sops = g_malloc(sizeof(struct sembuf) * nsops);
> +    if (sops == NULL) {
> +        return -TARGET_EFAULT;
> +    }
> +
> +    if (target_to_host_sembuf(sops, ptr, nsops)) {
> +        g_free(sops);
> +        return -TARGET_EFAULT;
> +    }
> +
> +    ret = get_errno(safe_semtimedop(semid, sops, nsops, pts));
> +    g_free(sops);
> +
> +    return ret;
> +}
> +#endif

As we have a "#ifdef__NR_semtimedop" around the definition of
safe_semtimedop() you need the same #ifdef around its use:
perhaps you can update the existing do_semop() to implement do_semtimedop().

>  
>  /* ??? Using host futex calls even when target atomic operations
>     are not really atomic probably breaks things.  However implementing
> @@ -9194,6 +9226,10 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>      case TARGET_NR_semop:
>          return do_semop(arg1, arg2, arg3);
>  #endif
> +#ifdef TARGET_NR_semtimedop
> +    case TARGET_NR_semtimedop:
> +        return do_semtimedop(arg1, arg2, arg3, arg4);
> +#endif
>  #ifdef TARGET_NR_semctl
>      case TARGET_NR_semctl:
>          return do_semctl(arg1, arg2, arg3, arg4);
> 

You should also implement in do_ipc() the IPCOP_semtimedop operation.

Thanks,
Laurent

