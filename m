Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5A59C2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 20:41:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85DD62071A
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 20:41:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HQmAbYkt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85DD62071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iv5m3-0001Bd-I1
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 15:41:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42675)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iv5kp-0007we-DL
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 15:40:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iv5ko-0005np-74
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 15:40:35 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:41712)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iv5ko-0005ma-1S
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 15:40:34 -0500
Received: by mail-wr1-x441.google.com with SMTP id c9so3580245wrw.8
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2020 12:40:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=DxyUL09mP/E2gi/BJdtPzSscycJU2l67msm7AJIa0aI=;
 b=HQmAbYktc84wg/Sr2RixfvIiThYjJ/XK+UrBBnUDuXL+893t5g+WV6BO1RMbacW8yO
 HmIg7jfZap/DKN9/279VjCufs0uUfeJ1ty6qdiC2nClPEa75AF56yo/DF3ht7D36wfaV
 abOOjuSjriIqMwg1c3mPFVwkPxLY3LNZRSVFelohDQ9r5ODWKJdirCsk7bLh1/LRuG2I
 L7xOcKPTxIl5WYIXLdfD0TKeIzxVZiulRnUGLLLRFhJ6L0n1Og77LyrqUIU8P32EZoqY
 Lg0hkNCUELoCFd5ibZ3nhi3CjnG0/iBUYs5V9UcroRxupj4hnXyL7set1bjtm/k+K7Dj
 qOOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=DxyUL09mP/E2gi/BJdtPzSscycJU2l67msm7AJIa0aI=;
 b=qxRe3Iy+tJHfwTj2RKUY0kyJEVi8E+gxD7a2y+F1siVOZccfIAI08Xc7M+BzKxJjG4
 +uypraoXxRem6gkXOs4LyrkTkl8DYgbfIurSd7B14C5FdHxdfP2VqxmJ02Hqi8huIvNs
 qSio+VLuE0aimUl9wAA0RbiTyTn1tWQhJJbxp0AYzDq4FJ8srLX3dShA1CIpNlC+IINc
 At6otJDwaz52ak9qfKz4MTpcClc2nmhqudgn3NzfzFuYwcXlNyIMMat+cCOkId+y314e
 Lax3Ds7MWg6jRyohr1akh2wuOWkTV/Mhxj7gqjiYiO1ucTe3gGWxi9qaWShxDxFynWb9
 Egqw==
X-Gm-Message-State: APjAAAU+bnairACGRbowss2OJuEKoFJiMnDMO1O9FXDK+Scj4iZdGIBE
 SwknSNmBl6B12RsmkhnIuRPAkw==
X-Google-Smtp-Source: APXvYqxezXLgjnKGxHXOg4nR6OOwAHhUJ+Qn88Rg6y9HZp95lkZNsH3OFJ2nOq7xNbq9manVD3dF2w==
X-Received: by 2002:adf:ef03:: with SMTP id e3mr6139820wro.216.1579898433066; 
 Fri, 24 Jan 2020 12:40:33 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id r6sm8776363wrq.92.2020.01.24.12.40.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2020 12:40:29 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id BF7F51FF91;
 Fri, 24 Jan 2020 20:40:26 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 04/13] travis.yml: Install genisoimage package
Date: Fri, 24 Jan 2020 20:40:17 +0000
Message-Id: <20200124204026.2107-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200124204026.2107-1-alex.bennee@linaro.org>
References: <20200124204026.2107-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, cota@braap.org,
 stefanha@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Wainer dos Santos Moschetta <wainersm@redhat.com>

The genisoimage program is required for tests/cdrom-test
tests, otherwise they are skipped. The current Travis
environments do not provide it by default, so let's
explicitly require the genisoimage package.

Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-Id: <20200110191254.11303-2-wainersm@redhat.com>
---
 .travis.yml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/.travis.yml b/.travis.yml
index 6c1038a0f1..131c920255 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -51,6 +51,8 @@ addons:
       - sparse
       - uuid-dev
       - gcovr
+      # Tests dependencies
+      - genisoimage
 
 
 # The channel name "irc.oftc.net#qemu" is encrypted against qemu/qemu
@@ -383,6 +385,8 @@ matrix:
           - libusb-1.0-0-dev
           - libvdeplug-dev
           - libvte-2.91-dev
+          # Tests dependencies
+          - genisoimage
       env:
         - TEST_CMD="make check check-tcg V=1"
         - CONFIG="--disable-containers --target-list=${MAIN_SOFTMMU_TARGETS}"
@@ -412,6 +416,8 @@ matrix:
           - libusb-1.0-0-dev
           - libvdeplug-dev
           - libvte-2.91-dev
+          # Tests dependencies
+          - genisoimage
       env:
         - TEST_CMD="make check check-tcg V=1"
         - CONFIG="--disable-containers --target-list=${MAIN_SOFTMMU_TARGETS},ppc64le-linux-user"
@@ -441,6 +447,8 @@ matrix:
           - libusb-1.0-0-dev
           - libvdeplug-dev
           - libvte-2.91-dev
+          # Tests dependencies
+          - genisoimage
       env:
         - TEST_CMD="make check check-tcg V=1"
         - CONFIG="--disable-containers --target-list=${MAIN_SOFTMMU_TARGETS},s390x-linux-user"
-- 
2.20.1


