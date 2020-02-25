Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FF6AC35DF5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 13:11:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EAA821744
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 13:11:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ehWAejFL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EAA821744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6ZzW-0001sS-Gl
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 08:11:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59048)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j6ZcI-0005Gy-Vd
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:47:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j6ZcH-0007AK-Hx
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:47:14 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:52248)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j6ZcH-0007A0-4Q
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:47:13 -0500
Received: by mail-wm1-x334.google.com with SMTP id p9so2866826wmc.2
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 04:47:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=yHiUnSiiRPYiPjChvKaEdKGXR8Q647zcjblW8i6ibWA=;
 b=ehWAejFLyb1hPZuxXAnNr5HL+OE3d0g18dvt8EZWolzz5mvBPti5mqjXZTG2dbRm05
 vKuH5Gi+DNYvfz8s2Xatiws/T5vNA5hYIQCpTjnVegec67VhAJP7yDKmq8wW0sFWvwrs
 DLVnNTFCl66kft/Jpd0IkEvXAcOMbYW6Dpm1d7NARb8BjgCzCitpPLH2A2KzXHd9SGxw
 VNJCCbirLAzGMFZ3IKExHCnZfwGBZoRV0aH2QyvkQX2s2FlX9IYZp5CaxnGkfsEHJiSh
 Mz9t7ZHPsRVYDjBcWJOTwifcMM81c7cLLPfMChez8zUOM0ZX0hIQ/mBpy2viC0rvBdRZ
 24ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=yHiUnSiiRPYiPjChvKaEdKGXR8Q647zcjblW8i6ibWA=;
 b=Z9IM/gymWEaubjyFMGtInHz8Wz/A9t4UQqegJWiAdbBWNUUJfNNWRRxLzWQLANB2TM
 kAMxzmAisJ/BgjXNw3GGo4Hh4f+cid+vVDKBz+HyyApMdEPtg03Ti16kx6qjVK49qS6p
 d2/DZte1uy7aVtwdAvEsIWkX/fCULRtSlVXxcuNw/Ggw8Dqn/rcHwg34cGdJE/0+h74C
 H1I9ZUw1ViwvVuldsiJ78KrAyRDxYHMWL5pFJPAmqLYKO4FywrPeRFfEzkeNNNOE6rCo
 FqugaKxTcpX7Hbmnvv9Lqoe0BojM0EMKr27v80IU3NkzJvcOOAI3UrYKej8GlZRGXxHt
 ZKmw==
X-Gm-Message-State: APjAAAVFeLenOWU8TwcIOX2J+Ti4T7UztD2v5WNoZS1Zz0inL8RE4K3D
 RxbctHJCOhWVPjOYCGpj+/qkjA==
X-Google-Smtp-Source: APXvYqyqxNBe7fEHEs1EG6Fr2pVLwhJ7nkjNCVEVHNiwT0ZIESSAEntc9aSQV98OsHHkEWI8GPlxKg==
X-Received: by 2002:a1c:4383:: with SMTP id q125mr5184988wma.88.1582634831963; 
 Tue, 25 Feb 2020 04:47:11 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id m19sm2547568wmc.34.2020.02.25.04.47.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2020 04:47:10 -0800 (PST)
Received: from zen.home.arpa (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 4598D1FF87;
 Tue, 25 Feb 2020 12:47:10 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v3 00/19] testing & plugin updates
Date: Tue, 25 Feb 2020 12:46:51 +0000
Message-Id: <20200225124710.14152-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::334
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
Cc: fam@euphon.net, berrange@redhat.com, robert.foley@linaro.org,
 pbonzini@redhat.com, stefanb@linux.vnet.ibm.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org, robhenry@microsoft.com,
 marcandre.lureau@redhat.com, aaron@os.amperecomputing.com, cota@braap.org,
 stefanha@redhat.com, kuhn.chenqun@huawei.com, peter.puhov@linaro.org,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

Nothing over v2 apart from signoffs. It would be nice to get the last
one reviewed before I roll the PR.

 - tests/iotests: be a little more forgiving on the size test

Alex Bennée (13):
  tests/tcg: include a skip runner for pauth3 with plugins
  tests/rcutorture: update usage hint
  tests/rcutorture: better document locking of stats
  tests/rcutorture: mild documenting refactor of update thread
  travis.yml: single-thread build-tcg stages
  tests/iotests: be a little more forgiving on the size test
  tracing: only allow -trace to override -D if set
  docs/devel: document query handle lifetimes
  target/riscv: progressively load the instruction during decode
  tests/plugins: make howvec clean-up after itself.
  tests/tcg: give debug builds a little bit longer
  tests/tcg: fix typo in configure.sh test for v8.3
  tests/tcg: take into account expected clashes pauth-4

Chen Qun (1):
  tests/plugin: prevent uninitialized warning

Emilio G. Cota (1):
  plugins/core: add missing break in cb_to_tcg_flags

Richard Henderson (1):
  tcg: save vaddr temp for plugin usage

Thomas Huth (1):
  travis.yml: Test the s390-ccw build, too

Wainer dos Santos Moschetta (1):
  travis.yml: Fix Travis YAML configuration warnings

Yoshinori Sato (1):
  qemu/bitops.h: Add extract8 and extract16

 docs/devel/tcg-plugins.rst                | 13 +++-
 include/qemu/bitops.h                     | 38 ++++++++++++
 target/riscv/instmap.h                    |  8 +--
 plugins/core.c                            |  1 +
 target/riscv/translate.c                  | 40 ++++++------
 tcg/tcg-op.c                              | 23 ++++++-
 tests/plugin/bb.c                         |  6 +-
 tests/plugin/howvec.c                     | 26 +++++---
 tests/plugin/insn.c                       |  3 +-
 tests/rcutorture.c                        | 74 ++++++++++++++++-------
 tests/tcg/aarch64/pauth-4.c               | 54 +++++++++++------
 trace/control.c                           | 11 +++-
 .travis.yml                               | 23 ++++---
 tests/qemu-iotests/214                    |  4 +-
 tests/tcg/Makefile.target                 |  4 +-
 tests/tcg/aarch64/Makefile.softmmu-target |  2 +
 tests/tcg/configure.sh                    |  2 +-
 17 files changed, 235 insertions(+), 97 deletions(-)

-- 
2.20.1


