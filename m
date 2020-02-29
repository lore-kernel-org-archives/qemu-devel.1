Return-Path: <SRS0=0Zkw=4R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CFF2C3F2D2
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Feb 2020 02:44:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CF022469D
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Feb 2020 02:44:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aQKwZYNX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CF022469D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7s7d-00009S-5Q
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 21:44:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42679)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j7s6d-00076Q-5z
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 21:43:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j7s6b-00031e-MU
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 21:43:54 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:42314)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j7s6b-0002y0-G4
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 21:43:53 -0500
Received: by mail-pl1-x644.google.com with SMTP id u3so1946593plr.9
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 18:43:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=+bGP5zTQ9CEVKQuxiSM93QKGtD6GSUP/eq+pny3GVwY=;
 b=aQKwZYNXDnggzddPYOxjzztEfwGsMlgXPSdiHilUn1v4ug4wBy2iEoUQFfmluE0K9a
 E2W9ZhrP5l2gP79Lp9gyN+pxy/tZ+VZlnH3sM5u81OAubq4iMv5sfPAQof221PApXhy0
 ki8RqCVsAdnIX2MvD0C6ABSt3pZ6HFQvuvoeLYPsO4mfoMcb24AB5+x2Jnxf900jkM0i
 PEhW2VzFIvD614Ji45vDvlumcs1w9BDLI7SGX66x3IwXj8fhRUH2rDWrj4O/SmGlR9ff
 ItG/wSVt3NSVacWZfDJXz3yC3/KhEOZGV94c66W36l8DSkasVfoIbcpjTF2eu4Nz8zvx
 TiPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=+bGP5zTQ9CEVKQuxiSM93QKGtD6GSUP/eq+pny3GVwY=;
 b=RJEIvrGWZyBm7LAb5IEwE4006RxHb+Hb8VW0AUop7WM1JedqUuLBOYEoUU4nbA5ySp
 ozknARyBGJK/BzXQ8kLf77+aVr+utq5efP/iLdY1FD0Vdsq4pY5Fn/59bza09finnodv
 H7DAlnXNF0hMLqYFYAPFTa8GH4isK69hURgM8NoeA1BE58JhwAg9fyWpwD0mXN0EJhMF
 gMkYEQ0Qu4fBy/heFCeU5QP/vbLPx0/hisRupDBAzwJrxNjn9KiIQeRDppMMyBeBTuTJ
 laj8K6mwFo+OevfUUf0ydSImsH0Pdd0L0lvm88rDztAdXqH/9WI7pBMJMmaL+eOrBpQB
 tBoQ==
X-Gm-Message-State: APjAAAVRZGgEiTi1pt7ZJGS+kZ460LkX8rKdLAtEYhzXyaxRbHxTdKGe
 yYK65vl+pwcK7rQKi3VSe0pyYR6qgSo=
X-Google-Smtp-Source: APXvYqx7GcoKu99PpwrT4VrqHMXK4jstJ7zYduE0QfuJBZetr5aTKXHTnvGKywZu5rZDD2NiWAqyQA==
X-Received: by 2002:a17:90a:cf11:: with SMTP id
 h17mr7982984pju.103.1582944230190; 
 Fri, 28 Feb 2020 18:43:50 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id k9sm3649321pjo.19.2020.02.28.18.43.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2020 18:43:49 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 0/8] tcg patch queue
Date: Fri, 28 Feb 2020 18:43:39 -0800
Message-Id: <20200229024347.22826-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
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

The following changes since commit e0175b71638cf4398903c0d25f93fe62e0606389:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20200228' into staging (2020-02-28 16:39:27 +0000)

are available in the Git repository at:

  https://github.com/rth7680/qemu.git tags/pull-tcg-20200228

for you to fetch changes up to 600e17b261555c56a048781b8dd5ba3985650013:

  accel/tcg: increase default code gen buffer size for 64 bit (2020-02-28 17:43:31 -0800)

----------------------------------------------------------------
Fix race in cpu_exec_step_atomic.
Work around compile failure with -fno-inine.
Expand tcg/arm epilogue inline.
Adjustments to the default code gen buffer size.

----------------------------------------------------------------
Alex Bennée (5):
      accel/tcg: fix race in cpu_exec_step_atomic (bug 1863025)
      accel/tcg: use units.h for defining code gen buffer sizes
      accel/tcg: remove link between guest ram and TCG cache size
      accel/tcg: only USE_STATIC_CODE_GEN_BUFFER on 32 bit hosts
      accel/tcg: increase default code gen buffer size for 64 bit

Richard Henderson (2):
      tcg/arm: Split out tcg_out_epilogue
      tcg/arm: Expand epilogue inline

Zenghui Yu (1):
      compiler.h: Don't use compile-time assert when __NO_INLINE__ is defined

 include/qemu/compiler.h   |  2 +-
 accel/tcg/cpu-exec.c      | 21 ++++++++--------
 accel/tcg/translate-all.c | 61 ++++++++++++++++++++++++++++-------------------
 tcg/arm/tcg-target.inc.c  | 29 ++++++++++------------
 4 files changed, 60 insertions(+), 53 deletions(-)

