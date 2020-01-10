Return-Path: <SRS0=GavZ=27=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AA5FC282DD
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 16:18:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2470F20673
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 16:18:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vXqGTa5l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2470F20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipwz4-0003HA-K6
	for qemu-devel@archiver.kernel.org; Fri, 10 Jan 2020 11:18:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44377)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1ipwxa-0002MU-Lg
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 11:16:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1ipwxZ-0007VY-IE
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 11:16:30 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:41043)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1ipwxZ-0007RU-B9
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 11:16:29 -0500
Received: by mail-wr1-x443.google.com with SMTP id c9so2338786wrw.8
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2020 08:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=gfwvHVDYbZuSvNzi99+6DJsZZB/y1TAqSvUL0BKJ2cA=;
 b=vXqGTa5lflyFd2DT/rgKQdc/FGBJZbN4ofkeRaPfkwGXqmt/fVcIR9IC+f6Zpsmxsx
 nSwjUDx+8oF6SG8/Y8G28aWuuUsEKy9RRjZA6FVDmaTfZT+ppOePEAmdAn4xFrvIFFKV
 f25MFCdfo4/3lCHeYP3kyhbf9uIeKFGpeC57Ds8b/QzVK1vegiLY4tHo4Ny3mk+i409O
 od7DacXhEDWy93rHaGWhwjnInG5nLxZYS+nLlYOgD1VT7C5/qcpNVWNDd7zdqc/h1SKK
 fWYHHGXCWM4xXLAH4h7hsXrwOCH3vPGL7Y9sJYfSqstun+YUVi5UynnKvm9atcDhVEuo
 tLjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=gfwvHVDYbZuSvNzi99+6DJsZZB/y1TAqSvUL0BKJ2cA=;
 b=h+2/LaPrgd8fjSbwiDWCryY7sO3E2Wy2JLm71XvOC6tucHpyyg8ZsJA5uFmIxvknbi
 YGKoRJG5Ucue2EQHo3+uoB+yT667JWa1lVGIB333MLBcIxfGYdOLIQM+T5GyB65RwYv/
 XTKv2gpN/ZT03xBxQgWM3RuBdsYF+NF63nAdVopuBQ8F7QWEUm3fTg+nH4alkDdlU57K
 DC6AQuOajIfA190NI1najz/DttL2mcKYJzruLW7BWYiAD555VgCxgWVyNme9hobbPEr/
 PS0KTqmLLU5xCh05+reAjF9oQu6p9OCa+UMsfMb1avsAF3O+zjrwj/XEdnCE1QA83ed2
 Gogg==
X-Gm-Message-State: APjAAAXRIA8M2gL3T3vhpPQFw59eOinCdIHLKZuwrjcH1UFj2W+wDKMt
 Wtl73bsp6ZhnTD93k7uxIDzR6A==
X-Google-Smtp-Source: APXvYqxJQoKEAp4Hc2/06jUCIOCe9HbH0z+1GsbBS41Y/g1uK8Kr2KvITGl1NXe9KE5uKHaCc0VpBw==
X-Received: by 2002:adf:9c8a:: with SMTP id d10mr4389734wre.156.1578672987998; 
 Fri, 10 Jan 2020 08:16:27 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id x11sm2703165wmg.46.2020.01.10.08.16.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2020 08:16:27 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 45C221FF87;
 Fri, 10 Jan 2020 16:16:26 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 0/2] fix for bug 1859021
Date: Fri, 10 Jan 2020 16:16:24 +0000
Message-Id: <20200110161626.31943-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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

This is a fairly trivial fix for a uint64_t overflow however I spent
some time making sure I understood why we got stuck in a busy loop and
adding tests to both tcg and kvm-unit-tests.

Alex Bennée (2):
  target/arm: detect 64 bit overflow caused by high cval + voff
  tests/tcg: add a vtimer test for aarch64

 target/arm/helper.c                       |  3 +
 tests/tcg/aarch64/system/vtimer.c         | 80 +++++++++++++++++++++++
 tests/tcg/aarch64/Makefile.softmmu-target |  4 ++
 3 files changed, 87 insertions(+)
 create mode 100644 tests/tcg/aarch64/system/vtimer.c

-- 
2.20.1


