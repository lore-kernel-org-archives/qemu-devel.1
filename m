Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 053F0C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 18:57:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BB872083B
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 18:57:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OO3EibiN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BB872083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53882 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDXwX-0004Km-Oj
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 14:57:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44294)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kDXvw-0003kd-Cc
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 14:56:36 -0400
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:42095)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kDXvt-0006g3-EJ
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 14:56:35 -0400
Received: by mail-lf1-x144.google.com with SMTP id b12so374535lfp.9
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2020 11:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=uHO/JasO8hPWdt2W5IAH2Lf5a50+MiEOqYRKEWrwXBo=;
 b=OO3EibiN62nAtpXpVB8YR6hA9vP7cOcijMD9svGcOlL4UH+NMKyjmsVb3N7bIpGzJ+
 UgkrExQAEwZEWV/QKERM9/taLVnRM4S44diVlPJQHOwk8IJ5AlMioA+t4ewDoG6GFC20
 sqk1MQP6KFViJQrNou7GGlWWzAHWzaazhvVu+pk/Lcf6NBDcx7obieCRqJ0+SNCvfXk+
 87GWajoNcrnFOPrJ5Gu/7WqNRsoJmTy6HUyPiaMNTyTqBnvLZwhI8q8I39IARjwz/Xni
 4arjKz9sRPLtkyOJ4iVh4o+zpuTCyCYMSXH6GSViHHgt3wTIpLQ41E84BZtepvEPwJqJ
 YKjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=uHO/JasO8hPWdt2W5IAH2Lf5a50+MiEOqYRKEWrwXBo=;
 b=X1bpVEWMZECFvnVzfGm6o7CAMaD8BFYVqeaylLp0CCJLZDgFTaPabmsRPi9iSJWbPK
 ejj0+lpoI3Ddm3IrUWITq8ve5qLWIe5dfqwPcQi/T3NzS4eTw0HOShKI2VocOISHxjIu
 aeXzKWGu5ksdcl61Kl87hUVjbxl39aP9OWwgdVeQE8qMbz2feScdlBPgsGQ38A5FFm+V
 939Qp6xrJs0Z8Dmid8fKcwy2r3JcG7/kKxWnc1I2b/Orwdr8wWHrL8ySwfnCMtpjrV2q
 1L0RzIaNUo42bduY98BNs9kWZUytmPSFFZGnBBSJfS+1ScYc1wXHnL4Z+ATvModDMQto
 D36w==
X-Gm-Message-State: AOAM5331jSR+lLSUfE2WSAq9czYpdzcIsoI5K6MQoycbAdyV6ssZvosn
 S+MajSst0Yw/kS/3P0ZLMudr/A+YSxkRN4iXeS8=
X-Google-Smtp-Source: ABdhPJxy73jTgrQOOszs0cbXamRraTE+b7XVYsYLOZiYhwxK5PPdaY3ZLuUYIvF0LcqIHtP0O2iZZhIFmkSWhx73idM=
X-Received: by 2002:ac2:4298:: with SMTP id m24mr4018547lfh.126.1599072991515; 
 Wed, 02 Sep 2020 11:56:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200902170054.810-1-luoyonggang@gmail.com>
 <20200902170054.810-4-luoyonggang@gmail.com>
 <5cde63a0-46fe-2944-f96e-1f3268e49af8@amsat.org>
 <CAE2XoE8bsq7jzbw6FMW3TybhQGiNEJ-F_NKPm3LHzkHm69hSdw@mail.gmail.com>
 <19b8d23c-c2e7-2d8e-50de-a4e977bae786@ilande.co.uk>
In-Reply-To: <19b8d23c-c2e7-2d8e-50de-a4e977bae786@ilande.co.uk>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Thu, 3 Sep 2020 02:56:19 +0800
Message-ID: <CAE2XoE_yO5kkQBFzJk+FzspJG-3gHD0Xvf7BSkOk45qhp1h4PA@mail.gmail.com>
Subject: Re: [PATCH 3/6] ci: Install msys2 in a proper way refer to
 https://github.com/cirruslabs/cirrus-ci-docs/issues/699 Enable msys2 ci in
 cirrus
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Content-Type: multipart/alternative; boundary="000000000000a116bd05ae593168"
Received-SPF: pass client-ip=2a00:1450:4864:20::144;
 envelope-from=luoyonggang@gmail.com; helo=mail-lf1-x144.google.com
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
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 qemu-level <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000a116bd05ae593168
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 3, 2020 at 2:55 AM Mark Cave-Ayland <
mark.cave-ayland@ilande.co.uk> wrote:

> On 02/09/2020 18:50, =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) wrote:
>
> > On Thu, Sep 3, 2020 at 1:30 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat=
.org
> > <mailto:f4bug@amsat.org>> wrote:
> >
> >     On 9/2/20 7:00 PM, Yonggang Luo wrote:
> >     > ---
> >     >  .cirrus.yml                         | 23 ++++++++++++++++
> >     >  scripts/ci/windows/msys2_build.sh   | 35 +++++++++++++++++++++++=
+
> >     >  scripts/ci/windows/msys2_install.sh | 41
> +++++++++++++++++++++++++++++
> >     >  3 files changed, 99 insertions(+)
> >     >  create mode 100644 scripts/ci/windows/msys2_build.sh
> >     >  create mode 100644 scripts/ci/windows/msys2_install.sh
> >     >
> >     > diff --git a/.cirrus.yml b/.cirrus.yml
> >     > index f287d23c5b..d377c28412 100644
> >     > --- a/.cirrus.yml
> >     > +++ b/.cirrus.yml
> >     > @@ -40,3 +40,26 @@ macos_xcode_task:
> >     >      - ../configure --cc=3Dclang || { cat config.log; exit 1; }
> >     >      - gmake -j$(sysctl -n hw.ncpu)
> >     >      - gmake check
> >     > +
> >     > +windows_msys2_task:
> >     > +  windows_container:
> >     > +    image: cirrusci/windowsservercore:cmake
> >     > +    os_version: 2019
> >     > +    cpu: 8
> >     > +    memory: 8G
> >     > +  env:
> >     > +    MSYS: winsymlinks:nativestrict
> >     > +    MSYSTEM: MINGW64
> >     > +    CHERE_INVOKING: 1
> >     > +  printenv_script: C:\tools\msys64\usr\bin\bash.exe -lc 'printen=
v'
> >     > +  install_script:
> >     > +    - C:\tools\msys64\usr\bin\bash.exe -lc "cd /c/tools && curl =
-O
> >
> http://repo.msys2.org/msys/x86_64/msys2-keyring-r21.b39fb11-1-any.pkg.tar=
.xz
> "
> >     > +    - C:\tools\msys64\usr\bin\bash.exe -lc "cd /c/tools && curl =
-O
> >
> http://repo.msys2.org/msys/x86_64/msys2-keyring-r21.b39fb11-1-any.pkg.tar=
.xz.sig
> "
> >     > +    - C:\tools\msys64\usr\bin\bash.exe -lc "cd /c/tools && pacma=
n
> -U
> >     --noconfirm msys2-keyring-r21.b39fb11-1-any.pkg.tar.xz"
> >     > +    - C:\tools\msys64\usr\bin\bash.exe -lc "pacman -Sy
> --noconfirm"
> >     > +    - C:\tools\msys64\usr\bin\bash.exe -lc "pacman --needed
> --noconfirm -S
> >     bash pacman pacman-mirrors msys2-runtime"
> >     > +    - taskkill /F /IM gpg-agent.exe
> >     > +    - C:\tools\msys64\usr\bin\bash.exe -lc "pacman --noconfirm
> -Su"
> >     > +    - C:\tools\msys64\usr\bin\bash.exe -lc "sh
> >     scripts/ci/windows/msys2_install.sh"
> >     > +  script:
> >     > +    C:\tools\msys64\usr\bin\bash.exe -lc "sh
> scripts/ci/windows/msys2_build.sh"
> >     > diff --git a/scripts/ci/windows/msys2_build.sh
> b/scripts/ci/windows/msys2_build.sh
> >     > new file mode 100644
> >     > index 0000000000..0363ef402a
> >     > --- /dev/null
> >     > +++ b/scripts/ci/windows/msys2_build.sh
> >     > @@ -0,0 +1,35 @@
> >     > +export QEMU_DIR=3D$PWD
> >     > +mkdir ../qemu-build
> >     > +cd ../qemu-build
> >     > +$QEMU_DIR/configure \
> >     > +  --python=3Dpython3 \
> >     > +  --cross-prefix=3Dx86_64-w64-mingw32- \
> >
> >     Isn't the prefix 'x86_64-w64-mingw32-gcc-'?
> >
> >     > +  --enable-gtk --enable-sdl \
> >     > +  --enable-capstone=3Dgit \
> >     > +  --enable-stack-protector \
> >     > +  --ninja=3Dninja \
> >     > +  --enable-gnutls \
> >     > +  --enable-nettle \
> >     > +  --enable-vnc \
> >     > +  --enable-vnc-sasl \
> >     > +  --enable-vnc-jpeg \
> >     > +  --enable-vnc-png \
> >     > +  --enable-membarrier \
> >     > +  --enable-slirp=3Dgit \
> >     > +  --disable-kvm \
> >     > +  --enable-hax \
> >     > +  --enable-whpx \
> >     > +  --disable-spice \
> >     > +  --enable-lzo \
> >     > +  --enable-snappy \
> >     > +  --enable-bzip2 \
> >     > +  --enable-vdi \
> >     > +  --enable-qcow1 \
> >     > +  --enable-tools \
> >     > +  --enable-libusb \
> >     > +  --enable-usb-redir \
> >     > +  --disable-libnfs \
> >     > +  --enable-libssh \
> >     > +  --disable-pie
> >     > +make -j$NUMBER_OF_PROCESSORS
> >     > +# make -j$NUMBER_OF_PROCESSORS check
> >     > diff --git a/scripts/ci/windows/msys2_install.sh
> >     b/scripts/ci/windows/msys2_install.sh
> >     > new file mode 100644
> >     > index 0000000000..3a5392cd99
> >     > --- /dev/null
> >     > +++ b/scripts/ci/windows/msys2_install.sh
> >     > @@ -0,0 +1,41 @@
> >     > +pacman --noconfirm -S --needed \
> >     > +base-devel \
> >     > +git \
> >     > +mingw-w64-x86_64-python \
> >     > +mingw-w64-x86_64-python-setuptools \
> >     > +mingw-w64-x86_64-toolchain \
> >     > +mingw-w64-x86_64-SDL2 \
> >     > +mingw-w64-x86_64-SDL2_image \
> >     > +mingw-w64-x86_64-gtk3 \
> >     > +mingw-w64-x86_64-ninja \
> >     > +mingw-w64-x86_64-make \
> >     > +mingw-w64-x86_64-lzo2 \
> >     > +mingw-w64-x86_64-libjpeg-turbo \
> >     > +mingw-w64-x86_64-pixman \
> >     > +mingw-w64-x86_64-libgcrypt \
> >     > +mingw-w64-x86_64-capstone \
> >     > +mingw-w64-x86_64-libpng \
> >     > +mingw-w64-x86_64-libssh \
> >     > +mingw-w64-x86_64-libxml2 \
> >     > +mingw-w64-x86_64-snappy \
> >     > +mingw-w64-x86_64-libusb \
> >     > +mingw-w64-x86_64-usbredir \
> >     > +mingw-w64-x86_64-libtasn1 \
> >     > +mingw-w64-x86_64-libnfs \
> >     > +mingw-w64-x86_64-nettle \
> >     > +mingw-w64-x86_64-cyrus-sasl \
> >     > +mingw-w64-x86_64-curl \
> >     > +mingw-w64-x86_64-gnutls \
> >     > +mingw-w64-x86_64-zstd \
> >     > +mingw-w64-x86_64-glib2
> >     > +
> >     > +cd /mingw64/bin
> >     > +cp x86_64-w64-mingw32-gcc-ar.exe x86_64-w64-mingw32-ar.exe
> >     > +cp x86_64-w64-mingw32-gcc-ranlib.exe x86_64-w64-mingw32-ranlib.e=
xe
> >     > +cp x86_64-w64-mingw32-gcc-nm.exe x86_64-w64-mingw32-nm.exe
> >     > +cp windres.exe x86_64-w64-mingw32-windres.exe
> >     > +cp strip.exe x86_64-w64-mingw32-strip.exe
> >     > +cp objcopy.exe x86_64-w64-mingw32-objcopy.exe
> >     > +cp ld x86_64-w64-mingw32-ld.exe
> >     > +cp as x86_64-w64-mingw32-as.exe
> >     > +cp sdl2-config x86_64-w64-mingw32-sdl2-config
> >
> >     Why is that needed?
> >
> >     Thanks,
> >
> >     Phil.
> >
> > Hi, I am looking for suggestion for building  with msys2, this is comes
> from wiki, if
> > you have better idea, then tell me.
> >
> > https://wiki.qemu.org/Hosts/W32#Native_builds_with_MSYS2
>
> FWIW I did a clean install of MSYS2 after the meson changes were merged
> and it seems
> to make things a bit simpler for Windows. Once Paolo's latest PR has been
> applied you
> should be able to do the following (from my notes for PPC builds):
>
> # As per https://www.msys2.org/
> pacman -Syu
> pacman -Su
>
> # QEMU build environment
> pacman -S \
>   base-devel \
>   mingw-w64-x86_64-toolchain \
>   git \
>   mingw64/mingw-w64-x86_64-python3 \
>   mingw64/mingw-w64-x86_64-python-setuptools \
>   mingw64/mingw-w64-x86_64-ninja
>
> # Basic GTK/SDL build
> pacman -S \
>   mingw-w64-x86_64-glib2 \
>   mingw64/mingw-w64-x86_64-gtk3 \
>   mingw64/mingw-w64-x86_64-SDL2
>
> # Build
> ./configure --target-list=3D"ppc-softmmu" --ninja=3Dninja
> make -j6
>
> That should be enough to get a basic working Windows build with GTK/SDL2
> UI, although
> I see you've added a lot more options.

I am trying to enable all possible feature on the CI for monitoring the
regression, at least from the compiling points of view

>


>
> ATB,
>
> Mark.
>


--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--000000000000a116bd05ae593168
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, Sep 3, 2020 at 2:55 AM Mark C=
ave-Ayland &lt;<a href=3D"mailto:mark.cave-ayland@ilande.co.uk">mark.cave-a=
yland@ilande.co.uk</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex">On 02/09/2020 18:50, =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang=
 Luo) wrote:<br>
<br>
&gt; On Thu, Sep 3, 2020 at 1:30 AM Philippe Mathieu-Daud=C3=A9 &lt;<a href=
=3D"mailto:f4bug@amsat.org" target=3D"_blank">f4bug@amsat.org</a><br>
&gt; &lt;mailto:<a href=3D"mailto:f4bug@amsat.org" target=3D"_blank">f4bug@=
amsat.org</a>&gt;&gt; wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0On 9/2/20 7:00 PM, Yonggang Luo wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; ---<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 .cirrus.yml=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 23 ++++++++=
++++++++<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 scripts/ci/windows/msys2_build.sh=C2=A0 =
=C2=A0| 35 ++++++++++++++++++++++++<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 scripts/ci/windows/msys2_install.sh | 41=
 +++++++++++++++++++++++++++++<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 3 files changed, 99 insertions(+)<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 create mode 100644 scripts/ci/windows/ms=
ys2_build.sh<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 create mode 100644 scripts/ci/windows/ms=
ys2_install.sh<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; diff --git a/.cirrus.yml b/.cirrus.yml<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; index f287d23c5b..d377c28412 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; --- a/.cirrus.yml<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +++ b/.cirrus.yml<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; @@ -40,3 +40,26 @@ macos_xcode_task:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 - ../configure --cc=3Dclan=
g || { cat config.log; exit 1; }<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 - gmake -j$(sysctl -n hw.n=
cpu)<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0 - gmake check<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +windows_msys2_task:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 windows_container:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 image: cirrusci/windowsserverco=
re:cmake<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 os_version: 2019<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 cpu: 8<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 memory: 8G<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 env:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 MSYS: winsymlinks:nativestrict<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 MSYSTEM: MINGW64<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 CHERE_INVOKING: 1<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 printenv_script: C:\tools\msys64\usr\b=
in\bash.exe -lc &#39;printenv&#39;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 install_script:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 - C:\tools\msys64\usr\bin\bash.=
exe -lc &quot;cd /c/tools &amp;&amp; curl -O<br>
&gt;=C2=A0 =C2=A0 =C2=A0<a href=3D"http://repo.msys2.org/msys/x86_64/msys2-=
keyring-r21.b39fb11-1-any.pkg.tar.xz" rel=3D"noreferrer" target=3D"_blank">=
http://repo.msys2.org/msys/x86_64/msys2-keyring-r21.b39fb11-1-any.pkg.tar.x=
z</a>&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 - C:\tools\msys64\usr\bin\bash.=
exe -lc &quot;cd /c/tools &amp;&amp; curl -O<br>
&gt;=C2=A0 =C2=A0 =C2=A0<a href=3D"http://repo.msys2.org/msys/x86_64/msys2-=
keyring-r21.b39fb11-1-any.pkg.tar.xz.sig" rel=3D"noreferrer" target=3D"_bla=
nk">http://repo.msys2.org/msys/x86_64/msys2-keyring-r21.b39fb11-1-any.pkg.t=
ar.xz.sig</a>&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 - C:\tools\msys64\usr\bin\bash.=
exe -lc &quot;cd /c/tools &amp;&amp; pacman -U<br>
&gt;=C2=A0 =C2=A0 =C2=A0--noconfirm msys2-keyring-r21.b39fb11-1-any.pkg.tar=
.xz&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 - C:\tools\msys64\usr\bin\bash.=
exe -lc &quot;pacman -Sy --noconfirm&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 - C:\tools\msys64\usr\bin\bash.=
exe -lc &quot;pacman --needed --noconfirm -S<br>
&gt;=C2=A0 =C2=A0 =C2=A0bash pacman pacman-mirrors msys2-runtime&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 - taskkill /F /IM gpg-agent.exe=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 - C:\tools\msys64\usr\bin\bash.=
exe -lc &quot;pacman --noconfirm -Su&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 - C:\tools\msys64\usr\bin\bash.=
exe -lc &quot;sh<br>
&gt;=C2=A0 =C2=A0 =C2=A0scripts/ci/windows/msys2_install.sh&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 script:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 C:\tools\msys64\usr\bin\bash.ex=
e -lc &quot;sh scripts/ci/windows/msys2_build.sh&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; diff --git a/scripts/ci/windows/msys2_build.sh=
 b/scripts/ci/windows/msys2_build.sh<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; new file mode 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; index 0000000000..0363ef402a<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; --- /dev/null<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +++ b/scripts/ci/windows/msys2_build.sh<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; @@ -0,0 +1,35 @@<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +export QEMU_DIR=3D$PWD<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +mkdir ../qemu-build<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +cd ../qemu-build<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +$QEMU_DIR/configure \<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 --python=3Dpython3 \<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 --cross-prefix=3Dx86_64-w64-mingw32- \=
<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Isn&#39;t the prefix &#39;x86_64-w64-mingw32-gcc-&#=
39;?<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 --enable-gtk --enable-sdl \<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 --enable-capstone=3Dgit \<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 --enable-stack-protector \<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 --ninja=3Dninja \<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 --enable-gnutls \<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 --enable-nettle \<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 --enable-vnc \<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 --enable-vnc-sasl \<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 --enable-vnc-jpeg \<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 --enable-vnc-png \<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 --enable-membarrier \<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 --enable-slirp=3Dgit \<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 --disable-kvm \<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 --enable-hax \<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 --enable-whpx \<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 --disable-spice \<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 --enable-lzo \<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 --enable-snappy \<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 --enable-bzip2 \<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 --enable-vdi \<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 --enable-qcow1 \<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 --enable-tools \<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 --enable-libusb \<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 --enable-usb-redir \<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 --disable-libnfs \<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 --enable-libssh \<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 --disable-pie<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +make -j$NUMBER_OF_PROCESSORS<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +# make -j$NUMBER_OF_PROCESSORS check<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; diff --git a/scripts/ci/windows/msys2_install.=
sh<br>
&gt;=C2=A0 =C2=A0 =C2=A0b/scripts/ci/windows/msys2_install.sh<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; new file mode 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; index 0000000000..3a5392cd99<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; --- /dev/null<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +++ b/scripts/ci/windows/msys2_install.sh<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; @@ -0,0 +1,41 @@<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +pacman --noconfirm -S --needed \<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +base-devel \<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +git \<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +mingw-w64-x86_64-python \<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +mingw-w64-x86_64-python-setuptools \<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +mingw-w64-x86_64-toolchain \<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +mingw-w64-x86_64-SDL2 \<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +mingw-w64-x86_64-SDL2_image \<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +mingw-w64-x86_64-gtk3 \<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +mingw-w64-x86_64-ninja \<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +mingw-w64-x86_64-make \<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +mingw-w64-x86_64-lzo2 \<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +mingw-w64-x86_64-libjpeg-turbo \<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +mingw-w64-x86_64-pixman \<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +mingw-w64-x86_64-libgcrypt \<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +mingw-w64-x86_64-capstone \<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +mingw-w64-x86_64-libpng \<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +mingw-w64-x86_64-libssh \<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +mingw-w64-x86_64-libxml2 \<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +mingw-w64-x86_64-snappy \<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +mingw-w64-x86_64-libusb \<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +mingw-w64-x86_64-usbredir \<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +mingw-w64-x86_64-libtasn1 \<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +mingw-w64-x86_64-libnfs \<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +mingw-w64-x86_64-nettle \<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +mingw-w64-x86_64-cyrus-sasl \<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +mingw-w64-x86_64-curl \<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +mingw-w64-x86_64-gnutls \<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +mingw-w64-x86_64-zstd \<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +mingw-w64-x86_64-glib2<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +cd /mingw64/bin<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +cp x86_64-w64-mingw32-gcc-ar.exe x86_64-w64-m=
ingw32-ar.exe<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +cp x86_64-w64-mingw32-gcc-ranlib.exe x86_64-w=
64-mingw32-ranlib.exe<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +cp x86_64-w64-mingw32-gcc-nm.exe x86_64-w64-m=
ingw32-nm.exe<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +cp windres.exe x86_64-w64-mingw32-windres.exe=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +cp strip.exe x86_64-w64-mingw32-strip.exe<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +cp objcopy.exe x86_64-w64-mingw32-objcopy.exe=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +cp ld x86_64-w64-mingw32-ld.exe<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +cp as x86_64-w64-mingw32-as.exe<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +cp sdl2-config x86_64-w64-mingw32-sdl2-config=
<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Why is that needed?<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Thanks,<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Phil.<br>
&gt; <br>
&gt; Hi, I am looking for suggestion for building=C2=A0 with msys2, this is=
 comes from wiki, if<br>
&gt; you have better idea, then tell me.<br>
&gt; <br>
&gt; <a href=3D"https://wiki.qemu.org/Hosts/W32#Native_builds_with_MSYS2" r=
el=3D"noreferrer" target=3D"_blank">https://wiki.qemu.org/Hosts/W32#Native_=
builds_with_MSYS2</a>=C2=A0<br>
<br>
FWIW I did a clean install of MSYS2 after the meson changes were merged and=
 it seems<br>
to make things a bit simpler for Windows. Once Paolo&#39;s latest PR has be=
en applied you<br>
should be able to do the following (from my notes for PPC builds):<br>
<br>
# As per <a href=3D"https://www.msys2.org/" rel=3D"noreferrer" target=3D"_b=
lank">https://www.msys2.org/</a><br>
pacman -Syu<br>
pacman -Su<br>
<br>
# QEMU build environment<br>
pacman -S \<br>
=C2=A0 base-devel \<br>
=C2=A0 mingw-w64-x86_64-toolchain \<br>
=C2=A0 git \<br>
=C2=A0 mingw64/mingw-w64-x86_64-python3 \<br>
=C2=A0 mingw64/mingw-w64-x86_64-python-setuptools \<br>
=C2=A0 mingw64/mingw-w64-x86_64-ninja<br>
<br>
# Basic GTK/SDL build<br>
pacman -S \<br>
=C2=A0 mingw-w64-x86_64-glib2 \<br>
=C2=A0 mingw64/mingw-w64-x86_64-gtk3 \<br>
=C2=A0 mingw64/mingw-w64-x86_64-SDL2<br>
<br>
# Build<br>
./configure --target-list=3D&quot;ppc-softmmu&quot; --ninja=3Dninja<br>
make -j6<br>
<br>
That should be enough to get a basic working Windows build with GTK/SDL2 UI=
, although<br>
I see you&#39;ve added a lot more options.</blockquote><div>I am trying to =
enable all possible feature on the CI for monitoring the regression, at lea=
st from the compiling points of view=C2=A0</div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex">=C2=A0</blockquote><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex">
<br>
<br>
ATB,<br>
<br>
Mark.<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =E6=AD=A4=E8=
=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=
=A0 sincerely,<br>Yonggang Luo<br></div></div>

--000000000000a116bd05ae593168--

