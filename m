Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7DA8C47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 18:44:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D7E6206E6
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 18:44:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D7E6206E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47250 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYDPM-0006Wg-MP
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 14:44:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45888)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jYDOi-0005oq-DV
 for qemu-devel@nongnu.org; Mon, 11 May 2020 14:43:28 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:57177)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jYDOg-0006HF-Hv
 for qemu-devel@nongnu.org; Mon, 11 May 2020 14:43:28 -0400
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue009 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1M8yso-1jVRi7304s-0069kk; Mon, 11 May 2020 20:43:17 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: chengang@emindsoft.com.cn, riku.voipio@iki.fi
References: <20200315122051.9360-1-chengang@emindsoft.com.cn>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Subject: Re: [PATCH v2] linux-user: syscall: ioctls: support DRM_IOCTL_VERSION
Message-ID: <15f9b7ec-5608-a009-1be7-42a351a9e93f@vivier.eu>
Date: Mon, 11 May 2020 20:43:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200315122051.9360-1-chengang@emindsoft.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:+9fjx8nGNRja50TAwaZLwmRDzqbsjy5ejza20Y3B4K2yLB/8NmW
 DcgaXw52PGoKTyjwM8cUiE2wGeKMp43iCwzGdfRmSrbGaFdAy4+CXlonJepdMLxM5bi1inb
 00+VqiDanahn6ZRwtVj5S/0Q1aTS2QgxpxmTXJrVMtHG3pPcE02QxauguU/TxKcprxRQPa5
 nEALxp/CgC3XjIrmPeqiA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:y0atP7VeElE=:YMWeslpId+rg7H0BrlZrUF
 HhJPCwaFkDo4Qz2BwoYw37gELGPFTMAv94SiZf3XqpcZDKj2C6Fc9+gOo2IoZljqSysWOf6nB
 XD7dUe5nrxqPP30vx5pRKIhk074SV5Xx3bcPP7WoFoU5QDvo9vf5i/KbRucjtKzG/XJA/5vcx
 9gb3pLHyUnkFANViCnFzjvonxfWGgOeK6M33gz3n06zEA5uUHMfG1c8hS/KgLgVJYPymmx+CW
 J98kY57hwApBQyCg1B5pSQoEi4EJPeIv30ruClQsUu6vDHUJS7eHUnwoM4K0RE6unKvJAJ6xR
 w0OrizLLjSC4yiHGU+MDV6DajgpZot1YDAbHxiZYmC11g3xP8+r+6Pegy220dGVHE0t8sTjv6
 DGP+istONjNpG3G3CUZ9760YemR07JIgnAniju9dlGMYXwbQ4Vtg8HPBuJvoXRHeY1OsLBAcG
 wNY8FP3Ew+LETwK8sUTjyJ2gBGWQwEmGYAEgk2+PzcPezMSDGGoSJctoQvqO9+XTd0zE2py2v
 cbHODmwB3bn20RaqPGFqb5xd2+drlM20Hj5WuKPfQPp+P+nmC9t6GGCFWxCJ/V3s0NUMtiBlx
 F+hBneSLAAAkhHRVmqSmMltpvYBREWoONkV3Yh4ay1VeUeIkkglnBuBEWrGHpDRR/gPPZJn4R
 oxL0NNHgLR5LIKzbP8GF3Y3Oj0YVst4RJnPhWqubHi8xoDbG1HOKsPESjq3D4hmXnHc5b+qnP
 JKIjCnbEo8/ZSLPFHcSJqfVv9imxdf5f3b/Rbw0KJM8WS4JOOyS8eqUeWUV5jHjyXhjiAsbCz
 /70LST7AOQHNIg4XQLZClPGjQMBGw6xRKGHf19t4rbEeE9a0nmfRFNu0eHIl1CYZ55IRdn4
Received-SPF: none client-ip=212.227.126.131; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 14:43:24
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
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

Le 15/03/2020 à 13:20, chengang@emindsoft.com.cn a écrit :
> From: Chen Gang <chengang@emindsoft.com.cn>
> 
> Another DRM_IOCTL_* commands will be done later.
> 
> Signed-off-by: Chen Gang <chengang@emindsoft.com.cn>
> ---
>  linux-user/ioctls.h        |  2 ++
>  linux-user/syscall.c       | 62 ++++++++++++++++++++++++++++++++++++++
>  linux-user/syscall_defs.h  | 15 +++++++++
>  linux-user/syscall_types.h | 11 +++++++
>  4 files changed, 90 insertions(+)
> 
> diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
> index 0defa1d8c1..3ae32cbfb1 100644
> --- a/linux-user/ioctls.h
> +++ b/linux-user/ioctls.h
> @@ -574,6 +574,8 @@
>    IOCTL_SPECIAL(SIOCDELRT, IOC_W, do_ioctl_rt,
>                  MK_PTR(MK_STRUCT(STRUCT_rtentry)))
>  
> +  IOCTL_SPECIAL(DRM_IOCTL_VERSION, IOC_RW, do_ioctl_drm,
> +                MK_PTR(MK_STRUCT(STRUCT_drm_version)))

Add a blank line here.

>  #ifdef TARGET_TIOCSTART
>    IOCTL_IGNORE(TIOCSTART)
>    IOCTL_IGNORE(TIOCSTOP)
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 8d27d10807..2eb7c91ab4 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -112,6 +112,7 @@
>  #include <linux/if_alg.h>
>  #include <linux/rtc.h>
>  #include <sound/asound.h>
> +#include <libdrm/drm.h>

I think you should check in configure that this file is available on the
system.

>  #include "linux_loop.h"
>  #include "uname.h"
>  
> @@ -5196,6 +5197,67 @@ static abi_long do_ioctl_tiocgptpeer(const IOCTLEntry *ie, uint8_t *buf_temp,
>  }
>  #endif
>  
> +static inline abi_long target_to_host_drmversion(struct drm_version *host_ver,
> +                                                abi_long target_addr)
> +{
> +    struct target_drm_version *target_ver;
> +
> +    if (!lock_user_struct(VERIFY_READ, target_ver, target_addr, 0)) {
> +        return -TARGET_EFAULT;
> +    }
> +    __get_user(host_ver->name_len, &target_ver->name_len);
> +    host_ver->name = host_ver->name_len ? g2h(target_ver->name) : NULL;
> +    __get_user(host_ver->date_len, &target_ver->date_len);
> +    host_ver->date = host_ver->date_len ? g2h(target_ver->date) : NULL;
> +    __get_user(host_ver->desc_len, &target_ver->desc_len);
> +    host_ver->desc = host_ver->desc_len ? g2h(target_ver->desc) : NULL;
> +    unlock_user_struct(target_ver, target_addr, 0);
> +    return 0;
> +}
> +
> +static inline abi_long host_to_target_drmversion(abi_ulong target_addr,
> +                                                 struct drm_version *host_ver)
> +{
> +    struct target_drm_version *target_ver;
> +
> +    if (!lock_user_struct(VERIFY_WRITE, target_ver, target_addr, 0)) {
> +        return -TARGET_EFAULT;
> +    }
> +    __put_user(host_ver->version_major, &target_ver->version_major);
> +    __put_user(host_ver->version_minor, &target_ver->version_minor);
> +    __put_user(host_ver->version_patchlevel, &target_ver->version_patchlevel);
> +    __put_user(host_ver->name_len, &target_ver->name_len);
> +    __put_user(host_ver->date_len, &target_ver->date_len);
> +    __put_user(host_ver->desc_len, &target_ver->desc_len);
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
> +        memset(ver, 0, sizeof(*ver));
> +        ret = target_to_host_drmversion(ver, arg);
> +        if (is_error(ret)) {
> +            return ret;
> +        }
> +        ret = get_errno(safe_ioctl(fd, ie->host_cmd, ver));
> +        if (is_error(ret)) {
> +            return ret;
> +        }
> +        ret = host_to_target_drmversion(arg, ver);
> +        return ret;
> +    }
> +    return -TARGET_EFAULT;
> +}
> +
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

Why do you use the TARGET_IOWRU variant?

Can't you use TARGET_IOWR('d', 0x00, struct target_drm_version)?

Thanks,
Laurent

