Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8CE6C04EB5
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 15:09:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8535320838
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 15:09:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JYzdP/i/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8535320838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59008 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j05GK-0007IS-Jr
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 10:09:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60257)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j058H-0000oz-9i
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 10:01:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j058F-0003rx-0K
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 10:01:25 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:40391)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j058E-0003m8-PQ
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 10:01:22 -0500
Received: by mail-wm1-x342.google.com with SMTP id t14so3087846wmi.5
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2020 07:01:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=IJCI3ecePskizRDxYgL1MN+1IoehJPZSqp7DKKTNS8A=;
 b=JYzdP/i/D8FO0LkEpN0NgzLiA0P0LsfNY9+uJRk7aokme7rbTV+Q9aCT14jhDdzz22
 YdcN5f7qCR1B4UrgOKpuQ8qjDNUt3cC0Rzyi2QBdcPbsVQl502W7pdaKifQnsT7Dj2ys
 BJeOhWbWfO+ZU4euU9FREi91EkEKlsxEDtp44ry6N8EML9BOGc8bVoTLpfDxcQKMBBsb
 wgFr+g0ywJ7LB+bnbGXxup3/OZgfEjsSRR+b9HaITbSjMonX0j1zgTK34DQCz4OQZVuZ
 D5+Z0DONZASvT6IrJUzf8IjQSMR9mwEjxXc7PtUDsRc9lom1fAOik5kWJ01tYqTnwnem
 Kq7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=IJCI3ecePskizRDxYgL1MN+1IoehJPZSqp7DKKTNS8A=;
 b=T45Zm08XTBDIeSaiUMKg5mdT3miZ9lw17/GuJLoggKVAVI5dtQu+YQnu3wgdFVf7QN
 3B7kREBxYrexVkeK4TTJ5E6wlxvQkeEw9R9z2yz5hQGebXvkp1zhLipuz6tH4qA/oZ9z
 B75PeL6tjFoDTK6P1SqhjORhw/SuCHAz7p70fYYqr/qxQFEuQon2ZlUJcylbWjooKj6N
 X8rPEmHCdH56WESpF75Yx0joc1exl4rcBFkdI00jur0CqlQq6Z9pqTTY+5q9Fn+dtYk3
 4W9rSipPW3lNDR7YhmXu/UNQ9kUqlPbM8XyB5ed1thCDYttKun7AutFnG8c6zPb+XPLL
 VhDA==
X-Gm-Message-State: APjAAAUmmYqEMbjOUQMN5CuvQY6yseTRypxFobJgCJK8XCcfiNTQNEOj
 tMlTl0dqlHqupbKXUwEl7BMEqw==
X-Google-Smtp-Source: APXvYqzVWjDDMeaCLxNRhG5AojHFyJiPDRpm3KQage2ykWOJj8HuBYDCTY6w/vlwE29uaFxx6HZCbg==
X-Received: by 2002:a1c:7203:: with SMTP id n3mr4784113wmc.119.1581087681633; 
 Fri, 07 Feb 2020 07:01:21 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id i11sm3647867wrs.10.2020.02.07.07.01.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2020 07:01:19 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E38EE1FF87;
 Fri,  7 Feb 2020 15:01:18 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 0/5] plugins/next
Date: Fri,  7 Feb 2020 15:01:13 +0000
Message-Id: <20200207150118.23007-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: robert.foley@linaro.org, robhenry@microsoft.com,
 aaron@os.amperecomputing.com, cota@braap.org, kuhn.chenqun@huawei.com,
 peter.puhov@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

A few bits and pieces for plugin cleanup. The most major thing in this
series is tweaking the riscv decoder to only load the instruction
bytes it needs.

Alex Bennée (3):
  docs/devel: document query handle lifetimes
  target/riscv: progressively load the instruction during decode
  tests/plugins: make howvec clean-up after itself.

Chen Qun (1):
  tests/plugin: prevent uninitialized warning

Emilio G. Cota (1):
  plugins/core: add missing break in cb_to_tcg_flags

 docs/devel/tcg-plugins.rst | 13 +++++++++++--
 plugins/core.c             |  1 +
 target/riscv/translate.c   | 39 +++++++++++++++++++-------------------
 tests/plugin/bb.c          |  6 +++---
 tests/plugin/howvec.c      | 12 +++++++++++-
 tests/plugin/insn.c        |  3 +--
 6 files changed, 47 insertions(+), 27 deletions(-)

-- 
2.20.1


