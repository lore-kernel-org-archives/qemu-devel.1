Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D453DC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 13:41:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9C38206A2
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 13:41:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9C38206A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jg7Av-0005Py-Vw
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 09:41:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59596)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jg79r-0004Eh-6c
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 09:40:47 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:54643)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jg79p-00063U-Jz
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 09:40:46 -0400
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue009 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MbAYi-1j9GJ307cu-00be0c; Tue, 02 Jun 2020 15:40:29 +0200
To: chengang@emindsoft.com.cn, riku.voipio@iki.fi
References: <20200602120023.5963-1-chengang@emindsoft.com.cn>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Subject: Re: [PATCH v4] linux-user: syscall: ioctls: support DRM_IOCTL_VERSION
Message-ID: <5525a258-7e9e-d52f-736c-db51ea2ea9cc@vivier.eu>
Date: Tue, 2 Jun 2020 15:40:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200602120023.5963-1-chengang@emindsoft.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:8A3eCa/Rz1BBt9dmUlto5JzJYqfY6siy1lRWGj5wvO5yZMiObjN
 KMFvbgTejBdxFaYnhitMiwAaYkhPDHJRexBE1881LDdi2UEbFbQ5X0gvefbYw3sJsK79kTn
 rFGRHSVOQyVR8X2TJ3sRAgDuF9djB8QJFFzuFZlbT9PvedDeTnqWtWwfTkL7SwZmHuirFvE
 D9m8HTC0UfDBEGtgvj3HQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qmmBuzOXq1o=:KWwseiJzIELy/BOsSjbCf9
 h/PgohBRfY2WS8M2pVekOJUbuu7Y3rKWLc25Kg+adRS+Hx/sWPaSdQXq9kHB5UJZhXIraY/Zz
 jTwr9hzzEZAG7yRi9GRoo3BhMhhGnMbzZmtl6dyOb8oJKMYIPK1FE4am75Y8N6wsC3n8kfMW/
 72X9hxgAgtqHnzHSCNoSpPpw2fqXNupeMTQvlaD6TlHlIB2/5Wfi0Ry4mwnFtpxjb1L8cgtAm
 ot3yrxfmmzAR4tS6yihDclwTjoUzM71PgS6UXPaOBij6DbdkKLd5Y0eXtz60V14A0oH84Umtp
 cMu/XZZFr7MbOymCpUWBKiWhQIc4FPy6TuwTcy6A4NLJZ/+XlD/iXR+/bmaM3P2/hm/gN+04s
 NuSgx31q9FHiFnbvenTRDtoYFfvguiUq3ae6mk0UjIftLHE8nhWctChqgnfMjYj/BFRTteDJ4
 jBCQa5ZAydYUCnEy62QyIUa2KiSQudDBC0/oslnc8tM8AuLAhPTG+Lz78VpLj4TQwkak5fUbZ
 W6q9joSsYtUJEawSLGAcNJRjpo+OEo2QNvvo0zxWMaJSLD3tdAN9Cg2Qwq3+HUPsVbDq9H8ez
 2y3sRcNoEQq8igtW9Yntu3WzG2bux5R193sjwcASkFEx1J6AiFQD7W3fMqndRp3AlBfbaYkVI
 QsffxUJusnIQA344NoGfloUGasw6p1q5K8eRVK11Sq2Ib8mG2/t0CKUglCr5Eqs8RrPhG8w2O
 3qznCQg4023f9p+HAnO3Rl78o/ICNGSaY3lOaLcvF63fRsT8Rrw0WHfG7rIEDCJjsgC9udhGZ
 FPtWftOUOOvsRdFoVVvOTXrtLLwoGLVBeW6gl27x29fSfYSQOCjTwBD2MTZ+KlxiIuk+cvx
Received-SPF: none client-ip=212.227.126.187; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/02 09:40:39
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

Le 02/06/2020 à 14:00, chengang@emindsoft.com.cn a écrit :
> From: Chen Gang <chengang@emindsoft.com.cn>
> 
> Another DRM_IOCTL_* commands will be done later.
> 
> Signed-off-by: Chen Gang <chengang@emindsoft.com.cn>
> ---
>  configure                  | 10 ++++++
>  linux-user/ioctls.h        |  5 +++
>  linux-user/syscall.c       | 67 ++++++++++++++++++++++++++++++++++++++
>  linux-user/syscall_defs.h  | 15 +++++++++
>  linux-user/syscall_types.h | 11 +++++++
>  5 files changed, 108 insertions(+)
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

The configure and HAVE_DRM_H look good...

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
> index 5af55fca78..006889cea6 100644
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
> @@ -5275,6 +5278,70 @@ static abi_long do_ioctl_tiocgptpeer(const IOCTLEntry *ie, uint8_t *buf_temp,
>  }
>  #endif
>  
> +#ifdef HAVE_DRM_H
> +
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

but I think the string buffers must be locked and access rights must be
checked.

So I think you should have something like:

host_ver->name = lock_user(VERIFY_WRITE, target_ver->name,
                           target_ver->name_len, 0);
...

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

unlock_user(host_ver->name, target_ver->name, host_ver->name_len);
...

> +    __put_user(host_ver->date_len, &target_ver->date_len);
> +    __put_user(host_ver->desc_len, &target_ver->desc_len);
> +    unlock_user_struct(target_ver, target_addr, 0);
> +    return 0;
> +}
> +

Thanks,
Laurent


