Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF64ACA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 07:48:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B633B2070B
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 07:48:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DV92W8iP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B633B2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNuKG-0002Xo-DN
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 03:48:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40390)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iNtpw-0004bY-IG
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 03:16:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iNtpv-0007CC-Eu
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 03:16:40 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:39315)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iNtpv-0007AG-8v
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 03:16:39 -0400
Received: by mail-wr1-x435.google.com with SMTP id a11so1027979wra.6
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 00:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=yaLEb0Rvga8cR2LHsL8/9HPdNDQgpcbnXqsduwaSFKE=;
 b=DV92W8iPJYuVhcCjjEuUQvuwknYl5XIvSo5IFuKq5r9+4se8JE0RWiCLrix3S1jtH2
 UanMOA9+tujGwdwXmiacX8JB6ym4jnUUDhRtIK3LmMRm+bZJtOyoipigzbgIE1oh2gOj
 eE2L2rxQV9nmBPWszHXf3c3tGMveftqixh4bruf3F9LDsqPkPehX2zQOZ5Pm5oFdPh43
 5D1IvKREsw7hovtZKZ346Qy/0X/+V2a2NhRR3US0OoDkPDRcmD+xN4y/rNpWBlN7JcV5
 ox+2ip6sFAc4QuDxuiV0djUrezOP40vDXUfwzlAcy05+rv44wBtfsxsO9w9wjQ5oPOp2
 5gBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=yaLEb0Rvga8cR2LHsL8/9HPdNDQgpcbnXqsduwaSFKE=;
 b=P4DrSoO/mi8MUrcr/kWIg+0zf44qVeADqKlZcHCIpNlRF05mUHRVKFxYRgjSvFNh5x
 xJnUcXijq8HpaQ0ufuAmzeUMnxu+z7lscXAYZ0nXip1+xpsmBQy/aqHLeOPmV8t4djQc
 16aiqdBs1YcqPWKzfOtsQ/GaQCIk7W5/fHKfWhXN49/1kOS/ukRAZ2jSlzoKU/2WYbPT
 uhRos4iMT50oNEMMww+jE58FjxkubyoxObtqFgYNOX1hpxX2l9I13lUAYK5bm6BviDFl
 R9Fx/iLLfLA0bJ94KcAb6I6d0ZIvrOM7LS3LABF7OhpY/GyjMQ1vpbYxkvb2nGukBpM5
 F6rw==
X-Gm-Message-State: APjAAAVIVl+sL4R0tzpuqgzUL5DuwWZH9sd5giglABa8QIn0yKFiQD5n
 jN+P9FRgVkb8S92saxqO/359JQ==
X-Google-Smtp-Source: APXvYqx9YsLIXYcvWKbMmS4lei7RlFErod688mmuCTS1z4wfNQq0AzeNVRqw+cemmAoHPy9OggKAQQ==
X-Received: by 2002:a05:6000:118f:: with SMTP id
 g15mr1371829wrx.242.1571987797740; 
 Fri, 25 Oct 2019 00:16:37 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id g184sm1762554wma.8.2019.10.25.00.16.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2019 00:16:36 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id EEA481FF9E;
 Fri, 25 Oct 2019 07:37:14 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL v2 14/73] travis.yml: --enable-debug-tcg to check-tcg
Date: Fri, 25 Oct 2019 07:36:14 +0100
Message-Id: <20191025063713.23374-15-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191025063713.23374-1-alex.bennee@linaro.org>
References: <20191025063713.23374-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::435
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

This adds a whole bunch of asserts which will catch bugs you might
introduce into the TCG code.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

diff --git a/.travis.yml b/.travis.yml
index c43597f1331..ba3a8d4cfc9 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -334,14 +334,14 @@ matrix:
 
     # Run check-tcg against linux-user
     - env:
-        - CONFIG="--disable-system"
+        - CONFIG="--disable-system --enable-debug-tcg"
         - TEST_CMD="make -j3 check-tcg V=1"
         - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-default"
 
 
     # Run check-tcg against softmmu targets
     - env:
-        - CONFIG="--target-list=xtensa-softmmu,arm-softmmu,aarch64-softmmu,alpha-softmmu"
+        - CONFIG="--enable-debug-tcg --target-list=xtensa-softmmu,arm-softmmu,aarch64-softmmu,alpha-softmmu"
         - TEST_CMD="make -j3 check-tcg V=1"
         - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-default"
 
-- 
2.20.1


