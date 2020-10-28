Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A12FCC388F9
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 03:09:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15CC12242B
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 03:09:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15CC12242B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=getutm.app
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34526 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXbpr-0005RB-LG
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 23:09:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58270)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osy86github@gmail.com>)
 id 1kXbnn-0003d6-9r
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 23:07:07 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36264)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osy86github@gmail.com>)
 id 1kXbnl-0006f5-IH
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 23:07:06 -0400
Received: by mail-pl1-f194.google.com with SMTP id r10so1792931plx.3
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 20:07:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=vywBQM9toHTg0WEsn8QMmtssiGPBfo/CxQm9kSe/cM8=;
 b=gdq8WZ+ischlomlY1oz6JecU7P+Ft7UmQdthFfzCwwPkE0rHzuqClB7EmQcSqSMqW+
 FRQoH5pJc+yVOpIOhdJ9FpOAGHH6LNhniYL4wsVlc8nlHgHiApZfUVuGqYzMypYEmuo+
 vUVA+oM+66sURvWT85UixvWFzeefn9RY0s2r+FMcHUvYT4X5D2P1ZT80B6/mc/Biv3Iz
 tHMEfAQmuCM4AAz2Plhv4L7Dowhzyqxre6h/ih52iXCZQKBu1vMfiSHNLRn5d18TU/zt
 A4Ch8UENJX6WSJ1Na9k/f3R2dfnwjYGg5+DvyKIz1oeqYRSEw8sM+zTXXMCz5FgX+ehB
 IqpA==
X-Gm-Message-State: AOAM53159hmaXMZuxZBYpR0CaifRUMYZxqfUvSGRGoXtgylHYF/psOkP
 +LxTd+GhsYgs7FASSbMM8qd8C1OCI6Y=
X-Google-Smtp-Source: ABdhPJwEzm3IbfIMgubg7VFAflRvn9h7UFUeMzUC91hZZdxI3Ldcd/G7Paco0l9GJuH4Gxj6JMF4+A==
X-Received: by 2002:a17:90a:e698:: with SMTP id
 s24mr4829035pjy.72.1603854423378; 
 Tue, 27 Oct 2020 20:07:03 -0700 (PDT)
Received: from localhost.localdomain ([73.93.155.93])
 by smtp.gmail.com with ESMTPSA id n6sm3407219pjj.34.2020.10.27.20.07.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 27 Oct 2020 20:07:02 -0700 (PDT)
From: Joelle van Dyne <j@getutm.app>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 0/7] iOS and Apple Silicon host support
Date: Tue, 27 Oct 2020 20:06:54 -0700
Message-Id: <20201028030701.14086-1-j@getutm.app>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.214.194;
 envelope-from=osy86github@gmail.com; helo=mail-pl1-f194.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 23:07:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Based-on: 20201026191540.12434-1-j@getutm.app
([PATCH RESEND 0/4] Mirror map JIT memory for TCG)

These set of changes brings QEMU TCG to iOS devices and future Apple Silicon
devices. They were originally developed last year and have been working in the
UTM app. Recently, we ported the changes to master, re-wrote a lot of the build
script changes for meson, and broke up the patches into more distinct units.

A summary of the changes:

* `CONFIG_IOS` defined when building for iOS and iOS specific changes (as well
  as unsupported code) are gated behind it.
* A new dependency, libucontext is added since iOS does not have native ucontext
  and broken support for sigaltstack. libucontext is available as a new option
  for coroutine backend.
* On stock iOS devices, there is a workaround for running JIT code without
  any special entitlement. It requires the JIT region to be mirror mapped with
  one region RW and another one RX. To support this style of JIT, TCG is changed
  to support writing to a different code_ptr. This change is submitted in a
  different patch set and this one depends on it.
* For (recent) jailbroken iOS devices as well as upcoming Apple Silicon devices,
  there are new rules for applications supporting JIT (with the proper
  entitlement). These rules are implemented as well.

Since v3:

* Moved mirror JIT support to a different patch set.
* Removed dependency on `pthread_jit_write_protect_np` because it was redundent
  and also crashes if called on a non-jailbroken iOS device.
* Removed `--enable-cross-compile` option
* Fixed checkpatch errors
* Fixed iOS build on master due to new test recently added which calls system()

Since v2:

* Changed getting mirror pointer from a macro to inline functions
* Split constification of TCG code pointers to separate patch
* Removed slirp updates (will send future patch once slirp changes are in)
* Removed shared library patch (will send future patch)

-j

Joelle van Dyne (7):
  configure: option to disable host block devices
  configure: cross-compiling with empty cross_prefix
  qemu: add support for iOS host
  coroutine: add libucontext as external library
  slirp: update build flags for iOS resolv fix
  tcg: implement JIT for iOS and Apple Silicon
  block: check availablity for preadv/pwritev on mac

 docs/devel/index.rst           |   1 +
 docs/devel/ios.rst             |  39 ++++++++++++
 configure                      |  77 ++++++++++++++++++++++--
 meson.build                    |  34 ++++++++++-
 include/exec/exec-all.h        |   2 +
 include/tcg/tcg-apple-jit.h    | 106 +++++++++++++++++++++++++++++++++
 include/tcg/tcg.h              |   3 +
 tcg/aarch64/tcg-target.h       |   7 +++
 accel/tcg/cpu-exec-common.c    |   2 +
 accel/tcg/cpu-exec.c           |   2 +
 accel/tcg/translate-all.c      |  87 ++++++++++++++++++++++++++-
 block.c                        |   2 +-
 block/file-posix.c             |  51 ++++++++++++----
 net/slirp.c                    |  16 ++---
 qga/commands-posix.c           |   6 ++
 target/arm/arm-semi.c          |   2 +
 target/m68k/m68k-semi.c        |   2 +
 target/nios2/nios2-semi.c      |   2 +
 tcg/tcg.c                      |   4 ++
 tests/qtest/libqos/virtio-9p.c |   8 +++
 util/coroutine-ucontext.c      |   9 +++
 .gitmodules                    |   3 +
 libucontext                    |   1 +
 meson_options.txt              |   2 +
 tests/qtest/meson.build        |   7 +--
 25 files changed, 440 insertions(+), 35 deletions(-)
 create mode 100644 docs/devel/ios.rst
 create mode 100644 include/tcg/tcg-apple-jit.h
 create mode 160000 libucontext

-- 
2.28.0


