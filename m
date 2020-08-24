Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A74EC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 20:36:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF78D204EA
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 20:36:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF78D204EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59300 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAJCs-0007ge-42
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 16:36:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59458)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kAJCE-0006qs-PD
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 16:36:02 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:33267)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kAJCC-0007aN-Ta
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 16:36:02 -0400
Received: from [192.168.100.1] ([82.252.135.186]) by mrelayeu.kundenserver.de
 (mreue012 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MQgtC-1jwdxq0rEU-00NhvR; Mon, 24 Aug 2020 22:35:56 +0200
Subject: Re: [PATCH v2] linux-user: syscall: ioctls: support
 DRM_IOCTL_I915_GETPARAM
To: chengang@emindsoft.com.cn
References: <20200802133938.12055-1-chengang@emindsoft.com.cn>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <21fbd5ab-1f1c-6b9a-c899-89af346e667e@vivier.eu>
Date: Mon, 24 Aug 2020 22:35:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200802133938.12055-1-chengang@emindsoft.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:5bQX7tP3Odu/O9oee1yjk3fx+NDJn5FHZq+BcS5fPlFG1U7AZzu
 g6rX1bU0L25fX6441tIWmLsmiynBY3VKfNdedSD+WC1dnu2tAC24iyYibAWBhqC5Lf15ay6
 BRI3IWUT4OMOfbPkp5Zxz2CSyl5V+VXZw83UrEDv3HsvRT/bJ+CRamnGuqEWnb9o427XnTo
 2UMOcZMz44cKy9RTjJr2Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8HBp8YIbW40=:H2ASjisGztV00BEUrJxEeI
 fhlOSmoebU+fmNqRt3OsEGNV6Wmkbc/OsVZxEPh8iBbzMLHwkyJRqlRXwbaXmoEo/HVQx9Ana
 GwRrikNutJBmnDeRtKDXZ49uIu+R5tv8iMuoXzb1infHNZcVci0QYfVyiB3k1x58KOAnOFBxt
 E7faM5QqaHjZ0NWCkUczECL4n2xLXMRT9f/UoVRh/F1N65zCI0+VCrqguZSZBFEJvsN5qrLUD
 F+71IvkzStgg92aUAgnq3zmTdmmcYMo4cGI5DWajGdri2CceG58RkIdXI1whsd6zjKm+iw7M9
 rX8GWQhCIgeUQb9F2IwWWCLJfWRrfmC02yyzo8ZYha577R0BYnbnVC1f7Ttefzb+/RJ0qtiO9
 0UcqdAdQje6e5Jv87wdkqXLDBzOhH1bOIiB0mQL7HKBgRItZByes+TRagE32SRlvTaRctNzYk
 /UPs6Cl+pkU4onoZ7/mQ3zv6MlISYdJkMOExlpKu38sxSZFkImTZ+MPE3owUf0DORfs76xAbF
 bocXBQ9xaQP31zJQeFq6Oa6QQHz48Ai53xi1uVfH9dG1LIV/idKCVibs3mddrU4DpGpKr4Skn
 6qmwmeAoKeZ7upTuHxCOLgnTspY2lUJ7XRx/k538rqXm2Or50TGILHmTVpTrvfwvHZQY2XsUo
 Q0HT719nVBLw+aGVx74awCM2oS1xrb6CLXaVfleCQnxOLM1UKQXcqRMWdU2xGuzqCLWzu5bNF
 wbFuwVPmd45JrEFTFCkNV2Os9sMzgq5qpB9GIjPaN8fZulloMNvFNuMd6NIAEZioHmJO8dvdk
 2hD0yb/RpdG6hrmDXqlkMAormCCTfO7nWp1DxMgo3xcvIm3ini7aYEwPRLT9JfVe9hcw6cK
Received-SPF: none client-ip=212.227.126.130; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/24 16:34:54
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 02/08/2020 à 15:39, chengang@emindsoft.com.cn a écrit :
> From: Chen Gang <chengang@emindsoft.com.cn>
> 
> Another DRM_IOCTL_I915 patches will be sent next.
> 
> Signed-off-by: Chen Gang <chengang@emindsoft.com.cn>
> ---
>  linux-user/ioctls.h        |  3 +++
>  linux-user/syscall.c       | 35 +++++++++++++++++++++++++++++++++++
>  linux-user/syscall_defs.h  |  8 ++++++++
>  linux-user/syscall_types.h |  4 ++++
>  4 files changed, 50 insertions(+)
> 
> diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
> index 0713ae1311..e2fc09b5a5 100644
> --- a/linux-user/ioctls.h
> +++ b/linux-user/ioctls.h
> @@ -581,6 +581,9 @@
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
> index 945fc25279..b0e15f373c 100644
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
> @@ -5413,6 +5414,40 @@ static abi_long do_ioctl_drm(const IOCTLEntry *ie, uint8_t *buf_temp,
>      return -TARGET_ENOSYS;
>  }
>  
> +static abi_long do_ioctl_drm_i915_getparam(const IOCTLEntry *ie,
> +                                           struct drm_i915_getparam *gparam,
> +                                           int fd, abi_long arg)
> +{
> +    abi_long ret;
> +    int value;
> +    struct target_drm_i915_getparam *target_gparam;
> +
> +    if (!lock_user_struct(VERIFY_READ, target_gparam, arg, 0)) {
> +        return -TARGET_EFAULT;
> +    }
> +
> +    __get_user(gparam->param, &target_gparam->param);
> +    gparam->value = &value;
> +    ret = get_errno(safe_ioctl(fd, ie->host_cmd, gparam));
> +    put_user_s32(value, target_gparam->value);
> +
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
> +
>  #endif
>  
>  IOCTLEntry ioctl_entries[] = {
> diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
> index 3c261cff0e..5a1692aa26 100644
> --- a/linux-user/syscall_defs.h
> +++ b/linux-user/syscall_defs.h
> @@ -1170,6 +1170,9 @@ struct target_rtc_pll_info {
>  /* drm ioctls */
>  #define TARGET_DRM_IOCTL_VERSION      TARGET_IOWRU('d', 0x00)
>  
> +/* drm i915 ioctls */
> +#define TARGET_DRM_IOCTL_I915_GETPARAM              TARGET_IOWRU('d', 0x46)
> +
>  /* from asm/termbits.h */
>  
>  #define TARGET_NCC 8
> @@ -2613,6 +2616,11 @@ struct target_drm_version {
>      abi_ulong desc;
>  };
>  
> +struct target_drm_i915_getparam {
> +    int param;
> +    abi_ulong value;
> +};
> +
>  #include "socket.h"
>  
>  #include "errno_defs.h"
> diff --git a/linux-user/syscall_types.h b/linux-user/syscall_types.h
> index 3f1f033464..12bf3484e2 100644
> --- a/linux-user/syscall_types.h
> +++ b/linux-user/syscall_types.h
> @@ -325,6 +325,10 @@ STRUCT(drm_version,
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


Applied to my linux-user-for-5.2 branch.

Thanks,
Laurent


