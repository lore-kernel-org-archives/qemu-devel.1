Return-Path: <SRS0=ZZp+=TS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2335C04AAF
	for <qemu-devel@archiver.kernel.org>; Sat, 18 May 2019 19:34:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2C572087B
	for <qemu-devel@archiver.kernel.org>; Sat, 18 May 2019 19:34:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Iio5Y0uY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2C572087B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37979 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hS56L-0004M1-SD
	for qemu-devel@archiver.kernel.org; Sat, 18 May 2019 15:34:37 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34600)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hS53e-0002NK-Af
	for qemu-devel@nongnu.org; Sat, 18 May 2019 15:31:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hS4rq-0007ZC-TE
	for qemu-devel@nongnu.org; Sat, 18 May 2019 15:19:39 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e]:37332)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hS4rq-0007Yh-OM
	for qemu-devel@nongnu.org; Sat, 18 May 2019 15:19:38 -0400
Received: by mail-pg1-x52e.google.com with SMTP id n27so2244514pgm.4
	for <qemu-devel@nongnu.org>; Sat, 18 May 2019 12:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id;
	bh=kNWizZq2qCo4VoGKtgyncVFOYpv0fo/wpkn1n6HcdBo=;
	b=Iio5Y0uYhkmB0I3YRLIR0rd1kCgETMp4yB9tzp2MTtS6OqCbMCGFxohsRb40p+KPWI
	/FdWZCqgv9f1lW12kyrMFDHwvWhu+xCI6EwiJVMgnRo9ubcbmKmg9fOyqlO5vAnf1M8d
	dR96xNzJxCQE9zj2m4rHI5i27Ein3Vo4EZm09aq4fmdJrca0IFv2rwPt3xdVIH9G6esD
	JM0TyWCv42sjpaYQXqT5ZEPOvO5UClwCZLz9opZ4s9ZfHfrPLJS1ArAGLJ1JtPlUUnRW
	XJGXRULx3qwVYrWJTI77Niv/NaPIt7Z3tJdxs9w/owY+uG0iz+OR/CP+efZJ0DMR3Aiv
	FsyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=kNWizZq2qCo4VoGKtgyncVFOYpv0fo/wpkn1n6HcdBo=;
	b=rxXjjcmkVlNzDlYQzONXx3HFoXJhbDgFYCBXs3YzS8DT3QmaY2Om+EFIwTy/dt7RZA
	yibebWJBGS2k9LFwHobC1BKqQ2L2i75zykdABph/yKpABooeYJFvX4rtHs/DCRp3jmCf
	QZeLmHU+C+8xKI825iCFY2UDJzMdaSxWqCpGcNh+u8LPLYRglOMe1/KNQslFPZmBEOLn
	ZRNcmlUYUM+vgKwYV1WcCQ0czYRXoQuy8CCgZtTFPp7GMhHIeT8NOpZ0AbM2vS5TwYIK
	2JgaseaNPjpKe30zK7ndvutKcBRDF9NYaQ+eNssQOUtbtNCpogApjU1/W07mJMpTrRHf
	cypQ==
X-Gm-Message-State: APjAAAVAMm4/KyMK+NL4TIyLyph0YJcmW2MNWq4rLEe6QRvdpnfYKY4U
	WfXqA9wIbc6tV6Bip5awU4LEVNzRRK4=
X-Google-Smtp-Source: APXvYqzvENSVG5jgPqth59uryyIa6LwMNWWyPus6XM0bsWaFUZFErg1Cx0XKb7zal8y5q3jhm9mxfA==
X-Received: by 2002:a63:ec02:: with SMTP id j2mr40225148pgh.340.1558207177340; 
	Sat, 18 May 2019 12:19:37 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	r185sm19639625pfc.167.2019.05.18.12.19.36
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sat, 18 May 2019 12:19:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sat, 18 May 2019 12:19:32 -0700
Message-Id: <20190518191934.21887-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::52e
Subject: [Qemu-devel] [PATCH 0/2] target/arm: make use of new gvec expanders
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Based-on: <20190518190157.21255-1-richard.henderson@linaro.org>
Aka "tcg: misc gvec improvements".

We've added (or are adding) generic support for variable vector shifts
and bitsel.  This trivially replaces the implementations of BSL, BIT,
and BSL.  It enables a reasonable implementation of {U,S}SHL.


r~


Richard Henderson (2):
  target/arm: Vectorize USHL and SSHL
  target/arm: Use tcg_gen_gvec_bitsel

 target/arm/helper.h        |  15 +-
 target/arm/translate-a64.h |   2 +
 target/arm/translate.h     |   9 +-
 target/arm/neon_helper.c   |  33 ----
 target/arm/translate-a64.c |  33 ++--
 target/arm/translate.c     | 362 ++++++++++++++++++++++++++++---------
 target/arm/vec_helper.c    | 176 ++++++++++++++++++
 7 files changed, 486 insertions(+), 144 deletions(-)

-- 
2.17.1


