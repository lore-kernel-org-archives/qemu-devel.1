Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEC95C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 07:31:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A02612076C
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 07:31:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gAIy+6oM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A02612076C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2rQ5-0003VW-QL
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 03:31:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40452)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k2rOV-0002YN-T5
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 03:29:56 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:54816)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k2rOT-0001Ag-LB
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 03:29:55 -0400
Received: by mail-wm1-x343.google.com with SMTP id d190so1698367wmd.4
 for <qemu-devel@nongnu.org>; Tue, 04 Aug 2020 00:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=C2KdyQOxedA9bLlMRbqpEFb3kNUly4/ATOb9RLKOmfg=;
 b=gAIy+6oMB61fifgG0oMGTxy5isRQm8KaMqYV7cm1VRWbBPWNktfvSEASbC5q2dqbwE
 seOmr0K1xN4a2rKxn3jOF7EYOuYhU12BC3rOmEZ/0bOKmY+sDKjiJh4UEQ9C6fkTpP3b
 haaYqZj30pwqHvB+oQ7P5WtmOdqNoIiGXOjmeIVGRmNZhtKX69Nr51t2pd+w6k8YK/jR
 lzaZEXgRDRrFgen7mzN65cEWQeaaGV9ecw4SNVY/jTzP4BuOdgkk0Be2ads0KWMHKm+K
 DN13wxh7nXebMjUDF7NV1DZ1R46xETiPkqI0xlGz8FRTpeA/X6CDWMy6AATh6QWvD7ZV
 olYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=C2KdyQOxedA9bLlMRbqpEFb3kNUly4/ATOb9RLKOmfg=;
 b=Oc2iQVvij0ocdOcd/TrSGznTK7Qi9ZK7UojSp02neq8IUnKVxaPejzTh3dUwdGnxoJ
 AcxnTNA0jGN3Nhh74psykL/crAY1MtPaiLfHu+sgtwj/UIycO8VsGi1XjYtkD6l4OjAd
 QGcO8Q/ueQfI2nqOYVaEwrgHrnnX+AkXgZyKXHMyJayNuVl6fiDAV9kw2KRl6t+NPizV
 Yz+NWjZ2qFD9ALcK53fjs4XwH6NZ9x0Y0+H4643Gxj05XeBnxvrTHoVGc6TBGqtoWhQ4
 8fgPpUQGrDlv4lFv56dGDG44zQ0Su/+g462HbTe8Qrvy6Zb4BiPn1IFY7pb8swzIlGxn
 fD5g==
X-Gm-Message-State: AOAM531uZdNUXlS2thIcIoApDcBDKiqXyT7KlENcJdMk+cDn2+9XsElB
 hvOzgQZBISfUeACb+lxYxrU=
X-Google-Smtp-Source: ABdhPJyOJ1ApBpxcOuuaqmvLRXnaalcv7qdKXTXgGhV0xAhUbnwolAZjxQkCYmBwgpI3QFx8bIuADg==
X-Received: by 2002:a1c:6007:: with SMTP id u7mr2853806wmb.32.1596526191533;
 Tue, 04 Aug 2020 00:29:51 -0700 (PDT)
Received: from [192.168.1.43] (214.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.214])
 by smtp.gmail.com with ESMTPSA id h13sm29996767wrx.17.2020.08.04.00.29.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Aug 2020 00:29:50 -0700 (PDT)
Subject: Re: [PATCH for-5.1] Add GitHub action for Windows build
To: Stefan Weil <sw@weilnetz.de>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20200803202042.1869013-1-sw@weilnetz.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <5373338e-0be6-83f4-e370-d693a06ce26b@amsat.org>
Date: Tue, 4 Aug 2020 09:29:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200803202042.1869013-1-sw@weilnetz.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/3/20 10:20 PM, Stefan Weil wrote:
> The GitHub action is restricted to https://github.com/qemu/qemu.
> 
> Signed-off-by: Stefan Weil <sw@weilnetz.de>
> ---
> 
> This patch adds a GitHub action for continuous integration builds
> of QEMU for Windows.

Thanks for this!

> 
> The CI builds run on GitHub and include the WHPX code.
> The action rules avoid unnecessary waste of resources by
> limiting the GitHub action to the official mirror.
> 
> Peter, maybe this can still be added to 5.1.
> There should be no risk as it only adds the GitHub action.
> 
> Regards,
> Stefan
> 
> 
>  .github/workflows/build.sh                | 112 ++++++++++++++++++++++
>  .github/workflows/pkg-config-crosswrapper |  37 +++++++
>  .github/workflows/win.yml                 |  34 +++++++

This misses the MAINTAINERS entry:

-- >8 --
diff --git a/MAINTAINERS b/MAINTAINERS
index 0886eb3d2b..e64315265e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3068,6 +3068,12 @@ R: Wainer dos Santos Moschetta <wainersm@redhat.com>
 S: Maintained
 F: .gitlab-ci.yml

+GitHub actions (Windows installer)
+M: Stefan Weil <sw@weilnetz.de>
+M: Sunil Muthuswamy <sunilmut@microsoft.com>
+S: Maintained
+F: .github/workflows/
+
 Guest Test Compilation Support
 M: Alex Bennée <alex.bennee@linaro.org>
 R: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
>  3 files changed, 183 insertions(+)
>  create mode 100755 .github/workflows/build.sh
>  create mode 100755 .github/workflows/pkg-config-crosswrapper
>  create mode 100644 .github/workflows/win.yml
> 
> diff --git a/.github/workflows/build.sh b/.github/workflows/build.sh
> new file mode 100755
> index 0000000000..c430a367be
> --- /dev/null
> +++ b/.github/workflows/build.sh
> @@ -0,0 +1,112 @@
> +#!/bin/bash
> +
> +# GitHub actions - Create QEMU installer for Windows
> +
> +# Author: Stefan Weil (2020)
> +
> +#~ set -e
> +set -x
> +
> +ARCH=$1
> +DLLS="libgcc_s_sjlj-1.dll libgomp-1.dll libstdc++-6.dll"
> +
> +if test "$ARCH" != "i686"; then
> +  ARCH=x86_64
> +  DLLS="libgcc_s_seh-1.dll libgomp-1.dll libstdc++-6.dll"
> +fi
> +
> +ROOTDIR=$PWD
> +DISTDIR=$ROOTDIR/dist
> +HOST=$ARCH-w64-mingw32
> +BUILDDIR=bin/ndebug/$HOST
> +PKG_ARCH=mingw64-${ARCH/_/-}
> +
> +# Install cygwin key and add cygwin sources.
> +curl -s https://qemu.weilnetz.de/debian/gpg.key | sudo apt-key add -
> +echo deb https://qemu.weilnetz.de/debian/ testing contrib | \
> +  sudo tee /etc/apt/sources.list.d/cygwin.list
> +
> +# Install packages.
> +sudo apt-get update
> +sudo apt-get install --no-install-recommends \
> +  mingw-w64-tools nsis \
> +  gcc libc6-dev \
> +  g++-mingw-w64-${ARCH/_/-} gcc-mingw-w64-${ARCH/_/-} \
> +  bison flex gettext python3-sphinx texinfo \
> +  $PKG_ARCH-adwaita-icon-theme $PKG_ARCH-cogl $PKG_ARCH-curl \
> +  $PKG_ARCH-gmp $PKG_ARCH-gnutls $PKG_ARCH-gtk3 $PKG_ARCH-icu \
> +  $PKG_ARCH-libxml2 $PKG_ARCH-ncurses $PKG_ARCH-sdl2 $PKG_ARCH-usbredir
> +
> +# Workaround for buggy cross pkg-config.
> +sudo ln -sf $PWD/.github/workflows/pkg-config-crosswrapper \
> +  /usr/bin/$HOST-pkg-config
> +
> +# Get header files for WHPX API from Mingw-w64 git master.
> +(
> +sudo mkdir -p /usr/$HOST/sys-include
> +cd /usr/$HOST/sys-include
> +SF_URLBASE=https://sourceforge.net
> +URL=$SF_URLBASE/p/mingw-w64/mingw-w64/ci/master/tree/mingw-w64-headers/include
> +sudo curl -s -o winhvemulation.h $URL/winhvemulation.h?format=raw
> +sudo curl -s -o winhvplatform.h $URL/winhvplatform.h?format=raw
> +sudo curl -s -o winhvplatformdefs.h $URL/winhvplatformdefs.h?format=raw
> +sudo ln -s winhvemulation.h WinHvEmulation.h
> +sudo ln -s winhvplatform.h WinHvPlatform.h
> +sudo ln -s winhvplatformdefs.h WinHvPlatformDefs.h
> +)
> +
> +DLL_PATH=$PWD/dll/$HOST
> +
> +mkdir -p $DISTDIR
> +mkdir -p $DLL_PATH
> +
> +for dll in $DLLS; do
> +  ln -sf /usr/lib/gcc/$HOST/*-win32/$dll $DLL_PATH
> +done
> +
> +DLLS="iconv.dll libatk-1.0-0.dll libbz2-1.dll"
> +DLLS="$DLLS libcairo-2.dll libcairo-gobject-2.dll libcurl-4.dll"
> +DLLS="$DLLS libeay32.dll libepoxy-0.dll libexpat-1.dll"
> +DLLS="$DLLS libffi-6.dll libfontconfig-1.dll libfreetype-6.dll"
> +DLLS="$DLLS libgdk-3-0.dll libgdk_pixbuf-2.0-0.dll"
> +DLLS="$DLLS libgio-2.0-0.dll libglib-2.0-0.dll libgmodule-2.0-0.dll"
> +DLLS="$DLLS libgmp-10.dll libgnutls-30.dll libgobject-2.0-0.dll libgtk-3-0.dll"
> +DLLS="$DLLS libharfbuzz-0.dll libhogweed-4.dll libidn2-0.dll libintl-8.dll"
> +DLLS="$DLLS libjpeg-8.dll liblzo2-2.dll"
> +DLLS="$DLLS libncursesw6.dll libnettle-6.dll libnghttp2-14.dll"
> +DLLS="$DLLS libp11-kit-0.dll libpango-1.0-0.dll libpangocairo-1.0-0.dll"
> +DLLS="$DLLS libpangoft2-1.0-0.dll libpangowin32-1.0-0.dll libpcre-1.dll"
> +DLLS="$DLLS libpixman-1-0.dll libpng16-16.dll libssh2-1.dll libtasn1-6.dll"
> +DLLS="$DLLS libunistring-2.dll libusb-1.0.dll libusbredirparser-1.dll"
> +DLLS="$DLLS SDL2.dll ssleay32.dll zlib1.dll"
> +
> +for dll in $DLLS; do
> +  ln -sf /usr/$HOST/sys-root/mingw/bin/$dll $DLL_PATH
> +done
> +
> +ln -sf /usr/$HOST/lib/libwinpthread-1.dll $DLL_PATH
> +
> +# Build QEMU installer.
> +
> +echo Building $HOST...
> +mingw=/usr/$HOST/sys-root/mingw
> +mkdir -p $BUILDDIR && cd $BUILDDIR
> +
> +# Run configure.
> +../../../configure --cross-prefix=$HOST- --disable-guest-agent-msi \
> +    --disable-werror --enable-whpx \
> +    --extra-cflags="-I $mingw/include" \
> +    --extra-ldflags="-L $mingw/lib"
> +
> +# Add config.log to build artifacts.
> +cp config.log $DISTDIR/
> +
> +make
> +
> +echo Building installers...
> +date=$(date +%Y%m%d)
> +INSTALLER=$DISTDIR/qemu-$ARCH-setup-$date.exe
> +make installer DLL_PATH=$DLL_PATH SIGNCODE=true INSTALLER=$INSTALLER
> +
> +echo Calculate SHA-512 checksum...
> +(cd $DISTDIR; exe=$(basename $INSTALLER); sha512sum $exe >${exe/exe/sha512})
> diff --git a/.github/workflows/pkg-config-crosswrapper b/.github/workflows/pkg-config-crosswrapper
> new file mode 100755
> index 0000000000..768e554194
> --- /dev/null
> +++ b/.github/workflows/pkg-config-crosswrapper
> @@ -0,0 +1,37 @@
> +#! /bin/sh
> +# pkg-config wrapper for cross-building
> +# Sets pkg-config search path to search multiarch and historical cross-compiling paths.
> +
> +# If the user has already set PKG_CONFIG_LIBDIR, believe it (even if empty):
> +# it's documented to be an override
> +if [ x"${PKG_CONFIG_LIBDIR+set}" = x ]; then
> +  # GNU triplet for the compiler, e.g. i486-linux-gnu for Debian i386,
> +  # i686-linux-gnu for Ubuntu i386
> +  basename="${0##*/}"
> +  triplet="${basename%-pkg-config}"
> +  # Normalized multiarch path if any, e.g. i386-linux-gnu for i386
> +  multiarch="`dpkg-architecture -t"${triplet}" -qDEB_HOST_MULTIARCH 2>/dev/null`"
> +
> +  PKG_CONFIG_LIBDIR="/usr/local/${triplet}/lib/pkgconfig"
> +  # For a native build we would also want to append /usr/local/lib/pkgconfig
> +  # at this point; but this is a cross-building script, so don't
> +  PKG_CONFIG_LIBDIR="$PKG_CONFIG_LIBDIR:/usr/local/share/pkgconfig"
> +
> +  if [ -n "$multiarch" ]; then
> +    PKG_CONFIG_LIBDIR="/usr/local/lib/${multiarch}/pkgconfig:$PKG_CONFIG_LIBDIR"
> +    PKG_CONFIG_LIBDIR="$PKG_CONFIG_LIBDIR:/usr/lib/${multiarch}/pkgconfig"
> +  fi
> +
> +  PKG_CONFIG_LIBDIR="$PKG_CONFIG_LIBDIR:/usr/${triplet}/lib/pkgconfig"
> +  # For a native build we would also want to append /usr/lib/pkgconfig
> +  # at this point; but this is a cross-building script, so don't
> +  # If you want to allow use of un-multiarched -dev packages for crossing
> +  # (at the risk of finding build-arch stuff you didn't want, if not in a clean chroot)
> +  # Uncomment the next line:
> +  # PKG_CONFIG_LIBDIR="$PKG_CONFIG_LIBDIR:/usr/lib/pkgconfig"
> +  PKG_CONFIG_LIBDIR="$PKG_CONFIG_LIBDIR:/usr/share/pkgconfig"
> +
> +  export PKG_CONFIG_LIBDIR
> +fi
> +
> +exec pkg-config "$@"
> diff --git a/.github/workflows/win.yml b/.github/workflows/win.yml
> new file mode 100644
> index 0000000000..81cf48530f
> --- /dev/null
> +++ b/.github/workflows/win.yml
> @@ -0,0 +1,34 @@
> +# GitHub actions - Create QEMU installers for Windows
> +
> +# The action is restricted to https://github.com/qemu/qemu.
> +# That avoids an unnecessary waste of resources when each fork
> +# runs the action, too.
> +
> +name: Cross build for Windows
> +
> +on: [push]
> +
> +jobs:
> +  build32:
> +    if: github.repository == 'qemu/qemu'
> +    runs-on: [ubuntu-20.04]

Since it is based on Ubuntu, we should be able to run it on GitLab
directly (and simplifies our CI). Also we could drop the Shippable
docker images too.

This works, so:
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

But I'm not keen on not using GitLab instead.

The only point I see of using GitHub/Azureus is if we then install
and run testing in the Windows Server 2019 environment:

https://docs.github.com/en/actions/reference/workflow-syntax-for-github-actions#jobsjob_idruns-on

> +    steps:
> +    - uses: actions/checkout@v2
> +    - name: Build QEMU installer (32 bit)
> +      run: .github/workflows/build.sh i686
> +    - uses: actions/upload-artifact@v1
> +      with:
> +        name: QEMU Installer Windows 32 bit
> +        path: dist
> +
> +  build64:
> +    if: github.repository == 'qemu/qemu'
> +    runs-on: [ubuntu-20.04]
> +    steps:
> +    - uses: actions/checkout@v2
> +    - name: Build QEMU installer (64 bit)
> +      run: .github/workflows/build.sh x86_64
> +    - uses: actions/upload-artifact@v1
> +      with:
> +        name: QEMU Installer Windows 64 bit
> +        path: dist
> 


