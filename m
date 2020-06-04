Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 286A6C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 09:12:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F07482074B
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 09:12:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F07482074B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jglvF-0008GV-8W
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 05:12:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53874)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jgltQ-00061r-1N
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 05:10:32 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:40169)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jgltO-00062k-DQ
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 05:10:31 -0400
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue108 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MAfMc-1jnKOA2L3g-00B0GU; Thu, 04 Jun 2020 11:10:18 +0200
To: chengang@emindsoft.com.cn, riku.voipio@iki.fi
References: <20200604014527.7795-1-chengang@emindsoft.com.cn>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Subject: Re: [PATCH] [PATCH v6] linux-user: syscall: ioctls: support
 DRM_IOCTL_VERSION
Message-ID: <30eeb463-42d8-5aaa-1741-1cc3bb885fdc@vivier.eu>
Date: Thu, 4 Jun 2020 11:10:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200604014527.7795-1-chengang@emindsoft.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:rem3equuguEm8+Cc9sYbNsPllUwU2lgZZ3qx+0R+pHidsQaEAN0
 MGZeYp0FtdW7g7hWW2bfgd4wVulo8QMveRHyhXKf7E54AZCz+Khz270hEXsZ0/sACP0No5m
 qsOkNwoULWlfs2ipfap3n/rEXyOGMJYAV4fLVIdd5F8K2EjtCGuWvgeHdcd/CKTobS7sNah
 2ur/wZyJ88MM5HQpecYEQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:IVqTkDo2nUQ=:b0oFP4TEcGT/YLjJCaiOfN
 tAJzKWVvSiPSdn741BHi4tLrXo7f2Cwj5anNuTWe12tiU3E8S+3mrstxYRGBjmG6dW9eDtqPL
 tn/cWxmkpjBnDXg7dRxJ2fVrIaItOkAS2nN8hPwz/7ssj0c40ivt2V3xj4H5WcS561u9IgpJ9
 sDR41JOR25MMMRL49UVtlqxMR+ZqDRvgAlakcH+PyI0M3PUxA7DEkap86vdOg+46djz8LVIca
 TrPtJga8iYoSKJiN2CGxN9dk5wAQYpZlPu0qOMowbluEV40orRLM/CmLFWB3BoMRl8mpATQSf
 eOnto51IQOBPtBbF2wuwfTB/CHEsm2foknDQRqc1XRAq4UNxtD5UDPwQ98mYjarC0sGNg9fgd
 nk8tgbj0fBuzr/6N3898mlKLnz9KZFtq54A6aS/7B14DxSSKzi9OLioKDxFbrCXOXs+0TC1K4
 X7LY4t2KZgs4bSb5cmvGZIJ01V4ceHqHDBWBkqwKv8mg3/z4F5PRuq/o26elP1l9KcMCmjmU0
 VnwNVAtIjTlTVYgm2wA5lBmgvAAv7+gt4IePkMQQxSk0dh5eDbUKo8Tey3S27QvzFvphI4GtS
 cUvZKIwPyX4ZhnFsIhQksKiSiBPu6QApu4urH4oxCGkDaizveNj+Co6/cDPkE6uIy+fSUN4xR
 qU5vy0SxhcTQAHj1sRi5XcYQBcrHbD5KGL0LOZQ7sj+F5dWltTRyHFlhsGgAQu2SWcdAvXlSq
 hTUkQPIb0utYPcIYO75CP6MpRF56Dq2DMOa7PRsGPDAD+CjsbhIcytIOlrdWwgDc3+P6UiuZs
 kjkbxtDySV5B5IPcuy7Wc2nFkfSJ5mSGp85+uAqqqSJG4j3UXCDadsPjbSRrZG71mRFC/uQ
Received-SPF: none client-ip=212.227.17.24; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 05:10:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

Le 04/06/2020 à 03:45, chengang@emindsoft.com.cn a écrit :
> From: Chen Gang <chengang@emindsoft.com.cn>
> 
> Another DRM_IOCTL_* commands will be done later.
> 
> Signed-off-by: Chen Gang <chengang@emindsoft.com.cn>
> ---
>  configure                  | 10 ++++
>  linux-user/ioctls.h        |  5 ++
>  linux-user/syscall.c       | 95 ++++++++++++++++++++++++++++++++++++++
>  linux-user/syscall_defs.h  | 15 ++++++
>  linux-user/syscall_types.h | 11 +++++
>  5 files changed, 136 insertions(+)
> 
> diff --git a/configure b/configure
> index f087d2bcd1..389dbb1d09 100755
> --- a/configure
> +++ b/configure
> @@ -3136,6 +3136,13 @@ if ! check_include "ifaddrs.h" ; then
>    have_ifaddrs_h=no
>  fi
>  
> +#########################################
> +# libdrm check
> +have_drm_h=no
> +if check_include "libdrm/drm.h" ; then
> +    have_drm_h=yes
> +fi
> +
>  ##########################################
>  # VTE probe
>  
> @@ -7127,6 +7134,9 @@ fi
>  if test "$have_ifaddrs_h" = "yes" ; then
>      echo "HAVE_IFADDRS_H=y" >> $config_host_mak
>  fi
> +if test "$have_drm_h" = "yes" ; then
> +  echo "HAVE_DRM_H=y" >> $config_host_mak
> +fi
>  if test "$have_broken_size_max" = "yes" ; then
>      echo "HAVE_BROKEN_SIZE_MAX=y" >> $config_host_mak
>  fi
> diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
> index 0defa1d8c1..f2e2fa9c87 100644
> --- a/linux-user/ioctls.h
> +++ b/linux-user/ioctls.h
> @@ -574,6 +574,11 @@
>    IOCTL_SPECIAL(SIOCDELRT, IOC_W, do_ioctl_rt,
>                  MK_PTR(MK_STRUCT(STRUCT_rtentry)))
>  
> +#ifdef HAVE_DRM_H
> +  IOCTL_SPECIAL(DRM_IOCTL_VERSION, IOC_RW, do_ioctl_drm,
> +                MK_PTR(MK_STRUCT(STRUCT_drm_version)))
> +#endif
> +
>  #ifdef TARGET_TIOCSTART
>    IOCTL_IGNORE(TIOCSTART)
>    IOCTL_IGNORE(TIOCSTOP)
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 7f6700c54e..1744e7acc7 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -112,6 +112,9 @@
>  #include <linux/if_alg.h>
>  #include <linux/rtc.h>
>  #include <sound/asound.h>
> +#ifdef HAVE_DRM_H
> +#include <libdrm/drm.h>
> +#endif
>  #include "linux_loop.h"
>  #include "uname.h"
>  
> @@ -5276,6 +5279,98 @@ static abi_long do_ioctl_tiocgptpeer(const IOCTLEntry *ie, uint8_t *buf_temp,
>  }
>  #endif
>  
> +#ifdef HAVE_DRM_H
> +
> +static void unlock_drm_version(struct drm_version *host_ver)
> +{
> +    unlock_user(host_ver->name, 0UL, 0);
> +    unlock_user(host_ver->date, 0UL, 0);
> +    unlock_user(host_ver->desc, 0UL, 0);
> +}

This is correct but I would prefer to not have this kind of function
with 0UL parameter.

You can use target_ver for the guest pointer and host_ver for the len,
guest pointer will be ignored if host pointer is NULL.

You can have a generic function that not copies data in case of error:

static void unlock_drm_strings(struct drm_version *host_ver,
                               struct target_drm_version *target_ver,
                               int copy)
{
    unlock_user(host_ver->name, target_ver->name,
                copy ? host_ver->name_len : 0);
...

> +
> +static inline abi_long target_to_host_drmversion(struct drm_version *host_ver,
> +                                          struct target_drm_version *target_ver)
> +{
> +    memset(host_ver, 0, sizeof(*host_ver));
> +
> +    __get_user(host_ver->name_len, &target_ver->name_len);
> +    if (host_ver->name_len) {
> +        host_ver->name = lock_user(VERIFY_WRITE, target_ver->name,
> +                                   target_ver->name_len, 0);
> +        if (!host_ver->name) {
> +            goto err;
> +        }
> +    }
> +
> +    __get_user(host_ver->date_len, &target_ver->date_len);
> +    if (host_ver->date_len) {
> +        host_ver->date = lock_user(VERIFY_WRITE, target_ver->date,
> +                                   target_ver->date_len, 0);
> +        if (!host_ver->date) {
> +            goto err;
> +        }
> +    }
> +
> +    __get_user(host_ver->desc_len, &target_ver->desc_len);
> +    if (host_ver->desc_len) {
> +        host_ver->desc = lock_user(VERIFY_WRITE, target_ver->desc,
> +                                   target_ver->desc_len, 0);
> +        if (!host_ver->desc) {
> +            goto err;
> +        }
> +    }
> +
> +    return 0;
> +err:
> +    unlock_drm_version(host_ver);

unlock_drm_strings(host_ver, target_ver, 0);

> +    return -EFAULT;
> +}
> +
> +static inline abi_long host_to_target_drmversion(
> +                                          struct target_drm_version *target_ver,
> +                                          struct drm_version *host_ver)
> +{
> +    __put_user(host_ver->version_major, &target_ver->version_major);
> +    __put_user(host_ver->version_minor, &target_ver->version_minor);
> +    __put_user(host_ver->version_patchlevel, &target_ver->version_patchlevel);
> +    __put_user(host_ver->name_len, &target_ver->name_len);
> +    __put_user(host_ver->date_len, &target_ver->date_len);
> +    __put_user(host_ver->desc_len, &target_ver->desc_len);
> +    unlock_user(host_ver->name, target_ver->name, host_ver->name_len);
> +    unlock_user(host_ver->date, target_ver->date, host_ver->date_len);
> +    unlock_user(host_ver->desc, target_ver->desc, host_ver->desc_len);

unlock_drm_strings(host_ver, target_ver, 1);

> +    return 0;
> +}
> +
> +static abi_long do_ioctl_drm(const IOCTLEntry *ie, uint8_t *buf_temp,
> +                             int fd, int cmd, abi_long arg)
> +{
> +    struct drm_version *ver;
> +    struct target_drm_version *target_ver;
> +    abi_long ret;
> +
> +    switch (ie->host_cmd) {
> +    case DRM_IOCTL_VERSION:
> +        if (!lock_user_struct(VERIFY_WRITE, target_ver, arg, 0)) {
> +            return -TARGET_EFAULT;
> +        }
> +        ver = (struct drm_version *)buf_temp;
> +        ret = target_to_host_drmversion(ver, target_ver);
> +        if (!is_error(ret)) {
> +            ret = get_errno(safe_ioctl(fd, ie->host_cmd, ver));
> +            if (!is_error(ret)) {
> +                ret = host_to_target_drmversion(target_ver, ver);
> +            }
> +            unlock_drm_version(ver);

} else {
    unlock_drm_strings(host_ver, target_ver, 0);
}

Thanks,
Laurent

