Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 094E1C433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 09:35:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36B1520714
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 09:35:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j1Wx3gVo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36B1520714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSGia-00039Y-6i
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 05:35:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42140)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kSGhT-0002SD-Bx
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 05:34:31 -0400
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:46300)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kSGhR-0004XO-1Z
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 05:34:31 -0400
Received: by mail-lj1-x244.google.com with SMTP id c21so19659141ljn.13
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2020 02:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=oDPTjb1Ec7JY6DpFgHwNJmwNmxEjsjimWKj0Ubrh36w=;
 b=j1Wx3gVog8CZVjJJQlkTyj24APglcEKDGBTgWx8uWxlXucliPHRME6jDu0VzwWATQ6
 TZu4u5xJUFT9j/1ViP/6hVrI4VEocQPHhebWiuIkHRoHKN5Nldq0HXOHV1v4Lazg4oo/
 bK+I/Aht8rOHT5afb31lpyjXdt2H/Ppst/BDgfkyb8ocR6NIs2wygjwJAIX9KIIdEEWJ
 4GdcbKuZT6ebye7k3u8oWHPvLWp+aBWNvxQVZRbkUKIAQpjJxrMsfoJje8TqUHjjAhoe
 Pd5LLY6396zXpKYBhDRf5hLjOeZOMkY0GlQfaDLosB6yKObmJuxQOiHMaMVXfhJws+mg
 iJaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=oDPTjb1Ec7JY6DpFgHwNJmwNmxEjsjimWKj0Ubrh36w=;
 b=CSnwD/uu1DICUv8ZtdqOQyvljYCv+O9DJ0kuxIrBe73SRDMSg7nluYCyL+jVSqn1V5
 zC05c+QpVjS8SSPojdJyPFXOzseyB39ceI7/UXezMaQS+/IXC02Zcf/CMqzaK5eRysrG
 lleZHAcHqn+/ssSjqvNxDjIOshARkWclyjGiDD7F/T0Fdf7mKTYwkiw+ihX9G18DFzyw
 gE7VNBwdNlLB8Oip0A8TXYNE73qSWG6oiXGoyFhHr9E8Uo9H1ZwpSzMzWo4Wfr3tcqyT
 CLee6uirUHN4+fvRVEufldXEL4eRX5Fs1xDF/lWyl8nzpwzxiFHCld+e0piWwnbGMx3z
 uMsA==
X-Gm-Message-State: AOAM532N3Z1ZaCtHKXAqKwnnywdhLdoFrCXM5QJlyAFcbs8GQ2oaZoC4
 a6ZsVoUE00luogKC1daqe8ii94b8eKmv58LLFpk=
X-Google-Smtp-Source: ABdhPJzzK/ipca9r+pWHE5WqdZ4agGtlWzeNjpcv9XshWekULGhIvDAJkROeK0PjvQu7z5751chm/yK490h/DRtmKX8=
X-Received: by 2002:a2e:87c9:: with SMTP id v9mr8354211ljj.368.1602581667148; 
 Tue, 13 Oct 2020 02:34:27 -0700 (PDT)
MIME-Version: 1.0
References: <20201012220620.124408-1-linus.walleij@linaro.org>
In-Reply-To: <20201012220620.124408-1-linus.walleij@linaro.org>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Tue, 13 Oct 2020 17:34:14 +0800
Message-ID: <CAE2XoE99b+9E7T0+f=qH-pinDr=J+AUTGWzZigFNJaJZD_sO7A@mail.gmail.com>
Subject: Re: [PATCH v3 RESEND] fcntl: Add 32bit filesystem mode
To: Linus Walleij <linus.walleij@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000fe789605b18a1ee4"
Received-SPF: pass client-ip=2a00:1450:4864:20::244;
 envelope-from=luoyonggang@gmail.com; helo=mail-lj1-x244.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: luoyonggang@gmail.com
Cc: Peter Maydell <peter.maydell@linaro.org>, Theodore Ts'o <tytso@mit.edu>,
 linux-api@vger.kernel.org, qemu-level <qemu-devel@nongnu.org>,
 Florian Weimer <fw@deneb.enyo.de>, Andreas Dilger <adilger.kernel@dilger.ca>,
 Andy Lutomirski <luto@kernel.org>, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000fe789605b18a1ee4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2020 at 6:09 AM Linus Walleij <linus.walleij@linaro.org>
wrote:
>
> It was brought to my attention that this bug from 2018 was
> still unresolved: 32 bit emulators like QEMU were given
> 64 bit hashes when running 32 bit emulation on 64 bit systems.
>
> This adds a flag to the fcntl() F_GETFD and F_SETFD operations
> to set the underlying filesystem into 32bit mode even if the
> file handle was opened using 64bit mode without the compat
> syscalls.
I've also seens this when running i386 inside WSL by qemu,
It's seems the same issue I am facing.
>
> Programs that need the 32 bit file system behavior need to
> issue a fcntl() system call such as in this example:
>
>   #define FD_32BIT_MODE 2
>
>   int main(int argc, char** argv) {
>     DIR* dir;
>     int err;
>     int fd;
>
>     dir =3D opendir("/boot");
>     fd =3D dirfd(dir);
>     err =3D fcntl(fd, F_SETFD, FD_32BIT_MODE);
>     if (err) {
>       printf("fcntl() failed! err=3D%d\n", err);
>       return 1;
>     }
>     printf("dir=3D%p\n", dir);
>     printf("readdir(dir)=3D%p\n", readdir(dir));
>     printf("errno=3D%d: %s\n", errno, strerror(errno));
>     return 0;
>   }
>
> This can be pretty hard to test since C libraries and linux
> userspace security extensions aggressively filter the parameters
> that are passed down and allowed to commit into actual system
> calls.
>
> Cc: Florian Weimer <fw@deneb.enyo.de>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Andy Lutomirski <luto@kernel.org>
> Suggested-by: Theodore Ts'o <tytso@mit.edu>
> Link: https://bugs.launchpad.net/qemu/+bug/1805913
> Link: https://lore.kernel.org/lkml/87bm56vqg4.fsf@mid.deneb.enyo.de/
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=3D205957
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v3->v3 RESEND 1:
> - Resending during the v5.10 merge window to get attention.
> ChangeLog v2->v3:
> - Realized that I also have to clear the flag correspondingly
>   if someone ask for !FD_32BIT_MODE after setting it the
>   first time.
> ChangeLog v1->v2:
> - Use a new flag FD_32BIT_MODE to F_GETFD and F_SETFD
>   instead of a new fcntl operation, there is already a fcntl
>   operation to set random flags.
> - Sorry for taking forever to respin this patch :(
> ---
>  fs/fcntl.c                       | 7 +++++++
>  include/uapi/asm-generic/fcntl.h | 8 ++++++++
>  2 files changed, 15 insertions(+)
>
> diff --git a/fs/fcntl.c b/fs/fcntl.c
> index 19ac5baad50f..6c32edc4099a 100644
> --- a/fs/fcntl.c
> +++ b/fs/fcntl.c
> @@ -335,10 +335,17 @@ static long do_fcntl(int fd, unsigned int cmd,
unsigned long arg,
>                 break;
>         case F_GETFD:
>                 err =3D get_close_on_exec(fd) ? FD_CLOEXEC : 0;
> +               /* Report 32bit file system mode */
> +               if (filp->f_mode & FMODE_32BITHASH)
> +                       err |=3D FD_32BIT_MODE;
>                 break;
>         case F_SETFD:
>                 err =3D 0;
>                 set_close_on_exec(fd, arg & FD_CLOEXEC);
> +               if (arg & FD_32BIT_MODE)
> +                       filp->f_mode |=3D FMODE_32BITHASH;
> +               else
> +                       filp->f_mode &=3D ~FMODE_32BITHASH;
>                 break;
>         case F_GETFL:
>                 err =3D filp->f_flags;
> diff --git a/include/uapi/asm-generic/fcntl.h
b/include/uapi/asm-generic/fcntl.h
> index 9dc0bf0c5a6e..edd3573cb7ef 100644
> --- a/include/uapi/asm-generic/fcntl.h
> +++ b/include/uapi/asm-generic/fcntl.h
> @@ -160,6 +160,14 @@ struct f_owner_ex {
>
>  /* for F_[GET|SET]FL */
>  #define FD_CLOEXEC     1       /* actually anything with low bit set
goes */
> +/*
> + * This instructs the kernel to provide 32bit semantics (such as hashes)
from
> + * the file system layer, when running a userland that depend on 32bit
> + * semantics on a kernel that supports 64bit userland, but does not use
the
> + * compat ioctl() for e.g. open(), so that the kernel would otherwise
assume
> + * that the userland process is capable of dealing with 64bit semantics.
> + */
> +#define FD_32BIT_MODE  2
>
>  /* for posix fcntl() and lockf() */
>  #ifndef F_RDLCK
> --
> 2.26.2
>
>


--
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--000000000000fe789605b18a1ee4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br>On Tue, Oct 13, 2020 at 6:09 AM Linus Walleij &lt;=
<a href=3D"mailto:linus.walleij@linaro.org">linus.walleij@linaro.org</a>&gt=
; wrote:<br>&gt;<br>&gt; It was brought to my attention that this bug from =
2018 was<br>&gt; still unresolved: 32 bit emulators like QEMU were given<br=
>&gt; 64 bit hashes when running 32 bit emulation on 64 bit systems.<br>&gt=
;<br>&gt; This adds a flag to the fcntl() F_GETFD and F_SETFD operations<br=
>&gt; to set the underlying filesystem into 32bit mode even if the<br>&gt; =
file handle was opened using 64bit mode without the compat<br>&gt; syscalls=
.<div>I&#39;ve also seens this when running i386 inside WSL by qemu,</div><=
div>It&#39;s seems the same issue I am facing.<br>&gt;<br>&gt; Programs tha=
t need the 32 bit file system behavior need to<br>&gt; issue a fcntl() syst=
em call such as in this example:<br>&gt;<br>&gt; =C2=A0 #define FD_32BIT_MO=
DE 2<br>&gt;<br>&gt; =C2=A0 int main(int argc, char** argv) {<br>&gt; =C2=
=A0 =C2=A0 DIR* dir;<br>&gt; =C2=A0 =C2=A0 int err;<br>&gt; =C2=A0 =C2=A0 i=
nt fd;<br>&gt;<br>&gt; =C2=A0 =C2=A0 dir =3D opendir(&quot;/boot&quot;);<br=
>&gt; =C2=A0 =C2=A0 fd =3D dirfd(dir);<br>&gt; =C2=A0 =C2=A0 err =3D fcntl(=
fd, F_SETFD, FD_32BIT_MODE);<br>&gt; =C2=A0 =C2=A0 if (err) {<br>&gt; =C2=
=A0 =C2=A0 =C2=A0 printf(&quot;fcntl() failed! err=3D%d\n&quot;, err);<br>&=
gt; =C2=A0 =C2=A0 =C2=A0 return 1;<br>&gt; =C2=A0 =C2=A0 }<br>&gt; =C2=A0 =
=C2=A0 printf(&quot;dir=3D%p\n&quot;, dir);<br>&gt; =C2=A0 =C2=A0 printf(&q=
uot;readdir(dir)=3D%p\n&quot;, readdir(dir));<br>&gt; =C2=A0 =C2=A0 printf(=
&quot;errno=3D%d: %s\n&quot;, errno, strerror(errno));<br>&gt; =C2=A0 =C2=
=A0 return 0;<br>&gt; =C2=A0 }<br>&gt;<br>&gt; This can be pretty hard to t=
est since C libraries and linux<br>&gt; userspace security extensions aggre=
ssively filter the parameters<br>&gt; that are passed down and allowed to c=
ommit into actual system<br>&gt; calls.<br>&gt;<br>&gt; Cc: Florian Weimer =
&lt;<a href=3D"mailto:fw@deneb.enyo.de">fw@deneb.enyo.de</a>&gt;<br>&gt; Cc=
: Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org">peter.mayde=
ll@linaro.org</a>&gt;<br>&gt; Cc: Andy Lutomirski &lt;<a href=3D"mailto:lut=
o@kernel.org">luto@kernel.org</a>&gt;<br>&gt; Suggested-by: Theodore Ts&#39=
;o &lt;<a href=3D"mailto:tytso@mit.edu">tytso@mit.edu</a>&gt;<br>&gt; Link:=
 <a href=3D"https://bugs.launchpad.net/qemu/+bug/1805913">https://bugs.laun=
chpad.net/qemu/+bug/1805913</a><br>&gt; Link: <a href=3D"https://lore.kerne=
l.org/lkml/87bm56vqg4.fsf@mid.deneb.enyo.de/">https://lore.kernel.org/lkml/=
87bm56vqg4.fsf@mid.deneb.enyo.de/</a><br>&gt; Bugzilla: <a href=3D"https://=
bugzilla.kernel.org/show_bug.cgi?id=3D205957">https://bugzilla.kernel.org/s=
how_bug.cgi?id=3D205957</a><br>&gt; Signed-off-by: Linus Walleij &lt;<a hre=
f=3D"mailto:linus.walleij@linaro.org">linus.walleij@linaro.org</a>&gt;<br>&=
gt; ---<br>&gt; ChangeLog v3-&gt;v3 RESEND 1:<br>&gt; - Resending during th=
e v5.10 merge window to get attention.<br>&gt; ChangeLog v2-&gt;v3:<br>&gt;=
 - Realized that I also have to clear the flag correspondingly<br>&gt; =C2=
=A0 if someone ask for !FD_32BIT_MODE after setting it the<br>&gt; =C2=A0 f=
irst time.<br>&gt; ChangeLog v1-&gt;v2:<br>&gt; - Use a new flag FD_32BIT_M=
ODE to F_GETFD and F_SETFD<br>&gt; =C2=A0 instead of a new fcntl operation,=
 there is already a fcntl<br>&gt; =C2=A0 operation to set random flags.<br>=
&gt; - Sorry for taking forever to respin this patch :(<br>&gt; ---<br>&gt;=
 =C2=A0fs/fcntl.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 | 7 +++++++<br>&gt; =C2=A0include/uapi/asm-generic/fcn=
tl.h | 8 ++++++++<br>&gt; =C2=A02 files changed, 15 insertions(+)<br>&gt;<b=
r>&gt; diff --git a/fs/fcntl.c b/fs/fcntl.c<br>&gt; index 19ac5baad50f..6c3=
2edc4099a 100644<br>&gt; --- a/fs/fcntl.c<br>&gt; +++ b/fs/fcntl.c<br>&gt; =
@@ -335,10 +335,17 @@ static long do_fcntl(int fd, unsigned int cmd, unsign=
ed long arg,<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 break;<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 case F_GETFD:<br>&gt; =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D get_close_on_exec=
(fd) ? FD_CLOEXEC : 0;<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 /* Report 32bit file system mode */<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (filp-&gt;f_mode &amp; FMODE_32BITHASH)<br>&=
gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 err |=3D FD_32BIT_MODE;<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 break;<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 case F_SETF=
D:<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D =
0;<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 set_clos=
e_on_exec(fd, arg &amp; FD_CLOEXEC);<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 if (arg &amp; FD_32BIT_MODE)<br>&gt; + =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 filp-&gt;f_m=
ode |=3D FMODE_32BITHASH;<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 else<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 filp-&gt;f_mode &amp;=3D ~FMODE_32BITHASH;<br>&=
gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>&gt; =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 case F_GETFL:<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D filp-&gt;f_flags;<br>&gt; diff --gi=
t a/include/uapi/asm-generic/fcntl.h b/include/uapi/asm-generic/fcntl.h<br>=
&gt; index 9dc0bf0c5a6e..edd3573cb7ef 100644<br>&gt; --- a/include/uapi/asm=
-generic/fcntl.h<br>&gt; +++ b/include/uapi/asm-generic/fcntl.h<br>&gt; @@ =
-160,6 +160,14 @@ struct f_owner_ex {<br>&gt;<br>&gt; =C2=A0/* for F_[GET|S=
ET]FL */<br>&gt; =C2=A0#define FD_CLOEXEC =C2=A0 =C2=A0 1 =C2=A0 =C2=A0 =C2=
=A0 /* actually anything with low bit set goes */<br>&gt; +/*<br>&gt; + * T=
his instructs the kernel to provide 32bit semantics (such as hashes) from<b=
r>&gt; + * the file system layer, when running a userland that depend on 32=
bit<br>&gt; + * semantics on a kernel that supports 64bit userland, but doe=
s not use the<br>&gt; + * compat ioctl() for e.g. open(), so that the kerne=
l would otherwise assume<br>&gt; + * that the userland process is capable o=
f dealing with 64bit semantics.<br>&gt; + */<br>&gt; +#define FD_32BIT_MODE=
 =C2=A02<br>&gt;<br>&gt; =C2=A0/* for posix fcntl() and lockf() */<br>&gt; =
=C2=A0#ifndef F_RDLCK<br>&gt; --<br>&gt; 2.26.2<br>&gt;<br>&gt;<br><br><br>=
--<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=E6=AD=A4=E8=87=B4<br>=E7=A4=BC<br>=
=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=A0 sincerely,<br>Yonggan=
g Luo</div></div>

--000000000000fe789605b18a1ee4--

