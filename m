Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F9DEC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 05:22:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA6392225F
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 05:22:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA6392225F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=getutm.app
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUNcn-0005YX-HN
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 01:22:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54188)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osy86github@gmail.com>)
 id 1kUNaR-0003xR-Al
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 01:19:59 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:54821)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osy86github@gmail.com>)
 id 1kUNaP-0005Bo-GB
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 01:19:58 -0400
Received: by mail-pj1-f67.google.com with SMTP id az3so4684470pjb.4
 for <qemu-devel@nongnu.org>; Sun, 18 Oct 2020 22:19:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=rlg8WALYpPlG8NDYC2Y8LlOBll+qZX4uBM0hQ3quyAw=;
 b=AjkbrW+djX1s4ePbxIfDUoqOnjt5TIKRoxOcn0GbV1WsYHYr5nFH3bmqALZc3S6+oo
 eC4UqJqCPsIS04kN1HwhNPPSJIgIAaXeHy+/+/nPGTvetotnO8DHS2JMY1rOI4Z0iOj1
 7MsNCX9ryHvYyZX26kCIUCEWGEMq7GvtFKWgBl5lmAON5To/YtNr4AhwwWiJ/WArO20N
 r0hOCWoS3xp/Eq+NmzJVCgydZZFbmj4fQQjbmMpf2+svugrawfE7PLmvUn6Zqw3iE7JF
 MqbM3h8dCJiX2jOJgaxSjXGVjuvdVedmwVGqaUYe3AVMECli1QIRM3l/qCyLhSGEgHOL
 fyKA==
X-Gm-Message-State: AOAM531lvCmHcNwSZg9dwcvGDCI+nOFCYptMWi9jdlr0dG3JWroCcgER
 Yu7dH1mnyMPjwNJvA1cl2Z8ieTj7IzFglg==
X-Google-Smtp-Source: ABdhPJxjSfmwB+A2JPpppAhJl7YQ305D4k+CaEOtXScFloZkyu5u4QYNVW9oki3IP9LRTQGxCKLTZA==
X-Received: by 2002:a17:902:9308:b029:d5:e527:60a5 with SMTP id
 bc8-20020a1709029308b02900d5e52760a5mr4006696plb.23.1603084795510; 
 Sun, 18 Oct 2020 22:19:55 -0700 (PDT)
Received: from localhost.localdomain ([73.93.152.253])
 by smtp.gmail.com with ESMTPSA id p6sm10673904pjd.1.2020.10.18.22.19.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 18 Oct 2020 22:19:55 -0700 (PDT)
From: Joelle van Dyne <j@getutm.app>
To: qemu-devel@nongnu.org
Subject: [PATCH RESEND v2 0/9] iOS and Apple Silicon host support
Date: Sun, 18 Oct 2020 22:19:44 -0700
Message-Id: <20201019051953.90107-1-j@getutm.app>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.216.67; envelope-from=osy86github@gmail.com;
 helo=mail-pj1-f67.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/19 01:19:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.249, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
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

These set of changes brings QEMU TCG to iOS devices and future Apple Silicon
devices. They were originally developed last year and have been working in the
UTM app. Recently, we ported the changes to master, re-wrote a lot of the build
script changes for meson, and broke up the patches into more distinct units.

A summary of the changes:

* `CONFIG_IOS` and `CONFIG_IOS_JIT` defined when building for iOS and
  iOS specific changes (as well as unsupported code) are gated behind it.
* A new dependency, libucontext is added since iOS does not have native ucontext
  and broken support for sigaltstack. libucontext is available as a new option
  for coroutine backend.
* On stock iOS devices, there is a workaround for running JIT code without
  any special entitlement. It requires the JIT region to be mirror mapped with
  one region RW and another one RX. To support this style of JIT, TCG is changed
  to support writing to a different code_ptr. These changes are gated by the
  `CONFIG_IOS_JIT`.
* For (recent) jailbroken iOS devices as well as upcoming Apple Silicon devices,
  there are new rules for applications supporting JIT (with the proper
  entitlement). These rules are implemented as well.

Since v2:

* Changed getting mirror pointer from a macro to inline functions
* Split constification of TCG code pointers to separate patch
* Removed slirp updates (will send future patch once slirp changes are in)
* Removed shared library patch (will send future patch)

-j

osy (9):
  configure: option to disable host block devices
  configure: cross-compiling without cross_prefix
  qemu: add support for iOS host
  coroutine: add libucontext as external library
  tcg: add const hints for code pointers
  tcg: implement mirror mapped JIT for iOS
  tcg: mirror mapping RWX pages for iOS optional
  tcg: support JIT on Apple Silicon
  block: check availablity for preadv/pwritev on mac

 docs/devel/ios.rst           |  40 +++++++++
 configure                    | 104 ++++++++++++++++++++--
 meson.build                  |  32 ++++++-
 include/exec/exec-all.h      |  10 +++
 include/sysemu/tcg.h         |   2 +-
 include/tcg/tcg-apple-jit.h  |  85 ++++++++++++++++++
 include/tcg/tcg.h            |  28 +++++-
 tcg/aarch64/tcg-target.h     |  23 ++++-
 tcg/arm/tcg-target.h         |   9 +-
 tcg/i386/tcg-target.h        |  24 ++++-
 tcg/mips/tcg-target.h        |   8 +-
 tcg/ppc/tcg-target.h         |   8 +-
 tcg/riscv/tcg-target.h       |   9 +-
 tcg/s390/tcg-target.h        |  13 ++-
 tcg/sparc/tcg-target.h       |   8 +-
 tcg/tci/tcg-target.h         |   9 +-
 accel/tcg/cpu-exec-common.c  |   2 +
 accel/tcg/cpu-exec.c         |   9 +-
 accel/tcg/tcg-all.c          |  27 +++++-
 accel/tcg/translate-all.c    | 168 ++++++++++++++++++++++++++++++++---
 block.c                      |   2 +-
 block/file-posix.c           |  50 ++++++++---
 bsd-user/main.c              |   2 +-
 linux-user/main.c            |   2 +-
 net/slirp.c                  |  16 ++--
 qga/commands-posix.c         |   6 ++
 target/arm/arm-semi.c        |   2 +
 target/m68k/m68k-semi.c      |   2 +
 target/nios2/nios2-semi.c    |   2 +
 tcg/tcg.c                    |  64 ++++++++-----
 util/coroutine-ucontext.c    |   9 ++
 .gitmodules                  |   3 +
 libucontext                  |   1 +
 meson_options.txt            |   2 +
 qemu-options.hx              |  11 +++
 tcg/aarch64/tcg-target.c.inc |  48 ++++++----
 tcg/arm/tcg-target.c.inc     |  33 ++++---
 tcg/i386/tcg-target.c.inc    |  28 +++---
 tcg/mips/tcg-target.c.inc    |  64 +++++++------
 tcg/ppc/tcg-target.c.inc     |  55 +++++++-----
 tcg/riscv/tcg-target.c.inc   |  51 ++++++-----
 tcg/s390/tcg-target.c.inc    |  25 +++---
 tcg/sparc/tcg-target.c.inc   |  33 ++++---
 tcg/tcg-ldst.c.inc           |   2 +-
 tcg/tcg-pool.c.inc           |   9 +-
 tcg/tci/tcg-target.c.inc     |   8 +-
 tests/qtest/meson.build      |   7 +-
 47 files changed, 919 insertions(+), 236 deletions(-)
 create mode 100644 docs/devel/ios.rst
 create mode 100644 include/tcg/tcg-apple-jit.h
 create mode 160000 libucontext

-- 
2.24.3 (Apple Git-128)


