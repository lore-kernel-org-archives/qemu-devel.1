Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6446C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 16:37:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 939A822D37
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 16:37:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q+3q1fOG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 939A822D37
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAFSv-0000Dg-SH
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 12:37:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56712)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kAFSK-0008D3-NM
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 12:36:24 -0400
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642]:43326)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kAFSJ-0007JB-1K
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 12:36:24 -0400
Received: by mail-ej1-x642.google.com with SMTP id m22so12709555eje.10
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2020 09:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=s0d9YG45Z+EX4DH+3DBnyDUD3m6wTfn6LFkEUob8EdU=;
 b=q+3q1fOGLd6l8Q9Tiq4Ao+sql6vvQz8xJvmWQg9fkR7ZH09Fc2UXmS+FthnP7HL7oM
 HOF6z3E1Kdvi+CnxK0bIF284eyrvH52FJs1l+ObebMFcLRM477R486Gwqy9HYDn/nzSu
 IuVg6OzdVBoGt+0/pYWcpHIW8NedCsIHVkh3Vg6sIGet8vSBPUY1r8tCJ5eh+BhEUhTJ
 WBKpd9/RkcF7tsoF6Ab9uI4sDfeCEQQhi0y4Falrc6PSz9WQYoRKdPWW8hKVuRhkv0zY
 upfbigzLjbiEIiAL8OzWQBHhci8KKjAOy9rLI3mH4vaClPZWFqn+NBGaN1O7F7gK1cad
 KzNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=s0d9YG45Z+EX4DH+3DBnyDUD3m6wTfn6LFkEUob8EdU=;
 b=igoewNcGDl33x+Rv1OkHUdwaN97h8vib2Q9rSwrgwfpMRhhtmn88yEm1NCjB2EFePZ
 EJT6pgk3IGJDCuiCgSXjg+idMAWdqZi1JhYMZ1lRmDVm8e/L09zeThiMOmXInP5bz2wU
 l8+VE3brIDzVp+PZHJ3Ure+/H2mbbOE0z5wWcyAZVH03KQdNC3WU1MN0vfS5udRZ76r2
 3Fe3kLQUFZOQK8+Og698Z05pizS/BsrHU7hHJcXp334g+tFjUJY8O7HUjxclGRuoUMTr
 94IRRpFxI2cYF/2EdTQuLQYIwRyXgHmwHetXULW6o6x6LwYx22Rt/DEJHy+EIspW1NPa
 F/zw==
X-Gm-Message-State: AOAM533VPo1EUjqIxISqDGPoLwNGZvlvJmhiy+cDHNU4CzcEZJTpHyLu
 dlqpGAhLXAcWdA1G9d+Q1KTbJI9i0K1lKIZHW4E=
X-Google-Smtp-Source: ABdhPJxl3J295azbWJ+gGOlbTa4D/0sVDMFNLh+5otvvbm/jdi26XTZ1T1Abi5mxtCEJyG57OHPAXeZzXlF/d0KZ3nQ=
X-Received: by 2002:a17:906:b78e:: with SMTP id
 dt14mr2393406ejb.527.1598286981617; 
 Mon, 24 Aug 2020 09:36:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200824155212.789568-1-brogers@suse.com>
In-Reply-To: <20200824155212.789568-1-brogers@suse.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 24 Aug 2020 20:36:09 +0400
Message-ID: <CAJ+F1CLxpP45ZZhrryWt7aSWug9i8ABvXKXOCyCX9ngXT9M5BQ@mail.gmail.com>
Subject: Re: [PATCH] meson: Fix meson build with --enable-libdaxctl
To: Bruce Rogers <brogers@suse.com>
Content-Type: multipart/alternative; boundary="000000000000c9dd0405ada22f06"
Received-SPF: pass client-ip=2a00:1450:4864:20::642;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-ej1-x642.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000c9dd0405ada22f06
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Mon, Aug 24, 2020 at 7:52 PM Bruce Rogers <brogers@suse.com> wrote:

> The daxctl library needs to be linked against when daxctl is asked for
> in configure.
>
> Signed-off-by: Bruce Rogers <brogers@suse.com>
>

I guess we should cover it too in the CI.

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

---
>  configure   | 1 +
>  meson.build | 6 +++++-
>  2 files changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/configure b/configure
> index 67832e3bab..15de7d10de 100755
> --- a/configure
> +++ b/configure
> @@ -7488,6 +7488,7 @@ fi
>
>  if test "$libdaxctl" =3D "yes" ; then
>    echo "CONFIG_LIBDAXCTL=3Dy" >> $config_host_mak
> +  echo "LIBDAXCTL_LIBS=3D$libdaxctl_libs" >> $config_host_mak
>  fi
>
>  if test "$bochs" =3D "yes" ; then
> diff --git a/meson.build b/meson.build
> index df5bf728b5..0a24e5c31a 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -380,6 +380,10 @@ if 'CONFIG_LIBPMEM' in config_host
>    libpmem =3D declare_dependency(compile_args:
> config_host['LIBPMEM_CFLAGS'].split(),
>                                 link_args:
> config_host['LIBPMEM_LIBS'].split())
>  endif
> +libdaxctl =3D not_found
> +if 'CONFIG_LIBDAXCTL' in config_host
> +  libdaxctl =3D declare_dependency(link_args:
> config_host['LIBDAXCTL_LIBS'].split())
> +endif
>
>  # Create config-host.h
>
> @@ -786,7 +790,7 @@ common_ss.add(files('cpus-common.c'))
>
>  subdir('softmmu')
>
> -specific_ss.add(files('disas.c', 'exec.c', 'gdbstub.c'), capstone,
> libpmem)
> +specific_ss.add(files('disas.c', 'exec.c', 'gdbstub.c'), capstone,
> libpmem, libdaxctl)
>  specific_ss.add(files('exec-vary.c'))
>  specific_ss.add(when: 'CONFIG_TCG', if_true: files(
>    'fpu/softfloat.c',
> --
> 2.28.0
>
>
>

--=20
Marc-Andr=C3=A9 Lureau

--000000000000c9dd0405ada22f06
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi<br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Aug 24, 2020 at 7:52 PM Bru=
ce Rogers &lt;<a href=3D"mailto:brogers@suse.com">brogers@suse.com</a>&gt; =
wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">The daxct=
l library needs to be linked against when daxctl is asked for<br>
in configure.<br>
<br>
Signed-off-by: Bruce Rogers &lt;<a href=3D"mailto:brogers@suse.com" target=
=3D"_blank">brogers@suse.com</a>&gt;<br></blockquote><div><br></div><div>I =
guess we should cover it too in the CI.</div><div><br></div><div>Reviewed-b=
y: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@redhat.com=
">marcandre.lureau@redhat.com</a>&gt;</div><div><br> </div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex">
---<br>
=C2=A0configure=C2=A0 =C2=A0| 1 +<br>
=C2=A0meson.build | 6 +++++-<br>
=C2=A02 files changed, 6 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/configure b/configure<br>
index 67832e3bab..15de7d10de 100755<br>
--- a/configure<br>
+++ b/configure<br>
@@ -7488,6 +7488,7 @@ fi<br>
<br>
=C2=A0if test &quot;$libdaxctl&quot; =3D &quot;yes&quot; ; then<br>
=C2=A0 =C2=A0echo &quot;CONFIG_LIBDAXCTL=3Dy&quot; &gt;&gt; $config_host_ma=
k<br>
+=C2=A0 echo &quot;LIBDAXCTL_LIBS=3D$libdaxctl_libs&quot; &gt;&gt; $config_=
host_mak<br>
=C2=A0fi<br>
<br>
=C2=A0if test &quot;$bochs&quot; =3D &quot;yes&quot; ; then<br>
diff --git a/meson.build b/meson.build<br>
index df5bf728b5..0a24e5c31a 100644<br>
--- a/meson.build<br>
+++ b/meson.build<br>
@@ -380,6 +380,10 @@ if &#39;CONFIG_LIBPMEM&#39; in config_host<br>
=C2=A0 =C2=A0libpmem =3D declare_dependency(compile_args: config_host[&#39;=
LIBPMEM_CFLAGS&#39;].split(),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 link_args: config_host[&#39;LIBPMEM_=
LIBS&#39;].split())<br>
=C2=A0endif<br>
+libdaxctl =3D not_found<br>
+if &#39;CONFIG_LIBDAXCTL&#39; in config_host<br>
+=C2=A0 libdaxctl =3D declare_dependency(link_args: config_host[&#39;LIBDAX=
CTL_LIBS&#39;].split())<br>
+endif<br>
<br>
=C2=A0# Create config-host.h<br>
<br>
@@ -786,7 +790,7 @@ common_ss.add(files(&#39;cpus-common.c&#39;))<br>
<br>
=C2=A0subdir(&#39;softmmu&#39;)<br>
<br>
-specific_ss.add(files(&#39;disas.c&#39;, &#39;exec.c&#39;, &#39;gdbstub.c&=
#39;), capstone, libpmem)<br>
+specific_ss.add(files(&#39;disas.c&#39;, &#39;exec.c&#39;, &#39;gdbstub.c&=
#39;), capstone, libpmem, libdaxctl)<br>
=C2=A0specific_ss.add(files(&#39;exec-vary.c&#39;))<br>
=C2=A0specific_ss.add(when: &#39;CONFIG_TCG&#39;, if_true: files(<br>
=C2=A0 =C2=A0&#39;fpu/softfloat.c&#39;,<br>
-- <br>
2.28.0<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature">Marc-Andr=C3=A9 Lureau<br></div></div>

--000000000000c9dd0405ada22f06--

