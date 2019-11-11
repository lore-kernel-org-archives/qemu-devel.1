Return-Path: <SRS0=6DzB=ZD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4560C43331
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 15:58:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E8C621655
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 15:58:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Sd+SKUej"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E8C621655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUC4n-0002iC-9T
	for qemu-devel@archiver.kernel.org; Mon, 11 Nov 2019 10:58:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37946)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iUC2x-00016x-6I
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 10:56:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iUC2v-0007no-Vb
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 10:56:06 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:41515)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iUC2v-0007nM-O3
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 10:56:05 -0500
Received: by mail-wr1-x430.google.com with SMTP id p4so15186433wrm.8
 for <qemu-devel@nongnu.org>; Mon, 11 Nov 2019 07:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=kHUJpSpH1yw4R83U28pX7pV8QkyCoUXlozixslbZnDQ=;
 b=Sd+SKUejBkdMtQeQmWSwBe/WxPHmHIBJKmM+IpCxi1hfgNzWsRP+aCpnqCmEaEaOI6
 Yp34liHXKVBdMkaZ2KTOCnRLikTnGA4LfG/rHQNQO6uIPOQM1Y/BW7X+GPqpxqGeItog
 bNmfuM7tWHUYlnszmrybjrv6doTcijlOMrt1xl1jlH0sIrk+QZ9fXCm4WHQW04YIVe4P
 eJz3jXHrR8M1jttyg1wJc8WDP6j1Sf01APJNDX4zGSA3xnodopw52A9rMxiWmpM3KXDa
 CmHhZtpfCcyDqWd8B4A4A7KEpymObnf00hHGamQJ8V/tGSYRKG2CXrVwHzq+LqQMWdtd
 mplA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=kHUJpSpH1yw4R83U28pX7pV8QkyCoUXlozixslbZnDQ=;
 b=bbMg78weD0kiR3j9Foo93kjDg4hUaczvj3Rj44z16N3N0j4/Z/PQ/SpkpRuDrq2413
 /S04hhOiDXfA8mz4tUUfhUyTCmkSdFOPkCNSuj5NXpvn7sgC2cdr9rfY5oBY4/ZZEi1M
 OmYce9vStPHhUscJgV9ZtULHPoJMVM6NziUZx+Apt7l+bEszuJgQ+Ghkt9MNsM2PKVBm
 9rwM8qRPG742php+U5ZteMEHSEX5CvObJ8X3o7kpwP9RtfvThA5fUbByZtfVgIiUk7Q1
 hh6KGRLnKEoC/7Syve2i320Jw/Jj3cSHFi9vHCov4WXdoBNK6fN7jlbGnQsez71zJuyK
 nvUw==
X-Gm-Message-State: APjAAAXZay1dCRW5sBFQEgAuOk5olYWDwOsSqv7g3JcaeRZb0rWIHSli
 7f01PHvKLCZdVvLyGe+CitRFm8F4AX/O5A==
X-Google-Smtp-Source: APXvYqwctg+QfeIORTREmK0c1BSjCGq9FaGBoCjknj/KtGJ4NNiNDFSafZGseshhbHZ7ioWZl1Usag==
X-Received: by 2002:a5d:6706:: with SMTP id o6mr771046wru.54.1573487764120;
 Mon, 11 Nov 2019 07:56:04 -0800 (PST)
Received: from localhost.localdomain
 (199.red-79-149-206.dynamicip.rima-tde.net. [79.149.206.199])
 by smtp.gmail.com with ESMTPSA id f19sm30023156wrf.23.2019.11.11.07.56.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Nov 2019 07:56:03 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 0/4] tcg patch queue
Date: Mon, 11 Nov 2019 16:55:47 +0100
Message-Id: <20191111155551.13885-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::430
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 654efcb511d394c1d3f5292c28503d1d19e5b1d3:

  Merge remote-tracking branch 'remotes/vivier/tags/q800-branch-pull-request' into staging (2019-11-11 09:23:46 +0000)

are available in the Git repository at:

  https://github.com/rth7680/qemu.git tags/pull-tcg-20191111

for you to fetch changes up to cb974c95df0e1c9e73a37facd3e13894bd3eedc2:

  tcg/LICENSE: Remove out of date claim about TCG subdirectory licensing (2019-11-11 15:11:21 +0100)

----------------------------------------------------------------
Remove no-longer-true statement that TCG is BSD-licensed

----------------------------------------------------------------
Peter Maydell (4):
      tcg/aarch64/tcg-target.opc.h: Add copyright/license
      tcg/i386/tcg-target.opc.h: Add copyright/license
      tcg/ppc/tcg-target.opc.h: Add copyright/license
      tcg/LICENSE: Remove out of date claim about TCG subdirectory licensing

 tcg/aarch64/tcg-target.opc.h | 15 ++++++++++++---
 tcg/i386/tcg-target.opc.h    | 28 +++++++++++++++++++++++++---
 tcg/ppc/tcg-target.opc.h     | 20 ++++++++++++++++++++
 LICENSE                      |  5 +++--
 tcg/LICENSE                  |  3 ---
 5 files changed, 60 insertions(+), 11 deletions(-)
 delete mode 100644 tcg/LICENSE

