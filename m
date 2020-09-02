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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC249C433E7
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 17:43:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47970207EA
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 17:43:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fogI1gmg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47970207EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDWn6-0002bA-Ay
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 13:43:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56332)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kDWmE-00020X-L0
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 13:42:30 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:46874)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kDWmB-0005i5-QK
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 13:42:30 -0400
Received: by mail-lj1-x242.google.com with SMTP id h19so96452ljg.13
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2020 10:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=3+nSdm0uTCEgkXQl6P1nWAcTWk8FhhKSfDcjimnp0oQ=;
 b=fogI1gmgCK3McZc+A2v/jRG1Nr7m/q0tbk2ftwwR65JDuFKdJiNqHRPIkOZKb2l0jz
 VeyRaxqYgaaBFSSHp/CgrkZpNIuFoHgdfCAIKbdOGonw2zlqQjWKyuK0itHyaVl4fPl9
 Y0369qwg0+70YYFzaFoVCWA31lWknmjOAxtt5i67hOPtcNk+unxYm69UVmscUE99oVc5
 P3b2OAp3mSagBAI1fCM8Q+2elmoeNcu0uBsVZ7y63ucUANJMnl/tRE/i9cCZkEkX+C/j
 cgsmQhM1dDZIfKnQmSFD/o2BqSzMBYg45KyFNSbW9ACZhEzW6eQ/KlG9PhXXTK2JAnWM
 tZng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=3+nSdm0uTCEgkXQl6P1nWAcTWk8FhhKSfDcjimnp0oQ=;
 b=IY8QgT/pr8spEOAGyt8+2ZkFIRUa4818il5/QOTYTdEdAJ4Hk+eyx+3WfaM05jOuQ1
 E4fh+obDTp5oV7kRYNocWEfiAvAzBZl2A6cJCBNnPqvnTeK+80hoeM054Rl7jch3Xx5J
 OBmwhnTj4Itv+B3ogkvnujbHHC9rMPOqwGKL+ideMfPY+lnL7AB6NbCVV1VVKAHUsnuI
 gFT/8Exzy9tjaMQixcnMGXhmXKsIKT3VNiYMVl2yM5dCSyi1DwYTAhS1JWjyKZxFU7nu
 bwcaO30QReh+RaGaATyk7JqIRml90oWeLnCOIB42keLK/CPvesmYypIVgOEnyyYVhxZw
 bXpQ==
X-Gm-Message-State: AOAM531VVIB1L40icUGasMJTolwxqE270Txiesv+5BSWfQhFgx6ybSb+
 F8mGefcU6kngj85MnaGH8UYqXMD77I0cPGYd45o=
X-Google-Smtp-Source: ABdhPJyR2GyUmwPARuyOAo6KyDER+mt8NqSPS/MHRdxcDGHgqtGEgUDzpZFQvXiBIWc47u7tUKywQXrUUX6mjZliD4Q=
X-Received: by 2002:a2e:8084:: with SMTP id i4mr4064096ljg.447.1599068545799; 
 Wed, 02 Sep 2020 10:42:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200902170054.810-1-luoyonggang@gmail.com>
 <20200902170054.810-4-luoyonggang@gmail.com>
 <5cde63a0-46fe-2944-f96e-1f3268e49af8@amsat.org>
In-Reply-To: <5cde63a0-46fe-2944-f96e-1f3268e49af8@amsat.org>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Thu, 3 Sep 2020 01:42:14 +0800
Message-ID: <CAE2XoE9raBeKzTrxjr7SbAE_1=EfkF8np75DzNvAmO3Go_1nEg@mail.gmail.com>
Subject: Re: [PATCH 3/6] ci: Install msys2 in a proper way refer to
 https://github.com/cirruslabs/cirrus-ci-docs/issues/699 Enable msys2 ci in
 cirrus
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: multipart/alternative; boundary="000000000000a4dc0105ae5828c9"
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

--000000000000a4dc0105ae5828c9
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
No, because of this:
```
C:\CI-Tools\msys64\mingw64\bin>dir x86_64-w64-mingw32*
 =E9=A9=B1=E5=8A=A8=E5=99=A8 C =E4=B8=AD=E7=9A=84=E5=8D=B7=E6=98=AF =E7=B3=
=BB=E7=BB=9F
 =E5=8D=B7=E7=9A=84=E5=BA=8F=E5=88=97=E5=8F=B7=E6=98=AF CAD5-8E95

 C:\CI-Tools\msys64\mingw64\bin =E7=9A=84=E7=9B=AE=E5=BD=95

2018/01/17  16:54            36,022 x86_64-w64-mingw32-agrep.exe
2020/09/02  05:06            67,861 x86_64-w64-mingw32-ar.exe
2020/09/02  05:06         2,872,225 x86_64-w64-mingw32-as.exe
2020/07/24  15:41         2,208,014 x86_64-w64-mingw32-c++.exe
2020/02/17  19:50           489,984 x86_64-w64-mingw32-captoinfo.exe
2020/02/17  19:50           348,160 x86_64-w64-mingw32-clear.exe
2020/06/26  17:21            64,176 x86_64-w64-mingw32-deflatehd.exe
2020/07/24  15:41         2,208,014 x86_64-w64-mingw32-g++.exe
2020/07/24  15:41         2,205,454 x86_64-w64-mingw32-gcc-10.2.0.exe
2020/07/24  15:41            67,861 x86_64-w64-mingw32-gcc-ar.exe
2020/07/24  15:41            67,861 x86_64-w64-mingw32-gcc-nm.exe
2020/07/24  15:41            67,861 x86_64-w64-mingw32-gcc-ranlib.exe
2020/07/24  15:41         2,205,454 x86_64-w64-mingw32-gcc.exe
2020/07/24  15:41         2,208,014 x86_64-w64-mingw32-gfortran.exe
2020/06/26  17:21            59,734 x86_64-w64-mingw32-inflatehd.exe
2020/02/17  19:50           462,848 x86_64-w64-mingw32-infocmp.exe
2020/02/17  19:50           489,984 x86_64-w64-mingw32-infotocap.exe
2020/09/02  05:06         2,773,229 x86_64-w64-mingw32-ld.exe
2020/09/02  05:06            67,861 x86_64-w64-mingw32-nm.exe
2020/09/02  05:06         2,367,282 x86_64-w64-mingw32-objcopy.exe
2017/03/22  14:58           669,355 x86_64-w64-mingw32-pkg-config.exe
2020/09/02  05:06            67,861 x86_64-w64-mingw32-ranlib.exe
2020/02/17  19:50           356,352 x86_64-w64-mingw32-reset.exe
2020/09/02  05:06             1,444 x86_64-w64-mingw32-sdl2-config
2020/09/02  05:06         2,367,282 x86_64-w64-mingw32-strip.exe
2020/02/17  19:50           348,160 x86_64-w64-mingw32-tabs.exe
2020/02/17  19:50           489,984 x86_64-w64-mingw32-tic.exe
2020/02/17  19:50           409,600 x86_64-w64-mingw32-toe.exe
2020/02/17  19:50           355,328 x86_64-w64-mingw32-tput.exe
2020/02/17  19:50           356,352 x86_64-w64-mingw32-tset.exe
2020/09/02  05:06         2,344,638 x86_64-w64-mingw32-windres.exe
              31 =E4=B8=AA=E6=96=87=E4=BB=B6     29,104,255 =E5=AD=97=E8=8A=
=82
               0 =E4=B8=AA=E7=9B=AE=E5=BD=95 203,338,362,880 =E5=8F=AF=E7=
=94=A8=E5=AD=97=E8=8A=82
```

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
> Comes from configure
```

ar=3D"${AR-${cross_prefix}ar}"
as=3D"${AS-${cross_prefix}as}"
ccas=3D"${CCAS-$cc}"
cpp=3D"${CPP-$cc -E}"
objcopy=3D"${OBJCOPY-${cross_prefix}objcopy}"
ld=3D"${LD-${cross_prefix}ld}"
ranlib=3D"${RANLIB-${cross_prefix}ranlib}"
nm=3D"${NM-${cross_prefix}nm}"
strip=3D"${STRIP-${cross_prefix}strip}"
windres=3D"${WINDRES-${cross_prefix}windres}"
pkg_config_exe=3D"${PKG_CONFIG-${cross_prefix}pkg-config}"
query_pkg_config() {
    "${pkg_config_exe}" ${QEMU_PKG_CONFIG_FLAGS} "$@"
}
pkg_config=3Dquery_pkg_config
sdl2_config=3D"${SDL2_CONFIG-${cross_prefix}sdl2-config}"

# If the user hasn't specified ARFLAGS, default to 'rv', just as make does.
ARFLAGS=3D"${ARFLAGS-rv}"
```
>
> Thanks,
>
> Phil.
>


--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--000000000000a4dc0105ae5828c9
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
Isn&#39;t the prefix &#39;x86_64-w64-mingw32-gcc-&#39;?<br></blockquote><di=
v>No, because of this:</div><div>```</div><div>C:\CI-Tools\msys64\mingw64\b=
in&gt;dir x86_64-w64-mingw32*<br>=C2=A0=E9=A9=B1=E5=8A=A8=E5=99=A8 C =E4=B8=
=AD=E7=9A=84=E5=8D=B7=E6=98=AF =E7=B3=BB=E7=BB=9F<br>=C2=A0=E5=8D=B7=E7=9A=
=84=E5=BA=8F=E5=88=97=E5=8F=B7=E6=98=AF CAD5-8E95<br><br>=C2=A0C:\CI-Tools\=
msys64\mingw64\bin =E7=9A=84=E7=9B=AE=E5=BD=95<br><br>2018/01/17 =C2=A016:5=
4 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A036,022 x86_64-w64-mingw32-agrep.=
exe<br>2020/09/02 =C2=A005:06 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A067,8=
61 x86_64-w64-mingw32-ar.exe<br>2020/09/02 =C2=A005:06 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 2,872,225 x86_64-w64-mingw32-as.exe<br>2020/07/24 =C2=A015:41 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 2,208,014 x86_64-w64-mingw32-c++.exe<br>2020/02/17=
 =C2=A019:50 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 489,984 x86_64-w64-mingw32-=
captoinfo.exe<br>2020/02/17 =C2=A019:50 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
348,160 x86_64-w64-mingw32-clear.exe<br>2020/06/26 =C2=A017:21 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A064,176 x86_64-w64-mingw32-deflatehd.exe<br>2=
020/07/24 =C2=A015:41 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2,208,014 x86_64-w64-ming=
w32-g++.exe<br>2020/07/24 =C2=A015:41 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2,205,454=
 x86_64-w64-mingw32-gcc-10.2.0.exe<br>2020/07/24 =C2=A015:41 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A067,861 x86_64-w64-mingw32-gcc-ar.exe<br>2020/07/=
24 =C2=A015:41 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A067,861 x86_64-w64-m=
ingw32-gcc-nm.exe<br>2020/07/24 =C2=A015:41 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A067,861 x86_64-w64-mingw32-gcc-ranlib.exe<br>2020/07/24 =C2=A015:4=
1 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2,205,454 x86_64-w64-mingw32-gcc.exe<br>2020/=
07/24 =C2=A015:41 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2,208,014 x86_64-w64-mingw32-=
gfortran.exe<br>2020/06/26 =C2=A017:21 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A059,734 x86_64-w64-mingw32-inflatehd.exe<br>2020/02/17 =C2=A019:50 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 462,848 x86_64-w64-mingw32-infocmp.exe<br>2=
020/02/17 =C2=A019:50 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 489,984 x86_64-w64=
-mingw32-infotocap.exe<br>2020/09/02 =C2=A005:06 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 2,773,229 x86_64-w64-mingw32-ld.exe<br>2020/09/02 =C2=A005:06 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A067,861 x86_64-w64-mingw32-nm.exe<br>2020/=
09/02 =C2=A005:06 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2,367,282 x86_64-w64-mingw32-=
objcopy.exe<br>2017/03/22 =C2=A014:58 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 66=
9,355 x86_64-w64-mingw32-pkg-config.exe<br>2020/09/02 =C2=A005:06 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A067,861 x86_64-w64-mingw32-ranlib.exe<br>2=
020/02/17 =C2=A019:50 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 356,352 x86_64-w64=
-mingw32-reset.exe<br>2020/09/02 =C2=A005:06 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 1,444 x86_64-w64-mingw32-sdl2-config<br>2020/09/02 =C2=A005:0=
6 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2,367,282 x86_64-w64-mingw32-strip.exe<br>202=
0/02/17 =C2=A019:50 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 348,160 x86_64-w64-m=
ingw32-tabs.exe<br>2020/02/17 =C2=A019:50 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 489,984 x86_64-w64-mingw32-tic.exe<br>2020/02/17 =C2=A019:50 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 409,600 x86_64-w64-mingw32-toe.exe<br>2020/02/17 =
=C2=A019:50 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 355,328 x86_64-w64-mingw32-t=
put.exe<br>2020/02/17 =C2=A019:50 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 356,35=
2 x86_64-w64-mingw32-tset.exe<br>2020/09/02 =C2=A005:06 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 2,344,638 x86_64-w64-mingw32-windres.exe<br>=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 31 =E4=B8=AA=E6=96=87=E4=BB=B6 =C2=A0 =C2=A0 2=
9,104,255 =E5=AD=97=E8=8A=82<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A00 =E4=B8=AA=E7=9B=AE=E5=BD=95 203,338,362,880 =E5=8F=AF=E7=94=
=A8=E5=AD=97=E8=8A=82<br></div><div>```</div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex">
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
<br></blockquote><div>Comes from configure=C2=A0</div>```<br><br>ar=3D&quot=
;${AR-${cross_prefix}ar}&quot;<br>as=3D&quot;${AS-${cross_prefix}as}&quot;<=
br>ccas=3D&quot;${CCAS-$cc}&quot;<br>cpp=3D&quot;${CPP-$cc -E}&quot;<br>obj=
copy=3D&quot;${OBJCOPY-${cross_prefix}objcopy}&quot;<br>ld=3D&quot;${LD-${c=
ross_prefix}ld}&quot;<br>ranlib=3D&quot;${RANLIB-${cross_prefix}ranlib}&quo=
t;<br>nm=3D&quot;${NM-${cross_prefix}nm}&quot;<br>strip=3D&quot;${STRIP-${c=
ross_prefix}strip}&quot;<br>windres=3D&quot;${WINDRES-${cross_prefix}windre=
s}&quot;<br>pkg_config_exe=3D&quot;${PKG_CONFIG-${cross_prefix}pkg-config}&=
quot;<br>query_pkg_config() {<br>=C2=A0 =C2=A0 &quot;${pkg_config_exe}&quot=
; ${QEMU_PKG_CONFIG_FLAGS} &quot;$@&quot;<br>}<br>pkg_config=3Dquery_pkg_co=
nfig<br>sdl2_config=3D&quot;${SDL2_CONFIG-${cross_prefix}sdl2-config}&quot;=
<br><br># If the user hasn&#39;t specified ARFLAGS, default to &#39;rv&#39;=
, just as make does.<br>ARFLAGS=3D&quot;${ARFLAGS-rv}&quot;<br>```<blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">
Thanks,<br>
<br>
Phil.<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =E6=AD=A4=E8=
=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=
=A0 sincerely,<br>Yonggang Luo<br></div></div>

--000000000000a4dc0105ae5828c9--

