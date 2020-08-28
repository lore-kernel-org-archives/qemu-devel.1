Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 218AFC433E6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 21:14:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8DBE2078A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 21:14:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KIB8Rvi3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8DBE2078A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBlhf-0003pE-UU
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 17:14:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34336)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kBlgn-0003GF-0a
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 17:13:37 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:39372)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kBlgl-0000Cp-0b
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 17:13:36 -0400
Received: by mail-lj1-x243.google.com with SMTP id e11so366421ljn.6
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 14:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=xacTXMnqjcS9s6lRfbYQEx0J5UWv5C1CAI6kEaFrZe8=;
 b=KIB8Rvi3zmdXBE0bXOkQGGa4NWVRbfE1b7vqvKUSqapBHLysoptiVB9oM+rCY9aZBL
 evr62gyy/dfZihpSxQ1izLfTITQpj6PAClmt2V4rIVKxEgf4NIZVXV6rUfh7YcIGrhIS
 SbUXLmLtO/JU5l76WioaaoIoDslDgaOJDomy1lNKb20klBDyu0pZqq+7pFYbJ1BDb42v
 AXmjGmhUWh34dMZvdNZvrjx2FMtzQzpzTExiuOeDSq7dKs0VbCs/oThsM/43L39syK9c
 w7DXhsC4KNq0C7F9FkJUd0+tx25dKSPQbDKNB/1+9ohJ8D/xFfMA1C4JoRx5d1oLSUgF
 +HVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=xacTXMnqjcS9s6lRfbYQEx0J5UWv5C1CAI6kEaFrZe8=;
 b=QIVCylgyGZbw6K/zw8qN0y9mSWRaDtYlOHVbGJ4Qxv0jfoyi+A5FeZ0SkVL1r/YDi1
 H9ETN/1Xq1nSSqtxjmQhXYOZq5MWWij4Tdf5baK2vI+4AQSxaCFdW/Wk25J9vt/yjgHP
 YaEXCMH5XQisX8reDJ8xrV2DwC59BrKmIkSZXenUp4uik/V2mz3+i7LfWzOBAa6rzpSU
 1tIlU9xAuQ2WX36jvLK9uESdlv4Ycov383aoUh0+r8exwqNqF+f9OixV7WKfvSEDQ1e3
 p5380WcXNOxal67vWvTA2yKJnkvaeHOusNsxwPrcs3pL5EFKpW4WJczXPy5mjpA1CQEg
 DZMg==
X-Gm-Message-State: AOAM530ZRlhJUEY0uub8EBNzo7MkyBnH4WJHgzHktI0KmfDT9rWOWfJq
 9k8lKy6Gq03tRGYvpCdovRpNeITvwaPbr5Iv53E=
X-Google-Smtp-Source: ABdhPJw3FftcfXJdKoYa4sa24tq1pUUwuBulUJGYh+J5P4mx1K7/CGl71nBW4yVLM4EcecdKcJzry57Cjnx+/pZqIAw=
X-Received: by 2002:a2e:7315:: with SMTP id o21mr298121ljc.120.1598649213095; 
 Fri, 28 Aug 2020 14:13:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200828173841.33505-1-pbonzini@redhat.com>
In-Reply-To: <20200828173841.33505-1-pbonzini@redhat.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Sat, 29 Aug 2020 05:13:20 +0800
Message-ID: <CAE2XoE8TWB_qnqYjNe=qUEebO0xktfWai77c-ab938XBoeqesQ@mail.gmail.com>
Subject: Re: [PATCH] meson: move zlib detection to meson
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000077b0b205adf6862e"
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
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 qemu-level <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000077b0b205adf6862e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 29, 2020 at 1:39 AM Paolo Bonzini <pbonzini@redhat.com> wrote:

> Meson includes the same logic that tries to look for -lz if
> pkg-config (and cmake) cannot find zlib.  The undocumented
> --disable-zlib-test option becomes a no-op.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  Makefile    |  2 +-
>  configure   | 32 +-------------------------------
>  meson.build |  6 +-----
>  3 files changed, 3 insertions(+), 37 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 81794d5c34..1520a2eab5 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -132,7 +132,7 @@ configure: ;
>
>  $(call set-vpath, $(SRC_PATH))
>
> -LIBS+=3D-lz $(LIBS_TOOLS)
> +LIBS+=3D$(LIBS_TOOLS)
>
>  SUBDIR_MAKEFLAGS=3D$(if $(V),,--no-print-directory --quiet)
> BUILD_DIR=3D$(BUILD_DIR)
>
> diff --git a/configure b/configure
> index 6ecaff429b..e035eb2868 100755
> --- a/configure
> +++ b/configure
> @@ -501,7 +501,6 @@ opengl=3D""
>  opengl_dmabuf=3D"no"
>  cpuid_h=3D"no"
>  avx2_opt=3D""
> -zlib=3D"yes"
>  capstone=3D""
>  lzo=3D""
>  snappy=3D""
> @@ -1423,7 +1422,7 @@ for opt do
>    ;;
>    --enable-usb-redir) usb_redir=3D"yes"
>    ;;
> -  --disable-zlib-test) zlib=3D"no"
> +  --disable-zlib-test)
>
Why not remove this no-op

>    ;;
>    --disable-lzo) lzo=3D"no"
>    ;;
> @@ -3898,30 +3897,6 @@ if ! compile_prog "$glib_cflags -Werror"
> "$glib_libs" ; then
>      fi
>  fi
>
> -#########################################
> -# zlib check
> -
> -if test "$zlib" !=3D "no" ; then
> -    if $pkg_config --exists zlib; then
> -        zlib_cflags=3D$($pkg_config --cflags zlib)
> -        zlib_libs=3D$($pkg_config --libs zlib)
> -        QEMU_CFLAGS=3D"$zlib_cflags $QEMU_CFLAGS"
> -        LIBS=3D"$zlib_libs $LIBS"
> -    else
> -        cat > $TMPC << EOF
> -#include <zlib.h>
> -int main(void) { zlibVersion(); return 0; }
> -EOF
> -        if compile_prog "" "-lz" ; then
> -            zlib_libs=3D-lz
> -            LIBS=3D"$LIBS $zlib_libs"
> -        else
> -            error_exit "zlib check failed" \
> -                "Make sure to have the zlib libs and headers installed."
> -        fi
> -    fi
> -fi
> -
>  ##########################################
>  # SHA command probe for modules
>  if test "$modules" =3D yes; then
> @@ -7129,11 +7104,6 @@ fi
>  if test "$posix_memalign" =3D "yes" ; then
>    echo "CONFIG_POSIX_MEMALIGN=3Dy" >> $config_host_mak
>  fi
> -if test "$zlib" !=3D "no" ; then
> -    echo "CONFIG_ZLIB=3Dy" >> $config_host_mak
> -    echo "ZLIB_CFLAGS=3D$zlib_cflags" >> $config_host_mak
> -    echo "ZLIB_LIBS=3D$zlib_libs" >> $config_host_mak
> -fi
>  if test "$spice" =3D "yes" ; then
>    echo "CONFIG_SPICE=3Dy" >> $config_host_mak
>    echo "SPICE_CFLAGS=3D$spice_cflags" >> $config_host_mak
> diff --git a/meson.build b/meson.build
> index 74f8ea0c2e..35e6f8688d 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -134,11 +134,7 @@ if 'CONFIG_AUTH_PAM' in config_host
>    pam =3D cc.find_library('pam')
>  endif
>  libaio =3D cc.find_library('aio', required: false)
> -zlib =3D not_found
> -if 'CONFIG_ZLIB' in config_host
> -  zlib =3D declare_dependency(compile_args:
> config_host['ZLIB_CFLAGS'].split(),
> -                            link_args: config_host['ZLIB_LIBS'].split())
> -endif
> +zlib =3D dependency('zlib', required: true)
>  linux_io_uring =3D not_found
>  if 'CONFIG_LINUX_IO_URING' in config_host
>    linux_io_uring =3D declare_dependency(compile_args:
> config_host['LINUX_IO_URING_CFLAGS'].split(),
> --
> 2.26.2
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

--00000000000077b0b205adf6862e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Sat, Aug 29, 2020 at 1:39 AM Paolo=
 Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com">pbonzini@redhat.com</a>=
&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Meso=
n includes the same logic that tries to look for -lz if<br>
pkg-config (and cmake) cannot find zlib.=C2=A0 The undocumented<br>
--disable-zlib-test option becomes a no-op.<br>
<br>
Signed-off-by: Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com" tar=
get=3D"_blank">pbonzini@redhat.com</a>&gt;<br>
---<br>
=C2=A0Makefile=C2=A0 =C2=A0 |=C2=A0 2 +-<br>
=C2=A0configure=C2=A0 =C2=A0| 32 +-------------------------------<br>
=C2=A0meson.build |=C2=A0 6 +-----<br>
=C2=A03 files changed, 3 insertions(+), 37 deletions(-)<br>
<br>
diff --git a/Makefile b/Makefile<br>
index 81794d5c34..1520a2eab5 100644<br>
--- a/Makefile<br>
+++ b/Makefile<br>
@@ -132,7 +132,7 @@ configure: ;<br>
<br>
=C2=A0$(call set-vpath, $(SRC_PATH))<br>
<br>
-LIBS+=3D-lz $(LIBS_TOOLS)<br>
+LIBS+=3D$(LIBS_TOOLS)<br>
<br>
=C2=A0SUBDIR_MAKEFLAGS=3D$(if $(V),,--no-print-directory --quiet) BUILD_DIR=
=3D$(BUILD_DIR)<br>
<br>
diff --git a/configure b/configure<br>
index 6ecaff429b..e035eb2868 100755<br>
--- a/configure<br>
+++ b/configure<br>
@@ -501,7 +501,6 @@ opengl=3D&quot;&quot;<br>
=C2=A0opengl_dmabuf=3D&quot;no&quot;<br>
=C2=A0cpuid_h=3D&quot;no&quot;<br>
=C2=A0avx2_opt=3D&quot;&quot;<br>
-zlib=3D&quot;yes&quot;<br>
=C2=A0capstone=3D&quot;&quot;<br>
=C2=A0lzo=3D&quot;&quot;<br>
=C2=A0snappy=3D&quot;&quot;<br>
@@ -1423,7 +1422,7 @@ for opt do<br>
=C2=A0 =C2=A0;;<br>
=C2=A0 =C2=A0--enable-usb-redir) usb_redir=3D&quot;yes&quot;<br>
=C2=A0 =C2=A0;;<br>
-=C2=A0 --disable-zlib-test) zlib=3D&quot;no&quot;<br>
+=C2=A0 --disable-zlib-test)<br></blockquote><div>Why not remove this no-op=
=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
=C2=A0 =C2=A0;;<br>
=C2=A0 =C2=A0--disable-lzo) lzo=3D&quot;no&quot;<br>
=C2=A0 =C2=A0;;<br>
@@ -3898,30 +3897,6 @@ if ! compile_prog &quot;$glib_cflags -Werror&quot; &=
quot;$glib_libs&quot; ; then<br>
=C2=A0 =C2=A0 =C2=A0fi<br>
=C2=A0fi<br>
<br>
-#########################################<br>
-# zlib check<br>
-<br>
-if test &quot;$zlib&quot; !=3D &quot;no&quot; ; then<br>
-=C2=A0 =C2=A0 if $pkg_config --exists zlib; then<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 zlib_cflags=3D$($pkg_config --cflags zlib)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 zlib_libs=3D$($pkg_config --libs zlib)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 QEMU_CFLAGS=3D&quot;$zlib_cflags $QEMU_CFLAGS&=
quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 LIBS=3D&quot;$zlib_libs $LIBS&quot;<br>
-=C2=A0 =C2=A0 else<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 cat &gt; $TMPC &lt;&lt; EOF<br>
-#include &lt;zlib.h&gt;<br>
-int main(void) { zlibVersion(); return 0; }<br>
-EOF<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if compile_prog &quot;&quot; &quot;-lz&quot; ;=
 then<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 zlib_libs=3D-lz<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 LIBS=3D&quot;$LIBS $zlib_libs&qu=
ot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 else<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_exit &quot;zlib check fail=
ed&quot; \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;Make sure to=
 have the zlib libs and headers installed.&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 fi<br>
-=C2=A0 =C2=A0 fi<br>
-fi<br>
-<br>
=C2=A0##########################################<br>
=C2=A0# SHA command probe for modules<br>
=C2=A0if test &quot;$modules&quot; =3D yes; then<br>
@@ -7129,11 +7104,6 @@ fi<br>
=C2=A0if test &quot;$posix_memalign&quot; =3D &quot;yes&quot; ; then<br>
=C2=A0 =C2=A0echo &quot;CONFIG_POSIX_MEMALIGN=3Dy&quot; &gt;&gt; $config_ho=
st_mak<br>
=C2=A0fi<br>
-if test &quot;$zlib&quot; !=3D &quot;no&quot; ; then<br>
-=C2=A0 =C2=A0 echo &quot;CONFIG_ZLIB=3Dy&quot; &gt;&gt; $config_host_mak<b=
r>
-=C2=A0 =C2=A0 echo &quot;ZLIB_CFLAGS=3D$zlib_cflags&quot; &gt;&gt; $config=
_host_mak<br>
-=C2=A0 =C2=A0 echo &quot;ZLIB_LIBS=3D$zlib_libs&quot; &gt;&gt; $config_hos=
t_mak<br>
-fi<br>
=C2=A0if test &quot;$spice&quot; =3D &quot;yes&quot; ; then<br>
=C2=A0 =C2=A0echo &quot;CONFIG_SPICE=3Dy&quot; &gt;&gt; $config_host_mak<br=
>
=C2=A0 =C2=A0echo &quot;SPICE_CFLAGS=3D$spice_cflags&quot; &gt;&gt; $config=
_host_mak<br>
diff --git a/meson.build b/meson.build<br>
index 74f8ea0c2e..35e6f8688d 100644<br>
--- a/meson.build<br>
+++ b/meson.build<br>
@@ -134,11 +134,7 @@ if &#39;CONFIG_AUTH_PAM&#39; in config_host<br>
=C2=A0 =C2=A0pam =3D cc.find_library(&#39;pam&#39;)<br>
=C2=A0endif<br>
=C2=A0libaio =3D cc.find_library(&#39;aio&#39;, required: false)<br>
-zlib =3D not_found<br>
-if &#39;CONFIG_ZLIB&#39; in config_host<br>
-=C2=A0 zlib =3D declare_dependency(compile_args: config_host[&#39;ZLIB_CFL=
AGS&#39;].split(),<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 link_args: config_host[&#39;ZLIB_LIBS&#39;].split(=
))<br>
-endif<br>
+zlib =3D dependency(&#39;zlib&#39;, required: true)<br>
=C2=A0linux_io_uring =3D not_found<br>
=C2=A0if &#39;CONFIG_LINUX_IO_URING&#39; in config_host<br>
=C2=A0 =C2=A0linux_io_uring =3D declare_dependency(compile_args: config_hos=
t[&#39;LINUX_IO_URING_CFLAGS&#39;].split(),<br>
-- <br>
2.26.2<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =E6=AD=A4=E8=
=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=
=A0 sincerely,<br>Yonggang Luo<br></div></div>

--00000000000077b0b205adf6862e--

