Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CCE1C2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 16:29:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7041206B8
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 16:29:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tBFzAM1M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7041206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kG2yW-000635-QD
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 12:29:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54996)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kG2ky-00015b-3T; Wed, 09 Sep 2020 12:15:37 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:40352)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kG2kv-0006dg-HC; Wed, 09 Sep 2020 12:15:35 -0400
Received: by mail-pf1-x441.google.com with SMTP id x123so2580226pfc.7;
 Wed, 09 Sep 2020 09:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=3P5Y7jpFx1Yl0p+ItkTNk+NDL4lE8BqiE6M7PKk1GHM=;
 b=tBFzAM1MBZ2zieyL6Pq4KVjfEHw0ABnBsqxcPftcePmlgyMwkvL6VnL9uhZjKmaXdX
 /UoWb93Xu7GP23jYGLOOShCOFUtEShwBr9yGPXvgMSEEYRlrMUUdLk3dPH2kIeUakFpZ
 TiipBp+iOhsXeFgUIlvOUmzciq3VzI+cY2kCoi2FSBIfdudyoWrnxenQnDQAmgl9Effz
 KFAyKZ4ypjHsPxDSFFQM4FnRXU3l9ihD8o8r9LyaIULQhyXScA7ULZjKF9JMIZUsrFBd
 Dk+S4I00zk5aZ1z0hKfvezJGxY9YT4b0q6xC4NabBmG6muFUE9uAGvaMDCknitWq7tMd
 ZRiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=3P5Y7jpFx1Yl0p+ItkTNk+NDL4lE8BqiE6M7PKk1GHM=;
 b=DsvSKAG6enFETwgHEpSVhuedmwiQUSSuBpTnpxyNe3LRde8y6Ns5MpeRw9+LNX4Wuz
 yLdeWOXMdbS1IqJR9edCNkwyH4nsqyGcOljVpSMQ4uyEnnVJPBFjbquqAfYW0ptc15gh
 aVV8Dij2R2mk+hi3zEu3ioWvMMB7zOIyQARaHfzEPcN61wsVe1hn2uSdAlAVhyfmQ1nw
 H2LUnXDAPVe/iOriwErcUVtBBiILdMgfglUoTBlpIMYKbUU9vJxn79mlPemj4lORtZ/x
 1NxtNllDuzTyF2wek9AbypqHwPNF7l9ljKglgffSbiHPznk/e3KK6s4oWUkg9Hdv3l9X
 1ZsA==
X-Gm-Message-State: AOAM532ve2KO8NUgK37tDLKOBpRPwo9KB/j+vjAFoTmJu8L0rmhibDXp
 hdFdiQ3jE0QCEy6WQmcTaZ9uScuvG1VuKdYq
X-Google-Smtp-Source: ABdhPJyyFHkoi41RmHqiqV9T9Zdro/cP4B2X4ReoZYMD5+WpUhWVGBntD5z9OIHvW7v3I+u/+wj0bQ==
X-Received: by 2002:a62:8607:0:b029:13c:1611:6593 with SMTP id
 x7-20020a6286070000b029013c16116593mr1501547pfd.16.1599668131197; 
 Wed, 09 Sep 2020 09:15:31 -0700 (PDT)
Received: from localhost.localdomain ([222.95.248.6])
 by smtp.googlemail.com with ESMTPSA id l123sm2506987pgl.24.2020.09.09.09.15.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2020 09:15:30 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 24/24] ci: Enable msys2 ci in cirrus
Date: Thu, 10 Sep 2020 00:14:30 +0800
Message-Id: <20200909161430.1789-11-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200909161430.1789-1-luoyonggang@gmail.com>
References: <20200909161430.1789-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=luoyonggang@gmail.com; helo=mail-pf1-x441.google.com
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
Cc: Kevin Wolf <kwolf@redhat.com>, Ed Maste <emaste@freebsd.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-block@nongnu.org,
 Stefan Weil <sw@weilnetz.de>, Xie Changlong <xiechanglong.d@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Wen Congyang <wencongyang2@huawei.com>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Peter Lieven <pl@kamp.de>
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
 .cirrus.yml | 59 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/.cirrus.yml b/.cirrus.yml
index a18971aac4..f819d202db 100644
--- a/.cirrus.yml
+++ b/.cirrus.yml
@@ -44,3 +44,62 @@ macos_xcode_task:
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
+    - C:\tools\msys64\usr\bin\bash.exe -lc "pacman --noconfirm -S --needed
+        base-devel
+        git
+        mingw-w64-x86_64-python
+        mingw-w64-x86_64-python-setuptools
+        mingw-w64-x86_64-toolchain
+        mingw-w64-x86_64-SDL2
+        mingw-w64-x86_64-SDL2_image
+        mingw-w64-x86_64-gtk3
+        mingw-w64-x86_64-glib2
+        mingw-w64-x86_64-ninja
+        mingw-w64-x86_64-make
+        mingw-w64-x86_64-jemalloc
+        mingw-w64-x86_64-lzo2
+        mingw-w64-x86_64-zstd
+        mingw-w64-x86_64-libjpeg-turbo
+        mingw-w64-x86_64-pixman
+        mingw-w64-x86_64-libgcrypt
+        mingw-w64-x86_64-capstone
+        mingw-w64-x86_64-libpng
+        mingw-w64-x86_64-libssh
+        mingw-w64-x86_64-libxml2
+        mingw-w64-x86_64-snappy
+        mingw-w64-x86_64-libusb
+        mingw-w64-x86_64-usbredir
+        mingw-w64-x86_64-libtasn1
+        mingw-w64-x86_64-libnfs
+        mingw-w64-x86_64-nettle
+        mingw-w64-x86_64-cyrus-sasl
+        mingw-w64-x86_64-curl
+        mingw-w64-x86_64-gnutls
+        mingw-w64-x86_64-zstd"
+  script:
+    - mkdir build
+    - cd build
+    - ../configure --python=python3 --enable-werror --ninja=ninja --disable-pie
+    - make -j$NUMBER_OF_PROCESSORS
+    - make check
-- 
2.28.0.windows.1


