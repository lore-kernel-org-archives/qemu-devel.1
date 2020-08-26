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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 381A4C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 08:07:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 022BE20866
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 08:07:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kCu0WMyw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 022BE20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAqSc-0002jW-At
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 04:07:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59458)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kAqRr-0001F8-Id
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 04:06:23 -0400
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:36656)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kAqRp-0004ep-Fe
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 04:06:23 -0400
Received: by mail-ed1-x543.google.com with SMTP id q4so935755eds.3
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2020 01:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=h2PGse28TOxwLvNEg8Gx7oK3tJ4tyVMTZblV+dnbIjc=;
 b=kCu0WMywcI/MKCbgK5mGA8Ael4UNuwM+8mqvkCTxcpIoIHlAMgqQeb/CjORXZf0c0X
 LuhIEnsVyUDrzFl9UMwgLqkl9yToy148wF5txJfXIyjAlnb744gEeLQ1o74yo34DrDQC
 rHBY0SOEFEAp0e9LGR7H4RijSHdc9E9GQ27xQzqnEmt1m307VbikOBdzDkiwgT7Xq3t+
 P+A4f9+VcGW5064gkrI32KGbpUhrOPKHT+JR5jVhN0khRXX9gjCVWttiHtHV6efY3ZPR
 hPpH7PjBCMvneC1ow4Zy/pPm2Oh0WKHBpWrMI8eJ0xiTYK2EKycVeAqq4zwXd8vH+T81
 BsrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=h2PGse28TOxwLvNEg8Gx7oK3tJ4tyVMTZblV+dnbIjc=;
 b=kNZCdxSrwZA6d+RowjeM1KPLt+Qp9R2Qp3wOQZ2DRzk25hepWZ/I4s0BzKWkFc/HqP
 wOAS9pPipGqgeuEeU1gBUrtig9Eg+GjOvE5zNLMCgj3dRBbgMm/6vgJ4i70tgKX/8Ehs
 ENP33By5iCpQz3UhFVQ7CWSryTCJbpDKY+3Q/bUn7JgHLTf+xYGHkvxHzMsY78d2ptym
 /dwj//jtIyex4Le6lzxQ/2w+2ZPxYLxiTVgZ7iGWJjk1MtcLGWmLJWNUXAex5vQ8b4kk
 4lLExvpTYVH/AEFSuQm0yHQvXJ0IO2mMR4q7P48IRHzMyoPwyxcqqi0hEf5zvJtcDSjZ
 NWlg==
X-Gm-Message-State: AOAM533istkihtTMUwJuDCzopcP23S5T0VTFwyxj8NlXrLCshRhyhZeL
 slAccuj8p/hyDrGkmOQ9s8xEEkiyMZMUbUtM27I=
X-Google-Smtp-Source: ABdhPJzeeYUQ9bVNdQfX5W0rBWjIqvZi3F1ERiqFOAvj8GijodbYe9xvFTisAzQ6Ssx0PIf7jtDv+BOH83IfgaI53V8=
X-Received: by 2002:a50:fc82:: with SMTP id f2mr13907690edq.53.1598429179531; 
 Wed, 26 Aug 2020 01:06:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200826070245.12051-1-pbonzini@redhat.com>
In-Reply-To: <20200826070245.12051-1-pbonzini@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 26 Aug 2020 12:06:07 +0400
Message-ID: <CAJ+F1CLeQoOF7J2q+_hZKxjEnvKbPRp8NU-1iTwreib5F8tT5A@mail.gmail.com>
Subject: Re: [PATCH] meson: skip SDL2 detection if --disable-system
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000071d70105adc34bb3"
Received-SPF: pass client-ip=2a00:1450:4864:20::543;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-ed1-x543.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000071d70105adc34bb3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2020 at 11:03 AM Paolo Bonzini <pbonzini@redhat.com> wrote:

> SDL is only used for system emulation; avoid spurious warnings for
> static --disable-system emulation by skipping the detection of
> the library if there are no system emulation targets.
>
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

---
>  meson.build | 27 ++++++++++++++++-----------
>  1 file changed, 16 insertions(+), 11 deletions(-)
>
> diff --git a/meson.build b/meson.build
> index 57c2fe2b65..19d4d42512 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -21,6 +21,16 @@ qemu_datadir =3D get_option('datadir') +
> get_option('confsuffix')
>  config_host_data =3D configuration_data()
>  genh =3D []
>
> +target_dirs =3D config_host['TARGET_DIRS'].split()
> +have_user =3D false
> +have_system =3D false
> +foreach target : target_dirs
> +  have_user =3D have_user or target.endswith('-user')
> +  have_system =3D have_system or target.endswith('-softmmu')
> +endforeach
> +have_tools =3D 'CONFIG_TOOLS' in config_host
> +have_block =3D have_system or have_tools
> +
>  add_project_arguments(config_host['QEMU_CFLAGS'].split(),
>                        native: false, language: ['c', 'objc'])
>  add_project_arguments(config_host['QEMU_CXXFLAGS'].split(),
> @@ -225,9 +235,12 @@ if 'CONFIG_BRLAPI' in config_host
>    brlapi =3D declare_dependency(link_args:
> config_host['BRLAPI_LIBS'].split())
>  endif
>
> -sdl =3D dependency('sdl2', required: get_option('sdl'), static:
> enable_static,
> -                 include_type: 'system')
> -sdl_image =3D not_found
> +sdl =3D not_found
> +if have_system
> +  sdl =3D dependency('sdl2', required: get_option('sdl'), static:
> enable_static,
> +                   include_type: 'system')
> +  sdl_image =3D not_found
> +endif
>  if sdl.found()
>    # work around 2.0.8 bug
>    sdl =3D declare_dependency(compile_args: '-Wno-undef',
> @@ -423,9 +436,6 @@ endforeach
>  genh +=3D configure_file(output: 'config-host.h', configuration:
> config_host_data)
>
>  minikconf =3D find_program('scripts/minikconf.py')
> -target_dirs =3D config_host['TARGET_DIRS'].split()
> -have_user =3D false
> -have_system =3D false
>  config_devices_mak_list =3D []
>  config_devices_h =3D {}
>  config_target_h =3D {}
> @@ -446,7 +456,6 @@ kconfig_external_symbols =3D [
>  ]
>  ignored =3D ['TARGET_XML_FILES', 'TARGET_ABI_DIR', 'TARGET_DIRS']
>  foreach target : target_dirs
> -  have_user =3D have_user or target.endswith('-user')
>    config_target =3D keyval.load(meson.current_build_dir() / target /
> 'config-target.mak')
>
>    config_target_data =3D configuration_data()
> @@ -469,8 +478,6 @@ foreach target : target_dirs
>                                                 configuration:
> config_target_data)}
>
>    if target.endswith('-softmmu')
> -    have_system =3D true
> -
>      base_kconfig =3D []
>      foreach sym : kconfig_external_symbols
>        if sym in config_target or sym in config_host
> @@ -500,8 +507,6 @@ foreach target : target_dirs
>    endif
>    config_target_mak +=3D {target: config_target}
>  endforeach
> -have_tools =3D 'CONFIG_TOOLS' in config_host
> -have_block =3D have_system or have_tools
>
>  grepy =3D find_program('scripts/grepy.sh')
>  # This configuration is used to build files that are shared by
> --
> 2.26.2
>
>
>

--=20
Marc-Andr=C3=A9 Lureau

--00000000000071d70105adc34bb3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, Aug 26, 2020 at 11:03 AM Paol=
o Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com">pbonzini@redhat.com</a=
>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">SDL=
 is only used for system emulation; avoid spurious warnings for<br>
static --disable-system emulation by skipping the detection of<br>
the library if there are no system emulation targets.<br>
<br>
Reported-by: Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org" =
target=3D"_blank">peter.maydell@linaro.org</a>&gt;<br>
Signed-off-by: Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com" tar=
get=3D"_blank">pbonzini@redhat.com</a>&gt;<br></blockquote><div><br></div><=
div>Reviewed-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lur=
eau@redhat.com">marcandre.lureau@redhat.com</a>&gt;=C2=A0 <br></div><div><b=
r></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex=
;border-left:1px solid rgb(204,204,204);padding-left:1ex">
---<br>
=C2=A0meson.build | 27 ++++++++++++++++-----------<br>
=C2=A01 file changed, 16 insertions(+), 11 deletions(-)<br>
<br>
diff --git a/meson.build b/meson.build<br>
index 57c2fe2b65..19d4d42512 100644<br>
--- a/meson.build<br>
+++ b/meson.build<br>
@@ -21,6 +21,16 @@ qemu_datadir =3D get_option(&#39;datadir&#39;) + get_opt=
ion(&#39;confsuffix&#39;)<br>
=C2=A0config_host_data =3D configuration_data()<br>
=C2=A0genh =3D []<br>
<br>
+target_dirs =3D config_host[&#39;TARGET_DIRS&#39;].split()<br>
+have_user =3D false<br>
+have_system =3D false<br>
+foreach target : target_dirs<br>
+=C2=A0 have_user =3D have_user or target.endswith(&#39;-user&#39;)<br>
+=C2=A0 have_system =3D have_system or target.endswith(&#39;-softmmu&#39;)<=
br>
+endforeach<br>
+have_tools =3D &#39;CONFIG_TOOLS&#39; in config_host<br>
+have_block =3D have_system or have_tools<br>
+<br>
=C2=A0add_project_arguments(config_host[&#39;QEMU_CFLAGS&#39;].split(),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0native: false, language: [&#39;c&#39;, &#39;objc&#39;])<br>
=C2=A0add_project_arguments(config_host[&#39;QEMU_CXXFLAGS&#39;].split(),<b=
r>
@@ -225,9 +235,12 @@ if &#39;CONFIG_BRLAPI&#39; in config_host<br>
=C2=A0 =C2=A0brlapi =3D declare_dependency(link_args: config_host[&#39;BRLA=
PI_LIBS&#39;].split())<br>
=C2=A0endif<br>
<br>
-sdl =3D dependency(&#39;sdl2&#39;, required: get_option(&#39;sdl&#39;), st=
atic: enable_static,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0include_type=
: &#39;system&#39;)<br>
-sdl_image =3D not_found<br>
+sdl =3D not_found<br>
+if have_system<br>
+=C2=A0 sdl =3D dependency(&#39;sdl2&#39;, required: get_option(&#39;sdl&#3=
9;), static: enable_static,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0inclu=
de_type: &#39;system&#39;)<br>
+=C2=A0 sdl_image =3D not_found<br>
+endif<br>
=C2=A0if sdl.found()<br>
=C2=A0 =C2=A0# work around 2.0.8 bug<br>
=C2=A0 =C2=A0sdl =3D declare_dependency(compile_args: &#39;-Wno-undef&#39;,=
<br>
@@ -423,9 +436,6 @@ endforeach<br>
=C2=A0genh +=3D configure_file(output: &#39;config-host.h&#39;, configurati=
on: config_host_data)<br>
<br>
=C2=A0minikconf =3D find_program(&#39;scripts/minikconf.py&#39;)<br>
-target_dirs =3D config_host[&#39;TARGET_DIRS&#39;].split()<br>
-have_user =3D false<br>
-have_system =3D false<br>
=C2=A0config_devices_mak_list =3D []<br>
=C2=A0config_devices_h =3D {}<br>
=C2=A0config_target_h =3D {}<br>
@@ -446,7 +456,6 @@ kconfig_external_symbols =3D [<br>
=C2=A0]<br>
=C2=A0ignored =3D [&#39;TARGET_XML_FILES&#39;, &#39;TARGET_ABI_DIR&#39;, &#=
39;TARGET_DIRS&#39;]<br>
=C2=A0foreach target : target_dirs<br>
-=C2=A0 have_user =3D have_user or target.endswith(&#39;-user&#39;)<br>
=C2=A0 =C2=A0config_target =3D keyval.load(meson.current_build_dir() / targ=
et / &#39;config-target.mak&#39;)<br>
<br>
=C2=A0 =C2=A0config_target_data =3D configuration_data()<br>
@@ -469,8 +478,6 @@ foreach target : target_dirs<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 configuration: config_target_data)}<br>
<br>
=C2=A0 =C2=A0if target.endswith(&#39;-softmmu&#39;)<br>
-=C2=A0 =C2=A0 have_system =3D true<br>
-<br>
=C2=A0 =C2=A0 =C2=A0base_kconfig =3D []<br>
=C2=A0 =C2=A0 =C2=A0foreach sym : kconfig_external_symbols<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0if sym in config_target or sym in config_host<br=
>
@@ -500,8 +507,6 @@ foreach target : target_dirs<br>
=C2=A0 =C2=A0endif<br>
=C2=A0 =C2=A0config_target_mak +=3D {target: config_target}<br>
=C2=A0endforeach<br>
-have_tools =3D &#39;CONFIG_TOOLS&#39; in config_host<br>
-have_block =3D have_system or have_tools<br>
<br>
=C2=A0grepy =3D find_program(&#39;scripts/grepy.sh&#39;)<br>
=C2=A0# This configuration is used to build files that are shared by<br>
-- <br>
2.26.2<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature">Marc-Andr=C3=A9 Lureau<br></div></div>

--00000000000071d70105adc34bb3--

