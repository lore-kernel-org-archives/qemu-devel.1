Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04282C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 15:34:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B316F2078D
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 15:34:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gv7hbCjK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B316F2078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49582 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAxRZ-0001q1-0Y
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 11:34:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36068)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kAxQe-0001JQ-VE
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 11:33:36 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:43002)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kAxQZ-0006uR-AE
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 11:33:36 -0400
Received: by mail-lj1-x241.google.com with SMTP id t6so2845558ljk.9
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2020 08:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=fPp4bYK3lppfVsT7k1huWXOQ8yfpvrdyFDiPY+6bo/4=;
 b=Gv7hbCjKQZ1YNmf0Fx7ywqRy/JumwSwm0Xri68Sbu8d9COCqY0alabgTzfUT6zdTrl
 7wr793+Z6kBdpp35fm5VJKTqGpX8TZ5rhufUR79clUohKEosC93RGH/SAVx+tIYDIlbR
 Uku3Xd0N6K2jvli03p1+clxxm4SjIR0Vrkm4FxWUQqI5sc28sKZ7LcRisxkKxwVzVG+B
 nDkewW5oGCVxKkLPBCCibn7H0ViIdLyG/yCOZgCzh6wiWuKkYjtw4b4fbL4dx9mjZvNB
 0AHYz8mVOMe5oypw2W5+B7VVs441QLTQfz9DB3SYO0Ixlb54kgzhJc2CenkEZoyvSfwQ
 GEWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=fPp4bYK3lppfVsT7k1huWXOQ8yfpvrdyFDiPY+6bo/4=;
 b=IGWnh6D95o4I9DLNZXA0lW/dBgLNqlRsbpd+6vXtPZO8k8kM27Kh/JVedmPfRfqoX2
 0msmg/Z1oX3wjMt7t2dKY2xLu66dSM23MPM4crRT6pU6NNR8z8cFf8Vonay+K2eGGWzK
 cEg/19cj2Vs/Wjfs9B8t0lf07dX84nwiH/02N7NAfEMn0kyJnynkuN7DPaQih3mLBBKg
 HVoygboPtznba/n+ETmrjtd7R4HCyjE7IZZOXSH+5rMWgI0A3AGFATh2+yB3GihUYo04
 kc3AoaKUDpTaYHbAUnhuU7nOaD0bbK8J821C51kBDDtce+SQ1/ZIpTKJ5tCDyIHa86Uo
 F+1g==
X-Gm-Message-State: AOAM533nkSih0PUrLqXlKwgDPcn0bnDv4a7dKCKGExR9ZceRX4n24vsy
 Iguj9S6//Y5khsokSnTQDcuGZ46cvQm0osyPn2M=
X-Google-Smtp-Source: ABdhPJw/9K0AB0wuCJZ+4cPYbgKorsEYUxBguc3LBKcoDjsqVUdjgYv6ugmYygNoakP0TmCkc7UZyDpGPCtPiJyGsJs=
X-Received: by 2002:a2e:7315:: with SMTP id o21mr794339ljc.120.1598456008220; 
 Wed, 26 Aug 2020 08:33:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200826151006.80-1-luoyonggang@gmail.com>
 <20200826151006.80-4-luoyonggang@gmail.com>
 <CABgObfbL9rdB1T0gzYvT4uR9D8ghLmo7OYaVdk+Vdk_vSjjvoA@mail.gmail.com>
In-Reply-To: <CABgObfbL9rdB1T0gzYvT4uR9D8ghLmo7OYaVdk+Vdk_vSjjvoA@mail.gmail.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Wed, 26 Aug 2020 23:33:16 +0800
Message-ID: <CAE2XoE-mG9PFZF3hA4XpZ62oUicMQDid5AMqvUbx+yoOfLY=EQ@mail.gmail.com>
Subject: Re: [PATCH v5 4/6] configure: Fix include and linkage issue on msys2
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000008f278c05adc98af6"
Received-SPF: pass client-ip=2a00:1450:4864:20::241;
 envelope-from=luoyonggang@gmail.com; helo=mail-lj1-x241.google.com
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
Cc: =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000008f278c05adc98af6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2020 at 11:24 PM Paolo Bonzini <pbonzini@redhat.com> wrote:

> I'm a bit wary of this patch, the effects are quite wide-ranging. If
> we move all the detection of dependencies to meson, it will take a
> while but we should get a similar effect.
>
Only on MINGW the $PWD sematic are changed, so I don't think there is side
effect of this patch.


>
> However, I'm testing and queuing patches 1 to 3.
>
> Paolo
>
> On Wed, Aug 26, 2020 at 5:13 PM <luoyonggang@gmail.com> wrote:
> >
> > From: Yonggang Luo <luoyonggang@gmail.com>
> >
> > On msys2, the -I/e/path/to/qemu -L/e/path/to/qemu are not recognized by
> the compiler
> > Cause $PWD are result posix style path such as /e/path/to/qemu that can
> not be recognized
> > by mingw gcc, and `pwd -W` are result Windows style path such as
> E:/path/to/qemu that can
> > be recognized by the mingw gcc. So we replace all $PWD with $build_path
> that can
> > building qemu under msys2/mingw environment.
> >
> > Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> > ---
> >  configure | 28 +++++++++++++++++++---------
> >  1 file changed, 19 insertions(+), 9 deletions(-)
> >
> > diff --git a/configure b/configure
> > index b1e11397a8..3b9e79923d 100755
> > --- a/configure
> > +++ b/configure
> > @@ -13,8 +13,13 @@ export CCACHE_RECACHE=3Dyes
> >
> >  # make source path absolute
> >  source_path=3D$(cd "$(dirname -- "$0")"; pwd)
> > +build_path=3D$PWD
> > +if [ "$MSYSTEM" =3D "MINGW64" -o  "$MSYSTEM" =3D "MINGW32" ]; then
> > +source_path=3D$(cd "$(dirname -- "$0")"; pwd -W)
> > +build_path=3D`pwd -W`
> > +fi
> >
> > -if test "$PWD" =3D "$source_path"
> > +if test "$build_path" =3D "$source_path"
> >  then
> >      echo "Using './build' as the directory for build output"
> >
> > @@ -346,7 +351,12 @@ ld_has() {
> >      $ld --help 2>/dev/null | grep ".$1" >/dev/null 2>&1
> >  }
> >
> > -if printf %s\\n "$source_path" "$PWD" | grep -q "[[:space:]:]";
> > +check_valid_build_path=3D"[[:space:]:]"
> > +if [ "$MSYSTEM" =3D "MINGW64" -o  "$MSYSTEM" =3D "MINGW32" ]; then
> > +check_valid_build_path=3D"[[:space:]]"
> > +fi
> > +
> > +if printf %s\\n "$source_path" "$build_path" | grep -q
> "$check_valid_build_path";
> >  then
> >    error_exit "main directory cannot contain spaces nor colons"
> >  fi
> > @@ -942,7 +952,7 @@ Linux)
> >    linux=3D"yes"
> >    linux_user=3D"yes"
> >    kvm=3D"yes"
> > -  QEMU_INCLUDES=3D"-isystem ${source_path}/linux-headers
> -I$PWD/linux-headers $QEMU_INCLUDES"
> > +  QEMU_INCLUDES=3D"-isystem ${source_path}/linux-headers
> -I${build_path}/linux-headers $QEMU_INCLUDES"
> >    libudev=3D"yes"
> >  ;;
> >  esac
> > @@ -4283,7 +4293,7 @@ EOF
> >                symlink "$source_path/dtc/Makefile" "dtc/Makefile"
> >            fi
> >            fdt_cflags=3D"-I${source_path}/dtc/libfdt"
> > -          fdt_ldflags=3D"-L$PWD/dtc/libfdt"
> > +          fdt_ldflags=3D"-L${build_path}/dtc/libfdt"
> >            fdt_libs=3D"$fdt_libs"
> >        elif test "$fdt" =3D "yes" ; then
> >            # Not a git build & no libfdt found, prompt for system insta=
ll
> > @@ -5268,7 +5278,7 @@ case "$capstone" in
> >      else
> >        LIBCAPSTONE=3Dlibcapstone.a
> >      fi
> > -    capstone_libs=3D"-L$PWD/capstone -lcapstone"
> > +    capstone_libs=3D"-L${build_path}/capstone -lcapstone"
> >      capstone_cflags=3D"-I${source_path}/capstone/include"
> >      ;;
> >
> > @@ -6268,8 +6278,8 @@ case "$slirp" in
> >        git_submodules=3D"${git_submodules} slirp"
> >      fi
> >      mkdir -p slirp
> > -    slirp_cflags=3D"-I${source_path}/slirp/src -I$PWD/slirp/src"
> > -    slirp_libs=3D"-L$PWD/slirp -lslirp"
> > +    slirp_cflags=3D"-I${source_path}/slirp/src -I${build_path}/slirp/s=
rc"
> > +    slirp_libs=3D"-L${build_path}/slirp -lslirp"
> >      if test "$mingw32" =3D "yes" ; then
> >        slirp_libs=3D"$slirp_libs -lws2_32 -liphlpapi"
> >      fi
> > @@ -8212,7 +8222,7 @@ fi
> >  mv $cross config-meson.cross
> >
> >  rm -rf meson-private meson-info meson-logs
> > -NINJA=3D$PWD/ninjatool $meson setup \
> > +NINJA=3D"${build_path}/ninjatool" $meson setup \
> >          --prefix "${pre_prefix}$prefix" \
> >          --libdir "${pre_prefix}$libdir" \
> >          --libexecdir "${pre_prefix}$libexecdir" \
> > @@ -8232,7 +8242,7 @@ NINJA=3D$PWD/ninjatool $meson setup \
> >         -Dvnc=3D$vnc -Dvnc_sasl=3D$vnc_sasl -Dvnc_jpeg=3D$vnc_jpeg
> -Dvnc_png=3D$vnc_png \
> >         -Dgettext=3D$gettext -Dxkbcommon=3D$xkbcommon \
> >          $cross_arg \
> > -        "$PWD" "$source_path"
> > +        "$build_path" "$source_path"
> >
> >  if test "$?" -ne 0 ; then
> >      error_exit "meson setup failed"
> > --
> > 2.27.0.windows.1
> >
>
>

--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--0000000000008f278c05adc98af6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"></div><br><div class=3D"gmail_quote"><div=
 dir=3D"ltr" class=3D"gmail_attr">On Wed, Aug 26, 2020 at 11:24 PM Paolo Bo=
nzini &lt;<a href=3D"mailto:pbonzini@redhat.com">pbonzini@redhat.com</a>&gt=
; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">I&#39;m=
 a bit wary of this patch, the effects are quite wide-ranging. If<br>
we move all the detection of dependencies to meson, it will take a<br>
while but we should get a similar effect.<br></blockquote><div>Only on MING=
W the $PWD sematic are changed, so I don&#39;t think there is side effect o=
f this patch.</div><div>=C2=A0<br></div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex">
<br>
However, I&#39;m testing and queuing patches 1 to 3.<br>
<br>
Paolo<br>
<br>
On Wed, Aug 26, 2020 at 5:13 PM &lt;<a href=3D"mailto:luoyonggang@gmail.com=
" target=3D"_blank">luoyonggang@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; From: Yonggang Luo &lt;<a href=3D"mailto:luoyonggang@gmail.com" target=
=3D"_blank">luoyonggang@gmail.com</a>&gt;<br>
&gt;<br>
&gt; On msys2, the -I/e/path/to/qemu -L/e/path/to/qemu are not recognized b=
y the compiler<br>
&gt; Cause $PWD are result posix style path such as /e/path/to/qemu that ca=
n not be recognized<br>
&gt; by mingw gcc, and `pwd -W` are result Windows style path such as E:/pa=
th/to/qemu that can<br>
&gt; be recognized by the mingw gcc. So we replace all $PWD with $build_pat=
h that can<br>
&gt; building qemu under msys2/mingw environment.<br>
&gt;<br>
&gt; Signed-off-by: Yonggang Luo &lt;<a href=3D"mailto:luoyonggang@gmail.co=
m" target=3D"_blank">luoyonggang@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 configure | 28 +++++++++++++++++++---------<br>
&gt;=C2=A0 1 file changed, 19 insertions(+), 9 deletions(-)<br>
&gt;<br>
&gt; diff --git a/configure b/configure<br>
&gt; index b1e11397a8..3b9e79923d 100755<br>
&gt; --- a/configure<br>
&gt; +++ b/configure<br>
&gt; @@ -13,8 +13,13 @@ export CCACHE_RECACHE=3Dyes<br>
&gt;<br>
&gt;=C2=A0 # make source path absolute<br>
&gt;=C2=A0 source_path=3D$(cd &quot;$(dirname -- &quot;$0&quot;)&quot;; pwd=
)<br>
&gt; +build_path=3D$PWD<br>
&gt; +if [ &quot;$MSYSTEM&quot; =3D &quot;MINGW64&quot; -o=C2=A0 &quot;$MSY=
STEM&quot; =3D &quot;MINGW32&quot; ]; then<br>
&gt; +source_path=3D$(cd &quot;$(dirname -- &quot;$0&quot;)&quot;; pwd -W)<=
br>
&gt; +build_path=3D`pwd -W`<br>
&gt; +fi<br>
&gt;<br>
&gt; -if test &quot;$PWD&quot; =3D &quot;$source_path&quot;<br>
&gt; +if test &quot;$build_path&quot; =3D &quot;$source_path&quot;<br>
&gt;=C2=A0 then<br>
&gt;=C2=A0 =C2=A0 =C2=A0 echo &quot;Using &#39;./build&#39; as the director=
y for build output&quot;<br>
&gt;<br>
&gt; @@ -346,7 +351,12 @@ ld_has() {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 $ld --help 2&gt;/dev/null | grep &quot;.$1&quot; &=
gt;/dev/null 2&gt;&amp;1<br>
&gt;=C2=A0 }<br>
&gt;<br>
&gt; -if printf %s\\n &quot;$source_path&quot; &quot;$PWD&quot; | grep -q &=
quot;[[:space:]:]&quot;;<br>
&gt; +check_valid_build_path=3D&quot;[[:space:]:]&quot;<br>
&gt; +if [ &quot;$MSYSTEM&quot; =3D &quot;MINGW64&quot; -o=C2=A0 &quot;$MSY=
STEM&quot; =3D &quot;MINGW32&quot; ]; then<br>
&gt; +check_valid_build_path=3D&quot;[[:space:]]&quot;<br>
&gt; +fi<br>
&gt; +<br>
&gt; +if printf %s\\n &quot;$source_path&quot; &quot;$build_path&quot; | gr=
ep -q &quot;$check_valid_build_path&quot;;<br>
&gt;=C2=A0 then<br>
&gt;=C2=A0 =C2=A0 error_exit &quot;main directory cannot contain spaces nor=
 colons&quot;<br>
&gt;=C2=A0 fi<br>
&gt; @@ -942,7 +952,7 @@ Linux)<br>
&gt;=C2=A0 =C2=A0 linux=3D&quot;yes&quot;<br>
&gt;=C2=A0 =C2=A0 linux_user=3D&quot;yes&quot;<br>
&gt;=C2=A0 =C2=A0 kvm=3D&quot;yes&quot;<br>
&gt; -=C2=A0 QEMU_INCLUDES=3D&quot;-isystem ${source_path}/linux-headers -I=
$PWD/linux-headers $QEMU_INCLUDES&quot;<br>
&gt; +=C2=A0 QEMU_INCLUDES=3D&quot;-isystem ${source_path}/linux-headers -I=
${build_path}/linux-headers $QEMU_INCLUDES&quot;<br>
&gt;=C2=A0 =C2=A0 libudev=3D&quot;yes&quot;<br>
&gt;=C2=A0 ;;<br>
&gt;=C2=A0 esac<br>
&gt; @@ -4283,7 +4293,7 @@ EOF<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 symlink &quot;$=
source_path/dtc/Makefile&quot; &quot;dtc/Makefile&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fi<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fdt_cflags=3D&quot;-I${source=
_path}/dtc/libfdt&quot;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fdt_ldflags=3D&quot;-L$PWD/dtc/lib=
fdt&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fdt_ldflags=3D&quot;-L${build_path=
}/dtc/libfdt&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fdt_libs=3D&quot;$fdt_libs&qu=
ot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 elif test &quot;$fdt&quot; =3D &quot;yes&qu=
ot; ; then<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Not a git build &amp; no li=
bfdt found, prompt for system install<br>
&gt; @@ -5268,7 +5278,7 @@ case &quot;$capstone&quot; in<br>
&gt;=C2=A0 =C2=A0 =C2=A0 else<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 LIBCAPSTONE=3Dlibcapstone.a<br>
&gt;=C2=A0 =C2=A0 =C2=A0 fi<br>
&gt; -=C2=A0 =C2=A0 capstone_libs=3D&quot;-L$PWD/capstone -lcapstone&quot;<=
br>
&gt; +=C2=A0 =C2=A0 capstone_libs=3D&quot;-L${build_path}/capstone -lcapsto=
ne&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 capstone_cflags=3D&quot;-I${source_path}/capstone/=
include&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 ;;<br>
&gt;<br>
&gt; @@ -6268,8 +6278,8 @@ case &quot;$slirp&quot; in<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 git_submodules=3D&quot;${git_submodules} sl=
irp&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 fi<br>
&gt;=C2=A0 =C2=A0 =C2=A0 mkdir -p slirp<br>
&gt; -=C2=A0 =C2=A0 slirp_cflags=3D&quot;-I${source_path}/slirp/src -I$PWD/=
slirp/src&quot;<br>
&gt; -=C2=A0 =C2=A0 slirp_libs=3D&quot;-L$PWD/slirp -lslirp&quot;<br>
&gt; +=C2=A0 =C2=A0 slirp_cflags=3D&quot;-I${source_path}/slirp/src -I${bui=
ld_path}/slirp/src&quot;<br>
&gt; +=C2=A0 =C2=A0 slirp_libs=3D&quot;-L${build_path}/slirp -lslirp&quot;<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 if test &quot;$mingw32&quot; =3D &quot;yes&quot; ;=
 then<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 slirp_libs=3D&quot;$slirp_libs -lws2_32 -li=
phlpapi&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 fi<br>
&gt; @@ -8212,7 +8222,7 @@ fi<br>
&gt;=C2=A0 mv $cross config-meson.cross<br>
&gt;<br>
&gt;=C2=A0 rm -rf meson-private meson-info meson-logs<br>
&gt; -NINJA=3D$PWD/ninjatool $meson setup \<br>
&gt; +NINJA=3D&quot;${build_path}/ninjatool&quot; $meson setup \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 --prefix &quot;${pre_prefix}$prefix&=
quot; \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 --libdir &quot;${pre_prefix}$libdir&=
quot; \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 --libexecdir &quot;${pre_prefix}$lib=
execdir&quot; \<br>
&gt; @@ -8232,7 +8242,7 @@ NINJA=3D$PWD/ninjatool $meson setup \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-Dvnc=3D$vnc -Dvnc_sasl=3D$vnc_sasl -=
Dvnc_jpeg=3D$vnc_jpeg -Dvnc_png=3D$vnc_png \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-Dgettext=3D$gettext -Dxkbcommon=3D$x=
kbcommon \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 $cross_arg \<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;$PWD&quot; &quot;$source_path&quot;=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;$build_path&quot; &quot;$source_pat=
h&quot;<br>
&gt;<br>
&gt;=C2=A0 if test &quot;$?&quot; -ne 0 ; then<br>
&gt;=C2=A0 =C2=A0 =C2=A0 error_exit &quot;meson setup failed&quot;<br>
&gt; --<br>
&gt; 2.27.0.windows.1<br>
&gt;<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =E6=AD=A4=E8=
=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=
=A0 sincerely,<br>Yonggang Luo<br></div></div>

--0000000000008f278c05adc98af6--

