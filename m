Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91199C432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 13:12:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 584CF2073A
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 13:12:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R8GkTNlO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 584CF2073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVbP4-0005aQ-63
	for qemu-devel@archiver.kernel.org; Fri, 15 Nov 2019 08:12:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49393)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1iVbNv-0004No-GW
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 08:11:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1iVbNu-0004No-BA
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 08:11:35 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:36637)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1iVbNu-0004NP-21
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 08:11:34 -0500
Received: by mail-pg1-x542.google.com with SMTP id k13so6014750pgh.3
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2019 05:11:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=wI02htXvbaCF/QBVlfvNuM25qEJJGrUPkf5so08TzqY=;
 b=R8GkTNlObqdMjoNPQEN0c994wbzQhcbz+h9v0vxQFyZa7KXXvxM0WW4nj1P2ymZZeZ
 aw4tcHcWA8YRGkvZbIt6HIyjOc3wYDWFganONoOv+qjkATdyqxWNAiW9zNYHXfBDNUiQ
 6rvlhDflZrX5XbOaWI3oTo7BdKskAqpvb8uf6t1Bylwa44/5ZBn+MDhywAi0lS8//PBY
 9aAAVDht9vdXMihmnDvQ9STRvjFXvSXtF0Ys2FoMX7AHaet5UxGcrAsyZ3UykAtZPyVr
 PrZKtMJreGf9FegxzEmYz8xoooUi3dTMsGZfWY+qiIizjYTr7x19WWnK4rr4AylMBTxr
 fIRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=wI02htXvbaCF/QBVlfvNuM25qEJJGrUPkf5so08TzqY=;
 b=L4VBeeJr+zZ5bZn5BAdQU6iF8yFJqWcIXbSYPA6YRRgm2qnzvaLm4kExqN0Y1ng+FU
 afjER6+XkBE+3ZXaXkGgED2cSEbhigMe09geG1W72cKjrhs0QFrTerWEaRxN190TPzL1
 NcoIJrDrfMkzrDvBTb42dUr5OT5ydlYNFNViO6ZpzgGzqRfUbPOUmmVYGcHkQlESk9Fo
 Y12lFLMB+PviVSAbNkHXi/VxVgF+S0y0n+3YEbdRkjkBUAXoB/3/g949K8fIgoXV+hhK
 7RT0wlYd1LItIVbv4VgAtejNFKRcoNuHnMUyB5C8ySDs6ROc/b1raiNmClxXPljymPI8
 MkRw==
X-Gm-Message-State: APjAAAXHQuqXmChfYLqpWLSdkltvjCgWgrK8P/FHBdI4xfyIZC8/SDcl
 uHgLqprV56Kr1IkVY/k777O9drlDDl8=
X-Google-Smtp-Source: APXvYqwQ4gG6P8C7CQrmAfABWsRv7szyZdgk/YiEVTT62M+BL53WnfLEBIB1jBSMYMQuxRkOVj8vrw==
X-Received: by 2002:a62:1bd0:: with SMTP id b199mr17611326pfb.44.1573823492158; 
 Fri, 15 Nov 2019 05:11:32 -0800 (PST)
Received: from Rfoley-MA01.usrd.futurewei.com ([12.111.81.71])
 by smtp.gmail.com with ESMTPSA id w138sm12007249pfc.68.2019.11.15.05.11.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Nov 2019 05:11:31 -0800 (PST)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/6] Make the qemu_logfile handle thread safe.
Date: Fri, 15 Nov 2019 08:10:34 -0500
Message-Id: <20191115131040.2834-1-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
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
Cc: peter.puhov@linaro.org, alex.bennee@linaro.org, robert.foley@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch adds thread safety to the qemu_logfile handle.  This now
allows changing the logfile while logging is active, and also solves 
the issue of a seg fault while changing the logfile.

This patch adds use of RCU for handling the swap out of the 
old qemu_logfile file descriptor.

Also added a few tests for logfile including changing the logfile
and closing the logfile.

One change also added for a pre-existing double free issue in 
qemu_set_log_filename() uncovered with the new test.

We also cleaned up the flow of code in qemu_set_log().

---
v2
    - This version of the patch adds some cleanup of code in
      qemu_set_log().
    - Also changed the order of patches to move our fix for the
      double free issue in qemu_set_log_filename() up to the beginning
      of the patch.
---
v1
    - This version of the patch incorporates changes 
      from the first round of review.  
    - It also includes a fix for an issue in
      qemu_set_log_filename().  This issue was uncovered 
      by the test added for this patch.
---
Robert Foley (6):
  Fix double free issue in qemu_set_log_filename().
  Cleaned up flow of code in qemu_set_log(), to simplify and clarify.
  Add a mutex to guarantee single writer to qemu_logfile handle.
  qemu_log_lock/unlock now preserves the qemu_logfile handle.
  Add use of RCU for qemu_logfile.
  Added tests for close and change of logfile.

 accel/tcg/cpu-exec.c          |   4 +-
 accel/tcg/translate-all.c     |   4 +-
 accel/tcg/translator.c        |   4 +-
 exec.c                        |   4 +-
 hw/net/can/can_sja1000.c      |   4 +-
 include/exec/log.h            |  33 +++++++++--
 include/qemu/log.h            |  49 +++++++++++++---
 net/can/can_socketcan.c       |   5 +-
 target/cris/translate.c       |   4 +-
 target/i386/translate.c       |   5 +-
 target/lm32/translate.c       |   4 +-
 target/microblaze/translate.c |   4 +-
 target/nios2/translate.c      |   4 +-
 target/tilegx/translate.c     |   7 ++-
 target/unicore32/translate.c  |   4 +-
 tcg/tcg.c                     |  28 ++++++----
 tests/test-logging.c          |  80 ++++++++++++++++++++++++++
 util/log.c                    | 102 ++++++++++++++++++++++++++--------
 18 files changed, 275 insertions(+), 74 deletions(-)

-- 
2.17.1


