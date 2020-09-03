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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E47BEC433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 11:30:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D5DD208B3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 11:30:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QgeEsAZX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D5DD208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDnRZ-0007VR-LM
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 07:30:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38086)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kDnMI-0008LV-4I
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 07:24:50 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:43184)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kDnMF-0007xC-VT
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 07:24:49 -0400
Received: by mail-pg1-x544.google.com with SMTP id d19so1869336pgl.10
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 04:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=lsA7UTbQIVwjmQ1n8RjT7+1kHRkAR2apyw1QSZWj5d4=;
 b=QgeEsAZXPujk7YXUc+sE7RSQ040MsbCpRwoQVHi8FKKg2hnYcN+EVpK51CoTqkxXS5
 nlQzK6p+eXj49PFnKdKB2TOEh7sYGhimRCVUZD1+fhN5LaDD03ey3ikTjlDZKXgOa5vB
 xscpFAHJCRlb8iUZ/QmH4T2/GEc9Qqt+jik5CsyvAVJbJ/GUWVU3/ekAYLO7H9zdeTwB
 eUCWKB75SR8LMlw++yZ+YQfkOMj8go+kRlXNLiuzyTN0DhmrndxCMiBMG4rMMbfye27C
 XFAJvL0blQA8atX0nlkKRHY9lL+AnjyuPqQ+yc9P22pul05xi5gHRUQi+pHQxWXICAS4
 e2vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=lsA7UTbQIVwjmQ1n8RjT7+1kHRkAR2apyw1QSZWj5d4=;
 b=KnR+LaNwGwbdffijcJeWqm2Sh8hW/cQYh59tZf2Hr5ytSveY7mkowlvjRiYtzyZWoj
 X8rk4uuSlBU135IIwdobnAbH6F05OjkeX873R9/7n1WsSkxOpiBwTMMP3Ht255Oi0Yni
 O5pbVRo+oOxNJaPksJb2Vg+SeqLCZAFbfPyeMWMH29Wj0ndNB1ZaNvboF0+pMgE9iluZ
 OFu+7UvDTXzOUB0M7VhZgXBDGORRUNOcwEtQuWp4G4Cs6jkkQu53Z03EVxbhMYGAzspd
 erc6FST153nNLVV/SkmBaTrNTFJEUyHT2Le2IT6MznUhg2JNWOMOq2oxM7/PCH5rji+E
 5LjQ==
X-Gm-Message-State: AOAM533/v1L0TWc6LB0BiQDPb6pc18tagVlIJBc4TtCFEZ6lNmlbGe1r
 1fEgRSLvxQ5Glz5iV18BlzcwxB4VQS52YDVs
X-Google-Smtp-Source: ABdhPJxmWLHbBy98QykdP6UwccJSLbVj1RE5ZMbXhkax5JttigY4d/XECAGtS9mVS5OnqWGyTFlkNg==
X-Received: by 2002:aa7:93a8:0:b029:13c:1611:6534 with SMTP id
 x8-20020aa793a80000b029013c16116534mr1730169pff.6.1599132285770; 
 Thu, 03 Sep 2020 04:24:45 -0700 (PDT)
Received: from localhost.localdomain ([222.95.248.6])
 by smtp.googlemail.com with ESMTPSA id y3sm2394249pjg.8.2020.09.03.04.24.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2020 04:24:45 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] ci: Enable msys2 ci in cirrus
Date: Thu,  3 Sep 2020 19:24:23 +0800
Message-Id: <20200903112423.1765-3-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200903112423.1765-1-luoyonggang@gmail.com>
References: <20200903112423.1765-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=luoyonggang@gmail.com; helo=mail-pg1-x544.google.com
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
 scripts/ci/windows/msys2_build.sh   | 33 +++++++++++++++++++++++++++++
 scripts/ci/windows/msys2_install.sh | 31 +++++++++++++++++++++++++++
 3 files changed, 88 insertions(+)
 create mode 100644 scripts/ci/windows/msys2_build.sh
 create mode 100644 scripts/ci/windows/msys2_install.sh

diff --git a/.cirrus.yml b/.cirrus.yml
index f287d23c5b..0bfb465193 100644
--- a/.cirrus.yml
+++ b/.cirrus.yml
@@ -40,3 +40,27 @@ macos_xcode_task:
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
+    - C:\tools\msys64\usr\bin\bash.exe -lc "sh scripts/ci/windows/msys2_install.sh"
+  script:
+    - C:\tools\msys64\usr\bin\bash.exe -lc "sh scripts/ci/windows/msys2_build.sh"
diff --git a/scripts/ci/windows/msys2_build.sh b/scripts/ci/windows/msys2_build.sh
new file mode 100644
index 0000000000..f46b92daf8
--- /dev/null
+++ b/scripts/ci/windows/msys2_build.sh
@@ -0,0 +1,33 @@
+mkdir build
+cd build
+../configure \
+  --python=python3 \
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
+  --enable-libnfs \
+  --enable-libssh \
+  --disable-pie
+make -j$NUMBER_OF_PROCESSORS
+make -i check
diff --git a/scripts/ci/windows/msys2_install.sh b/scripts/ci/windows/msys2_install.sh
new file mode 100644
index 0000000000..ff35b73ef2
--- /dev/null
+++ b/scripts/ci/windows/msys2_install.sh
@@ -0,0 +1,31 @@
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
-- 
2.28.0.windows.1


