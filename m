Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43014C352A4
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 03:23:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11FA420873
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 03:23:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Bhb+BJhL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11FA420873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j255z-0003jj-6q
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 22:23:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60127)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j255B-0002BN-4J
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 22:22:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j2559-0008VH-QN
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 22:22:28 -0500
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:33441)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j2559-0008R0-JR
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 22:22:27 -0500
Received: by mail-pl1-x642.google.com with SMTP id ay11so1763332plb.0
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2020 19:22:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=jR773XWNEuiDz4JRTeFFlE4dtWRUsueyRY/ZMloKFL4=;
 b=Bhb+BJhL6G99JLDs9Rtl2qz6C29lwthfJ0GHoCKke6ArxQKp+n0jSBUgFL8z6TBecU
 RIo1H+qbyP25DNjT/I9lbyF8hLWtvvt/GokKP9bsMSuGJ9y6oPJ9Aii1HMf+E0ttn1lz
 M/SeiUr5TIJ2szTIzCv29SzSX4apl9NudyOaqeOY+zzNBTC1qX8mDxzoKcI1gYHdSJbr
 Vli9rTBJebJlTGeNCAo5nlioGkdKi7+UTc39bbCKRAVA4PWyWzJiWFd43cTUrIiUI5zo
 nhTJMYoXzIUEGnD4nB+03tteyXYRHAYI9IULCEhklGw7CC9k9ncEJqBdiSVfLE/H3OuC
 JquQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=jR773XWNEuiDz4JRTeFFlE4dtWRUsueyRY/ZMloKFL4=;
 b=l/fA+foJE3GptE4YLq5j+k7aPS5I08Hl+pcR77eZ4n/muqfkRLlgTC+a/nXZYUsG3W
 vhP0KlJP1PWjevtJEKnMKPOiAWJTUNa8c5Ds7M3SpHtoUfyDi+jzPxf99sOjK19+MJEw
 TMBEcg/ofgHdGVumh0vacUDdkRHCFE16ybniucr8lTo0TRQIkp9FbtdHLNWnMEHdPJZw
 vtG2VHuzkOH+LXiceVat7Yc0434Qhx+JpdolIwMEcGbm1V8Mp5xTig09GXN2UbIbdlX7
 BubQ8p4zA6LxSDDxdKuI49KxwdFT0R6MU0f9MPhDw9pJq2fs5BfMJynOFI5TZnq3deH9
 AKCw==
X-Gm-Message-State: APjAAAUY+4WvOeG9D7AwoNnmvbm35oQgNPajVYbGwe7a5jhGhCNTCp0Q
 ErZKaAZDeXvzKer4cyoPvSPuKfLlWKs=
X-Google-Smtp-Source: APXvYqyT4ZjgP1YJ0GKJhiCoMXJL6ppN0L70uaeP2Sd0Zc0RVJm3dyRSJGRD7yzB6+OGJ2JmkGH4Hg==
X-Received: by 2002:a17:90a:bd97:: with SMTP id
 z23mr2663322pjr.19.1581564145649; 
 Wed, 12 Feb 2020 19:22:25 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id l15sm536067pgi.31.2020.02.12.19.22.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Feb 2020 19:22:24 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 0/5] linux-user: Implement x86_64 vsyscalls
Date: Wed, 12 Feb 2020 19:22:18 -0800
Message-Id: <20200213032223.14643-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
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
Cc: laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Changes for v3:

  * Add TARGET_VSYSCALL_PAGE define.
  * Move the sigsegv goto around.

v2: https://lists.gnu.org/archive/html/qemu-devel/2020-01/msg03474.html
v1: https://lists.gnu.org/archive/html/qemu-devel/2020-01/msg02841.html


r~


Richard Henderson (5):
  target/i386: Renumber EXCP_SYSCALL
  linux-user/i386: Split out gen_signal
  linux-user/i386: Emulate x86_64 vsyscalls
  linux-user: Add x86_64 vsyscall page to /proc/self/maps
  linux-user: Flush out implementation of gettimeofday

 target/i386/cpu.h          |  12 ++-
 linux-user/i386/cpu_loop.c | 201 ++++++++++++++++++++++++++-----------
 linux-user/syscall.c       |  37 ++++++-
 target/i386/translate.c    |  14 ++-
 4 files changed, 198 insertions(+), 66 deletions(-)

-- 
2.20.1


