Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF67DC3F2D7
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 18:22:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C29E124673
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 18:22:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ewcGuiMG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C29E124673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8phm-0007j7-Vb
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 13:22:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43482)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j8pep-0002QS-W1
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 13:19:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j8peo-00017J-RT
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 13:19:11 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:36395)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j8peo-000165-JK
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 13:19:10 -0500
Received: by mail-wr1-x42f.google.com with SMTP id j16so1008213wrt.3
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 10:19:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=4dHa+MZePXR7QI6+BxX3W06bgfxpjCqKFrM6J8weaRI=;
 b=ewcGuiMGVNJ0MCY9ZwCZRNCK4S9/mCPSC5+il6bNykEiivN2mbY1ZrvsCcjGakjyNn
 MiauaV0KoB2mpglzoJZuTw/Q9Z1p2FrJO9YD1lu6ZocR3GETINFOMi4q6xqFODrsEK+8
 MnagVIoHUAl4zm7gIgYHCmQpfVE4BZvDuZWodUv5eifVB/qOHfZmckzCdtxBuZGZhBzZ
 xGgxRG1WgcPvGfl61XQ/Lp9WDDL0ZUPZyPMs0zWnXsCUxrS0wuHQ2JwznGGoJxrPQ0SZ
 4k1WRfKoIenvzdATwRf+guAfVJcUdfdkQyAwrFE/MsxxXqPnkJeQ7ZysRmgdP5fjCYOm
 dVOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=4dHa+MZePXR7QI6+BxX3W06bgfxpjCqKFrM6J8weaRI=;
 b=KFc/J/B0ujVWgN89d1fZJVFCLTSCd0EIkOx3MquP6SzZ2owktGqR6akOm0e6dNdhZQ
 FPtJU2xKCCP5CUoO+s/tATCEvYutZwwfdEUrC91QLdEyOtZWb2MQkFpiK8GBBAOc04hk
 s7Qq0NMpuSUwLA/givB1Yk/Vv0Gm55vh5kggwuwy/L7nE3OEXqAoShdPYpQuDQ8xtdYT
 1GUGLtuEIzPNLmyyxftNrEz4zwPmPgn2Nv+h7ZBfjYJBA6vnRoWACBYlx7U/VZnxazy2
 UUXyRgfKrZCC17Uf3jbY69hJZqO/4blpq+M9LQBTXOmQUevW45A1wHnbKrTXGkbjgEFw
 S3TQ==
X-Gm-Message-State: ANhLgQ06UUxXshodZtNU36+XOgj5JQnAIiZES65Wrq2e5PjziO7V9d0V
 v8obOiz7/bEzSn1eesxJcehqdg==
X-Google-Smtp-Source: ADFU+vtVK0B6TlrJDiguUeFpvu9CKUVYh1Ia0YFKABHaHEgoYj9f335eF5oFwjk+/CbR8FDB9BgATw==
X-Received: by 2002:a5d:6ac1:: with SMTP id u1mr743225wrw.383.1583173148969;
 Mon, 02 Mar 2020 10:19:08 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id q6sm28855789wrf.67.2020.03.02.10.19.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2020 10:19:08 -0800 (PST)
Received: from zen.home.arpa (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 7EA0D1FF87;
 Mon,  2 Mar 2020 18:19:07 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 00/10] testing/next updates (tweaks and re-greening)
Date: Mon,  2 Mar 2020 18:18:57 +0000
Message-Id: <20200302181907.32110-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42f
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

I was reviewing Roberts vm-build.aarch64 patches when I ran into some
problems with testing. Then I noticed the CI had turned red again so I
went to fix those problems and here we are.

The following patches are mine and need review:

 - travis.yml: install python3 numpy and opencv libraries
 - tests/acceptance: move @skipUnless decoration to test itself
 - configure: detect and report genisoimage
 - configure: fix check for libzstd

Alex Bennée (4):
  configure: fix check for libzstd
  configure: detect and report genisoimage
  tests/acceptance: move @skipUnless decoration to test itself
  travis.yml: install python3 numpy and opencv libraries

Laurent Vivier (1):
  travis: enable tools build on OS X

Robert Foley (5):
  tests/vm: use $(PYTHON) consistently
  tests/vm: Debug mode shows ssh output.
  tests/vm: increased max timeout for vm boot.
  tests/vm: give wait_ssh() option to wait for root
  tests/vm: Added gen_cloud_init_iso() to basevm.py

 configure                              | 15 ++++++-
 .travis.yml                            |  3 ++
 tests/acceptance/machine_mips_malta.py |  4 +-
 tests/vm/Makefile.include              | 16 +++++--
 tests/vm/basevm.py                     | 61 ++++++++++++++++++++++++--
 tests/vm/centos                        | 33 +-------------
 tests/vm/ubuntu.i386                   | 37 +---------------
 7 files changed, 91 insertions(+), 78 deletions(-)

-- 
2.20.1


