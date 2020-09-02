Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EA23C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 19:31:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B752920773
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 19:31:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LV32Ctad"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B752920773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDYU9-0003lA-An
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 15:31:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50988)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kDYTP-00034d-Br
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 15:31:11 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:41070)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kDYTL-0002QP-IQ
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 15:31:11 -0400
Received: by mail-wr1-x441.google.com with SMTP id w5so584534wrp.8
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2020 12:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=X8G1MG2zh8T4bxOuWQdx67bXXgwvX+fzCUs/xBOAmRU=;
 b=LV32CtadZ1U8jEtyUqcSIQYVXiwddVAphmP4DnwZVrHtwohAhcEC2cWO60xg87xRel
 sKaBOK8gBwj3TjCVmlW4UTGnSS0LibzdR8iYdAR1CEx39mFuAODqjTJxFQHwrA3ZgZAH
 lVHTUD6o00wDLQYuQgStVfVLKJL4cC690S+9cv903r53alxRo9l6N0AzoF52BsrZpoiZ
 N54Qvwpae5TxEo2+m7xmTpc30AtiQDbs7Ulnx9LvmL/7UmBTuowvD3Wd+K8THm/ry379
 /DdFW8PHQJID+tAQu1hDO6D1eS7ZhI1cqGlO6jGE936EtaWINd7zJLe/nI8HkV1Mwlh9
 7m5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=X8G1MG2zh8T4bxOuWQdx67bXXgwvX+fzCUs/xBOAmRU=;
 b=SvXg61V3rJ2pXOodPI/REOfEE9cALDM+6sSEJF3X+O63d97v0cEoRWXthhqa/i6jbH
 X3wyMzu5bQZlTgvwb9anbPhZYNb/4UIgYVSw5bZU+JPd4/xf4CsBh1rrBYDmv1qtz4ki
 EjWWOw7wv/aX8U8wcCyRvvF4+bOfy1k1hA6HK/l2WxFQhHRaDGJ7/Grl2bGkRzXPQygN
 hRDuOihLj29unUEP+AF4YdZV/F8otxs33PnjP8DazIDYuKgpg3jtJ6jYTvlhQalP4RBP
 Kp6c5jpm2syAtQ1wS/8hBOvrM9XtaKi9SRn3aOJWhW5w1YrNZEMtkApLQq7rYm2RjTL1
 nT3g==
X-Gm-Message-State: AOAM530206B79RqAGxvBpW4Fq8ukJGGqUQm0kd8ncWsRl2ToDogjnFfY
 AqLSXo9bzzlTG0LfnKZKBS768TpqIY0=
X-Google-Smtp-Source: ABdhPJwENLEVjeynyB3U6aRcvaSyPABngMHh/vN2Izjsul/i0bqcMmP7AVStqwe2hG+pSVKlTIJrAQ==
X-Received: by 2002:adf:f7d0:: with SMTP id a16mr8197854wrq.381.1599075063715; 
 Wed, 02 Sep 2020 12:31:03 -0700 (PDT)
Received: from [192.168.1.36] (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id t203sm903083wmg.43.2020.09.02.12.31.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Sep 2020 12:31:02 -0700 (PDT)
Subject: Re: [PATCH 3/6] ci: Install msys2 in a proper way refer to
 https://github.com/cirruslabs/cirrus-ci-docs/issues/699 Enable msys2 ci in
 cirrus
To: luoyonggang@gmail.com
References: <20200902170054.810-1-luoyonggang@gmail.com>
 <20200902170054.810-4-luoyonggang@gmail.com>
 <5cde63a0-46fe-2944-f96e-1f3268e49af8@amsat.org>
 <CAE2XoE9raBeKzTrxjr7SbAE_1=EfkF8np75DzNvAmO3Go_1nEg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <484c1d28-70a1-3111-caf7-fe99656e1608@amsat.org>
Date: Wed, 2 Sep 2020 21:31:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAE2XoE9raBeKzTrxjr7SbAE_1=EfkF8np75DzNvAmO3Go_1nEg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001, NICE_REPLY_A=-0.324,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-level <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/2/20 7:42 PM, 罗勇刚(Yonggang Luo) wrote:
> 
> 
> On Thu, Sep 3, 2020 at 1:30 AM Philippe Mathieu-Daudé <f4bug@amsat.org
> <mailto:f4bug@amsat.org>> wrote:
> 
>     On 9/2/20 7:00 PM, Yonggang Luo wrote:
>     > ---
>     >  .cirrus.yml                         | 23 ++++++++++++++++
>     >  scripts/ci/windows/msys2_build.sh   | 35 ++++++++++++++++++++++++
>     >  scripts/ci/windows/msys2_install.sh | 41
>     +++++++++++++++++++++++++++++
>     >  3 files changed, 99 insertions(+)
>     >  create mode 100644 scripts/ci/windows/msys2_build.sh
>     >  create mode 100644 scripts/ci/windows/msys2_install.sh
>     >
>     > diff --git a/.cirrus.yml b/.cirrus.yml
>     > index f287d23c5b..d377c28412 100644
>     > --- a/.cirrus.yml
>     > +++ b/.cirrus.yml
>     > @@ -40,3 +40,26 @@ macos_xcode_task:
>     >      - ../configure --cc=clang || { cat config.log; exit 1; }
>     >      - gmake -j$(sysctl -n hw.ncpu)
>     >      - gmake check
>     > +
>     > +windows_msys2_task:
>     > +  windows_container:
>     > +    image: cirrusci/windowsservercore:cmake
>     > +    os_version: 2019
>     > +    cpu: 8
>     > +    memory: 8G
>     > +  env:
>     > +    MSYS: winsymlinks:nativestrict
>     > +    MSYSTEM: MINGW64
>     > +    CHERE_INVOKING: 1
>     > +  printenv_script: C:\tools\msys64\usr\bin\bash.exe -lc 'printenv'
>     > +  install_script:
>     > +    - C:\tools\msys64\usr\bin\bash.exe -lc "cd /c/tools && curl
>     -O
>     http://repo.msys2.org/msys/x86_64/msys2-keyring-r21.b39fb11-1-any.pkg.tar.xz"
>     > +    - C:\tools\msys64\usr\bin\bash.exe -lc "cd /c/tools && curl
>     -O
>     http://repo.msys2.org/msys/x86_64/msys2-keyring-r21.b39fb11-1-any.pkg.tar.xz.sig"
>     > +    - C:\tools\msys64\usr\bin\bash.exe -lc "cd /c/tools && pacman
>     -U --noconfirm msys2-keyring-r21.b39fb11-1-any.pkg.tar.xz"
>     > +    - C:\tools\msys64\usr\bin\bash.exe -lc "pacman -Sy --noconfirm"
>     > +    - C:\tools\msys64\usr\bin\bash.exe -lc "pacman --needed
>     --noconfirm -S bash pacman pacman-mirrors msys2-runtime"
>     > +    - taskkill /F /IM gpg-agent.exe
>     > +    - C:\tools\msys64\usr\bin\bash.exe -lc "pacman --noconfirm -Su"
>     > +    - C:\tools\msys64\usr\bin\bash.exe -lc "sh
>     scripts/ci/windows/msys2_install.sh"
>     > +  script:
>     > +    C:\tools\msys64\usr\bin\bash.exe -lc "sh
>     scripts/ci/windows/msys2_build.sh"
>     > diff --git a/scripts/ci/windows/msys2_build.sh
>     b/scripts/ci/windows/msys2_build.sh
>     > new file mode 100644
>     > index 0000000000..0363ef402a
>     > --- /dev/null
>     > +++ b/scripts/ci/windows/msys2_build.sh
>     > @@ -0,0 +1,35 @@
>     > +export QEMU_DIR=$PWD
>     > +mkdir ../qemu-build
>     > +cd ../qemu-build
>     > +$QEMU_DIR/configure \
>     > +  --python=python3 \
>     > +  --cross-prefix=x86_64-w64-mingw32- \
> 
>     Isn't the prefix 'x86_64-w64-mingw32-gcc-'?
> 
> No, because of this:
> ```
> C:\CI-Tools\msys64\mingw64\bin>dir x86_64-w64-mingw32*
>  驱动器 C 中的卷是 系统
>  卷的序列号是 CAD5-8E95
> 
>  C:\CI-Tools\msys64\mingw64\bin 的目录
> 
> 2018/01/17  16:54            36,022 x86_64-w64-mingw32-agrep.exe
> 2020/09/02  05:06            67,861 x86_64-w64-mingw32-ar.exe
> 2020/09/02  05:06         2,872,225 x86_64-w64-mingw32-as.exe
> 2020/07/24  15:41         2,208,014 x86_64-w64-mingw32-c++.exe
> 2020/02/17  19:50           489,984 x86_64-w64-mingw32-captoinfo.exe
> 2020/02/17  19:50           348,160 x86_64-w64-mingw32-clear.exe
> 2020/06/26  17:21            64,176 x86_64-w64-mingw32-deflatehd.exe
> 2020/07/24  15:41         2,208,014 x86_64-w64-mingw32-g++.exe
> 2020/07/24  15:41         2,205,454 x86_64-w64-mingw32-gcc-10.2.0.exe
> 2020/07/24  15:41            67,861 x86_64-w64-mingw32-gcc-ar.exe
> 2020/07/24  15:41            67,861 x86_64-w64-mingw32-gcc-nm.exe
> 2020/07/24  15:41            67,861 x86_64-w64-mingw32-gcc-ranlib.exe
> 2020/07/24  15:41         2,205,454 x86_64-w64-mingw32-gcc.exe
> 2020/07/24  15:41         2,208,014 x86_64-w64-mingw32-gfortran.exe
> 2020/06/26  17:21            59,734 x86_64-w64-mingw32-inflatehd.exe
> 2020/02/17  19:50           462,848 x86_64-w64-mingw32-infocmp.exe
> 2020/02/17  19:50           489,984 x86_64-w64-mingw32-infotocap.exe
> 2020/09/02  05:06         2,773,229 x86_64-w64-mingw32-ld.exe
> 2020/09/02  05:06            67,861 x86_64-w64-mingw32-nm.exe
> 2020/09/02  05:06         2,367,282 x86_64-w64-mingw32-objcopy.exe
> 2017/03/22  14:58           669,355 x86_64-w64-mingw32-pkg-config.exe
> 2020/09/02  05:06            67,861 x86_64-w64-mingw32-ranlib.exe
> 2020/02/17  19:50           356,352 x86_64-w64-mingw32-reset.exe
> 2020/09/02  05:06             1,444 x86_64-w64-mingw32-sdl2-config
> 2020/09/02  05:06         2,367,282 x86_64-w64-mingw32-strip.exe
> 2020/02/17  19:50           348,160 x86_64-w64-mingw32-tabs.exe
> 2020/02/17  19:50           489,984 x86_64-w64-mingw32-tic.exe
> 2020/02/17  19:50           409,600 x86_64-w64-mingw32-toe.exe
> 2020/02/17  19:50           355,328 x86_64-w64-mingw32-tput.exe
> 2020/02/17  19:50           356,352 x86_64-w64-mingw32-tset.exe
> 2020/09/02  05:06         2,344,638 x86_64-w64-mingw32-windres.exe

So 'x86_64-w64-mingw32-' it is.

>               31 个文件     29,104,255 字节
>                0 个目录 203,338,362,880 可用字节
> ```
> 
> 
>     > +  --enable-gtk --enable-sdl \
>     > +  --enable-capstone=git \
>     > +  --enable-stack-protector \
>     > +  --ninja=ninja \
>     > +  --enable-gnutls \
>     > +  --enable-nettle \
>     > +  --enable-vnc \
>     > +  --enable-vnc-sasl \
>     > +  --enable-vnc-jpeg \
>     > +  --enable-vnc-png \
>     > +  --enable-membarrier \
>     > +  --enable-slirp=git \
>     > +  --disable-kvm \
>     > +  --enable-hax \
>     > +  --enable-whpx \
>     > +  --disable-spice \
>     > +  --enable-lzo \
>     > +  --enable-snappy \
>     > +  --enable-bzip2 \
>     > +  --enable-vdi \
>     > +  --enable-qcow1 \
>     > +  --enable-tools \
>     > +  --enable-libusb \
>     > +  --enable-usb-redir \
>     > +  --disable-libnfs \
>     > +  --enable-libssh \
>     > +  --disable-pie
>     > +make -j$NUMBER_OF_PROCESSORS
>     > +# make -j$NUMBER_OF_PROCESSORS check
>     > diff --git a/scripts/ci/windows/msys2_install.sh
>     b/scripts/ci/windows/msys2_install.sh
>     > new file mode 100644
>     > index 0000000000..3a5392cd99
>     > --- /dev/null
>     > +++ b/scripts/ci/windows/msys2_install.sh
>     > @@ -0,0 +1,41 @@
>     > +pacman --noconfirm -S --needed \
>     > +base-devel \
>     > +git \
>     > +mingw-w64-x86_64-python \
>     > +mingw-w64-x86_64-python-setuptools \
>     > +mingw-w64-x86_64-toolchain \
>     > +mingw-w64-x86_64-SDL2 \
>     > +mingw-w64-x86_64-SDL2_image \
>     > +mingw-w64-x86_64-gtk3 \
>     > +mingw-w64-x86_64-ninja \
>     > +mingw-w64-x86_64-make \
>     > +mingw-w64-x86_64-lzo2 \
>     > +mingw-w64-x86_64-libjpeg-turbo \
>     > +mingw-w64-x86_64-pixman \
>     > +mingw-w64-x86_64-libgcrypt \
>     > +mingw-w64-x86_64-capstone \
>     > +mingw-w64-x86_64-libpng \
>     > +mingw-w64-x86_64-libssh \
>     > +mingw-w64-x86_64-libxml2 \
>     > +mingw-w64-x86_64-snappy \
>     > +mingw-w64-x86_64-libusb \
>     > +mingw-w64-x86_64-usbredir \
>     > +mingw-w64-x86_64-libtasn1 \
>     > +mingw-w64-x86_64-libnfs \
>     > +mingw-w64-x86_64-nettle \
>     > +mingw-w64-x86_64-cyrus-sasl \
>     > +mingw-w64-x86_64-curl \
>     > +mingw-w64-x86_64-gnutls \
>     > +mingw-w64-x86_64-zstd \
>     > +mingw-w64-x86_64-glib2
>     > +
>     > +cd /mingw64/bin
>     > +cp x86_64-w64-mingw32-gcc-ar.exe x86_64-w64-mingw32-ar.exe
>     > +cp x86_64-w64-mingw32-gcc-ranlib.exe x86_64-w64-mingw32-ranlib.exe
>     > +cp x86_64-w64-mingw32-gcc-nm.exe x86_64-w64-mingw32-nm.exe
>     > +cp windres.exe x86_64-w64-mingw32-windres.exe
>     > +cp strip.exe x86_64-w64-mingw32-strip.exe
>     > +cp objcopy.exe x86_64-w64-mingw32-objcopy.exe
>     > +cp ld x86_64-w64-mingw32-ld.exe
>     > +cp as x86_64-w64-mingw32-as.exe
>     > +cp sdl2-config x86_64-w64-mingw32-sdl2-config
> 
>     Why is that needed?
> 
> Comes from configure 

I meant why do you need to copy? The toolchain installation path names
seem broken...

> ```
> 
> ar="${AR-${cross_prefix}ar}"
> as="${AS-${cross_prefix}as}"
> ccas="${CCAS-$cc}"
> cpp="${CPP-$cc -E}"
> objcopy="${OBJCOPY-${cross_prefix}objcopy}"
> ld="${LD-${cross_prefix}ld}"
> ranlib="${RANLIB-${cross_prefix}ranlib}"
> nm="${NM-${cross_prefix}nm}"
> strip="${STRIP-${cross_prefix}strip}"
> windres="${WINDRES-${cross_prefix}windres}"
> pkg_config_exe="${PKG_CONFIG-${cross_prefix}pkg-config}"
> query_pkg_config() {
>     "${pkg_config_exe}" ${QEMU_PKG_CONFIG_FLAGS} "$@"
> }
> pkg_config=query_pkg_config
> sdl2_config="${SDL2_CONFIG-${cross_prefix}sdl2-config}"
> 
> # If the user hasn't specified ARFLAGS, default to 'rv', just as make does.
> ARFLAGS="${ARFLAGS-rv}"
> ```
> 
>     Thanks,
> 
>     Phil.
> 
> 
> 
> -- 
>          此致
> 礼
> 罗勇刚
> Yours
>     sincerely,
> Yonggang Luo

