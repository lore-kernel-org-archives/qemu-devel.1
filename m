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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD9CDC433E7
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 17:51:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5187F20758
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 17:51:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GQXUi9eg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5187F20758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48690 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDWux-0006os-FN
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 13:51:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57988)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kDWuF-0006Ie-3X
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 13:50:47 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:39636)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kDWuC-0006hr-KS
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 13:50:46 -0400
Received: by mail-lj1-x242.google.com with SMTP id e11so183958ljn.6
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2020 10:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=Hb1i5tnAlL8ynjVCnDWcnJL9Jy138l1pVaMRnZtYPJc=;
 b=GQXUi9egl2V4aSjOAflk0/DE9S9drUZHOJlLCZSLog6Yl2Rn7bIq3ajWuvWcGb4BRs
 /kwB0VMV9a9siG7GhPIrTu1XRFVLLu65a+JCATXTQ7uTN0Iw9rCLF6iCtQ/Urd/NNFPs
 ls7RGWiCA/umBXf+7RmNlzFNKPsTti0l/29TPyo9qgRZYWNClJ79GiEJMhQ+kQMW0W45
 CNZ0mMoAn5Cl6HxqGOI3ixbNEEkRkantM+yGDJ+5ey1J+ZX9bzQR772EaJ0Jh9WK+iHv
 Y56s7CUoAu5ntoXkMo5ERguixWBNj5PXcwb4Kco11EKJxApuHr0xy06sqLEjr62ZwiiW
 rYvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=Hb1i5tnAlL8ynjVCnDWcnJL9Jy138l1pVaMRnZtYPJc=;
 b=EfEKsRkVpccWRLzNEksLqpftWDE2XEqBntaVmmnWCCZY9v8IjJ5U71oJhiMDrm9yZG
 tqDAIFxzjeJH+zmrSmrx9B1bjwkky3YXAOiWXvBO/+NyYNiv/UvEtBnfQfU17sf6Ms7r
 PT0akAFd4BX5H0WMeS12iHiPz1/Ifx/d5rM1bxBS+N1qCqtkFrNsLWF1sFinEyOTCYQH
 YoPYy7rAJa+F7EnKK/FqPzxLQ7DkRA4pFnXMtpPBxzszjHvHffqeXkBC/vmBWvcBy9qv
 aNIPlqadypzNR1YeYoT9ndwgARlILri0Cwx8Z0hasYlbp3cIDmtL4w9/h7SO5RGZLSOp
 kUew==
X-Gm-Message-State: AOAM532dA8b6zW58xkjpuqeOJIGhrVNf2IuJusrsigWa5/E9Fa5UFjeR
 qJJmcZLXZ6Y8Y4m7X+Qc55M392AXkGF32GzC+XY=
X-Google-Smtp-Source: ABdhPJyPYmi6LxFywJz5GAOCOJLbcQ3LCOJBA+974ToecFJ0lDLCZTK2OkZYKnlF14nP3JJU8PT/Msw2T9YnGQHIuPg=
X-Received: by 2002:a05:651c:151:: with SMTP id
 c17mr4116944ljd.467.1599069042749; 
 Wed, 02 Sep 2020 10:50:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200902170054.810-1-luoyonggang@gmail.com>
 <20200902170054.810-4-luoyonggang@gmail.com>
 <5cde63a0-46fe-2944-f96e-1f3268e49af8@amsat.org>
In-Reply-To: <5cde63a0-46fe-2944-f96e-1f3268e49af8@amsat.org>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Thu, 3 Sep 2020 01:50:30 +0800
Message-ID: <CAE2XoE8bsq7jzbw6FMW3TybhQGiNEJ-F_NKPm3LHzkHm69hSdw@mail.gmail.com>
Subject: Re: [PATCH 3/6] ci: Install msys2 in a proper way refer to
 https://github.com/cirruslabs/cirrus-ci-docs/issues/699 Enable msys2 ci in
 cirrus
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: multipart/alternative; boundary="00000000000043b80b05ae584697"
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-level <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000043b80b05ae584697
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 3, 2020 at 1:30 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org=
>
wrote:

> On 9/2/20 7:00 PM, Yonggang Luo wrote:
> > ---
> >  .cirrus.yml                         | 23 ++++++++++++++++
> >  scripts/ci/windows/msys2_build.sh   | 35 ++++++++++++++++++++++++
> >  scripts/ci/windows/msys2_install.sh | 41 +++++++++++++++++++++++++++++
> >  3 files changed, 99 insertions(+)
> >  create mode 100644 scripts/ci/windows/msys2_build.sh
> >  create mode 100644 scripts/ci/windows/msys2_install.sh
> >
> > diff --git a/.cirrus.yml b/.cirrus.yml
> > index f287d23c5b..d377c28412 100644
> > --- a/.cirrus.yml
> > +++ b/.cirrus.yml
> > @@ -40,3 +40,26 @@ macos_xcode_task:
> >      - ../configure --cc=3Dclang || { cat config.log; exit 1; }
> >      - gmake -j$(sysctl -n hw.ncpu)
> >      - gmake check
> > +
> > +windows_msys2_task:
> > +  windows_container:
> > +    image: cirrusci/windowsservercore:cmake
> > +    os_version: 2019
> > +    cpu: 8
> > +    memory: 8G
> > +  env:
> > +    MSYS: winsymlinks:nativestrict
> > +    MSYSTEM: MINGW64
> > +    CHERE_INVOKING: 1
> > +  printenv_script: C:\tools\msys64\usr\bin\bash.exe -lc 'printenv'
> > +  install_script:
> > +    - C:\tools\msys64\usr\bin\bash.exe -lc "cd /c/tools && curl -O
> http://repo.msys2.org/msys/x86_64/msys2-keyring-r21.b39fb11-1-any.pkg.tar=
.xz
> "
> > +    - C:\tools\msys64\usr\bin\bash.exe -lc "cd /c/tools && curl -O
> http://repo.msys2.org/msys/x86_64/msys2-keyring-r21.b39fb11-1-any.pkg.tar=
.xz.sig
> "
> > +    - C:\tools\msys64\usr\bin\bash.exe -lc "cd /c/tools && pacman -U
> --noconfirm msys2-keyring-r21.b39fb11-1-any.pkg.tar.xz"
> > +    - C:\tools\msys64\usr\bin\bash.exe -lc "pacman -Sy --noconfirm"
> > +    - C:\tools\msys64\usr\bin\bash.exe -lc "pacman --needed --noconfir=
m
> -S bash pacman pacman-mirrors msys2-runtime"
> > +    - taskkill /F /IM gpg-agent.exe
> > +    - C:\tools\msys64\usr\bin\bash.exe -lc "pacman --noconfirm -Su"
> > +    - C:\tools\msys64\usr\bin\bash.exe -lc "sh
> scripts/ci/windows/msys2_install.sh"
> > +  script:
> > +    C:\tools\msys64\usr\bin\bash.exe -lc "sh
> scripts/ci/windows/msys2_build.sh"
> > diff --git a/scripts/ci/windows/msys2_build.sh
> b/scripts/ci/windows/msys2_build.sh
> > new file mode 100644
> > index 0000000000..0363ef402a
> > --- /dev/null
> > +++ b/scripts/ci/windows/msys2_build.sh
> > @@ -0,0 +1,35 @@
> > +export QEMU_DIR=3D$PWD
> > +mkdir ../qemu-build
> > +cd ../qemu-build
> > +$QEMU_DIR/configure \
> > +  --python=3Dpython3 \
> > +  --cross-prefix=3Dx86_64-w64-mingw32- \
>
> Isn't the prefix 'x86_64-w64-mingw32-gcc-'?
>
> > +  --enable-gtk --enable-sdl \
> > +  --enable-capstone=3Dgit \
> > +  --enable-stack-protector \
> > +  --ninja=3Dninja \
> > +  --enable-gnutls \
> > +  --enable-nettle \
> > +  --enable-vnc \
> > +  --enable-vnc-sasl \
> > +  --enable-vnc-jpeg \
> > +  --enable-vnc-png \
> > +  --enable-membarrier \
> > +  --enable-slirp=3Dgit \
> > +  --disable-kvm \
> > +  --enable-hax \
> > +  --enable-whpx \
> > +  --disable-spice \
> > +  --enable-lzo \
> > +  --enable-snappy \
> > +  --enable-bzip2 \
> > +  --enable-vdi \
> > +  --enable-qcow1 \
> > +  --enable-tools \
> > +  --enable-libusb \
> > +  --enable-usb-redir \
> > +  --disable-libnfs \
> > +  --enable-libssh \
> > +  --disable-pie
> > +make -j$NUMBER_OF_PROCESSORS
> > +# make -j$NUMBER_OF_PROCESSORS check
> > diff --git a/scripts/ci/windows/msys2_install.sh
> b/scripts/ci/windows/msys2_install.sh
> > new file mode 100644
> > index 0000000000..3a5392cd99
> > --- /dev/null
> > +++ b/scripts/ci/windows/msys2_install.sh
> > @@ -0,0 +1,41 @@
> > +pacman --noconfirm -S --needed \
> > +base-devel \
> > +git \
> > +mingw-w64-x86_64-python \
> > +mingw-w64-x86_64-python-setuptools \
> > +mingw-w64-x86_64-toolchain \
> > +mingw-w64-x86_64-SDL2 \
> > +mingw-w64-x86_64-SDL2_image \
> > +mingw-w64-x86_64-gtk3 \
> > +mingw-w64-x86_64-ninja \
> > +mingw-w64-x86_64-make \
> > +mingw-w64-x86_64-lzo2 \
> > +mingw-w64-x86_64-libjpeg-turbo \
> > +mingw-w64-x86_64-pixman \
> > +mingw-w64-x86_64-libgcrypt \
> > +mingw-w64-x86_64-capstone \
> > +mingw-w64-x86_64-libpng \
> > +mingw-w64-x86_64-libssh \
> > +mingw-w64-x86_64-libxml2 \
> > +mingw-w64-x86_64-snappy \
> > +mingw-w64-x86_64-libusb \
> > +mingw-w64-x86_64-usbredir \
> > +mingw-w64-x86_64-libtasn1 \
> > +mingw-w64-x86_64-libnfs \
> > +mingw-w64-x86_64-nettle \
> > +mingw-w64-x86_64-cyrus-sasl \
> > +mingw-w64-x86_64-curl \
> > +mingw-w64-x86_64-gnutls \
> > +mingw-w64-x86_64-zstd \
> > +mingw-w64-x86_64-glib2
> > +
> > +cd /mingw64/bin
> > +cp x86_64-w64-mingw32-gcc-ar.exe x86_64-w64-mingw32-ar.exe
> > +cp x86_64-w64-mingw32-gcc-ranlib.exe x86_64-w64-mingw32-ranlib.exe
> > +cp x86_64-w64-mingw32-gcc-nm.exe x86_64-w64-mingw32-nm.exe
> > +cp windres.exe x86_64-w64-mingw32-windres.exe
> > +cp strip.exe x86_64-w64-mingw32-strip.exe
> > +cp objcopy.exe x86_64-w64-mingw32-objcopy.exe
> > +cp ld x86_64-w64-mingw32-ld.exe
> > +cp as x86_64-w64-mingw32-as.exe
> > +cp sdl2-config x86_64-w64-mingw32-sdl2-config
>
> Why is that needed?
>
> Thanks,
>
> Phil.
>
Hi, I am looking for suggestion for building  with msys2, this is comes
from wiki, if you have better idea, then tell me.

https://wiki.qemu.org/Hosts/W32#Native_builds_with_MSYS2

--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--00000000000043b80b05ae584697
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, Sep 3, 2020 at 1:30 AM Philip=
pe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug@amsat.org">f4bug@amsat.or=
g</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"=
>On 9/2/20 7:00 PM, Yonggang Luo wrote:<br>
&gt; ---<br>
&gt;=C2=A0 .cirrus.yml=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 23 ++++++++++++++++<br>
&gt;=C2=A0 scripts/ci/windows/msys2_build.sh=C2=A0 =C2=A0| 35 +++++++++++++=
+++++++++++<br>
&gt;=C2=A0 scripts/ci/windows/msys2_install.sh | 41 +++++++++++++++++++++++=
++++++<br>
&gt;=C2=A0 3 files changed, 99 insertions(+)<br>
&gt;=C2=A0 create mode 100644 scripts/ci/windows/msys2_build.sh<br>
&gt;=C2=A0 create mode 100644 scripts/ci/windows/msys2_install.sh<br>
&gt; <br>
&gt; diff --git a/.cirrus.yml b/.cirrus.yml<br>
&gt; index f287d23c5b..d377c28412 100644<br>
&gt; --- a/.cirrus.yml<br>
&gt; +++ b/.cirrus.yml<br>
&gt; @@ -40,3 +40,26 @@ macos_xcode_task:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 - ../configure --cc=3Dclang || { cat config.log; e=
xit 1; }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 - gmake -j$(sysctl -n hw.ncpu)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 - gmake check<br>
&gt; +<br>
&gt; +windows_msys2_task:<br>
&gt; +=C2=A0 windows_container:<br>
&gt; +=C2=A0 =C2=A0 image: cirrusci/windowsservercore:cmake<br>
&gt; +=C2=A0 =C2=A0 os_version: 2019<br>
&gt; +=C2=A0 =C2=A0 cpu: 8<br>
&gt; +=C2=A0 =C2=A0 memory: 8G<br>
&gt; +=C2=A0 env:<br>
&gt; +=C2=A0 =C2=A0 MSYS: winsymlinks:nativestrict<br>
&gt; +=C2=A0 =C2=A0 MSYSTEM: MINGW64<br>
&gt; +=C2=A0 =C2=A0 CHERE_INVOKING: 1<br>
&gt; +=C2=A0 printenv_script: C:\tools\msys64\usr\bin\bash.exe -lc &#39;pri=
ntenv&#39;<br>
&gt; +=C2=A0 install_script:<br>
&gt; +=C2=A0 =C2=A0 - C:\tools\msys64\usr\bin\bash.exe -lc &quot;cd /c/tool=
s &amp;&amp; curl -O <a href=3D"http://repo.msys2.org/msys/x86_64/msys2-key=
ring-r21.b39fb11-1-any.pkg.tar.xz" rel=3D"noreferrer" target=3D"_blank">htt=
p://repo.msys2.org/msys/x86_64/msys2-keyring-r21.b39fb11-1-any.pkg.tar.xz</=
a>&quot;<br>
&gt; +=C2=A0 =C2=A0 - C:\tools\msys64\usr\bin\bash.exe -lc &quot;cd /c/tool=
s &amp;&amp; curl -O <a href=3D"http://repo.msys2.org/msys/x86_64/msys2-key=
ring-r21.b39fb11-1-any.pkg.tar.xz.sig" rel=3D"noreferrer" target=3D"_blank"=
>http://repo.msys2.org/msys/x86_64/msys2-keyring-r21.b39fb11-1-any.pkg.tar.=
xz.sig</a>&quot;<br>
&gt; +=C2=A0 =C2=A0 - C:\tools\msys64\usr\bin\bash.exe -lc &quot;cd /c/tool=
s &amp;&amp; pacman -U --noconfirm msys2-keyring-r21.b39fb11-1-any.pkg.tar.=
xz&quot;<br>
&gt; +=C2=A0 =C2=A0 - C:\tools\msys64\usr\bin\bash.exe -lc &quot;pacman -Sy=
 --noconfirm&quot;<br>
&gt; +=C2=A0 =C2=A0 - C:\tools\msys64\usr\bin\bash.exe -lc &quot;pacman --n=
eeded --noconfirm -S bash pacman pacman-mirrors msys2-runtime&quot;<br>
&gt; +=C2=A0 =C2=A0 - taskkill /F /IM gpg-agent.exe<br>
&gt; +=C2=A0 =C2=A0 - C:\tools\msys64\usr\bin\bash.exe -lc &quot;pacman --n=
oconfirm -Su&quot;<br>
&gt; +=C2=A0 =C2=A0 - C:\tools\msys64\usr\bin\bash.exe -lc &quot;sh scripts=
/ci/windows/msys2_install.sh&quot;<br>
&gt; +=C2=A0 script:<br>
&gt; +=C2=A0 =C2=A0 C:\tools\msys64\usr\bin\bash.exe -lc &quot;sh scripts/c=
i/windows/msys2_build.sh&quot;<br>
&gt; diff --git a/scripts/ci/windows/msys2_build.sh b/scripts/ci/windows/ms=
ys2_build.sh<br>
&gt; new file mode 100644<br>
&gt; index 0000000000..0363ef402a<br>
&gt; --- /dev/null<br>
&gt; +++ b/scripts/ci/windows/msys2_build.sh<br>
&gt; @@ -0,0 +1,35 @@<br>
&gt; +export QEMU_DIR=3D$PWD<br>
&gt; +mkdir ../qemu-build<br>
&gt; +cd ../qemu-build<br>
&gt; +$QEMU_DIR/configure \<br>
&gt; +=C2=A0 --python=3Dpython3 \<br>
&gt; +=C2=A0 --cross-prefix=3Dx86_64-w64-mingw32- \<br>
<br>
Isn&#39;t the prefix &#39;x86_64-w64-mingw32-gcc-&#39;?<br>
<br>
&gt; +=C2=A0 --enable-gtk --enable-sdl \<br>
&gt; +=C2=A0 --enable-capstone=3Dgit \<br>
&gt; +=C2=A0 --enable-stack-protector \<br>
&gt; +=C2=A0 --ninja=3Dninja \<br>
&gt; +=C2=A0 --enable-gnutls \<br>
&gt; +=C2=A0 --enable-nettle \<br>
&gt; +=C2=A0 --enable-vnc \<br>
&gt; +=C2=A0 --enable-vnc-sasl \<br>
&gt; +=C2=A0 --enable-vnc-jpeg \<br>
&gt; +=C2=A0 --enable-vnc-png \<br>
&gt; +=C2=A0 --enable-membarrier \<br>
&gt; +=C2=A0 --enable-slirp=3Dgit \<br>
&gt; +=C2=A0 --disable-kvm \<br>
&gt; +=C2=A0 --enable-hax \<br>
&gt; +=C2=A0 --enable-whpx \<br>
&gt; +=C2=A0 --disable-spice \<br>
&gt; +=C2=A0 --enable-lzo \<br>
&gt; +=C2=A0 --enable-snappy \<br>
&gt; +=C2=A0 --enable-bzip2 \<br>
&gt; +=C2=A0 --enable-vdi \<br>
&gt; +=C2=A0 --enable-qcow1 \<br>
&gt; +=C2=A0 --enable-tools \<br>
&gt; +=C2=A0 --enable-libusb \<br>
&gt; +=C2=A0 --enable-usb-redir \<br>
&gt; +=C2=A0 --disable-libnfs \<br>
&gt; +=C2=A0 --enable-libssh \<br>
&gt; +=C2=A0 --disable-pie<br>
&gt; +make -j$NUMBER_OF_PROCESSORS<br>
&gt; +# make -j$NUMBER_OF_PROCESSORS check<br>
&gt; diff --git a/scripts/ci/windows/msys2_install.sh b/scripts/ci/windows/=
msys2_install.sh<br>
&gt; new file mode 100644<br>
&gt; index 0000000000..3a5392cd99<br>
&gt; --- /dev/null<br>
&gt; +++ b/scripts/ci/windows/msys2_install.sh<br>
&gt; @@ -0,0 +1,41 @@<br>
&gt; +pacman --noconfirm -S --needed \<br>
&gt; +base-devel \<br>
&gt; +git \<br>
&gt; +mingw-w64-x86_64-python \<br>
&gt; +mingw-w64-x86_64-python-setuptools \<br>
&gt; +mingw-w64-x86_64-toolchain \<br>
&gt; +mingw-w64-x86_64-SDL2 \<br>
&gt; +mingw-w64-x86_64-SDL2_image \<br>
&gt; +mingw-w64-x86_64-gtk3 \<br>
&gt; +mingw-w64-x86_64-ninja \<br>
&gt; +mingw-w64-x86_64-make \<br>
&gt; +mingw-w64-x86_64-lzo2 \<br>
&gt; +mingw-w64-x86_64-libjpeg-turbo \<br>
&gt; +mingw-w64-x86_64-pixman \<br>
&gt; +mingw-w64-x86_64-libgcrypt \<br>
&gt; +mingw-w64-x86_64-capstone \<br>
&gt; +mingw-w64-x86_64-libpng \<br>
&gt; +mingw-w64-x86_64-libssh \<br>
&gt; +mingw-w64-x86_64-libxml2 \<br>
&gt; +mingw-w64-x86_64-snappy \<br>
&gt; +mingw-w64-x86_64-libusb \<br>
&gt; +mingw-w64-x86_64-usbredir \<br>
&gt; +mingw-w64-x86_64-libtasn1 \<br>
&gt; +mingw-w64-x86_64-libnfs \<br>
&gt; +mingw-w64-x86_64-nettle \<br>
&gt; +mingw-w64-x86_64-cyrus-sasl \<br>
&gt; +mingw-w64-x86_64-curl \<br>
&gt; +mingw-w64-x86_64-gnutls \<br>
&gt; +mingw-w64-x86_64-zstd \<br>
&gt; +mingw-w64-x86_64-glib2<br>
&gt; +<br>
&gt; +cd /mingw64/bin<br>
&gt; +cp x86_64-w64-mingw32-gcc-ar.exe x86_64-w64-mingw32-ar.exe<br>
&gt; +cp x86_64-w64-mingw32-gcc-ranlib.exe x86_64-w64-mingw32-ranlib.exe<br=
>
&gt; +cp x86_64-w64-mingw32-gcc-nm.exe x86_64-w64-mingw32-nm.exe<br>
&gt; +cp windres.exe x86_64-w64-mingw32-windres.exe<br>
&gt; +cp strip.exe x86_64-w64-mingw32-strip.exe<br>
&gt; +cp objcopy.exe x86_64-w64-mingw32-objcopy.exe<br>
&gt; +cp ld x86_64-w64-mingw32-ld.exe<br>
&gt; +cp as x86_64-w64-mingw32-as.exe<br>
&gt; +cp sdl2-config x86_64-w64-mingw32-sdl2-config<br>
<br>
Why is that needed?<br>
<br>
Thanks,<br>
<br>
Phil.<br>
</blockquote></div>Hi, I am looking for suggestion for building=C2=A0

with msys2, this is comes from wiki, if you have better idea, then tell me.=
<div><br></div><div><a href=3D"https://wiki.qemu.org/Hosts/W32#Native_build=
s_with_MSYS2">https://wiki.qemu.org/Hosts/W32#Native_builds_with_MSYS2</a>=
=C2=A0<br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr" class=3D"gma=
il_signature">=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =E6=AD=A4=E8=87=B4<br>=E7=
=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=A0 sincerely,<=
br>Yonggang Luo<br></div></div></div>

--00000000000043b80b05ae584697--

