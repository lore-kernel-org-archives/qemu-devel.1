Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5A27C433E7
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 10:26:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AFAD205F4
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 10:26:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D0kuAPg3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AFAD205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35730 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTMwr-0000hH-JO
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 06:26:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56632)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTMux-0008JL-P9
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 06:24:59 -0400
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641]:42666)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTMuv-0004wQ-BT
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 06:24:59 -0400
Received: by mail-ej1-x641.google.com with SMTP id h24so2348731ejg.9
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2020 03:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=duPu8sIgVJMec7hqGmUCR69i46WsG6gynAUf8/QCUXE=;
 b=D0kuAPg3bM5edRRpvU2WuipJ9PjmGkcammawg0XnV77XEHLlf7X6wEfI6vCBvxiLMr
 INsu3G3/FqJHc0CyHUJe5oDxDJ3LLO4p0OuBoEi4C/R7jS70vQceBWt+qFGS7mdX2Dh0
 xIMDVgsdU3oWt6MnHP/jIkIwnaHjQZ/4Ksr4e0g3POYb7m9vGGhA6i8QdXaXBE0TmlaJ
 vETWgjZ+I/43X1s+pu4b8aYVFFnjIkTwz/2+jvtr3azYA/yb8rsmQdouT24iAMBXT+Zh
 s/p77y75J0b5Zz8dJ4ZFlHG4SYTFcK6kURVl3qv1qhOroho1YVGHAzkaKmgAzkIwXrhQ
 Fxyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=duPu8sIgVJMec7hqGmUCR69i46WsG6gynAUf8/QCUXE=;
 b=XMMysYCaSNpHVvGJ+zYbS8NiIYzt0jLm6L052ilP1ser++dgmCDuhNAMNvrEt7ocWK
 6iNdNuT+nww1m+zIN5E03KuTo7+PnH3XFlq7TgY3RrmWSmtYZQs12YM0cOtIZBOSuZsQ
 ypx9pXajODXH11HfRAqHdDiwwhyp8xGXUBdj3uw1+nE5ONIlOE9JRpeAUA5/EWm6F0ri
 YJLT1ddi7BnlnJ6PaURhF3wrcdK46UpwblNT3L5zccDwya58MNMuzXuPLAlLRbcaKElF
 zYP5NMkySV5QKUGmMIUfFK4jcyi3j0tXil3l0niCX7RZxKS0OMFH9TcZEDW56YfC5el2
 rJSw==
X-Gm-Message-State: AOAM530o9jmSb8XIoz9xv5JzVZn+6Toq35r/4wiiBYQb5Ekq5V5S0NHl
 wpUjEUMF8jYzvP7HrVlWwuHNkDyjsAuXWVUMxJw=
X-Google-Smtp-Source: ABdhPJwyW6Ror9HHO0NLvzvIDirXb+q6La6FlheqTeO0yilck/qJ6Z/73lXZgy4WNAfoTFTXAtrVY7qE2vKYy2yyGxw=
X-Received: by 2002:a17:906:7f8c:: with SMTP id
 f12mr3136656ejr.8.1602843894640; 
 Fri, 16 Oct 2020 03:24:54 -0700 (PDT)
MIME-Version: 1.0
References: <20201016100031.1557275-1-pbonzini@redhat.com>
In-Reply-To: <20201016100031.1557275-1-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
 <philippe.mathieu.daude@gmail.com>
Date: Fri, 16 Oct 2020 12:24:41 +0200
Message-ID: <CAAdtpL6gX2_EAj1sK13orHi+h5bTiTOA5-gSsKD6Wrxwkxutbg@mail.gmail.com>
Subject: Re: [PATCH] ci: include configure and meson logs in all jobs if
 configure fails
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000f875ec05b1c72ca4"
Received-SPF: pass client-ip=2a00:1450:4864:20::641;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x641.google.com
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
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000f875ec05b1c72ca4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le ven. 16 oct. 2020 12:05, Paolo Bonzini <pbonzini@redhat.com> a =C3=A9cri=
t :

> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

---
>  .cirrus.yml    | 6 +++---
>  .gitlab-ci.yml | 6 +++---
>  .travis.yml    | 8 ++++----
>  3 files changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/.cirrus.yml b/.cirrus.yml
> index e099da0fec..81a2960b1a 100644
> --- a/.cirrus.yml
> +++ b/.cirrus.yml
> @@ -13,7 +13,7 @@ freebsd_12_task:
>    script:
>      - mkdir build
>      - cd build
> -    - ../configure --enable-werror || { cat config.log; exit 1; }
> +    - ../configure --enable-werror || { cat config.log
> meson-logs/meson-log.txt; exit 1; }
>      - gmake -j$(sysctl -n hw.ncpu)
>      - gmake -j$(sysctl -n hw.ncpu) check V=3D1
>
> @@ -27,7 +27,7 @@ macos_task:
>      - cd build
>      - ../configure --python=3D/usr/local/bin/python3 --enable-werror
>                     --extra-cflags=3D'-Wno-error=3Ddeprecated-declaration=
s'
> -                   || { cat config.log; exit 1; }
> +                   || { cat config.log meson-logs/meson-log.txt; exit 1;=
 }
>      - gmake -j$(sysctl -n hw.ncpu)
>      - gmake check V=3D1
>
> @@ -41,7 +41,7 @@ macos_xcode_task:
>      - mkdir build
>      - cd build
>      - ../configure --extra-cflags=3D'-Wno-error=3Ddeprecated-declaration=
s'
> -                   --enable-werror --cc=3Dclang || { cat config.log; exi=
t
> 1; }
> +                   --enable-werror --cc=3Dclang || { cat config.log
> meson-logs/meson-log.txt; exit 1; }
>      - gmake -j$(sysctl -n hw.ncpu)
>      - gmake check V=3D1
>
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index 8ffd415ca5..66ad7aa5c2 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -32,7 +32,7 @@ include:
>          ../configure --enable-werror $CONFIGURE_ARGS
> --target-list=3D"$TARGETS" ;
>        else
>          ../configure --enable-werror $CONFIGURE_ARGS ;
> -      fi
> +      fi || { cat config.log meson-logs/meson-log.txt && exit 1; }
>      - make -j"$JOBS"
>      - if test -n "$MAKE_CHECK_ARGS";
>        then
> @@ -229,7 +229,7 @@ build-tcg-disabled:
>    script:
>      - mkdir build
>      - cd build
> -    - ../configure --disable-tcg --audio-drv-list=3D""
> +    - ../configure --disable-tcg --audio-drv-list=3D"" || { cat config.l=
og
> meson-logs/meson-log.txt && exit 1; }
>      - make -j"$JOBS"
>      - make check-unit
>      - make check-qapi-schema
> @@ -322,7 +322,7 @@ build-tci:
>      - mkdir build
>      - cd build
>      - ../configure --enable-tcg-interpreter
> -        --target-list=3D"$(for tg in $TARGETS; do echo -n ${tg}'-softmmu=
 ';
> done)"
> +        --target-list=3D"$(for tg in $TARGETS; do echo -n ${tg}'-softmmu=
 ';
> done)" || { cat config.log meson-logs/meson-log.txt && exit 1; }
>      - make -j"$JOBS"
>      - make run-tcg-tests-x86_64-softmmu
>      - make tests/qtest/boot-serial-test tests/qtest/cdrom-test
> tests/qtest/pxe-test
> diff --git a/.travis.yml b/.travis.yml
> index d7bfbb8bfe..a3d78171ca 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -95,7 +95,7 @@ before_install:
>  # Configure step - may be overridden
>  before_script:
>    - mkdir -p ${BUILD_DIR} && cd ${BUILD_DIR}
> -  - ${SRC_DIR}/configure ${BASE_CONFIG} ${CONFIG} || { cat config.log &&
> exit 1; }
> +  - ${SRC_DIR}/configure ${BASE_CONFIG} ${CONFIG} || { cat config.log
> meson-logs/meson-log.txt && exit 1; }
>
>  # Main build & test - rarely overridden - controlled by TEST_CMD
>  script:
> @@ -199,7 +199,7 @@ jobs:
>        compiler: clang
>        before_script:
>          - mkdir -p ${BUILD_DIR} && cd ${BUILD_DIR}
> -        - ${SRC_DIR}/configure ${CONFIG}
> --extra-cflags=3D"-fsanitize=3Dundefined -Werror" || { cat config.log && =
exit
> 1; }
> +        - ${SRC_DIR}/configure ${CONFIG}
> --extra-cflags=3D"-fsanitize=3Dundefined -Werror" || { cat config.log
> meson-logs/meson-log.txt && exit 1; }
>
>
>      - name: "Clang (other-softmmu)"
> @@ -298,7 +298,7 @@ jobs:
>          - TEST_CMD=3D""
>        before_script:
>          - mkdir -p ${BUILD_DIR} && cd ${BUILD_DIR}
> -        - ${SRC_DIR}/configure ${CONFIG} --extra-cflags=3D"-g3 -O0
> -fsanitize=3Dthread" || { cat config.log && exit 1; }
> +        - ${SRC_DIR}/configure ${CONFIG} --extra-cflags=3D"-g3 -O0
> -fsanitize=3Dthread" || { cat config.log meson-logs/meson-log.txt && exit=
 1; }
>
>
>      # Run check-tcg against linux-user
> @@ -530,7 +530,7 @@ jobs:
>          - ls -l ${SRC_DIR}/qemu-${QEMU_VERSION}.tar.bz2
>          - tar -xf ${SRC_DIR}/qemu-${QEMU_VERSION}.tar.bz2 && cd
> qemu-${QEMU_VERSION}
>          - mkdir -p release-build && cd release-build
> -        - ../configure ${BASE_CONFIG} ${CONFIG} || { cat config.log &&
> exit 1; }
> +        - ../configure ${BASE_CONFIG} ${CONFIG} || { cat config.log
> meson-logs/meson-log.txt && exit 1; }
>          - make install
>    allow_failures:
>      - env: UNRELIABLE=3Dtrue
> --
> 2.26.2
>
>
>

--000000000000f875ec05b1c72ca4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D=
"gmail_attr">Le ven. 16 oct. 2020 12:05, Paolo Bonzini &lt;<a href=3D"mailt=
o:pbonzini@redhat.com">pbonzini@redhat.com</a>&gt; a =C3=A9crit=C2=A0:<br><=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-le=
ft:1px #ccc solid;padding-left:1ex">Signed-off-by: Paolo Bonzini &lt;<a hre=
f=3D"mailto:pbonzini@redhat.com" target=3D"_blank" rel=3D"noreferrer">pbonz=
ini@redhat.com</a>&gt;<br></blockquote></div></div><div dir=3D"auto"><br></=
div><div dir=3D"auto">Reviewed-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=
=3D"mailto:f4bug@amsat.org">f4bug@amsat.org</a>&gt;<br></div><div dir=3D"au=
to"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pad=
ding-left:1ex">
---<br>
=C2=A0.cirrus.yml=C2=A0 =C2=A0 | 6 +++---<br>
=C2=A0.gitlab-ci.yml | 6 +++---<br>
=C2=A0.travis.yml=C2=A0 =C2=A0 | 8 ++++----<br>
=C2=A03 files changed, 10 insertions(+), 10 deletions(-)<br>
<br>
diff --git a/.cirrus.yml b/.cirrus.yml<br>
index e099da0fec..81a2960b1a 100644<br>
--- a/.cirrus.yml<br>
+++ b/.cirrus.yml<br>
@@ -13,7 +13,7 @@ freebsd_12_task:<br>
=C2=A0 =C2=A0script:<br>
=C2=A0 =C2=A0 =C2=A0- mkdir build<br>
=C2=A0 =C2=A0 =C2=A0- cd build<br>
-=C2=A0 =C2=A0 - ../configure --enable-werror || { cat config.log; exit 1; =
}<br>
+=C2=A0 =C2=A0 - ../configure --enable-werror || { cat config.log meson-log=
s/meson-log.txt; exit 1; }<br>
=C2=A0 =C2=A0 =C2=A0- gmake -j$(sysctl -n hw.ncpu)<br>
=C2=A0 =C2=A0 =C2=A0- gmake -j$(sysctl -n hw.ncpu) check V=3D1<br>
<br>
@@ -27,7 +27,7 @@ macos_task:<br>
=C2=A0 =C2=A0 =C2=A0- cd build<br>
=C2=A0 =C2=A0 =C2=A0- ../configure --python=3D/usr/local/bin/python3 --enab=
le-werror<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 --ext=
ra-cflags=3D&#39;-Wno-error=3Ddeprecated-declarations&#39;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|| { =
cat config.log; exit 1; }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|| { =
cat config.log meson-logs/meson-log.txt; exit 1; }<br>
=C2=A0 =C2=A0 =C2=A0- gmake -j$(sysctl -n hw.ncpu)<br>
=C2=A0 =C2=A0 =C2=A0- gmake check V=3D1<br>
<br>
@@ -41,7 +41,7 @@ macos_xcode_task:<br>
=C2=A0 =C2=A0 =C2=A0- mkdir build<br>
=C2=A0 =C2=A0 =C2=A0- cd build<br>
=C2=A0 =C2=A0 =C2=A0- ../configure --extra-cflags=3D&#39;-Wno-error=3Ddepre=
cated-declarations&#39;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0--ena=
ble-werror --cc=3Dclang || { cat config.log; exit 1; }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0--ena=
ble-werror --cc=3Dclang || { cat config.log meson-logs/meson-log.txt; exit =
1; }<br>
=C2=A0 =C2=A0 =C2=A0- gmake -j$(sysctl -n hw.ncpu)<br>
=C2=A0 =C2=A0 =C2=A0- gmake check V=3D1<br>
<br>
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml<br>
index 8ffd415ca5..66ad7aa5c2 100644<br>
--- a/.gitlab-ci.yml<br>
+++ b/.gitlab-ci.yml<br>
@@ -32,7 +32,7 @@ include:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0../configure --enable-werror $CONFIGURE_A=
RGS --target-list=3D&quot;$TARGETS&quot; ;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0else<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0../configure --enable-werror $CONFIGURE_A=
RGS ;<br>
-=C2=A0 =C2=A0 =C2=A0 fi<br>
+=C2=A0 =C2=A0 =C2=A0 fi || { cat config.log meson-logs/meson-log.txt &amp;=
&amp; exit 1; }<br>
=C2=A0 =C2=A0 =C2=A0- make -j&quot;$JOBS&quot;<br>
=C2=A0 =C2=A0 =C2=A0- if test -n &quot;$MAKE_CHECK_ARGS&quot;;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0then<br>
@@ -229,7 +229,7 @@ build-tcg-disabled:<br>
=C2=A0 =C2=A0script:<br>
=C2=A0 =C2=A0 =C2=A0- mkdir build<br>
=C2=A0 =C2=A0 =C2=A0- cd build<br>
-=C2=A0 =C2=A0 - ../configure --disable-tcg --audio-drv-list=3D&quot;&quot;=
<br>
+=C2=A0 =C2=A0 - ../configure --disable-tcg --audio-drv-list=3D&quot;&quot;=
 || { cat config.log meson-logs/meson-log.txt &amp;&amp; exit 1; }<br>
=C2=A0 =C2=A0 =C2=A0- make -j&quot;$JOBS&quot;<br>
=C2=A0 =C2=A0 =C2=A0- make check-unit<br>
=C2=A0 =C2=A0 =C2=A0- make check-qapi-schema<br>
@@ -322,7 +322,7 @@ build-tci:<br>
=C2=A0 =C2=A0 =C2=A0- mkdir build<br>
=C2=A0 =C2=A0 =C2=A0- cd build<br>
=C2=A0 =C2=A0 =C2=A0- ../configure --enable-tcg-interpreter<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 --target-list=3D&quot;$(for tg in $TARGETS; do=
 echo -n ${tg}&#39;-softmmu &#39;; done)&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 --target-list=3D&quot;$(for tg in $TARGETS; do=
 echo -n ${tg}&#39;-softmmu &#39;; done)&quot; || { cat config.log meson-lo=
gs/meson-log.txt &amp;&amp; exit 1; }<br>
=C2=A0 =C2=A0 =C2=A0- make -j&quot;$JOBS&quot;<br>
=C2=A0 =C2=A0 =C2=A0- make run-tcg-tests-x86_64-softmmu<br>
=C2=A0 =C2=A0 =C2=A0- make tests/qtest/boot-serial-test tests/qtest/cdrom-t=
est tests/qtest/pxe-test<br>
diff --git a/.travis.yml b/.travis.yml<br>
index d7bfbb8bfe..a3d78171ca 100644<br>
--- a/.travis.yml<br>
+++ b/.travis.yml<br>
@@ -95,7 +95,7 @@ before_install:<br>
=C2=A0# Configure step - may be overridden<br>
=C2=A0before_script:<br>
=C2=A0 =C2=A0- mkdir -p ${BUILD_DIR} &amp;&amp; cd ${BUILD_DIR}<br>
-=C2=A0 - ${SRC_DIR}/configure ${BASE_CONFIG} ${CONFIG} || { cat config.log=
 &amp;&amp; exit 1; }<br>
+=C2=A0 - ${SRC_DIR}/configure ${BASE_CONFIG} ${CONFIG} || { cat config.log=
 meson-logs/meson-log.txt &amp;&amp; exit 1; }<br>
<br>
=C2=A0# Main build &amp; test - rarely overridden - controlled by TEST_CMD<=
br>
=C2=A0script:<br>
@@ -199,7 +199,7 @@ jobs:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0compiler: clang<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0before_script:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- mkdir -p ${BUILD_DIR} &amp;&amp; cd ${B=
UILD_DIR}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 - ${SRC_DIR}/configure ${CONFIG} --extra-cflag=
s=3D&quot;-fsanitize=3Dundefined -Werror&quot; || { cat config.log &amp;&am=
p; exit 1; }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 - ${SRC_DIR}/configure ${CONFIG} --extra-cflag=
s=3D&quot;-fsanitize=3Dundefined -Werror&quot; || { cat config.log meson-lo=
gs/meson-log.txt &amp;&amp; exit 1; }<br>
<br>
<br>
=C2=A0 =C2=A0 =C2=A0- name: &quot;Clang (other-softmmu)&quot;<br>
@@ -298,7 +298,7 @@ jobs:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- TEST_CMD=3D&quot;&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0before_script:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- mkdir -p ${BUILD_DIR} &amp;&amp; cd ${B=
UILD_DIR}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 - ${SRC_DIR}/configure ${CONFIG} --extra-cflag=
s=3D&quot;-g3 -O0 -fsanitize=3Dthread&quot; || { cat config.log &amp;&amp; =
exit 1; }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 - ${SRC_DIR}/configure ${CONFIG} --extra-cflag=
s=3D&quot;-g3 -O0 -fsanitize=3Dthread&quot; || { cat config.log meson-logs/=
meson-log.txt &amp;&amp; exit 1; }<br>
<br>
<br>
=C2=A0 =C2=A0 =C2=A0# Run check-tcg against linux-user<br>
@@ -530,7 +530,7 @@ jobs:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- ls -l ${SRC_DIR}/qemu-${QEMU_VERSION}.t=
ar.bz2<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- tar -xf ${SRC_DIR}/qemu-${QEMU_VERSION}=
.tar.bz2 &amp;&amp; cd qemu-${QEMU_VERSION}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- mkdir -p release-build &amp;&amp; cd re=
lease-build<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 - ../configure ${BASE_CONFIG} ${CONFIG} || { c=
at config.log &amp;&amp; exit 1; }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 - ../configure ${BASE_CONFIG} ${CONFIG} || { c=
at config.log meson-logs/meson-log.txt &amp;&amp; exit 1; }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- make install<br>
=C2=A0 =C2=A0allow_failures:<br>
=C2=A0 =C2=A0 =C2=A0- env: UNRELIABLE=3Dtrue<br>
-- <br>
2.26.2<br>
<br>
<br>
</blockquote></div></div></div>

--000000000000f875ec05b1c72ca4--

