Return-Path: <SRS0=0mkr=WZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31C89C3A59F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 16:50:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E00562189D
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 16:50:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BfyFKe/e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E00562189D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3Ncf-00082P-GB
	for qemu-devel@archiver.kernel.org; Thu, 29 Aug 2019 12:50:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46322)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vandersonmr2@gmail.com>) id 1i3Naq-0006BR-7r
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 12:48:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vandersonmr2@gmail.com>) id 1i3Nan-00066l-RQ
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 12:48:16 -0400
Received: from mail-qk1-x72a.google.com ([2607:f8b0:4864:20::72a]:33248)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <vandersonmr2@gmail.com>)
 id 1i3Nan-00065V-JR
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 12:48:13 -0400
Received: by mail-qk1-x72a.google.com with SMTP id w18so3589600qki.0
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2019 09:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=wkWlBGw6I03+6YIH0pF6jRVYnHVoMS4d7bWD201rqPI=;
 b=BfyFKe/eFuxziVrd12Q5ZCStN5ffF7TRBOSbzSdZ13dvKM5vrD5rg6h73i7OrhxWMA
 udTQMXM8LfRuYfPNpLpj3uFQrGa/8Op7kMsOOAxuMCKY6I6tI2VrvrOcpD+esY3zwMXX
 4ffUn7i6wBLhN2wZYsTrIheBhQWVUyhlh6h+V3573gUAeXC7GqzxO5DYFb3kagLfVjb1
 zyYxJyaP1QLzR3lS7CZMu0qKyEenSdY+QsGlXPF0cweSaM6jN9bSzSABv6nvmIwL7Bgu
 mdIqcqQuBDTWbCl+VM0jLclffWW+Tz0VqdNbub+mXXxWxN46XouIY3f7RPvJyA+p6tuA
 25Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=wkWlBGw6I03+6YIH0pF6jRVYnHVoMS4d7bWD201rqPI=;
 b=iOc/tI9GK91fKiFwrf/4pbUF9rgIWzNCLogEW2lmqX309X8jpTZkuOw+r1OvSEJ+kQ
 j7yDgjRLDRkgrGB8WahS0fCDPWV1964+mZvg8+wcNZfvH8tdm84snCDzhPfeAGaT+8Db
 FakOSzw/O3ZQLz3jGbJ32GG4L2P1iux7HKsTBB2sAn4S122VIqkGo0KsVnMXuo5ZKAXt
 f9YFuJ5g8q4XbK2Kqy3S48coGej6nU0XLu3VUGzaeLsjFcDVNE3x4kYhCHcgZiLxgq1j
 Bjhe2Kh8JC95g+RIz4KzNfnrbTT+N/CyBK+PEKNpPp1RjPzNlO1/9qXVZ95DIUDIQjqf
 kT8A==
X-Gm-Message-State: APjAAAX9Vuuf+VzHbfWdphrUwFKmEOL6Q2k8eAmVsT2kI+agumU1L0s5
 9JWDzq4cuy+elY569XCqccHT32DDAwE=
X-Google-Smtp-Source: APXvYqwc4AIky4PAmjmteEgCPtdlwa+G3WH6AhAtmm/WAbMP4l1O1hl3Yrn+8U+PjrcWnj2x36ddNg==
X-Received: by 2002:ae9:e313:: with SMTP id v19mr10558015qkf.22.1567097292058; 
 Thu, 29 Aug 2019 09:48:12 -0700 (PDT)
Received: from vanderson-lmcad.gw.lmcad.ic.unicamp.br (gw.lmcad.ic.unicamp.br.
 [143.106.73.166])
 by smtp.googlemail.com with ESMTPSA id g25sm1441024qkk.87.2019.08.29.09.48.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Aug 2019 09:48:11 -0700 (PDT)
From: vandersonmr <vandersonmr2@gmail.com>
To: qemu-devel@nongnu.org
Date: Thu, 29 Aug 2019 13:47:44 -0300
Message-Id: <20190829164754.3906-1-vandersonmr2@gmail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::72a
Subject: [Qemu-devel] [PATCH v7 00/10] Measure Tiny Code Generation Quality
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

vandersonmr (10):
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

 accel/tcg/cpu-exec.c          |   4 +
 accel/tcg/tb-stats.c          | 831 ++++++++++++++++++++++++++++++++++
 accel/tcg/tcg-runtime.c       |   7 +
 accel/tcg/tcg-runtime.h       |   2 +
 accel/tcg/translate-all.c     |  77 ++--
 accel/tcg/translator.c        |   5 +
 configure                     |   3 -
 cpus.c                        |  14 +-
 disas.c                       |  31 +-
 hmp-commands-info.hx          |  31 ++
 hmp-commands.hx               |  17 +
 include/exec/gen-icount.h     |  10 +
 include/exec/tb-stats-flags.h |  43 ++
 include/exec/tb-stats.h       | 109 ++++-
 include/qemu/log-for-trace.h  |   4 +
 include/qemu/log.h            |   3 +
 include/qemu/timer.h          |   5 +-
 linux-user/exit.c             |   4 +
 monitor/misc.c                | 171 ++++++-
 tcg/tcg.c                     | 230 +++-------
 tcg/tcg.h                     |  22 +-
 util/log.c                    |  88 +++-
 vl.c                          |   8 +-
 23 files changed, 1443 insertions(+), 276 deletions(-)
 create mode 100644 include/exec/tb-stats-flags.h

-- 
2.22.0


