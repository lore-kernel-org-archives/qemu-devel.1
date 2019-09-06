Return-Path: <SRS0=KBml=XB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD9FBC43331
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 10:02:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A05442082C
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 10:02:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A05442082C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6B4F-0003wl-RJ
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 06:02:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42373)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1i6B2M-00037V-Ei
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 06:00:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1i6B2L-0007c9-7v
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 06:00:14 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:38201)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1i6B2K-0007af-VF
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 06:00:13 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue106 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MQMi7-1hkXZb0Rn7-00MMwE; Fri, 06 Sep 2019 11:59:46 +0200
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
References: <1567601968-26946-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1567601968-26946-2-git-send-email-aleksandar.markovic@rt-rk.com>
From: Laurent Vivier <laurent@vivier.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <508092d0-bd8e-59b2-1707-765c2db36539@vivier.eu>
Date: Fri, 6 Sep 2019 11:59:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1567601968-26946-2-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:hXb5rbs1lr8DRGS1HE/hcZNZZeYHAuMENgiSMIUz62jKU0v+FZB
 UT5Qk8pLFoF7ZDIG3a/s8Eq29Umd5cyRS3BD+HW7iRzEYmOoTVQm2gUS6iceFyzmc6GH/ia
 9KqoVvYIDba1XvWEBNF6e2P+NwbsZOoKICQY9YNEk1snkAuD4nbS3Us9JIMs9wJDKpqJH4/
 pE7wNPDJ+N9fcHf3dyXKg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7hA8jVGHFzI=:4v5ZH26DS24ccxPTNfkjC4
 5TdX+Ws/A1zspS+yeofghKGXAUs8TbUczeRF4it3F/VkKcEVdHabb4WHh1GkaFURLp/2b2CYh
 okHX1tESx4J/dt/OalwC4owb6q2QD1AJRcxl/vSvrLz2RdUs4T+KttMFPUekKKwHlXMhZcRcM
 Y1xQK+CODPWJWCklHxjxj0ZeMQkNw4LvWxyC8BaR//zJhRQZel3wl/HxZfk7wYu5nFmZkcWZQ
 giN2Ke6uRA9FcGMkRBulD+hfbFepFDXTto3JcPuglqMbcDGIiLvVv3jJkEzhOOJIeO0hQ0hsb
 dvmDAFzX5h6gRdTKgkcLP1Na7XeLwqi8KhSHu0JDQ/CQlW5syR65Hw8nyBEF2FxRQCoRcrxOH
 vjrCvw+jGZPxzykVIk6MxxCD6BD/EtgoH5qjxDV4xDGehbJemPGAGUPYXBRaIW6WSj4eDia+d
 IGluTMg4HctSLO79glcrh1vkf4GNpCP1MhL/WweiT29KxqbY+Nvm+o6IRBa5sgLpDdoBLGCLW
 NZJEXlM9ebFS+KjWYtZYlhlUbA6YAxhQaZqIm9w2Gc99jgVLTsAV5X128lcrhpyAZ2Atgd6HD
 U37GwPso7ssmP6RrrhWAldHQAVKvD9zIwjDwse9iV++Js7h6YUsu1H8mQjlAqkuoCDI5oib8G
 hTbbEE6BC9ksF+hUVgKLmNan78srf79oBH5k3blJPMPzOw+6IyH7tD7O9URgZogC+N8+xMZXf
 lJPOYBPGCXxDmGrUl9znyNnBumzUeoj+f4Z6/z6N0iQL/eE9PVt/kHz8ycSoQezM3CmEkP6NS
 vHHdHuvry4x4IWCgXmR8rfZGR6k+XSf04b3ySHPHLB8VABMFEw=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.10
Subject: Re: [Qemu-devel] [PATCH v6 1/8] linux-user: Add support for
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
Cc: riku.voipio@iki.fi, amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 04/09/2019 à 14:59, Aleksandar Markovic a écrit :
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
>  linux-user/syscall.c | 40 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 8367cb1..b5bc6e4 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -6649,7 +6649,43 @@ static inline abi_long host_to_target_statx(struct target_statx *host_stx,
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
> +#ifdef __NR_semtimedop
> +    ret = get_errno(safe_semtimedop(semid, sops, nsops, pts));
> +#else
> +    ret = -TARGET_ENOSYS;
> +#endif

You can do like in do_semop():

    ret = -TARGET_ENOSYS;
#ifdef __NR_semtimedop
    ret = get_errno(safe_semtimedop(semid, sops, nsops, pts));
#endif
#ifdef __NR_ipc
    if (ret == -TARGET_ENOSYS) {
        ret = get_errno(safe_ipc(IPCOP_semtimedop, semid, nsops, 0, sops, pts));
    }
#endif

> +    g_free(sops);
> +
> +    return ret;
> +}
> +#endif

The you can remove do_semop() and replace it:

    case IPCOP_semop:
        ret = do_semtimedop(first, ptr, second, NULL);
        break;

and

#ifdef TARGET_NR_semop
    case TARGET_NR_semop:
        return do_semtimedop(arg1, arg2, arg3, NULL);
#endif

you can also add in do_ipc():

    case IPCOP_semtimedop
        ret = do_semtimedop( ... );
        break;

>  
>  /* ??? Using host futex calls even when target atomic operations
>     are not really atomic probably breaks things.  However implementing
> @@ -9193,6 +9229,10 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
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

Thanks,
Laurent

