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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8B2CC43461
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 16:38:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 399F420C09
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 16:38:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Db6vemj1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 399F420C09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46518 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kG37Z-0005P8-AB
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 12:38:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60802)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kG372-0004zt-An; Wed, 09 Sep 2020 12:38:24 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:37302)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kG370-0001n3-Hs; Wed, 09 Sep 2020 12:38:24 -0400
Received: by mail-pf1-x441.google.com with SMTP id w7so2646253pfi.4;
 Wed, 09 Sep 2020 09:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=mcEgwoPfkIo4jwm2SHJ+JwvDx87lf8gxLPF78FEt0BI=;
 b=Db6vemj1yAHFaQEoU1CJCPrUZEKME8kn7pzm4oCB1pDYJ+v2Lei2/Qc8yp9wZCh9ki
 Wuu6vGrx2NkwovQNf+JrunsohABcWfq7aLjKxHi3TNCunaHUzUY6lbqhUdc5efN2vw4U
 WO7DZDpkWvHJt5nPl6w9fm1BICDIoLiZ7dxQtlKYV18Uv6zc1SPzeYLJRoq6Ti70fhzo
 OgCLk620l7DSxD/ehatcumqT6rX2UKJBiwsqihx+BBx9KRDZBQNKxikVeliOOthty5Bn
 5pS3Z8OR4OWfMZRQH8XFe7koWQPt61UQVJC+6e4uRMUyie0x+UpN/P5erRAAIvYhTHHb
 8cXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=mcEgwoPfkIo4jwm2SHJ+JwvDx87lf8gxLPF78FEt0BI=;
 b=HBax7zCHFoBM/Sft/Yb37vFQVxLQiWXgby3ewhK5cdxvLaZDGUxNe9UY2U5Y5/LpAt
 4H/C1T3TDCpynzSrhWHt8IjIAcaOPL/ic2Bg3ee7WjOmnPUQ9VXJaCs9Pr1+m8gOuWDc
 5lKicbWsttlFWEi9evfVd/2/3fWrLSJa16z2eaqOwIpioVG3IFPOtn2kwhZJPcxORD2c
 FoW1jMY4cs6CUpq8sB1oBDitF+XI9CO92zO+t08dMPwBZvtw+r2+pzB3uyZka97tIZuR
 DpdU93jVxMRYdLhm5g1UodOg84b0ZnlZ67GeSaFAO2ElZ59eI8oa8V6BrNZavTVoLkcf
 6Epg==
X-Gm-Message-State: AOAM533mDV1kjD2RTUdT+1ejswmxoVvDRmh0YcDimeuq5+VIs0QuNyip
 /2ANT3eOG9Qj/MEXyo3OlnmNiHORSDPSWW/d
X-Google-Smtp-Source: ABdhPJzyJCYKJlpJIh0e7d0xdXUvrSpC1chw/x1Flu+F2uvt8P3CrOOW0iiDpTAsTeV40hhVC3bePw==
X-Received: by 2002:a17:902:b192:b029:d0:cbe1:e7a1 with SMTP id
 s18-20020a170902b192b02900d0cbe1e7a1mr1760823plr.18.1599669499614; 
 Wed, 09 Sep 2020 09:38:19 -0700 (PDT)
Received: from localhost.localdomain ([222.95.248.6])
 by smtp.googlemail.com with ESMTPSA id d17sm3309354pfq.157.2020.09.09.09.38.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2020 09:38:18 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 24/24] ci: Enable msys2 ci in cirrus
Date: Thu, 10 Sep 2020 00:38:02 +0800
Message-Id: <20200909163802.872-1-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
 Wen Congyang <wencongyang2@huawei.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Peter Lieven <pl@kamp.de>
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
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 .cirrus.yml | 58 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/.cirrus.yml b/.cirrus.yml
index a18971aac4..dfe58642a4 100644
--- a/.cirrus.yml
+++ b/.cirrus.yml
@@ -44,3 +44,61 @@ macos_xcode_task:
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
+    - C:\tools\msys64\usr\bin\bash.exe -lc "mkdir build"
+    - C:\tools\msys64\usr\bin\bash.exe -lc "cd build && ../configure --python=python3 --ninja=ninja"
+    - C:\tools\msys64\usr\bin\bash.exe -lc "cd build && make -j$NUMBER_OF_PROCESSORS"
+    - C:\tools\msys64\usr\bin\bash.exe -lc "cd build && make check"
-- 
2.28.0.windows.1


