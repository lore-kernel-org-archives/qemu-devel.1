Return-Path: <SRS0=TwS2=YA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9A45C47404
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 15:34:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7484A206C2
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 15:34:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QRQ4q30z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7484A206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHV1Y-00061Y-AC
	for qemu-devel@archiver.kernel.org; Mon, 07 Oct 2019 11:34:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48824)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iHUwG-0002Ue-49
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 11:28:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iHUwE-00054u-Ar
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 11:28:43 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:41599)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iHUwD-00053t-Vt
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 11:28:42 -0400
Received: by mail-wr1-x430.google.com with SMTP id q9so15848813wrm.8
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2019 08:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=BZ7CrskQXtG1eqsH9u30B5DDTJTq9ZrtUzGvfXip6b8=;
 b=QRQ4q30z1jIPEx9aD3KiwC12FROaCM1sno9DJ7ZR+tVm9m8a2WG8RdyM40yw3M/Uja
 ERfhP/uS+BuEEublELJHNwv55wIUaAfXJ2dwXAdPHWtLLhCuyik4zSSEwNtx9XTT1y8P
 6QJgNDeqHfVjsBOBXWe+4jHZ2gt1Jof7GDSpZoxGn101PC6lSsVMZgoCoV0YyzM/b8hd
 ATR5PfJ7qP3IJ0eHj6ViWy96cIZoGvEI7hOdTEjA1WjVNfD/sl5cf2LenQ7Lbpxql9nb
 2hc6S3+k/+uf8SwB08zZqBO4lLREhz+Bcf6KUvMogCVGdSBIvm2NWkUDot/lFm/YacfN
 jphQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=BZ7CrskQXtG1eqsH9u30B5DDTJTq9ZrtUzGvfXip6b8=;
 b=RnrvHbEQZ3bfe8mZIfhe1mbxXcW2S/7tCDm5PRNOOJhHDY/1nT7nKTRKChZFKAelIL
 OtwsdldUypTlLGAqQDkTbbdnbIlKIeyCn7oTuAyfyEKS7YhriyCrfnStr9uqW59enagJ
 aDvyYx8OLr+UMB0JkMMm1FwHlH4RmM3w34XCZ+xFCfPvwtzwrifTfdjXEQ3OnznN52a9
 SlTN4A8KNARJ86AbVNm5uN5C+KeCn3v1Sx7eBnJKKgNQsGt5lZH2iMqWg+8jz7a94svc
 KRdVQiEZ4QuWgC1slxNeavaMoP7AshLaAoBCrkiXd/E18jhcYALslTHMqQFOq/1jXOyQ
 MXuA==
X-Gm-Message-State: APjAAAWe/cTGc8PxLuqU7K589SayEnaXRclzLxg/19dtJ80RI1Q/3h7Q
 ZxTgtCVAftMDnp5u+iZNFmm/oA==
X-Google-Smtp-Source: APXvYqz5qNmP+Y4wFO0JKELIbEUa9elgTR0hwQacU5aHNI/aPcKqTt6MwwXr8pxmTFYQWIpOO/FIZw==
X-Received: by 2002:a5d:604e:: with SMTP id j14mr6018465wrt.119.1570462120604; 
 Mon, 07 Oct 2019 08:28:40 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id j1sm33174278wrg.24.2019.10.07.08.28.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Oct 2019 08:28:39 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 248F71FF87;
 Mon,  7 Oct 2019 16:28:39 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v9 00/13] TCG code quality tracking and perf integration
Date: Mon,  7 Oct 2019 16:28:26 +0100
Message-Id: <20191007152839.30804-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::430
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
Cc: cota@braap.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

These are the bits of Vanderson's GSoC project which I think are ready
for merge(^) and would like get up-streamed before the code freeze
kicks in. It effectively removes the CONFIG_PROFILER support in favour
of a more dynamic and configurable TB Statistics subsystem. While not
in use it has no impact on the system apart a small amount of wasted
space in the TCGContext for each thread which is used to collect stats
during translation. When in use a TBStats structure is created for
each set of TBs that have the same address/flags combination. The most
basic tracking involves counting executions of each TB. You can also
enable JIT stats and sort by features such as spill count and
host/guest expansion ration.

For full performance analysis you can use -perf to output a JIT dump
that is compatible with the linux perf tool. This allows you to see
exactly which TBs are responsible for the majority of real execution
time. With the additional TB stats involved it will also include basic
information about the quality of that code.

The main changes from Vanderson's last post apart from general
clean-ups and g_autoptr'ing is I've dropped the "cfg" and "coverset"
commands. I dropped "cfg" because I wasn't happy about it navigated
the next TB in the chain. "coverset" tends to dump quite a lot of TBs
on a full system emulation so I wanted to think about a slightly
smoother UI experience.

^ and finally I think I'll also drop the "tb" command for the next
iteration because although useful it fails when the guest has
un-mapped pages and results in a exception getting delivered to the
guest which is less than ideal. See the comments for get_code_string.
However I've left it in this iteration so you can see a taste of the
future.

There are more notes on the project at the wiki page:

  https://wiki.qemu.org/Features/TCGCodeQuality

Please review.

Alex Bennée (2):
  tb-stats: reset the tracked TBs on a tb_flush
  configure: remove the final bits of --profiler support

Vanderson M. do Rosario (11):
  accel/tcg: introduce TBStatistics structure
  accel: collecting TB execution count
  accel: collecting JIT statistics
  accel: replacing part of CONFIG_PROFILER with TBStats
  accel: adding TB_JIT_TIME and full replacing CONFIG_PROFILER
  debug: add -d tb_stats to control TBStatistics collection:
  monitor: adding tb_stats hmp command
  Adding info [tb-list|tb] commands to HMP (WIP)
  tb-stats: dump hot TBs at the end of the execution
  accel/tcg: adding integration with linux perf
  tb-stats: adding TBStatistics info into perf dump

 accel/tcg/Makefile.objs       |   4 +-
 accel/tcg/cpu-exec.c          |   4 +
 accel/tcg/perf/Makefile.objs  |   1 +
 accel/tcg/perf/jitdump.c      | 206 +++++++++++
 accel/tcg/perf/jitdump.h      |  36 ++
 accel/tcg/tb-stats.c          | 662 ++++++++++++++++++++++++++++++++++
 accel/tcg/tcg-runtime.c       |   7 +
 accel/tcg/tcg-runtime.h       |   2 +
 accel/tcg/translate-all.c     | 173 +++++++--
 accel/tcg/translator.c        |   4 +
 configure                     |   8 -
 cpus.c                        |  14 +-
 disas.c                       |  31 +-
 docs/devel/tcg.rst            |  15 +
 hmp-commands-info.hx          |  16 +
 hmp-commands.hx               |  17 +
 include/exec/exec-all.h       |  15 +-
 include/exec/gen-icount.h     |  10 +
 include/exec/tb-context.h     |  12 +
 include/exec/tb-hash.h        |   7 +
 include/exec/tb-stats-dump.h  |  21 ++
 include/exec/tb-stats-flags.h |  31 ++
 include/exec/tb-stats.h       | 165 +++++++++
 include/qemu-common.h         |   3 +
 include/qemu/log-for-trace.h  |   4 +
 include/qemu/log.h            |   3 +
 include/qemu/timer.h          |   5 +-
 linux-user/exit.c             |   2 +
 linux-user/main.c             |   7 +
 monitor/misc.c                | 127 +++++--
 os-posix.c                    |   5 +
 qemu-options.hx               |  11 +
 stubs/Makefile.objs           |   1 +
 stubs/tb-stats.c              |  32 ++
 tcg/tcg.c                     | 221 +++---------
 tcg/tcg.h                     |  34 +-
 util/log.c                    |  89 ++++-
 vl.c                          |  10 +-
 38 files changed, 1727 insertions(+), 288 deletions(-)
 create mode 100644 accel/tcg/perf/Makefile.objs
 create mode 100644 accel/tcg/perf/jitdump.c
 create mode 100644 accel/tcg/perf/jitdump.h
 create mode 100644 accel/tcg/tb-stats.c
 create mode 100644 include/exec/tb-stats-dump.h
 create mode 100644 include/exec/tb-stats-flags.h
 create mode 100644 include/exec/tb-stats.h
 create mode 100644 stubs/tb-stats.c

-- 
2.20.1


