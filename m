Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC32CC433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 00:59:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BDCA218AC
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 00:59:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BDCA218AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=getutm.app
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60278 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kS8f4-0004Nd-Mt
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 20:59:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44882)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1kS7Gd-0001mW-2H
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 19:30:11 -0400
Received: from mail-pf1-f170.google.com ([209.85.210.170]:45307)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1kS7GB-00060p-5D
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 19:30:10 -0400
Received: by mail-pf1-f170.google.com with SMTP id e7so6201709pfn.12
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 16:29:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=L/OSG/2hTLtzEozIXjJfqbODBNlgXCsDdxNndbh2w2k=;
 b=Fud8LbscBVAr7GwUqa67W6g/NlorBiy/bzbkIKDHqfzmxhhfFa6OOZOWCfGN1KpspW
 vF2AXI7XAJ5yWd//5bQB/RMFb6mDA3cEu1RqOyFkwl9ZisBhCGbYiFRO1f/Hx2mBTXXu
 XaQTgcFH00B9ZJrTTIIkVR2sr0svvRFPxwQtPjqEuQMQSKMbrDFCUg1DRLOwBAnPHCdD
 4urnem4lXd++nLsZ7YgIqNZh2Wg9KeTKqsiL2fDeTyHDfg3XFQpzX0sHjqr0ZORkmKVg
 jNTFzQWA0P08x8/fe7pRMco6Jls0fLJGbtXfYUnUEd0P+ALXhE0xNNzjjMUN9jRCTyM5
 /gDQ==
X-Gm-Message-State: AOAM53333DZDF5Kxa9X/pdd9PVqT9ds3LTmiW8mpjKg8nDQBTJsP+CmD
 Va4QVX5i4Q3EWCEmPO9fXMpUEj6Ytz4=
X-Google-Smtp-Source: ABdhPJyJDGfQr6GctlJIOQmYyXEzsduP2vht3JdwsPWwo2i3MTZqKOdUtI85ai0xmF6X6sdPLElPEw==
X-Received: by 2002:aa7:8e54:0:b029:142:2501:34d2 with SMTP id
 d20-20020aa78e540000b0290142250134d2mr24891356pfr.43.1602545381006; 
 Mon, 12 Oct 2020 16:29:41 -0700 (PDT)
Received: from localhost.localdomain ([73.93.152.174])
 by smtp.gmail.com with ESMTPSA id f21sm8088315pfk.169.2020.10.12.16.29.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 12 Oct 2020 16:29:40 -0700 (PDT)
From: Joelle van Dyne <j@getutm.app>
To: qemu-devel@nongnu.org
Subject: [PATCH 00/10] iOS and Apple Silicon host support
Date: Mon, 12 Oct 2020 16:29:29 -0700
Message-Id: <20201012232939.48481-1-j@getutm.app>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.210.170; envelope-from=osy86dev@gmail.com;
 helo=mail-pf1-f170.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/12 19:29:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.249, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 12 Oct 2020 20:56:28 -0400
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
* slirp updated to support DNS resolving using libresolv; a separate patch will
  be submitted to the project. To allow for builds to succeed, the .gitmodule
  is temporarily changed. We're not entirely sure how cross-project patches
  should be handled here.
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
* An option to build QEMU as a shared library is added because iOS does not
  support fork().

These patches are also on Github:
  https://github.com/utmapp/qemu/tree/ios-support-master

-j

osy (10):
  configure: option to disable host block devices
  configure: cross-compiling without cross_prefix
  qemu: add support for iOS host
  meson: option to build as shared library
  slirp: update for iOS resolv fix
  coroutine: add libucontext as external library
  tcg: implement bulletproof JIT
  tcg: mirror mapping RWX pages for iOS optional
  tcg: support JIT on Apple Silicon
  block: check availablity for preadv/pwritev on mac

 .gitmodules                  |   5 +-
 accel/tcg/cpu-exec-common.c  |   2 +
 accel/tcg/cpu-exec.c         |   9 +-
 accel/tcg/tcg-all.c          |  27 +++++-
 accel/tcg/translate-all.c    | 169 ++++++++++++++++++++++++++++++++---
 block.c                      |   2 +-
 block/file-posix.c           |  50 ++++++++---
 bsd-user/main.c              |   2 +-
 configure                    | 118 ++++++++++++++++++++++--
 docs/devel/ios.rst           |  40 +++++++++
 include/exec/exec-all.h      |  10 +++
 include/sysemu/tcg.h         |   2 +-
 include/tcg/tcg-apple-jit.h  |  85 ++++++++++++++++++
 include/tcg/tcg.h            |  21 ++++-
 libucontext                  |   1 +
 linux-user/main.c            |   2 +-
 meson.build                  |  74 +++++++++++++--
 meson_options.txt            |   4 +
 net/slirp.c                  |  16 ++--
 qemu-options.hx              |  11 +++
 qga/commands-posix.c         |   6 ++
 slirp                        |   2 +-
 target/arm/arm-semi.c        |   2 +
 target/m68k/m68k-semi.c      |   2 +
 target/nios2/nios2-semi.c    |   2 +
 tcg/aarch64/tcg-target.c.inc |  48 ++++++----
 tcg/aarch64/tcg-target.h     |  23 ++++-
 tcg/arm/tcg-target.c.inc     |  33 ++++---
 tcg/arm/tcg-target.h         |   9 +-
 tcg/i386/tcg-target.c.inc    |  28 +++---
 tcg/i386/tcg-target.h        |  24 ++++-
 tcg/mips/tcg-target.c.inc    |  64 +++++++------
 tcg/mips/tcg-target.h        |   8 +-
 tcg/ppc/tcg-target.c.inc     |  55 +++++++-----
 tcg/ppc/tcg-target.h         |   8 +-
 tcg/riscv/tcg-target.c.inc   |  51 ++++++-----
 tcg/riscv/tcg-target.h       |   9 +-
 tcg/s390/tcg-target.c.inc    |  25 +++---
 tcg/s390/tcg-target.h        |  13 ++-
 tcg/sparc/tcg-target.c.inc   |  33 ++++---
 tcg/sparc/tcg-target.h       |   8 +-
 tcg/tcg-ldst.c.inc           |   2 +-
 tcg/tcg-pool.c.inc           |   9 +-
 tcg/tcg.c                    |  64 ++++++++-----
 tcg/tci/tcg-target.c.inc     |   8 +-
 tcg/tci/tcg-target.h         |   9 +-
 tests/qtest/meson.build      |   7 +-
 util/coroutine-ucontext.c    |   9 ++
 48 files changed, 965 insertions(+), 246 deletions(-)
 create mode 100644 docs/devel/ios.rst
 create mode 100644 include/tcg/tcg-apple-jit.h
 create mode 160000 libucontext

-- 
2.24.3 (Apple Git-128)


