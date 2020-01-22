Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACA0EC2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 14:08:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80AA92467C
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 14:08:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80AA92467C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuGfz-0001H0-EQ
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 09:08:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57081)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iuGfG-0000Wi-1o
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 09:07:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iuGfE-0006Mc-VY
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 09:07:25 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:48057)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iuGfE-0006Lz-Mb
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 09:07:24 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue108 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MG9Xu-1ion1U2yQG-00GcNu; Wed, 22 Jan 2020 15:07:08 +0100
Subject: Re: [PATCH 03/12] linux-user: Add support for
 FS_IOC32_<GET|SET>VERSION ioctls
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
References: <1579214991-19602-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1579214991-19602-4-git-send-email-aleksandar.markovic@rt-rk.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <86937f48-7e08-684d-0c8f-2fb2fd4e3822@vivier.eu>
Date: Wed, 22 Jan 2020 15:07:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <1579214991-19602-4-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:3H7YCGUzsw+dFK501PgVgYDwAyERiq1d/Ng6ITJ78gH0kDXKNX3
 kXC+Ex71g6cLRbkfbeUIDz2gcIiKPjdndOzqj49CAHdVq6cIFhILUUEPAQRrln+lhqEp4JR
 lswDL8QVHb8Qb2a8it0hD6SZGmSfOKP4DYAKolE7HWPrUeXkaqo7y/MA7V9kZpGfYhotDpt
 Tffed6s/gsA5PQ9oETTjQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:j4NixjbIsN8=:+lWs7EL0DlAHze+f1SR5vg
 R5uJAR6/zy36uFBQw0YE2UvpHoCH9WCweYgsEXfGRAIoV/SVUIA7MrBVJ6zH/weE9/K7+drdZ
 Ivg0KYmKjHnpBv6uL9dSUGxQCEsC0aL3oDyc0GkOcWqUWFxIFYVWAR7V5fhE0h7u/cN5yqNEN
 kwmU79qSwN8N07/7Rl8cJtMI+5weNbM9ZP4FOFdvVX+YHoaNFOATfjhbJb2XlBZwrUTBw8vZA
 m8gT+5t2m5sbr/9i2oTSMztNyGcRXD2NbbqWq0oB1KwO+TVoVnXUcHPsi9PnIYJnGCEO11Hjs
 K69AJewDEoIYn4NnsVNhMM1YzKOxPfnrvIVxCq7XM3ttA6RB6+b5kujzYO6qx9Cyh30jJ4AYj
 TePXxLltkNs2f5VpM0mdCom97DjXFntUYfyqx1nO9ijxzx1zJ+1WGjxYFghfpEARCLAvOP0+7
 s1gK5LVPvSTKqKCSoPRFlNgYU3OrrWxfz6NMQ4sdmnBDzYH4iMsgxU2fw+Sn35gqLiaz3JKdG
 PfRLh9jIks8EASOHsGyYbemMwTrdWZGCb1yx+J0VyMxZzgNJijuBZMW5ouaOw8M/+qm+af/nD
 dPkl+4P+MbkKJaIdHBVoj7+gDOYYfoA54owpD/k/d/0dxV256I8MsTfkDkCBFGm6+PtXir+w8
 TW75L+9XPmGw9xDJLsEvQZ8gBH13TBvM6plOxP7k+JWmVZMmSH60Ev7WkNA6nixtY4mMQWR1z
 fSjijQLg0QDqfsvb4s7uHvaucUKMObhOC5Rn833ElkFj/THwoGxPe8n4XRnT1buzbutGgZUnJ
 eWV1+14Se4CtFVIg1ACs5fxguNp9taY6cx2YzvM1nmc37qtVz0=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 217.72.192.73
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
> These FS_IOC32_<GET|SET>VERSION ioctls are identical to
> FS_IOC_<GET|SET>VERSION ioctls, but without the anomaly of their
> number defined as if their third argument is of type long, while
> it is treated internally in kernel as is of type int.
> 
> Reviewed-by: Laurent Vivier <laurent@vivier.eu>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---
>  linux-user/ioctls.h       | 2 ++
>  linux-user/syscall_defs.h | 2 ++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
> index 4fd6939..3affd88 100644
> --- a/linux-user/ioctls.h
> +++ b/linux-user/ioctls.h
> @@ -142,6 +142,8 @@
>       IOCTL(FS_IOC_SETVERSION, IOC_W, MK_PTR(TYPE_INT))
>       IOCTL(FS_IOC32_GETFLAGS, IOC_R, MK_PTR(TYPE_INT))
>       IOCTL(FS_IOC32_SETFLAGS, IOC_W, MK_PTR(TYPE_INT))
> +     IOCTL(FS_IOC32_GETVERSION, IOC_R, MK_PTR(TYPE_INT))
> +     IOCTL(FS_IOC32_SETVERSION, IOC_W, MK_PTR(TYPE_INT))
>  
>  #ifdef CONFIG_USBFS
>    /* USB ioctls */
> diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
> index 964b2b4..a73cc3d 100644
> --- a/linux-user/syscall_defs.h
> +++ b/linux-user/syscall_defs.h
> @@ -922,6 +922,8 @@ struct target_pollfd {
>  #define TARGET_FS_IOC_FIEMAP TARGET_IOWR('f',11,struct fiemap)
>  #define TARGET_FS_IOC32_GETFLAGS TARGET_IOR('f', 1, int)
>  #define TARGET_FS_IOC32_SETFLAGS TARGET_IOW('f', 2, int)
> +#define TARGET_FS_IOC32_GETVERSION TARGET_IOR('v', 1, int)
> +#define TARGET_FS_IOC32_SETVERSION TARGET_IOW('v', 2, int)
>  
>  /* usb ioctls */
>  #define TARGET_USBDEVFS_CONTROL TARGET_IOWRU('U', 0)
> 

Applied to my linux-user branch.

Thanks,
Laurent

