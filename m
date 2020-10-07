Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF423C4363D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 11:01:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2561F2080A
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 11:01:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uh/azKsw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2561F2080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQ7C5-0001Ip-Ti
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 07:01:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50190)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kQ79I-0006l7-6w; Wed, 07 Oct 2020 06:58:20 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:45465)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kQ79F-0002Td-5R; Wed, 07 Oct 2020 06:58:19 -0400
Received: by mail-lj1-x241.google.com with SMTP id a4so1480234lji.12;
 Wed, 07 Oct 2020 03:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=Bsiq4A0rv0CJfSnIL3jJRUQHoWgqxlRR1XbDsT6060w=;
 b=uh/azKswi5ldUW8RBGZzSWQ8Ujr8+b4bTRTTu8BZPLdDROf5Ce6eDoRoWohgzohCTZ
 ntmB77sPrqeS4NY+5LMxotM3+bBS2Ux6K1eroaJImNfJjDFR9UNMCL07RCn++SWCCKjq
 ce3ruWD8ugqMJcLoASsqmaWJzyuLQWzQSwOwYLdOAVBts4rmgJFxBHv1CGoD4cMY20AD
 sIfpCGwxEYobp8hy9G6zCZn89nLH/Aewjpa9JS4pAfoIpZfcfM2PlspKkB5sDJKayG+o
 nA8VDxgrfvIM+AgG9fdSy7DUlxj9dC3MvXbL561DQsSRcYj90HGrKzfK6EJDXfd7RP31
 trNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=Bsiq4A0rv0CJfSnIL3jJRUQHoWgqxlRR1XbDsT6060w=;
 b=UtIcgYbpM9DfQhmESGilpzB5gnsSepHd7RPfh/OioaWrVdFGKlhyjmRdrX1P7EpEz/
 CXhhI9rwL/Qr6Z+TXMaTXzCC0p2j0sFbn0mGISO4LGHTo6I/fXJr7uomJT//YlRYS4ds
 TsRPvzAh5mYKZhMcfXDMVg/IkQAbxY/oiAp2hyJcI5ZCg6tWkQuaTtGMxXzoKuKmM6/b
 FkQpamk0y3aijiswnq2Ip0jOaUre6vhcZlEGOkBaA84MPwEmeCZD1s09CQ65/vbwSOsr
 /PWXbADWq6kcOeFY4+LrrEyUWZwH9TK+JJekTbqJig7B4bRQSH0usQwNuJBKviDaecQ0
 QXyQ==
X-Gm-Message-State: AOAM531PPgLTqs062cl/THQrc6IGTsRvGavNdd7o+mDaQVfrDNMMvRS0
 2gAwZxE+QsFQutnkT+4yxqZ8uClTc9YId6d1kF8nAASpkI+VAg==
X-Google-Smtp-Source: ABdhPJykZw7BUVwVT3c8NqNwuEFUDu9GeRiPsgpsxziS6nqey6T63BhYZJweuDf5VKBy/A7GRIyKdKUoxn6J8o8KoxE=
X-Received: by 2002:a2e:89d6:: with SMTP id c22mr1055556ljk.242.1602068293988; 
 Wed, 07 Oct 2020 03:58:13 -0700 (PDT)
MIME-Version: 1.0
References: <20201007105518.1019-1-luoyonggang@gmail.com>
 <20201007105518.1019-2-luoyonggang@gmail.com>
In-Reply-To: <20201007105518.1019-2-luoyonggang@gmail.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Wed, 7 Oct 2020 18:58:01 +0800
Message-ID: <CAE2XoE8+1D_xvf_jXeqSU+0zkPunCna0QADROkf2wpja5f7h_Q@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] cirrus: Fixing and speedup the msys2/mingw CI
To: qemu-level <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="00000000000091b85705b112975a"
Received-SPF: pass client-ip=2a00:1450:4864:20::241;
 envelope-from=luoyonggang@gmail.com; helo=mail-lj1-x241.google.com
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000091b85705b112975a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The building result are at
https://cirrus-ci.com/task/4899553256144896

On Wed, Oct 7, 2020 at 6:55 PM Yonggang Luo <luoyonggang@gmail.com> wrote:
>
> Use cache of cirrus caching msys2
> The install of msys2 are refer to https://github.com/msys2/setup-msys2
> The first time install msys2 would be time consuming, so increase
timeout_in to 90m
> according to https://cirrus-ci.org/faq/#instance-timed-out
>
> Apply patch of
https://lists.gnu.org/archive/html/qemu-devel/2020-10/msg00072.html
>
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> ---
>  .cirrus.yml | 104 +++++++++++++++++++++++++++++-----------------------
>  1 file changed, 59 insertions(+), 45 deletions(-)
>
> diff --git a/.cirrus.yml b/.cirrus.yml
> index d58782ce67..b58fb63521 100644
> --- a/.cirrus.yml
> +++ b/.cirrus.yml
> @@ -46,64 +46,78 @@ macos_xcode_task:
>      - gmake check
>
>  windows_msys2_task:
> +  timeout_in: 90m
>    windows_container:
> -    image: cirrusci/windowsservercore:cmake
> +    image: cirrusci/windowsservercore:2019
>      os_version: 2019
>      cpu: 8
>      memory: 8G
>    env:
> +    CIRRUS_SHELL: powershell
>      MSYS: winsymlinks:nativestrict
>      MSYSTEM: MINGW64
>      CHERE_INVOKING: 1
> -  printenv_script:
> -    - C:\tools\msys64\usr\bin\bash.exe -lc 'printenv'
> +  msys2_cache:
> +      folder: C:\tools\msys64
> +      reupload_on_changes: false
> +      fingerprint_script: cat .cirrus.yml
> +      populate_script:
> +        - |
> +          Write-Output $env:PATH
> +          md C:\tools
> +          $start_time =3D Get-Date
> +          cd C:\tools
> +          bitsadmin /transfer msys_download /dynamic /download /priority
FOREGROUND
https://github.com/msys2/msys2-installer/releases/download/2020-09-03/msys2=
-base-x86_64-20200903.sfx.exe
C:\tools\base.exe
> +          Write-Output "Download time taken:
$((Get-Date).Subtract($start_time).Seconds) second(s)"
> +          C:\tools\base.exe -y
> +          ((Get-Content -path C:\tools\msys64\etc\\post-install\\
07-pacman-key.post -Raw) -replace '--refresh-keys', '--version') |
Set-Content -Path C:\tools\msys64\etc\\post-install\\07-pacman-key.post
> +          C:\tools\msys64\usr\bin\bash.exe -lc "sed -i
's/^CheckSpace/#CheckSpace/g' /etc/pacman.conf"
> +          C:\tools\msys64\usr\bin\bash.exe -lc "export"
> +          C:\tools\msys64\usr\bin\bash.exe -lc "grep -rl 'repo.msys2.org=
/'
/etc/pacman.d/mirrorlist.* | xargs sed -i 's/repo.msys2.org\//
mirrors.tuna.tsinghua.edu.cn\/msys2\//g'"
> +          C:\tools\msys64\usr\bin\pacman.exe --noconfirm -Sy
> +          echo Y | C:\tools\msys64\usr\bin\pacman.exe --noconfirm -Suu
--overwrite '*'
> +          taskkill /F /FI "MODULES eq msys-2.0.dll"
> +          tasklist
> +          C:\tools\msys64\usr\bin\bash.exe -lc "mv -f
/etc/pacman.conf.pacnew /etc/pacman.conf || true"
> +          C:\tools\msys64\usr\bin\bash.exe -lc "pacman --noconfirm -Suu
--overwrite '*'"
> +          C:\tools\msys64\usr\bin\bash.exe -lc "pacman --noconfirm -S
--needed \
> +            diffutils git grep make pkg-config sed \
> +            mingw-w64-x86_64-python \
> +            mingw-w64-x86_64-python-setuptools \
> +            mingw-w64-x86_64-toolchain \
> +            mingw-w64-x86_64-SDL2 \
> +            mingw-w64-x86_64-SDL2_image \
> +            mingw-w64-x86_64-gtk3 \
> +            mingw-w64-x86_64-glib2 \
> +            mingw-w64-x86_64-ninja \
> +            mingw-w64-x86_64-jemalloc \
> +            mingw-w64-x86_64-lzo2 \
> +            mingw-w64-x86_64-zstd \
> +            mingw-w64-x86_64-libjpeg-turbo \
> +            mingw-w64-x86_64-pixman \
> +            mingw-w64-x86_64-libgcrypt \
> +            mingw-w64-x86_64-libpng \
> +            mingw-w64-x86_64-libssh \
> +            mingw-w64-x86_64-libxml2 \
> +            mingw-w64-x86_64-snappy \
> +            mingw-w64-x86_64-libusb \
> +            mingw-w64-x86_64-usbredir \
> +            mingw-w64-x86_64-libtasn1 \
> +            mingw-w64-x86_64-nettle \
> +            mingw-w64-x86_64-cyrus-sasl \
> +            mingw-w64-x86_64-curl \
> +            mingw-w64-x86_64-gnutls \
> +            "
>    install_script:
> -    - C:\tools\msys64\usr\bin\bash.exe -lc "cd /c/tools &&
> -        curl -O
http://repo.msys2.org/msys/x86_64/msys2-keyring-r21.b39fb11-1-any.pkg.tar.x=
z
"
> -    - C:\tools\msys64\usr\bin\bash.exe -lc "cd /c/tools &&
> -        curl -O
http://repo.msys2.org/msys/x86_64/msys2-keyring-r21.b39fb11-1-any.pkg.tar.x=
z.sig
"
> -    - C:\tools\msys64\usr\bin\bash.exe -lc "cd /c/tools &&
> -        pacman -U --noconfirm msys2-keyring-r21.b39fb11-1-any.pkg.tar.xz=
"
> -    - C:\tools\msys64\usr\bin\bash.exe -lc "pacman --noconfirm -Sy"
> -    - C:\tools\msys64\usr\bin\bash.exe -lc "pacman --noconfirm -S
--needed
> -        bash pacman pacman-mirrors msys2-runtime"
> -    - taskkill /F /IM gpg-agent.exe
> -    - C:\tools\msys64\usr\bin\bash.exe -lc "pacman --noconfirm -Su"
> -    - C:\tools\msys64\usr\bin\bash.exe -lc "pacman --noconfirm -S
--needed
> -        base-devel
> -        git
> -        mingw-w64-x86_64-python
> -        mingw-w64-x86_64-python-setuptools
> -        mingw-w64-x86_64-toolchain
> -        mingw-w64-x86_64-capstone
> -        mingw-w64-x86_64-SDL2
> -        mingw-w64-x86_64-SDL2_image
> -        mingw-w64-x86_64-gtk3
> -        mingw-w64-x86_64-glib2
> -        mingw-w64-x86_64-ninja
> -        mingw-w64-x86_64-make
> -        mingw-w64-x86_64-lzo2
> -        mingw-w64-x86_64-zstd
> -        mingw-w64-x86_64-libjpeg-turbo
> -        mingw-w64-x86_64-pixman
> -        mingw-w64-x86_64-libgcrypt
> -        mingw-w64-x86_64-libpng
> -        mingw-w64-x86_64-libssh
> -        mingw-w64-x86_64-libxml2
> -        mingw-w64-x86_64-snappy
> -        mingw-w64-x86_64-libusb
> -        mingw-w64-x86_64-usbredir
> -        mingw-w64-x86_64-libtasn1
> -        mingw-w64-x86_64-nettle
> -        mingw-w64-x86_64-cyrus-sasl
> -        mingw-w64-x86_64-curl
> -        mingw-w64-x86_64-gnutls
> -        mingw-w64-x86_64-zstd"
> +    - |
> +      Write-Output $env:PATH
> +      C:\tools\msys64\usr\bin\bash.exe -lc "export"
> +
>    script:
>      - C:\tools\msys64\usr\bin\bash.exe -lc "mkdir build"
>      - C:\tools\msys64\usr\bin\bash.exe -lc "cd build && ../configure
>        --python=3Dpython3 --ninja=3Dninja
>
 --target-list-exclude=3Di386-softmmu,arm-softmmu,ppc-softmmu,mips-softmmu"
> -    - C:\tools\msys64\usr\bin\bash.exe -lc "cd build && make
-j$NUMBER_OF_PROCESSORS"
> +    - C:\tools\msys64\usr\bin\bash.exe -lc "cd build && make -j8"
>    test_script:
>      - C:\tools\msys64\usr\bin\bash.exe -lc "cd build && make V=3D1 check=
"
> --
> 2.28.0.windows.1
>


--
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--00000000000091b85705b112975a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">The building result are at=C2=A0<div><a href=3D"https://ci=
rrus-ci.com/task/4899553256144896">https://cirrus-ci.com/task/4899553256144=
896</a><br><br>On Wed, Oct 7, 2020 at 6:55 PM Yonggang Luo &lt;<a href=3D"m=
ailto:luoyonggang@gmail.com">luoyonggang@gmail.com</a>&gt; wrote:<br>&gt;<b=
r>&gt; Use cache of cirrus caching msys2<br>&gt; The install of msys2 are r=
efer to <a href=3D"https://github.com/msys2/setup-msys2">https://github.com=
/msys2/setup-msys2</a><br>&gt; The first time install msys2 would be time c=
onsuming, so increase timeout_in to 90m<br>&gt; according to <a href=3D"htt=
ps://cirrus-ci.org/faq/#instance-timed-out">https://cirrus-ci.org/faq/#inst=
ance-timed-out</a><br>&gt;<br>&gt; Apply patch of <a href=3D"https://lists.=
gnu.org/archive/html/qemu-devel/2020-10/msg00072.html">https://lists.gnu.or=
g/archive/html/qemu-devel/2020-10/msg00072.html</a><br>&gt;<br>&gt; Signed-=
off-by: Yonggang Luo &lt;<a href=3D"mailto:luoyonggang@gmail.com">luoyongga=
ng@gmail.com</a>&gt;<br>&gt; ---<br>&gt; =C2=A0.cirrus.yml | 104 ++++++++++=
+++++++++++++++++++-----------------------<br>&gt; =C2=A01 file changed, 59=
 insertions(+), 45 deletions(-)<br>&gt;<br>&gt; diff --git a/.cirrus.yml b/=
.cirrus.yml<br>&gt; index d58782ce67..b58fb63521 100644<br>&gt; --- a/.cirr=
us.yml<br>&gt; +++ b/.cirrus.yml<br>&gt; @@ -46,64 +46,78 @@ macos_xcode_ta=
sk:<br>&gt; =C2=A0 =C2=A0 =C2=A0- gmake check<br>&gt;<br>&gt; =C2=A0windows=
_msys2_task:<br>&gt; + =C2=A0timeout_in: 90m<br>&gt; =C2=A0 =C2=A0windows_c=
ontainer:<br>&gt; - =C2=A0 =C2=A0image: cirrusci/windowsservercore:cmake<br=
>&gt; + =C2=A0 =C2=A0image: cirrusci/windowsservercore:2019<br>&gt; =C2=A0 =
=C2=A0 =C2=A0os_version: 2019<br>&gt; =C2=A0 =C2=A0 =C2=A0cpu: 8<br>&gt; =
=C2=A0 =C2=A0 =C2=A0memory: 8G<br>&gt; =C2=A0 =C2=A0env:<br>&gt; + =C2=A0 =
=C2=A0CIRRUS_SHELL: powershell<br>&gt; =C2=A0 =C2=A0 =C2=A0MSYS: winsymlink=
s:nativestrict<br>&gt; =C2=A0 =C2=A0 =C2=A0MSYSTEM: MINGW64<br>&gt; =C2=A0 =
=C2=A0 =C2=A0CHERE_INVOKING: 1<br>&gt; - =C2=A0printenv_script:<br>&gt; - =
=C2=A0 =C2=A0- C:\tools\msys64\usr\bin\bash.exe -lc &#39;printenv&#39;<br>&=
gt; + =C2=A0msys2_cache:<br>&gt; + =C2=A0 =C2=A0 =C2=A0folder: C:\tools\msy=
s64<br>&gt; + =C2=A0 =C2=A0 =C2=A0reupload_on_changes: false<br>&gt; + =C2=
=A0 =C2=A0 =C2=A0fingerprint_script: cat .cirrus.yml<br>&gt; + =C2=A0 =C2=
=A0 =C2=A0populate_script:<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0- |<br>&gt;=
 + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Write-Output $env:PATH<br>&gt; + =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0md C:\tools<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0$start_time =3D Get-Date<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0cd C:\tools<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bitsadmin /t=
ransfer msys_download /dynamic /download /priority FOREGROUND <a href=3D"ht=
tps://github.com/msys2/msys2-installer/releases/download/2020-09-03/msys2-b=
ase-x86_64-20200903.sfx.exe">https://github.com/msys2/msys2-installer/relea=
ses/download/2020-09-03/msys2-base-x86_64-20200903.sfx.exe</a> C:\tools\bas=
e.exe<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Write-Output &quot;Downlo=
ad time taken: $((Get-Date).Subtract($start_time).Seconds) second(s)&quot;<=
br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0C:\tools\base.exe -y<br>&gt; + =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0((Get-Content -path C:\tools\msys64\etc\\=
post-install\\<a href=3D"http://07-pacman-key.post">07-pacman-key.post</a> =
-Raw) -replace &#39;--refresh-keys&#39;, &#39;--version&#39;) | Set-Content=
 -Path C:\tools\msys64\etc\\post-install\\<a href=3D"http://07-pacman-key.p=
ost">07-pacman-key.post</a><br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0C:\=
tools\msys64\usr\bin\bash.exe -lc &quot;sed -i &#39;s/^CheckSpace/#CheckSpa=
ce/g&#39; /etc/pacman.conf&quot;<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0C:\tools\msys64\usr\bin\bash.exe -lc &quot;export&quot;<br>&gt; + =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0C:\tools\msys64\usr\bin\bash.exe -lc &quot;grep=
 -rl &#39;<a href=3D"http://repo.msys2.org/">repo.msys2.org/</a>&#39; /etc/=
pacman.d/mirrorlist.* | xargs sed -i &#39;s/<a href=3D"http://repo.msys2.or=
g">repo.msys2.org</a>\//<a href=3D"http://mirrors.tuna.tsinghua.edu.cn">mir=
rors.tuna.tsinghua.edu.cn</a>\/msys2\//g&#39;&quot;<br>&gt; + =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0C:\tools\msys64\usr\bin\pacman.exe --noconfirm -Sy<br>=
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0echo Y | C:\tools\msys64\usr\bin\p=
acman.exe --noconfirm -Suu --overwrite &#39;*&#39;<br>&gt; + =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0taskkill /F /FI &quot;MODULES eq msys-2.0.dll&quot;<br>=
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tasklist<br>&gt; + =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0C:\tools\msys64\usr\bin\bash.exe -lc &quot;mv -f /etc/p=
acman.conf.pacnew /etc/pacman.conf || true&quot;<br>&gt; + =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0C:\tools\msys64\usr\bin\bash.exe -lc &quot;pacman --noc=
onfirm -Suu --overwrite &#39;*&#39;&quot;<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0C:\tools\msys64\usr\bin\bash.exe -lc &quot;pacman --noconfirm =
-S --needed \<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0diffutils =
git grep make pkg-config sed \<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0mingw-w64-x86_64-python \<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0mingw-w64-x86_64-python-setuptools \<br>&gt; + =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0mingw-w64-x86_64-toolchain \<br>&gt; + =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mingw-w64-x86_64-SDL2 \<br>&gt; + =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mingw-w64-x86_64-SDL2_image \<br>&gt; + =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mingw-w64-x86_64-gtk3 \<br>&gt; + =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mingw-w64-x86_64-glib2 \<br>&gt; + =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mingw-w64-x86_64-ninja \<br>&gt; +=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mingw-w64-x86_64-jemalloc \<br>&g=
t; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mingw-w64-x86_64-lzo2 \<br>&g=
t; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mingw-w64-x86_64-zstd \<br>&g=
t; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mingw-w64-x86_64-libjpeg-turb=
o \<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mingw-w64-x86_64-pix=
man \<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mingw-w64-x86_64-l=
ibgcrypt \<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mingw-w64-x86=
_64-libpng \<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mingw-w64-x=
86_64-libssh \<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mingw-w64=
-x86_64-libxml2 \<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mingw-=
w64-x86_64-snappy \<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ming=
w-w64-x86_64-libusb \<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mi=
ngw-w64-x86_64-usbredir \<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0mingw-w64-x86_64-libtasn1 \<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0mingw-w64-x86_64-nettle \<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0mingw-w64-x86_64-cyrus-sasl \<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0mingw-w64-x86_64-curl \<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0mingw-w64-x86_64-gnutls \<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0&quot;<br>&gt; =C2=A0 =C2=A0install_script:<br>&gt; - =
=C2=A0 =C2=A0- C:\tools\msys64\usr\bin\bash.exe -lc &quot;cd /c/tools &amp;=
&amp;<br>&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0curl -O <a href=3D"http://repo.m=
sys2.org/msys/x86_64/msys2-keyring-r21.b39fb11-1-any.pkg.tar.xz">http://rep=
o.msys2.org/msys/x86_64/msys2-keyring-r21.b39fb11-1-any.pkg.tar.xz</a>&quot=
;<br>&gt; - =C2=A0 =C2=A0- C:\tools\msys64\usr\bin\bash.exe -lc &quot;cd /c=
/tools &amp;&amp;<br>&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0curl -O <a href=3D"h=
ttp://repo.msys2.org/msys/x86_64/msys2-keyring-r21.b39fb11-1-any.pkg.tar.xz=
.sig">http://repo.msys2.org/msys/x86_64/msys2-keyring-r21.b39fb11-1-any.pkg=
.tar.xz.sig</a>&quot;<br>&gt; - =C2=A0 =C2=A0- C:\tools\msys64\usr\bin\bash=
.exe -lc &quot;cd /c/tools &amp;&amp;<br>&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0=
pacman -U --noconfirm msys2-keyring-r21.b39fb11-1-any.pkg.tar.xz&quot;<br>&=
gt; - =C2=A0 =C2=A0- C:\tools\msys64\usr\bin\bash.exe -lc &quot;pacman --no=
confirm -Sy&quot;<br>&gt; - =C2=A0 =C2=A0- C:\tools\msys64\usr\bin\bash.exe=
 -lc &quot;pacman --noconfirm -S --needed<br>&gt; - =C2=A0 =C2=A0 =C2=A0 =
=C2=A0bash pacman pacman-mirrors msys2-runtime&quot;<br>&gt; - =C2=A0 =C2=
=A0- taskkill /F /IM gpg-agent.exe<br>&gt; - =C2=A0 =C2=A0- C:\tools\msys64=
\usr\bin\bash.exe -lc &quot;pacman --noconfirm -Su&quot;<br>&gt; - =C2=A0 =
=C2=A0- C:\tools\msys64\usr\bin\bash.exe -lc &quot;pacman --noconfirm -S --=
needed<br>&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0base-devel<br>&gt; - =C2=A0 =C2=
=A0 =C2=A0 =C2=A0git<br>&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0mingw-w64-x86_64-=
python<br>&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0mingw-w64-x86_64-python-setupto=
ols<br>&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0mingw-w64-x86_64-toolchain<br>&gt;=
 - =C2=A0 =C2=A0 =C2=A0 =C2=A0mingw-w64-x86_64-capstone<br>&gt; - =C2=A0 =
=C2=A0 =C2=A0 =C2=A0mingw-w64-x86_64-SDL2<br>&gt; - =C2=A0 =C2=A0 =C2=A0 =
=C2=A0mingw-w64-x86_64-SDL2_image<br>&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0ming=
w-w64-x86_64-gtk3<br>&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0mingw-w64-x86_64-gli=
b2<br>&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0mingw-w64-x86_64-ninja<br>&gt; - =
=C2=A0 =C2=A0 =C2=A0 =C2=A0mingw-w64-x86_64-make<br>&gt; - =C2=A0 =C2=A0 =
=C2=A0 =C2=A0mingw-w64-x86_64-lzo2<br>&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0min=
gw-w64-x86_64-zstd<br>&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0mingw-w64-x86_64-li=
bjpeg-turbo<br>&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0mingw-w64-x86_64-pixman<br=
>&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0mingw-w64-x86_64-libgcrypt<br>&gt; - =C2=
=A0 =C2=A0 =C2=A0 =C2=A0mingw-w64-x86_64-libpng<br>&gt; - =C2=A0 =C2=A0 =C2=
=A0 =C2=A0mingw-w64-x86_64-libssh<br>&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0ming=
w-w64-x86_64-libxml2<br>&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0mingw-w64-x86_64-=
snappy<br>&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0mingw-w64-x86_64-libusb<br>&gt;=
 - =C2=A0 =C2=A0 =C2=A0 =C2=A0mingw-w64-x86_64-usbredir<br>&gt; - =C2=A0 =
=C2=A0 =C2=A0 =C2=A0mingw-w64-x86_64-libtasn1<br>&gt; - =C2=A0 =C2=A0 =C2=
=A0 =C2=A0mingw-w64-x86_64-nettle<br>&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0ming=
w-w64-x86_64-cyrus-sasl<br>&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0mingw-w64-x86_=
64-curl<br>&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0mingw-w64-x86_64-gnutls<br>&gt=
; - =C2=A0 =C2=A0 =C2=A0 =C2=A0mingw-w64-x86_64-zstd&quot;<br>&gt; + =C2=A0=
 =C2=A0- |<br>&gt; + =C2=A0 =C2=A0 =C2=A0Write-Output $env:PATH<br>&gt; + =
=C2=A0 =C2=A0 =C2=A0C:\tools\msys64\usr\bin\bash.exe -lc &quot;export&quot;=
<br>&gt; +<br>&gt; =C2=A0 =C2=A0script:<br>&gt; =C2=A0 =C2=A0 =C2=A0- C:\to=
ols\msys64\usr\bin\bash.exe -lc &quot;mkdir build&quot;<br>&gt; =C2=A0 =C2=
=A0 =C2=A0- C:\tools\msys64\usr\bin\bash.exe -lc &quot;cd build &amp;&amp; =
../configure<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0--python=3Dpython3 --ninja=
=3Dninja<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0--target-list-exclude=3Di386-so=
ftmmu,arm-softmmu,ppc-softmmu,mips-softmmu&quot;<br>&gt; - =C2=A0 =C2=A0- C=
:\tools\msys64\usr\bin\bash.exe -lc &quot;cd build &amp;&amp; make -j$NUMBE=
R_OF_PROCESSORS&quot;<br>&gt; + =C2=A0 =C2=A0- C:\tools\msys64\usr\bin\bash=
.exe -lc &quot;cd build &amp;&amp; make -j8&quot;<br>&gt; =C2=A0 =C2=A0test=
_script:<br>&gt; =C2=A0 =C2=A0 =C2=A0- C:\tools\msys64\usr\bin\bash.exe -lc=
 &quot;cd build &amp;&amp; make V=3D1 check&quot;<br>&gt; --<br>&gt; 2.28.0=
.windows.1<br>&gt;<br><br><br>--<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=E6=
=AD=A4=E8=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=
=A0 =C2=A0 sincerely,<br>Yonggang Luo</div></div>

--00000000000091b85705b112975a--

