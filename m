Return-Path: <SRS0=3KIA=4V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D674C3F2D1
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 08:01:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 179DB20866
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 08:01:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ihAF8l8Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 179DB20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58566 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9Oxl-0002An-7T
	for qemu-devel@archiver.kernel.org; Wed, 04 Mar 2020 03:01:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51053)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1j9OwW-0001aG-Ay
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 02:59:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1j9OwU-0003Lu-CT
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 02:59:48 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:37026)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1j9OwT-0003Fr-FA; Wed, 04 Mar 2020 02:59:45 -0500
Received: by mail-oi1-x241.google.com with SMTP id q65so1199181oif.4;
 Tue, 03 Mar 2020 23:59:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=nAA0ECN+YiquK4Xp6XWjIb0W3XtCV5F6HrPNs0hF5qc=;
 b=ihAF8l8YAJXgtnU9JTKdecdGx/bIZsAU0LgtaVyv3A2QXRWKfzn/lhocBfPHYnxHHp
 dxJwnRnoebvtXutuNSiyAhmD3KClIw5Dg0zxmwPrJAThIPJIqpAdKeM0LtEyDnfcBgxG
 d3Z6dsP1/SuZmN6pMJo5KSHgGaNff7+kAbeXixEAHusjl/d/9CfK/VAi3e8Eb5HNGB6F
 bdmAS0J05Y6irC4c5Oyhe6TMZoY5NIXuP/MbdrLDtFSHncxmYyjfrMoAV1SIwkY5fwhm
 lYWGnjFslGimfqeAHGtcFevXPHvmsrRTVFyddq0FXkhQALVs1PoFqTEXxyHLoySNoKOt
 GdQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=nAA0ECN+YiquK4Xp6XWjIb0W3XtCV5F6HrPNs0hF5qc=;
 b=DUI/jcq9tw5nw3wly9BRai8uOmd7Er8U1CQ0v5Zo+zLjhmuMTCYILrAb1UxmLcVGWe
 WGFxM9zaN4zKTCiGnMxcm3Czd1wrVgwz77t+T4xmkLWla4WkJr1pRSg0tyhvJPdpm7uu
 u4f3n27k3//k/lQkT5Yo58c23BMkI3f9Y/tgDkLZxxVk0/nAw7d7p8JrIWl9olQmkTv0
 SkwtUlKYK/h5vH/WyLEqDdrOSGlNIGX2i0HNW74KhmB7GWlts1Ir0VF20eDCzG3oJPMf
 qJ8q378V4p/T3LWUPpZP4rPmiaD6+xb7+MyTZW/Gy2ApLwkJTCPNu/CXRhwGjGeVqUM2
 +m+Q==
X-Gm-Message-State: ANhLgQ3resN4zSl6L4RcF/IEak8kxxTeGfk+64WTLR3Ivbgic5hZ8BVe
 vzu1gxlBo7ArLkULb81qh5T1qcVWAlVrm+hKa00=
X-Google-Smtp-Source: ADFU+vuD5oxfSR9x61+Yip3c4ND5jPBQCvcWt06mhfCE6O318i2kqDaiIrQ4PqWGofFcW2bVFbY1ucyd7A0deu6MeCw=
X-Received: by 2002:aca:c3c5:: with SMTP id t188mr931923oif.53.1583308784247; 
 Tue, 03 Mar 2020 23:59:44 -0800 (PST)
MIME-Version: 1.0
References: <cover.1583282640.git.alistair.francis@wdc.com>
 <406774cf394d785da30a30d99169f0b2cf1bb1de.1583282640.git.alistair.francis@wdc.com>
In-Reply-To: <406774cf394d785da30a30d99169f0b2cf1bb1de.1583282640.git.alistair.francis@wdc.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Wed, 4 Mar 2020 08:59:26 +0100
Message-ID: <CAL1e-=iQwKrze3biSJgxyWh=tMP6F1JAHx_A51f7LcTej6x+Og@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] linux-user/syscall: Add support for
 clock_gettime64/clock_settime64
To: Alistair Francis <Alistair.Francis@wdc.com>
Content-Type: multipart/alternative; boundary="000000000000a7a56b05a002cd84"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
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
Cc: palmer@dabbelt.com, "open list:RISC-V" <qemu-riscv@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, alistair23@gmail.com,
 laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000a7a56b05a002cd84
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

1:53 AM Sre, 04.03.2020. Alistair Francis <alistair.francis@wdc.com> =D1=98=
=D0=B5
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> Add support for the clock_gettime64/clock_settime64 syscalls. Currently
> we only support these syscalls when running on 64-bit hosts.
>

For clarity, "Currently we only support" should be replaced with "This
patch supports only".

> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  linux-user/syscall.c | 43 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
>
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index c000fb07c5..82468e018d 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -1236,6 +1236,22 @@ static inline abi_long
target_to_host_timespec(struct timespec *host_ts,
>  }
>  #endif
>
> +#if defined(TARGET_NR_clock_settime64) && HOST_LONG_BITS =3D=3D 64
> +static inline abi_long target_to_host_timespec64(struct timespec
*host_ts,
> +                                                 abi_ulong target_addr)
> +{
> +    struct target_timespec *target_ts;
> +
> +    if (!lock_user_struct(VERIFY_READ, target_ts, target_addr, 1)) {
> +        return -TARGET_EFAULT;
> +    }
> +    __get_user(host_ts->tv_sec, &target_ts->tv_sec);
> +    __get_user(host_ts->tv_nsec, &target_ts->tv_nsec);
> +    unlock_user_struct(target_ts, target_addr, 0);
> +    return 0;
> +}
> +#endif
> +
>  static inline abi_long host_to_target_timespec(abi_ulong target_addr,
>                                                 struct timespec *host_ts)
>  {
> @@ -11465,6 +11481,20 @@ static abi_long do_syscall1(void *cpu_env, int
num, abi_long arg1,
>          return ret;
>      }
>  #endif
> +#ifdef TARGET_NR_clock_settime64
> +# if HOST_LONG_BITS =3D=3D 64
> +    case TARGET_NR_clock_settime64:
> +    {
> +        struct timespec ts;
> +
> +        ret =3D target_to_host_timespec64(&ts, arg2);
> +        if (!is_error(ret)) {
> +            ret =3D get_errno(clock_settime(arg1, &ts));
> +        }
> +        return ret;
> +    }
> +# endif
> +#endif
>  #ifdef TARGET_NR_clock_gettime
>      case TARGET_NR_clock_gettime:
>      {
> @@ -11476,6 +11506,19 @@ static abi_long do_syscall1(void *cpu_env, int
num, abi_long arg1,
>          return ret;
>      }
>  #endif
> +#ifdef TARGET_NR_clock_gettime64
> +# if HOST_LONG_BITS =3D=3D 64
> +    case TARGET_NR_clock_gettime64:
> +    {
> +        struct timespec ts;
> +        ret =3D get_errno(clock_gettime(arg1, &ts));
> +        if (!is_error(ret)) {
> +            ret =3D host_to_target_timespec64(arg2, &ts);
> +        }
> +        return ret;
> +    }
> +# endif
> +#endif
>  #ifdef TARGET_NR_clock_getres
>      case TARGET_NR_clock_getres:
>      {
> --

Nice patch for the first version, still I think the patch could be much
better.

Why not support 32-bit hosts? If a 32-bit host supports
clock_<get|set>time64(), the mapping is obvious. If not, the implementation
could be "best effort" based, using host's clock_<get|set>time().

Regards,
Aleksandar

> 2.25.1
>
>

--000000000000a7a56b05a002cd84
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"></p>
<p dir=3D"ltr">1:53 AM Sre, 04.03.2020. Alistair Francis &lt;<a href=3D"mai=
lto:alistair.francis@wdc.com">alistair.francis@wdc.com</a>&gt; =D1=98=D0=B5=
 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:<br>
&gt;<br>
&gt; Add support for the clock_gettime64/clock_settime64 syscalls. Currentl=
y<br>
&gt; we only support these syscalls when running on 64-bit hosts.<br>
&gt;</p>
<p dir=3D"ltr">For clarity, &quot;Currently we only support&quot; should be=
 replaced with &quot;This patch supports only&quot;.</p>
<p dir=3D"ltr">&gt; Signed-off-by: Alistair Francis &lt;<a href=3D"mailto:a=
listair.francis@wdc.com">alistair.francis@wdc.com</a>&gt;<br>
&gt; ---<br>
&gt; =C2=A0linux-user/syscall.c | 43 ++++++++++++++++++++++++++++++++++++++=
+++++<br>
&gt; =C2=A01 file changed, 43 insertions(+)<br>
&gt;<br>
&gt; diff --git a/linux-user/syscall.c b/linux-user/syscall.c<br>
&gt; index c000fb07c5..82468e018d 100644<br>
&gt; --- a/linux-user/syscall.c<br>
&gt; +++ b/linux-user/syscall.c<br>
&gt; @@ -1236,6 +1236,22 @@ static inline abi_long target_to_host_timespec(=
struct timespec *host_ts,<br>
&gt; =C2=A0}<br>
&gt; =C2=A0#endif<br>
&gt;<br>
&gt; +#if defined(TARGET_NR_clock_settime64) &amp;&amp; HOST_LONG_BITS =3D=
=3D 64<br>
&gt; +static inline abi_long target_to_host_timespec64(struct timespec *hos=
t_ts,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0abi_ulong target_addr)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 struct target_timespec *target_ts;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (!lock_user_struct(VERIFY_READ, target_ts, target_ad=
dr, 1)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -TARGET_EFAULT;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 __get_user(host_ts-&gt;tv_sec, &amp;target_ts-&gt;tv_se=
c);<br>
&gt; +=C2=A0 =C2=A0 __get_user(host_ts-&gt;tv_nsec, &amp;target_ts-&gt;tv_n=
sec);<br>
&gt; +=C2=A0 =C2=A0 unlock_user_struct(target_ts, target_addr, 0);<br>
&gt; +=C2=A0 =C2=A0 return 0;<br>
&gt; +}<br>
&gt; +#endif<br>
&gt; +<br>
&gt; =C2=A0static inline abi_long host_to_target_timespec(abi_ulong target_=
addr,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 struct timespec *host_ts)<br>
&gt; =C2=A0{<br>
&gt; @@ -11465,6 +11481,20 @@ static abi_long do_syscall1(void *cpu_env, in=
t num, abi_long arg1,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt; =C2=A0 =C2=A0 =C2=A0}<br>
&gt; =C2=A0#endif<br>
&gt; +#ifdef TARGET_NR_clock_settime64<br>
&gt; +# if HOST_LONG_BITS =3D=3D 64<br>
&gt; +=C2=A0 =C2=A0 case TARGET_NR_clock_settime64:<br>
&gt; +=C2=A0 =C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct timespec ts;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D target_to_host_timespec64(&amp;ts=
, arg2);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!is_error(ret)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D get_errno(clock_set=
time(arg1, &amp;ts));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +# endif<br>
&gt; +#endif<br>
&gt; =C2=A0#ifdef TARGET_NR_clock_gettime<br>
&gt; =C2=A0 =C2=A0 =C2=A0case TARGET_NR_clock_gettime:<br>
&gt; =C2=A0 =C2=A0 =C2=A0{<br>
&gt; @@ -11476,6 +11506,19 @@ static abi_long do_syscall1(void *cpu_env, in=
t num, abi_long arg1,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt; =C2=A0 =C2=A0 =C2=A0}<br>
&gt; =C2=A0#endif<br>
&gt; +#ifdef TARGET_NR_clock_gettime64<br>
&gt; +# if HOST_LONG_BITS =3D=3D 64<br>
&gt; +=C2=A0 =C2=A0 case TARGET_NR_clock_gettime64:<br>
&gt; +=C2=A0 =C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct timespec ts;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D get_errno(clock_gettime(arg1, &am=
p;ts));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!is_error(ret)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D host_to_target_time=
spec64(arg2, &amp;ts);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +# endif<br>
&gt; +#endif<br>
&gt; =C2=A0#ifdef TARGET_NR_clock_getres<br>
&gt; =C2=A0 =C2=A0 =C2=A0case TARGET_NR_clock_getres:<br>
&gt; =C2=A0 =C2=A0 =C2=A0{<br>
&gt; -- </p>
<p dir=3D"ltr">Nice patch for the first version, still I think the patch co=
uld be much better.</p>
<p dir=3D"ltr">Why not support 32-bit hosts? If a 32-bit host supports cloc=
k_&lt;get|set&gt;time64(), the mapping is obvious. If not, the implementati=
on could be &quot;best effort&quot; based, using host&#39;s clock_&lt;get|s=
et&gt;time().</p>
<p dir=3D"ltr">Regards,<br>
Aleksandar</p>
<p dir=3D"ltr">&gt; 2.25.1<br>
&gt;<br>
&gt;<br>
</p>

--000000000000a7a56b05a002cd84--

