Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8803DC433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 09:50:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4ED17206A2
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 09:50:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ED17206A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgQ2Y-0000PS-Je
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 05:50:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51388)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jgQ21-0008NC-1m
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 05:49:57 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:45209)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jgQ1z-0002Pp-Ha
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 05:49:56 -0400
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue106 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1Mduym-1j5iAM3G9m-00b05A; Wed, 03 Jun 2020 11:49:49 +0200
To: chengang@emindsoft.com.cn, riku.voipio@iki.fi
References: <20200603010809.32139-1-chengang@emindsoft.com.cn>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Subject: Re: [PATCH v5] linux-user: syscall: ioctls: support DRM_IOCTL_VERSION
Message-ID: <02add5c5-e1ad-050e-229e-c5a7d2afdf2b@vivier.eu>
Date: Wed, 3 Jun 2020 11:49:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200603010809.32139-1-chengang@emindsoft.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:tRA7PDTO9S1XwYf/ldW5g1z9PnK7SuldpmIHdK5LckZquzEXIVy
 rFOretCPshJIF9JTVuqEbkyOMlnm7oy21O2Os7I/3opNO8AchjokuBMwnHzddsxkGoaOxF5
 3W6DQuAXJRp3cKMFAPXYXcMlJ0WIpTFCfL1NujSt/RPIrof5lWKb+sW92V0TC7MZXMniAjO
 mYOEYmNaaD3al8+t1/aiQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:50K/XmxPmT4=:lo1N2tEo5J4II/M+eupURF
 lmgRL8n0B/Fgz0eY+0ADyGrYUkACRCqnr/q53MdegpR/rOHtfLlAqoKztSJuJdQOpYsOV2o0f
 M0aDJIlTjEIAhJUyLFBM5TIj+w3PJrWkH2UbCbpitML44oZxfP4LwNy+4B3KIPxlMpArQZDV2
 I2Eu8CGkrCFiDlQ77hx4kUqybdf/OQuHqVXW5GrWdP0SjdfqLTlVDJZfVHm7srANJoaIMR79X
 Ykj8qF7w150EvbO3nvMoELchwaaI9BOahslRW9btvEo3sNnfiWLG31uCKsaeWLHWU0W0aEtk0
 QcvMmleJyrMCgdQqmAOoINDnPNG0rflRR6opqFVvqCApPi1FJiPmgizarzZcxD9Edd7OCQXz+
 /uWQBRWumX+Yz9NspjY6rhMbqpI+Tw6VV2f5HZdRok5uFN4sr8qWFgaIpxAyG3+7Nec+OUOhW
 zegZRdvwKcAMos8kfYIj443S9ciox8EiBmooyjk/0G8g2o2+qE6cr2rd3cUn32KGkW5zU5nLP
 swUnVe434gaYqsITZJOuC1KMIvN5TkEMnPitaEaaJQ1gBE2Yhr3hJeG8MgfulTj4F0/cl6hiQ
 QPHGphxvnhOjxpDKEOY6EMTAM+dJ88+meupLXftJ0ByveZLzVPzxYpHieMMM7WPYoLA9e1zlT
 VbeepWKRd/2I+CxRnKAt847hW9Fim0jsiD1nj/fDo3y2DXl3kM2HOiJnsBxrEnxmjR4jUNszf
 JHkovmykCQtLdYLfH1gmRkF8YQj98zf9c+kX5YBRBdWngmQaKAXKGYLklxegB+nVpxkA4LofV
 2UD4fzQhwdqknjgIW7tFTUomZkC1YU1ADhM3av9haeDB4S01Kh65bLKiQZd2ZRny0vFwlui
Received-SPF: none client-ip=217.72.192.73; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/03 05:49:53
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

Le 03/06/2020 à 03:08, chengang@emindsoft.com.cn a écrit :
> From: Chen Gang <chengang@emindsoft.com.cn>
> 
> Another DRM_IOCTL_* commands will be done later.
> 
> Signed-off-by: Chen Gang <chengang@emindsoft.com.cn>
> ---
>  configure                  |  10 ++++
>  linux-user/ioctls.h        |   5 ++
>  linux-user/syscall.c       | 117 +++++++++++++++++++++++++++++++++++++
>  linux-user/syscall_defs.h  |  15 +++++
>  linux-user/syscall_types.h |  11 ++++
>  5 files changed, 158 insertions(+)
> 
> diff --git a/configure b/configure
> index e225a1e3ff..3cf28a649a 100755
> --- a/configure
> +++ b/configure
> @@ -3140,6 +3140,13 @@ if ! check_include "ifaddrs.h" ; then
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
> @@ -7149,6 +7156,9 @@ fi
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
> index 5af55fca78..07b7596e0f 100644
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
> @@ -5275,6 +5278,120 @@ static abi_long do_ioctl_tiocgptpeer(const IOCTLEntry *ie, uint8_t *buf_temp,
>  }
>  #endif
>  
> +#ifdef HAVE_DRM_H
> +
> +static void unlock_drm_version(struct drm_version *host_ver)
> +{
> +    if (host_ver->name) {
> +        unlock_user(host_ver->name, 0UL, 0);

unlock_user() allows to have a NULL host pointer parameter, so you don't
need to check. But you must provide the target pointer, with the length.
The same below.

> +    }
> +    if (host_ver->date) {
> +        unlock_user(host_ver->date, 0UL, 0);
> +    }
> +    if (host_ver->desc) {
> +        unlock_user(host_ver->desc, 0UL, 0);
> +    }
> +}
> +
> +static inline abi_long target_to_host_drmversion(struct drm_version *host_ver,
> +                                                abi_long target_addr)
> +{
> +    struct target_drm_version *target_ver;
> +
> +    if (!lock_user_struct(VERIFY_READ, target_ver, target_addr, 0)) {
> +        return -TARGET_EFAULT;
> +    }
> +
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
> +    unlock_user_struct(target_ver, target_addr, 0);
> +    return 0;
> +err:
> +    unlock_drm_version(host_ver);
> +    unlock_user_struct(target_ver, target_addr, 0);
> +    return -ENOMEM;

In fact it should be -TARGET_EFAULT: it has failed because of access rights.

> +}
> +
> +static inline abi_long host_to_target_drmversion(abi_ulong target_addr,
> +                                                 struct drm_version *host_ver)
> +{
> +    struct target_drm_version *target_ver;
> +
> +    if (!lock_user_struct(VERIFY_WRITE, target_ver, target_addr, 0)) {

I think you should not unlock_struct() in target_to_host_drmversion() so
you don't have to lock it again here.

> +        unlock_drm_version(host_ver);
> +        return -TARGET_EFAULT;
> +    }
> +    __put_user(host_ver->version_major, &target_ver->version_major);
> +    __put_user(host_ver->version_minor, &target_ver->version_minor);
> +    __put_user(host_ver->version_patchlevel, &target_ver->version_patchlevel);
> +    __put_user(host_ver->name_len, &target_ver->name_len);
> +    __put_user(host_ver->date_len, &target_ver->date_len);
> +    __put_user(host_ver->desc_len, &target_ver->desc_len);
> +    if (host_ver->name) {
> +        unlock_user(host_ver->name, target_ver->name, host_ver->name_len);
> +    }

No need to check if host_ver->name is NULL.
Same below.

> +    if (host_ver->date) {
> +        unlock_user(host_ver->date, target_ver->date, host_ver->date_len);
> +    }
> +    if (host_ver->desc) {
> +        unlock_user(host_ver->desc, target_ver->desc, host_ver->desc_len);
> +    }
> +    unlock_user_struct(target_ver, target_addr, 0);
> +    return 0;
> +}
> +
> +static abi_long do_ioctl_drm(const IOCTLEntry *ie, uint8_t *buf_temp,
> +                             int fd, int cmd, abi_long arg)
> +{
> +    struct drm_version *ver;
> +    abi_long ret;
> +
> +    switch (ie->host_cmd) {
> +    case DRM_IOCTL_VERSION:
> +        ver = (struct drm_version *)buf_temp;

you should lock the structure here (rather than in
target_to_host_drmversion())...

> +        ret = target_to_host_drmversion(ver, arg);
> +        if (is_error(ret)) {
> +            return ret;
> +        }
> +        ret = get_errno(safe_ioctl(fd, ie->host_cmd, ver));
> +        if (is_error(ret)) {
> +            unlock_drm_version(ver);
> +            return ret;
> +        }
> +        return host_to_target_drmversion(arg, ver);

and unlock the structure here (rather than in host_to_target_drmversion()).

You should return "ret" too.

> +    }
> +    return -TARGET_EFAULT;

Why -TARGET_EFAULT? -TARGET_ENOSYS would be better.

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

Thanks,
Laurent


