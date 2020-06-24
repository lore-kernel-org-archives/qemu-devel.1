Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 366D6C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 14:14:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E819D2082F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 14:14:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gd5Vpp7L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E819D2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo6AG-0005wx-46
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 10:14:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33512)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jo68t-00047D-Ot
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 10:12:47 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:38193)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jo68r-0005v0-KQ
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 10:12:47 -0400
Received: by mail-wm1-x333.google.com with SMTP id f18so2682240wml.3
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2020 07:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=gYny8RQMLGvnYX7pxE0cYv3y41J+K9oraa4mW6ajsxI=;
 b=Gd5Vpp7L+pxJ1UyhJa7Iayqcx7za3wgVZYEPEFRIvIP183AjkWg19BllD8Fbw3n02A
 YAaT+g4ocyAqkcGOWbpfmrqTzRb1ndTDrhI1yk0J0kKuvsHvSv41GuOE3U4v5lLCdVea
 AlK1n50e6+wSS7Fg5F61TsfvFVeF7QidmI33/ab8laR3rHhBZFkxi8stGY45Czs1Uc7c
 LoV2hdW5R/T1DHD2h5TX1HEkAce6ZvnoM0atl0T0MhVcsFIx52E2TjAL5tk048TzdQr3
 ksZVpIwA5AK30jVtR7GXiHH1sYKIq2+7k213WtF6CQFnoDYgAv1JfTfmpYJPzDcr9Q3q
 U4BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=gYny8RQMLGvnYX7pxE0cYv3y41J+K9oraa4mW6ajsxI=;
 b=D1ldMzNmibpH5Slpf2RYx9pNtkwb05YbVKG1L3MMaXa4lL4Kfb17oJeGKPBFoMKM0o
 VAIuWH0sgrDHDyIKlTgCR4Ra1H27xmeCZSS6gUj/fJhFNyhUoWV+pBCi7XVo4C9g4R6i
 n1B+31detmRxrtD+PmjPcqJTC4tjTTjHAvJyFER5MVJ7oI3/+r+QNR+kPL0ba3i6pvr2
 75738uGk6V9s8lUzUR7y/VzPyLvGxeYz5Z5FDtz0+fgS+MfP4830TsKSNnNTdShrkzhq
 jXs82uO1igZeG84GTaIDRH8V+/muknMVt6sDrQxSIDy31FLk4j0V/Pi1pjHS59kekZ8I
 2Upg==
X-Gm-Message-State: AOAM531LFQjWIt8cHnKy0MW0SZodvEks1hvz8lD1ndJnNuWlVXYH5MWx
 L4K4cPr3I557Rp8KoUdb5nXj+w==
X-Google-Smtp-Source: ABdhPJxi3TpJlhUdAD+Hn8p6ahxt8mhOWRseW9KYp6QyFRn31Awy7l16EXg0gYbKnMy4k1IWzgzBkg==
X-Received: by 2002:a7b:c1cc:: with SMTP id a12mr21586291wmj.112.1593007963596; 
 Wed, 24 Jun 2020 07:12:43 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id k11sm24741091wrd.23.2020.06.24.07.12.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2020 07:12:40 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 457EE1FF7E;
 Wed, 24 Jun 2020 15:04:48 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 19/25] gitlab: convert jobs to use custom built containers
Date: Wed, 24 Jun 2020 15:04:40 +0100
Message-Id: <20200624140446.15380-20-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200624140446.15380-1-alex.bennee@linaro.org>
References: <20200624140446.15380-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x333.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: fam@euphon.net, Thomas Huth <thuth@redhat.com>, berrange@redhat.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, cota@braap.org,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Daniel P. Berrangé <berrange@redhat.com>

Now that we're building standard container images from
dockerfiles in tests/docker/dockerfiles, we can convert
the build jobs to use them. The key benefit of this is
that a contributor can now more easily replicate the CI
environment on their local machine. The container images
are cached too, so we are not spending time waiting for
the apt-get/dnf package installs to complete.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20200622153318.751107-4-berrange@redhat.com>
[AJB: tweak naming convention]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .gitlab-ci.yml | 187 +++++++++++++++++++++----------------------------
 1 file changed, 81 insertions(+), 106 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 72d688875fd..a7abc55a5c6 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -9,133 +9,108 @@ include:
   - local: '/.gitlab-ci.d/opensbi.yml'
   - local: '/.gitlab-ci.d/containers.yml'
 
-.update_apt_template: &before_script_apt
- before_script:
-  - apt-get update -qq
-  - apt-get install -y -qq git gcc libglib2.0-dev libpixman-1-dev make
-        genisoimage
-  - JOBS=$(expr $(nproc) + 1)
-
-.update_dnf_template: &before_script_dnf
- before_script:
-  - dnf update -y
-  - dnf install -y bzip2 diffutils gcc git genisoimage findutils glib2-devel
-        make python3 perl-podlators perl-Test-Harness pixman-devel zlib-devel
-  - JOBS=$(expr $(nproc) + 1)
+.native_build_job_template: &native_build_job_definition
+  stage: build
+  image: $CI_REGISTRY_IMAGE/qemu/$IMAGE:latest
+  before_script:
+    - JOBS=$(expr $(nproc) + 1)
+  script:
+    - mkdir build
+    - cd build
+    - if test -n "$TARGETS";
+      then
+        ../configure --enable-werror $CONFIGURE_ARGS --target-list="$TARGETS" ;
+      else
+        ../configure --enable-werror $CONFIGURE_ARGS ;
+      fi
+    - make -j"$JOBS"
+    - make -j"$JOBS" $MAKE_CHECK_ARGS
 
 build-system1:
- stage: build
- image: ubuntu:19.10
- <<: *before_script_apt
- script:
- - apt-get install -y -qq libgtk-3-dev libvte-dev nettle-dev libcacard-dev
-      libusb-dev libvde-dev libspice-protocol-dev libgl1-mesa-dev libvdeplug-dev
- - mkdir build
- - cd build
- - ../configure --enable-werror --target-list="aarch64-softmmu alpha-softmmu
-      cris-softmmu hppa-softmmu lm32-softmmu moxie-softmmu microblazeel-softmmu
-      mips64el-softmmu m68k-softmmu ppc-softmmu riscv64-softmmu sparc-softmmu"
- - make -j"$JOBS"
- - make -j"$JOBS" check
+  <<: *native_build_job_definition
+  variables:
+    IMAGE: ubuntu2004
+    TARGETS: aarch64-softmmu alpha-softmmu cris-softmmu hppa-softmmu lm32-softmmu
+      moxie-softmmu microblazeel-softmmu mips64el-softmmu m68k-softmmu ppc-softmmu
+      riscv64-softmmu sparc-softmmu
+    MAKE_CHECK_ARGS: check
 
 build-system2:
- stage: build
- image: fedora:latest
- <<: *before_script_dnf
- script:
- - yum install -y SDL2-devel libgcrypt-devel brlapi-devel libaio-devel
-       libfdt-devel lzo-devel librdmacm-devel libibverbs-devel libibumad-devel
-       libzstd-devel
- - mkdir build
- - cd build
- - ../configure --enable-werror --target-list="tricore-softmmu unicore32-softmmu
-      microblaze-softmmu mips-softmmu riscv32-softmmu s390x-softmmu sh4-softmmu
-      sparc64-softmmu x86_64-softmmu xtensa-softmmu nios2-softmmu or1k-softmmu"
- - make -j"$JOBS"
- - make -j"$JOBS" check
+  <<: *native_build_job_definition
+  variables:
+    IMAGE: fedora
+    TARGETS: tricore-softmmu unicore32-softmmu microblaze-softmmu mips-softmmu
+      riscv32-softmmu s390x-softmmu sh4-softmmu sparc64-softmmu x86_64-softmmu
+      xtensa-softmmu nios2-softmmu or1k-softmmu
+    MAKE_CHECK_ARGS: check
 
 build-disabled:
- stage: build
- image: fedora:latest
- <<: *before_script_dnf
- script:
- - mkdir build
- - cd build
- - ../configure --enable-werror --disable-rdma --disable-slirp --disable-curl
+  <<: *native_build_job_definition
+  variables:
+    IMAGE: fedora
+    CONFIGURE_ARGS: --disable-rdma --disable-slirp --disable-curl
       --disable-capstone --disable-live-block-migration --disable-glusterfs
       --disable-replication --disable-coroutine-pool --disable-smartcard
       --disable-guest-agent --disable-curses --disable-libxml2 --disable-tpm
       --disable-qom-cast-debug --disable-spice --disable-vhost-vsock
       --disable-vhost-net --disable-vhost-crypto --disable-vhost-user
-      --target-list="i386-softmmu ppc64-softmmu mips64-softmmu i386-linux-user"
- - make -j"$JOBS"
- - make -j"$JOBS" check-qtest SPEED=slow
+    TARGETS: i386-softmmu ppc64-softmmu mips64-softmmu i386-linux-user
+    MAKE_CHECK_ARGS: check-qtest SPEED=slow
 
 build-tcg-disabled:
- stage: build
- image: centos:8
- <<: *before_script_dnf
- script:
- - dnf install -y clang gtk3-devel libusbx-devel libgcrypt-devel
- - mkdir build
- - cd build
- - ../configure --cc=clang --enable-werror --disable-tcg --audio-drv-list=""
- - make -j"$JOBS"
- - make check-unit
- - make check-qapi-schema
- - cd tests/qemu-iotests/
- - ./check -raw 001 002 003 004 005 008 009 010 011 012 021 025 032 033 048
+  <<: *native_build_job_definition
+  variables:
+    IMAGE: centos8
+  script:
+    - mkdir build
+    - cd build
+    - ../configure --disable-tcg --audio-drv-list=""
+    - make -j"$JOBS"
+    - make check-unit
+    - make check-qapi-schema
+    - cd tests/qemu-iotests/
+    - ./check -raw 001 002 003 004 005 008 009 010 011 012 021 025 032 033 048
             052 063 077 086 101 104 106 113 148 150 151 152 157 159 160 163
             170 171 183 184 192 194 197 208 215 221 222 226 227 236 253 277
- - ./check -qcow2 028 051 056 057 058 065 067 068 082 085 091 095 096 102 122
+    - ./check -qcow2 028 051 056 057 058 065 067 068 082 085 091 095 096 102 122
             124 132 139 142 144 145 151 152 155 157 165 194 196 197 200 202
             208 209 215 216 218 222 227 234 246 247 248 250 254 255 257 258
             260 261 262 263 264 270 272 273 277 279
 
 build-user:
- stage: build
- <<: *before_script_apt
- script:
- - mkdir build
- - cd build
- - ../configure --enable-werror --disable-system --disable-guest-agent
-               --disable-capstone --disable-slirp --disable-fdt
- - make -j"$JOBS"
- - make run-tcg-tests-i386-linux-user run-tcg-tests-x86_64-linux-user
+  <<: *native_build_job_definition
+  variables:
+    IMAGE: ubuntu2004
+    CONFIGURE_ARGS: --disable-system --disable-guest-agent
+      --disable-capstone --disable-slirp --disable-fdt
+    MAKE_CHECK_ARGS:  run-tcg-tests-i386-linux-user run-tcg-tests-x86_64-linux-user
 
 build-clang:
- stage: build
- image: fedora:latest
- <<: *before_script_dnf
- script:
- - yum install -y clang SDL2-devel libattr-devel libcap-ng-devel xfsprogs-devel
-       libiscsi-devel libnfs-devel libseccomp-devel gnutls-devel librbd-devel
- - mkdir build
- - cd build
- - ../configure --cc=clang --cxx=clang++ --enable-werror
-      --target-list="alpha-softmmu arm-softmmu m68k-softmmu mips64-softmmu
-                     ppc-softmmu s390x-softmmu x86_64-softmmu arm-linux-user"
- - make -j"$JOBS"
- - make -j"$JOBS" check
+  <<: *native_build_job_definition
+  variables:
+    IMAGE: fedora
+    CONFIGURE_ARGS: --cc=clang --cxx=clang++
+    TARGETS: alpha-softmmu arm-softmmu m68k-softmmu mips64-softmmu
+      ppc-softmmu s390x-softmmu x86_64-softmmu arm-linux-user
+    MAKE_CHECK_ARGS: check
 
 build-tci:
- stage: build
- image: centos:8
- <<: *before_script_dnf
- script:
- - TARGETS="aarch64 alpha arm hppa m68k microblaze moxie ppc64 s390x x86_64"
- - mkdir build
- - cd build
- - ../configure --enable-tcg-interpreter
-      --target-list="$(for tg in $TARGETS; do echo -n ${tg}'-softmmu '; done)"
- - make -j"$JOBS"
- - make run-tcg-tests-x86_64-softmmu
- - make tests/qtest/boot-serial-test tests/qtest/cdrom-test tests/qtest/pxe-test
- - for tg in $TARGETS ; do
-     export QTEST_QEMU_BINARY="${tg}-softmmu/qemu-system-${tg}" ;
-     ./tests/qtest/boot-serial-test || exit 1 ;
-     ./tests/qtest/cdrom-test || exit 1 ;
-   done
- - QTEST_QEMU_BINARY="x86_64-softmmu/qemu-system-x86_64" ./tests/qtest/pxe-test
- - QTEST_QEMU_BINARY="s390x-softmmu/qemu-system-s390x"
-   ./tests/qtest/pxe-test -m slow
+  <<: *native_build_job_definition
+  variables:
+    IMAGE: fedora
+  script:
+    - TARGETS="aarch64 alpha arm hppa m68k microblaze moxie ppc64 s390x x86_64"
+    - mkdir build
+    - cd build
+    - ../configure --enable-tcg-interpreter
+        --target-list="$(for tg in $TARGETS; do echo -n ${tg}'-softmmu '; done)"
+    - make -j"$JOBS"
+    - make run-tcg-tests-x86_64-softmmu
+    - make tests/qtest/boot-serial-test tests/qtest/cdrom-test tests/qtest/pxe-test
+    - for tg in $TARGETS ; do
+        export QTEST_QEMU_BINARY="${tg}-softmmu/qemu-system-${tg}" ;
+        ./tests/qtest/boot-serial-test || exit 1 ;
+        ./tests/qtest/cdrom-test || exit 1 ;
+      done
+    - QTEST_QEMU_BINARY="x86_64-softmmu/qemu-system-x86_64" ./tests/qtest/pxe-test
+    - QTEST_QEMU_BINARY="s390x-softmmu/qemu-system-s390x" ./tests/qtest/pxe-test -m slow
-- 
2.20.1


