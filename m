Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFBE2C433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 07:49:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4F75206C0
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 07:49:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iUfHbyJF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4F75206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35572 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDk0M-0001J4-QV
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 03:49:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43482)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kDjuj-0000oN-4k
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 03:44:09 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:34870)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kDjug-0003v6-VB
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 03:44:08 -0400
Received: by mail-pj1-x1044.google.com with SMTP id g6so1068250pjl.0
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 00:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=RPs3RoSh234lXncrsywCpA+V5get783NAhmcnU+hzlo=;
 b=iUfHbyJFHXe9LOF3xQaeLRQn4G6OacWh0s0spzv8StMBdYin+zMqcZELjT54/WJvMq
 Ik+H8tbvrDcXzdr6XSvYQcMm/Sq2/zEHVnA28JTjWFWWjiz+H5cCTMqkqPmm/5PLnbTH
 hDnBIHN4UJhOC5u+jQOEn7al370Oc7RsSdf/R+Tum0mY8cR9iuC33g8Uej9gSf48kZbv
 OXz47zU6JzsTnW7bEDGrWGUmJPhl8AKBWhiKCHCSGcSqCs6TJBrGhSFBPLF6TbhkL/D1
 7pimML4XQXtD4nVzoTNVKlpGK97M7Acy2vLYy+wykYTxrQOpUyuqpqISfClCiZq7E2QZ
 AE3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=RPs3RoSh234lXncrsywCpA+V5get783NAhmcnU+hzlo=;
 b=bnRovbYHtPDLsI4PU7Y0430qeIALnUh3ZzKP/OTu3l8YmVGUhpkCQMrPAtnK9jBF2K
 PModdWfvkEzlGmmW0uVvDVf3qwQ6nW90+1lnavXBrkudg9amkvr/gz0QTy2/Gyomwa8a
 aNfvJi58YBU0xlJ/YVEp8HPmyb/xs8kpbbBckyTxYPXDrgjBsoFgt+tmIkdRujN7XCbq
 GaASVn5PfmBRvWBrasnpq/kRBcOaXD9UvpwdGeY83A1m6OLfMaB2CblQrR4K1bDrttAp
 g8jXoOUwKE5PvJG0BinBZp6Mor3ii1vwYvl37iCa0WqBGhGF5J8FwcIxg8rS+86FZ1W5
 a0PA==
X-Gm-Message-State: AOAM53373l2hu5yqWe+B2je9TQYcByGQWFZfm4iJ/LXXC6/5Z+l9/8Au
 ZZlOcgfgmLWhoOUD0flAShVzy0c3IxE+oc7g
X-Google-Smtp-Source: ABdhPJwaJblHbAYFES+QR4WRfz3ya+TkSfDAneXGmFAaT9gtylJ1ZjpInma0B83+NxkJiMweIwV3tQ==
X-Received: by 2002:a17:90a:8589:: with SMTP id
 m9mr2074589pjn.109.1599119045126; 
 Thu, 03 Sep 2020 00:44:05 -0700 (PDT)
Received: from localhost.localdomain ([222.95.248.6])
 by smtp.googlemail.com with ESMTPSA id o6sm1512472pju.25.2020.09.03.00.44.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2020 00:44:03 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 12/12] ci: Enable msys2 ci in cirrus
Date: Thu,  3 Sep 2020 15:43:13 +0800
Message-Id: <20200903074313.1498-13-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200903074313.1498-1-luoyonggang@gmail.com>
References: <20200903074313.1498-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1044;
 envelope-from=luoyonggang@gmail.com; helo=mail-pj1-x1044.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Install msys2 in a proper way refer to https://github.com/cirruslabs/cirrus=
-ci-docs/issues/699
The https://wiki.qemu.org/Hosts/W32#Native_builds_with_MSYS2 need to be upd=
ated.
There is no need of --cross-prefix, open mingw64.exe instead of msys2.exe t=
hen we don't
need the --cross-prefix, besides using ENV
    MSYS: winsymlinks:nativestrict
    MSYSTEM: MINGW64
    CHERE_INVOKING: 1
to opening mingw64 native shell.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 .cirrus.yml                         | 108 +++++++++++++++++-----------
 scripts/ci/windows/msys2_build.sh   |  33 +++++++++
 scripts/ci/windows/msys2_install.sh |  31 ++++++++
 3 files changed, 130 insertions(+), 42 deletions(-)
 create mode 100644 scripts/ci/windows/msys2_build.sh
 create mode 100644 scripts/ci/windows/msys2_install.sh

diff --git a/.cirrus.yml b/.cirrus.yml
index f287d23c5b..0bfb465193 100644
--- a/.cirrus.yml
+++ b/.cirrus.yml
@@ -1,42 +1,66 @@
-env:
-  CIRRUS_CLONE_DEPTH: 1
-
-freebsd_12_task:
-  freebsd_instance:
-    image_family: freebsd-12-1
-    cpu: 8
-    memory: 8G
-  install_script: ASSUME_ALWAYS_YES=3Dyes pkg bootstrap -f ; pkg install -y
-    bash curl cyrus-sasl git glib gmake gnutls gsed
-    nettle perl5 pixman pkgconf png usbredir
-  script:
-    - mkdir build
-    - cd build
-    - ../configure || { cat config.log; exit 1; }
-    - gmake -j8
-    - gmake V=3D1 check
-
-macos_task:
-  osx_instance:
-    image: mojave-base
-  install_script:
-    - brew install pkg-config python gnu-sed glib pixman make sdl2 bash
-  script:
-    - mkdir build
-    - cd build
-    - ../configure --python=3D/usr/local/bin/python3 || { cat config.log; =
exit 1; }
-    - gmake -j$(sysctl -n hw.ncpu)
-    - gmake check
-
-macos_xcode_task:
-  osx_instance:
-    # this is an alias for the latest Xcode
-    image: mojave-xcode
-  install_script:
-    - brew install pkg-config gnu-sed glib pixman make sdl2 bash
-  script:
-    - mkdir build
-    - cd build
-    - ../configure --cc=3Dclang || { cat config.log; exit 1; }
-    - gmake -j$(sysctl -n hw.ncpu)
-    - gmake check
+env:=0D
+  CIRRUS_CLONE_DEPTH: 1=0D
+=0D
+freebsd_12_task:=0D
+  freebsd_instance:=0D
+    image_family: freebsd-12-1=0D
+    cpu: 8=0D
+    memory: 8G=0D
+  install_script: ASSUME_ALWAYS_YES=3Dyes pkg bootstrap -f ; pkg install -=
y=0D
+    bash curl cyrus-sasl git glib gmake gnutls gsed=0D
+    nettle perl5 pixman pkgconf png usbredir=0D
+  script:=0D
+    - mkdir build=0D
+    - cd build=0D
+    - ../configure || { cat config.log; exit 1; }=0D
+    - gmake -j8=0D
+    - gmake V=3D1 check=0D
+=0D
+macos_task:=0D
+  osx_instance:=0D
+    image: mojave-base=0D
+  install_script:=0D
+    - brew install pkg-config python gnu-sed glib pixman make sdl2 bash=0D
+  script:=0D
+    - mkdir build=0D
+    - cd build=0D
+    - ../configure --python=3D/usr/local/bin/python3 || { cat config.log; =
exit 1; }=0D
+    - gmake -j$(sysctl -n hw.ncpu)=0D
+    - gmake check=0D
+=0D
+macos_xcode_task:=0D
+  osx_instance:=0D
+    # this is an alias for the latest Xcode=0D
+    image: mojave-xcode=0D
+  install_script:=0D
+    - brew install pkg-config gnu-sed glib pixman make sdl2 bash=0D
+  script:=0D
+    - mkdir build=0D
+    - cd build=0D
+    - ../configure --cc=3Dclang || { cat config.log; exit 1; }=0D
+    - gmake -j$(sysctl -n hw.ncpu)=0D
+    - gmake check=0D
+=0D
+windows_msys2_task:=0D
+  windows_container:=0D
+    image: cirrusci/windowsservercore:cmake=0D
+    os_version: 2019=0D
+    cpu: 8=0D
+    memory: 8G=0D
+  env:=0D
+    MSYS: winsymlinks:nativestrict=0D
+    MSYSTEM: MINGW64=0D
+    CHERE_INVOKING: 1=0D
+  printenv_script:=0D
+    - C:\tools\msys64\usr\bin\bash.exe -lc 'printenv'=0D
+  install_script:=0D
+    - C:\tools\msys64\usr\bin\bash.exe -lc "cd /c/tools && curl -O http://=
repo.msys2.org/msys/x86_64/msys2-keyring-r21.b39fb11-1-any.pkg.tar.xz"=0D
+    - C:\tools\msys64\usr\bin\bash.exe -lc "cd /c/tools && curl -O http://=
repo.msys2.org/msys/x86_64/msys2-keyring-r21.b39fb11-1-any.pkg.tar.xz.sig"=
=0D
+    - C:\tools\msys64\usr\bin\bash.exe -lc "cd /c/tools && pacman -U --noc=
onfirm msys2-keyring-r21.b39fb11-1-any.pkg.tar.xz"=0D
+    - C:\tools\msys64\usr\bin\bash.exe -lc "pacman -Sy --noconfirm"=0D
+    - C:\tools\msys64\usr\bin\bash.exe -lc "pacman --needed --noconfirm -S=
 bash pacman pacman-mirrors msys2-runtime"=0D
+    - taskkill /F /IM gpg-agent.exe=0D
+    - C:\tools\msys64\usr\bin\bash.exe -lc "pacman --noconfirm -Su"=0D
+    - C:\tools\msys64\usr\bin\bash.exe -lc "sh scripts/ci/windows/msys2_in=
stall.sh"=0D
+  script:=0D
+    - C:\tools\msys64\usr\bin\bash.exe -lc "sh scripts/ci/windows/msys2_bu=
ild.sh"=0D
diff --git a/scripts/ci/windows/msys2_build.sh b/scripts/ci/windows/msys2_b=
uild.sh
new file mode 100644
index 0000000000..3ba89a4206
--- /dev/null
+++ b/scripts/ci/windows/msys2_build.sh
@@ -0,0 +1,33 @@
+mkdir build
+cd build
+../configure \
+  --python=3Dpython3 \
+  --enable-gtk --enable-sdl \
+  --enable-capstone=3Dgit \
+  --enable-stack-protector \
+  --ninja=3Dninja \
+  --enable-gnutls \
+  --enable-nettle \
+  --enable-vnc \
+  --enable-vnc-sasl \
+  --enable-vnc-jpeg \
+  --enable-vnc-png \
+  --enable-membarrier \
+  --enable-slirp=3Dgit \
+  --disable-kvm \
+  --enable-hax \
+  --enable-whpx \
+  --disable-spice \
+  --enable-lzo \
+  --enable-snappy \
+  --enable-bzip2 \
+  --enable-vdi \
+  --enable-qcow1 \
+  --enable-tools \
+  --enable-libusb \
+  --enable-usb-redir \
+  --enable-libnfs \
+  --enable-libssh \
+  --disable-pie
+make -j$NUMBER_OF_PROCESSORS
+# make check
diff --git a/scripts/ci/windows/msys2_install.sh b/scripts/ci/windows/msys2=
_install.sh
new file mode 100644
index 0000000000..ff35b73ef2
--- /dev/null
+++ b/scripts/ci/windows/msys2_install.sh
@@ -0,0 +1,31 @@
+pacman --noconfirm -S --needed \=0D
+base-devel \=0D
+git \=0D
+mingw-w64-x86_64-python \=0D
+mingw-w64-x86_64-python-setuptools \=0D
+mingw-w64-x86_64-toolchain \=0D
+mingw-w64-x86_64-SDL2 \=0D
+mingw-w64-x86_64-SDL2_image \=0D
+mingw-w64-x86_64-gtk3 \=0D
+mingw-w64-x86_64-ninja \=0D
+mingw-w64-x86_64-make \=0D
+mingw-w64-x86_64-lzo2 \=0D
+mingw-w64-x86_64-libjpeg-turbo \=0D
+mingw-w64-x86_64-pixman \=0D
+mingw-w64-x86_64-libgcrypt \=0D
+mingw-w64-x86_64-capstone \=0D
+mingw-w64-x86_64-libpng \=0D
+mingw-w64-x86_64-libssh \=0D
+mingw-w64-x86_64-libxml2 \=0D
+mingw-w64-x86_64-snappy \=0D
+mingw-w64-x86_64-libusb \=0D
+mingw-w64-x86_64-usbredir \=0D
+mingw-w64-x86_64-libtasn1 \=0D
+mingw-w64-x86_64-libnfs \=0D
+mingw-w64-x86_64-nettle \=0D
+mingw-w64-x86_64-cyrus-sasl \=0D
+mingw-w64-x86_64-curl \=0D
+mingw-w64-x86_64-gnutls \=0D
+mingw-w64-x86_64-zstd \=0D
+mingw-w64-x86_64-glib2=0D
+=0D
--=20
2.28.0.windows.1


