Return-Path: <SRS0=0mkr=WZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0D9AC3A59F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 17:36:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F3EB2189D
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 17:36:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rP0Zw1Xo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F3EB2189D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3OLj-0006AZ-Al
	for qemu-devel@archiver.kernel.org; Thu, 29 Aug 2019 13:36:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60280)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vandersonmr2@gmail.com>) id 1i3OK5-0004ee-Hr
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 13:35:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vandersonmr2@gmail.com>) id 1i3OK4-0008VX-3f
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 13:35:01 -0400
Received: from mail-qk1-x732.google.com ([2607:f8b0:4864:20::732]:36679)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <vandersonmr2@gmail.com>)
 id 1i3OK3-0008VI-TL
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 13:35:00 -0400
Received: by mail-qk1-x732.google.com with SMTP id d23so3710697qko.3
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2019 10:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=/1+UMmh3lslt6RXSVte35tSusyCF0XvNozZjI1Z2dfI=;
 b=rP0Zw1XoPrlVHh4+okuAFKfwtw+2PrYnDt3kgbwVljuMDXeYqap6NipkcnXYlAxkEL
 WKbYTqxiY5mUOf9IR+Oz5rIDJgVr8mOPpDshBNNavVwpBlxb2gIIYRMXUu2qr2gZhVmP
 Y7n/rI8otaAYpBRCMRZVSHRQvf7Igauz4lLjxyj0BCsaF436BQenGySUKXg4WpK77ktw
 Hs9/4gK9EKjQUJ2+bZFOoBhfHSE4+JnEuctk/ouIB+3Mi+4Suw+U2H/6r+CZjBmYnSIS
 Nnz57zGiDmQbIs+5bY2MxezE9c49NEGJqwqIImx4afSkyR0IxGPLzHrJxSlnR6pc30+H
 1FDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=/1+UMmh3lslt6RXSVte35tSusyCF0XvNozZjI1Z2dfI=;
 b=CCMNdpTa8ebMXXmMaWG2jQ6KP6m0iiSXJfnY2nGRJ3BajM7ql3PjkZ+8u4kl+komz7
 avmAkfWvxTeH7Vbbp5NDEfr22NNx1fG4DhlUdP8/ispYDGovzZQrIeGASGpK6Y/F6daF
 bxNzQmyAb/e+cN/wzY6+e2tn3XYSTyUamzTjqYrXMCz90YXj+YaZEFAZVUmQHjRgLtwu
 tTw8ilFtbW8Uq+9wBiDfKaZTfJxGSOvEUVyyWk9xlaxroIlG9qCyE3wZqDEe7n4xHzut
 EHb5lNdlHOklp5BDVgFVwdLnZx2H9WEGsu2eKwTTJm77kfXvRqAt/t/TtCGGLYbfv4CR
 6CNA==
X-Gm-Message-State: APjAAAXJXxY8LZKzuyQI71lyA29iJ+SB7QTQJNqxRe+SqjxVFVALc4gl
 nUhs1lNNKK82OhV8jR9qu/cp1xYi0V85SQ==
X-Google-Smtp-Source: APXvYqzLyEHM+T56itLtaQiUhhGq0jsgKMT/fKzf/16AhQAsekItla6sOQIE+hdrS1koYrJyUTrhsg==
X-Received: by 2002:a37:494:: with SMTP id 142mr10356436qke.239.1567100098895; 
 Thu, 29 Aug 2019 10:34:58 -0700 (PDT)
Received: from vanderson-lmcad.gw.lmcad.ic.unicamp.br (gw.lmcad.ic.unicamp.br.
 [143.106.73.166])
 by smtp.googlemail.com with ESMTPSA id j50sm1721700qtj.30.2019.08.29.10.34.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Aug 2019 10:34:58 -0700 (PDT)
From: vandersonmr <vandersonmr2@gmail.com>
To: qemu-devel@nongnu.org
Date: Thu, 29 Aug 2019 14:34:26 -0300
Message-Id: <20190829173437.5926-1-vandersonmr2@gmail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::732
Subject: [Qemu-devel] [PATCH v8 00/11] Measure Tiny Code Generation Quality
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
Cc: vandersonmr <vandersonmr2@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch is part of Google Summer of Code (GSoC) 2019.
More about the project can be found in:
https://wiki.qemu.org/Internships/ProjectIdeas/TCGCodeQuality

The goal of this patch is to add infrastructure to collect
execution and JIT statistics during the emulation with accel/TCG.
The statistics are stored in TBStatistic structures (TBStats)
with each TB having its respective TBStats.

We added -d tb_stats and HMP tb_stats commands to allow the control
of this statistics collection. And info tb, tbs, and coverset commands
were also added to allow dumping and exploring all this information
while emulating.

Collecting these statistics and information is useful to understand
qemu performance and to help to add the support for traces to QEMU.

v8:
 - fixing missing commit from v7
v7:
 - rebase
 - adding license to new files
 - applying comments from v6
v6:
 - applying comments from V5.
 - change info tbs to info tb-list
 - fix crash when dumping tb's targets
 - fix "liveness/code time" calculation
v5:
 - full replacement of CONFIG_PROFILER
 - several fixes
 - adds "info cfg"
 - adds TB's targets to dump

vandersonmr (11):
  accel: introducing TBStatistics structure
  accel: collecting TB execution count
  accel: collecting JIT statistics
  accel: replacing part of CONFIG_PROFILER with TBStats
  accel: adding TB_JIT_TIME and full replacing CONFIG_PROFILER
  Adding -d tb_stats to control TBStatistics collection:
  monitor: adding tb_stats hmp command
  Adding tb_stats [start|pause|stop|filter] command to hmp.
  Adding info [tb-list|tb|coverset] commands to HMP.
  monitor: adding new info cfg command
  linux-user: dumping hot TBs at the end of the execution

 accel/tcg/Makefile.objs       |   2 +-
 accel/tcg/cpu-exec.c          |   4 +
 accel/tcg/tb-stats.c          | 894 ++++++++++++++++++++++++++++++++++
 accel/tcg/tcg-runtime.c       |   7 +
 accel/tcg/tcg-runtime.h       |   2 +
 accel/tcg/translate-all.c     | 132 +++--
 accel/tcg/translator.c        |   5 +
 configure                     |   3 -
 cpus.c                        |  14 +-
 disas.c                       |  31 +-
 hmp-commands-info.hx          |  31 ++
 hmp-commands.hx               |  17 +
 include/exec/exec-all.h       |  15 +-
 include/exec/gen-icount.h     |  10 +
 include/exec/tb-context.h     |  12 +
 include/exec/tb-hash.h        |   7 +
 include/exec/tb-stats-flags.h |  43 ++
 include/exec/tb-stats.h       | 170 +++++++
 include/qemu/log-for-trace.h  |   4 +
 include/qemu/log.h            |   3 +
 include/qemu/timer.h          |   5 +-
 linux-user/exit.c             |   4 +
 monitor/misc.c                | 171 ++++++-
 tcg/tcg.c                     | 230 +++------
 tcg/tcg.h                     |  22 +-
 util/log.c                    |  90 +++-
 vl.c                          |   8 +-
 27 files changed, 1652 insertions(+), 284 deletions(-)
 create mode 100644 accel/tcg/tb-stats.c
 create mode 100644 include/exec/tb-stats-flags.h
 create mode 100644 include/exec/tb-stats.h

-- 
2.22.0


