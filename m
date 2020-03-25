Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8798C1975A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 15:29:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EB85206F8
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 15:29:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LfPaQx8g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EB85206F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38344 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH7yY-000882-Rw
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 11:29:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42741)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jH7s2-0007cC-9w
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 11:23:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jH7s0-0004sh-Os
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 11:23:05 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:33278)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jH7s0-0004s0-Hs
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 11:23:04 -0400
Received: by mail-wr1-x433.google.com with SMTP id a25so3690886wrd.0
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2020 08:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=pz4+hj7n/yl99ow8yOnM+Gbx/Hl9NI3JBuBBYB7hHVY=;
 b=LfPaQx8gRlZk1/KyUhutKckcHZ5Ibj95ZtbVVUULPwPM/aTqRSBI+tPY4pvpyRxPv+
 RB8c5rJs04h3fFF0t+br9to61Elqi2cwOSAAI7Xtq1Ki7LaAlAGZ4zaKv+eXK9xcQowO
 a1z3PgK35CVpfYkSOiSWUsnzd4z3aZlxVjq77oT/B0WCcSDTXDtNogtDyeZDKufA93Uj
 lyn+HjDom1SPviJryRUyAsu63gdHifTVDWXaH8daa5zXif8t9yNb0U4aa0Uc+MBShm+m
 eO8a+lOzUD9jTuroOMnefnctzhrq/QXyXKZRgotO46XopSdlkIBQqNE9uOpawKG/+oGa
 qjYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=pz4+hj7n/yl99ow8yOnM+Gbx/Hl9NI3JBuBBYB7hHVY=;
 b=CuDwQyT6afhIlubeiZZxEREistywW4brkRp46EJPH8pFiaDPq4Ggf5x8exwsyxkIAC
 x73X4lc6vkygXbULfsqrTVKKXX70vyLUjZOH/9YthY1F0GH9jnogntavV0QiTqQg2KvP
 go8qUBN8O9794kKQz8QfeIAwPwtX1NGA+d86KLIcq9CRLY4S8IN7McVCOYy4LtHYhhgo
 TSrQ5lWc8e/MqbqmLiXtK/PuZPCGrOjlQDFUVJKa9Tkf4upN0DZ23isnsP1/CJBGTz5Y
 2T9yAWaCXhUAhZ/VoOMwIJ5g30vb42c6Y/byEf1qf8libeMK36u0j/tTIs363Ant9L8+
 axFQ==
X-Gm-Message-State: ANhLgQ3n23+MRALqBlhM8dyyAngDcT29UmXeisSLNXo4ZULr5RTKQLBD
 enpJPCoYdNzzJi9FtNG+o4usPw==
X-Google-Smtp-Source: ADFU+vtU9dBd6DOPav8rZne1BLOuW5Vzg8SRGgqCMejvYkdx6Qc0MMcNLCXx5hZ/XrStoghPaS05Ug==
X-Received: by 2002:adf:9321:: with SMTP id 30mr3886756wro.330.1585149783283; 
 Wed, 25 Mar 2020 08:23:03 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id s15sm33776554wrt.16.2020.03.25.08.23.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2020 08:23:02 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 3AD271FF9A;
 Wed, 25 Mar 2020 15:15:44 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 11/11] .travis.yml: Add a KVM-only s390x job
Date: Wed, 25 Mar 2020 15:15:43 +0000
Message-Id: <20200325151543.32478-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200325151543.32478-1-alex.bennee@linaro.org>
References: <20200325151543.32478-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::433
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 "open list:S390 general arch..." <qemu-s390x@nongnu.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Add a job to build QEMU on s390x with TCG disabled, so
this configuration won't bitrot over time.

This job is quick, running check-unit: Ran for 5 min 30 sec
https://travis-ci.org/github/philmd/qemu/jobs/665456423

Acked-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200322154015.25358-1-philmd@redhat.com>
Message-Id: <20200323161514.23952-12-alex.bennee@linaro.org>

diff --git a/.travis.yml b/.travis.yml
index 5672d129ec6..e0c72210b7a 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -525,6 +525,48 @@ jobs:
               $(exit $BUILD_RC);
           fi
 
+    - name: "[s390x] GCC check (KVM)"
+      arch: s390x
+      dist: bionic
+      addons:
+        apt_packages:
+          - libaio-dev
+          - libattr1-dev
+          - libbrlapi-dev
+          - libcap-ng-dev
+          - libgcrypt20-dev
+          - libgnutls28-dev
+          - libgtk-3-dev
+          - libiscsi-dev
+          - liblttng-ust-dev
+          - libncurses5-dev
+          - libnfs-dev
+          - libnss3-dev
+          - libpixman-1-dev
+          - libpng-dev
+          - librados-dev
+          - libsdl2-dev
+          - libseccomp-dev
+          - liburcu-dev
+          - libusb-1.0-0-dev
+          - libvdeplug-dev
+          - libvte-2.91-dev
+          # Tests dependencies
+          - genisoimage
+      env:
+        - TEST_CMD="make check-unit"
+        - CONFIG="--disable-containers --disable-tcg --enable-kvm --disable-tools"
+      script:
+        - ( cd ${SRC_DIR} ; git submodule update --init roms/SLOF )
+        - BUILD_RC=0 && make -j${JOBS} || BUILD_RC=$?
+        - |
+          if [ "$BUILD_RC" -eq 0 ] ; then
+              mv pc-bios/s390-ccw/*.img pc-bios/ ;
+              ${TEST_CMD} ;
+          else
+              $(exit $BUILD_RC);
+          fi
+
     # Release builds
     # The make-release script expect a QEMU version, so our tag must start with a 'v'.
     # This is the case when release candidate tags are created.
-- 
2.20.1


