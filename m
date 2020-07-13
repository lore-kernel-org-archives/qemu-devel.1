Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1E71C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 18:47:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 768F52065D
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 18:47:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 768F52065D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52814 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jv3UD-00021D-Lf
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 14:47:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50936)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jv3TX-0001BE-D9
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 14:46:51 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:44179)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jv3TV-00088z-Az
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 14:46:51 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue109 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MHoZM-1k7gXE2z5S-00Esef; Mon, 13 Jul 2020 20:46:34 +0200
To: chengang@emindsoft.com.cn, riku.voipio@iki.fi
References: <20200712034102.23355-1-chengang@emindsoft.com.cn>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Subject: Re: [PATCH] linux-user: syscall: ioctls: support
 DRM_IOCTL_I915_GETPARAM
Message-ID: <1e64eed1-509f-3b8d-112f-58c02794496a@vivier.eu>
Date: Mon, 13 Jul 2020 20:46:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200712034102.23355-1-chengang@emindsoft.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:YNhD+u6RhhgdowewujetvdWSRSoj4y6JDXD41OpWhpsb9rILh/r
 IDedYA6xX++xaHt43tmYw6YGwKhRqGNXc9j0NtcmdfOhDD+FvlFFfLQejvZ9+n1GnpUXTyk
 oxbieI2d0ptkt7lPLWvAw/S+zd09AE4em7xarj0GFrjRnvhrILZnJYDVP989/I6WGZ9zVwR
 8ND9ORK/cgEZwCGjINvNQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:sfSWBUxS8TA=:86kr63sfjlsEl3g1Txyqpe
 Jl+AAhSfsNDrH0xdYvZIv03haG+4M63J04fPVgzhGpauyyaSOWVJkpK8mbzi4s9wsY7F1ezhU
 vTJdcfQsqOvVbfWYzIgl2cFbG+bo4LM8cTIku7Eij0d6bwP7Pd6ADPsMYIgof/VdM8LRtRxUh
 WLflz17I9kUIE9Q0UdVSrCO8uu5MM8HKp5eq28HT3mt5PoLtAG56qHKORTFTi0UBSCIs53gZY
 I6JZZ+BLUxtlBsLY76LyI7pVanqfWRtK6hK8QmSc3E7DgbEmq0w/nN6ZBGlRozLtCblIGUjDD
 YQTourXX7NChmL2giH4ny1tR7ZkKTw5fdrret7hInrtYIVdASlVeoO4O+Q8hs283Cz53SO2ZT
 tTlNLDHMkCg5Du7DEyeJuqBG1F/pxct8/pCeU5gQhjmi1qN/CgjxDYe8YIs1X1fMZapLA45KT
 Snek3JSovGJPcebM3hjxqh+D1RosRU2iuXG0G1zLE2mmD5cUHQLYqLZRhX5QcGikZmCotqLgJ
 hviBks72KTTHEqbNljPmQlvCoP/aOkqKaa42xs/USjeL+GAXqSmvkRuksjHvjrYcC+NQsVVqv
 amf+jkjA3D/XcGpHZYWLoiKs/H1hGh8Wk/yNCz29gsdMHR8v2v5e6tqPVeXbMd7nkHFSDn/A6
 nydGSZUfww1NzreJRY2ba7J5z+LF3gMAjUj6BWI2d0YX1pWfYX8b8cCcB69nS4nzqzduBblgL
 4dv5itGDqM6LQeFIjkSSiONweDRE4PXzXEDnrppjGPgiBQA8Uy4dbsDcmfCM2yVMSb5sLTcZg
 Ud6o+e+Lr7PSdRpgTfc2+BfJy7HTiDgjsGRGvdzuur8rzWD6ckx+ahwkmPKqs9tc21XsXjx
Received-SPF: none client-ip=217.72.192.75; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 14:46:47
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 12/07/2020 à 05:41, chengang@emindsoft.com.cn a écrit :
> From: Chen Gang <chengang@emindsoft.com.cn>
> 
> It is for i915 drm command, and next, I shall send another i915 commands
> implementations.
> 
> Signed-off-by: Chen Gang <chengang@emindsoft.com.cn>
> ---
>  linux-user/ioctls.h        |  3 +++
>  linux-user/syscall.c       | 39 ++++++++++++++++++++++++++++++++++++++
>  linux-user/syscall_defs.h  |  9 +++++++++
>  linux-user/syscall_types.h |  4 ++++
>  4 files changed, 55 insertions(+)
> 
> diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
> index f2e2fa9c87..83e045deba 100644
> --- a/linux-user/ioctls.h
> +++ b/linux-user/ioctls.h
> @@ -577,6 +577,9 @@
>  #ifdef HAVE_DRM_H
>    IOCTL_SPECIAL(DRM_IOCTL_VERSION, IOC_RW, do_ioctl_drm,
>                  MK_PTR(MK_STRUCT(STRUCT_drm_version)))
> +
> +  IOCTL_SPECIAL(DRM_IOCTL_I915_GETPARAM, IOC_RW, do_ioctl_drm_i915,
> +                MK_PTR(MK_STRUCT(STRUCT_drm_i915_getparam)))
>  #endif
>  
>  #ifdef TARGET_TIOCSTART
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 17ed7f8d6b..6fab9064af 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -114,6 +114,7 @@
>  #include <sound/asound.h>
>  #ifdef HAVE_DRM_H
>  #include <libdrm/drm.h>
> +#include <libdrm/i915_drm.h>
>  #endif
>  #include "linux_loop.h"
>  #include "uname.h"
> @@ -5372,6 +5373,44 @@ static abi_long do_ioctl_drm(const IOCTLEntry *ie, uint8_t *buf_temp,
>      return -TARGET_ENOSYS;
>  }
>  
> +static abi_long do_ioctl_drm_i915_getparam(const IOCTLEntry *ie,
> +                                           struct drm_i915_getparam *gparam,
> +                                           int fd, abi_long arg)
> +{
> +    abi_long ret;
> +    struct target_drm_i915_getparam *target_gparam;
> +
> +    if (!lock_user_struct(VERIFY_READ, target_gparam, arg, 0)) {
> +        return -TARGET_EFAULT;
> +    }
> +    __get_user(gparam->param, &target_gparam->param);
> +    gparam->value = lock_user(VERIFY_WRITE, target_gparam->value,
> +                             sizeof(*gparam->value), 0);

I don't think you should use directly the guest memory.
You should have something like that:

     int value;

     gparam->value = &value;

> +    if (!gparam->value) {
> +        unlock_user_struct(target_gparam, arg, 0);
> +        return -TARGET_EFAULT;
> +    }
> +
> +    ret = get_errno(safe_ioctl(fd, ie->host_cmd, gparam));

and then:

put_user_s32(value, target_gparam->value);

> +
> +    unlock_user(gparam->value, target_gparam->value, sizeof(*gparam->value));
> +    unlock_user_struct(target_gparam, arg, 0);
> +    return ret;
> +}
> +
> +static abi_long do_ioctl_drm_i915(const IOCTLEntry *ie, uint8_t *buf_temp,
> +                                  int fd, int cmd, abi_long arg)
> +{
> +    switch (ie->host_cmd) {
> +    case DRM_IOCTL_I915_GETPARAM:
> +        return do_ioctl_drm_i915_getparam(ie,
> +                                          (struct drm_i915_getparam *)buf_temp,
> +                                          fd, arg);
> +    default:
> +        return -TARGET_ENOSYS;
> +    }
> +}

There is a better way to register a struct with convertion functions:
you might use STRUCT_SPECIAL() to declare the structure rather than
IOCTL_SPECIAL() to declare the ioctl command.
(I think STRUCT_SPECIAL() could also be used with DRM_IOCTL_VERSION)

> +
>  #endif
>  
>  static IOCTLEntry ioctl_entries[] = {
> diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
> index 3c261cff0e..9082f6c2bc 100644
> --- a/linux-user/syscall_defs.h
> +++ b/linux-user/syscall_defs.h
> @@ -1170,6 +1170,9 @@ struct target_rtc_pll_info {
>  /* drm ioctls */
>  #define TARGET_DRM_IOCTL_VERSION      TARGET_IOWRU('d', 0x00)
>  
> +/* drm i915 ioctls */
> +#define TARGET_DRM_IOCTL_I915_GETPARAM              TARGET_IOWRU('d', 0x46)

why do you use the U variant?

TARGET_IOWR('d', 0x46, struct target_drm_i915_getparam)

> +
>  /* from asm/termbits.h */
>  
>  #define TARGET_NCC 8
> @@ -2613,6 +2616,12 @@ struct target_drm_version {
>      abi_ulong desc;
>  };
>  
> +struct target_drm_i915_getparam {
> +    int param;
> +    abi_ulong value;
> +};
> +
> +
>  #include "socket.h"
>  
>  #include "errno_defs.h"
> diff --git a/linux-user/syscall_types.h b/linux-user/syscall_types.h
> index e2b0484f50..ef60d5f38c 100644
> --- a/linux-user/syscall_types.h
> +++ b/linux-user/syscall_types.h
> @@ -303,6 +303,10 @@ STRUCT(drm_version,
>         TYPE_ULONG, /* desc_len */
>         TYPE_PTRVOID) /* desc */
>  
> +STRUCT(drm_i915_getparam,
> +       TYPE_INT, /* param */
> +       TYPE_PTRVOID) /* value */
> +
>  STRUCT(file_clone_range,
>         TYPE_LONGLONG, /* src_fd */
>         TYPE_ULONGLONG, /* src_offset */
> 

Thanks,
Laurent

