Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA1F6C3524D
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 09:15:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 964222070A
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 09:15:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uPepcULe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 964222070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36664 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyXow-0007wW-QT
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 04:15:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47757)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iyXjp-0006rI-Bl
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 04:09:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iyXjo-00019S-9P
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 04:09:49 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:35065)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iyXjo-00017f-2g
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 04:09:48 -0500
Received: by mail-wr1-x436.google.com with SMTP id w12so5985029wrt.2
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2020 01:09:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=JI9taW7Mf8A4HrYR0xn5XJboAo2fuIQkC6EsJTBwttw=;
 b=uPepcULeMox8z0v1mNzicpUoANqPRHsd2LbPWEn/2IDJeM8I2DCeyWsAjbt7FFbUgb
 G+rJOCl6NQC/TTbewM7ZfI7y/3kw13QbPXe3OqK5ggxRrKEaAz6ge+wt6P80u1OkVboR
 pU7s5rym8HosXcMSF2yBrJPAzKhLUazEDIVoZnJLb4BQLPS0zI4OEh2OR1boUetdP8DG
 FJ+jVjKX0EKly8dD77WjA7Rc93Txhmq8TSGd14pz4WiKrMhyYGkGm1tZQW7nCJXBQdS1
 mhfiVpov3kLU//4olZoMnxd16bX1JeXTXncv+33i7bv1DaXY8cQcNNRq5OI6NMdVJ+A0
 qoQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=JI9taW7Mf8A4HrYR0xn5XJboAo2fuIQkC6EsJTBwttw=;
 b=RS8Ec3m7Hm6yYe0xEW9cQbU+tIPU1EhpnBRYGemZaLID9+K7H1MejePLiRcZ7pMjIs
 ZmGz6PR5ABXc4wGjksbKFV22okuXhNIjSfAJFGYhr3korPD0nyUy140H9Hj/ST1xwHTp
 A8oixYkMtvE3u76p9BKyD9fWR5nyr40dpUdyggoQjSPpDEpZfWJKcGBMulHx3CuOFOo7
 5+BI0Vu549j4Vg+LCefPbFTRk88eb0o0qDvEpWH8VesXItmj34seZEjXow/oSCxG7zWh
 y/SMWkueUJ7BWa72l25gjl6nKdX1H0lFB2diye4nChoIAveTKPoacyag206kkESysWlZ
 QS/g==
X-Gm-Message-State: APjAAAWwvRza4XcVvpqqkQPLZfX7cEq+KzL6KxOVEvLRX77Uprg2Yao1
 dKsFnUskfY1pZ55xpDXyGah4SQ==
X-Google-Smtp-Source: APXvYqxPJ/8g+dUWE9RVsSMZ8QBqdrnDR77DoerUtzL4SoVYHoKSnrl3ClZP4fnId2YOuX0t3GAB2g==
X-Received: by 2002:a5d:52c4:: with SMTP id r4mr14157583wrv.368.1580720987107; 
 Mon, 03 Feb 2020 01:09:47 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id j5sm15359345wrb.33.2020.02.03.01.09.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2020 01:09:39 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 3BB841FF9A;
 Mon,  3 Feb 2020 09:09:33 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 10/17] .travis.yml: move cache flushing to early common
 phase
Date: Mon,  3 Feb 2020 09:09:25 +0000
Message-Id: <20200203090932.19147-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200203090932.19147-1-alex.bennee@linaro.org>
References: <20200203090932.19147-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::436
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
Cc: fam@euphon.net, berrange@redhat.com, stefanb@linux.vnet.ibm.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, cota@braap.org,
 stefanha@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We shall be adding more common early setup in a future commit.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 .travis.yml | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index f245765cfed..1b92f40eab2 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -82,11 +82,16 @@ git:
   # we want to do this ourselves
   submodules: false
 
+# Common first phase for all steps
+before_install:
+  - if command -v ccache ; then ccache --zero-stats ; fi
 
+# Configure step - may be overridden
 before_script:
-  - if command -v ccache ; then ccache --zero-stats ; fi
   - mkdir -p ${BUILD_DIR} && cd ${BUILD_DIR}
   - ${SRC_DIR}/configure ${BASE_CONFIG} ${CONFIG} || { cat config.log && exit 1; }
+
+# Main build & test - rarely overridden - controlled by TEST_CMD
 script:
   - BUILD_RC=0 && make -j3 || BUILD_RC=$?
   - if [ "$BUILD_RC" -eq 0 ] ; then travis_retry ${TEST_CMD} ; else $(exit $BUILD_RC); fi
@@ -268,7 +273,6 @@ matrix:
       before_script:
         - brew link --overwrite python
         - export PATH="/usr/local/opt/ccache/libexec:$PATH"
-        - if command -v ccache ; then ccache --zero-stats ; fi
         - mkdir -p ${BUILD_DIR} && cd ${BUILD_DIR}
         - ${SRC_DIR}/configure ${BASE_CONFIG} ${CONFIG} || { cat config.log && exit 1; }
 
@@ -499,9 +503,6 @@ matrix:
         - TEST_CMD="make install -j3"
         - QEMU_VERSION="${TRAVIS_TAG:1}"
         - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-default"
-      before_script:
-        - command -v ccache && ccache --zero-stats
-        - mkdir -p ${BUILD_DIR} && cd ${BUILD_DIR}
       script:
         - make -C ${SRC_DIR} qemu-${QEMU_VERSION}.tar.bz2
         - ls -l ${SRC_DIR}/qemu-${QEMU_VERSION}.tar.bz2
-- 
2.20.1


