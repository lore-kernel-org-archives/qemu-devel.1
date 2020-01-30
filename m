Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EB64C33CB3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 11:44:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9AF6206F0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 11:44:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nCciDePc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9AF6206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ix8FV-0001Wr-63
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 06:44:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36214)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1ix89z-0001Qs-OZ
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 06:39:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1ix89y-0000Fz-0K
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 06:38:59 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:38090)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1ix89x-0000Eu-QQ
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 06:38:57 -0500
Received: by mail-wr1-x441.google.com with SMTP id y17so3641435wrh.5
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2020 03:38:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8SPcB6wgCgKwBE9VXIf2AxmCpkYpuej8115FHkXbZbg=;
 b=nCciDePcj3CYF0RiwXXE+2cAc4ped+l457ONDDpgAyDV6z062hQfuqxw6hWbfDC4zn
 ct5A6NjRwEPSb/4SmtPpuyL/2xYL7KIr7MfP955YlapddKAAuFGehDuWCx+wlUJPqpU9
 x5xTpQjMLkrwOdL9HqIZEZevvvOT6gPWTJ2xV5Pk5NpIHH+tNqpqHF0Jv3jInJ1XYaSb
 z3k0NSLwsbhsB3k20cZUk+8xfPFhxEtHSFGxQTDmWogyVjl/Tv1Y79tUAx3E5J4/cU38
 v1I//fem81t31GjEhW5fUlrRMOs5eyYJ5hU/7mRYyzd2T0MCj8/w6MaXMt7qPP1UhZh+
 1MKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8SPcB6wgCgKwBE9VXIf2AxmCpkYpuej8115FHkXbZbg=;
 b=pBfX8Digg2S7a947PmDKjqLngn8aKQVrIyMHNH8quwqnhyxeYdUNiBM3BAJSKF5N0i
 hFJtJ46njuu52kuVMawbiwM1wyCUsOdNSJ5L+bV6U1aYS3LUHhPURk6xBh6DZOVqCXNj
 dXpLYq3g3NuRNgpJHf51vUbQYgysM4pzxdTn1YhjgzUlHnusueFXKmMSwEWaRmwfF61w
 TipR7wxaeINwmQX23mFLQJdKdOmoOeO6VQMgJfMAxYygMdwOUrPjIOlbxk/WzK3Bi44T
 F/Ixn9fusmqVGm7KXVbwGJrT+3cRisveQojuuc13wQ6kYBUQlbI1z9YPA+L7/WKXJe9E
 El4Q==
X-Gm-Message-State: APjAAAUlk/yn7HaIpNHaV4z18/3Pv7wPnNnsKEc81unQswD+gTlHJBuR
 auOMHkT3RhNFnE5qubWKWvv4jg==
X-Google-Smtp-Source: APXvYqwZ0vl2YQItTr866CqvrBRBwAcTB23XPLLz20AhJOH3WgVZNOFhxxoTUenwlXtzEXVJ561lAw==
X-Received: by 2002:adf:f5cb:: with SMTP id k11mr5320825wrp.71.1580384336831; 
 Thu, 30 Jan 2020 03:38:56 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id b137sm6454072wme.26.2020.01.30.03.38.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jan 2020 03:38:49 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 8AA7F1FF91;
 Thu, 30 Jan 2020 11:32:23 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v2 04/12] travis.yml: Install genisoimage package
Date: Thu, 30 Jan 2020 11:32:15 +0000
Message-Id: <20200130113223.31046-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200130113223.31046-1-alex.bennee@linaro.org>
References: <20200130113223.31046-1-alex.bennee@linaro.org>
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
index 1ae645e9fc..e75c979b6c 100644
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


