Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51D2CC433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 17:02:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BA1A2067C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 17:02:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rvkRQQvn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BA1A2067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDW9P-0001yB-5k
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 13:02:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45354)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kDW8Q-0000Ew-Db
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 13:01:22 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:42994)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kDW8O-0000I3-BS
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 13:01:22 -0400
Received: by mail-pl1-x643.google.com with SMTP id j11so31339plk.9
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2020 10:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=gZugdAc0YYQQQMUJH814Yqj9KG0APjmY2BrDJE6YAjA=;
 b=rvkRQQvnFKYlB9Fk9yNrnqjpzSTP7BNzoPCS7ACQ1zsJigcJytrv4b9rBkKsPRUD2+
 1tsZR9dfiKMnC1FVyJyTAzJVHH6oQsl3epmNZIxSkvL1aIMT4AZWPBniRVIhy1CgP/s6
 6N9QO0U84pHwkBSASHBXtk/TWM9LVrrIfZ0zzy9aIjhMGj6r7+zqNzOKPD0hXHN+21f6
 vjQmCS3LCBPmYKxlYUtgGomE0cuhI6q5+9SluMxlIhwppPDoofFBojyhz+ED1D/ge2Io
 oJMHjWJknPaAwOkkaUNhrI9LQrhVFZC7NHCPBNFVug3f2UJGoi7EC8pFY+u+/a2CO96+
 XlnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=gZugdAc0YYQQQMUJH814Yqj9KG0APjmY2BrDJE6YAjA=;
 b=pI7nFviyhvwNbptTWTbiFPplu2heBU0PRCuY335vHhQuDpVZ0xtOJ4RvBoM32BHLMo
 1Nk5QehcPiHNeEnZXhwPm4lMgDO0/ceeJ7VEGmR6UV2IQl+JNOCktXysVSvE/yYctz/a
 8QA3Uo5ntZSxAge70gEkHMsosQkKTFFv0zmVcspdwC6oRw4eJKM9gwL0933+rXM8M5M1
 7F6CB/2Hf4cSQZ2iVAPavE0QNGfW+PiayDLlXRq18fnq8Q3OsgVC7m4VIIfyMrdhy3Nc
 +11aLy1/pKf3eng/sDjrxDxftl87ncW69aals0Pd+C14jqpn7v6KkNuelwhIgql2dCjq
 Urnw==
X-Gm-Message-State: AOAM530ldhCI54zIm+48XdzmBDSP2d4Z//lSvcR+hLZeFcjN1Zj7RseK
 CxO2tOUYlxPCtVCFybOGfJOFby3Ny94=
X-Google-Smtp-Source: ABdhPJyQaWqgXwZIJUlgmFK8GZFOYxD6y4pov31ZKOfQ5JGByy8/1rKhOZP0s13INLg5aef+VHvpMA==
X-Received: by 2002:a17:90b:88d:: with SMTP id
 bj13mr2981044pjb.80.1599066078441; 
 Wed, 02 Sep 2020 10:01:18 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id x4sm40527pfm.86.2020.09.02.10.01.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2020 10:01:17 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/6] ci: Install msys2 in a proper way refer to
 https://github.com/cirruslabs/cirrus-ci-docs/issues/699 Enable msys2 ci in
 cirrus
Date: Thu,  3 Sep 2020 01:00:51 +0800
Message-Id: <20200902170054.810-4-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.27.0.windows.1
In-Reply-To: <20200902170054.810-1-luoyonggang@gmail.com>
References: <20200902170054.810-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::643;
 envelope-from=luoyonggang@gmail.com; helo=mail-pl1-x643.google.com
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

---
 .cirrus.yml                         | 23 ++++++++++++++++
 scripts/ci/windows/msys2_build.sh   | 35 ++++++++++++++++++++++++
 scripts/ci/windows/msys2_install.sh | 41 +++++++++++++++++++++++++++++
 3 files changed, 99 insertions(+)
 create mode 100644 scripts/ci/windows/msys2_build.sh
 create mode 100644 scripts/ci/windows/msys2_install.sh

diff --git a/.cirrus.yml b/.cirrus.yml
index f287d23c5b..d377c28412 100644
--- a/.cirrus.yml
+++ b/.cirrus.yml
@@ -40,3 +40,26 @@ macos_xcode_task:
     - ../configure --cc=clang || { cat config.log; exit 1; }
     - gmake -j$(sysctl -n hw.ncpu)
     - gmake check
+
+windows_msys2_task:
+  windows_container:
+    image: cirrusci/windowsservercore:cmake
+    os_version: 2019
+    cpu: 8
+    memory: 8G
+  env:
+    MSYS: winsymlinks:nativestrict
+    MSYSTEM: MINGW64
+    CHERE_INVOKING: 1
+  printenv_script: C:\tools\msys64\usr\bin\bash.exe -lc 'printenv'
+  install_script:
+    - C:\tools\msys64\usr\bin\bash.exe -lc "cd /c/tools && curl -O http://repo.msys2.org/msys/x86_64/msys2-keyring-r21.b39fb11-1-any.pkg.tar.xz"
+    - C:\tools\msys64\usr\bin\bash.exe -lc "cd /c/tools && curl -O http://repo.msys2.org/msys/x86_64/msys2-keyring-r21.b39fb11-1-any.pkg.tar.xz.sig"
+    - C:\tools\msys64\usr\bin\bash.exe -lc "cd /c/tools && pacman -U --noconfirm msys2-keyring-r21.b39fb11-1-any.pkg.tar.xz"
+    - C:\tools\msys64\usr\bin\bash.exe -lc "pacman -Sy --noconfirm"
+    - C:\tools\msys64\usr\bin\bash.exe -lc "pacman --needed --noconfirm -S bash pacman pacman-mirrors msys2-runtime"
+    - taskkill /F /IM gpg-agent.exe
+    - C:\tools\msys64\usr\bin\bash.exe -lc "pacman --noconfirm -Su"
+    - C:\tools\msys64\usr\bin\bash.exe -lc "sh scripts/ci/windows/msys2_install.sh"
+  script:
+    C:\tools\msys64\usr\bin\bash.exe -lc "sh scripts/ci/windows/msys2_build.sh"
diff --git a/scripts/ci/windows/msys2_build.sh b/scripts/ci/windows/msys2_build.sh
new file mode 100644
index 0000000000..0363ef402a
--- /dev/null
+++ b/scripts/ci/windows/msys2_build.sh
@@ -0,0 +1,35 @@
+export QEMU_DIR=$PWD
+mkdir ../qemu-build
+cd ../qemu-build
+$QEMU_DIR/configure \
+  --python=python3 \
+  --cross-prefix=x86_64-w64-mingw32- \
+  --enable-gtk --enable-sdl \
+  --enable-capstone=git \
+  --enable-stack-protector \
+  --ninja=ninja \
+  --enable-gnutls \
+  --enable-nettle \
+  --enable-vnc \
+  --enable-vnc-sasl \
+  --enable-vnc-jpeg \
+  --enable-vnc-png \
+  --enable-membarrier \
+  --enable-slirp=git \
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
+  --disable-libnfs \
+  --enable-libssh \
+  --disable-pie
+make -j$NUMBER_OF_PROCESSORS
+# make -j$NUMBER_OF_PROCESSORS check
diff --git a/scripts/ci/windows/msys2_install.sh b/scripts/ci/windows/msys2_install.sh
new file mode 100644
index 0000000000..3a5392cd99
--- /dev/null
+++ b/scripts/ci/windows/msys2_install.sh
@@ -0,0 +1,41 @@
+pacman --noconfirm -S --needed \
+base-devel \
+git \
+mingw-w64-x86_64-python \
+mingw-w64-x86_64-python-setuptools \
+mingw-w64-x86_64-toolchain \
+mingw-w64-x86_64-SDL2 \
+mingw-w64-x86_64-SDL2_image \
+mingw-w64-x86_64-gtk3 \
+mingw-w64-x86_64-ninja \
+mingw-w64-x86_64-make \
+mingw-w64-x86_64-lzo2 \
+mingw-w64-x86_64-libjpeg-turbo \
+mingw-w64-x86_64-pixman \
+mingw-w64-x86_64-libgcrypt \
+mingw-w64-x86_64-capstone \
+mingw-w64-x86_64-libpng \
+mingw-w64-x86_64-libssh \
+mingw-w64-x86_64-libxml2 \
+mingw-w64-x86_64-snappy \
+mingw-w64-x86_64-libusb \
+mingw-w64-x86_64-usbredir \
+mingw-w64-x86_64-libtasn1 \
+mingw-w64-x86_64-libnfs \
+mingw-w64-x86_64-nettle \
+mingw-w64-x86_64-cyrus-sasl \
+mingw-w64-x86_64-curl \
+mingw-w64-x86_64-gnutls \
+mingw-w64-x86_64-zstd \
+mingw-w64-x86_64-glib2
+
+cd /mingw64/bin
+cp x86_64-w64-mingw32-gcc-ar.exe x86_64-w64-mingw32-ar.exe
+cp x86_64-w64-mingw32-gcc-ranlib.exe x86_64-w64-mingw32-ranlib.exe
+cp x86_64-w64-mingw32-gcc-nm.exe x86_64-w64-mingw32-nm.exe
+cp windres.exe x86_64-w64-mingw32-windres.exe
+cp strip.exe x86_64-w64-mingw32-strip.exe
+cp objcopy.exe x86_64-w64-mingw32-objcopy.exe
+cp ld x86_64-w64-mingw32-ld.exe
+cp as x86_64-w64-mingw32-as.exe
+cp sdl2-config x86_64-w64-mingw32-sdl2-config
-- 
2.27.0.windows.1


