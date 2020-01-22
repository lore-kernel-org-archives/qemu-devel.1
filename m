Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49E37C2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 14:05:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F5E72465A
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 14:05:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F5E72465A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42598 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuGdI-0007Ij-6I
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 09:05:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56834)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iuGcY-0006q2-Q0
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 09:04:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iuGcX-0004XV-MZ
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 09:04:38 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:41353)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iuGcX-0004X1-DV
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 09:04:37 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue108 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1Mwwm5-1jo9EM3gU7-00yNAX; Wed, 22 Jan 2020 15:04:22 +0100
Subject: Re: [PATCH 01/12] linux-user: Add support for FS_IOC_<GET|SET>VERSION
 ioctls
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
References: <1579214991-19602-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1579214991-19602-2-git-send-email-aleksandar.markovic@rt-rk.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <7cb21df7-95cd-f872-a8da-2f91ecb645d8@vivier.eu>
Date: Wed, 22 Jan 2020 15:04:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <1579214991-19602-2-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:0iJLtmaH0T2NGr9aWFhxqz6gCfi1zTK6pCJTrxD9w+MD71DoeOT
 SwAD109i0JG0HHnTQ2CK4zKRSysEyFZq1CKzJ7jdyrId3N3UUl7QtPWWz6jFzU0g0JEIcNq
 Ac62rytENJsJsmV1nA3BPIyHs3v8Y0O9R8NlK5K+Y94uW7Zxmywun6slcICLMmUopsk2LB/
 W6xAG7GrgOlXArAoNByxw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hagRY2saSmM=:sBWVL2RwpCgPFpz7K8CBN0
 hx7aj1thAGDSkKgqZKIiaPYVG+qzw1LcTl44hjWQ5tpoQk/NIvsdat3uqeAo3jVg5IE/SZuAM
 aPMOOzYAwkTJFrV+mSjiQ47gIQUbnxkPBzEuzmPnKof0M5cOeUP9JH1+gds8JQyCtNvN/eBT/
 ScAZOCarEJAJniC6JUGGgVrhWOiKmTJfX1WNNC6AUIp5c1hxCfCm12gFOdsab3WHCowQre+jF
 7jofLk2wIwl4tiGcIMRNcMxj2VHeA2asHO+8VBC7Meu+ENZtqe06fRUr8wFM3johx9bc0YN0z
 DkaZBeBw3hUY6WhfXtdOrdfmerInFGNQ5z8P/33wMr+DTY9QXLrWgBB3iAPzeTvkUYWqfPdT6
 j/HYQwHKTEAHgk6OAf5MM3QQ4X3slpaHCsHSI05pZD2x2vjmvgAczF7OiYP6ta3B9oNLDCdEg
 IkampSHEKJl7RrG5zyLBefOBKccZ20STjoDGEWGs6ab3njO1ar+WXRtuwbcIfyKGU0GIyvCMW
 rnp0Z2YwHpPRJpKLeX4RYROW24A9phbgPYTmv9p+J7kEz1Hq/skJVbD11N+dX1O09vvIqP3nX
 DFTbLaU8mbweG7/yhVf9mXadVx4MwGw6EW6LZenWzAenLQHHEDkvkglnCnCzVE+bjQLCryULA
 zhGzbRf0WkVdBuVz545VHnlK7DY6pOhB+Wc8cVoIfxPvEjrlJJZeIxWSKfnD+nAEkuHw3JvcS
 0W7CRUMLlBLFtpl6eq0w7MlDamLY1HkJlMUk0+UMdzKKAC9UgIqGS8rmwwCb2jEumJh3nx52L
 fMWvXfevAz7+vK+8J+ObVeH4zlFEai5RQiqMO5i9RYlVHqQxss=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 217.72.192.74
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
Cc: amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 16/01/2020 à 23:49, Aleksandar Markovic a écrit :
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
> 
> A very specific thing for these two ioctls is that their code
> implies that their third argument is of type 'long', but the
> kernel uses that argument as if it is of type 'int'. This anomaly
> is recognized also in commit 6080723 (linux-user: Implement
> FS_IOC_GETFLAGS and FS_IOC_SETFLAGS ioctls).
> 
> Reviewed-by: Laurent Vivier <laurent@vivier.eu>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---
>  linux-user/ioctls.h       | 2 ++
>  linux-user/syscall_defs.h | 8 +++++---
>  2 files changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
> index c6b9d6a..c44f42e 100644
> --- a/linux-user/ioctls.h
> +++ b/linux-user/ioctls.h
> @@ -138,6 +138,8 @@
>  
>       IOCTL(FS_IOC_GETFLAGS, IOC_R, MK_PTR(TYPE_INT))
>       IOCTL(FS_IOC_SETFLAGS, IOC_W, MK_PTR(TYPE_INT))
> +     IOCTL(FS_IOC_GETVERSION, IOC_R, MK_PTR(TYPE_INT))
> +     IOCTL(FS_IOC_SETVERSION, IOC_W, MK_PTR(TYPE_INT))
>  
>  #ifdef CONFIG_USBFS
>    /* USB ioctls */
> diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
> index 98c2119..f68a8b6 100644
> --- a/linux-user/syscall_defs.h
> +++ b/linux-user/syscall_defs.h
> @@ -911,12 +911,14 @@ struct target_pollfd {
>  #define TARGET_FICLONE    TARGET_IOW(0x94, 9, int)
>  #define TARGET_FICLONERANGE TARGET_IOW(0x94, 13, struct file_clone_range)
>  
> -/* Note that the ioctl numbers claim type "long" but the actual type
> - * used by the kernel is "int".
> +/*
> + * Note that the ioctl numbers for FS_IOC_<GET|SET><FLAGS|VERSION>
> + * claim type "long" but the actual type used by the kernel is "int".
>   */
>  #define TARGET_FS_IOC_GETFLAGS TARGET_IOR('f', 1, abi_long)
>  #define TARGET_FS_IOC_SETFLAGS TARGET_IOW('f', 2, abi_long)
> -
> +#define TARGET_FS_IOC_GETVERSION TARGET_IOR('v', 1, abi_long)
> +#define TARGET_FS_IOC_SETVERSION TARGET_IOW('v', 2, abi_long)
>  #define TARGET_FS_IOC_FIEMAP TARGET_IOWR('f',11,struct fiemap)
>  
>  /* usb ioctls */
> 

Applied to my linux-user branch.

Thanks,
Laurent

