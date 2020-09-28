Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.9 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CCEEC2D0A8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 16:54:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DE972074A
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 16:54:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v0ZpXE0b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DE972074A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMwPj-0002AF-Cv
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 12:54:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40808)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <scw@google.com>) id 1kMwOG-0001DE-RY
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 12:52:41 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:33829)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <scw@google.com>) id 1kMwOD-0002yA-Dv
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 12:52:40 -0400
Received: by mail-ed1-x542.google.com with SMTP id k14so2149067edo.1
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2020 09:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=3slzntq008JGcijt64ttc0K1G4vzLSG3ZXVt6PaBeuc=;
 b=v0ZpXE0b+TYMdoYpEjML9Jc6b7UPjGdagf9UVPR/OJOfDbTz5kcW0h3F2w9mfE11mP
 wIMRC788ZofWcxPm/AsKn40BsB02Ttf66AZxJ4x/qDaloBE6dFFyzXlSg+gdzgl2E8IA
 denwy5oKdnRt81a/6tgGiCAEyo2VbpikePEvVsWebZJIQ+IUxpjtE0QCpf3BUNhFVGKQ
 pq1kR2a4PLbloGro+D5WgXuMml31odgmM2GEZLT3kzhHwYEwlCa+yo/iI8QZMO6/8A1H
 KU6jniUnBCGHslXhBzb882SaQ2G6UDGhzKHmNop8sfGlML9TnDdLzisKmgLe90BH2A/6
 8T1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=3slzntq008JGcijt64ttc0K1G4vzLSG3ZXVt6PaBeuc=;
 b=h1DnUrqCFpErZjsSIFONSwahPmoK0DkZnC+G8vXJJz4QNF7YqM8ggUoj8RB8j7+bGZ
 Jd1sh8m6BB3kcCPBq60DkWqiUJNnkvkAGb/GntCc2Hp/87zF/jKnn2MvOR+l9UULZUsN
 IpcUjBjghtMxELXgyez/rGx/kHNnanX90lxTgYZ2BrsbGIvITS8YqBf3bqDLxMfDMIcQ
 kPk+kc1jQxxOmV6+sc7wZ6K/P1q482BSBntl8h2KUttC9+BnSFBohnYy7R/0yScRaRPw
 fBrSjCEwzVaMfCX04W5Sapvw2nJkyZ4D9KttAdZqQcXm9funT0HLJvjZzV+pqALCXaAp
 wgww==
X-Gm-Message-State: AOAM533f0ImSe37j8FgV45Lea2T7HypVgSxUtiAndxhzFhwBKOk5sk36
 U6pMj3c5SJWEL1HzqHQBGEP9PF80+JcBm/Z5NgtzJw==
X-Google-Smtp-Source: ABdhPJz31iOaz5ZPLiU0lsjCB+bZECWYPcgPtolUVlTIw8vtNftTe810EDI5flWS8+ikEg7q1GwbACughW38r9mj374=
X-Received: by 2002:aa7:d4d2:: with SMTP id t18mr2753383edr.55.1601311954188; 
 Mon, 28 Sep 2020 09:52:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200723231020.769893-1-scw@google.com>
 <5f73f9b9-53dd-b483-4eed-07ab9d660ed1@vivier.eu>
In-Reply-To: <5f73f9b9-53dd-b483-4eed-07ab9d660ed1@vivier.eu>
From: Shu-Chun Weng <scw@google.com>
Date: Mon, 28 Sep 2020 09:52:22 -0700
Message-ID: <CAF3nBxjJn++0O5iAgO8-bxDo=+LQj=2sJTkYJWWvbgdh_QXUYw@mail.gmail.com>
Subject: Re: [PATCH v2] linux-user: Add most IFTUN ioctls
To: Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel@nongnu.org, Riku Voipio <riku.voipio@iki.fi>,
 Josh Kunz <jkz@google.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="0000000000003aa21005b0627e13"
Received-SPF: pass client-ip=2a00:1450:4864:20::542;
 envelope-from=scw@google.com; helo=mail-ed1-x542.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -180
X-Spam_score: -18.1
X-Spam_bar: ------------------
X-Spam_report: (-18.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.468,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
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

--0000000000003aa21005b0627e13
Content-Type: multipart/alternative; boundary="0000000000003497a605b0627e3d"

--0000000000003497a605b0627e3d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 26, 2020 at 9:44 AM Laurent Vivier <laurent@vivier.eu> wrote:

> Le 24/07/2020 =C3=A0 01:10, Shu-Chun Weng a =C3=A9crit :
> > The three options handling `struct sock_fprog` (TUNATTACHFILTER,
> > TUNDETACHFILTER, and TUNGETFILTER) are not implemented. Linux kernel
> > keeps a user space pointer in them which we cannot correctly handle.
> >
> > Signed-off-by: Josh Kunz <jkz@google.com>
> > Signed-off-by: Shu-Chun Weng <scw@google.com>
> > ---
> > v2:
> >   Title changed from "linux-user: Add several IFTUN ioctls"
> >
> >   Properly specify the argument types for various options, including a
> custom
> >   implementation for TUNSETTXFILTER.
> >
> >   #ifdef guards for macros introduced up to 5 years ago.
> >
> >  linux-user/ioctls.h       | 45 +++++++++++++++++++++++++++++++++++++++
> >  linux-user/syscall.c      | 36 +++++++++++++++++++++++++++++++
> >  linux-user/syscall_defs.h | 32 ++++++++++++++++++++++++++++
> >  3 files changed, 113 insertions(+)
> >
> > diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
> > index 0713ae1311..b9fb01f558 100644
> > --- a/linux-user/ioctls.h
> > +++ b/linux-user/ioctls.h
> > @@ -593,3 +593,48 @@
> >    IOCTL(KCOV_DISABLE, 0, TYPE_NULL)
> >    IOCTL(KCOV_INIT_TRACE, IOC_R, TYPE_ULONG)
> >  #endif
> > +
> > +  IOCTL(TUNSETDEBUG,     IOC_W, TYPE_INT)
> > +  IOCTL(TUNSETIFF,       IOC_RW, MK_PTR(MK_STRUCT(STRUCT_short_ifreq))=
)
>
> Why is this IOC_RW?
>

R:
https://github.com/torvalds/linux/blob/a1b8638ba1320e6684aa98233c15255eb803=
fac7/drivers/net/tun.c#L3010
W:
https://github.com/torvalds/linux/blob/a1b8638ba1320e6684aa98233c15255eb803=
fac7/drivers/net/tun.c#L3046

More specifically, the call may update ifr->ifr_name:
https://github.com/torvalds/linux/blob/a1b8638ba1320e6684aa98233c15255eb803=
fac7/drivers/net/tun.c#L2821


>
> > +  IOCTL(TUNSETPERSIST,   IOC_W, TYPE_INT)
> > +  IOCTL(TUNSETOWNER,     IOC_W, TYPE_INT)
> > +  IOCTL(TUNSETLINK,      IOC_W, TYPE_INT)
> > +  IOCTL(TUNSETGROUP,     IOC_W, TYPE_INT)
> > +  IOCTL(TUNGETFEATURES,  IOC_R, MK_PTR(TYPE_INT))
> > +  IOCTL(TUNSETOFFLOAD,   IOC_W, TYPE_LONG)
>
> Why is this long?
>

Appears to be a bitmask:
https://github.com/torvalds/linux/blob/a1b8638ba1320e6684aa98233c15255eb803=
fac7/drivers/net/tun.c#L2853


>
> > +  IOCTL_SPECIAL(TUNSETTXFILTER, IOC_W, do_ioctl_TUNSETTXFILTER,
> > +                /*
> > +                 * We can't represent `struct tun_filter` in thunk so
> leaving
> > +                 * this empty. do_ioctl_TUNSETTXFILTER will do the
> conversion.
> > +                 */
> > +                TYPE_NULL)
>
> You should use TYPE_PTRVOID to allow QEMU_STRACE to display the pointer.
> Or implement the function to dump the structure (see STRUCT_termios and
> struct_termios_def).
>

Will change to TYPE_PTRVOID. `struct tun_filter` uses flexible arrays (
https://github.com/torvalds/linux/blob/a4d63c3732f1a0c91abcf5b7f32b4ef7dcd8=
2025/include/uapi/linux/if_tun.h#L111)
and can't even be written with custom converters because the structure size
isn't fixed.

IIRC, it can be implemented on top of my other patch which adds flexible
array support to the thunk infrastructure
https://lists.nongnu.org/archive/html/qemu-devel/2020-08/msg01949.html


>
> > +  IOCTL(TUNGETIFF,       IOC_R, MK_PTR(MK_STRUCT(STRUCT_short_ifreq)))
> > +  IOCTL(TUNGETSNDBUF,    IOC_R, MK_PTR(TYPE_INT))
> > +  IOCTL(TUNSETSNDBUF,    IOC_W, MK_PTR(TYPE_INT))
> > +  /*
> > +   * TUNATTACHFILTER and TUNDETACHFILTER are not supported. Linux
> kernel keeps a
> > +   * user pointer in TUNATTACHFILTER, which we are not able to
> correctly handle.
> > +   */
> > +  IOCTL(TUNGETVNETHDRSZ, IOC_R, MK_PTR(TYPE_INT))
> > +  IOCTL(TUNSETVNETHDRSZ, IOC_W, MK_PTR(TYPE_INT))
> > +  IOCTL(TUNSETQUEUE,     IOC_W, MK_PTR(MK_STRUCT(STRUCT_short_ifreq)))
> > +  IOCTL(TUNSETIFINDEX ,  IOC_W, MK_PTR(TYPE_INT))
> > +  /* TUNGETFILTER is not supported: see TUNATTACHFILTER. */
> > +  IOCTL(TUNSETVNETLE,    IOC_W, MK_PTR(TYPE_INT))
> > +  IOCTL(TUNGETVNETLE,    IOC_R, MK_PTR(TYPE_INT))
> > +#ifdef TUNSETVNETBE
> > +  IOCTL(TUNSETVNETBE,    IOC_W, MK_PTR(TYPE_INT))
> > +  IOCTL(TUNGETVNETBE,    IOC_R, MK_PTR(TYPE_INT))
> > +#endif
> > +#ifdef TUNSETSTEERINGEBPF
> > +  IOCTL(TUNSETSTEERINGEBPF, IOC_W, MK_PTR(TYPE_INT))
> > +#endif
> > +#ifdef TUNSETFILTEREBPF
> > +  IOCTL(TUNSETFILTEREBPF, IOC_W, MK_PTR(TYPE_INT))
> > +#endif
> > +#ifdef TUNSETCARRIER
> > +  IOCTL(TUNSETCARRIER,   IOC_W, MK_PTR(TYPE_INT))
> > +#endif
> > +#ifdef TUNGETDEVNETNS
> > +  IOCTL(TUNGETDEVNETNS,  IOC_R, TYPE_NULL)
> > +#endif
> > diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> > index 1211e759c2..7f1efed189 100644
> > --- a/linux-user/syscall.c
> > +++ b/linux-user/syscall.c
> > @@ -56,6 +56,7 @@
> >  #include <linux/wireless.h>
> >  #include <linux/icmp.h>
> >  #include <linux/icmpv6.h>
> > +#include <linux/if_tun.h>
> >  #include <linux/errqueue.h>
> >  #include <linux/random.h>
> >  #ifdef CONFIG_TIMERFD
> > @@ -5422,6 +5423,41 @@ static abi_long do_ioctl_drm(const IOCTLEntry
> *ie, uint8_t *buf_temp,
> >
> >  #endif
> >
> > +static abi_long do_ioctl_TUNSETTXFILTER(const IOCTLEntry *ie, uint8_t
> *buf_temp,
> > +                                        int fd, int cmd, abi_long arg)
> > +{
> > +    struct tun_filter *filter =3D (struct tun_filter *)buf_temp;
> > +    struct tun_filter *target_filter;
> > +    char *target_addr;
> > +
> > +    assert(ie->access =3D=3D IOC_W);
> > +
> > +    target_filter =3D lock_user(VERIFY_READ, arg, sizeof(*filter), 1);
>
> sizeof(*target_filter) vould be more coherent: we lock the target memory
> so use the size of the type of the target.
>
> > +    if (!target_filter) {
> > +        return -TARGET_EFAULT;
> > +    }
> > +    filter->flags =3D tswap16(target_filter->flags);
> > +    filter->count =3D tswap16(target_filter->count);
> > +    unlock_user(target_filter, arg, sizeof(*filter));
>
> unlock_user(target_filter, arg, 0) as we don't need to copy the value
> back to the target.
>
> > +
> > +    if (filter->count) {
> > +        if (sizeof(*filter) + filter->count * ETH_ALEN >
> MAX_STRUCT_SIZE) {
>
> Rather than sizeof() use offsetof(struct tun_filter, addr)
>
> > +            return -TARGET_EFAULT;
> > +        }
> > +
> > +        target_addr =3D lock_user(VERIFY_READ, arg + sizeof(*filter),
>
> Rather than sizeof() use offsetof(struct tun_filter, addr)
>
> > +                                filter->count * ETH_ALEN, 1);
> > +        if (!target_addr) {
> > +            return -TARGET_EFAULT;
> > +        }
> > +        memcpy(filter->addr, target_addr, filter->count * ETH_ALEN);
> > +        unlock_user(target_addr, arg + sizeof(*filter),
>
>  offsetof(struct tun_filter, addr)
>

All changes in syscall.c applied. Will send out v3 soon.

Thank you very much!

Shu-Chun


>
> Thanks,
> Laurent
>

--0000000000003497a605b0627e3d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Sat, Sep 26, 2020 at 9:44 AM Laure=
nt Vivier &lt;<a href=3D"mailto:laurent@vivier.eu">laurent@vivier.eu</a>&gt=
; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Le 24/0=
7/2020 =C3=A0 01:10, Shu-Chun Weng a =C3=A9crit=C2=A0:<br>
&gt; The three options handling `struct sock_fprog` (TUNATTACHFILTER,<br>
&gt; TUNDETACHFILTER, and TUNGETFILTER) are not implemented. Linux kernel<b=
r>
&gt; keeps a user space pointer in them which we cannot correctly handle.<b=
r>
&gt; <br>
&gt; Signed-off-by: Josh Kunz &lt;<a href=3D"mailto:jkz@google.com" target=
=3D"_blank" class=3D"cremed">jkz@google.com</a>&gt;<br>
&gt; Signed-off-by: Shu-Chun Weng &lt;<a href=3D"mailto:scw@google.com" tar=
get=3D"_blank" class=3D"cremed">scw@google.com</a>&gt;<br>
&gt; ---<br>
&gt; v2:<br>
&gt;=C2=A0 =C2=A0Title changed from &quot;linux-user: Add several IFTUN ioc=
tls&quot;<br>
&gt; <br>
&gt;=C2=A0 =C2=A0Properly specify the argument types for various options, i=
ncluding a custom<br>
&gt;=C2=A0 =C2=A0implementation for TUNSETTXFILTER.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0#ifdef guards for macros introduced up to 5 years ago.<br>
&gt; <br>
&gt;=C2=A0 linux-user/ioctls.h=C2=A0 =C2=A0 =C2=A0 =C2=A0| 45 +++++++++++++=
++++++++++++++++++++++++++<br>
&gt;=C2=A0 linux-user/syscall.c=C2=A0 =C2=A0 =C2=A0 | 36 ++++++++++++++++++=
+++++++++++++<br>
&gt;=C2=A0 linux-user/syscall_defs.h | 32 ++++++++++++++++++++++++++++<br>
&gt;=C2=A0 3 files changed, 113 insertions(+)<br>
&gt; <br>
&gt; diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h<br>
&gt; index 0713ae1311..b9fb01f558 100644<br>
&gt; --- a/linux-user/ioctls.h<br>
&gt; +++ b/linux-user/ioctls.h<br>
&gt; @@ -593,3 +593,48 @@<br>
&gt;=C2=A0 =C2=A0 IOCTL(KCOV_DISABLE, 0, TYPE_NULL)<br>
&gt;=C2=A0 =C2=A0 IOCTL(KCOV_INIT_TRACE, IOC_R, TYPE_ULONG)<br>
&gt;=C2=A0 #endif<br>
&gt; +<br>
&gt; +=C2=A0 IOCTL(TUNSETDEBUG,=C2=A0 =C2=A0 =C2=A0IOC_W, TYPE_INT)<br>
&gt; +=C2=A0 IOCTL(TUNSETIFF,=C2=A0 =C2=A0 =C2=A0 =C2=A0IOC_RW, MK_PTR(MK_S=
TRUCT(STRUCT_short_ifreq)))<br>
<br>
Why is this IOC_RW?<br></blockquote><div><br></div><div>R:=C2=A0<a href=3D"=
https://github.com/torvalds/linux/blob/a1b8638ba1320e6684aa98233c15255eb803=
fac7/drivers/net/tun.c#L3010">https://github.com/torvalds/linux/blob/a1b863=
8ba1320e6684aa98233c15255eb803fac7/drivers/net/tun.c#L3010</a></div><div>W:=
=C2=A0<a href=3D"https://github.com/torvalds/linux/blob/a1b8638ba1320e6684a=
a98233c15255eb803fac7/drivers/net/tun.c#L3046">https://github.com/torvalds/=
linux/blob/a1b8638ba1320e6684aa98233c15255eb803fac7/drivers/net/tun.c#L3046=
</a></div><div><br></div><div>More specifically, the call may update ifr-&g=
t;ifr_name:=C2=A0<a href=3D"https://github.com/torvalds/linux/blob/a1b8638b=
a1320e6684aa98233c15255eb803fac7/drivers/net/tun.c#L2821">https://github.co=
m/torvalds/linux/blob/a1b8638ba1320e6684aa98233c15255eb803fac7/drivers/net/=
tun.c#L2821</a></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex">
<br>
&gt; +=C2=A0 IOCTL(TUNSETPERSIST,=C2=A0 =C2=A0IOC_W, TYPE_INT)<br>
&gt; +=C2=A0 IOCTL(TUNSETOWNER,=C2=A0 =C2=A0 =C2=A0IOC_W, TYPE_INT)<br>
&gt; +=C2=A0 IOCTL(TUNSETLINK,=C2=A0 =C2=A0 =C2=A0 IOC_W, TYPE_INT)<br>
&gt; +=C2=A0 IOCTL(TUNSETGROUP,=C2=A0 =C2=A0 =C2=A0IOC_W, TYPE_INT)<br>
&gt; +=C2=A0 IOCTL(TUNGETFEATURES,=C2=A0 IOC_R, MK_PTR(TYPE_INT))<br>
&gt; +=C2=A0 IOCTL(TUNSETOFFLOAD,=C2=A0 =C2=A0IOC_W, TYPE_LONG)<br>
<br>
Why is this long?<br></blockquote><div><br></div><div>Appears to be a bitma=
sk: <a href=3D"https://github.com/torvalds/linux/blob/a1b8638ba1320e6684aa9=
8233c15255eb803fac7/drivers/net/tun.c#L2853">https://github.com/torvalds/li=
nux/blob/a1b8638ba1320e6684aa98233c15255eb803fac7/drivers/net/tun.c#L2853</=
a></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; +=C2=A0 IOCTL_SPECIAL(TUNSETTXFILTER, IOC_W, do_ioctl_TUNSETTXFILTER,<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* We ca=
n&#39;t represent `struct tun_filter` in thunk so leaving<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* this =
empty. do_ioctl_TUNSETTXFILTER will do the conversion.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TYPE_NULL)<br=
>
<br>
You should use TYPE_PTRVOID to allow QEMU_STRACE to display the pointer.<br=
>
Or implement the function to dump the structure (see STRUCT_termios and<br>
struct_termios_def).<br></blockquote><div><br></div><div>Will change to TYP=
E_PTRVOID. `struct tun_filter` uses flexible arrays (<a href=3D"https://git=
hub.com/torvalds/linux/blob/a4d63c3732f1a0c91abcf5b7f32b4ef7dcd82025/includ=
e/uapi/linux/if_tun.h#L111">https://github.com/torvalds/linux/blob/a4d63c37=
32f1a0c91abcf5b7f32b4ef7dcd82025/include/uapi/linux/if_tun.h#L111</a>) and =
can&#39;t even be written with custom converters because the structure size=
 isn&#39;t fixed.</div><div><br></div><div>IIRC, it can be implemented on t=
op of my other patch which adds flexible array support to the thunk infrast=
ructure <a href=3D"https://lists.nongnu.org/archive/html/qemu-devel/2020-08=
/msg01949.html">https://lists.nongnu.org/archive/html/qemu-devel/2020-08/ms=
g01949.html</a></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex">
<br>
&gt; +=C2=A0 IOCTL(TUNGETIFF,=C2=A0 =C2=A0 =C2=A0 =C2=A0IOC_R, MK_PTR(MK_ST=
RUCT(STRUCT_short_ifreq)))<br>
&gt; +=C2=A0 IOCTL(TUNGETSNDBUF,=C2=A0 =C2=A0 IOC_R, MK_PTR(TYPE_INT))<br>
&gt; +=C2=A0 IOCTL(TUNSETSNDBUF,=C2=A0 =C2=A0 IOC_W, MK_PTR(TYPE_INT))<br>
&gt; +=C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0* TUNATTACHFILTER and TUNDETACHFILTER are not supported.=
 Linux kernel keeps a<br>
&gt; +=C2=A0 =C2=A0* user pointer in TUNATTACHFILTER, which we are not able=
 to correctly handle.<br>
&gt; +=C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 IOCTL(TUNGETVNETHDRSZ, IOC_R, MK_PTR(TYPE_INT))<br>
&gt; +=C2=A0 IOCTL(TUNSETVNETHDRSZ, IOC_W, MK_PTR(TYPE_INT))<br>
&gt; +=C2=A0 IOCTL(TUNSETQUEUE,=C2=A0 =C2=A0 =C2=A0IOC_W, MK_PTR(MK_STRUCT(=
STRUCT_short_ifreq)))<br>
&gt; +=C2=A0 IOCTL(TUNSETIFINDEX ,=C2=A0 IOC_W, MK_PTR(TYPE_INT))<br>
&gt; +=C2=A0 /* TUNGETFILTER is not supported: see TUNATTACHFILTER. */<br>
&gt; +=C2=A0 IOCTL(TUNSETVNETLE,=C2=A0 =C2=A0 IOC_W, MK_PTR(TYPE_INT))<br>
&gt; +=C2=A0 IOCTL(TUNGETVNETLE,=C2=A0 =C2=A0 IOC_R, MK_PTR(TYPE_INT))<br>
&gt; +#ifdef TUNSETVNETBE<br>
&gt; +=C2=A0 IOCTL(TUNSETVNETBE,=C2=A0 =C2=A0 IOC_W, MK_PTR(TYPE_INT))<br>
&gt; +=C2=A0 IOCTL(TUNGETVNETBE,=C2=A0 =C2=A0 IOC_R, MK_PTR(TYPE_INT))<br>
&gt; +#endif<br>
&gt; +#ifdef TUNSETSTEERINGEBPF<br>
&gt; +=C2=A0 IOCTL(TUNSETSTEERINGEBPF, IOC_W, MK_PTR(TYPE_INT))<br>
&gt; +#endif<br>
&gt; +#ifdef TUNSETFILTEREBPF<br>
&gt; +=C2=A0 IOCTL(TUNSETFILTEREBPF, IOC_W, MK_PTR(TYPE_INT))<br>
&gt; +#endif<br>
&gt; +#ifdef TUNSETCARRIER<br>
&gt; +=C2=A0 IOCTL(TUNSETCARRIER,=C2=A0 =C2=A0IOC_W, MK_PTR(TYPE_INT))<br>
&gt; +#endif<br>
&gt; +#ifdef TUNGETDEVNETNS<br>
&gt; +=C2=A0 IOCTL(TUNGETDEVNETNS,=C2=A0 IOC_R, TYPE_NULL)<br>
&gt; +#endif<br>
&gt; diff --git a/linux-user/syscall.c b/linux-user/syscall.c<br>
&gt; index 1211e759c2..7f1efed189 100644<br>
&gt; --- a/linux-user/syscall.c<br>
&gt; +++ b/linux-user/syscall.c<br>
&gt; @@ -56,6 +56,7 @@<br>
&gt;=C2=A0 #include &lt;linux/wireless.h&gt;<br>
&gt;=C2=A0 #include &lt;linux/icmp.h&gt;<br>
&gt;=C2=A0 #include &lt;linux/icmpv6.h&gt;<br>
&gt; +#include &lt;linux/if_tun.h&gt;<br>
&gt;=C2=A0 #include &lt;linux/errqueue.h&gt;<br>
&gt;=C2=A0 #include &lt;linux/random.h&gt;<br>
&gt;=C2=A0 #ifdef CONFIG_TIMERFD<br>
&gt; @@ -5422,6 +5423,41 @@ static abi_long do_ioctl_drm(const IOCTLEntry *=
ie, uint8_t *buf_temp,<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 #endif<br>
&gt;=C2=A0 <br>
&gt; +static abi_long do_ioctl_TUNSETTXFILTER(const IOCTLEntry *ie, uint8_t=
 *buf_temp,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int =
fd, int cmd, abi_long arg)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 struct tun_filter *filter =3D (struct tun_filter *)buf_=
temp;<br>
&gt; +=C2=A0 =C2=A0 struct tun_filter *target_filter;<br>
&gt; +=C2=A0 =C2=A0 char *target_addr;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 assert(ie-&gt;access =3D=3D IOC_W);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 target_filter =3D lock_user(VERIFY_READ, arg, sizeof(*f=
ilter), 1);<br>
<br>
sizeof(*target_filter) vould be more coherent: we lock the target memory<br=
>
so use the size of the type of the target.<br>
<br>
&gt; +=C2=A0 =C2=A0 if (!target_filter) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -TARGET_EFAULT;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 filter-&gt;flags =3D tswap16(target_filter-&gt;flags);<=
br>
&gt; +=C2=A0 =C2=A0 filter-&gt;count =3D tswap16(target_filter-&gt;count);<=
br>
&gt; +=C2=A0 =C2=A0 unlock_user(target_filter, arg, sizeof(*filter));<br>
<br>
unlock_user(target_filter, arg, 0) as we don&#39;t need to copy the value<b=
r>
back to the target.<br>
<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (filter-&gt;count) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (sizeof(*filter) + filter-&gt;count * =
ETH_ALEN &gt; MAX_STRUCT_SIZE) {<br>
<br>
Rather than sizeof() use offsetof(struct tun_filter, addr)<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -TARGET_EFAULT;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 target_addr =3D lock_user(VERIFY_READ, ar=
g + sizeof(*filter),<br>
<br>
Rather than sizeof() use offsetof(struct tun_filter, addr)<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 filter-&gt;count * ETH_ALEN, 1);=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!target_addr) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -TARGET_EFAULT;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 memcpy(filter-&gt;addr, target_addr, filt=
er-&gt;count * ETH_ALEN);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 unlock_user(target_addr, arg + sizeof(*fi=
lter),<br>
<br>
=C2=A0offsetof(struct tun_filter, addr)<br></blockquote><div><br></div><div=
>All changes in syscall.c applied. Will send out v3 soon.</div><div><br></d=
iv><div>Thank you very much!</div><div><br></div><div>Shu-Chun</div><div>=
=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Thanks,<br>
Laurent<br>
</blockquote></div></div>

--0000000000003497a605b0627e3d--

--0000000000003aa21005b0627e13
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIPkgYJKoZIhvcNAQcCoIIPgzCCD38CAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ggzsMIIEtjCCA56gAwIBAgIQeAMYYHb81ngUVR0WyMTzqzANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA3MjgwMDAwMDBaFw0yOTAzMTgwMDAwMDBaMFQxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFz
IFIzIFNNSU1FIENBIDIwMjAwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCvLe9xPU9W
dpiHLAvX7kFnaFZPuJLey7LYaMO8P/xSngB9IN73mVc7YiLov12Fekdtn5kL8PjmDBEvTYmWsuQS
6VBo3vdlqqXZ0M9eMkjcKqijrmDRleudEoPDzTumwQ18VB/3I+vbN039HIaRQ5x+NHGiPHVfk6Rx
c6KAbYceyeqqfuJEcq23vhTdium/Bf5hHqYUhuJwnBQ+dAUcFndUKMJrth6lHeoifkbw2bv81zxJ
I9cvIy516+oUekqiSFGfzAqByv41OrgLV4fLGCDH3yRh1tj7EtV3l2TngqtrDLUs5R+sWIItPa/4
AJXB1Q3nGNl2tNjVpcSn0uJ7aFPbAgMBAAGjggGKMIIBhjAOBgNVHQ8BAf8EBAMCAYYwHQYDVR0l
BBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMBIGA1UdEwEB/wQIMAYBAf8CAQAwHQYDVR0OBBYEFHzM
CmjXouseLHIb0c1dlW+N+/JjMB8GA1UdIwQYMBaAFI/wS3+oLkUkrk1Q+mOai97i3Ru8MHsGCCsG
AQUFBwEBBG8wbTAuBggrBgEFBQcwAYYiaHR0cDovL29jc3AyLmdsb2JhbHNpZ24uY29tL3Jvb3Ry
MzA7BggrBgEFBQcwAoYvaHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvcm9vdC1y
My5jcnQwNgYDVR0fBC8wLTAroCmgJ4YlaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9yb290LXIz
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
--0000000000003aa21005b0627e13--

