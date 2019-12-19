Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26DA0C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 11:06:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8594222C2
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 11:06:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a7u7AhMR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8594222C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihtdW-00049F-G5
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 06:06:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57071)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1ihtWd-0003pN-N8
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 05:59:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1ihtWc-00010q-Is
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 05:59:23 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:44595)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1ihtWc-0000uz-AC
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 05:59:22 -0500
Received: by mail-wr1-x429.google.com with SMTP id q10so5493753wrm.11
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 02:59:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5wZWaLRvYvZmLIMHo5Ts618uNlIbDVM0vsHKMJtTzPM=;
 b=a7u7AhMRQ7JvoMkVctN7MwzSHwdmI2dvIPrInk/CzKQA4ESw8rAdEBbfYWz5dkSFNc
 vS4wVcjVatLj6btwpz58zB/5yYRVt/FQPlL19ePqvWJkrj42N8SHFiV81mQAaetvjj7M
 zSgvRiCz9O3WY5OEKXVyzk6S0+9Ofl+Rc5l+eCIP6wENA8U2N2Hjl8mKB5Zsed+n5hHO
 Wdu5NO80QWrbiruRXawX66qxAM51ZMpXYEdJ4jKtx+q/gk0rsY1J4FWEigGNogC3dmVr
 3YDqnE6xixCS+u6Ke7ip8R4tsLKq6jOKlYM6kfeQYRxUhyj5Vc6Uj4Er/lRctyic0LFx
 HLfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5wZWaLRvYvZmLIMHo5Ts618uNlIbDVM0vsHKMJtTzPM=;
 b=rQPep7QWV9erphQwoIRaV6q2xXrXpAONVx9fZxzOXDvdt9vedSKgJEjkIjV8/kkcjJ
 qxat4ga+Cq6Dg9bhyDwnLasLZG3hEj2SirIbX+ulUnbQLIAfHmhDZozAWW+Lp4v61E04
 i+WjqkmpyBJq4sjEsd62P13cQ9MjAtgRxF7mG/1rHxKvtku6vXHYQDaAtitckKv0Sftl
 FWyPD3NlUE5mdRz23rYrnnwHbLAExfB/3rcr64p1R35wlweZUXiAqu1mgaXoxaz1x56W
 qwKy7Nf1GkbvNnMQSHjZ1RsSUa8FJdfqT6ZPIpbguVlVC6hRk8Kqid1SYrHn1idpScc3
 lRBQ==
X-Gm-Message-State: APjAAAUAMo0/Qk+EGjwmZKS1q1aPtApSFo1mM8bD6zWmTKq9UpeDcRzB
 UDkYrliHDVQeTqDUyXKHkj7L6Q==
X-Google-Smtp-Source: APXvYqxgfQFQU7rag4zN8EmDoylBgeZGBduNLDO6cV/ytxnbKg7Nof1r0VDs4MA2QHzbOSY43N2BMw==
X-Received: by 2002:adf:fe0e:: with SMTP id n14mr8702460wrr.116.1576753161269; 
 Thu, 19 Dec 2019 02:59:21 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 60sm6200327wrn.86.2019.12.19.02.59.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2019 02:59:18 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D132C1FFB1;
 Thu, 19 Dec 2019 10:49:36 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 25/25] tests/tcg: ensure we re-configure if configure.sh is
 updated
Date: Thu, 19 Dec 2019 10:49:34 +0000
Message-Id: <20191219104934.866-26-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191219104934.866-1-alex.bennee@linaro.org>
References: <20191219104934.866-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::429
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We were only doing this if docker was enabled which isn't quite right.

Fixes: fc76c56d3f47
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20191211170520.7747-17-alex.bennee@linaro.org>

diff --git a/tests/tcg/Makefile.prereqs b/tests/tcg/Makefile.prereqs
index 7494b31b952..9a29604a839 100644
--- a/tests/tcg/Makefile.prereqs
+++ b/tests/tcg/Makefile.prereqs
@@ -13,6 +13,6 @@ DOCKER_IMAGE:=
 
 ifneq ($(DOCKER_IMAGE),)
 build-tcg-tests-$(PROBE_TARGET): docker-image-$(DOCKER_IMAGE)
+endif
 $(BUILD_DIR)/tests/tcg/config_$(PROBE_TARGET).mak: config-host.mak
 config-host.mak: $(SRC_PATH)/tests/tcg/configure.sh
-endif
-- 
2.20.1


