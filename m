Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ECDDC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 08:14:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 379D5207DE
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 08:14:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y0sYFxH7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 379D5207DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47704 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8JEo-0000tp-GR
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 04:14:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56706)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1k8JEC-0000Sr-J1
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 04:13:48 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533]:41206)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1k8JEA-0000Al-B4
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 04:13:48 -0400
Received: by mail-ed1-x533.google.com with SMTP id w17so17340029edt.8
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2020 01:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ZC7EKt4kRF2Ij0AsWVRLeos07Q3csSz8RyDsjAvhzSg=;
 b=Y0sYFxH7LSBDA3gb2PFmj3Y4pOHzt1L9jPnXjw6b8JRy6JFCgiR0N0PU5nBHy+l1P3
 a/ri/9L46VmAXQrut2WddVIUQL+J6ciALboZOSd+iSBJWM8W6mN3DZGwRm/paEsVy0Na
 rKFH/7+fCiM9j8ijzu/8X/TipZXsk+lwkFDCWHWUxaEeiRg1LJe+AsyGBJR65CV/Dd2W
 Xl6apr9I0lXpNrfyYTK4hQRiSFuYrpqaMZWIhMkZFt/cYqV2EEcpkEy+WcXsZ7D8/HH4
 PpO4dntf7B/zIh/MEqSlWC43WZMz79P7b88xW87D8mWG18lMDyMRCZKGRxjAp7zPSdW/
 BTAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZC7EKt4kRF2Ij0AsWVRLeos07Q3csSz8RyDsjAvhzSg=;
 b=T0/vj6pCwLcnASvJqz3THFyLybYpOVXgUKAiGfd8gpNyiDTwYqK+ajP9pRfq+pzrxx
 RuwMiaDenWJgFJ7PiX+RLinmk+bAF4769xJdeVvOB/e+Fxf4WwRMrvXfNBsIjYGH34SI
 iSzFerBkJI07viPwhRHYJzeKdpJImKDIKO2qkN4ZPK4xQCXizxUwOtpj3s9/AI/APIZX
 TzUxVAK4x3yzFvrWYDcg9dqgVpR421e52EMeTc9l+xzUA/icacTh5ilAF7RP15DaE16I
 c3jRrsnlqN2CNkeNQ/v+7DwjoWZF0DGoaobFKOJvPDTsVEaAkVPb8piHrzh9MMmmRCqs
 MgFw==
X-Gm-Message-State: AOAM5313XJRN3MKKOWhIWXqzaLY3M9DBk1NNr5w8Lc1VkrK9xzpC+WwK
 uhwVeZoEV6kPW7KvVpvIkmX68iNPb5y+w0Y9PiI=
X-Google-Smtp-Source: ABdhPJwDEKpINFPJwa7daUaf4AqNKrkqdJuKeytNxhStGwvTlEOGEE6Dlkh49AOtZ1z4zkE4jbN0CKg+0Gw0gJ/LtBc=
X-Received: by 2002:a50:fc82:: with SMTP id f2mr23424946edq.53.1597824824013; 
 Wed, 19 Aug 2020 01:13:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200819080206.27423-1-pbonzini@redhat.com>
In-Reply-To: <20200819080206.27423-1-pbonzini@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 19 Aug 2020 12:13:32 +0400
Message-ID: <CAJ+F1CL3EVufDFXht3Fy4aafBVLMeJZZhVRCErQdiVLOxAZc+A@mail.gmail.com>
Subject: Re: [PATCH] tests: docker: support mxe-based mingw builds
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000000c78e105ad3695ea"
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-ed1-x533.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000000c78e105ad3695ea
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Wed, Aug 19, 2020 at 12:03 PM Paolo Bonzini <pbonzini@redhat.com> wrote:

> This can be run with docker-test-mingw@ubuntu1804-mxe, and is the setup
> that Peter uses to test cross-compilation.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>


I wish I had this a few times, thanks!

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  tests/docker/common.rc                        | 18 ++++++-
>  .../docker/dockerfiles/ubuntu1804-mxe.docker  | 54 +++++++++++++++++++
>  tests/docker/test-mingw                       | 11 +++-
>  3 files changed, 80 insertions(+), 3 deletions(-)
>  create mode 100644 tests/docker/dockerfiles/ubuntu1804-mxe.docker
>
> diff --git a/tests/docker/common.rc b/tests/docker/common.rc
> index ebc5b97ecf..402f6603b6 100755
> --- a/tests/docker/common.rc
> +++ b/tests/docker/common.rc
> @@ -15,10 +15,26 @@
>  # overriden by TARGET_LIST if the user sets it.
>  DEF_TARGET_LIST=3D${DEF_TARGET_LIST:-"x86_64-softmmu,aarch64-softmmu"}
>
> +has()
> +{
> +    echo "$FEATURES" | grep -wq -e "$1"
> +}
> +
> +requires_any()
> +{
> +    for c in $@; do
> +        if has "$c"; then
> +            return
> +        fi
> +    done
> +    echo "None of prerequisites '$*' is present, skip"
> +    exit 0
> +}
> +
>  requires()
>  {
>      for c in $@; do
> -        if ! echo "$FEATURES" | grep -wq -e "$c"; then
> +        if ! has "$c"; then
>              echo "Prerequisite '$c' not present, skip"
>              exit 0
>          fi
> diff --git a/tests/docker/dockerfiles/ubuntu1804-mxe.docker
> b/tests/docker/dockerfiles/ubuntu1804-mxe.docker
> new file mode 100644
> index 0000000000..91895db80d
> --- /dev/null
> +++ b/tests/docker/dockerfiles/ubuntu1804-mxe.docker
> @@ -0,0 +1,54 @@
> +FROM ubuntu:18.04
> +ENV PACKAGES \
> +    ccache \
> +    gcc \
> +    gettext \
> +    git \
> +    gnupg \
> +    gnupg2 \
> +    make \
> +    nsis \
> +    python3-yaml \
> +    python3-sphinx \
> +    python3-setuptools \
> +    texinfo
> +RUN apt-get update && \
> +    DEBIAN_FRONTEND=3Dnoninteractive apt-get -y install $PACKAGES
> +
> +ENV MXE_PACKAGES \
> +    mxe-i686-w64-mingw32.shared-bzip2 \
> +    mxe-i686-w64-mingw32.shared-curl \
> +    mxe-i686-w64-mingw32.shared-glib \
> +    mxe-i686-w64-mingw32.shared-gcc \
> +    mxe-i686-w64-mingw32.shared-glib \
> +    mxe-i686-w64-mingw32.shared-gmp \
> +    mxe-i686-w64-mingw32.shared-gnutls \
> +    mxe-i686-w64-mingw32.shared-gtk3 \
> +    mxe-i686-w64-mingw32.shared-libjpeg-turbo \
> +    mxe-i686-w64-mingw32.shared-libpng \
> +    mxe-i686-w64-mingw32.shared-nettle \
> +    mxe-i686-w64-mingw32.shared-nsis \
> +    mxe-i686-w64-mingw32.shared-pixman \
> +    mxe-i686-w64-mingw32.shared-pkgconf \
> +    mxe-i686-w64-mingw32.shared-sdl2 \
> +    mxe-x86-64-w64-mingw32.shared-bzip2 \
> +    mxe-x86-64-w64-mingw32.shared-curl \
> +    mxe-x86-64-w64-mingw32.shared-gcc \
> +    mxe-x86-64-w64-mingw32.shared-glib \
> +    mxe-x86-64-w64-mingw32.shared-gmp \
> +    mxe-x86-64-w64-mingw32.shared-gnutls \
> +    mxe-x86-64-w64-mingw32.shared-gtk3 \
> +    mxe-x86-64-w64-mingw32.shared-libjpeg-turbo \
> +    mxe-x86-64-w64-mingw32.shared-libpng \
> +    mxe-x86-64-w64-mingw32.shared-nettle \
> +    mxe-x86-64-w64-mingw32.shared-nsis \
> +    mxe-x86-64-w64-mingw32.shared-pixman \
> +    mxe-x86-64-w64-mingw32.shared-pkgconf \
> +    mxe-x86-64-w64-mingw32.shared-sdl2
> +
> +RUN echo "deb http://pkg.mxe.cc/repos/apt bionic main" > \
> +   /etc/apt/sources.list.d/mxeapt.list && \
> +   apt-key adv --keyserver keyserver.ubuntu.com --recv-keys
> C6BF758A33A3A276 && \
> +   apt-get update && \
> +   DEBIAN_FRONTEND=3Dnoninteractive apt-get install -y $MXE_PACKAGES
> +ENV FEATURES mxe
> diff --git a/tests/docker/test-mingw b/tests/docker/test-mingw
> index c30eb654eb..9e2fadb11a 100755
> --- a/tests/docker/test-mingw
> +++ b/tests/docker/test-mingw
> @@ -13,11 +13,18 @@
>
>  . common.rc
>
> -requires mingw dtc
> +requires dtc
> +requires_any mingw mxe
>
>  cd "$BUILD_DIR"
>
> -for prefix in x86_64-w64-mingw32- i686-w64-mingw32-; do
> +if has mingw; then
> +  prefixes=3D'x86_64-w64-mingw32- i686-w64-mingw32-'
> +else
> +  prefixes=3D'x86_64-w64-mingw32.shared- i686-w64-mingw32.shared-'
> +  export PATH=3D/usr/lib/mxe/usr/bin:$PATH
> +fi
> +for prefix in $prefixes; do
>      TARGET_LIST=3D${TARGET_LIST:-$DEF_TARGET_LIST} \
>          build_qemu --cross-prefix=3D$prefix \
>          --enable-trace-backends=3Dsimple \
> --
> 2.26.2
>
>
>

--=20
Marc-Andr=C3=A9 Lureau

--0000000000000c78e105ad3695ea
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi<br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Aug 19, 2020 at 12:03 PM Pa=
olo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com">pbonzini@redhat.com<=
/a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">T=
his can be run with docker-test-mingw@ubuntu1804-mxe, and is the setup<br>
that Peter uses to test cross-compilation.<br>
<br>
Signed-off-by: Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com" tar=
get=3D"_blank">pbonzini@redhat.com</a>&gt;<br></blockquote><div><br></div><=
div><br></div><div>I wish I had this a few times, thanks!<br></div><div><br=
></div><div>Reviewed-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marca=
ndre.lureau@redhat.com">marcandre.lureau@redhat.com</a>&gt;=C2=A0 <br></div=
><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">---<br>
=C2=A0tests/docker/common.rc=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 18 ++++++-<br>
=C2=A0.../docker/dockerfiles/ubuntu1804-mxe.docker=C2=A0 | 54 +++++++++++++=
++++++<br>
=C2=A0tests/docker/test-mingw=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 11 +++-<br>
=C2=A03 files changed, 80 insertions(+), 3 deletions(-)<br>
=C2=A0create mode 100644 tests/docker/dockerfiles/ubuntu1804-mxe.docker<br>
<br>
diff --git a/tests/docker/common.rc b/tests/docker/common.rc<br>
index ebc5b97ecf..402f6603b6 100755<br>
--- a/tests/docker/common.rc<br>
+++ b/tests/docker/common.rc<br>
@@ -15,10 +15,26 @@<br>
=C2=A0# overriden by TARGET_LIST if the user sets it.<br>
=C2=A0DEF_TARGET_LIST=3D${DEF_TARGET_LIST:-&quot;x86_64-softmmu,aarch64-sof=
tmmu&quot;}<br>
<br>
+has()<br>
+{<br>
+=C2=A0 =C2=A0 echo &quot;$FEATURES&quot; | grep -wq -e &quot;$1&quot;<br>
+}<br>
+<br>
+requires_any()<br>
+{<br>
+=C2=A0 =C2=A0 for c in $@; do<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if has &quot;$c&quot;; then<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 fi<br>
+=C2=A0 =C2=A0 done<br>
+=C2=A0 =C2=A0 echo &quot;None of prerequisites &#39;$*&#39; is present, sk=
ip&quot;<br>
+=C2=A0 =C2=A0 exit 0<br>
+}<br>
+<br>
=C2=A0requires()<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0for c in $@; do<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if ! echo &quot;$FEATURES&quot; | grep -wq -e =
&quot;$c&quot;; then<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if ! has &quot;$c&quot;; then<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0echo &quot;Prerequisite &#3=
9;$c&#39; not present, skip&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0exit 0<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fi<br>
diff --git a/tests/docker/dockerfiles/ubuntu1804-mxe.docker b/tests/docker/=
dockerfiles/ubuntu1804-mxe.docker<br>
new file mode 100644<br>
index 0000000000..91895db80d<br>
--- /dev/null<br>
+++ b/tests/docker/dockerfiles/ubuntu1804-mxe.docker<br>
@@ -0,0 +1,54 @@<br>
+FROM ubuntu:18.04<br>
+ENV PACKAGES \<br>
+=C2=A0 =C2=A0 ccache \<br>
+=C2=A0 =C2=A0 gcc \<br>
+=C2=A0 =C2=A0 gettext \<br>
+=C2=A0 =C2=A0 git \<br>
+=C2=A0 =C2=A0 gnupg \<br>
+=C2=A0 =C2=A0 gnupg2 \<br>
+=C2=A0 =C2=A0 make \<br>
+=C2=A0 =C2=A0 nsis \<br>
+=C2=A0 =C2=A0 python3-yaml \<br>
+=C2=A0 =C2=A0 python3-sphinx \<br>
+=C2=A0 =C2=A0 python3-setuptools \<br>
+=C2=A0 =C2=A0 texinfo<br>
+RUN apt-get update &amp;&amp; \<br>
+=C2=A0 =C2=A0 DEBIAN_FRONTEND=3Dnoninteractive apt-get -y install $PACKAGE=
S<br>
+<br>
+ENV MXE_PACKAGES \<br>
+=C2=A0 =C2=A0 mxe-i686-w64-mingw32.shared-bzip2 \<br>
+=C2=A0 =C2=A0 mxe-i686-w64-mingw32.shared-curl \<br>
+=C2=A0 =C2=A0 mxe-i686-w64-mingw32.shared-glib \<br>
+=C2=A0 =C2=A0 mxe-i686-w64-mingw32.shared-gcc \<br>
+=C2=A0 =C2=A0 mxe-i686-w64-mingw32.shared-glib \<br>
+=C2=A0 =C2=A0 mxe-i686-w64-mingw32.shared-gmp \<br>
+=C2=A0 =C2=A0 mxe-i686-w64-mingw32.shared-gnutls \<br>
+=C2=A0 =C2=A0 mxe-i686-w64-mingw32.shared-gtk3 \<br>
+=C2=A0 =C2=A0 mxe-i686-w64-mingw32.shared-libjpeg-turbo \<br>
+=C2=A0 =C2=A0 mxe-i686-w64-mingw32.shared-libpng \<br>
+=C2=A0 =C2=A0 mxe-i686-w64-mingw32.shared-nettle \<br>
+=C2=A0 =C2=A0 mxe-i686-w64-mingw32.shared-nsis \<br>
+=C2=A0 =C2=A0 mxe-i686-w64-mingw32.shared-pixman \<br>
+=C2=A0 =C2=A0 mxe-i686-w64-mingw32.shared-pkgconf \<br>
+=C2=A0 =C2=A0 mxe-i686-w64-mingw32.shared-sdl2 \<br>
+=C2=A0 =C2=A0 mxe-x86-64-w64-mingw32.shared-bzip2 \<br>
+=C2=A0 =C2=A0 mxe-x86-64-w64-mingw32.shared-curl \<br>
+=C2=A0 =C2=A0 mxe-x86-64-w64-mingw32.shared-gcc \<br>
+=C2=A0 =C2=A0 mxe-x86-64-w64-mingw32.shared-glib \<br>
+=C2=A0 =C2=A0 mxe-x86-64-w64-mingw32.shared-gmp \<br>
+=C2=A0 =C2=A0 mxe-x86-64-w64-mingw32.shared-gnutls \<br>
+=C2=A0 =C2=A0 mxe-x86-64-w64-mingw32.shared-gtk3 \<br>
+=C2=A0 =C2=A0 mxe-x86-64-w64-mingw32.shared-libjpeg-turbo \<br>
+=C2=A0 =C2=A0 mxe-x86-64-w64-mingw32.shared-libpng \<br>
+=C2=A0 =C2=A0 mxe-x86-64-w64-mingw32.shared-nettle \<br>
+=C2=A0 =C2=A0 mxe-x86-64-w64-mingw32.shared-nsis \<br>
+=C2=A0 =C2=A0 mxe-x86-64-w64-mingw32.shared-pixman \<br>
+=C2=A0 =C2=A0 mxe-x86-64-w64-mingw32.shared-pkgconf \<br>
+=C2=A0 =C2=A0 mxe-x86-64-w64-mingw32.shared-sdl2<br>
+<br>
+RUN echo &quot;deb <a href=3D"http://pkg.mxe.cc/repos/apt" rel=3D"noreferr=
er" target=3D"_blank">http://pkg.mxe.cc/repos/apt</a> bionic main&quot; &gt=
; \<br>
+=C2=A0 =C2=A0/etc/apt/sources.list.d/mxeapt.list &amp;&amp; \<br>
+=C2=A0 =C2=A0apt-key adv --keyserver <a href=3D"http://keyserver.ubuntu.co=
m" rel=3D"noreferrer" target=3D"_blank">keyserver.ubuntu.com</a> --recv-key=
s C6BF758A33A3A276 &amp;&amp; \<br>
+=C2=A0 =C2=A0apt-get update &amp;&amp; \<br>
+=C2=A0 =C2=A0DEBIAN_FRONTEND=3Dnoninteractive apt-get install -y $MXE_PACK=
AGES<br>
+ENV FEATURES mxe<br>
diff --git a/tests/docker/test-mingw b/tests/docker/test-mingw<br>
index c30eb654eb..9e2fadb11a 100755<br>
--- a/tests/docker/test-mingw<br>
+++ b/tests/docker/test-mingw<br>
@@ -13,11 +13,18 @@<br>
<br>
=C2=A0. common.rc<br>
<br>
-requires mingw dtc<br>
+requires dtc<br>
+requires_any mingw mxe<br>
<br>
=C2=A0cd &quot;$BUILD_DIR&quot;<br>
<br>
-for prefix in x86_64-w64-mingw32- i686-w64-mingw32-; do<br>
+if has mingw; then<br>
+=C2=A0 prefixes=3D&#39;x86_64-w64-mingw32- i686-w64-mingw32-&#39;<br>
+else<br>
+=C2=A0 prefixes=3D&#39;x86_64-w64-mingw32.shared- i686-w64-mingw32.shared-=
&#39;<br>
+=C2=A0 export PATH=3D/usr/lib/mxe/usr/bin:$PATH<br>
+fi<br>
+for prefix in $prefixes; do<br>
=C2=A0 =C2=A0 =C2=A0TARGET_LIST=3D${TARGET_LIST:-$DEF_TARGET_LIST} \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0build_qemu --cross-prefix=3D$prefix \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0--enable-trace-backends=3Dsimple \<br>
-- <br>
2.26.2<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature">Marc-Andr=C3=A9 Lureau<br></div></div>

--0000000000000c78e105ad3695ea--

