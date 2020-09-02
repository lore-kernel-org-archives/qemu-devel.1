Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B945AC433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 18:55:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76C90206C0
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 18:55:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76C90206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51032 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDXvA-0002yV-FB
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 14:55:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43876)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1kDXuU-0002Ni-4r
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 14:55:06 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167]:52150
 helo=mail.default.ilande.uk0.bigv.io)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1kDXuR-0006ON-Rk
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 14:55:05 -0400
Received: from host86-148-246-76.range86-148.btcentralplus.com
 ([86.148.246.76] helo=[192.168.1.65])
 by mail.default.ilande.uk0.bigv.io with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.92)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1kDXut-0001Nt-NY; Wed, 02 Sep 2020 19:55:36 +0100
To: luoyonggang@gmail.com, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <f4bug@amsat.org>
References: <20200902170054.810-1-luoyonggang@gmail.com>
 <20200902170054.810-4-luoyonggang@gmail.com>
 <5cde63a0-46fe-2944-f96e-1f3268e49af8@amsat.org>
 <CAE2XoE8bsq7jzbw6FMW3TybhQGiNEJ-F_NKPm3LHzkHm69hSdw@mail.gmail.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Autocrypt: addr=mark.cave-ayland@ilande.co.uk; keydata=
 mQENBFQJuzwBCADAYvxrwUh1p/PvUlNFwKosVtVHHplgWi5p29t58QlOUkceZG0DBYSNqk93
 3JzBTbtd4JfFcSupo6MNNOrCzdCbCjZ64ik8ycaUOSzK2tKbeQLEXzXoaDL1Y7vuVO7nL9bG
 E5Ru3wkhCFc7SkoypIoAUqz8EtiB6T89/D9TDEyjdXUacc53R5gu8wEWiMg5MQQuGwzbQy9n
 PFI+mXC7AaEUqBVc2lBQVpAYXkN0EyqNNT12UfDLdxaxaFpUAE2pCa2LTyo5vn5hEW+i3VdN
 PkmjyPvL6DdY03fvC01PyY8zaw+UI94QqjlrDisHpUH40IUPpC/NB0LwzL2aQOMkzT2NABEB
 AAG0ME1hcmsgQ2F2ZS1BeWxhbmQgPG1hcmsuY2F2ZS1heWxhbmRAaWxhbmRlLmNvLnVrPokB
 OAQTAQIAIgUCVAm7PAIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQW8LFb64PMh9f
 NAgAuc3ObOEY8NbZko72AGrg2tWKdybcMVITxmcor4hb9155o/OWcA4IDbeATR6cfiDL/oxU
 mcmtXVgPqOwtW3NYAKr5g/FrZZ3uluQ2mtNYAyTFeALy8YF7N3yhs7LOcpbFP7tEbkSzoXNG
 z8iYMiYtKwttt40WaheWuRs0ZOLbs6yoczZBDhna3Nj0LA3GpeJKlaV03O4umjKJgACP1c/q
 T2Pkg+FCBHHFP454+waqojHp4OCBo6HyK+8I4wJRa9Z0EFqXIu8lTDYoggeX0Xd6bWeCFHK3
 DhD0/Xi/kegSW33unsp8oVcM4kcFxTkpBgj39dB4KwAUznhTJR0zUHf63LkBDQRUCbs8AQgA
 y7kyevA4bpetM/EjtuqQX4U05MBhEz/2SFkX6IaGtTG2NNw5wbcAfhOIuNNBYbw6ExuaJ3um
 2uLseHnudmvN4VSJ5Hfbd8rhqoMmmO71szgT/ZD9MEe2KHzBdmhmhxJdp+zQNivy215j6H27
 14mbC2dia7ktwP1rxPIX1OOfQwPuqlkmYPuVwZP19S4EYnCELOrnJ0m56tZLn5Zj+1jZX9Co
 YbNLMa28qsktYJ4oU4jtn6V79H+/zpERZAHmH40IRXdR3hA+Ye7iC/ZpWzT2VSDlPbGY9Yja
 Sp7w2347L5G+LLbAfaVoejHlfy/msPeehUcuKjAdBLoEhSPYzzdvEQARAQABiQEfBBgBAgAJ
 BQJUCbs8AhsMAAoJEFvCxW+uDzIfabYIAJXmBepHJpvCPiMNEQJNJ2ZSzSjhic84LTMWMbJ+
 opQgr5cb8SPQyyb508fc8b4uD8ejlF/cdbbBNktp3BXsHlO5BrmcABgxSP8HYYNsX0n9kERv
 NMToU0oiBuAaX7O/0K9+BW+3+PGMwiu5ml0cwDqljxfVN0dUBZnQ8kZpLsY+WDrIHmQWjtH+
 Ir6VauZs5Gp25XLrL6bh/SL8aK0BX6y79m5nhfKI1/6qtzHAjtMAjqy8ChPvOqVVVqmGUzFg
 KPsrrIoklWcYHXPyMLj9afispPVR8e0tMKvxzFBWzrWX1mzljbBlnV2n8BIwVXWNbgwpHSsj
 imgcU9TTGC5qd9g=
Message-ID: <19b8d23c-c2e7-2d8e-50de-a4e977bae786@ilande.co.uk>
Date: Wed, 2 Sep 2020 19:54:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAE2XoE8bsq7jzbw6FMW3TybhQGiNEJ-F_NKPm3LHzkHm69hSdw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.148.246.76
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH 3/6] ci: Install msys2 in a proper way refer to
 https://github.com/cirruslabs/cirrus-ci-docs/issues/699 Enable msys2 ci in
 cirrus
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.default.ilande.uk0.bigv.io)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk;
 helo=mail.default.ilande.uk0.bigv.io
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.324,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 02/09/2020 18:50, 罗勇刚(Yonggang Luo) wrote:

> On Thu, Sep 3, 2020 at 1:30 AM Philippe Mathieu-Daudé <f4bug@amsat.org
> <mailto:f4bug@amsat.org>> wrote:
> 
>     On 9/2/20 7:00 PM, Yonggang Luo wrote:
>     > ---
>     >  .cirrus.yml                         | 23 ++++++++++++++++
>     >  scripts/ci/windows/msys2_build.sh   | 35 ++++++++++++++++++++++++
>     >  scripts/ci/windows/msys2_install.sh | 41 +++++++++++++++++++++++++++++
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
>     > +    - C:\tools\msys64\usr\bin\bash.exe -lc "cd /c/tools && curl -O
>     http://repo.msys2.org/msys/x86_64/msys2-keyring-r21.b39fb11-1-any.pkg.tar.xz"
>     > +    - C:\tools\msys64\usr\bin\bash.exe -lc "cd /c/tools && curl -O
>     http://repo.msys2.org/msys/x86_64/msys2-keyring-r21.b39fb11-1-any.pkg.tar.xz.sig"
>     > +    - C:\tools\msys64\usr\bin\bash.exe -lc "cd /c/tools && pacman -U
>     --noconfirm msys2-keyring-r21.b39fb11-1-any.pkg.tar.xz"
>     > +    - C:\tools\msys64\usr\bin\bash.exe -lc "pacman -Sy --noconfirm"
>     > +    - C:\tools\msys64\usr\bin\bash.exe -lc "pacman --needed --noconfirm -S
>     bash pacman pacman-mirrors msys2-runtime"
>     > +    - taskkill /F /IM gpg-agent.exe
>     > +    - C:\tools\msys64\usr\bin\bash.exe -lc "pacman --noconfirm -Su"
>     > +    - C:\tools\msys64\usr\bin\bash.exe -lc "sh
>     scripts/ci/windows/msys2_install.sh"
>     > +  script:
>     > +    C:\tools\msys64\usr\bin\bash.exe -lc "sh scripts/ci/windows/msys2_build.sh"
>     > diff --git a/scripts/ci/windows/msys2_build.sh b/scripts/ci/windows/msys2_build.sh
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
>     Thanks,
> 
>     Phil.
> 
> Hi, I am looking for suggestion for building  with msys2, this is comes from wiki, if
> you have better idea, then tell me.
> 
> https://wiki.qemu.org/Hosts/W32#Native_builds_with_MSYS2 

FWIW I did a clean install of MSYS2 after the meson changes were merged and it seems
to make things a bit simpler for Windows. Once Paolo's latest PR has been applied you
should be able to do the following (from my notes for PPC builds):

# As per https://www.msys2.org/
pacman -Syu
pacman -Su

# QEMU build environment
pacman -S \
  base-devel \
  mingw-w64-x86_64-toolchain \
  git \
  mingw64/mingw-w64-x86_64-python3 \
  mingw64/mingw-w64-x86_64-python-setuptools \
  mingw64/mingw-w64-x86_64-ninja

# Basic GTK/SDL build
pacman -S \
  mingw-w64-x86_64-glib2 \
  mingw64/mingw-w64-x86_64-gtk3 \
  mingw64/mingw-w64-x86_64-SDL2

# Build
./configure --target-list="ppc-softmmu" --ninja=ninja
make -j6

That should be enough to get a basic working Windows build with GTK/SDL2 UI, although
I see you've added a lot more options.


ATB,

Mark.

