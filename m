Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45599C433E7
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 17:08:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E36B220709
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 17:08:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pc9KcXEZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E36B220709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDWEu-0003oS-0Y
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 13:08:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46866)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kDWDh-0002L1-1E
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 13:06:49 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:44406)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kDWDe-0000wf-GZ
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 13:06:48 -0400
Received: by mail-lj1-x243.google.com with SMTP id b19so6812554lji.11
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2020 10:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=dmuDtAQFzDCeqREoIi7GVWaBTPnkxvfXXTK6JihZ+mI=;
 b=pc9KcXEZ4Je6tfXlxfuseH4f9M+AYpt2CBkqbaHovlFkfEY2NfWCobBjYvSjklDR+8
 /7w+WNg5/VPDnPiYucEVFcYINCuDF0+Y83jnCEjGlhmAZgqj0duEtHhvDUcN8r344yCe
 VMWxigx/Uceh3OyHuUPKH7H3Q9NMViIB5/Kz+5sLSrujv2d4tqFIv4W9Z2qOdpLnqOUH
 D1NTay93sCfP4Ydhcm1HjfkKs74WSA+r1PZsygET4rPP7gvjVE58dSSq7dN18HNRauVT
 ocePOtY8YF6Z9uaqRAT298dZhz6sWmnBxhMU4BCmV2/PhWC1XYUAO/z1nLBWSXxNwame
 7jEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=dmuDtAQFzDCeqREoIi7GVWaBTPnkxvfXXTK6JihZ+mI=;
 b=YoHpEuxXOUzu+hCQ94IRXHqO47pDgYghKlILItxWNjePuVG5nl2LO8OEoz3+4ckDF0
 xIydqIm7k4mnQLwJWc9l0Jkmc9Tr5Sa4hwjzDybzzIXJXM69rL0nlcWd+mqh58vGxkLb
 EJ23xLQj+r5CKCObEUJCLP5AoiMxMlOu951Wz/qyKzFnBYOfXdyXjvyeg1Jr2IPunPhb
 xYQdG8XJzuXBZxvouTiWcA6xAxeNw6H1UlWglEZCRX76RfES2AfANr/Zf2IgYbcoEqJ+
 k3R8BJfGQYL5S3LNs8J2SV8KyLmppyohHrlkS2g0lykLgNuWtNRrZO+5m9zK8zi3dkZy
 slxQ==
X-Gm-Message-State: AOAM533UJWNIf8x6jyHMJX5/GZM8W9YP8kSninJ48DpWrY9E9JaID5fW
 gVJ1+8LzuAPMCoCnur/7H9fhhDm69+z5dvx5Jb0=
X-Google-Smtp-Source: ABdhPJwFabuZDWDE6r2YAVw8iF1KWrK58J5Q70lK1TXWU6ZRHA84jLySNrAxhlqlVOhC7CdkcbKuTi9Yqxp9fV2saU0=
X-Received: by 2002:a05:651c:151:: with SMTP id
 c17mr4028891ljd.467.1599066401235; 
 Wed, 02 Sep 2020 10:06:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200902170054.810-1-luoyonggang@gmail.com>
 <20200902170054.810-7-luoyonggang@gmail.com>
 <436ea293-8fba-e762-fdff-d84534f5baee@redhat.com>
In-Reply-To: <436ea293-8fba-e762-fdff-d84534f5baee@redhat.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Thu, 3 Sep 2020 01:06:29 +0800
Message-ID: <CAE2XoE8=w42-X+W9nqNFPux-+pDgpL4erDLYNRd=w+2hawZxTg@mail.gmail.com>
Subject: Re: [PATCH 6/6] configure: Fix include and linkage issue on msys2
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000d1669e05ae57a841"
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
Cc: qemu-level <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000d1669e05ae57a841
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I am OK with that, I just need to this make the CI green, once your patch
upstream, I'll drop this

On Thu, Sep 3, 2020 at 1:05 AM Paolo Bonzini <pbonzini@redhat.com> wrote:

> On 02/09/20 19:00, Yonggang Luo wrote:
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
>
> I'm dropping this patch in favor of relative -L and -I paths.
>
> Paolo
>
> >  configure | 28 +++++++++++++++++++---------
> >  1 file changed, 19 insertions(+), 9 deletions(-)
> >
> > diff --git a/configure b/configure
> > index 30f8c4db29..5f2bcc4b57 100755
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
> > @@ -943,7 +953,7 @@ Linux)
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
> > @@ -4259,7 +4269,7 @@ EOF
> >            fdt=3Dgit
> >            mkdir -p dtc
> >            fdt_cflags=3D"-I${source_path}/dtc/libfdt"
> > -          fdt_ldflags=3D"-L$PWD/dtc/libfdt"
> > +          fdt_ldflags=3D"-L${build_path}/dtc/libfdt"
> >            fdt_libs=3D"$fdt_libs"
> >        elif test "$fdt" =3D "yes" ; then
> >            # Not a git build & no libfdt found, prompt for system insta=
ll
> > @@ -5244,7 +5254,7 @@ case "$capstone" in
> >      else
> >        LIBCAPSTONE=3Dlibcapstone.a
> >      fi
> > -    capstone_libs=3D"-L$PWD/capstone -lcapstone"
> > +    capstone_libs=3D"-L${build_path}/capstone -lcapstone"
> >      capstone_cflags=3D"-I${source_path}/capstone/include"
> >      ;;
> >
> > @@ -6244,8 +6254,8 @@ case "$slirp" in
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
> > @@ -8190,7 +8200,7 @@ fi
> >  mv $cross config-meson.cross
> >
> >  rm -rf meson-private meson-info meson-logs
> > -NINJA=3D${ninja:-$PWD/ninjatool} $meson setup \
> > +NINJA=3D${ninja:-${build_path}/ninjatool} $meson setup \
> >          --prefix "${pre_prefix}$prefix" \
> >          --libdir "${pre_prefix}$libdir" \
> >          --libexecdir "${pre_prefix}$libexecdir" \
> > @@ -8212,7 +8222,7 @@ NINJA=3D${ninja:-$PWD/ninjatool} $meson setup \
> >       -Dvnc=3D$vnc -Dvnc_sasl=3D$vnc_sasl -Dvnc_jpeg=3D$vnc_jpeg
> -Dvnc_png=3D$vnc_png \
> >       -Dgettext=3D$gettext -Dxkbcommon=3D$xkbcommon -Du2f=3D$u2f\
> >          $cross_arg \
> > -        "$PWD" "$source_path"
> > +        "$build_path" "$source_path"
> >
> >  if test "$?" -ne 0 ; then
> >      error_exit "meson setup failed"
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

--000000000000d1669e05ae57a841
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I am OK with that, I just need to this make the CI green, =
once your patch upstream, I&#39;ll drop this</div><br><div class=3D"gmail_q=
uote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Sep 3, 2020 at 1:05 AM =
Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com">pbonzini@redhat.co=
m</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"=
>On 02/09/20 19:00, Yonggang Luo wrote:<br>
&gt; On msys2, the -I/e/path/to/qemu -L/e/path/to/qemu are not recognized b=
y the compiler<br>
&gt; Cause $PWD are result posix style path such as /e/path/to/qemu that ca=
n not be recognized<br>
&gt; by mingw gcc, and `pwd -W` are result Windows style path such as E:/pa=
th/to/qemu that can<br>
&gt; be recognized by the mingw gcc. So we replace all $PWD with $build_pat=
h that can<br>
&gt; building qemu under msys2/mingw environment.<br>
&gt; <br>
&gt; Signed-off-by: Yonggang Luo &lt;<a href=3D"mailto:luoyonggang@gmail.co=
m" target=3D"_blank">luoyonggang@gmail.com</a>&gt;<br>
<br>
I&#39;m dropping this patch in favor of relative -L and -I paths.<br>
<br>
Paolo<br>
<br>
&gt;=C2=A0 configure | 28 +++++++++++++++++++---------<br>
&gt;=C2=A0 1 file changed, 19 insertions(+), 9 deletions(-)<br>
&gt; <br>
&gt; diff --git a/configure b/configure<br>
&gt; index 30f8c4db29..5f2bcc4b57 100755<br>
&gt; --- a/configure<br>
&gt; +++ b/configure<br>
&gt; @@ -13,8 +13,13 @@ export CCACHE_RECACHE=3Dyes<br>
&gt;=C2=A0 <br>
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
&gt;=C2=A0 <br>
&gt; -if test &quot;$PWD&quot; =3D &quot;$source_path&quot;<br>
&gt; +if test &quot;$build_path&quot; =3D &quot;$source_path&quot;<br>
&gt;=C2=A0 then<br>
&gt;=C2=A0 =C2=A0 =C2=A0 echo &quot;Using &#39;./build&#39; as the director=
y for build output&quot;<br>
&gt;=C2=A0 <br>
&gt; @@ -346,7 +351,12 @@ ld_has() {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 $ld --help 2&gt;/dev/null | grep &quot;.$1&quot; &=
gt;/dev/null 2&gt;&amp;1<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
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
&gt; @@ -943,7 +953,7 @@ Linux)<br>
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
&gt; @@ -4259,7 +4269,7 @@ EOF<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fdt=3Dgit<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mkdir -p dtc<br>
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
&gt; @@ -5244,7 +5254,7 @@ case &quot;$capstone&quot; in<br>
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
&gt;=C2=A0 <br>
&gt; @@ -6244,8 +6254,8 @@ case &quot;$slirp&quot; in<br>
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
&gt; @@ -8190,7 +8200,7 @@ fi<br>
&gt;=C2=A0 mv $cross config-meson.cross<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 rm -rf meson-private meson-info meson-logs<br>
&gt; -NINJA=3D${ninja:-$PWD/ninjatool} $meson setup \<br>
&gt; +NINJA=3D${ninja:-${build_path}/ninjatool} $meson setup \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 --prefix &quot;${pre_prefix}$prefix&=
quot; \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 --libdir &quot;${pre_prefix}$libdir&=
quot; \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 --libexecdir &quot;${pre_prefix}$lib=
execdir&quot; \<br>
&gt; @@ -8212,7 +8222,7 @@ NINJA=3D${ninja:-$PWD/ninjatool} $meson setup \<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0-Dvnc=3D$vnc -Dvnc_sasl=3D$vnc_sasl -Dvnc_jp=
eg=3D$vnc_jpeg -Dvnc_png=3D$vnc_png \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0-Dgettext=3D$gettext -Dxkbcommon=3D$xkbcommo=
n -Du2f=3D$u2f\<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 $cross_arg \<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;$PWD&quot; &quot;$source_path&quot;=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;$build_path&quot; &quot;$source_pat=
h&quot;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 if test &quot;$?&quot; -ne 0 ; then<br>
&gt;=C2=A0 =C2=A0 =C2=A0 error_exit &quot;meson setup failed&quot;<br>
&gt; <br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =E6=AD=A4=E8=
=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=
=A0 sincerely,<br>Yonggang Luo<br></div>

--000000000000d1669e05ae57a841--

