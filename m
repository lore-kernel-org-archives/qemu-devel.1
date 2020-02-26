Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE89C4BA1E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 18:11:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B6FA21556
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 18:11:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uF3WhlzW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B6FA21556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j719M-0008Hb-DT
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 13:11:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40598)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j718b-00076L-86
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 13:10:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j718a-00062f-CI
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 13:10:25 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:40713)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j718a-00061Q-5V
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 13:10:24 -0500
Received: by mail-wm1-x32b.google.com with SMTP id t14so231635wmi.5
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2020 10:10:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=LsCWnhAvrs83gaBRDHbiIWQXeBQ4TuQ1uQ9PFAxp7z4=;
 b=uF3WhlzWVCjqrIqpflQhsnA6ZK6SaoPi4D9E2LBPf0kyUBT8k5BxkZ4kCdMPcFv6M1
 Ru3nhY1X0bB2kO7eVFKRUxd8OJRRZA4xvJz5j4y/lcjNa+c7MbDhUXjkvC0qzgk2ZaG+
 4jVd4XrXotm5iLG3O29kv2mReWBZjEbwdec4wjrLUxwoUPv+JftiFTRo6r37V/eOxK8e
 AZU2YBsObz3H3Hh2OgWS91M21jG7+zJiRIMVemxg4deVK9Tqzd/NTw4WLXgJCKLrzv1M
 FWUQKdEyty2/0/GxAr0+pRiu8xNufuTW1tpu2wCTgiKBmoD/odVCYkjgIyHj9sZIPps4
 jWEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=LsCWnhAvrs83gaBRDHbiIWQXeBQ4TuQ1uQ9PFAxp7z4=;
 b=G8WACrx9itml1ITwjYI0Iq/rRgamf5D4FIHDEndBUomRm4fSFHck2lLffay/hUg50P
 BkvCWTxEAQfbnknVkKdS/zXjGUDYVpqYEn0+RdM0gSWJksNYz826ta8OasyHuTR92idG
 2y5na6O4dNo23t9L6q3QTKol8LoYgGUEpS0GuJg1ztx+8WzR7YGYX0H6XVIeM5z5PeK3
 ULziY1iKQ9KTK5UWQY8hPzKq5CpRMjGvH38M95yf/dQVbOi4O0g3n/vaUNpPADpaOvNj
 eTCS9LO0Uu0joofC6+NjcZqwr10MzYZhjs38t55R70D9TEAo/Yxqpq1cxdJhd5CfOyBR
 zpWQ==
X-Gm-Message-State: APjAAAXfD+FpMcW4klOckTAABMtEn3kIjICW/YGx/DiEiw5xl0NhmHCs
 PqJylWWy0gadx3sK6HdhMzwMdw==
X-Google-Smtp-Source: APXvYqwfRY7e6aDIRqw6Dq8qFIbCMopXr6vu0QUgZuBS/TZDj8ZaHfvDxnhNkdhtBJiLoZ06JB9JAQ==
X-Received: by 2002:a7b:cf12:: with SMTP id l18mr143843wmg.66.1582740622977;
 Wed, 26 Feb 2020 10:10:22 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id j14sm4405876wrn.32.2020.02.26.10.10.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2020 10:10:21 -0800 (PST)
Received: from zen.home.arpa (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D5CD91FF87;
 Wed, 26 Feb 2020 18:10:20 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 0/4] Fix codegen translation cache size 
Date: Wed, 26 Feb 2020 18:10:16 +0000
Message-Id: <20200226181020.19592-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32b
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
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

Slightly more cleaned up series based on what I sent earlier today to
fix the recent slowdown in emulation caused by an overly small
translation cache.

Please review.

Alex Bennée (4):
  accel/tcg: use units.h for defining code gen buffer sizes
  accel/tcg: remove link between guest ram and TCG cache size
  accel/tcg: only USE_STATIC_CODE_GEN_BUFFER on 32 bit hosts
  accel/tcg: increase default code gen buffer size for 64 bit

 accel/tcg/translate-all.c | 42 +++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 22 deletions(-)

-- 
2.20.1


