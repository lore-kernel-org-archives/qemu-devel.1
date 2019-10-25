Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDB60CA9EBD
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 19:54:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA42421D71
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 19:54:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ie8oh25w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA42421D71
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iO5fe-0005is-Sw
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 15:54:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57783)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iO5Og-0008AL-BG
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 15:37:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iO5Of-00037M-5z
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 15:37:18 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:35937)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iO5Oe-00036o-WE
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 15:37:17 -0400
Received: by mail-wr1-x433.google.com with SMTP id w18so3637453wrt.3
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 12:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=HDnFETyoSIS8dCFtwOkMGxSV5Cme4iWm+VQG9FYgBJY=;
 b=ie8oh25wgFnQzDJU2H4SE3ZJByT33fWoh6JnN4z2Z+nu7gIsskRp91SfnEM+/I06PH
 pJDBE0RDG8IVY7wcuIhVz64DEsf82kP5RVZI6o3licLeySqIKGqhYShMN8MaFo9vSTLe
 XdJs5ZnMr93Rm8jD8i1TM3EsraQthmSm/U/2H97Wwbd5NJ08yfwddO189ILvCgHHbpTa
 ntmQ8y1O0dCASDa2r7x5kq1CwQFH3IPEQJ8adtJ5WKnPq4TM3xkgJ5wBRbY/zA5DO7uO
 lTpoM3VuzSinnZHq/u3DXYSrtrmZ0+/EovQWXWt0u5bbrzaS51FDo0Aebq2CnvMXXmBb
 MzUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=HDnFETyoSIS8dCFtwOkMGxSV5Cme4iWm+VQG9FYgBJY=;
 b=pIll68GCkgSVDJ2eibUPAkmx9EvTA2m40W9RRINIdHEPoAqkuT1QJNg0bdRl7wN1Yb
 maPEX7tv8kR7QlDKKBrvqGKiwniJ2EMQyHwWPhBH6R5LpngDFw5m6EiRMfcYK5HnShdk
 EhBU667aguTbejANluz5T9l8e1qp5880F4+Cn1wpPsSPhWtZguvZnH0sMIayo9dBDO5O
 g2CKaRMZtwzNm7OyrDds8JAuvT82/h3QILuvVMzb30Z7TpXPPp0fH2IS03oNw9XNejD3
 d4zj/lkX/Qu2fErxDNBZuAJVSmYit7B1Na97+3xRYa7QqlAtPDL4w9Fa92alaQ/NP5aF
 Qg3g==
X-Gm-Message-State: APjAAAUU9ApKAyr7iKhn42LACT7IK/UZi3+sju8B1Hq3XGbHUUM4xIxF
 39+K2hkuWMwD5pMy8/shsVwczg==
X-Google-Smtp-Source: APXvYqwJtLv+u27sRPmEYPaquJuq5MnvZZNZKIAWk3z4e9lyRKLhC9Eg2yoZCO55vjhPYA56ouKurg==
X-Received: by 2002:a5d:6ac3:: with SMTP id u3mr4663889wrw.206.1572032235924; 
 Fri, 25 Oct 2019 12:37:15 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id r19sm3579023wrr.47.2019.10.25.12.37.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2019 12:37:13 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E22831FF92;
 Fri, 25 Oct 2019 20:37:09 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL v3 05/15] travis.yml: Fix the ccache lines
Date: Fri, 25 Oct 2019 20:36:59 +0100
Message-Id: <20191025193709.28783-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191025193709.28783-1-alex.bennee@linaro.org>
References: <20191025193709.28783-1-alex.bennee@linaro.org>
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
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

The "command -v ccache && ccache ..." likely were supposed to test
the availability of ccache before running the program. But this
shell construct causes Travis to abort if ccache is not available.
Use an if-statement instead to fix this problem.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20191009170701.14756-5-thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/.travis.yml b/.travis.yml
index e65e53f3d7e..7e0d4ad2b31 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -91,13 +91,13 @@ git:
 
 before_script:
   - if [ "$TRAVIS_OS_NAME" == "osx" ] ; then export PATH="/usr/local/opt/ccache/libexec:$PATH" ; fi
-  - command -v ccache && ccache --zero-stats
+  - if command -v ccache ; then ccache --zero-stats ; fi
   - mkdir -p ${BUILD_DIR} && cd ${BUILD_DIR}
   - ${SRC_DIR}/configure ${BASE_CONFIG} ${CONFIG} || { cat config.log && exit 1; }
 script:
   - make -j3 && travis_retry ${TEST_CMD}
 after_script:
-  - command -v ccache && ccache --show-stats
+  - if command -v ccache ; then ccache --show-stats ; fi
 
 
 matrix:
-- 
2.20.1


