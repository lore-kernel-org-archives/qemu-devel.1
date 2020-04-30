Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FDFDC47247
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 19:03:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 228832073E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 19:03:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qXZL+GjM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 228832073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUESf-0007y4-3N
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 15:03:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43288)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jUERA-0006CD-MI
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 15:01:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jUER8-000382-42
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 15:01:32 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:41449)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jUER7-00037Q-Je
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 15:01:29 -0400
Received: by mail-wr1-x443.google.com with SMTP id g13so8403374wrb.8
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 12:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=uiH2PQhIhTnBYX3ciLkOdb5ad8e/gr1fJnqziw/sEeQ=;
 b=qXZL+GjM9Ia4oX3cosakYAN+qPzFj58/AMfWnV47y4luzvbskL1QYmL3UHl+tDVKXM
 j925ofaIjK9q1cqGPfxZ1Iao1TglBt4aWLLwef8T3wAYZvXquRRz4CT2Ioc0HSKu6dBl
 S7WaSuuxjlgksJzMUlzGK8CI4b7SSdj/JibR4orCcFvEEZlnRd043u/XonnpYEkjl0k8
 +MmZBm3ZM4xvRSYLrMoCt4Uue5KMgYf56OkVJ7huG7aKwGy7Abjfthtd0Hqh4A7CvWF8
 M+r85aJG3oCjn8x4Wsf3HLfZ9HWw5WTdD8u/ffLpdc2uHIYtO0edZJ6VwtyIwrPd+czS
 Diuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=uiH2PQhIhTnBYX3ciLkOdb5ad8e/gr1fJnqziw/sEeQ=;
 b=FUxy38fCCHC3PULtbvEZ31G1QL0HI2hXnZkdZzmXNVfGc+luAu/4kYK/liokRsGw9D
 w7wN3E1viozPZscWcqh1AgpKVnxUty0UmMLiefmGfxfm0iIO+/JTj+8tItHfCJ260FdE
 jqr+erslswFcgHi41RT4DrNHYO29V6rdrAvjmPBhqN1sKPu5em4crDGfNTGMKwC5+l7C
 TojoR9bt77XmYiEbLOliGna7cAC1YiwZtbzaIFcxTrf18OGZeNoEzbeNSIRh0RphV3V9
 0L4LFdqG4DGzUVPPRIsHjwHY/HMJAYXNT7kHUJX3iaaFwW81wy87XaLuGeb1T3hcy7O3
 4/ig==
X-Gm-Message-State: AGi0PuY8IMIGg4RmgckZX5cdbZ4Xb7nuUYoEaE870A6UuixCcu3jGpjA
 2QcPvARVkyD42dHOp4yDXn/PB7BjDQc=
X-Google-Smtp-Source: APiQypIVEDYsSdkQ+KwLyPU+beDa+xJvuHvzkZ2MErHCndaVi5l5BtQgntj5lp3k4dvSTjbGLoefBA==
X-Received: by 2002:a05:6000:1001:: with SMTP id
 a1mr5763137wrx.9.1588273287892; 
 Thu, 30 Apr 2020 12:01:27 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id k9sm984229wrd.17.2020.04.30.12.01.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2020 12:01:23 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 9A2781FF7E;
 Thu, 30 Apr 2020 20:01:22 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 0/9] gdbstub/next
Date: Thu, 30 Apr 2020 20:01:13 +0100
Message-Id: <20200430190122.4592-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

As another release is cut from the tree we start again the collection
of patches fixes and enhancements that weren't yet ready to be
released on an unsuspecting world.

Some of these patches have been seen before in my random collection
series but these are all gdbstub related, This includes more testing,
a new unix socket mode for linux-user to support the testing and a few
other bits and pieces.

The following patches need review:

 - tests/tcg: add a multiarch linux-user gdb test
 - tests/guest-debug: use the unix socket for linux-user tests
 - gdbstub/linux-user: support debugging over a unix socket
 - gdbstub: eliminate gdbserver_fd global
 - tests/tcg: drop inferior.was_attached() test
 - tests/tcg: better trap gdb failures
 - configure: favour gdb-multiarch if we have it

Alex Bennée (7):
  configure: favour gdb-multiarch if we have it
  tests/tcg: better trap gdb failures
  tests/tcg: drop inferior.was_attached() test
  gdbstub: eliminate gdbserver_fd global
  gdbstub/linux-user: support debugging over a unix socket
  tests/guest-debug: use the unix socket for linux-user tests
  tests/tcg: add a multiarch linux-user gdb test

KONRAD Frederic (1):
  target/m68k: fix gdb for m68xxx

Philippe Mathieu-Daudé (1):
  gdbstub: Introduce gdb_get_float64() to get 64-bit float registers

 configure                                   |   4 +-
 include/exec/gdbstub.h                      |  25 +++-
 bsd-user/main.c                             |   8 +-
 gdbstub.c                                   | 119 ++++++++++++++++----
 linux-user/main.c                           |  12 +-
 target/m68k/cpu.c                           |  52 ++++++---
 target/m68k/helper.c                        |   3 +-
 target/ppc/gdbstub.c                        |   4 +-
 target/ppc/translate_init.inc.c             |   2 +-
 gdb-xml/m68k-core.xml                       |  29 +++++
 tests/guest-debug/run-test.py               |  30 ++++-
 tests/tcg/aarch64/Makefile.target           |   5 +-
 tests/tcg/aarch64/gdbstub/test-sve-ioctl.py |   4 -
 tests/tcg/aarch64/gdbstub/test-sve.py       |   4 -
 tests/tcg/cris/Makefile.target              |   1 +
 tests/tcg/multiarch/Makefile.target         |  14 +++
 tests/tcg/multiarch/gdbstub/sha1.py         |  81 +++++++++++++
 17 files changed, 323 insertions(+), 74 deletions(-)
 create mode 100644 gdb-xml/m68k-core.xml
 create mode 100644 tests/tcg/multiarch/gdbstub/sha1.py

-- 
2.20.1


