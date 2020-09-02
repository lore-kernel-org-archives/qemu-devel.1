Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B13D7C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 19:33:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16EB020773
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 19:33:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jxPVpFG3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16EB020773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDYVg-0004en-4m
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 15:33:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51372)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kDYUt-0004EH-U5
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 15:32:43 -0400
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:40078)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kDYUr-0002Z1-6L
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 15:32:43 -0400
Received: by mail-lj1-x244.google.com with SMTP id s205so553526lja.7
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2020 12:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=GeAXA/e7xg6qdtsau//xNE74gRxZgu8tOhwmbKH8peI=;
 b=jxPVpFG3elp/b/ZX0f+JLqY1I8Npf0opzPSEPLIr+YlSJ0MKHbW1PrFFzlCjSjj+UT
 Edg6mwe/534rMtoF+pMIXAr8H4K8MCT18wLvmHAAaxo6mLV5cxFDO0CuXE/XmdjwVGrZ
 lqWQL181UiA6gRmr856pxgI3FAg38bbT0tzlOrDC6zbukR+BN8M7/nAVuhPs+x9kNTjr
 1/ikFs3rfvIno7lFUnlqINZd4nL4XavpXhu9On1ix83Hk/Fgg9Q0yVWJgX6w9hocvY2g
 NPYNQDTKtm7yJ1dY41/q0lzMec8HMn7Z/JWI7Pt+6PBTYw55jN0PBKV1+iDH6TSx6pF0
 TLqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=GeAXA/e7xg6qdtsau//xNE74gRxZgu8tOhwmbKH8peI=;
 b=nf0/Z8BCqLEkTqEPTjIgf73x18vSEgKZgKQP+Z30TLx/B0aTuYPyvYvqxSii6DicH5
 C3Z2ZJnLHcVsCtzBif+8Pj8KaC7x0IDCj8FDAMAP+ItS6BdExqg0RbyUrxt4Kx4uHhCM
 WznSKAIRJ/vIGgRDQxwnHcofHO04NYtegq7UAs3YFe4luXuDjkAejBF5bykvsCTOH6e0
 5tmO6k2rkZmaQ5DsAHyVxLw7BVuasX6UTnWUujmw4CQVKkWqCvWpSg4mmlxZ1hugWMkS
 HLU7aFINY7JWqZTc43n7egj9er7IEKxRGl4A4JJ2s6GFFHE61YLG+SfMWTnylGesblvL
 uy/g==
X-Gm-Message-State: AOAM532OHAylPKL6hdXV+s1bRhJ47j8YcD+6Dsq3yDPAIh4Qs/TE0aNG
 tZBgI63B1CHtTbqjEZj/xgBNhytkIjqVl4v8KbU=
X-Google-Smtp-Source: ABdhPJzN0S9+0x1bH7RmWY29WbmoM4WZqY9rbkcW2aoA8zFhB0Z7qpifRQxRaHq/EZorU5ySNCeG6rrK97CNSB6Kr8A=
X-Received: by 2002:a05:651c:1119:: with SMTP id
 d25mr3613008ljo.300.1599075159480; 
 Wed, 02 Sep 2020 12:32:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200902170054.810-1-luoyonggang@gmail.com>
 <20200902170054.810-4-luoyonggang@gmail.com>
 <5cde63a0-46fe-2944-f96e-1f3268e49af8@amsat.org>
 <CAE2XoE9raBeKzTrxjr7SbAE_1=EfkF8np75DzNvAmO3Go_1nEg@mail.gmail.com>
 <484c1d28-70a1-3111-caf7-fe99656e1608@amsat.org>
In-Reply-To: <484c1d28-70a1-3111-caf7-fe99656e1608@amsat.org>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Thu, 3 Sep 2020 03:32:27 +0800
Message-ID: <CAE2XoE9mDtY-aHnOA3M=AxxO4f3zmGZRWw5sORsu5hmJMp3cug@mail.gmail.com>
Subject: Re: [PATCH 3/6] ci: Install msys2 in a proper way refer to
 https://github.com/cirruslabs/cirrus-ci-docs/issues/699 Enable msys2 ci in
 cirrus
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: multipart/alternative; boundary="000000000000d9a01c05ae59b2c2"
Received-SPF: pass client-ip=2a00:1450:4864:20::244;
 envelope-from=luoyonggang@gmail.com; helo=mail-lj1-x244.google.com
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

--000000000000d9a01c05ae59b2c2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 3, 2020 at 3:31 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org=
>
wrote:

> On 9/2/20 7:42 PM, =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) wrote:
> >
> >
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
> >     +++++++++++++++++++++++++++++
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
> >     > +    - C:\tools\msys64\usr\bin\bash.exe -lc "cd /c/tools && curl
> >     -O
> >
> http://repo.msys2.org/msys/x86_64/msys2-keyring-r21.b39fb11-1-any.pkg.tar=
.xz
> "
> >     > +    - C:\tools\msys64\usr\bin\bash.exe -lc "cd /c/tools && curl
> >     -O
> >
> http://repo.msys2.org/msys/x86_64/msys2-keyring-r21.b39fb11-1-any.pkg.tar=
.xz.sig
> "
> >     > +    - C:\tools\msys64\usr\bin\bash.exe -lc "cd /c/tools && pacma=
n
> >     -U --noconfirm msys2-keyring-r21.b39fb11-1-any.pkg.tar.xz"
> >     > +    - C:\tools\msys64\usr\bin\bash.exe -lc "pacman -Sy
> --noconfirm"
> >     > +    - C:\tools\msys64\usr\bin\bash.exe -lc "pacman --needed
> >     --noconfirm -S bash pacman pacman-mirrors msys2-runtime"
> >     > +    - taskkill /F /IM gpg-agent.exe
> >     > +    - C:\tools\msys64\usr\bin\bash.exe -lc "pacman --noconfirm
> -Su"
> >     > +    - C:\tools\msys64\usr\bin\bash.exe -lc "sh
> >     scripts/ci/windows/msys2_install.sh"
> >     > +  script:
> >     > +    C:\tools\msys64\usr\bin\bash.exe -lc "sh
> >     scripts/ci/windows/msys2_build.sh"
> >     > diff --git a/scripts/ci/windows/msys2_build.sh
> >     b/scripts/ci/windows/msys2_build.sh
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
> > No, because of this:
> > ```
> > C:\CI-Tools\msys64\mingw64\bin>dir x86_64-w64-mingw32*
> >  =E9=A9=B1=E5=8A=A8=E5=99=A8 C =E4=B8=AD=E7=9A=84=E5=8D=B7=E6=98=AF =E7=
=B3=BB=E7=BB=9F
> >  =E5=8D=B7=E7=9A=84=E5=BA=8F=E5=88=97=E5=8F=B7=E6=98=AF CAD5-8E95
> >
> >  C:\CI-Tools\msys64\mingw64\bin =E7=9A=84=E7=9B=AE=E5=BD=95
> >
> > 2018/01/17  16:54            36,022 x86_64-w64-mingw32-agrep.exe
> > 2020/09/02  05:06            67,861 x86_64-w64-mingw32-ar.exe
> > 2020/09/02  05:06         2,872,225 x86_64-w64-mingw32-as.exe
> > 2020/07/24  15:41         2,208,014 x86_64-w64-mingw32-c++.exe
> > 2020/02/17  19:50           489,984 x86_64-w64-mingw32-captoinfo.exe
> > 2020/02/17  19:50           348,160 x86_64-w64-mingw32-clear.exe
> > 2020/06/26  17:21            64,176 x86_64-w64-mingw32-deflatehd.exe
> > 2020/07/24  15:41         2,208,014 x86_64-w64-mingw32-g++.exe
> > 2020/07/24  15:41         2,205,454 x86_64-w64-mingw32-gcc-10.2.0.exe
> > 2020/07/24  15:41            67,861 x86_64-w64-mingw32-gcc-ar.exe
> > 2020/07/24  15:41            67,861 x86_64-w64-mingw32-gcc-nm.exe
> > 2020/07/24  15:41            67,861 x86_64-w64-mingw32-gcc-ranlib.exe
> > 2020/07/24  15:41         2,205,454 x86_64-w64-mingw32-gcc.exe
> > 2020/07/24  15:41         2,208,014 x86_64-w64-mingw32-gfortran.exe
> > 2020/06/26  17:21            59,734 x86_64-w64-mingw32-inflatehd.exe
> > 2020/02/17  19:50           462,848 x86_64-w64-mingw32-infocmp.exe
> > 2020/02/17  19:50           489,984 x86_64-w64-mingw32-infotocap.exe
> > 2020/09/02  05:06         2,773,229 x86_64-w64-mingw32-ld.exe
> > 2020/09/02  05:06            67,861 x86_64-w64-mingw32-nm.exe
> > 2020/09/02  05:06         2,367,282 x86_64-w64-mingw32-objcopy.exe
> > 2017/03/22  14:58           669,355 x86_64-w64-mingw32-pkg-config.exe
> > 2020/09/02  05:06            67,861 x86_64-w64-mingw32-ranlib.exe
> > 2020/02/17  19:50           356,352 x86_64-w64-mingw32-reset.exe
> > 2020/09/02  05:06             1,444 x86_64-w64-mingw32-sdl2-config
> > 2020/09/02  05:06         2,367,282 x86_64-w64-mingw32-strip.exe
> > 2020/02/17  19:50           348,160 x86_64-w64-mingw32-tabs.exe
> > 2020/02/17  19:50           489,984 x86_64-w64-mingw32-tic.exe
> > 2020/02/17  19:50           409,600 x86_64-w64-mingw32-toe.exe
> > 2020/02/17  19:50           355,328 x86_64-w64-mingw32-tput.exe
> > 2020/02/17  19:50           356,352 x86_64-w64-mingw32-tset.exe
> > 2020/09/02  05:06         2,344,638 x86_64-w64-mingw32-windres.exe
>
> So 'x86_64-w64-mingw32-' it is.
>
> >               31 =E4=B8=AA=E6=96=87=E4=BB=B6     29,104,255 =E5=AD=97=
=E8=8A=82
> >                0 =E4=B8=AA=E7=9B=AE=E5=BD=95 203,338,362,880 =E5=8F=AF=
=E7=94=A8=E5=AD=97=E8=8A=82
> > ```
> >
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
> > Comes from configure
>
> I meant why do you need to copy? The toolchain installation path names
> seem broken...
>
> The copy also comes from the Wiki, and I fond more broken things, so I
copied more, maybe there are better way to do that.

> > ```
> >
> > ar=3D"${AR-${cross_prefix}ar}"
> > as=3D"${AS-${cross_prefix}as}"
> > ccas=3D"${CCAS-$cc}"
> > cpp=3D"${CPP-$cc -E}"
> > objcopy=3D"${OBJCOPY-${cross_prefix}objcopy}"
> > ld=3D"${LD-${cross_prefix}ld}"
> > ranlib=3D"${RANLIB-${cross_prefix}ranlib}"
> > nm=3D"${NM-${cross_prefix}nm}"
> > strip=3D"${STRIP-${cross_prefix}strip}"
> > windres=3D"${WINDRES-${cross_prefix}windres}"
> > pkg_config_exe=3D"${PKG_CONFIG-${cross_prefix}pkg-config}"
> > query_pkg_config() {
> >     "${pkg_config_exe}" ${QEMU_PKG_CONFIG_FLAGS} "$@"
> > }
> > pkg_config=3Dquery_pkg_config
> > sdl2_config=3D"${SDL2_CONFIG-${cross_prefix}sdl2-config}"
> >
> > # If the user hasn't specified ARFLAGS, default to 'rv', just as make
> does.
> > ARFLAGS=3D"${ARFLAGS-rv}"
> > ```
> >
> >     Thanks,
> >
> >     Phil.
> >
> >
> >
> > --
> >          =E6=AD=A4=E8=87=B4
> > =E7=A4=BC
> > =E7=BD=97=E5=8B=87=E5=88=9A
> > Yours
> >     sincerely,
> > Yonggang Luo
>


--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--000000000000d9a01c05ae59b2c2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, Sep 3, 2020 at 3:31 AM Philip=
pe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug@amsat.org">f4bug@amsat.or=
g</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"=
>On 9/2/20 7:42 PM, =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) wrote:<br>
&gt; <br>
&gt; <br>
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
<br>
&gt;=C2=A0 =C2=A0 =C2=A0+++++++++++++++++++++++++++++<br>
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
exe -lc &quot;cd /c/tools &amp;&amp; curl<br>
&gt;=C2=A0 =C2=A0 =C2=A0-O<br>
&gt;=C2=A0 =C2=A0 =C2=A0<a href=3D"http://repo.msys2.org/msys/x86_64/msys2-=
keyring-r21.b39fb11-1-any.pkg.tar.xz" rel=3D"noreferrer" target=3D"_blank">=
http://repo.msys2.org/msys/x86_64/msys2-keyring-r21.b39fb11-1-any.pkg.tar.x=
z</a>&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 - C:\tools\msys64\usr\bin\bash.=
exe -lc &quot;cd /c/tools &amp;&amp; curl<br>
&gt;=C2=A0 =C2=A0 =C2=A0-O<br>
&gt;=C2=A0 =C2=A0 =C2=A0<a href=3D"http://repo.msys2.org/msys/x86_64/msys2-=
keyring-r21.b39fb11-1-any.pkg.tar.xz.sig" rel=3D"noreferrer" target=3D"_bla=
nk">http://repo.msys2.org/msys/x86_64/msys2-keyring-r21.b39fb11-1-any.pkg.t=
ar.xz.sig</a>&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 - C:\tools\msys64\usr\bin\bash.=
exe -lc &quot;cd /c/tools &amp;&amp; pacman<br>
&gt;=C2=A0 =C2=A0 =C2=A0-U --noconfirm msys2-keyring-r21.b39fb11-1-any.pkg.=
tar.xz&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 - C:\tools\msys64\usr\bin\bash.=
exe -lc &quot;pacman -Sy --noconfirm&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 - C:\tools\msys64\usr\bin\bash.=
exe -lc &quot;pacman --needed<br>
&gt;=C2=A0 =C2=A0 =C2=A0--noconfirm -S bash pacman pacman-mirrors msys2-run=
time&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 - taskkill /F /IM gpg-agent.exe=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 - C:\tools\msys64\usr\bin\bash.=
exe -lc &quot;pacman --noconfirm -Su&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 - C:\tools\msys64\usr\bin\bash.=
exe -lc &quot;sh<br>
&gt;=C2=A0 =C2=A0 =C2=A0scripts/ci/windows/msys2_install.sh&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 script:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0 C:\tools\msys64\usr\bin\bash.ex=
e -lc &quot;sh<br>
&gt;=C2=A0 =C2=A0 =C2=A0scripts/ci/windows/msys2_build.sh&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; diff --git a/scripts/ci/windows/msys2_build.sh=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0b/scripts/ci/windows/msys2_build.sh<br>
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
&gt; No, because of this:<br>
&gt; ```<br>
&gt; C:\CI-Tools\msys64\mingw64\bin&gt;dir x86_64-w64-mingw32*<br>
&gt; =C2=A0=E9=A9=B1=E5=8A=A8=E5=99=A8 C =E4=B8=AD=E7=9A=84=E5=8D=B7=E6=98=
=AF =E7=B3=BB=E7=BB=9F<br>
&gt; =C2=A0=E5=8D=B7=E7=9A=84=E5=BA=8F=E5=88=97=E5=8F=B7=E6=98=AF CAD5-8E95=
<br>
&gt; <br>
&gt; =C2=A0C:\CI-Tools\msys64\mingw64\bin =E7=9A=84=E7=9B=AE=E5=BD=95<br>
&gt; <br>
&gt; 2018/01/17 =C2=A016:54 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A036,022=
 x86_64-w64-mingw32-agrep.exe<br>
&gt; 2020/09/02 =C2=A005:06 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A067,861=
 x86_64-w64-mingw32-ar.exe<br>
&gt; 2020/09/02 =C2=A005:06 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2,872,225 x86_64-w6=
4-mingw32-as.exe<br>
&gt; 2020/07/24 =C2=A015:41 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2,208,014 x86_64-w6=
4-mingw32-c++.exe<br>
&gt; 2020/02/17 =C2=A019:50 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 489,984 x86_=
64-w64-mingw32-captoinfo.exe<br>
&gt; 2020/02/17 =C2=A019:50 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 348,160 x86_=
64-w64-mingw32-clear.exe<br>
&gt; 2020/06/26 =C2=A017:21 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A064,176=
 x86_64-w64-mingw32-deflatehd.exe<br>
&gt; 2020/07/24 =C2=A015:41 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2,208,014 x86_64-w6=
4-mingw32-g++.exe<br>
&gt; 2020/07/24 =C2=A015:41 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2,205,454 x86_64-w6=
4-mingw32-gcc-10.2.0.exe<br>
&gt; 2020/07/24 =C2=A015:41 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A067,861=
 x86_64-w64-mingw32-gcc-ar.exe<br>
&gt; 2020/07/24 =C2=A015:41 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A067,861=
 x86_64-w64-mingw32-gcc-nm.exe<br>
&gt; 2020/07/24 =C2=A015:41 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A067,861=
 x86_64-w64-mingw32-gcc-ranlib.exe<br>
&gt; 2020/07/24 =C2=A015:41 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2,205,454 x86_64-w6=
4-mingw32-gcc.exe<br>
&gt; 2020/07/24 =C2=A015:41 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2,208,014 x86_64-w6=
4-mingw32-gfortran.exe<br>
&gt; 2020/06/26 =C2=A017:21 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A059,734=
 x86_64-w64-mingw32-inflatehd.exe<br>
&gt; 2020/02/17 =C2=A019:50 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 462,848 x86_=
64-w64-mingw32-infocmp.exe<br>
&gt; 2020/02/17 =C2=A019:50 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 489,984 x86_=
64-w64-mingw32-infotocap.exe<br>
&gt; 2020/09/02 =C2=A005:06 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2,773,229 x86_64-w6=
4-mingw32-ld.exe<br>
&gt; 2020/09/02 =C2=A005:06 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A067,861=
 x86_64-w64-mingw32-nm.exe<br>
&gt; 2020/09/02 =C2=A005:06 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2,367,282 x86_64-w6=
4-mingw32-objcopy.exe<br>
&gt; 2017/03/22 =C2=A014:58 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 669,355 x86_=
64-w64-mingw32-pkg-config.exe<br>
&gt; 2020/09/02 =C2=A005:06 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A067,861=
 x86_64-w64-mingw32-ranlib.exe<br>
&gt; 2020/02/17 =C2=A019:50 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 356,352 x86_=
64-w64-mingw32-reset.exe<br>
&gt; 2020/09/02 =C2=A005:06 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1,444=
 x86_64-w64-mingw32-sdl2-config<br>
&gt; 2020/09/02 =C2=A005:06 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2,367,282 x86_64-w6=
4-mingw32-strip.exe<br>
&gt; 2020/02/17 =C2=A019:50 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 348,160 x86_=
64-w64-mingw32-tabs.exe<br>
&gt; 2020/02/17 =C2=A019:50 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 489,984 x86_=
64-w64-mingw32-tic.exe<br>
&gt; 2020/02/17 =C2=A019:50 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 409,600 x86_=
64-w64-mingw32-toe.exe<br>
&gt; 2020/02/17 =C2=A019:50 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 355,328 x86_=
64-w64-mingw32-tput.exe<br>
&gt; 2020/02/17 =C2=A019:50 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 356,352 x86_=
64-w64-mingw32-tset.exe<br>
&gt; 2020/09/02 =C2=A005:06 =C2=A0 =C2=A0 =C2=A0 =C2=A0 2,344,638 x86_64-w6=
4-mingw32-windres.exe<br>
<br>
So &#39;x86_64-w64-mingw32-&#39; it is.<br>
<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 31 =E4=B8=AA=E6=96=87=
=E4=BB=B6 =C2=A0 =C2=A0 29,104,255 =E5=AD=97=E8=8A=82<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00 =E4=B8=AA=E7=
=9B=AE=E5=BD=95 203,338,362,880 =E5=8F=AF=E7=94=A8=E5=AD=97=E8=8A=82<br>
&gt; ```<br>
&gt; <br>
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
&gt; Comes from configure=C2=A0<br>
<br>
I meant why do you need to copy? The toolchain installation path names<br>
seem broken...<br>
<br></blockquote><div>The copy also comes from the Wiki, and I fond more br=
oken things, so I copied more, maybe there are better way to do that.=C2=A0=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt; ```<br>
&gt; <br>
&gt; ar=3D&quot;${AR-${cross_prefix}ar}&quot;<br>
&gt; as=3D&quot;${AS-${cross_prefix}as}&quot;<br>
&gt; ccas=3D&quot;${CCAS-$cc}&quot;<br>
&gt; cpp=3D&quot;${CPP-$cc -E}&quot;<br>
&gt; objcopy=3D&quot;${OBJCOPY-${cross_prefix}objcopy}&quot;<br>
&gt; ld=3D&quot;${LD-${cross_prefix}ld}&quot;<br>
&gt; ranlib=3D&quot;${RANLIB-${cross_prefix}ranlib}&quot;<br>
&gt; nm=3D&quot;${NM-${cross_prefix}nm}&quot;<br>
&gt; strip=3D&quot;${STRIP-${cross_prefix}strip}&quot;<br>
&gt; windres=3D&quot;${WINDRES-${cross_prefix}windres}&quot;<br>
&gt; pkg_config_exe=3D&quot;${PKG_CONFIG-${cross_prefix}pkg-config}&quot;<b=
r>
&gt; query_pkg_config() {<br>
&gt; =C2=A0 =C2=A0 &quot;${pkg_config_exe}&quot; ${QEMU_PKG_CONFIG_FLAGS} &=
quot;$@&quot;<br>
&gt; }<br>
&gt; pkg_config=3Dquery_pkg_config<br>
&gt; sdl2_config=3D&quot;${SDL2_CONFIG-${cross_prefix}sdl2-config}&quot;<br=
>
&gt; <br>
&gt; # If the user hasn&#39;t specified ARFLAGS, default to &#39;rv&#39;, j=
ust as make does.<br>
&gt; ARFLAGS=3D&quot;${ARFLAGS-rv}&quot;<br>
&gt; ```<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Thanks,<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Phil.<br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; -- <br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =E6=AD=A4=E8=87=B4<br>
&gt; =E7=A4=BC<br>
&gt; =E7=BD=97=E5=8B=87=E5=88=9A<br>
&gt; Yours<br>
&gt; =C2=A0 =C2=A0 sincerely,<br>
&gt; Yonggang Luo<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =E6=AD=A4=E8=
=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=
=A0 sincerely,<br>Yonggang Luo<br></div></div>

--000000000000d9a01c05ae59b2c2--

