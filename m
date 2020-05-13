Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74223C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 17:52:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECBA120659
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 17:52:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FdgXZ2PP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECBA120659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYvYj-0002II-8K
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 13:52:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33370)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jYvXg-0000jC-CL
 for qemu-devel@nongnu.org; Wed, 13 May 2020 13:51:40 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:39574)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jYvXf-0004xN-GS
 for qemu-devel@nongnu.org; Wed, 13 May 2020 13:51:40 -0400
Received: by mail-wm1-x32d.google.com with SMTP id y24so29581936wma.4
 for <qemu-devel@nongnu.org>; Wed, 13 May 2020 10:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=HFDLFAKOqzqDM16uDgH8kQv5arlsfvslWta0/Fd6rk4=;
 b=FdgXZ2PPep7Gw/rPsOqbqlantISX5CYa3goFQ7oYj3/KXa3OMC24rnfaVSjU/CHNdl
 rR/bV5Dl6f6JNkUTheYRXmbcwm6EeG9yBWSIcvS+pWFkJVbwzbIPFUocjE8+SLhjGxzJ
 BT3JWyBjrXaxB+CrjQKT+ysvmO8ctZoZalbPPSLZGvRx4wmHHFCnYgZ2OAh9qQA8kfLg
 GsP/mHOs+QF7bgradK0Xixqr6Iu3cQrsZqERbb4Sh359Rr3gqSg+44vS4bBdwH9Hvnh8
 o7kh18Jkp2X1DZmvOqED7ybrH82JpgfG186z866ckST0H1r38YpanMGWLElHXeE7GbZh
 chhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=HFDLFAKOqzqDM16uDgH8kQv5arlsfvslWta0/Fd6rk4=;
 b=i2/ba3oWihmIP+DP56XcC5R/bxiAX7KkUq5A26VW2UNy9U64iNfjSHHzzo420zH1nM
 bDfs9gYwoXI3kmKfCtavPA8BreGZAmzt9/HMHpUG2fIbBGh9eqmUK6imu27pp2EcXMrf
 JElq5JKk55KRzx2O3GimBpY309Fqw5nbgo4ZMfUfEQHk20hckMIQ2W+R34ib3yGZ/OVL
 my3XXh7PX2W3tX0soDfgjdH1PQelP7SozL2EXENqzmrk/py+xu/OAx6T+rxi8SP3Q1BG
 syr87UvWt93pKlacadziwvefvYxbfzLvVH/kNvMOys8hCreLLg4xDEbuNshLlHGazbbZ
 gDvg==
X-Gm-Message-State: AGi0PuatJcbqlc9A++zV+/vAgtu8E9rkAzZh9xivXAj6xkfOSALhrgJG
 qYuBq6nzF+9TAPe0zt6z5bwI8A==
X-Google-Smtp-Source: APiQypJP224MWbAJRR22mSCugCETVMgBNjXAJiJynx3GqeCXI0UYxb5fzE4ypIQ/MkTy367aVynP1g==
X-Received: by 2002:a1c:5988:: with SMTP id
 n130mr34162317wmb.187.1589392297948; 
 Wed, 13 May 2020 10:51:37 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id q17sm19462879wmk.36.2020.05.13.10.51.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2020 10:51:35 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 02B8C1FF8C;
 Wed, 13 May 2020 18:51:35 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 02/10] travis.yml: Improve the --disable-tcg test on s390x
Date: Wed, 13 May 2020 18:51:26 +0100
Message-Id: <20200513175134.19619-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200513175134.19619-1-alex.bennee@linaro.org>
References: <20200513175134.19619-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>,
 "open list:S390 general arch..." <qemu-s390x@nongnu.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

Since the s390x containers do not allow KVM, we only compile-test
the --disable-tcg build on s390x and do not run the qtests. Thus,
it does not make sense to install genisoimage here, and it also does
not make sense to build the s390-ccw.img here again - it is simply
not used without the qtests.
On the other hand, if we do not build the s390-ccw.img anymore, we
can also compile with Clang - so let's use that compiler here to
get some additional test coverage.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200512133849.10624-1-thuth@redhat.com>
---
 .travis.yml | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index fe708792ca2..1ec8a7b4657 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -502,9 +502,10 @@ jobs:
               $(exit $BUILD_RC);
           fi
 
-    - name: "[s390x] GCC check (KVM)"
+    - name: "[s390x] Clang (disable-tcg)"
       arch: s390x
       dist: bionic
+      compiler: clang
       addons:
         apt_packages:
           - libaio-dev
@@ -528,21 +529,10 @@ jobs:
           - libusb-1.0-0-dev
           - libvdeplug-dev
           - libvte-2.91-dev
-          # Tests dependencies
-          - genisoimage
       env:
         - TEST_CMD="make check-unit"
-        - CONFIG="--disable-containers --disable-tcg --enable-kvm --disable-tools"
-      script:
-        - ( cd ${SRC_DIR} ; git submodule update --init roms/SLOF )
-        - BUILD_RC=0 && make -j${JOBS} || BUILD_RC=$?
-        - |
-          if [ "$BUILD_RC" -eq 0 ] ; then
-              mv pc-bios/s390-ccw/*.img pc-bios/ ;
-              ${TEST_CMD} ;
-          else
-              $(exit $BUILD_RC);
-          fi
+        - CONFIG="--disable-containers --disable-tcg --enable-kvm
+                  --disable-tools --host-cc=clang --cxx=clang++"
 
     # Release builds
     # The make-release script expect a QEMU version, so our tag must start with a 'v'.
-- 
2.20.1


