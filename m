Return-Path: <SRS0=v56/=TT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F754C04E87
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 14:38:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 146FF21851
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 14:38:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ihXFl8Q6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 146FF21851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49561 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSMxc-0005JP-8N
	for qemu-devel@archiver.kernel.org; Sun, 19 May 2019 10:38:48 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58469)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSMw1-0004S7-9L
	for qemu-devel@nongnu.org; Sun, 19 May 2019 10:37:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSMw0-0007OR-Bs
	for qemu-devel@nongnu.org; Sun, 19 May 2019 10:37:09 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e]:37470)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hSMw0-0007Ns-3P
	for qemu-devel@nongnu.org; Sun, 19 May 2019 10:37:08 -0400
Received: by mail-pg1-x52e.google.com with SMTP id n27so2923205pgm.4
	for <qemu-devel@nongnu.org>; Sun, 19 May 2019 07:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=WPUvViTdN8PoJfzSHvNo7aUGAd0OZus5IdnMEt+G1Ek=;
	b=ihXFl8Q6DseWNHffG3B53955DPtN8Fah/KEHmp4xHiOocbRXT/GndQSIUEszTuq2Si
	YUfym9qHuJT3wCb0mi20fz/eMYX+HqJuEpOFRuM0jrkmMSz02zPzTZa6dGecZyhcfDEM
	ShdQjYpC6udC9GU/CHF0Jk+xJu4VKXJXnt5UY1MD8hxKQhLdPWGs9We05GQKawfzEU3K
	CQspRrPcCwvHSbJUbi93vAZWCF6zz10s7cwiCnI62VbWuPyklNOa2HOD3gycjeXwGqc9
	Msx/HCCslHlQfI9k//MhAQmFAP3Yax3w1YfFMR5mBt19AlURkhOyXflmysfc6fPFIIFZ
	mCLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=WPUvViTdN8PoJfzSHvNo7aUGAd0OZus5IdnMEt+G1Ek=;
	b=gF5R0ORc369xjCLionogu2ap9PTTNuLpgZj81pMEBAc2SdTCU3jcIT8bQK6egewmkq
	VIJS88fRXrp9nnD9AsYuWRLwevOzMZxFePJBCSYbNa8qvwdap8O5d/okajrIUZNiuMT4
	1tkPl84pXBe3Kf04+KOAyRKDimDwB5NPiW3dbqAP1BofE1Uc21g/h+F3RNHAG4twesiC
	6qzRJcqpObgYQ/OCXnR+qnFWwiUfZqwsT0zATtQhhlZYuPUUvYPFymiEWHqwUKQQ2o0j
	g37fZn7dX+GSxefSHk20lM1HjC70bOlBXFh1WmE2bc9T9BBaxdNRteG9oR3gDl25QvMm
	gapA==
X-Gm-Message-State: APjAAAUaVeCe0RzZf0iivu1xrMe7LYoY/n+bi5jEJiE0eV7rl2to3Haf
	deo9h6JBL5du8AplJe2qHqBm4P6G/wE=
X-Google-Smtp-Source: APXvYqxp07GvhWzl0m1FvI5DPG9W0TXfFYu2vhAk3XRz34OcY2vqRWfSV983YcUwlRSnohgLRPCj7w==
X-Received: by 2002:a63:4d56:: with SMTP id n22mr41496786pgl.307.1558276625733;
	Sun, 19 May 2019 07:37:05 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	184sm18248195pfa.48.2019.05.19.07.37.03
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sun, 19 May 2019 07:37:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sun, 19 May 2019 07:37:00 -0700
Message-Id: <20190519143702.5587-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::52e
Subject: [Qemu-devel] [PULL 0/2] target/alpha: Fix user-only floating-point
 exceptions
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 1b46b4daa6fbf45eddcf77877379a0afac341df9:

  Merge remote-tracking branch 'remotes/kraxel/tags/ui-20190517-pull-request' into staging (2019-05-17 17:25:19 +0100)

are available in the Git repository at:

  https://github.com/rth7680/qemu.git tags/pull-axp-20190519

for you to fetch changes up to 21ba856499f9c0ccdc05ed04432df059ae76b337:

  target/alpha: Fix user-only floating-point exceptions (2019-05-19 07:30:03 -0700)

----------------------------------------------------------------
Fix https://bugs.launchpad.net/bugs/1701835

----------------------------------------------------------------
Richard Henderson (2):
      target/alpha: Clean up alpha_cpu_dump_state
      target/alpha: Fix user-only floating-point exceptions

 linux-user/syscall_defs.h |   3 +-
 target/alpha/cpu.h        |  42 +++++++++++++++++++
 linux-user/syscall.c      | 104 ++++++++++++++++++++++------------------------
 target/alpha/fpu_helper.c |  21 ++++++++--
 target/alpha/helper.c     |  39 ++++++++++++-----
 5 files changed, 140 insertions(+), 69 deletions(-)

