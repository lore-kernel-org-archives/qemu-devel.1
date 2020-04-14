Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0183DC2BA19
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 16:27:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD3352076B
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 16:27:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j75IshkE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD3352076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOOPQ-0006v1-PD
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 12:27:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51625)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jOOOF-00054k-P6
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 12:26:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jOOO9-00078p-T2
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 12:26:23 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:37985)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jOOO9-00078T-F6
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 12:26:17 -0400
Received: by mail-wm1-x336.google.com with SMTP id g12so6878908wmh.3
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2020 09:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=R7JGiudy1UdoZaTW4BQ3pL5AFqpsAym0Lwz8mT/Tr/4=;
 b=j75IshkECkR+lwcigJNChqrnfIlFDtmC8OpuWkRAGES1SUZecepWk2lLn2L9FnJ/KB
 jsyfL4HtG4KcWRm1NvcQltoj4lJsXsqs4M5PKjyjWeK4d/+arfbyTTNtlQMMPt9Phnn+
 1JQxu75BEYR4o6aPJ3+1i7vuLJNtiJ35+2HH4QeoB4VlCuA8A23ih3Ngu9CeHEif0FT/
 TAsznYd/Hx+g7O1O+i+Cqgw/PPCA2LKNq9Cdm4ojJ5jdiBUs4mKvLsHBy+5FsLef0RqM
 CcA03SFTqUJj/RY0yAOJfVZLJ56dqXz/vh7/JK7wIM3v/PaCfoGL9jwsO5g8TcKckSll
 ujWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=R7JGiudy1UdoZaTW4BQ3pL5AFqpsAym0Lwz8mT/Tr/4=;
 b=dDI36RO0TLq2qckiSfFuQPiQcwNLurFrwj62EhnS5PgBDf2PAaMOrB8jO7FTpSqTLU
 yOmpbWd+8BuHrWlcsETRJG2JZWGBwtj89keanBymnnuycew47Em6XYuu5kEFS6zctsBN
 psQUmCjTLgHnhNuiIjQChjjFzQQ9w/4PJyxsMf6YN3uZ3FJAoYh3B4u2tgaMI7fXjfa8
 4Dvskk60sKFy/3OIgAljTSo7llUdZbE4mcqcV5zgtM9VRgtFPUuYEuNQbJKVDuus2bck
 rb7G9OiGA7eTVmAC3iSUaeQ94+ZuIoX265h+Aa+KtjjZCoS80F9pVruBaYKWq2BinI5S
 76Jw==
X-Gm-Message-State: AGi0PuZEY0lUycfChFvE9V30AgN+vfG6YefOeNnyNw7ACQfJAWsFWRuc
 pDV4W1o/GNAJiYMTjQIRRSfYJFm5OP73Jw==
X-Google-Smtp-Source: APiQypKH5YLMd+DqzohF9gXVr1jbMopfL0BnyDMR3m+rR6ds8V9tZA2BUWXYmUf71UlXJFcp99zhVQ==
X-Received: by 2002:a1c:3b09:: with SMTP id i9mr617513wma.19.1586881575931;
 Tue, 14 Apr 2020 09:26:15 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id i129sm20003802wmi.20.2020.04.14.09.26.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2020 09:26:15 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/12] target-arm queue
Date: Tue, 14 Apr 2020 17:26:01 +0100
Message-Id: <20200414162613.4479-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::336
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Almost nothing in here is arm-related, but the target-arm
queue was convenient for these last minute bits and pieces
for 5.0...

thanks
-- PMM

The following changes since commit 14e5526b51910efd62cd31cd95b49baca975c83f:

  Merge remote-tracking branch 'remotes/mst/tags/for_upstream' into staging (2020-04-13 15:42:51 +0100)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20200414

for you to fetch changes up to 84f82ddcbb4ac4ed04c8675e85155329f23184f0:

  Deprecate KVM support for AArch32 (2020-04-14 17:20:22 +0100)

----------------------------------------------------------------
patch queue:
 * Fix some problems that trip up Coverity's scanner
 * run-coverity-scan: New script automating the scan-and-upload process
 * docs: Improve our gdbstub documentation
 * configure: Honour --disable-werror for Sphinx
 * docs: Fix errors produced when building with Sphinx 3.0
 * docs: Require Sphinx 1.6 or better
 * Add deprecation notice for KVM support on AArch32 hosts

----------------------------------------------------------------
Peter Maydell (12):
      osdep.h: Drop no-longer-needed Coverity workarounds
      thread.h: Fix Coverity version of qemu_cond_timedwait()
      thread.h: Remove trailing semicolons from Coverity qemu_mutex_lock() etc
      linux-user/flatload.c: Use "" for include of QEMU header target_flat.h
      scripts/run-coverity-scan: Script to run Coverity Scan build
      scripts/coverity-scan: Add Docker support
      docs: Improve our gdbstub documentation
      configure: Honour --disable-werror for Sphinx
      scripts/kernel-doc: Add missing close-paren in c:function directives
      kernel-doc: Use c:struct for Sphinx 3.0 and later
      docs: Require Sphinx 1.6 or better
      Deprecate KVM support for AArch32

 configure                                  |   9 +-
 Makefile                                   |   2 +-
 include/qemu/osdep.h                       |  14 -
 include/qemu/thread.h                      |  12 +-
 linux-user/flatload.c                      |   2 +-
 MAINTAINERS                                |   5 +
 docs/conf.py                               |   6 +-
 docs/sphinx/kerneldoc.py                   |   1 +
 docs/system/deprecated.rst                 |   8 +
 docs/system/gdb.rst                        |  22 +-
 qemu-options.hx                            |  24 +-
 scripts/coverity-scan/coverity-scan.docker | 131 ++++++++++
 scripts/coverity-scan/run-coverity-scan    | 401 +++++++++++++++++++++++++++++
 scripts/kernel-doc                         |  18 +-
 14 files changed, 615 insertions(+), 40 deletions(-)
 create mode 100644 scripts/coverity-scan/coverity-scan.docker
 create mode 100755 scripts/coverity-scan/run-coverity-scan

