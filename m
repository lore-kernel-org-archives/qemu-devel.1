Return-Path: <SRS0=F+Q9=YM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD1B3CA9EAB
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2019 15:13:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC2F7222D2
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2019 15:13:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WPtHIj+2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC2F7222D2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLqQA-0002tV-1H
	for qemu-devel@archiver.kernel.org; Sat, 19 Oct 2019 11:13:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45646)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iLqNn-0001BU-Is
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 11:11:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iLqNm-0006wb-Dz
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 11:11:07 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:53861)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iLqNl-0006sk-UK
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 11:11:06 -0400
Received: by mail-wm1-x341.google.com with SMTP id i16so8955423wmd.3
 for <qemu-devel@nongnu.org>; Sat, 19 Oct 2019 08:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=MF0EQPP3cD8SJXZvLkrocXszvXXa5m91dnqBgj92aeQ=;
 b=WPtHIj+28/Sh13vOIiM9hndXFcypP5AuIER2wK+I9mR32cLrXFzhG/JEnnJWihAOAr
 rbAkI3+QIXyUKR+8fXaWsYdJyjOnADS+DXFUssq2ZFhLKhv6WGZIX/dHHUyoYO9xqQ6c
 OkQy/fA8hBlo/gZxd8xgkgMTnX5NjBQVCMQyH7B7z5qAcMpZ4sB4pf5IRJ6LJOyWTCvB
 Wwf1ZDadY/niBFH8jotyvqw46qZa30L6SER+gBVuYMB1MvQ8wVGqBMBlYqmbISOrT86V
 70ZpgvXC0+BSzmKWjhi8t40LlGe5TG1FmF0+K7+ekeQq7YqLo/kJaGOyIg+e8R1nPD+Q
 bLfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=MF0EQPP3cD8SJXZvLkrocXszvXXa5m91dnqBgj92aeQ=;
 b=RsDC7uilteZNPZFm07PXgjvGoK08xHHlSkXLgmTxG7a/Av20GttbqlGVvWTtHY2Wfl
 eoBqG5mPAtDMA/FzKE50yqvhFG6dBBL3bWHDWT5aPEWB9m76nT7e/oYUDi6tToLQ1X8j
 tVxV4m9sLnoewmrisSh//rT9vf90o0oiRTEXw41jXZQ3PAbAJoGlG6QcEFJ56CEaMnsE
 /fdEgqDxfR1gUJncwg0HwxiOeObYucYs8xe7uOi53zKjCxu4cHmBHoIGbf3PN0ry3z6u
 8ZE6kja84NZDfkBra+iQhf9QjpdiQpGJMnd/qmfwk3xkKrTv9Ro9xalSF8os2rLGvWtb
 4r5Q==
X-Gm-Message-State: APjAAAUrFOQllgqoNCDNi9hZDctHA34QIfsh6Rrg4FjjiGlIebnyzo1l
 +dPpg0e7h7VhghmuU9WoQ5khVrRx
X-Google-Smtp-Source: APXvYqzsfIPCghwHztq2QUKDQ9z8Q/+2AqxoLFPujLe4Xx4nxIHhwbJiX4ovodk8DR2XDpJP+67bjg==
X-Received: by 2002:a05:600c:143:: with SMTP id
 w3mr11172712wmm.35.1571497860713; 
 Sat, 19 Oct 2019 08:11:00 -0700 (PDT)
Received: from x1w.redhat.com (14.red-88-21-201.staticip.rima-tde.net.
 [88.21.201.14])
 by smtp.gmail.com with ESMTPSA id t13sm10753964wra.70.2019.10.19.08.10.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Oct 2019 08:10:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 00/11] tests/acceptance: Fix 64-bit MIPS target tests
Date: Sat, 19 Oct 2019 17:10:47 +0200
Message-Id: <20191019151058.31733-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, PhilMD <f4bug@amsat.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>, Cleber Rosa <crosa@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: PhilMD <f4bug@amsat.org>

Commit 9090d3332cdcc introduced a regression which makes the
64-bit target tests to fail.

This series fix it (by previously refactoring the linux_ssh_malta
test), and also add another test for the 5KEc CPU.

I had to include Avocado-related patches not yet merged again to
avoid sending patches that will later not apply.

Please review,

Phil.

Cleber Rosa (1):
  Acceptance tests: refactor wait_for_console_pattern

Philippe Mathieu-Daudé (10):
  tests/acceptance: Fixe wait_for_console_pattern() hangs
  tests/acceptance: Send <carriage return> on serial lines
  tests/acceptance: Refactor exec_command_and_wait_for_pattern()
  tests/boot_linux_console: Use Avocado archive::gzip_uncompress()
  tests/boot_linux_console: Run BusyBox on 5KEc 64-bit cpu
  tests/ssh_linux_malta: Run tests using a snapshot image
  tests/ssh_linux_malta: Remove duplicated test
  tests/ssh_linux_malta: Match stricter console output
  tests/ssh_linux_malta: Refactor how to get image/kernel info
  tests/ssh_linux_malta: Fix 64-bit target tests

 .mailmap                                  |   1 +
 tests/acceptance/avocado_qemu/__init__.py |  45 ++++++++
 tests/acceptance/boot_linux_console.py    |  88 ++++++++-------
 tests/acceptance/linux_ssh_mips_malta.py  | 124 +++++++++++-----------
 4 files changed, 159 insertions(+), 99 deletions(-)

-- 
2.21.0


