Return-Path: <SRS0=zSEs=EO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17F92C388F9
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 23:28:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A714D206DB
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 23:28:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A714D206DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=getutm.app
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kbu6M-0002Zh-GH
	for qemu-devel@archiver.kernel.org; Sun, 08 Nov 2020 18:28:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45192)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osy86github@gmail.com>)
 id 1kbu2w-0000ky-LK
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 18:24:30 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43376)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osy86github@gmail.com>)
 id 1kbu2v-0000FG-2g
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 18:24:30 -0500
Received: by mail-pf1-f196.google.com with SMTP id z3so6110543pfb.10
 for <qemu-devel@nongnu.org>; Sun, 08 Nov 2020 15:24:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=QR6l0oO0N33nF2HH4gIWqjkSU1Ga2pDLwCrBr86eCSQ=;
 b=OMJzt6JPxDBxFwA+uyo8PbW54rjcaVq0NQkCFduhmgvyFPUmITutGXFFJvpg1W2ffh
 ctnwre6kfWo3lL2ytFNEeJLvXXr7vrrwnZeeSqTZn2A06ewyyNZlP/BSNzDPk4uDAgVV
 OF+gFP52OERneLsfu5ti3FlOhHVV7fdCtedZefRx6Vp5SXpRNBBH7AYBbkBQ1rpckDMb
 BkTc4/1DnZsB69zLlRixYFgqCGResFZljHLiiEx4Cfvlid7eQgm+454Gfdl7jqy3jPrM
 mYamR0LVka7s9JErzGNtjO+uw8jp+g+qOhZI9+X6kfK/fhuW0WdrZ2u9tkFDTJQDJWZ3
 etkg==
X-Gm-Message-State: AOAM530vhxTFgTTGgSymfx6THALU9XaZK1Fhb+IBjadNt6rSc4Hbpp0Q
 zjRFEmFo+ICZZOxC19XVKasADGTWqGk=
X-Google-Smtp-Source: ABdhPJwNhyDdOY6/uVRKS1tiA+SprHAWz6eFwhHfGpNWUQ7fC0mVUla6XgoG+MT1hSsfY8nPNUWhIQ==
X-Received: by 2002:a05:6a00:6:b029:18b:b5a:494c with SMTP id
 h6-20020a056a000006b029018b0b5a494cmr11418252pfk.81.1604877867306; 
 Sun, 08 Nov 2020 15:24:27 -0800 (PST)
Received: from localhost.localdomain ([73.93.154.215])
 by smtp.gmail.com with ESMTPSA id z3sm8275171pgl.73.2020.11.08.15.24.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 08 Nov 2020 15:24:26 -0800 (PST)
From: Joelle van Dyne <j@getutm.app>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 0/7] iOS and Apple Silicon host support
Date: Sun,  8 Nov 2020 15:24:17 -0800
Message-Id: <20201108232425.1705-1-j@getutm.app>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.210.196;
 envelope-from=osy86github@gmail.com; helo=mail-pf1-f196.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/08 18:24:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Based-on: 20201106032921.600200-1-richard.henderson@linaro.org
([PATCH v3 00/41] Mirror map JIT memory for TCG)

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
* For (recent) jailbroken iOS devices as well as upcoming Apple Silicon devices,
  there are new rules for applications supporting JIT (with the proper
  entitlement). These rules are implemented as well.

Since v5:

* Fixed some more instances of QAPI define of CONFIG_HOST_BLOCK_DEVICE
* Fixed libucontext build on newer version of GCC

Since v4:

* Updated QAPI schema for CONFIG_HOST_BLOCK_DEVICE
* Updated maintainers file for iOS host support
* Moved system() changes to osdep.h
* Fixed typo in libucontext meson.build change

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

 docs/devel/index.rst        |  1 +
 docs/devel/ios.rst          | 28 ++++++++++++
 configure                   | 76 +++++++++++++++++++++++++++++---
 meson.build                 | 33 +++++++++++++-
 qapi/block-core.json        | 10 +++--
 include/exec/exec-all.h     |  2 +
 include/qemu/osdep.h        | 11 +++++
 include/tcg/tcg-apple-jit.h | 86 +++++++++++++++++++++++++++++++++++++
 include/tcg/tcg.h           |  3 ++
 accel/tcg/cpu-exec-common.c |  2 +
 accel/tcg/cpu-exec.c        |  2 +
 accel/tcg/translate-all.c   | 46 ++++++++++++++++++++
 block.c                     |  2 +-
 block/file-posix.c          | 53 +++++++++++++++++------
 net/slirp.c                 | 16 +++----
 qga/commands-posix.c        |  6 +++
 tcg/tcg.c                   |  4 ++
 util/coroutine-ucontext.c   |  9 ++++
 .gitmodules                 |  3 ++
 MAINTAINERS                 |  7 +++
 libucontext                 |  1 +
 meson_options.txt           |  2 +
 tests/qtest/meson.build     |  7 ++-
 23 files changed, 373 insertions(+), 37 deletions(-)
 create mode 100644 docs/devel/ios.rst
 create mode 100644 include/tcg/tcg-apple-jit.h
 create mode 160000 libucontext

-- 
2.28.0


