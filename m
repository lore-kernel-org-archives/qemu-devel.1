Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FCC4C4363D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 10:57:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DABCF2080A
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 10:57:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IXH/EroV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DABCF2080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39816 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQ789-0005Cz-S3
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 06:57:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49536)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kQ76l-00047Y-9e; Wed, 07 Oct 2020 06:55:43 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d]:52188)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kQ76i-0002B7-S9; Wed, 07 Oct 2020 06:55:42 -0400
Received: by mail-pj1-x102d.google.com with SMTP id a17so852580pju.1;
 Wed, 07 Oct 2020 03:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=VqD/zYpr/sdk/Y+r0fUPKbQDVWYPXq2xh1NgEd97x/c=;
 b=IXH/EroVMEBY3BBdR2hVmt9s6VXxTqwzWzUxnY/FGDbnPvZCgvQ42HYrZPW2etYoyR
 JSc0FZGDEJouNoJpF84v+l4oVP03DvOJ2WXcM8BE1Y1FSEXhHdE4YXU2V3aRYg5vXU40
 Fi8GIdj4VYEpN7eEo1VO07w9ntpXFWW22Y5BrHVjkCxt8v/Yoe5MS5M8E8Hpb34XdFHP
 ZuqSZZ4/y0g8FFzBPzlXl3BZ2w1gWM4klNsUL+JLNr3ScmXCIUxvNPo3TNi7DnawHEqJ
 V24lGig6XBxjYf75oLwZpWvQH9ExlVtse1dsJc7t0V8onI1Xe3jYOSobW+Qidmlc0S2J
 wMQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=VqD/zYpr/sdk/Y+r0fUPKbQDVWYPXq2xh1NgEd97x/c=;
 b=g3NXL9OMIHayYixmwTEqpctQhUN1KhsByax+TCZhyM55dRkqP1DXrJB9IY2FrIBEFJ
 qQSnDaQSd+17tx88XMNk6lUM151N15BZ2EqDAnsXKHKX1IpesfzZDSP0Z6TbulDEblf1
 2iWxPwz+lGC0FcInCyVY0AZ18p9t91Tbf9uY1HRLOod0IfD28h/3tU8wjjenryAg+PPL
 TO++wJOxzwRLsQvV/GBInr3hXarSugjOboBYFb3jNcBGKHgUrU6TjsYiu1MhNSIGh7hV
 b0xFeH3tCQKHW4NWUiYCK797XKnueHF9DiG5u1RlM4dQc0UBJ2EUh4tTPwJwsqC7UOhA
 SJOQ==
X-Gm-Message-State: AOAM5320l40fx6AZVZXdlzVSTT6HQuvihYqJSjMaOX7OYIJE/EkhTouV
 DBQSbsEQSjQd3J7FT5mpy8joq65t1EaTIA==
X-Google-Smtp-Source: ABdhPJzJATI33I/IXE8bO2A2u3HhKEAutq7T48HxCyFrRJm9g1iHb5ko8XxEV+MY2TJ4jf1oFHzezw==
X-Received: by 2002:a17:902:7e82:b029:d3:f3b5:d99a with SMTP id
 z2-20020a1709027e82b02900d3f3b5d99amr1485433pla.7.1602068138011; 
 Wed, 07 Oct 2020 03:55:38 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id d6sm1947351pjz.12.2020.10.07.03.55.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2020 03:55:37 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 1/2] cirrus: Fixing and speedup the msys2/mingw CI
Date: Wed,  7 Oct 2020 18:55:17 +0800
Message-Id: <20201007105518.1019-2-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20201007105518.1019-1-luoyonggang@gmail.com>
References: <20201007105518.1019-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=luoyonggang@gmail.com; helo=mail-pj1-x102d.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 QEMU Trivial <qemu-trivial@nongnu.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Yonggang Luo <luoyonggang@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use cache of cirrus caching msys2
The install of msys2 are refer to https://github.com/msys2/setup-msys2
The first time install msys2 would be time consuming, so increase timeout_in to 90m
according to https://cirrus-ci.org/faq/#instance-timed-out

Apply patch of https://lists.gnu.org/archive/html/qemu-devel/2020-10/msg00072.html

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 .cirrus.yml | 104 +++++++++++++++++++++++++++++-----------------------
 1 file changed, 59 insertions(+), 45 deletions(-)

diff --git a/.cirrus.yml b/.cirrus.yml
index d58782ce67..b58fb63521 100644
--- a/.cirrus.yml
+++ b/.cirrus.yml
@@ -46,64 +46,78 @@ macos_xcode_task:
     - gmake check
 
 windows_msys2_task:
+  timeout_in: 90m
   windows_container:
-    image: cirrusci/windowsservercore:cmake
+    image: cirrusci/windowsservercore:2019
     os_version: 2019
     cpu: 8
     memory: 8G
   env:
+    CIRRUS_SHELL: powershell
     MSYS: winsymlinks:nativestrict
     MSYSTEM: MINGW64
     CHERE_INVOKING: 1
-  printenv_script:
-    - C:\tools\msys64\usr\bin\bash.exe -lc 'printenv'
+  msys2_cache:
+      folder: C:\tools\msys64
+      reupload_on_changes: false
+      fingerprint_script: cat .cirrus.yml
+      populate_script:
+        - |
+          Write-Output $env:PATH
+          md C:\tools
+          $start_time = Get-Date
+          cd C:\tools
+          bitsadmin /transfer msys_download /dynamic /download /priority FOREGROUND https://github.com/msys2/msys2-installer/releases/download/2020-09-03/msys2-base-x86_64-20200903.sfx.exe C:\tools\base.exe
+          Write-Output "Download time taken: $((Get-Date).Subtract($start_time).Seconds) second(s)"
+          C:\tools\base.exe -y
+          ((Get-Content -path C:\tools\msys64\etc\\post-install\\07-pacman-key.post -Raw) -replace '--refresh-keys', '--version') | Set-Content -Path C:\tools\msys64\etc\\post-install\\07-pacman-key.post
+          C:\tools\msys64\usr\bin\bash.exe -lc "sed -i 's/^CheckSpace/#CheckSpace/g' /etc/pacman.conf"
+          C:\tools\msys64\usr\bin\bash.exe -lc "export"
+          C:\tools\msys64\usr\bin\bash.exe -lc "grep -rl 'repo.msys2.org/' /etc/pacman.d/mirrorlist.* | xargs sed -i 's/repo.msys2.org\//mirrors.tuna.tsinghua.edu.cn\/msys2\//g'"
+          C:\tools\msys64\usr\bin\pacman.exe --noconfirm -Sy
+          echo Y | C:\tools\msys64\usr\bin\pacman.exe --noconfirm -Suu --overwrite '*'
+          taskkill /F /FI "MODULES eq msys-2.0.dll"
+          tasklist
+          C:\tools\msys64\usr\bin\bash.exe -lc "mv -f /etc/pacman.conf.pacnew /etc/pacman.conf || true"
+          C:\tools\msys64\usr\bin\bash.exe -lc "pacman --noconfirm -Suu --overwrite '*'"
+          C:\tools\msys64\usr\bin\bash.exe -lc "pacman --noconfirm -S --needed \
+            diffutils git grep make pkg-config sed \
+            mingw-w64-x86_64-python \
+            mingw-w64-x86_64-python-setuptools \
+            mingw-w64-x86_64-toolchain \
+            mingw-w64-x86_64-SDL2 \
+            mingw-w64-x86_64-SDL2_image \
+            mingw-w64-x86_64-gtk3 \
+            mingw-w64-x86_64-glib2 \
+            mingw-w64-x86_64-ninja \
+            mingw-w64-x86_64-jemalloc \
+            mingw-w64-x86_64-lzo2 \
+            mingw-w64-x86_64-zstd \
+            mingw-w64-x86_64-libjpeg-turbo \
+            mingw-w64-x86_64-pixman \
+            mingw-w64-x86_64-libgcrypt \
+            mingw-w64-x86_64-libpng \
+            mingw-w64-x86_64-libssh \
+            mingw-w64-x86_64-libxml2 \
+            mingw-w64-x86_64-snappy \
+            mingw-w64-x86_64-libusb \
+            mingw-w64-x86_64-usbredir \
+            mingw-w64-x86_64-libtasn1 \
+            mingw-w64-x86_64-nettle \
+            mingw-w64-x86_64-cyrus-sasl \
+            mingw-w64-x86_64-curl \
+            mingw-w64-x86_64-gnutls \
+            "
   install_script:
-    - C:\tools\msys64\usr\bin\bash.exe -lc "cd /c/tools &&
-        curl -O http://repo.msys2.org/msys/x86_64/msys2-keyring-r21.b39fb11-1-any.pkg.tar.xz"
-    - C:\tools\msys64\usr\bin\bash.exe -lc "cd /c/tools &&
-        curl -O http://repo.msys2.org/msys/x86_64/msys2-keyring-r21.b39fb11-1-any.pkg.tar.xz.sig"
-    - C:\tools\msys64\usr\bin\bash.exe -lc "cd /c/tools &&
-        pacman -U --noconfirm msys2-keyring-r21.b39fb11-1-any.pkg.tar.xz"
-    - C:\tools\msys64\usr\bin\bash.exe -lc "pacman --noconfirm -Sy"
-    - C:\tools\msys64\usr\bin\bash.exe -lc "pacman --noconfirm -S --needed
-        bash pacman pacman-mirrors msys2-runtime"
-    - taskkill /F /IM gpg-agent.exe
-    - C:\tools\msys64\usr\bin\bash.exe -lc "pacman --noconfirm -Su"
-    - C:\tools\msys64\usr\bin\bash.exe -lc "pacman --noconfirm -S --needed
-        base-devel
-        git
-        mingw-w64-x86_64-python
-        mingw-w64-x86_64-python-setuptools
-        mingw-w64-x86_64-toolchain
-        mingw-w64-x86_64-capstone
-        mingw-w64-x86_64-SDL2
-        mingw-w64-x86_64-SDL2_image
-        mingw-w64-x86_64-gtk3
-        mingw-w64-x86_64-glib2
-        mingw-w64-x86_64-ninja
-        mingw-w64-x86_64-make
-        mingw-w64-x86_64-lzo2
-        mingw-w64-x86_64-zstd
-        mingw-w64-x86_64-libjpeg-turbo
-        mingw-w64-x86_64-pixman
-        mingw-w64-x86_64-libgcrypt
-        mingw-w64-x86_64-libpng
-        mingw-w64-x86_64-libssh
-        mingw-w64-x86_64-libxml2
-        mingw-w64-x86_64-snappy
-        mingw-w64-x86_64-libusb
-        mingw-w64-x86_64-usbredir
-        mingw-w64-x86_64-libtasn1
-        mingw-w64-x86_64-nettle
-        mingw-w64-x86_64-cyrus-sasl
-        mingw-w64-x86_64-curl
-        mingw-w64-x86_64-gnutls
-        mingw-w64-x86_64-zstd"
+    - |
+      Write-Output $env:PATH
+      C:\tools\msys64\usr\bin\bash.exe -lc "export"
+
   script:
     - C:\tools\msys64\usr\bin\bash.exe -lc "mkdir build"
     - C:\tools\msys64\usr\bin\bash.exe -lc "cd build && ../configure
       --python=python3 --ninja=ninja
       --target-list-exclude=i386-softmmu,arm-softmmu,ppc-softmmu,mips-softmmu"
-    - C:\tools\msys64\usr\bin\bash.exe -lc "cd build && make -j$NUMBER_OF_PROCESSORS"
+    - C:\tools\msys64\usr\bin\bash.exe -lc "cd build && make -j8"
   test_script:
     - C:\tools\msys64\usr\bin\bash.exe -lc "cd build && make V=1 check"
-- 
2.28.0.windows.1


