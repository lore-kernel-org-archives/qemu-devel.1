Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99017C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 13:24:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 629D5206DA
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 13:24:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bN+mVGYc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 629D5206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55392 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiIGV-00016B-UV
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 08:24:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42597)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iiIF4-0007SJ-AA
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 08:22:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iiIF3-0005Ut-3R
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 08:22:54 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:38762)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iiIF2-0005R4-Mp
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 08:22:52 -0500
Received: by mail-wm1-x344.google.com with SMTP id u2so9218183wmc.3
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2019 05:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=xiAAb76pOFZYS2kb+B4csCpUenDpkD5QkNMd1FaRNGI=;
 b=bN+mVGYcqMSSDTzLyQVDCq3mZen+JsZOqjGVDW2W8PhOGUcQVcbXb12LvTK3+2zSNe
 EgeD7beYvGLd3XOctfv3vzckKhsc2kMpjC4Om1IvQEfC47xiTxYoIETMC1EPmnVOvV4S
 W3O6S/pdE83zsC9CBJ+c1XOVEqx3vVTtMhlY5AlAfGbNpQLGYd9AM0P/hY9Nwzxbz8B7
 a2vnjhOKMyOvKWcQWB9GhtDhzgmVP6e/RA4g+Xo27kkrdr8Xvs/XZVNqpWjFmYyCWxrj
 elc2gLyIJkyfd05kGw0ZChVHG2cRt+iUqQY4gHWk8qBzLLZne5mAz0CsFD36mAtzKrfV
 3sMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=xiAAb76pOFZYS2kb+B4csCpUenDpkD5QkNMd1FaRNGI=;
 b=NvbvvF6fEt6hNseZ4Wc5Q7jVOHOd55RK3pAyQJfBvq+IP1V6dOVVE/K1JzYFDFU89k
 DZ/oMcUv3Wz+tUZH+14UnK7d2RYiLEvQOPm0OIZ/uw2N/lYJ+/0dz/dResTQe4FdmCDv
 PAJG+CfmhrOEkQuPMrR8BMSSTbWwC+1SMlf0yBj7GOhH/iiX1iWKsRXsrH59kzTlHttK
 +6CGf4ZRfLozy6xAlG/pI8f45D8Lx4DEqZEEcDuKNeF+YDB1mONEMOPtD8YvbzeCkH+z
 cMJu2cVXlyNchhJkhX3zsFK3mUnnLG6ka2p5seQo5wCm0J71Thvw5OScd7l4iyhqIvJq
 a46w==
X-Gm-Message-State: APjAAAUCT8XlVRQo1Z0RZKdHT1hCdqFjmSnjNQ5VqlzpLZz+0nQJG8zL
 ulSHa7CkAL87wwttj+q93rnASw==
X-Google-Smtp-Source: APXvYqxouc9r3iP7ImYxpgnzr+4Ue6aVU0shUf/MHI1MqbJRbtiGoDot5KE8l9BBSozGoaYwSvb47Q==
X-Received: by 2002:a1c:f213:: with SMTP id s19mr17427208wmc.42.1576848171425; 
 Fri, 20 Dec 2019 05:22:51 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id s65sm9968729wmf.48.2019.12.20.05.22.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Dec 2019 05:22:47 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 96E5F1FF87;
 Fri, 20 Dec 2019 13:22:46 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v2 0/5] semihosting read console support
Date: Fri, 20 Dec 2019 13:22:41 +0000
Message-Id: <20191220132246.6759-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: keithp@keithp.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

A quick update to introduce a new "blocking" console read function for
semihosting. The main change is a new test case for user-mode and
changing the linux-user implementation to also block on a getchar()
without any fancy polling. Otherwise I've addresses the review
comments and re-tested.

The following patches need review
   05 - tests tcg add user version of dumb as bricks semi

Alex Bennée (4):
  target/arm: remove unused EXCP_SEMIHOST leg
  target/arm: only update pc after semihosting completes
  tests/tcg: add a dumb-as-bricks semihosting console test
  tests/tcg: add user version of dumb-as-bricks semiconsole test

Keith Packard (1):
  semihosting: add qemu_semihosting_console_inc for SYS_READC

 include/hw/semihosting/console.h          | 16 +++++
 include/hw/semihosting/semihost.h         |  4 ++
 hw/semihosting/console.c                  | 79 +++++++++++++++++++++++
 linux-user/aarch64/cpu_loop.c             |  1 +
 linux-user/arm/cpu_loop.c                 |  1 +
 linux-user/arm/semihost.c                 | 27 ++++++++
 stubs/semihost.c                          |  4 ++
 target/arm/arm-semi.c                     |  3 +-
 target/arm/helper.c                       |  8 +--
 target/arm/m_helper.c                     |  1 +
 target/arm/translate-a64.c                |  2 +-
 target/arm/translate.c                    |  6 +-
 tests/tcg/aarch64/system/semiconsole.c    | 38 +++++++++++
 tests/tcg/arm/semiconsole.c               | 47 ++++++++++++++
 vl.c                                      |  3 +
 tests/tcg/aarch64/Makefile.softmmu-target |  9 ++-
 tests/tcg/arm/Makefile.target             |  7 ++
 17 files changed, 243 insertions(+), 13 deletions(-)
 create mode 100644 tests/tcg/aarch64/system/semiconsole.c
 create mode 100644 tests/tcg/arm/semiconsole.c

-- 
2.20.1


