Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74427C43461
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 09:38:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD8B12087C
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 09:38:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MLB01RNI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD8B12087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFwYz-0000b3-Cx
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 05:38:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54880)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFwXL-0007tN-Gh; Wed, 09 Sep 2020 05:37:08 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:39531)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFwXH-0006Kp-TY; Wed, 09 Sep 2020 05:37:07 -0400
Received: by mail-lj1-x241.google.com with SMTP id u21so2641809ljl.6;
 Wed, 09 Sep 2020 02:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=do7L2Te0uiYtp1suN0TM8wBPLb34L1B2jRDl6GDUW3Q=;
 b=MLB01RNITS7gGEdYYc7yNOONbAQ6B6hivOez+gyfDG/ltdlPWqhhTLDN/Ub657LyeM
 AWyCvO2I02aOlupHWqlqXpqKrTHv0szho813zKpHJVpJa0bA2Qz7l+C20cESY+CHxoKj
 pYl4HtNi3O6vsrbIEMyX/HKf7TG7wbr68z70p/7P9dDRrV9GIzMgIcaDN2qdP6ULw2KO
 gX7Yq9B+evWcMWpP3V9V/+zo3jSc97miHB+cbu9WCluVsURUz58GJrFpQsI/qVw0GpF2
 IvNfXGKXBl2vrPRFX3LpN1OSOXobpq7LSqo2eN6eI3C9ry0mDsxZhX4XVW6zZLG72YfN
 awxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=do7L2Te0uiYtp1suN0TM8wBPLb34L1B2jRDl6GDUW3Q=;
 b=snkBHTZfiyqjq0q3bsDW7XahMc3ZqvRItpyANuCgucywlKFFOaUKwmvTRyfjFE2iQj
 WqwXrd/R3WrL4NgKtCEN63xiBB32uTA9uVVQ2e5SNlE2NalJy7a/5auLvvSbbWMj9Niw
 5krVUdeq+/QguCljpdF3vKmIhPRqc2d5wxITb4JAmKXwuWKdwig8UA1+20vtKlUn4PLD
 SKXNAhPJppTwRJWBqwcNZ3E/p68IoH7qVl45cslYMr3G+7c7ttRTOR8rhOFWqIpdy+6a
 PHNzr1zUp2zIg5hgF46YSej1GiwcP8MZhHISFYCwY7Bm/FBmUhEfGFZkVjgDBJEGv7r0
 OMGQ==
X-Gm-Message-State: AOAM532lqM9CQzxArhM9lpZgLAtR2xLsq2WPCByah1CBndYh3FLBerlF
 BvXeAgG+lPhIetQZdTqdK3iNZtydCGs88dPN/5g=
X-Google-Smtp-Source: ABdhPJwAXrzrXmiGmn0Syfz2lE9L3+iZXOIkAXGhtOh6rambzQh2q82POAx6FidPtgXO0+6egEcCO9FO0LPS7WehVF0=
X-Received: by 2002:a2e:9dc7:: with SMTP id x7mr1535400ljj.447.1599644220065; 
 Wed, 09 Sep 2020 02:37:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200908194820.702-1-luoyonggang@gmail.com>
 <20200908194820.702-7-luoyonggang@gmail.com>
 <20200909082718.GH1011023@redhat.com>
In-Reply-To: <20200909082718.GH1011023@redhat.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Wed, 9 Sep 2020 17:36:49 +0800
Message-ID: <CAE2XoE8hHtoV_oUY2KiU=2Papjt_A4-eSF5MabPsMxnHf2uSRw@mail.gmail.com>
Subject: Re: [PATCH 06/16] ci: Enable msys2 ci in cirrus
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000810dc505aede31ce"
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
Cc: Kevin Wolf <kwolf@redhat.com>, Ed Maste <emaste@freebsd.org>,
 Qemu-block <qemu-block@nongnu.org>, Stefan Weil <sw@weilnetz.de>,
 Xie Changlong <xiechanglong.d@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-level <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Wen Congyang <wencongyang2@huawei.com>,
 Max Reitz <mreitz@redhat.com>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Markus Armbruster <armbru@redhat.com>, Peter Lieven <pl@kamp.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000810dc505aede31ce
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 9, 2020 at 4:27 PM Daniel P. Berrang=C3=A9 <berrange@redhat.com=
>
wrote:

> On Wed, Sep 09, 2020 at 03:48:10AM +0800, Yonggang Luo wrote:
> > Install msys2 in a proper way refer to
> https://github.com/cirruslabs/cirrus-ci-docs/issues/699
> > The https://wiki.qemu.org/Hosts/W32#Native_builds_with_MSYS2 need to be
> updated.
> > There is no need of --cross-prefix, open mingw64.exe instead of
> msys2.exe then we don't
> > need the --cross-prefix, besides we using environment variable settings=
:
> >     MSYS: winsymlinks:nativestrict
> >     MSYSTEM: MINGW64
> >     CHERE_INVOKING: 1
> > to opening mingw64 native shell.
> > We now running tests with make -i check to skip tests errors.
> >
> > Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> > ---
> >  .cirrus.yml                         | 24 +++++++++++++++++++++
> >  scripts/ci/windows/msys2-build.sh   | 28 ++++++++++++++++++++++++
> >  scripts/ci/windows/msys2-install.sh | 33 +++++++++++++++++++++++++++++
> >  3 files changed, 85 insertions(+)
> >  create mode 100644 scripts/ci/windows/msys2-build.sh
> >  create mode 100644 scripts/ci/windows/msys2-install.sh
> >
> > diff --git a/.cirrus.yml b/.cirrus.yml
> > index 3dd9fcff7f..49335e68c9 100644
> > --- a/.cirrus.yml
> > +++ b/.cirrus.yml
> > @@ -63,3 +63,27 @@ macos_xcode_task:
> >                     --enable-werror --cc=3Dclang || { cat config.log; e=
xit
> 1; }
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
> > +  printenv_script:
> > +    - C:\tools\msys64\usr\bin\bash.exe -lc 'printenv'
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
> scripts/ci/windows/msys2-install.sh"
> > +  script:
> > +    - C:\tools\msys64\usr\bin\bash.exe -lc "sh
> scripts/ci/windows/msys2-build.sh"
> > diff --git a/scripts/ci/windows/msys2-build.sh
> b/scripts/ci/windows/msys2-build.sh
> > new file mode 100644
> > index 0000000000..d9d046b5b0
> > --- /dev/null
> > +++ b/scripts/ci/windows/msys2-build.sh
> > @@ -0,0 +1,28 @@
> > +mkdir build
> > +cd build
> > +../configure \
> > +--python=3Dpython3 \
> > +--ninja=3Dninja \
> > +--enable-stack-protector \
> > +--enable-guest-agent \
> > +--disable-pie \
> > +--enable-gnutls --enable-nettle \
> > +--enable-sdl --enable-sdl-image --enable-gtk --disable-vte
> --enable-curses --enable-iconv \
> > +--enable-vnc --enable-vnc-sasl --enable-vnc-jpeg --enable-vnc-png \
> > +--enable-slirp=3Dgit \
> > +--disable-brlapi --enable-curl \
> > +--enable-fdt \
> > +--disable-kvm --enable-hax --enable-whpx \
> > +--enable-libnfs --enable-libusb --enable-live-block-migration
> --enable-usb-redir \
> > +--enable-lzo --enable-snappy --enable-bzip2 --enable-zstd \
> > +--enable-membarrier --enable-coroutine-pool \
> > +--enable-libssh --enable-libxml2 \
> > +--enable-jemalloc --enable-avx2 \
> > +--enable-replication \
> > +--enable-tools \
> > +--enable-bochs --enable-cloop --enable-dmg --enable-qcow1 --enable-vdi
> --enable-vvfat --enable-qed --enable-parallels \
> > +--enable-sheepdog \
> > +--enable-capstone=3Dgit
>
> Why do we need to have all these disable/enable args ?   AFAIK, configure
> should just "do the right thing" and automatically detect and enable
> libraries which are present in the environment.
>
> Te intent is that a bare "configure" should complete successfully on all
> supported platforms. Ff something breaks at build time, that is
> generally considered a bug in the configure script as it should
> automatically
> disable any features that are broken on a given platform.
>
Gotcha, I'll leave only configure latter, currently I use this to detect
which msys2 package not installed yet.


>
>
> Regards,
> Daniel
> --
> |: https://berrange.com      -o-
> https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-
> https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-
> https://www.instagram.com/dberrange :|
>
>

--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--000000000000810dc505aede31ce
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, Sep 9, 2020 at 4:27 PM Daniel=
 P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.com">berrange@redha=
t.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex">On Wed, Sep 09, 2020 at 03:48:10AM +0800, Yonggang Luo wrote:<br>
&gt; Install msys2 in a proper way refer to <a href=3D"https://github.com/c=
irruslabs/cirrus-ci-docs/issues/699" rel=3D"noreferrer" target=3D"_blank">h=
ttps://github.com/cirruslabs/cirrus-ci-docs/issues/699</a><br>
&gt; The <a href=3D"https://wiki.qemu.org/Hosts/W32#Native_builds_with_MSYS=
2" rel=3D"noreferrer" target=3D"_blank">https://wiki.qemu.org/Hosts/W32#Nat=
ive_builds_with_MSYS2</a> need to be updated.<br>
&gt; There is no need of --cross-prefix, open mingw64.exe instead of msys2.=
exe then we don&#39;t<br>
&gt; need the --cross-prefix, besides we using environment variable setting=
s:<br>
&gt;=C2=A0 =C2=A0 =C2=A0MSYS: winsymlinks:nativestrict<br>
&gt;=C2=A0 =C2=A0 =C2=A0MSYSTEM: MINGW64<br>
&gt;=C2=A0 =C2=A0 =C2=A0CHERE_INVOKING: 1<br>
&gt; to opening mingw64 native shell.<br>
&gt; We now running tests with make -i check to skip tests errors.<br>
&gt; <br>
&gt; Signed-off-by: Yonggang Luo &lt;<a href=3D"mailto:luoyonggang@gmail.co=
m" target=3D"_blank">luoyonggang@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 .cirrus.yml=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 24 +++++++++++++++++++++<br>
&gt;=C2=A0 scripts/ci/windows/msys2-build.sh=C2=A0 =C2=A0| 28 +++++++++++++=
+++++++++++<br>
&gt;=C2=A0 scripts/ci/windows/msys2-install.sh | 33 +++++++++++++++++++++++=
++++++<br>
&gt;=C2=A0 3 files changed, 85 insertions(+)<br>
&gt;=C2=A0 create mode 100644 scripts/ci/windows/msys2-build.sh<br>
&gt;=C2=A0 create mode 100644 scripts/ci/windows/msys2-install.sh<br>
&gt; <br>
&gt; diff --git a/.cirrus.yml b/.cirrus.yml<br>
&gt; index 3dd9fcff7f..49335e68c9 100644<br>
&gt; --- a/.cirrus.yml<br>
&gt; +++ b/.cirrus.yml<br>
&gt; @@ -63,3 +63,27 @@ macos_xcode_task:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0--enable-werror --cc=3Dclang || { cat config.log; exit 1; }<br>
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
&gt; +=C2=A0 printenv_script:<br>
&gt; +=C2=A0 =C2=A0 - C:\tools\msys64\usr\bin\bash.exe -lc &#39;printenv&#3=
9;<br>
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
/ci/windows/msys2-install.sh&quot;<br>
&gt; +=C2=A0 script:<br>
&gt; +=C2=A0 =C2=A0 - C:\tools\msys64\usr\bin\bash.exe -lc &quot;sh scripts=
/ci/windows/msys2-build.sh&quot;<br>
&gt; diff --git a/scripts/ci/windows/msys2-build.sh b/scripts/ci/windows/ms=
ys2-build.sh<br>
&gt; new file mode 100644<br>
&gt; index 0000000000..d9d046b5b0<br>
&gt; --- /dev/null<br>
&gt; +++ b/scripts/ci/windows/msys2-build.sh<br>
&gt; @@ -0,0 +1,28 @@<br>
&gt; +mkdir build<br>
&gt; +cd build<br>
&gt; +../configure \<br>
&gt; +--python=3Dpython3 \<br>
&gt; +--ninja=3Dninja \<br>
&gt; +--enable-stack-protector \<br>
&gt; +--enable-guest-agent \<br>
&gt; +--disable-pie \<br>
&gt; +--enable-gnutls --enable-nettle \<br>
&gt; +--enable-sdl --enable-sdl-image --enable-gtk --disable-vte --enable-c=
urses --enable-iconv \<br>
&gt; +--enable-vnc --enable-vnc-sasl --enable-vnc-jpeg --enable-vnc-png \<b=
r>
&gt; +--enable-slirp=3Dgit \<br>
&gt; +--disable-brlapi --enable-curl \<br>
&gt; +--enable-fdt \<br>
&gt; +--disable-kvm --enable-hax --enable-whpx \<br>
&gt; +--enable-libnfs --enable-libusb --enable-live-block-migration --enabl=
e-usb-redir \<br>
&gt; +--enable-lzo --enable-snappy --enable-bzip2 --enable-zstd \<br>
&gt; +--enable-membarrier --enable-coroutine-pool \<br>
&gt; +--enable-libssh --enable-libxml2 \<br>
&gt; +--enable-jemalloc --enable-avx2 \<br>
&gt; +--enable-replication \<br>
&gt; +--enable-tools \<br>
&gt; +--enable-bochs --enable-cloop --enable-dmg --enable-qcow1 --enable-vd=
i --enable-vvfat --enable-qed --enable-parallels \<br>
&gt; +--enable-sheepdog \<br>
&gt; +--enable-capstone=3Dgit<br>
<br>
Why do we need to have all these disable/enable args ?=C2=A0 =C2=A0AFAIK, c=
onfigure<br>
should just &quot;do the right thing&quot; and automatically detect and ena=
ble<br>
libraries which are present in the environment.<br>
<br>
Te intent is that a bare &quot;configure&quot; should complete successfully=
 on all<br>
supported platforms. Ff something breaks at build time, that is<br>
generally considered a bug in the configure script as it should automatical=
ly<br>
disable any features that are broken on a given platform.<br></blockquote><=
div>Gotcha, I&#39;ll leave only configure latter, currently I use this to d=
etect which msys2 package not installed yet.</div><div>=C2=A0</div><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px=
 solid rgb(204,204,204);padding-left:1ex">
<br>
<br>
Regards,<br>
Daniel<br>
-- <br>
|: <a href=3D"https://berrange.com" rel=3D"noreferrer" target=3D"_blank">ht=
tps://berrange.com</a>=C2=A0 =C2=A0 =C2=A0 -o-=C2=A0 =C2=A0 <a href=3D"http=
s://www.flickr.com/photos/dberrange" rel=3D"noreferrer" target=3D"_blank">h=
ttps://www.flickr.com/photos/dberrange</a> :|<br>
|: <a href=3D"https://libvirt.org" rel=3D"noreferrer" target=3D"_blank">htt=
ps://libvirt.org</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-o-=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://fstop138.berrange.com" rel=3D"n=
oreferrer" target=3D"_blank">https://fstop138.berrange.com</a> :|<br>
|: <a href=3D"https://entangle-photo.org" rel=3D"noreferrer" target=3D"_bla=
nk">https://entangle-photo.org</a>=C2=A0 =C2=A0 -o-=C2=A0 =C2=A0 <a href=3D=
"https://www.instagram.com/dberrange" rel=3D"noreferrer" target=3D"_blank">=
https://www.instagram.com/dberrange</a> :|<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =E6=AD=A4=E8=
=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=
=A0 sincerely,<br>Yonggang Luo<br></div></div>

--000000000000810dc505aede31ce--

