Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B08B2C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 11:06:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74FDD239EF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 11:06:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74FDD239EF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jprbx-0001ZL-QC
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 07:06:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40442)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jprbF-0000zJ-Bq
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 07:05:21 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:37493)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jprbD-00071F-AD
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 07:05:21 -0400
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue106 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MMnnm-1jZIeU0NvQ-00Imbk; Mon, 29 Jun 2020 13:05:14 +0200
Subject: Re: [PATCH v7] linux-user: syscall: ioctls: support DRM_IOCTL_VERSION
To: chengang@emindsoft.com.cn, riku.voipio@iki.fi
References: <20200605013221.22828-1-chengang@emindsoft.com.cn>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <2f90b61a-b671-6f9c-a4a3-d031e3fbb56a@vivier.eu>
Date: Mon, 29 Jun 2020 13:05:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200605013221.22828-1-chengang@emindsoft.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:CNs4WmZnMqcJ4pdMGsqcu0OXBfLQFt/rukvZMAeDM9Uq+RBVVU4
 l1c4o0PaGFP0glhHzQ5H+rPT+5VBBnuVXjE1hjrxcetTT3wH2sghlKotNeYWPrMKCtaAbzJ
 JM7o2UW11iGkRr3NPvhzmov8Jes+5yHy5UxPA5nWJ8xCh4AdPoW21HciNTt4LBDb5/6RD0Y
 nwx58iqRH/+/aWVysCcog==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1EhJ/dKLAC0=:Uc7MzjdPF4Qq8KmCbO8sbj
 KZtFpoTgaAM0nhaBKfcRxwS593fdV3gHXlaDCtHcOA2yFzIU7fJvDQW4WbAAKnZOuj0VSdxbu
 b7u+HpswkihUjKRUxtsKKgeqplaIJlw5Xkpkv8ooMNM1iRAgW+Ono97JPFU7wUGZuBR4MtF+y
 UGYpVfkuw70soPLnd8MmbT0ZJdUPMVvV2rKUoiC5wWdXweQazmpgbN+W/i0DMP8FfCO9upWLg
 h9ZTClpJxVDjkBi5Ep4XEl8d/TOXw82pVA3pZhFg5itL9yvabac7cQEeQmLhdE0j0EbCDkIwY
 GMa6WXnrRrvZQoWcjSay5+nBJRL+twloEDhJVu7GfJC9MamaDoC3IsqRcDZ00GKqN6XK/9Ohr
 3UxLZ++IBHbg+yMP3pqhkm+DLzjqFseV4UZBEpJc9lIX+Nhn78J/CVEyUo+6g2Np6IuE0H3k5
 6x7I9HQ7mTOajZ1pgsYEIVNtWzChnlwv87x19S03uGPjBb3BdXXQh3/ig27Kx+llKpa9aZ0JZ
 aC8/lwWyv6EfCuZZN9izfmfHDHTrxBv5j1SGcVRrWUXAp2nYR3cbq5FbQnfM089oevVDsUyBb
 XK2fi7qpYmdBQy6FribWO/9gPS0JpwI44W0aFtI7WCwka7i1kx6Dk4aRTn+7sUaxjk3g1Bv5N
 7CCV+HWwpX3idpT8ne0zAqt6U00j4Hj20JnMxzdaIZ0lIroxEmdwABxk5mTDCzpITb3g/lQ/6
 AQ0HV/9Iq4M2e5yUD13LON8ERdsMrXH7xo0XxmUeZRzYQ9KmRxdBwMFZbcE2kKsPCD1j9DmW+
 kg9hrtSwAggsBcLV7sAUFJH7pFGOWfv+/VQdFbUOX2Y+V22bFimNMWTDK6QZLSjK/NshYgd
Received-SPF: none client-ip=212.227.17.10; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/29 07:05:18
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=_AUTOLEARN
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

Le 05/06/2020 à 03:32, chengang@emindsoft.com.cn a écrit :
> From: Chen Gang <chengang@emindsoft.com.cn>
> 
> Another DRM_IOCTL_* commands will be done later.
> 
> Signed-off-by: Chen Gang <chengang@emindsoft.com.cn>
> ---
>  configure                  | 10 ++++
>  linux-user/ioctls.h        |  5 ++
>  linux-user/syscall.c       | 98 ++++++++++++++++++++++++++++++++++++++
>  linux-user/syscall_defs.h  | 15 ++++++
>  linux-user/syscall_types.h | 11 +++++
>  5 files changed, 139 insertions(+)
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
> index 7f6700c54e..c0515c4378 100644
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
> @@ -5276,6 +5279,101 @@ static abi_long do_ioctl_tiocgptpeer(const IOCTLEntry *ie, uint8_t *buf_temp,
>  }
>  #endif
>  
> +#ifdef HAVE_DRM_H
> +
> +static void unlock_drm_version(struct drm_version *host_ver,
> +                               struct target_drm_version *target_ver,
> +                               bool copy)
> +{
> +    unlock_user(host_ver->name, target_ver->name,
> +                                copy ? host_ver->name_len : 0);
> +    unlock_user(host_ver->date, target_ver->date,
> +                                copy ? host_ver->date_len : 0);
> +    unlock_user(host_ver->desc, target_ver->desc,
> +                                copy ? host_ver->desc_len : 0);
> +}
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
> +            return -EFAULT;
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
> +    unlock_drm_version(host_ver, target_ver, false);
> +    return -EFAULT;
> +}
> +
> +static inline void host_to_target_drmversion(
> +                                          struct target_drm_version *target_ver,
> +                                          struct drm_version *host_ver)
> +{
> +    __put_user(host_ver->version_major, &target_ver->version_major);
> +    __put_user(host_ver->version_minor, &target_ver->version_minor);
> +    __put_user(host_ver->version_patchlevel, &target_ver->version_patchlevel);
> +    __put_user(host_ver->name_len, &target_ver->name_len);
> +    __put_user(host_ver->date_len, &target_ver->date_len);
> +    __put_user(host_ver->desc_len, &target_ver->desc_len);
> +    unlock_drm_version(host_ver, target_ver, true);
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
> +            if (is_error(ret)) {
> +                unlock_drm_version(ver, target_ver, false);
> +            } else {
> +                host_to_target_drmversion(target_ver, ver);
> +            }
> +        }
> +        unlock_user_struct(target_ver, arg, 0);
> +        return ret;
> +    }
> +    return -TARGET_ENOSYS;
> +}
> +
> +#endif
> +
>  static IOCTLEntry ioctl_entries[] = {
>  #define IOCTL(cmd, access, ...) \
>      { TARGET_ ## cmd, cmd, #cmd, access, 0, {  __VA_ARGS__ } },
> diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
> index 152ec637cb..3c261cff0e 100644
> --- a/linux-user/syscall_defs.h
> +++ b/linux-user/syscall_defs.h
> @@ -1167,6 +1167,9 @@ struct target_rtc_pll_info {
>  #define TARGET_DM_TARGET_MSG          TARGET_IOWRU(0xfd, 0x0e)
>  #define TARGET_DM_DEV_SET_GEOMETRY    TARGET_IOWRU(0xfd, 0x0f)
>  
> +/* drm ioctls */
> +#define TARGET_DRM_IOCTL_VERSION      TARGET_IOWRU('d', 0x00)
> +
>  /* from asm/termbits.h */
>  
>  #define TARGET_NCC 8
> @@ -2598,6 +2601,18 @@ struct target_mq_attr {
>      abi_long mq_curmsgs;
>  };
>  
> +struct target_drm_version {
> +    int version_major;
> +    int version_minor;
> +    int version_patchlevel;
> +    abi_ulong name_len;
> +    abi_ulong name;
> +    abi_ulong date_len;
> +    abi_ulong date;
> +    abi_ulong desc_len;
> +    abi_ulong desc;
> +};
> +
>  #include "socket.h"
>  
>  #include "errno_defs.h"
> diff --git a/linux-user/syscall_types.h b/linux-user/syscall_types.h
> index 4e12c1661e..e2b0484f50 100644
> --- a/linux-user/syscall_types.h
> +++ b/linux-user/syscall_types.h
> @@ -292,6 +292,17 @@ STRUCT(dm_target_versions,
>  STRUCT(dm_target_msg,
>         TYPE_ULONGLONG) /* sector */
>  
> +STRUCT(drm_version,
> +       TYPE_INT, /* version_major */
> +       TYPE_INT, /* version_minor */
> +       TYPE_INT, /* version_patchlevel */
> +       TYPE_ULONG, /* name_len */
> +       TYPE_PTRVOID, /* name */
> +       TYPE_ULONG, /* date_len */
> +       TYPE_PTRVOID, /* date */
> +       TYPE_ULONG, /* desc_len */
> +       TYPE_PTRVOID) /* desc */
> +
>  STRUCT(file_clone_range,
>         TYPE_LONGLONG, /* src_fd */
>         TYPE_ULONGLONG, /* src_offset */
> 

Applied to my branch linux-user-for-5.1

Thanks,
Laurent

