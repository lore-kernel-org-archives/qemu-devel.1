Return-Path: <SRS0=zSEs=EO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AF8CC388F2
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 05:32:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00CE320897
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 05:32:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00CE320897
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=getutm.app
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kbdJ3-0006ji-4O
	for qemu-devel@archiver.kernel.org; Sun, 08 Nov 2020 00:32:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42472)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osy86github@gmail.com>)
 id 1kbdDR-0001QT-Iu
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 00:26:13 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34611)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osy86github@gmail.com>)
 id 1kbdDO-0004ts-C1
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 00:26:13 -0500
Received: by mail-pl1-f193.google.com with SMTP id p4so2963381plr.1
 for <qemu-devel@nongnu.org>; Sat, 07 Nov 2020 21:26:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=xlXS8bTLGmgrI4jv8lK1KhWtrhRRrwvn4l+tYjVvwMM=;
 b=XCST/y2J5wQNBh3Z75SE8vqjbTyLCDtYY9JSf2NamwVyYO7HigeYAN2/S//f2AKRrV
 IduiT5PoJd/McNiaqnUIIi9W47hBG/i9PyfJDaOvJ7y+RG+SdRcf5mldF39wxid/+HXD
 zOeldII38Ds3+43vuFbH33HKLzN60ZZZ30DttqtLpmjuwtts0e1/pXbrEHH5S2VhT7fK
 3SpOh7hVhfFreKstlLVKw8vc590W2dpK3cVSbr5VFgg/7k9E1eKZ5JjH+zCKutHthLxq
 ToAwlYpmsx4RzgmZ5iVHgdQ4yuFBwZvINukcatrzz4TZUp5TaXqtnG5kC0ZULNtz+roD
 i97g==
X-Gm-Message-State: AOAM531s7eg5xcRK4tIOEnn840MBeutisAxjh1Z+eq5mcmLeyD1tneu0
 7h5iEHc4pjDkK5LWNdijVdmsUXEK07Q=
X-Google-Smtp-Source: ABdhPJzj1N19iPTBByCzfJ+Qd1KNdNugCJd3xn+eO9Fx8Vg6TGMnL3ZYZcxMfWaRdXm9gs71rqZp5Q==
X-Received: by 2002:a17:90a:d201:: with SMTP id
 o1mr6856556pju.46.1604813167888; 
 Sat, 07 Nov 2020 21:26:07 -0800 (PST)
Received: from localhost.localdomain ([73.93.155.42])
 by smtp.gmail.com with ESMTPSA id hz18sm6994406pjb.13.2020.11.07.21.26.06
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 07 Nov 2020 21:26:07 -0800 (PST)
From: Joelle van Dyne <j@getutm.app>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 0/7] iOS and Apple Silicon host support
Date: Sat,  7 Nov 2020 21:25:58 -0800
Message-Id: <20201108052605.45840-1-j@getutm.app>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.214.193;
 envelope-from=osy86github@gmail.com; helo=mail-pl1-f193.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/08 00:26:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
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
Cc: Joelle van Dyne <j@getutm.app>
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
 qapi/block-core.json        |  4 +-
 include/exec/exec-all.h     |  2 +
 include/qemu/osdep.h        | 11 +++++
 include/tcg/tcg-apple-jit.h | 86 +++++++++++++++++++++++++++++++++++++
 include/tcg/tcg.h           |  3 ++
 accel/tcg/cpu-exec-common.c |  2 +
 accel/tcg/cpu-exec.c        |  2 +
 accel/tcg/translate-all.c   | 46 ++++++++++++++++++++
 block.c                     |  2 +-
 block/file-posix.c          | 51 ++++++++++++++++------
 net/slirp.c                 | 16 +++----
 qga/commands-posix.c        |  6 +++
 tcg/tcg.c                   |  4 ++
 util/coroutine-ucontext.c   |  9 ++++
 .gitmodules                 |  3 ++
 MAINTAINERS                 |  7 +++
 libucontext                 |  1 +
 meson_options.txt           |  2 +
 tests/qtest/meson.build     |  7 ++-
 23 files changed, 367 insertions(+), 35 deletions(-)
 create mode 100644 docs/devel/ios.rst
 create mode 100644 include/tcg/tcg-apple-jit.h
 create mode 160000 libucontext

-- 
2.28.0


