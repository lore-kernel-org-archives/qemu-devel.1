Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8017C43463
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 12:57:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E76E2207D3
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 12:57:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lKVXXP4o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E76E2207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJFxQ-0004uD-3i
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 08:57:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37886)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kJFvp-0003jx-Ur
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 08:56:05 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:46919)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kJFvn-0006it-2y
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 08:56:05 -0400
Received: by mail-lj1-x242.google.com with SMTP id a22so4964667ljp.13
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 05:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=yfSB2oALpBLeuqAluvbxyMBwJgjQq7dsjT2Q4s0fCnI=;
 b=lKVXXP4oDrWWvcE/iCfEVd6XUBw5fV2fax39/VwMiebqmB6kp0Zg7lADTSCr328NAT
 tSZf4cgSXgfOIuMMJui4ReByQNKubR2xJV6PzORAWDkLK5mTOmOeyQAcg2Opwl6g2f+7
 bPWez0V6ns7Tr+zc8dQiU3eQIOH0v971ggE4EuUZgxq3Z1XvjvYoSMKFPSn66Q3NjMj0
 dBQjgPfBN+2JSnV68vWrCCiukm6T6IPOLD9E9lqxZof7z8Mt+fHulsBOwVLBfMBykU/B
 viI097mZWsGq1LcIj3DIAcv3sy+ArF+wGQAc7CJsLqbChvpTkT786bxLy8sEYqLuH7Fn
 raOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=yfSB2oALpBLeuqAluvbxyMBwJgjQq7dsjT2Q4s0fCnI=;
 b=LSrYG7e+pvFpLw84eY4e+C/ZwcmvEZ87DZ3ypKN1fkUA8atXrS9EjH5692FAc2XuNu
 wEcnrxYEVGJHpZSmsSfcdXMYEVmnOPS0ClLeIP7FvVc8EnFSXus8y83pvUMqtF9VSJFS
 YwgZeLGWx0jOWy3S+erZkGLOj/MgXZv8DoA7KN21+U+3qWOeOCI4b3amM2/f4J5mNdLB
 FBtSGhzNgebM4N/ks4gF1iesISjIrq1RyRcqUIDXiIJvI8KkvLYA8RfKsRtqIFvnumJl
 9Yp3Mv3nHrfXMwfOtutlNHCRxP8nIG4zBxZw0Jrf6KLXtlHiqKVSKe/Yw89UQno2TA/0
 QeVQ==
X-Gm-Message-State: AOAM530JVplSzMKw/4bs5anhuCMe73eViw1f2atsUUt2MsVGEkjJHTsH
 +koAvm0zikNtvnMSOwMGjGLzwOL+NLgbLx+INvo=
X-Google-Smtp-Source: ABdhPJxudTzIv8DzzEs7/Ht2fzqzTcaWebFoWmcd03lIyydmPdd5DIlhHR9c1SyB/NFgMGYWnxJxwJx60igC0ADGXqk=
X-Received: by 2002:a05:651c:1119:: with SMTP id
 d25mr10694963ljo.300.1600433761007; 
 Fri, 18 Sep 2020 05:56:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200916080608.17689-1-pbonzini@redhat.com>
In-Reply-To: <20200916080608.17689-1-pbonzini@redhat.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Fri, 18 Sep 2020 20:55:49 +0800
Message-ID: <CAE2XoE82=BjoGF5sXUBE+rTJzDwphBRL8CqRp2Z9FAq83dHXJw@mail.gmail.com>
Subject: Re: [PATCH] configure: move malloc_trim/tcmalloc/jemalloc to meson
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000cfbd9805af9605c8"
Received-SPF: pass client-ip=2a00:1450:4864:20::242;
 envelope-from=luoyonggang@gmail.com; helo=mail-lj1-x242.google.com
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
Cc: qemu-level <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000cfbd9805af9605c8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 16, 2020 at 4:07 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> Because LIBS is not used anymore, tcmalloc/jemalloc does
> not work with binaries whose description is in Meson.
> The fix is simply to move them to Meson too.
>
> For consistency with other configure options, specifying
> --enable-malloc-trim together with --enable-{tc,je}malloc
> becomes a fatal error.
>
> Reported-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  configure         | 84 +++++------------------------------------------
>  meson.build       | 28 +++++++++++++---
>  meson_options.txt |  5 +++
>  3 files changed, 38 insertions(+), 79 deletions(-)
>
> diff --git a/configure b/configure
> index ce27eafb0a..13f53ba231 100755
> --- a/configure
> +++ b/configure
> @@ -540,7 +540,7 @@ skip_meson=3Dno
>  gettext=3D""
>
>  bogus_os=3D"no"
> -malloc_trim=3D""
> +malloc_trim=3D"auto"
>
>  deprecated_features=3D""
>
> @@ -1222,9 +1222,9 @@ for opt do
>    ;;
>    --enable-tcg) tcg=3D"yes"
>    ;;
> -  --disable-malloc-trim) malloc_trim=3D"no"
> +  --disable-malloc-trim) malloc_trim=3D"disabled"
>    ;;
> -  --enable-malloc-trim) malloc_trim=3D"yes"
> +  --enable-malloc-trim) malloc_trim=3D"enabled"
>    ;;
>    --disable-spice) spice=3D"no"
>    ;;
> @@ -4428,77 +4428,14 @@ EOF
>    fi
>  fi
>
> +malloc=3Dsystem
>  if test "$tcmalloc" =3D "yes" && test "$jemalloc" =3D "yes" ; then
>      echo "ERROR: tcmalloc && jemalloc can't be used at the same time"
>      exit 1
> -fi
This patch looks good for me, but I still have a small advice than move
thse judgement from
configure to meson, because finally they need to be converted.
and getting tcmalloc /  jemalloc to be "enabled" "disabled" for consistence


> -
> -# Even if malloc_trim() is available, these non-libc memory allocators
> -# do not support it.
> -if test "$tcmalloc" =3D "yes" || test "$jemalloc" =3D "yes" ; then
> -    if test "$malloc_trim" =3D "yes" ; then
> -        echo "Disabling malloc_trim with non-libc memory allocator"
> -    fi
> -    malloc_trim=3D"no"
> -fi
> -
> -#######################################
> -# malloc_trim
> -
> -if test "$malloc_trim" !=3D "no" ; then
> -    cat > $TMPC << EOF
> -#include <malloc.h>
> -int main(void) { malloc_trim(0); return 0; }
> -EOF
> -    if compile_prog "" "" ; then
> -        malloc_trim=3D"yes"
> -    else
> -        malloc_trim=3D"no"
> -    fi
> -fi
> -
> -##########################################
> -# tcmalloc probe
> -
> -if test "$tcmalloc" =3D "yes" ; then
> -  cat > $TMPC << EOF
> -#include <stdlib.h>
> -int main(void) {
> -    void *tmp =3D malloc(1);
> -    if (tmp !=3D NULL) {
> -        return 0;
> -    }
> -    return 1;
> -}
> -EOF
> -
> -  if compile_prog "" "-ltcmalloc" ; then
> -    LIBS=3D"-ltcmalloc $LIBS"
> -  else
> -    feature_not_found "tcmalloc" "install gperftools devel"
> -  fi
> -fi
> -
> -##########################################
> -# jemalloc probe
> -
> -if test "$jemalloc" =3D "yes" ; then
> -  cat > $TMPC << EOF
> -#include <stdlib.h>
> -int main(void) {
> -    void *tmp =3D malloc(1);
> -    if (tmp !=3D NULL) {
> -        return 0;
> -    }
> -    return 1;
> -}
> -EOF
> -
> -  if compile_prog "" "-ljemalloc" ; then
> -    LIBS=3D"-ljemalloc $LIBS"
> -  else
> -    feature_not_found "jemalloc" "install jemalloc devel"
> -  fi
> +elif test "$tcmalloc" =3D "yes" ; then
> +    malloc=3Dtcmalloc
> +elif test "$jemalloc" =3D "yes" ; then
> +    malloc=3Djemalloc
>  fi
>
>  ##########################################
> @@ -7023,10 +6960,6 @@ if test "$gbm" =3D "yes" ; then
>  fi
>
>
> -if test "$malloc_trim" =3D "yes" ; then
> -  echo "CONFIG_MALLOC_TRIM=3Dy" >> $config_host_mak
> -fi
> -
>  if test "$avx2_opt" =3D "yes" ; then
>    echo "CONFIG_AVX2_OPT=3Dy" >> $config_host_mak
>  fi
> @@ -8003,6 +7936,7 @@ NINJA=3D${ninja:-$PWD/ninjatool} $meson setup \
>          -Dstrip=3D$(if test "$strip_opt" =3D yes; then echo true; else e=
cho
false; fi) \
>          -Db_pie=3D$(if test "$pie" =3D yes; then echo true; else echo fa=
lse;
fi) \
>          -Db_coverage=3D$(if test "$gcov" =3D yes; then echo true; else e=
cho
false; fi) \
> +       -Dmalloc=3D$malloc -Dmalloc_trim=3D$malloc_trim \
>         -Dsdl=3D$sdl -Dsdl_image=3D$sdl_image \
>         -Dvnc=3D$vnc -Dvnc_sasl=3D$vnc_sasl -Dvnc_jpeg=3D$vnc_jpeg
-Dvnc_png=3D$vnc_png \
>         -Dgettext=3D$gettext -Dxkbcommon=3D$xkbcommon -Du2f=3D$u2f\
> diff --git a/meson.build b/meson.build
> index bba766b4bc..d3b1e5c34c 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -439,6 +439,26 @@ keyutils =3D dependency('libkeyutils', required: fal=
se,
>
>  has_gettid =3D cc.has_function('gettid')
>
> +# Malloc tests
> +
> +malloc =3D []
> +if get_option('malloc') =3D=3D 'system'
> +  has_malloc_trim =3D \
> +    not get_option('malloc_trim').disabled() and \
> +    cc.compiles('''#include <malloc.h>
> +                   int main(void) { malloc_trim(0); return 0; }''')
> +else
> +  has_malloc_trim =3D false
> +  malloc =3D cc.find_library(get_option('malloc'), required: true)
> +endif
> +if not has_malloc_trim and get_option('malloc_trim').enabled()
> +  if get_option('malloc') =3D=3D 'system'
> +    error('malloc_trim not available on this platform.')
> +  else
> +    error('malloc_trim not available with non-libc memory allocator')
> +  endif
> +endif
> +
>  # Create config-host.h
>
>  config_host_data.set('CONFIG_SDL', sdl.found())
> @@ -450,6 +470,7 @@ config_host_data.set('CONFIG_VNC_SASL', sasl.found())
>  config_host_data.set('CONFIG_XKBCOMMON', xkbcommon.found())
>  config_host_data.set('CONFIG_KEYUTILS', keyutils.found())
>  config_host_data.set('CONFIG_GETTID', has_gettid)
> +config_host_data.set('CONFIG_MALLOC_TRIM', has_malloc_trim)
>  config_host_data.set('QEMU_VERSION', '"@0@
"'.format(meson.project_version()))
>  config_host_data.set('QEMU_VERSION_MAJOR',
meson.project_version().split('.')[0])
>  config_host_data.set('QEMU_VERSION_MINOR',
meson.project_version().split('.')[1])
> @@ -818,7 +839,7 @@ util_ss.add_all(trace_ss)
>  util_ss =3D util_ss.apply(config_all, strict: false)
>  libqemuutil =3D static_library('qemuutil',
>                               sources: util_ss.sources() +
stub_ss.sources() + genh,
> -                             dependencies: [util_ss.dependencies(), m,
glib, socket])
> +                             dependencies: [util_ss.dependencies(), m,
glib, socket, malloc])
>  qemuutil =3D declare_dependency(link_with: libqemuutil,
>                                sources: genh + version_res)
>
> @@ -1442,7 +1463,7 @@ summary_info +=3D {'Install blobs':
config_host.has_key('INSTALL_BLOBS')}
>  #  summary_info +=3D {'TCG debug enabled':
config_host.has_key('CONFIG_DEBUG_TCG')}
>  #  summary_info +=3D {'TCG interpreter':
config_host.has_key('CONFIG_TCG_INTERPRETER')}
>  #endif
> -summary_info +=3D {'malloc trim support':
config_host.has_key('CONFIG_MALLOC_TRIM')}
> +summary_info +=3D {'malloc trim support': has_malloc_trim}
>  summary_info +=3D {'RDMA support':      config_host.has_key('CONFIG_RDMA=
')}
>  summary_info +=3D {'PVRDMA support':
 config_host.has_key('CONFIG_PVRDMA')}
>  summary_info +=3D {'fdt support':       config_host.has_key('CONFIG_FDT'=
)}
> @@ -1504,8 +1525,7 @@ summary_info +=3D {'lzfse support':
config_host.has_key('CONFIG_LZFSE')}
>  summary_info +=3D {'zstd support':      config_host.has_key('CONFIG_ZSTD=
')}
>  summary_info +=3D {'NUMA host support': config_host.has_key('CONFIG_NUMA=
')}
>  summary_info +=3D {'libxml2':
config_host.has_key('CONFIG_LIBXML2')}
> -summary_info +=3D {'tcmalloc support':
 config_host.has_key('CONFIG_TCMALLOC')}
> -summary_info +=3D {'jemalloc support':
 config_host.has_key('CONFIG_JEMALLOC')}
> +summary_info +=3D {'memory allocator':  get_option('malloc')}
>  summary_info +=3D {'avx2 optimization':
config_host.has_key('CONFIG_AVX2_OPT')}
>  summary_info +=3D {'avx512f optimization':
config_host.has_key('CONFIG_AVX512F_OPT')}
>  summary_info +=3D {'replication support':
config_host.has_key('CONFIG_REPLICATION')}
> diff --git a/meson_options.txt b/meson_options.txt
> index 543cf70043..894e006799 100644
> --- a/meson_options.txt
> +++ b/meson_options.txt
> @@ -6,6 +6,11 @@ option('docdir', type : 'string', value : 'doc',
>  option('gettext', type : 'boolean', value : true,
>         description: 'Localization of the GTK+ user interface')
>
> +option('malloc_trim', type : 'feature', value : 'auto',
> +       description: 'enable libc malloc_trim() for memory optimization')
> +option('malloc', type : 'combo', choices : ['system', 'tcmalloc',
'jemalloc'],
> +       value: 'system', description: 'choose memory allocator to use')
> +
>  option('sdl', type : 'feature', value : 'auto',
>         description: 'SDL user interface')
>  option('sdl_image', type : 'feature', value : 'auto',
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

--000000000000cfbd9805af9605c8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br>On Wed, Sep 16, 2020 at 4:07 PM Paolo Bonzini &lt;=
<a href=3D"mailto:pbonzini@redhat.com">pbonzini@redhat.com</a>&gt; wrote:<b=
r>&gt;<br>&gt; Because LIBS is not used anymore, tcmalloc/jemalloc does<br>=
&gt; not work with binaries whose description is in Meson.<br>&gt; The fix =
is simply to move them to Meson too.<br>&gt;<br>&gt; For consistency with o=
ther configure options, specifying<br>&gt; --enable-malloc-trim together wi=
th --enable-{tc,je}malloc<br>&gt; becomes a fatal error.<br>&gt;<br>&gt; Re=
ported-by: Stefan Hajnoczi &lt;<a href=3D"mailto:stefanha@redhat.com">stefa=
nha@redhat.com</a>&gt;<br>&gt; Signed-off-by: Paolo Bonzini &lt;<a href=3D"=
mailto:pbonzini@redhat.com">pbonzini@redhat.com</a>&gt;<br>&gt; ---<br>&gt;=
 =C2=A0configure =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 84 +++++--------------------=
----------------------<br>&gt; =C2=A0meson.build =C2=A0 =C2=A0 =C2=A0 | 28 =
+++++++++++++---<br>&gt; =C2=A0meson_options.txt | =C2=A05 +++<br>&gt; =C2=
=A03 files changed, 38 insertions(+), 79 deletions(-)<br>&gt;<br>&gt; diff =
--git a/configure b/configure<br>&gt; index ce27eafb0a..13f53ba231 100755<b=
r>&gt; --- a/configure<br>&gt; +++ b/configure<br>&gt; @@ -540,7 +540,7 @@ =
skip_meson=3Dno<br>&gt; =C2=A0gettext=3D&quot;&quot;<br>&gt;<br>&gt; =C2=A0=
bogus_os=3D&quot;no&quot;<br>&gt; -malloc_trim=3D&quot;&quot;<br>&gt; +mall=
oc_trim=3D&quot;auto&quot;<br>&gt;<br>&gt; =C2=A0deprecated_features=3D&quo=
t;&quot;<br>&gt;<br>&gt; @@ -1222,9 +1222,9 @@ for opt do<br>&gt; =C2=A0 =
=C2=A0;;<br>&gt; =C2=A0 =C2=A0--enable-tcg) tcg=3D&quot;yes&quot;<br>&gt; =
=C2=A0 =C2=A0;;<br>&gt; - =C2=A0--disable-malloc-trim) malloc_trim=3D&quot;=
no&quot;<br>&gt; + =C2=A0--disable-malloc-trim) malloc_trim=3D&quot;disable=
d&quot;<br>&gt; =C2=A0 =C2=A0;;<br>&gt; - =C2=A0--enable-malloc-trim) mallo=
c_trim=3D&quot;yes&quot;<br>&gt; + =C2=A0--enable-malloc-trim) malloc_trim=
=3D&quot;enabled&quot;<br>&gt; =C2=A0 =C2=A0;;<br>&gt; =C2=A0 =C2=A0--disab=
le-spice) spice=3D&quot;no&quot;<br>&gt; =C2=A0 =C2=A0;;<br>&gt; @@ -4428,7=
7 +4428,14 @@ EOF<br>&gt; =C2=A0 =C2=A0fi<br>&gt; =C2=A0fi<br>&gt;<br>&gt; =
+malloc=3Dsystem<br>&gt; =C2=A0if test &quot;$tcmalloc&quot; =3D &quot;yes&=
quot; &amp;&amp; test &quot;$jemalloc&quot; =3D &quot;yes&quot; ; then<br>&=
gt; =C2=A0 =C2=A0 =C2=A0echo &quot;ERROR: tcmalloc &amp;&amp; jemalloc can&=
#39;t be used at the same time&quot;<br>&gt; =C2=A0 =C2=A0 =C2=A0exit 1<br>=
&gt; -fi<div>This patch looks good for me, but I still have a small advice =
than move thse judgement from</div><div>configure to meson, because finally=
 they need to be converted.</div><div>and getting tcmalloc /=C2=A0

jemalloc to be &quot;enabled&quot; &quot;disabled&quot; for consistence</di=
v><div><br></div><div><br></div><div>&gt; -<br>&gt; -# Even if malloc_trim(=
) is available, these non-libc memory allocators<br>&gt; -# do not support =
it.<br>&gt; -if test &quot;$tcmalloc&quot; =3D &quot;yes&quot; || test &quo=
t;$jemalloc&quot; =3D &quot;yes&quot; ; then<br>&gt; - =C2=A0 =C2=A0if test=
 &quot;$malloc_trim&quot; =3D &quot;yes&quot; ; then<br>&gt; - =C2=A0 =C2=
=A0 =C2=A0 =C2=A0echo &quot;Disabling malloc_trim with non-libc memory allo=
cator&quot;<br>&gt; - =C2=A0 =C2=A0fi<br>&gt; - =C2=A0 =C2=A0malloc_trim=3D=
&quot;no&quot;<br>&gt; -fi<br>&gt; -<br>&gt; -#############################=
##########<br>&gt; -# malloc_trim<br>&gt; -<br>&gt; -if test &quot;$malloc_=
trim&quot; !=3D &quot;no&quot; ; then<br>&gt; - =C2=A0 =C2=A0cat &gt; $TMPC=
 &lt;&lt; EOF<br>&gt; -#include &lt;malloc.h&gt;<br>&gt; -int main(void) { =
malloc_trim(0); return 0; }<br>&gt; -EOF<br>&gt; - =C2=A0 =C2=A0if compile_=
prog &quot;&quot; &quot;&quot; ; then<br>&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0=
malloc_trim=3D&quot;yes&quot;<br>&gt; - =C2=A0 =C2=A0else<br>&gt; - =C2=A0 =
=C2=A0 =C2=A0 =C2=A0malloc_trim=3D&quot;no&quot;<br>&gt; - =C2=A0 =C2=A0fi<=
br>&gt; -fi<br>&gt; -<br>&gt; -##########################################<b=
r>&gt; -# tcmalloc probe<br>&gt; -<br>&gt; -if test &quot;$tcmalloc&quot; =
=3D &quot;yes&quot; ; then<br>&gt; - =C2=A0cat &gt; $TMPC &lt;&lt; EOF<br>&=
gt; -#include &lt;stdlib.h&gt;<br>&gt; -int main(void) {<br>&gt; - =C2=A0 =
=C2=A0void *tmp =3D malloc(1);<br>&gt; - =C2=A0 =C2=A0if (tmp !=3D NULL) {<=
br>&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>&gt; - =C2=A0 =C2=A0}<br>=
&gt; - =C2=A0 =C2=A0return 1;<br>&gt; -}<br>&gt; -EOF<br>&gt; -<br>&gt; - =
=C2=A0if compile_prog &quot;&quot; &quot;-ltcmalloc&quot; ; then<br>&gt; - =
=C2=A0 =C2=A0LIBS=3D&quot;-ltcmalloc $LIBS&quot;<br>&gt; - =C2=A0else<br>&g=
t; - =C2=A0 =C2=A0feature_not_found &quot;tcmalloc&quot; &quot;install gper=
ftools devel&quot;<br>&gt; - =C2=A0fi<br>&gt; -fi<br>&gt; -<br>&gt; -######=
####################################<br>&gt; -# jemalloc probe<br>&gt; -<br=
>&gt; -if test &quot;$jemalloc&quot; =3D &quot;yes&quot; ; then<br>&gt; - =
=C2=A0cat &gt; $TMPC &lt;&lt; EOF<br>&gt; -#include &lt;stdlib.h&gt;<br>&gt=
; -int main(void) {<br>&gt; - =C2=A0 =C2=A0void *tmp =3D malloc(1);<br>&gt;=
 - =C2=A0 =C2=A0if (tmp !=3D NULL) {<br>&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0r=
eturn 0;<br>&gt; - =C2=A0 =C2=A0}<br>&gt; - =C2=A0 =C2=A0return 1;<br>&gt; =
-}<br>&gt; -EOF<br>&gt; -<br>&gt; - =C2=A0if compile_prog &quot;&quot; &quo=
t;-ljemalloc&quot; ; then<br>&gt; - =C2=A0 =C2=A0LIBS=3D&quot;-ljemalloc $L=
IBS&quot;<br>&gt; - =C2=A0else<br>&gt; - =C2=A0 =C2=A0feature_not_found &qu=
ot;jemalloc&quot; &quot;install jemalloc devel&quot;<br>&gt; - =C2=A0fi<br>=
&gt; +elif test &quot;$tcmalloc&quot; =3D &quot;yes&quot; ; then<br>&gt; + =
=C2=A0 =C2=A0malloc=3Dtcmalloc<br>&gt; +elif test &quot;$jemalloc&quot; =3D=
 &quot;yes&quot; ; then<br>&gt; + =C2=A0 =C2=A0malloc=3Djemalloc<br>&gt; =
=C2=A0fi<br>&gt;<br>&gt; =C2=A0##########################################<b=
r>&gt; @@ -7023,10 +6960,6 @@ if test &quot;$gbm&quot; =3D &quot;yes&quot; =
; then<br>&gt; =C2=A0fi<br>&gt;<br>&gt;<br>&gt; -if test &quot;$malloc_trim=
&quot; =3D &quot;yes&quot; ; then<br>&gt; - =C2=A0echo &quot;CONFIG_MALLOC_=
TRIM=3Dy&quot; &gt;&gt; $config_host_mak<br>&gt; -fi<br>&gt; -<br>&gt; =C2=
=A0if test &quot;$avx2_opt&quot; =3D &quot;yes&quot; ; then<br>&gt; =C2=A0 =
=C2=A0echo &quot;CONFIG_AVX2_OPT=3Dy&quot; &gt;&gt; $config_host_mak<br>&gt=
; =C2=A0fi<br>&gt; @@ -8003,6 +7936,7 @@ NINJA=3D${ninja:-$PWD/ninjatool} $=
meson setup \<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-Dstrip=3D$(if test=
 &quot;$strip_opt&quot; =3D yes; then echo true; else echo false; fi) \<br>=
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-Db_pie=3D$(if test &quot;$pie&quot;=
 =3D yes; then echo true; else echo false; fi) \<br>&gt; =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0-Db_coverage=3D$(if test &quot;$gcov&quot; =3D yes; then e=
cho true; else echo false; fi) \<br>&gt; + =C2=A0 =C2=A0 =C2=A0 -Dmalloc=3D=
$malloc -Dmalloc_trim=3D$malloc_trim \<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
-Dsdl=3D$sdl -Dsdl_image=3D$sdl_image \<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 -Dvnc=3D$vnc -Dvnc_sasl=3D$vnc_sasl -Dvnc_jpeg=3D$vnc_jpeg -Dvnc_png=3D$vn=
c_png \<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 -Dgettext=3D$gettext -Dxkbcommo=
n=3D$xkbcommon -Du2f=3D$u2f\<br>&gt; diff --git a/meson.build b/meson.build=
<br>&gt; index bba766b4bc..d3b1e5c34c 100644<br>&gt; --- a/meson.build<br>&=
gt; +++ b/meson.build<br>&gt; @@ -439,6 +439,26 @@ keyutils =3D dependency(=
&#39;libkeyutils&#39;, required: false,<br>&gt;<br>&gt; =C2=A0has_gettid =
=3D cc.has_function(&#39;gettid&#39;)<br>&gt;<br>&gt; +# Malloc tests<br>&g=
t; +<br>&gt; +malloc =3D []<br>&gt; +if get_option(&#39;malloc&#39;) =3D=3D=
 &#39;system&#39;<br>&gt; + =C2=A0has_malloc_trim =3D \<br>&gt; + =C2=A0 =
=C2=A0not get_option(&#39;malloc_trim&#39;).disabled() and \<br>&gt; + =C2=
=A0 =C2=A0cc.compiles(&#39;&#39;&#39;#include &lt;malloc.h&gt;<br>&gt; + =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int main(voi=
d) { malloc_trim(0); return 0; }&#39;&#39;&#39;)<br>&gt; +else<br>&gt; + =
=C2=A0has_malloc_trim =3D false<br>&gt; + =C2=A0malloc =3D cc.find_library(=
get_option(&#39;malloc&#39;), required: true)<br>&gt; +endif<br>&gt; +if no=
t has_malloc_trim and get_option(&#39;malloc_trim&#39;).enabled()<br>&gt; +=
 =C2=A0if get_option(&#39;malloc&#39;) =3D=3D &#39;system&#39;<br>&gt; + =
=C2=A0 =C2=A0error(&#39;malloc_trim not available on this platform.&#39;)<b=
r>&gt; + =C2=A0else<br>&gt; + =C2=A0 =C2=A0error(&#39;malloc_trim not avail=
able with non-libc memory allocator&#39;)<br>&gt; + =C2=A0endif<br>&gt; +en=
dif<br>&gt; +<br>&gt; =C2=A0# Create config-host.h<br>&gt;<br>&gt; =C2=A0co=
nfig_host_data.set(&#39;CONFIG_SDL&#39;, sdl.found())<br>&gt; @@ -450,6 +47=
0,7 @@ config_host_data.set(&#39;CONFIG_VNC_SASL&#39;, sasl.found())<br>&gt=
; =C2=A0config_host_data.set(&#39;CONFIG_XKBCOMMON&#39;, xkbcommon.found())=
<br>&gt; =C2=A0config_host_data.set(&#39;CONFIG_KEYUTILS&#39;, keyutils.fou=
nd())<br>&gt; =C2=A0config_host_data.set(&#39;CONFIG_GETTID&#39;, has_getti=
d)<br>&gt; +config_host_data.set(&#39;CONFIG_MALLOC_TRIM&#39;, has_malloc_t=
rim)<br>&gt; =C2=A0config_host_data.set(&#39;QEMU_VERSION&#39;, &#39;&quot;=
@0@&quot;&#39;.format(meson.project_version()))<br>&gt; =C2=A0config_host_d=
ata.set(&#39;QEMU_VERSION_MAJOR&#39;, meson.project_version().split(&#39;.&=
#39;)[0])<br>&gt; =C2=A0config_host_data.set(&#39;QEMU_VERSION_MINOR&#39;, =
meson.project_version().split(&#39;.&#39;)[1])<br>&gt; @@ -818,7 +839,7 @@ =
util_ss.add_all(trace_ss)<br>&gt; =C2=A0util_ss =3D util_ss.apply(config_al=
l, strict: false)<br>&gt; =C2=A0libqemuutil =3D static_library(&#39;qemuuti=
l&#39;,<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sources: util_ss.sources() + =
stub_ss.sources() + genh,<br>&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dependencies: [=
util_ss.dependencies(), m, glib, socket])<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 dependencies: [util_ss.dependencies(), m, glib, socket, malloc])<br>&gt=
; =C2=A0qemuutil =3D declare_dependency(link_with: libqemuutil,<br>&gt; =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sources: genh + version_res)<br>&gt;<br>&=
gt; @@ -1442,7 +1463,7 @@ summary_info +=3D {&#39;Install blobs&#39;: =C2=
=A0 =C2=A0 config_host.has_key(&#39;INSTALL_BLOBS&#39;)}<br>&gt; =C2=A0# =
=C2=A0summary_info +=3D {&#39;TCG debug enabled&#39;: config_host.has_key(&=
#39;CONFIG_DEBUG_TCG&#39;)}<br>&gt; =C2=A0# =C2=A0summary_info +=3D {&#39;T=
CG interpreter&#39;: =C2=A0 config_host.has_key(&#39;CONFIG_TCG_INTERPRETER=
&#39;)}<br>&gt; =C2=A0#endif<br>&gt; -summary_info +=3D {&#39;malloc trim s=
upport&#39;: config_host.has_key(&#39;CONFIG_MALLOC_TRIM&#39;)}<br>&gt; +su=
mmary_info +=3D {&#39;malloc trim support&#39;: has_malloc_trim}<br>&gt; =
=C2=A0summary_info +=3D {&#39;RDMA support&#39;: =C2=A0 =C2=A0 =C2=A0config=
_host.has_key(&#39;CONFIG_RDMA&#39;)}<br>&gt; =C2=A0summary_info +=3D {&#39=
;PVRDMA support&#39;: =C2=A0 =C2=A0config_host.has_key(&#39;CONFIG_PVRDMA&#=
39;)}<br>&gt; =C2=A0summary_info +=3D {&#39;fdt support&#39;: =C2=A0 =C2=A0=
 =C2=A0 config_host.has_key(&#39;CONFIG_FDT&#39;)}<br>&gt; @@ -1504,8 +1525=
,7 @@ summary_info +=3D {&#39;lzfse support&#39;: =C2=A0 =C2=A0 config_host=
.has_key(&#39;CONFIG_LZFSE&#39;)}<br>&gt; =C2=A0summary_info +=3D {&#39;zst=
d support&#39;: =C2=A0 =C2=A0 =C2=A0config_host.has_key(&#39;CONFIG_ZSTD&#3=
9;)}<br>&gt; =C2=A0summary_info +=3D {&#39;NUMA host support&#39;: config_h=
ost.has_key(&#39;CONFIG_NUMA&#39;)}<br>&gt; =C2=A0summary_info +=3D {&#39;l=
ibxml2&#39;: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 config_host.has_key(&#39;CO=
NFIG_LIBXML2&#39;)}<br>&gt; -summary_info +=3D {&#39;tcmalloc support&#39;:=
 =C2=A0config_host.has_key(&#39;CONFIG_TCMALLOC&#39;)}<br>&gt; -summary_inf=
o +=3D {&#39;jemalloc support&#39;: =C2=A0config_host.has_key(&#39;CONFIG_J=
EMALLOC&#39;)}<br>&gt; +summary_info +=3D {&#39;memory allocator&#39;: =C2=
=A0get_option(&#39;malloc&#39;)}<br>&gt; =C2=A0summary_info +=3D {&#39;avx2=
 optimization&#39;: config_host.has_key(&#39;CONFIG_AVX2_OPT&#39;)}<br>&gt;=
 =C2=A0summary_info +=3D {&#39;avx512f optimization&#39;: config_host.has_k=
ey(&#39;CONFIG_AVX512F_OPT&#39;)}<br>&gt; =C2=A0summary_info +=3D {&#39;rep=
lication support&#39;: config_host.has_key(&#39;CONFIG_REPLICATION&#39;)}<b=
r>&gt; diff --git a/meson_options.txt b/meson_options.txt<br>&gt; index 543=
cf70043..894e006799 100644<br>&gt; --- a/meson_options.txt<br>&gt; +++ b/me=
son_options.txt<br>&gt; @@ -6,6 +6,11 @@ option(&#39;docdir&#39;, type : &#=
39;string&#39;, value : &#39;doc&#39;,<br>&gt; =C2=A0option(&#39;gettext&#3=
9;, type : &#39;boolean&#39;, value : true,<br>&gt; =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 description: &#39;Localization of the GTK+ user interface&#39;)<br>&=
gt;<br>&gt; +option(&#39;malloc_trim&#39;, type : &#39;feature&#39;, value =
: &#39;auto&#39;,<br>&gt; + =C2=A0 =C2=A0 =C2=A0 description: &#39;enable l=
ibc malloc_trim() for memory optimization&#39;)<br>&gt; +option(&#39;malloc=
&#39;, type : &#39;combo&#39;, choices : [&#39;system&#39;, &#39;tcmalloc&#=
39;, &#39;jemalloc&#39;],<br>&gt; + =C2=A0 =C2=A0 =C2=A0 value: &#39;system=
&#39;, description: &#39;choose memory allocator to use&#39;)<br>&gt; +<br>=
&gt; =C2=A0option(&#39;sdl&#39;, type : &#39;feature&#39;, value : &#39;aut=
o&#39;,<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 description: &#39;SDL user inte=
rface&#39;)<br>&gt; =C2=A0option(&#39;sdl_image&#39;, type : &#39;feature&#=
39;, value : &#39;auto&#39;,<br>&gt; --<br>&gt; 2.26.2<br>&gt;<br>&gt;<br><=
br><br>--<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=E6=AD=A4=E8=87=B4<br>=E7=A4=
=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=A0 sincerely,<br>=
Yonggang Luo</div></div>

--000000000000cfbd9805af9605c8--

