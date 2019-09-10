Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E41CCC3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 09:13:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A04CD208E4
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 09:13:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O18Ye8oP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A04CD208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7cDE-0002Sr-6v
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 05:13:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37247)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i7bqt-0000ki-Me
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 04:50:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i7bqs-0000b2-9k
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 04:50:19 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:43306)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i7bqs-0000aY-2y
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 04:50:18 -0400
Received: by mail-wr1-x42d.google.com with SMTP id q17so13697672wrx.10
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 01:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=flfnwEa/qmAbmD2M5WH/Dd1NeF2hOFImcYs5xWcss38=;
 b=O18Ye8oPQ3DreL0ySAUdT8g3tEc9LiCJLtjDdEYewI7QyAhZOoxx4e2T1j7kXRvRAk
 mb1yxQLcs9RZ4LPUZUN3KKybyT121tAER5w1KXS2js30ZFRwlnBV3fnoj4IjQ6ZQ4VU2
 xjLFTcDTIgqrCXNwFLShGVDML9wcTFyDIrm1yk8PHpXJSiN3LJrAUqf5lk++8QaCiLlI
 NrCFtUvPlYWdZBgfE16ZX16ExyfSXlRhEry62h429Y+UtYz/zkXy+ekJmfgTdMVyAHoA
 ovNg6E0RRDBN2130O31vtnes8m4m6HNM+iUaDOIhmpVy6IQUSGwOMq6JVLd1g/jE23Er
 2LAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=flfnwEa/qmAbmD2M5WH/Dd1NeF2hOFImcYs5xWcss38=;
 b=ol7coOE1lNeZ+IA8GmFAxxq4H/5uDq5XLz0SzXA6kPSaRstq/egETZe9n7wu6M4A0T
 lOpd91EZQhXpq78YstO+DOBWjwC4r7ispLh2nrqXHtKyV49fN84yE2skRoDp5/9iI+Rg
 r90M3OxSOvMpUOEC/ioINe+n6L98QSHQasIO3ZWCLnkjbC+Xj7oq+lJEbyVOJDwWXvYt
 oOaR5PtbJb/R+7tf1wwceoyUeiQVhEVDtWktqROGSlz0jEIIYnHjc77Vo2giRCpSyhbl
 Ee+AtMGDIrTU2JgjKrz6oQtdWTmEKI8/0TMk7dTGSOOtqY4MBR4x9KY92WOxtboAov65
 vXJQ==
X-Gm-Message-State: APjAAAVTh6F663Ks3mSh3nsSz3jGqNHVv0JP3eT0F0AwDnZiZautPdWX
 oL62xkitVn5PSk207KYlZDX9xQ==
X-Google-Smtp-Source: APXvYqxApKvRmsNnOf8mOPtKLN/xKUqOdVBKZBDnYViNCbEfmawIWtgpgK/TfBwsPi6LfoVsRwvx3g==
X-Received: by 2002:adf:ffc6:: with SMTP id x6mr26190211wrs.346.1568105417056; 
 Tue, 10 Sep 2019 01:50:17 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id x17sm2103530wmj.19.2019.09.10.01.50.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2019 01:50:14 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 188B51FF8C;
 Tue, 10 Sep 2019 09:43:53 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Tue, 10 Sep 2019 09:43:42 +0100
Message-Id: <20190910084349.28817-39-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190910084349.28817-1-alex.bennee@linaro.org>
References: <20190910084349.28817-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42d
Subject: [Qemu-devel] [PULL 38/45] .travis.yml: Improve ccache use
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
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Per https://ccache.dev/manual/latest.html:

  By default, ccache tries to give as few false cache hits as
  possible. However, in certain situations it’s possible that
  you know things that ccache can’t take for granted.

  [The CCACHE_SLOPINESS environment variable] makes it possible
  to tell ccache to relax some checks in order to increase the
  hit rate.

We can relax the ctime/mtime header checks:

  - include_file_ctime

    By default, ccache also will not cache a file if it
    includes a header whose ctime is too new. This option
    disables that check.

  - include_file_mtime

    By default, ccache will not cache a file if it includes
    a header whose mtime is too new. This option disables
    that check.

We also add a call to clear the cache statistics before running
the build, and display them when the build finishes.

See https://docs.travis-ci.com/user/caching/#ccache-cache

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/.travis.yml b/.travis.yml
index 097a844d68b..7d6c63a2803 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -70,6 +70,9 @@ env:
     - TEST_CMD="make check -j3 V=1"
     # This is broadly a list of "mainline" softmmu targets which have support across the major distros
     - MAIN_SOFTMMU_TARGETS="aarch64-softmmu,arm-softmmu,i386-softmmu,mips-softmmu,mips64-softmmu,ppc64-softmmu,riscv64-softmmu,s390x-softmmu,x86_64-softmmu"
+    - CCACHE_SLOPPINESS="include_file_ctime,include_file_mtime"
+    - CCACHE_MAXSIZE=1G
+
 
 git:
   # we want to do this ourselves
@@ -77,10 +80,13 @@ git:
 
 
 before_script:
+  - command -v ccache && ccache --zero-stats
   - mkdir -p ${BUILD_DIR} && cd ${BUILD_DIR}
   - ${SRC_DIR}/configure ${BASE_CONFIG} ${CONFIG} || { cat config.log && exit 1; }
 script:
   - make -j3 && travis_retry ${TEST_CMD}
+after_script:
+  - command -v ccache && ccache --show-stats
 
 
 matrix:
-- 
2.20.1


