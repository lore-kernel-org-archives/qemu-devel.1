Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CFECC2BBD0
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 17:31:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA9BB20C56
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 17:31:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i+7EFqrZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA9BB20C56
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDWbK-0000yH-P0
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 13:31:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53048)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kDWaM-0008Ju-Ld
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 13:30:14 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:43131)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kDWaK-0003yc-Dc
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 13:30:14 -0400
Received: by mail-wr1-x444.google.com with SMTP id k15so228957wrn.10
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2020 10:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Ed3B6QdIoJsq8Si1+3+cM0I3Fw1gyOaCF1MRxJSc6PY=;
 b=i+7EFqrZ8N8wj51WZkROtRVAwknl7HyxU63pLz/xCoxKlPOJB5vlIRErjdr1HSM/QQ
 PgY7g1MNfiiS7Yk3B1lXFay1Xk6qkqndYsxJRVIBo3I6BgNwLfv+/irDPhFOSQ+P1kEv
 919bz9q48FuonGAS6clrfLalveDVMqfztkJAopFJYfiyRMComtCF9Gy9QDfdF2Gl7wmS
 MPm+zrWbZH2PBgLfIGSfuTEi5VG5FxiI+ZYwFkYG7s6YTl4WFECEPCiMoqsrQVNTbzc4
 FfqHxd7Qgo9ljEackmbI1O8DJf/fC0DxS4AolkiC9jqgtpO7SD7oZ0cps4N/Qnt5DCBI
 TlvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Ed3B6QdIoJsq8Si1+3+cM0I3Fw1gyOaCF1MRxJSc6PY=;
 b=V2U+Tcz3jx9XdGLXxEIhvq2QzH15SODvBEXefaM5YVTWErTJ0cRo1b7esyzfXKlIeT
 6cwHLi6a/GBD8QqzH1hX/hOCoGoUJX+0dXIYNdZbf+sXzETc6BdoaaYhsjtUAA24a21R
 oiJmAa+Hi8Yx5u5WG+eciEHoUy1wD0RVr7/LBIg2Rrs5H0cgRbsohZVgnrwMgDmPvlwl
 miorL0s+Sf4JsENZlNMmBt6rC+hiAdLr5avHCM1Umxx8XBfx0yWzG3eMMP3BaNGxv1LP
 Rc7/poX5Mv2QXG4HstRwOUWH9ybISay8JZcgyU9FeTtqpUYbYpaAGJ4k6HIa8ckZg3Ie
 b4bA==
X-Gm-Message-State: AOAM530UCZ9b835dm5fJckDc9W40Pz9bJxuwGiUeBs//ym2pt8AG50RJ
 LXyomG1zdQobdK/AU3ifSqY=
X-Google-Smtp-Source: ABdhPJysmYWpRplzA+r17jXNlJltCL14u62L7kd7BH4ardrgF9/09pl7wfjEbSXrxhNMLMG19Gr3BQ==
X-Received: by 2002:adf:ef0a:: with SMTP id e10mr8101073wro.362.1599067810880; 
 Wed, 02 Sep 2020 10:30:10 -0700 (PDT)
Received: from [192.168.1.36] (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id t203sm462850wmg.43.2020.09.02.10.30.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Sep 2020 10:30:09 -0700 (PDT)
Subject: Re: [PATCH 3/6] ci: Install msys2 in a proper way refer to
 https://github.com/cirruslabs/cirrus-ci-docs/issues/699 Enable msys2 ci in
 cirrus
To: Yonggang Luo <luoyonggang@gmail.com>, qemu-devel@nongnu.org
References: <20200902170054.810-1-luoyonggang@gmail.com>
 <20200902170054.810-4-luoyonggang@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <5cde63a0-46fe-2944-f96e-1f3268e49af8@amsat.org>
Date: Wed, 2 Sep 2020 19:30:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200902170054.810-4-luoyonggang@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/2/20 7:00 PM, Yonggang Luo wrote:
> ---
>  .cirrus.yml                         | 23 ++++++++++++++++
>  scripts/ci/windows/msys2_build.sh   | 35 ++++++++++++++++++++++++
>  scripts/ci/windows/msys2_install.sh | 41 +++++++++++++++++++++++++++++
>  3 files changed, 99 insertions(+)
>  create mode 100644 scripts/ci/windows/msys2_build.sh
>  create mode 100644 scripts/ci/windows/msys2_install.sh
> 
> diff --git a/.cirrus.yml b/.cirrus.yml
> index f287d23c5b..d377c28412 100644
> --- a/.cirrus.yml
> +++ b/.cirrus.yml
> @@ -40,3 +40,26 @@ macos_xcode_task:
>      - ../configure --cc=clang || { cat config.log; exit 1; }
>      - gmake -j$(sysctl -n hw.ncpu)
>      - gmake check
> +
> +windows_msys2_task:
> +  windows_container:
> +    image: cirrusci/windowsservercore:cmake
> +    os_version: 2019
> +    cpu: 8
> +    memory: 8G
> +  env:
> +    MSYS: winsymlinks:nativestrict
> +    MSYSTEM: MINGW64
> +    CHERE_INVOKING: 1
> +  printenv_script: C:\tools\msys64\usr\bin\bash.exe -lc 'printenv'
> +  install_script:
> +    - C:\tools\msys64\usr\bin\bash.exe -lc "cd /c/tools && curl -O http://repo.msys2.org/msys/x86_64/msys2-keyring-r21.b39fb11-1-any.pkg.tar.xz"
> +    - C:\tools\msys64\usr\bin\bash.exe -lc "cd /c/tools && curl -O http://repo.msys2.org/msys/x86_64/msys2-keyring-r21.b39fb11-1-any.pkg.tar.xz.sig"
> +    - C:\tools\msys64\usr\bin\bash.exe -lc "cd /c/tools && pacman -U --noconfirm msys2-keyring-r21.b39fb11-1-any.pkg.tar.xz"
> +    - C:\tools\msys64\usr\bin\bash.exe -lc "pacman -Sy --noconfirm"
> +    - C:\tools\msys64\usr\bin\bash.exe -lc "pacman --needed --noconfirm -S bash pacman pacman-mirrors msys2-runtime"
> +    - taskkill /F /IM gpg-agent.exe
> +    - C:\tools\msys64\usr\bin\bash.exe -lc "pacman --noconfirm -Su"
> +    - C:\tools\msys64\usr\bin\bash.exe -lc "sh scripts/ci/windows/msys2_install.sh"
> +  script:
> +    C:\tools\msys64\usr\bin\bash.exe -lc "sh scripts/ci/windows/msys2_build.sh"
> diff --git a/scripts/ci/windows/msys2_build.sh b/scripts/ci/windows/msys2_build.sh
> new file mode 100644
> index 0000000000..0363ef402a
> --- /dev/null
> +++ b/scripts/ci/windows/msys2_build.sh
> @@ -0,0 +1,35 @@
> +export QEMU_DIR=$PWD
> +mkdir ../qemu-build
> +cd ../qemu-build
> +$QEMU_DIR/configure \
> +  --python=python3 \
> +  --cross-prefix=x86_64-w64-mingw32- \

Isn't the prefix 'x86_64-w64-mingw32-gcc-'?

> +  --enable-gtk --enable-sdl \
> +  --enable-capstone=git \
> +  --enable-stack-protector \
> +  --ninja=ninja \
> +  --enable-gnutls \
> +  --enable-nettle \
> +  --enable-vnc \
> +  --enable-vnc-sasl \
> +  --enable-vnc-jpeg \
> +  --enable-vnc-png \
> +  --enable-membarrier \
> +  --enable-slirp=git \
> +  --disable-kvm \
> +  --enable-hax \
> +  --enable-whpx \
> +  --disable-spice \
> +  --enable-lzo \
> +  --enable-snappy \
> +  --enable-bzip2 \
> +  --enable-vdi \
> +  --enable-qcow1 \
> +  --enable-tools \
> +  --enable-libusb \
> +  --enable-usb-redir \
> +  --disable-libnfs \
> +  --enable-libssh \
> +  --disable-pie
> +make -j$NUMBER_OF_PROCESSORS
> +# make -j$NUMBER_OF_PROCESSORS check
> diff --git a/scripts/ci/windows/msys2_install.sh b/scripts/ci/windows/msys2_install.sh
> new file mode 100644
> index 0000000000..3a5392cd99
> --- /dev/null
> +++ b/scripts/ci/windows/msys2_install.sh
> @@ -0,0 +1,41 @@
> +pacman --noconfirm -S --needed \
> +base-devel \
> +git \
> +mingw-w64-x86_64-python \
> +mingw-w64-x86_64-python-setuptools \
> +mingw-w64-x86_64-toolchain \
> +mingw-w64-x86_64-SDL2 \
> +mingw-w64-x86_64-SDL2_image \
> +mingw-w64-x86_64-gtk3 \
> +mingw-w64-x86_64-ninja \
> +mingw-w64-x86_64-make \
> +mingw-w64-x86_64-lzo2 \
> +mingw-w64-x86_64-libjpeg-turbo \
> +mingw-w64-x86_64-pixman \
> +mingw-w64-x86_64-libgcrypt \
> +mingw-w64-x86_64-capstone \
> +mingw-w64-x86_64-libpng \
> +mingw-w64-x86_64-libssh \
> +mingw-w64-x86_64-libxml2 \
> +mingw-w64-x86_64-snappy \
> +mingw-w64-x86_64-libusb \
> +mingw-w64-x86_64-usbredir \
> +mingw-w64-x86_64-libtasn1 \
> +mingw-w64-x86_64-libnfs \
> +mingw-w64-x86_64-nettle \
> +mingw-w64-x86_64-cyrus-sasl \
> +mingw-w64-x86_64-curl \
> +mingw-w64-x86_64-gnutls \
> +mingw-w64-x86_64-zstd \
> +mingw-w64-x86_64-glib2
> +
> +cd /mingw64/bin
> +cp x86_64-w64-mingw32-gcc-ar.exe x86_64-w64-mingw32-ar.exe
> +cp x86_64-w64-mingw32-gcc-ranlib.exe x86_64-w64-mingw32-ranlib.exe
> +cp x86_64-w64-mingw32-gcc-nm.exe x86_64-w64-mingw32-nm.exe
> +cp windres.exe x86_64-w64-mingw32-windres.exe
> +cp strip.exe x86_64-w64-mingw32-strip.exe
> +cp objcopy.exe x86_64-w64-mingw32-objcopy.exe
> +cp ld x86_64-w64-mingw32-ld.exe
> +cp as x86_64-w64-mingw32-as.exe
> +cp sdl2-config x86_64-w64-mingw32-sdl2-config

Why is that needed?

Thanks,

Phil.

