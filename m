Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0437EC433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 07:09:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B578220716
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 07:09:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DsvyV2Gb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B578220716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDjMu-0005KV-SI
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 03:09:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36176)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kDjMG-0004un-Ih
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 03:08:32 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:40745)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kDjME-0007zO-MU
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 03:08:32 -0400
Received: by mail-lj1-x243.google.com with SMTP id s205so2317653lja.7
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 00:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=+p/MohhaJEAuGgwgS0LbFj7E3XtTQmDAeSRN1EzZHv4=;
 b=DsvyV2GbafQITHIBqewATPXpzHN3GZltgwtNA7PS0hjKF7gqCRZQrJD2uUsfGbEW/+
 ZMl0XYAo4xR7kJxRwILL54Y1tP34VAnD9lS2jBbvpJuKsy4iKQxLgaWla7sI45YJUgtr
 nP5+byK7CvOhUzP/Wb+YWwki9P8FnIL1FrduFubCy+dTH4FWkwHRgqaoBbsa2FEBCToj
 8uPMDu2xqC6b9rIwZ+oGydIhYExALnsIJIYnXrg1HiVHcdFxe0PvIshT3iniVBTHTw6P
 9bLmDJoXaYV0IlgK4l1zMhTw5b1BsqTxK1c94pgO0Lmt2EsXqw11Cizp5hYu8FN0yP2F
 lUvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=+p/MohhaJEAuGgwgS0LbFj7E3XtTQmDAeSRN1EzZHv4=;
 b=MOtJrhNHoSJfrC2BoILOwWiLQbjVZXqTcxkcBXWcO5PxsUP4j62rF3jhi87TfEZS8M
 xYrTpwoAmnr8yWndwih/hOQYrLsd5Ct/3VZSIDZ9/wlwlvVGuNrG7diNHFnhif9x2zK9
 gBLXDRPCQWdSHt8xnuJX5T6szuOucwJx7UCSm7z5/OKxeY4SHl+22XxHxORjqqwaqWxX
 cdZd+7xJTxKQnX/v8fTmszHAXJoedO2nKDSAiewG/gdh+deygpJv7RZIvrFTp2Wbo9MB
 wjMOadY1FldBjOUy2h77D3RBQep1isVYGVPrD1tswE9jD16hY14MxdHBuJLBN1qAYPpm
 7qXw==
X-Gm-Message-State: AOAM5314+Q/GWR9VdmudzA6GWOjHhxn7KGdYG8vr1GWMBjTBMPzyQKr5
 cUZcOUM0lM1RDXs5IMh9S/xEavBxFUGkdv7LZbAt4/rZ8tolDA==
X-Google-Smtp-Source: ABdhPJwl8Kisn+k062ot+OX1VkwCYsexW/Ox9UokuHjGLpmK9Rgtaom92Pl9CAl8qoXHY+++DYgAUMxpnt7DJmGWxnc=
X-Received: by 2002:a05:651c:1119:: with SMTP id
 d25mr464411ljo.300.1599116908795; 
 Thu, 03 Sep 2020 00:08:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200903054503.425435-1-thuth@redhat.com>
In-Reply-To: <20200903054503.425435-1-thuth@redhat.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Thu, 3 Sep 2020 15:08:17 +0800
Message-ID: <CAE2XoE85T-BcpDqKSO7Buc8MxSZ-jsQEV+8BsTXoShHz=eOwDw@mail.gmail.com>
Subject: Re: [PATCH] stubs: Move qemu_fd_register stub to util/main-loop.c
To: Thomas Huth <thuth@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000004d9cb405ae636bde"
Received-SPF: pass client-ip=2a00:1450:4864:20::243;
 envelope-from=luoyonggang@gmail.com; helo=mail-lj1-x243.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-level <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000004d9cb405ae636bde
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I am also facing some problem alike:

  LINK    tests/test-qdev-global-props.exe
  LINK    tests/test-timed-average.exe
C:/CI-Tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../.=
./../x86_64-w64-mingw32/bin/ld.exe:
libqemuutil.a(util_main-loop.c.obj): in function `qemu_notify_event':
C:\work\xemu\qemu-build/../qemu/util/main-loop.c:139: multiple definition
of `qemu_notify_event';
libqemuutil.a(stubs_notify-event.c.obj):C:\work\xemu\qemu-build/../qemu/stu=
bs/notify-event.c:6:
first defined here
collect2.exe: error: ld returned 1 exit status
make: *** [C:/work/xemu/qemu/rules.mak:88=EF=BC=9Atests/test-timed-average.=
exe] =E9=94=99=E8=AF=AF 1

On Thu, Sep 3, 2020 at 1:46 PM Thomas Huth <thuth@redhat.com> wrote:

> The linker of MinGW sometimes runs into the following problem:
>
> libqemuutil.a(util_main-loop.c.obj): In function `qemu_fd_register':
> /builds/huth/qemu/build/../util/main-loop.c:331: multiple definition of
>  `qemu_fd_register'
>
> libqemuutil.a(stubs_fd-register.c.obj):/builds/huth/qemu/stubs/fd-registe=
r.c:5:
>  first defined here
> collect2: error: ld returned 1 exit status
> /builds/huth/qemu/rules.mak:88: recipe for target
> 'tests/test-timed-average.exe'
>  failed
>
> qemu_fd_register() is defined in util/main-loop.c for WIN32, so let's
> simply
> move the stub also there in the #else part of the corresponding #ifndef
> to fix this problem.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  stubs/fd-register.c | 6 ------
>  stubs/meson.build   | 1 -
>  util/main-loop.c    | 4 ++++
>  3 files changed, 4 insertions(+), 7 deletions(-)
>  delete mode 100644 stubs/fd-register.c
>
> diff --git a/stubs/fd-register.c b/stubs/fd-register.c
> deleted file mode 100644
> index 63a4abdb20..0000000000
> --- a/stubs/fd-register.c
> +++ /dev/null
> @@ -1,6 +0,0 @@
> -#include "qemu/osdep.h"
> -#include "qemu/main-loop.h"
> -
> -void qemu_fd_register(int fd)
> -{
> -}
> diff --git a/stubs/meson.build b/stubs/meson.build
> index e2dfedc2a7..e0b322bc28 100644
> --- a/stubs/meson.build
> +++ b/stubs/meson.build
> @@ -9,7 +9,6 @@ stub_ss.add(files('cpu-get-clock.c'))
>  stub_ss.add(files('cpu-get-icount.c'))
>  stub_ss.add(files('dump.c'))
>  stub_ss.add(files('error-printf.c'))
> -stub_ss.add(files('fd-register.c'))
>  stub_ss.add(files('fdset.c'))
>  stub_ss.add(files('fw_cfg.c'))
>  stub_ss.add(files('gdbstub.c'))
> diff --git a/util/main-loop.c b/util/main-loop.c
> index f69f055013..217c8d6056 100644
> --- a/util/main-loop.c
> +++ b/util/main-loop.c
> @@ -179,6 +179,10 @@ static int max_priority;
>  static int glib_pollfds_idx;
>  static int glib_n_poll_fds;
>
> +void qemu_fd_register(int fd)
> +{
> +}
> +
>  static void glib_pollfds_fill(int64_t *cur_timeout)
>  {
>      GMainContext *context =3D g_main_context_default();
> --
> 2.18.2
>
>
>

--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--0000000000004d9cb405ae636bde
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>I am also facing some problem alike:</div><div><br></=
div><div>=C2=A0 LINK =C2=A0 =C2=A0tests/test-qdev-global-props.exe<br>=C2=
=A0 LINK =C2=A0 =C2=A0tests/test-timed-average.exe<br>C:/CI-Tools/msys64/mi=
ngw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../../../x86_64-w64-mingw=
32/bin/ld.exe: libqemuutil.a(util_main-loop.c.obj): in function `qemu_notif=
y_event&#39;:<br>C:\work\xemu\qemu-build/../qemu/util/main-loop.c:139: mult=
iple definition of `qemu_notify_event&#39;; libqemuutil.a(stubs_notify-even=
t.c.obj):C:\work\xemu\qemu-build/../qemu/stubs/notify-event.c:6: first defi=
ned here<br>collect2.exe: error: ld returned 1 exit status<br>make: *** [C:=
/work/xemu/qemu/rules.mak:88=EF=BC=9Atests/test-timed-average.exe] =E9=94=
=99=E8=AF=AF 1<br></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" cla=
ss=3D"gmail_attr">On Thu, Sep 3, 2020 at 1:46 PM Thomas Huth &lt;<a href=3D=
"mailto:thuth@redhat.com">thuth@redhat.com</a>&gt; wrote:<br></div><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px=
 solid rgb(204,204,204);padding-left:1ex">The linker of MinGW sometimes run=
s into the following problem:<br>
<br>
libqemuutil.a(util_main-loop.c.obj): In function `qemu_fd_register&#39;:<br=
>
/builds/huth/qemu/build/../util/main-loop.c:331: multiple definition of<br>
=C2=A0`qemu_fd_register&#39;<br>
libqemuutil.a(stubs_fd-register.c.obj):/builds/huth/qemu/stubs/fd-register.=
c:5:<br>
=C2=A0first defined here<br>
collect2: error: ld returned 1 exit status<br>
/builds/huth/qemu/rules.mak:88: recipe for target &#39;tests/test-timed-ave=
rage.exe&#39;<br>
=C2=A0failed<br>
<br>
qemu_fd_register() is defined in util/main-loop.c for WIN32, so let&#39;s s=
imply<br>
move the stub also there in the #else part of the corresponding #ifndef<br>
to fix this problem.<br>
<br>
Signed-off-by: Thomas Huth &lt;<a href=3D"mailto:thuth@redhat.com" target=
=3D"_blank">thuth@redhat.com</a>&gt;<br>
---<br>
=C2=A0stubs/fd-register.c | 6 ------<br>
=C2=A0stubs/meson.build=C2=A0 =C2=A0| 1 -<br>
=C2=A0util/main-loop.c=C2=A0 =C2=A0 | 4 ++++<br>
=C2=A03 files changed, 4 insertions(+), 7 deletions(-)<br>
=C2=A0delete mode 100644 stubs/fd-register.c<br>
<br>
diff --git a/stubs/fd-register.c b/stubs/fd-register.c<br>
deleted file mode 100644<br>
index 63a4abdb20..0000000000<br>
--- a/stubs/fd-register.c<br>
+++ /dev/null<br>
@@ -1,6 +0,0 @@<br>
-#include &quot;qemu/osdep.h&quot;<br>
-#include &quot;qemu/main-loop.h&quot;<br>
-<br>
-void qemu_fd_register(int fd)<br>
-{<br>
-}<br>
diff --git a/stubs/meson.build b/stubs/meson.build<br>
index e2dfedc2a7..e0b322bc28 100644<br>
--- a/stubs/meson.build<br>
+++ b/stubs/meson.build<br>
@@ -9,7 +9,6 @@ stub_ss.add(files(&#39;cpu-get-clock.c&#39;))<br>
=C2=A0stub_ss.add(files(&#39;cpu-get-icount.c&#39;))<br>
=C2=A0stub_ss.add(files(&#39;dump.c&#39;))<br>
=C2=A0stub_ss.add(files(&#39;error-printf.c&#39;))<br>
-stub_ss.add(files(&#39;fd-register.c&#39;))<br>
=C2=A0stub_ss.add(files(&#39;fdset.c&#39;))<br>
=C2=A0stub_ss.add(files(&#39;fw_cfg.c&#39;))<br>
=C2=A0stub_ss.add(files(&#39;gdbstub.c&#39;))<br>
diff --git a/util/main-loop.c b/util/main-loop.c<br>
index f69f055013..217c8d6056 100644<br>
--- a/util/main-loop.c<br>
+++ b/util/main-loop.c<br>
@@ -179,6 +179,10 @@ static int max_priority;<br>
=C2=A0static int glib_pollfds_idx;<br>
=C2=A0static int glib_n_poll_fds;<br>
<br>
+void qemu_fd_register(int fd)<br>
+{<br>
+}<br>
+<br>
=C2=A0static void glib_pollfds_fill(int64_t *cur_timeout)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0GMainContext *context =3D g_main_context_default();<br>
-- <br>
2.18.2<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =E6=AD=A4=E8=
=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=
=A0 sincerely,<br>Yonggang Luo<br></div></div>

--0000000000004d9cb405ae636bde--

