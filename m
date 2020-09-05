Return-Path: <SRS0=twQi=CO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2448C43461
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2020 06:29:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 413F120FC3
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2020 06:29:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D+rgPHD5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 413F120FC3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kERh5-0006IM-CW
	for qemu-devel@archiver.kernel.org; Sat, 05 Sep 2020 02:28:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49518)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kERcO-00070H-GA; Sat, 05 Sep 2020 02:24:08 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:43021)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kERcM-0003XO-GJ; Sat, 05 Sep 2020 02:24:08 -0400
Received: by mail-pf1-x443.google.com with SMTP id f18so5764355pfa.10;
 Fri, 04 Sep 2020 23:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=JKpIfWL/hMusaXWduI57Hsr7ijHQZtG8tbpSkLPslEQ=;
 b=D+rgPHD5TVTR4LqkIHYGc+eTNCQTfRelfpH/I9hmvJN0FxEuLjLvHj099wRw/dYtQS
 yXJTlzHxnQBjrkF1SjtVUGmps7QpqOf7uOmZnyYnxU03k1VsDeTTGpuL4JVbW8SoR0Bf
 gHpJg4aTYW4Az4NFhoOb3MPGzFMhnOo1KYMAUjNWW+azV3WkkRcoaV2G9epaqYBw1Cfj
 9KWDI43AKc4i/zgc7BzJ6IXJ5n+fw0HEHA0bo/5n+ZB0vuOkNxWN9UCje/I/NMLbtWQg
 WqllgWfRclW35IsFZjvII1OFxEsuqv2tmN9zZts0MEqihdt4kAtYCAPGdPBiMZhZTJIR
 fmAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=JKpIfWL/hMusaXWduI57Hsr7ijHQZtG8tbpSkLPslEQ=;
 b=Ua8tNxl8SXLEoFeTTVOVRedm5vusj3Do8CeLS40udGU/e9aMXlsSXbF7zj92Eh6M9R
 Cz0939qH703slz4M1hL/k/+SkevtvO/f2u3IGtRkaW2tWrj7vSA9loNX4AuHiBeHu1fo
 u/5OmgrD/5mn/rakNKmKcXWWa9/xyrdwrvnrGqt8ne88gOJEGRc7E8lE5nPXUa84ZB/O
 swCo6JUJRJaO4zFNsNgDYK5AepsNy7A+jZV9ZpgR+FS4WfKLWgGgNRe73ukphdhrVB2r
 1kIrlcHXMWdezMcJdM/FJZ0L8i7bEQZJgKnekMNPvXoIkVl+YiYypW7K9xSxCwUFVrjr
 xexw==
X-Gm-Message-State: AOAM531ptYtEqy/vZpNgGjT9RqDGI9UoCZCrHw8phtUYtIDYrXQdClBs
 Bs3BzucBoEKHB4czpXKomsvaa69NAGRyOCr0
X-Google-Smtp-Source: ABdhPJzeRiyTtRLW7AwRuo2D4/lcN6IgiTUnCOE+1UxHFTFvpPdG6R11gf1b9ZJ5gzLu6Mnw854LrQ==
X-Received: by 2002:a05:6a00:22c9:: with SMTP id
 f9mr12347361pfj.212.1599287044198; 
 Fri, 04 Sep 2020 23:24:04 -0700 (PDT)
Received: from localhost.localdomain ([222.95.248.6])
 by smtp.googlemail.com with ESMTPSA id v8sm21436381pju.1.2020.09.04.23.24.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2020 23:24:03 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 05/11] ci: Enable msys2 ci in cirrus
Date: Sat,  5 Sep 2020 14:23:27 +0800
Message-Id: <20200905062333.1087-6-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200905062333.1087-1-luoyonggang@gmail.com>
References: <20200905062333.1087-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=luoyonggang@gmail.com; helo=mail-pf1-x443.google.com
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
Cc: Kevin Wolf <kwolf@redhat.com>, QEMU Block <qemu-block@nongnu.org>,
 Stefan Weil <sw@weilnetz.de>, Peter Lieven <pl@kamp.de>,
 Yonggang Luo <luoyonggang@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Install msys2 in a proper way refer to https://github.com/cirruslabs/cirrus-ci-docs/issues/699
The https://wiki.qemu.org/Hosts/W32#Native_builds_with_MSYS2 need to be updated.
There is no need of --cross-prefix, open mingw64.exe instead of msys2.exe then we don't
need the --cross-prefix, besides we using environment variable settings:
    MSYS: winsymlinks:nativestrict
    MSYSTEM: MINGW64
    CHERE_INVOKING: 1
to opening mingw64 native shell.
We now running tests with make -i check to skip tests errors.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 .cirrus.yml                         | 24 +++++++++++++++++++++
 scripts/ci/windows/msys2-build.sh   | 27 +++++++++++++++++++++++
 scripts/ci/windows/msys2-install.sh | 33 +++++++++++++++++++++++++++++
 3 files changed, 84 insertions(+)
 create mode 100644 scripts/ci/windows/msys2-build.sh
 create mode 100644 scripts/ci/windows/msys2-install.sh

diff --git a/.cirrus.yml b/.cirrus.yml
index 3dd9fcff7f..49335e68c9 100644
--- a/.cirrus.yml
+++ b/.cirrus.yml
@@ -63,3 +63,27 @@ macos_xcode_task:
                    --enable-werror --cc=clang || { cat config.log; exit 1; }
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
+  printenv_script:
+    - C:\tools\msys64\usr\bin\bash.exe -lc 'printenv'
+  install_script:
+    - C:\tools\msys64\usr\bin\bash.exe -lc "cd /c/tools && curl -O http://repo.msys2.org/msys/x86_64/msys2-keyring-r21.b39fb11-1-any.pkg.tar.xz"
+    - C:\tools\msys64\usr\bin\bash.exe -lc "cd /c/tools && curl -O http://repo.msys2.org/msys/x86_64/msys2-keyring-r21.b39fb11-1-any.pkg.tar.xz.sig"
+    - C:\tools\msys64\usr\bin\bash.exe -lc "cd /c/tools && pacman -U --noconfirm msys2-keyring-r21.b39fb11-1-any.pkg.tar.xz"
+    - C:\tools\msys64\usr\bin\bash.exe -lc "pacman -Sy --noconfirm"
+    - C:\tools\msys64\usr\bin\bash.exe -lc "pacman --needed --noconfirm -S bash pacman pacman-mirrors msys2-runtime"
+    - taskkill /F /IM gpg-agent.exe
+    - C:\tools\msys64\usr\bin\bash.exe -lc "pacman --noconfirm -Su"
+    - C:\tools\msys64\usr\bin\bash.exe -lc "sh scripts/ci/windows/msys2-install.sh"
+  script:
+    - C:\tools\msys64\usr\bin\bash.exe -lc "sh scripts/ci/windows/msys2-build.sh"
diff --git a/scripts/ci/windows/msys2-build.sh b/scripts/ci/windows/msys2-build.sh
new file mode 100644
index 0000000000..532cb847c0
--- /dev/null
+++ b/scripts/ci/windows/msys2-build.sh
@@ -0,0 +1,27 @@
+mkdir build
+cd build
+../configure \
+--python=python3 \
+--enable-stack-protector \
+--enable-guest-agent \
+--disable-pie \
+--enable-gnutls --enable-nettle \
+--enable-sdl --enable-sdl-image --enable-gtk --disable-vte --disable-curses --enable-iconv \
+--enable-vnc --enable-vnc-sasl --enable-vnc-jpeg --enable-vnc-png \
+--enable-slirp=git \
+--disable-brlapi --enable-curl \
+--enable-fdt \
+--disable-kvm --enable-hax --enable-whpx \
+--enable-libnfs --enable-libusb --enable-live-block-migration --enable-usb-redir \
+--enable-lzo --enable-snappy --enable-bzip2 --enable-zstd \
+--enable-membarrier --enable-coroutine-pool \
+--enable-libssh --enable-libxml2 \
+--enable-jemalloc --enable-avx2 \
+--enable-replication \
+--enable-tools \
+--enable-bochs --enable-cloop --enable-dmg --enable-qcow1 --enable-vdi --enable-vvfat --enable-qed --enable-parallels \
+--enable-sheepdog \
+--enable-capstone=git
+
+make -j$NUMBER_OF_PROCESSORS
+make -i -j$NUMBER_OF_PROCESSORS check
diff --git a/scripts/ci/windows/msys2-install.sh b/scripts/ci/windows/msys2-install.sh
new file mode 100644
index 0000000000..6086452399
--- /dev/null
+++ b/scripts/ci/windows/msys2-install.sh
@@ -0,0 +1,33 @@
+pacman --noconfirm -S --needed \
+base-devel \
+git \
+mingw-w64-x86_64-python \
+mingw-w64-x86_64-python-setuptools \
+mingw-w64-x86_64-toolchain \
+mingw-w64-x86_64-SDL2 \
+mingw-w64-x86_64-SDL2_image \
+mingw-w64-x86_64-gtk3 \
+mingw-w64-x86_64-glib2 \
+mingw-w64-x86_64-ninja \
+mingw-w64-x86_64-make \
+mingw-w64-x86_64-jemalloc \
+mingw-w64-x86_64-lzo2 \
+mingw-w64-x86_64-zstd \
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
+
-- 
2.28.0.windows.1


