Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFC7BC433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 23:23:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66E482076E
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 23:23:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HswKt8DB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66E482076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3SlC-0005Hc-OD
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 19:23:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50712)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <scw@google.com>) id 1k3SkT-0004PI-Tl
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 19:23:05 -0400
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643]:41085)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <scw@google.com>) id 1k3SkR-0006DZ-C4
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 19:23:05 -0400
Received: by mail-ej1-x643.google.com with SMTP id m19so7721325ejd.8
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2020 16:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=OcVa4n6+4hdB5/dV1+z2yiKqsyM/3YKgk4Y5PU4RPxw=;
 b=HswKt8DBdU6ejozcqTK5npNM7Qk2vUcQLaB624psfSwJWZ86GV0xyd4M+e8a/Hi0i3
 ObPclk3hHJZEcPq6uu1U5iOE4k2uM8Lr1ED0A6oikEZMae4iEcWwmFyGQpeqLHEZZ433
 74DFEi25jI5W9sZ8i5SeoABxk7HZPoiku0mqMnoO06DP2ih3+Z/ayvlLAj1DB+t7yOSs
 lklRtgdrUBD9KS8FEItu3P+wR78miT2x4BEgNd3SAzw0MyX0Z98ZsTDGLfEu4FEOeKmj
 5xkvrYDm21bZRn3rAjaH+ZmIjj5PHUUwZA3AU9/qi+key1xdUuGHcYGPp2QUYbB92CBn
 5hvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=OcVa4n6+4hdB5/dV1+z2yiKqsyM/3YKgk4Y5PU4RPxw=;
 b=gxZxbagAPAxG7HUuzJbJDPOFtG47bsLjatBmJKYZWOW9w7kcTyjxGclSce5ahpD4zL
 ZpwZLCL2GiVlg1nQ2OFYYoWoJnEVFOidF9VcuSPAS32P+ePgjApeV3cMQGk97ymZJRED
 M5uw6cBvFMFaO44xWDWFqK6Fq/u0OeLzq1ZTXflVdLiLPYiafdcmkeIlseVlYZgpo/lq
 g5/0dNzJCfGIJ0lbU9a7tvCKfRlw1Eaxdg0dlckn9xlgn0BMyuL49olLNvgiKMU7fJ09
 WnEXBk5iQCyIGzLjRNc1DfK8PhM+/KkNhyvg/qwRfFneraKuN0L+beSDa7wsJR1Tb+Jd
 oQPw==
X-Gm-Message-State: AOAM5328syx8QqagdaeLCe4l8t5EAfbTA2RkKumem1vsZpFZb+TweUzN
 9cVANZQHx1zO7a+R1VHc8cipHQuuBUnfxAXRrCCZzQ==
X-Google-Smtp-Source: ABdhPJwDesSgeDiDgqgD4ueNBlrMT0J0gUgc9WcWOjbry/sTyHUr2ZZQEpWXVwZpkzFLprlAv38rCOVfGtTQLMJukgc=
X-Received: by 2002:a17:906:d050:: with SMTP id
 bo16mr1726255ejb.367.1596669780228; 
 Wed, 05 Aug 2020 16:23:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200723231020.769893-1-scw@google.com>
In-Reply-To: <20200723231020.769893-1-scw@google.com>
From: Shu-Chun Weng <scw@google.com>
Date: Wed, 5 Aug 2020 16:22:49 -0700
Message-ID: <CAF3nBxiekWfY26yuWyb1bgy2eVHZUbDHW_7d7tGNvhp6Ugg+tw@mail.gmail.com>
Subject: Re: [PATCH v2] linux-user: Add most IFTUN ioctls
To: Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel@nongnu.org, Riku Voipio <riku.voipio@iki.fi>,
 Josh Kunz <jkz@google.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="000000000000189ee305ac29a766"
Received-SPF: pass client-ip=2a00:1450:4864:20::643;
 envelope-from=scw@google.com; helo=mail-ej1-x643.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -185
X-Spam_score: -18.6
X-Spam_bar: ------------------
X-Spam_report: (-18.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001,
 USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000189ee305ac29a766
Content-Type: multipart/alternative; boundary="00000000000013563c05ac29a7e7"

--00000000000013563c05ac29a7e7
Content-Type: text/plain; charset="UTF-8"

Ping: https://patchew.org/QEMU/20200723231020.769893-1-scw@google.com/

On Thu, Jul 23, 2020 at 4:10 PM Shu-Chun Weng <scw@google.com> wrote:

> The three options handling `struct sock_fprog` (TUNATTACHFILTER,
> TUNDETACHFILTER, and TUNGETFILTER) are not implemented. Linux kernel
> keeps a user space pointer in them which we cannot correctly handle.
>
> Signed-off-by: Josh Kunz <jkz@google.com>
> Signed-off-by: Shu-Chun Weng <scw@google.com>
> ---
> v2:
>   Title changed from "linux-user: Add several IFTUN ioctls"
>
>   Properly specify the argument types for various options, including a
> custom
>   implementation for TUNSETTXFILTER.
>
>   #ifdef guards for macros introduced up to 5 years ago.
>
>  linux-user/ioctls.h       | 45 +++++++++++++++++++++++++++++++++++++++
>  linux-user/syscall.c      | 36 +++++++++++++++++++++++++++++++
>  linux-user/syscall_defs.h | 32 ++++++++++++++++++++++++++++
>  3 files changed, 113 insertions(+)
>
> diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
> index 0713ae1311..b9fb01f558 100644
> --- a/linux-user/ioctls.h
> +++ b/linux-user/ioctls.h
> @@ -593,3 +593,48 @@
>    IOCTL(KCOV_DISABLE, 0, TYPE_NULL)
>    IOCTL(KCOV_INIT_TRACE, IOC_R, TYPE_ULONG)
>  #endif
> +
> +  IOCTL(TUNSETDEBUG,     IOC_W, TYPE_INT)
> +  IOCTL(TUNSETIFF,       IOC_RW, MK_PTR(MK_STRUCT(STRUCT_short_ifreq)))
> +  IOCTL(TUNSETPERSIST,   IOC_W, TYPE_INT)
> +  IOCTL(TUNSETOWNER,     IOC_W, TYPE_INT)
> +  IOCTL(TUNSETLINK,      IOC_W, TYPE_INT)
> +  IOCTL(TUNSETGROUP,     IOC_W, TYPE_INT)
> +  IOCTL(TUNGETFEATURES,  IOC_R, MK_PTR(TYPE_INT))
> +  IOCTL(TUNSETOFFLOAD,   IOC_W, TYPE_LONG)
> +  IOCTL_SPECIAL(TUNSETTXFILTER, IOC_W, do_ioctl_TUNSETTXFILTER,
> +                /*
> +                 * We can't represent `struct tun_filter` in thunk so
> leaving
> +                 * this empty. do_ioctl_TUNSETTXFILTER will do the
> conversion.
> +                 */
> +                TYPE_NULL)
> +  IOCTL(TUNGETIFF,       IOC_R, MK_PTR(MK_STRUCT(STRUCT_short_ifreq)))
> +  IOCTL(TUNGETSNDBUF,    IOC_R, MK_PTR(TYPE_INT))
> +  IOCTL(TUNSETSNDBUF,    IOC_W, MK_PTR(TYPE_INT))
> +  /*
> +   * TUNATTACHFILTER and TUNDETACHFILTER are not supported. Linux kernel
> keeps a
> +   * user pointer in TUNATTACHFILTER, which we are not able to correctly
> handle.
> +   */
> +  IOCTL(TUNGETVNETHDRSZ, IOC_R, MK_PTR(TYPE_INT))
> +  IOCTL(TUNSETVNETHDRSZ, IOC_W, MK_PTR(TYPE_INT))
> +  IOCTL(TUNSETQUEUE,     IOC_W, MK_PTR(MK_STRUCT(STRUCT_short_ifreq)))
> +  IOCTL(TUNSETIFINDEX ,  IOC_W, MK_PTR(TYPE_INT))
> +  /* TUNGETFILTER is not supported: see TUNATTACHFILTER. */
> +  IOCTL(TUNSETVNETLE,    IOC_W, MK_PTR(TYPE_INT))
> +  IOCTL(TUNGETVNETLE,    IOC_R, MK_PTR(TYPE_INT))
> +#ifdef TUNSETVNETBE
> +  IOCTL(TUNSETVNETBE,    IOC_W, MK_PTR(TYPE_INT))
> +  IOCTL(TUNGETVNETBE,    IOC_R, MK_PTR(TYPE_INT))
> +#endif
> +#ifdef TUNSETSTEERINGEBPF
> +  IOCTL(TUNSETSTEERINGEBPF, IOC_W, MK_PTR(TYPE_INT))
> +#endif
> +#ifdef TUNSETFILTEREBPF
> +  IOCTL(TUNSETFILTEREBPF, IOC_W, MK_PTR(TYPE_INT))
> +#endif
> +#ifdef TUNSETCARRIER
> +  IOCTL(TUNSETCARRIER,   IOC_W, MK_PTR(TYPE_INT))
> +#endif
> +#ifdef TUNGETDEVNETNS
> +  IOCTL(TUNGETDEVNETNS,  IOC_R, TYPE_NULL)
> +#endif
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 1211e759c2..7f1efed189 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -56,6 +56,7 @@
>  #include <linux/wireless.h>
>  #include <linux/icmp.h>
>  #include <linux/icmpv6.h>
> +#include <linux/if_tun.h>
>  #include <linux/errqueue.h>
>  #include <linux/random.h>
>  #ifdef CONFIG_TIMERFD
> @@ -5422,6 +5423,41 @@ static abi_long do_ioctl_drm(const IOCTLEntry *ie,
> uint8_t *buf_temp,
>
>  #endif
>
> +static abi_long do_ioctl_TUNSETTXFILTER(const IOCTLEntry *ie, uint8_t
> *buf_temp,
> +                                        int fd, int cmd, abi_long arg)
> +{
> +    struct tun_filter *filter = (struct tun_filter *)buf_temp;
> +    struct tun_filter *target_filter;
> +    char *target_addr;
> +
> +    assert(ie->access == IOC_W);
> +
> +    target_filter = lock_user(VERIFY_READ, arg, sizeof(*filter), 1);
> +    if (!target_filter) {
> +        return -TARGET_EFAULT;
> +    }
> +    filter->flags = tswap16(target_filter->flags);
> +    filter->count = tswap16(target_filter->count);
> +    unlock_user(target_filter, arg, sizeof(*filter));
> +
> +    if (filter->count) {
> +        if (sizeof(*filter) + filter->count * ETH_ALEN > MAX_STRUCT_SIZE)
> {
> +            return -TARGET_EFAULT;
> +        }
> +
> +        target_addr = lock_user(VERIFY_READ, arg + sizeof(*filter),
> +                                filter->count * ETH_ALEN, 1);
> +        if (!target_addr) {
> +            return -TARGET_EFAULT;
> +        }
> +        memcpy(filter->addr, target_addr, filter->count * ETH_ALEN);
> +        unlock_user(target_addr, arg + sizeof(*filter),
> +                    filter->count * ETH_ALEN);
> +    }
> +
> +    return get_errno(safe_ioctl(fd, ie->host_cmd, filter));
> +}
> +
>  IOCTLEntry ioctl_entries[] = {
>  #define IOCTL(cmd, access, ...) \
>      { TARGET_ ## cmd, cmd, #cmd, access, 0, {  __VA_ARGS__ } },
> diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
> index 3c261cff0e..7ef0ff0328 100644
> --- a/linux-user/syscall_defs.h
> +++ b/linux-user/syscall_defs.h
> @@ -891,6 +891,38 @@ struct target_rtc_pll_info {
>
>  #define TARGET_SIOCGIWNAME     0x8B01          /* get name == wireless
> protocol */
>
> +/* From <linux/if_tun.h> */
> +
> +#define TARGET_TUNSETDEBUG        TARGET_IOW('T', 201, int)
> +#define TARGET_TUNSETIFF          TARGET_IOW('T', 202, int)
> +#define TARGET_TUNSETPERSIST      TARGET_IOW('T', 203, int)
> +#define TARGET_TUNSETOWNER        TARGET_IOW('T', 204, int)
> +#define TARGET_TUNSETLINK         TARGET_IOW('T', 205, int)
> +#define TARGET_TUNSETGROUP        TARGET_IOW('T', 206, int)
> +#define TARGET_TUNGETFEATURES     TARGET_IOR('T', 207, unsigned int)
> +#define TARGET_TUNSETOFFLOAD      TARGET_IOW('T', 208, unsigned int)
> +#define TARGET_TUNSETTXFILTER     TARGET_IOW('T', 209, unsigned int)
> +#define TARGET_TUNGETIFF          TARGET_IOR('T', 210, unsigned int)
> +#define TARGET_TUNGETSNDBUF       TARGET_IOR('T', 211, int)
> +#define TARGET_TUNSETSNDBUF       TARGET_IOW('T', 212, int)
> +/*
> + * TUNATTACHFILTER and TUNDETACHFILTER are not supported. Linux kernel
> keeps a
> + * user pointer in TUNATTACHFILTER, which we are not able to correctly
> handle.
> + */
> +#define TARGET_TUNGETVNETHDRSZ    TARGET_IOR('T', 215, int)
> +#define TARGET_TUNSETVNETHDRSZ    TARGET_IOW('T', 216, int)
> +#define TARGET_TUNSETQUEUE        TARGET_IOW('T', 217, int)
> +#define TARGET_TUNSETIFINDEX      TARGET_IOW('T', 218, unsigned int)
> +/* TUNGETFILTER is not supported: see TUNATTACHFILTER. */
> +#define TARGET_TUNSETVNETLE       TARGET_IOW('T', 220, int)
> +#define TARGET_TUNGETVNETLE       TARGET_IOR('T', 221, int)
> +#define TARGET_TUNSETVNETBE       TARGET_IOW('T', 222, int)
> +#define TARGET_TUNGETVNETBE       TARGET_IOR('T', 223, int)
> +#define TARGET_TUNSETSTEERINGEBPF TARGET_IOR('T', 224, int)
> +#define TARGET_TUNSETFILTEREBPF   TARGET_IOR('T', 225, int)
> +#define TARGET_TUNSETCARRIER      TARGET_IOW('T', 226, int)
> +#define TARGET_TUNGETDEVNETNS     TARGET_IO('T', 227)
> +
>  /* From <linux/random.h> */
>
>  #define TARGET_RNDGETENTCNT    TARGET_IOR('R', 0x00, int)
> --
> 2.28.0.rc0.142.g3c755180ce-goog
>
>

--00000000000013563c05ac29a7e7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Ping:=C2=A0<a href=3D"https://patchew.org/QEMU/20200723231=
020.769893-1-scw@google.com/" class=3D"cremed">https://patchew.org/QEMU/202=
00723231020.769893-1-scw@google.com/</a></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jul 23, 2020 at 4:10 PM Shu=
-Chun Weng &lt;<a href=3D"mailto:scw@google.com">scw@google.com</a>&gt; wro=
te:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">The three op=
tions handling `struct sock_fprog` (TUNATTACHFILTER,<br>
TUNDETACHFILTER, and TUNGETFILTER) are not implemented. Linux kernel<br>
keeps a user space pointer in them which we cannot correctly handle.<br>
<br>
Signed-off-by: Josh Kunz &lt;<a href=3D"mailto:jkz@google.com" target=3D"_b=
lank">jkz@google.com</a>&gt;<br>
Signed-off-by: Shu-Chun Weng &lt;<a href=3D"mailto:scw@google.com" target=
=3D"_blank">scw@google.com</a>&gt;<br>
---<br>
v2:<br>
=C2=A0 Title changed from &quot;linux-user: Add several IFTUN ioctls&quot;<=
br>
<br>
=C2=A0 Properly specify the argument types for various options, including a=
 custom<br>
=C2=A0 implementation for TUNSETTXFILTER.<br>
<br>
=C2=A0 #ifdef guards for macros introduced up to 5 years ago.<br>
<br>
=C2=A0linux-user/ioctls.h=C2=A0 =C2=A0 =C2=A0 =C2=A0| 45 ++++++++++++++++++=
+++++++++++++++++++++<br>
=C2=A0linux-user/syscall.c=C2=A0 =C2=A0 =C2=A0 | 36 +++++++++++++++++++++++=
++++++++<br>
=C2=A0linux-user/syscall_defs.h | 32 ++++++++++++++++++++++++++++<br>
=C2=A03 files changed, 113 insertions(+)<br>
<br>
diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h<br>
index 0713ae1311..b9fb01f558 100644<br>
--- a/linux-user/ioctls.h<br>
+++ b/linux-user/ioctls.h<br>
@@ -593,3 +593,48 @@<br>
=C2=A0 =C2=A0IOCTL(KCOV_DISABLE, 0, TYPE_NULL)<br>
=C2=A0 =C2=A0IOCTL(KCOV_INIT_TRACE, IOC_R, TYPE_ULONG)<br>
=C2=A0#endif<br>
+<br>
+=C2=A0 IOCTL(TUNSETDEBUG,=C2=A0 =C2=A0 =C2=A0IOC_W, TYPE_INT)<br>
+=C2=A0 IOCTL(TUNSETIFF,=C2=A0 =C2=A0 =C2=A0 =C2=A0IOC_RW, MK_PTR(MK_STRUCT=
(STRUCT_short_ifreq)))<br>
+=C2=A0 IOCTL(TUNSETPERSIST,=C2=A0 =C2=A0IOC_W, TYPE_INT)<br>
+=C2=A0 IOCTL(TUNSETOWNER,=C2=A0 =C2=A0 =C2=A0IOC_W, TYPE_INT)<br>
+=C2=A0 IOCTL(TUNSETLINK,=C2=A0 =C2=A0 =C2=A0 IOC_W, TYPE_INT)<br>
+=C2=A0 IOCTL(TUNSETGROUP,=C2=A0 =C2=A0 =C2=A0IOC_W, TYPE_INT)<br>
+=C2=A0 IOCTL(TUNGETFEATURES,=C2=A0 IOC_R, MK_PTR(TYPE_INT))<br>
+=C2=A0 IOCTL(TUNSETOFFLOAD,=C2=A0 =C2=A0IOC_W, TYPE_LONG)<br>
+=C2=A0 IOCTL_SPECIAL(TUNSETTXFILTER, IOC_W, do_ioctl_TUNSETTXFILTER,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* We can&#39=
;t represent `struct tun_filter` in thunk so leaving<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* this empty=
. do_ioctl_TUNSETTXFILTER will do the conversion.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TYPE_NULL)<br>
+=C2=A0 IOCTL(TUNGETIFF,=C2=A0 =C2=A0 =C2=A0 =C2=A0IOC_R, MK_PTR(MK_STRUCT(=
STRUCT_short_ifreq)))<br>
+=C2=A0 IOCTL(TUNGETSNDBUF,=C2=A0 =C2=A0 IOC_R, MK_PTR(TYPE_INT))<br>
+=C2=A0 IOCTL(TUNSETSNDBUF,=C2=A0 =C2=A0 IOC_W, MK_PTR(TYPE_INT))<br>
+=C2=A0 /*<br>
+=C2=A0 =C2=A0* TUNATTACHFILTER and TUNDETACHFILTER are not supported. Linu=
x kernel keeps a<br>
+=C2=A0 =C2=A0* user pointer in TUNATTACHFILTER, which we are not able to c=
orrectly handle.<br>
+=C2=A0 =C2=A0*/<br>
+=C2=A0 IOCTL(TUNGETVNETHDRSZ, IOC_R, MK_PTR(TYPE_INT))<br>
+=C2=A0 IOCTL(TUNSETVNETHDRSZ, IOC_W, MK_PTR(TYPE_INT))<br>
+=C2=A0 IOCTL(TUNSETQUEUE,=C2=A0 =C2=A0 =C2=A0IOC_W, MK_PTR(MK_STRUCT(STRUC=
T_short_ifreq)))<br>
+=C2=A0 IOCTL(TUNSETIFINDEX ,=C2=A0 IOC_W, MK_PTR(TYPE_INT))<br>
+=C2=A0 /* TUNGETFILTER is not supported: see TUNATTACHFILTER. */<br>
+=C2=A0 IOCTL(TUNSETVNETLE,=C2=A0 =C2=A0 IOC_W, MK_PTR(TYPE_INT))<br>
+=C2=A0 IOCTL(TUNGETVNETLE,=C2=A0 =C2=A0 IOC_R, MK_PTR(TYPE_INT))<br>
+#ifdef TUNSETVNETBE<br>
+=C2=A0 IOCTL(TUNSETVNETBE,=C2=A0 =C2=A0 IOC_W, MK_PTR(TYPE_INT))<br>
+=C2=A0 IOCTL(TUNGETVNETBE,=C2=A0 =C2=A0 IOC_R, MK_PTR(TYPE_INT))<br>
+#endif<br>
+#ifdef TUNSETSTEERINGEBPF<br>
+=C2=A0 IOCTL(TUNSETSTEERINGEBPF, IOC_W, MK_PTR(TYPE_INT))<br>
+#endif<br>
+#ifdef TUNSETFILTEREBPF<br>
+=C2=A0 IOCTL(TUNSETFILTEREBPF, IOC_W, MK_PTR(TYPE_INT))<br>
+#endif<br>
+#ifdef TUNSETCARRIER<br>
+=C2=A0 IOCTL(TUNSETCARRIER,=C2=A0 =C2=A0IOC_W, MK_PTR(TYPE_INT))<br>
+#endif<br>
+#ifdef TUNGETDEVNETNS<br>
+=C2=A0 IOCTL(TUNGETDEVNETNS,=C2=A0 IOC_R, TYPE_NULL)<br>
+#endif<br>
diff --git a/linux-user/syscall.c b/linux-user/syscall.c<br>
index 1211e759c2..7f1efed189 100644<br>
--- a/linux-user/syscall.c<br>
+++ b/linux-user/syscall.c<br>
@@ -56,6 +56,7 @@<br>
=C2=A0#include &lt;linux/wireless.h&gt;<br>
=C2=A0#include &lt;linux/icmp.h&gt;<br>
=C2=A0#include &lt;linux/icmpv6.h&gt;<br>
+#include &lt;linux/if_tun.h&gt;<br>
=C2=A0#include &lt;linux/errqueue.h&gt;<br>
=C2=A0#include &lt;linux/random.h&gt;<br>
=C2=A0#ifdef CONFIG_TIMERFD<br>
@@ -5422,6 +5423,41 @@ static abi_long do_ioctl_drm(const IOCTLEntry *ie, u=
int8_t *buf_temp,<br>
<br>
=C2=A0#endif<br>
<br>
+static abi_long do_ioctl_TUNSETTXFILTER(const IOCTLEntry *ie, uint8_t *buf=
_temp,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int fd, =
int cmd, abi_long arg)<br>
+{<br>
+=C2=A0 =C2=A0 struct tun_filter *filter =3D (struct tun_filter *)buf_temp;=
<br>
+=C2=A0 =C2=A0 struct tun_filter *target_filter;<br>
+=C2=A0 =C2=A0 char *target_addr;<br>
+<br>
+=C2=A0 =C2=A0 assert(ie-&gt;access =3D=3D IOC_W);<br>
+<br>
+=C2=A0 =C2=A0 target_filter =3D lock_user(VERIFY_READ, arg, sizeof(*filter=
), 1);<br>
+=C2=A0 =C2=A0 if (!target_filter) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -TARGET_EFAULT;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 filter-&gt;flags =3D tswap16(target_filter-&gt;flags);<br>
+=C2=A0 =C2=A0 filter-&gt;count =3D tswap16(target_filter-&gt;count);<br>
+=C2=A0 =C2=A0 unlock_user(target_filter, arg, sizeof(*filter));<br>
+<br>
+=C2=A0 =C2=A0 if (filter-&gt;count) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (sizeof(*filter) + filter-&gt;count * ETH_A=
LEN &gt; MAX_STRUCT_SIZE) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -TARGET_EFAULT;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 target_addr =3D lock_user(VERIFY_READ, arg + s=
izeof(*filter),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 filter-&gt;count * ETH_ALEN, 1);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!target_addr) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -TARGET_EFAULT;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 memcpy(filter-&gt;addr, target_addr, filter-&g=
t;count * ETH_ALEN);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 unlock_user(target_addr, arg + sizeof(*filter)=
,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 filt=
er-&gt;count * ETH_ALEN);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 return get_errno(safe_ioctl(fd, ie-&gt;host_cmd, filter));<b=
r>
+}<br>
+<br>
=C2=A0IOCTLEntry ioctl_entries[] =3D {<br>
=C2=A0#define IOCTL(cmd, access, ...) \<br>
=C2=A0 =C2=A0 =C2=A0{ TARGET_ ## cmd, cmd, #cmd, access, 0, {=C2=A0 __VA_AR=
GS__ } },<br>
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h<br>
index 3c261cff0e..7ef0ff0328 100644<br>
--- a/linux-user/syscall_defs.h<br>
+++ b/linux-user/syscall_defs.h<br>
@@ -891,6 +891,38 @@ struct target_rtc_pll_info {<br>
<br>
=C2=A0#define TARGET_SIOCGIWNAME=C2=A0 =C2=A0 =C2=A00x8B01=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 /* get name =3D=3D wireless protocol */<br>
<br>
+/* From &lt;linux/if_tun.h&gt; */<br>
+<br>
+#define TARGET_TUNSETDEBUG=C2=A0 =C2=A0 =C2=A0 =C2=A0 TARGET_IOW(&#39;T&#3=
9;, 201, int)<br>
+#define TARGET_TUNSETIFF=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TARGET_IOW(&#39=
;T&#39;, 202, int)<br>
+#define TARGET_TUNSETPERSIST=C2=A0 =C2=A0 =C2=A0 TARGET_IOW(&#39;T&#39;, 2=
03, int)<br>
+#define TARGET_TUNSETOWNER=C2=A0 =C2=A0 =C2=A0 =C2=A0 TARGET_IOW(&#39;T&#3=
9;, 204, int)<br>
+#define TARGET_TUNSETLINK=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TARGET_IOW(&#39=
;T&#39;, 205, int)<br>
+#define TARGET_TUNSETGROUP=C2=A0 =C2=A0 =C2=A0 =C2=A0 TARGET_IOW(&#39;T&#3=
9;, 206, int)<br>
+#define TARGET_TUNGETFEATURES=C2=A0 =C2=A0 =C2=A0TARGET_IOR(&#39;T&#39;, 2=
07, unsigned int)<br>
+#define TARGET_TUNSETOFFLOAD=C2=A0 =C2=A0 =C2=A0 TARGET_IOW(&#39;T&#39;, 2=
08, unsigned int)<br>
+#define TARGET_TUNSETTXFILTER=C2=A0 =C2=A0 =C2=A0TARGET_IOW(&#39;T&#39;, 2=
09, unsigned int)<br>
+#define TARGET_TUNGETIFF=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TARGET_IOR(&#39=
;T&#39;, 210, unsigned int)<br>
+#define TARGET_TUNGETSNDBUF=C2=A0 =C2=A0 =C2=A0 =C2=A0TARGET_IOR(&#39;T&#3=
9;, 211, int)<br>
+#define TARGET_TUNSETSNDBUF=C2=A0 =C2=A0 =C2=A0 =C2=A0TARGET_IOW(&#39;T&#3=
9;, 212, int)<br>
+/*<br>
+ * TUNATTACHFILTER and TUNDETACHFILTER are not supported. Linux kernel kee=
ps a<br>
+ * user pointer in TUNATTACHFILTER, which we are not able to correctly han=
dle.<br>
+ */<br>
+#define TARGET_TUNGETVNETHDRSZ=C2=A0 =C2=A0 TARGET_IOR(&#39;T&#39;, 215, i=
nt)<br>
+#define TARGET_TUNSETVNETHDRSZ=C2=A0 =C2=A0 TARGET_IOW(&#39;T&#39;, 216, i=
nt)<br>
+#define TARGET_TUNSETQUEUE=C2=A0 =C2=A0 =C2=A0 =C2=A0 TARGET_IOW(&#39;T&#3=
9;, 217, int)<br>
+#define TARGET_TUNSETIFINDEX=C2=A0 =C2=A0 =C2=A0 TARGET_IOW(&#39;T&#39;, 2=
18, unsigned int)<br>
+/* TUNGETFILTER is not supported: see TUNATTACHFILTER. */<br>
+#define TARGET_TUNSETVNETLE=C2=A0 =C2=A0 =C2=A0 =C2=A0TARGET_IOW(&#39;T&#3=
9;, 220, int)<br>
+#define TARGET_TUNGETVNETLE=C2=A0 =C2=A0 =C2=A0 =C2=A0TARGET_IOR(&#39;T&#3=
9;, 221, int)<br>
+#define TARGET_TUNSETVNETBE=C2=A0 =C2=A0 =C2=A0 =C2=A0TARGET_IOW(&#39;T&#3=
9;, 222, int)<br>
+#define TARGET_TUNGETVNETBE=C2=A0 =C2=A0 =C2=A0 =C2=A0TARGET_IOR(&#39;T&#3=
9;, 223, int)<br>
+#define TARGET_TUNSETSTEERINGEBPF TARGET_IOR(&#39;T&#39;, 224, int)<br>
+#define TARGET_TUNSETFILTEREBPF=C2=A0 =C2=A0TARGET_IOR(&#39;T&#39;, 225, i=
nt)<br>
+#define TARGET_TUNSETCARRIER=C2=A0 =C2=A0 =C2=A0 TARGET_IOW(&#39;T&#39;, 2=
26, int)<br>
+#define TARGET_TUNGETDEVNETNS=C2=A0 =C2=A0 =C2=A0TARGET_IO(&#39;T&#39;, 22=
7)<br>
+<br>
=C2=A0/* From &lt;linux/random.h&gt; */<br>
<br>
=C2=A0#define TARGET_RNDGETENTCNT=C2=A0 =C2=A0 TARGET_IOR(&#39;R&#39;, 0x00=
, int)<br>
-- <br>
2.28.0.rc0.142.g3c755180ce-goog<br>
<br>
</blockquote></div>

--00000000000013563c05ac29a7e7--

--000000000000189ee305ac29a766
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIPAAYJKoZIhvcNAQcCoIIO8TCCDu0CAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ggxjMIIEkjCCA3qgAwIBAgINAewckktV4F6Q7sAtGDANBgkqhkiG9w0BAQsFADBMMSAwHgYDVQQL
ExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UEAxMK
R2xvYmFsU2lnbjAeFw0xODA2MjAwMDAwMDBaFw0yODA2MjAwMDAwMDBaMEsxCzAJBgNVBAYTAkJF
MRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSEwHwYDVQQDExhHbG9iYWxTaWduIFNNSU1FIENB
IDIwMTgwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCUeobu8FdB5oJg6Fz6SFf8YsPI
dNcq4rBSiSDAwqMNYbeTpRrINMBdWuPqVWaBX7WHYMsKQwCOvAF1b7rkD+ROo+CCTJo76EAY25Pp
jt7TYP/PxoLesLQ+Ld088+BeyZg9pQaf0VK4tn23fOCWbFWoM8hdnF86Mqn6xB6nLsxJcz4CUGJG
qAhC3iedFiCfZfsIp2RNyiUhzPAqalkrtD0bZQvCgi5aSNJseNyCysS1yA58OuxEyn2e9itZJE+O
sUeD8VFgz+nAYI5r/dmFEXu5d9npLvTTrSJjrEmw2/ynKn6r6ONueZnCfo6uLmP1SSglhI/SN7dy
L1rKUCU7R1MjAgMBAAGjggFyMIIBbjAOBgNVHQ8BAf8EBAMCAYYwJwYDVR0lBCAwHgYIKwYBBQUH
AwIGCCsGAQUFBwMEBggrBgEFBQcDCTASBgNVHRMBAf8ECDAGAQH/AgEAMB0GA1UdDgQWBBRMtwWJ
1lPNI0Ci6A94GuRtXEzs0jAfBgNVHSMEGDAWgBSP8Et/qC5FJK5NUPpjmove4t0bvDA+BggrBgEF
BQcBAQQyMDAwLgYIKwYBBQUHMAGGImh0dHA6Ly9vY3NwMi5nbG9iYWxzaWduLmNvbS9yb290cjMw
NgYDVR0fBC8wLTAroCmgJ4YlaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9yb290LXIzLmNybDBn
BgNVHSAEYDBeMAsGCSsGAQQBoDIBKDAMBgorBgEEAaAyASgKMEEGCSsGAQQBoDIBXzA0MDIGCCsG
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
aHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wUQYIKwYBBQUHAQEERTBDMEEG
CCsGAQUFBzAChjVodHRwOi8vc2VjdXJlLmdsb2JhbHNpZ24uY29tL2NhY2VydC9nc3NtaW1lY2Ey
MDE4LmNydDAfBgNVHSMEGDAWgBRMtwWJ1lPNI0Ci6A94GuRtXEzs0jA/BgNVHR8EODA2MDSgMqAw
hi5odHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2NhL2dzc21pbWVjYTIwMTguY3JsMA0GCSqGSIb3
DQEBCwUAA4IBAQB0zgx4rAhCKzIVBMrEn4R/8FrisDQWZwJvA4VLbgtBPI1kP/Ys+cw3oYecxHED
MAHXOYclqmcaKudfjsLKZ/jrpdjZMAHDazo86g4BREWWiAxAtnMPhKrL4Ciqs0Yx/fj4VJlJRgES
1wscHQQNh2BgbqP15O5D2CtZVsLIuc9pSY3DZNYUrMQy55hszPnhgeghImVgNLtzUkF8oLKlnrWs
blvMc7fi7e42/rSnhbE6WUWGHvXcQ3+qIptP079GF+p1ZnEVmXIrQeoP1Rh0wS2ThPBorHqMY8OB
+c1AbPa2A/qY7QkFA6Oq7I8gUPNRO1NyuEElN4LJy+SCH0kWzLawMYICYTCCAl0CAQEwXzBLMQsw
CQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTEhMB8GA1UEAxMYR2xvYmFsU2ln
biBTTUlNRSBDQSAyMDE4AhAB2NRaeBKJjaSQ9CGctwQsMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqG
SIb3DQEJBDEiBCBGyDSFEbD4AbTO96Yzdp5EBEaP+zHLYfvk7O//rLFWdzAYBgkqhkiG9w0BCQMx
CwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yMDA4MDUyMzIzMDBaMGkGCSqGSIb3DQEJDzFc
MFowCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJ
KoZIhvcNAQEKMAsGCSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAo4ZY
MKBEp6yh88A1B09CKtzjXWwrkPVCKi32tzKdd9Mpi02iIU8BUH1Gv99YY+2moG91jRZptwSURNXV
iPMhnbujpoPjx7suYETLhqcoH0c8XWC1cBFT+jwRVNEBxTiz/nqnaWV2p6kONGMR/0LkcwA2DQ2k
XZQ86yZR8+/1nxQy3fS1G4CB9svDGj2qe3kkHYvApkGRP2kOvEBI1Lf3btTJa1OSRpEs6KorQXkW
kknDOhQQpMc3+Tycj3Y/q/JeumT4tti1+HA4sb+7FaHQNVkkH55hwUUPKSKX+XNtSz3fHxQ48ZJY
4lbS4mDqEvEbnXeZB35wLRU8q4KJnNHKCQ==
--000000000000189ee305ac29a766--

