Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85C5AC2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 09:12:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 581C720B7C
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 09:12:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yACQQXAm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 581C720B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47152 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZAuz-000118-KR
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 05:12:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39388)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hZAp1-00047Z-Fg
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:06:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hZAoy-0004Ii-1T
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:06:03 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:41276)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hZAox-0004Ct-Ra
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:05:59 -0400
Received: by mail-wr1-x432.google.com with SMTP id c2so1338120wrm.8
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2019 02:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=WAruCVUMvVUZGKjuxI8Kw2Q2uX+I+acKmrGoMuG66f8=;
 b=yACQQXAmEShz7T8rno6cKs8EZgrltB2s2aGEYSUgVT01Xx5M4SmxLwEbPMdxLvs7jI
 Wfm4H2sYxkd1XyaeH+JaiN6TaUYmvboJ1ankaxsvTWzmbw1vHHNDpg0mYBVxOAHoIxtI
 8y7/XK4dj/mEm8hZWaBtSR+oVPT8rzk3KtARNtURrIavMRjRETGFeeUGc0zuUmF3TaGF
 5iPApuy2SxNBHq+zJFGGCyM0FX/m/tBb3Sj8RYIFRgmi1T32DBIAO34ci40UZ9ifySsF
 1hnj76vC9TurrDlu5sz9fRkbEWyAZaAndBrpFKTXL7hFnQKVRYNESOPEymKKiIyY+sNV
 jHlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=WAruCVUMvVUZGKjuxI8Kw2Q2uX+I+acKmrGoMuG66f8=;
 b=jOXT1WIaBGPagKvBqpGXEOBaEo6lFwwqki1HocwgL4/IGFmxo+bvhIHT1DvH7E4wPh
 0OM1rFFnvwqg0j01Xn/jSgfEv2kXnzpD5z+3wL5Ls+8XZDg54Uuz4D+Ecm35YPXXwnzI
 8niqtLvD2ges5Rzs79AiPDnc18TN1T/a8e2gZoirqGG33v7RpEX6HGhkDFtVLb0WF8Tq
 4kwE+oRHoYvRE3tr9WeqKacZ5+5yq+3Se+9iDP9QI0qcvmDaSSju7Ero5/3ODWPvz3Pf
 ztC/8F4+EcHj+RxIPgpqsV/hcAklDfzCug4mdNOm20p4aF9NSIIie7lGtvUkU2v0wWDQ
 Y3DA==
X-Gm-Message-State: APjAAAXsBusOdqlFjFo+BNIG6DsRAfkkLg3XGMQtW2vY1nv0meD2BWRe
 WtY9PqV+I8FDotpHYOuf8qciDA==
X-Google-Smtp-Source: APXvYqxRsN+YGq3zxo7EWhz/ww0C1kthWqCL7eeOMKVwoP5l8rYoUL9k/jAqlJLrpOXbOj7R16d2vg==
X-Received: by 2002:adf:e4d2:: with SMTP id v18mr5887019wrm.189.1559898358300; 
 Fri, 07 Jun 2019 02:05:58 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id k10sm1645351wmk.14.2019.06.07.02.05.53
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 07 Jun 2019 02:05:56 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 902DB1FF96;
 Fri,  7 Jun 2019 10:05:52 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Fri,  7 Jun 2019 10:05:06 +0100
Message-Id: <20190607090552.12434-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190607090552.12434-1-alex.bennee@linaro.org>
References: <20190607090552.12434-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::432
Subject: [Qemu-devel] [PULL 07/52] .travis.yml: add clang ubsan job
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
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We document this on our wiki and we might as well catch it in our CI
rather than waiting for it to be picked up on merge:

  https://wiki.qemu.org/Testing#clang_UBSan

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

diff --git a/.travis.yml b/.travis.yml
index f0aa37f2d1..2f1658602e 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -152,6 +152,13 @@ matrix:
       compiler: clang
 
 
+    - env:
+        - CONFIG="--target-list=${MAIN_SOFTMMU_TARGETS} "
+      compiler: clang
+      before_script:
+        - ./configure ${CONFIG} --extra-cflags="-fsanitize=undefined -Werror" || { cat config.log && exit 1; }
+
+
     - env:
         - CONFIG="--disable-user --target-list-exclude=${MAIN_SOFTMMU_TARGETS}"
       compiler: clang
-- 
2.20.1


