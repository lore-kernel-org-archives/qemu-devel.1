Return-Path: <SRS0=IjNW=VM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD8E2C7618F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 15:22:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83DC52067C
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 15:22:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83DC52067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hn2oY-0005Uj-0e
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 11:22:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47192)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hn2oK-0004pE-0C
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 11:22:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hn2oI-0001H9-Qh
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 11:22:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54694)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>)
 id 1hn2oG-0001GB-8m; Mon, 15 Jul 2019 11:22:36 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 96E9F308FE8D;
 Mon, 15 Jul 2019 15:22:34 +0000 (UTC)
Received: from x1w.redhat.com (unknown [10.40.205.87])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CEA6A6085B;
 Mon, 15 Jul 2019 15:22:28 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 15 Jul 2019 17:22:20 +0200
Message-Id: <20190715152225.26135-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Mon, 15 Jul 2019 15:22:34 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [RFC PATCH-for-4.1? v2 0/5] semihosting: Build with
 CONFIG_SEMIHOSTING disabled
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>, James Hogan <jhogan@kernel.org>,
 Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-arm@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, James Hogan <james.hogan@mips.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Amusingly Miroslav and myself hit this issue at the same time.

Note now that "config-devices.h" exists (commit 6c22ea9d83) I could use
#include "config-devices.h" to implement Alex's suggestion to avoid a stu=
b:
https://lists.gnu.org/archive/html/qemu-devel/2019-06/msg03607.html

Some know (arch-specific) limitations are:

- MIPS ITU is accessed by coprocessor instr (ISA feature)
- MIPS timer is accessed by coprocessor instr (ISA feature)
- MIPS semihosting (ISA feature?)
- ARM semihosting (ISA feature?)
- ARMv7 NVIC (device)

This series attempt to fix this the most trivial way, adding
stubs for unreachable code.

Since v1: https://lists.gnu.org/archive/html/qemu-devel/2019-05/msg07267.=
html
- Always enable semihosting on linux-user

$ git backport-diff -u v1
Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream pat=
ch
[down] : patch is downstream-only (new)
The flags [FC] indicate (F)unctional and (C)ontextual differences, respec=
tively

001/5:[down] 'target/arm: Always enable CONFIG_SEMIHOSTING'
002/5:[down] 'target/mips: Always enable CONFIG_SEMIHOSTING'
003/5:[down] 'hw/semihosting: Allow this feature to be disabled'
004/5:[0004] [FC] 'target/arm: Add stubs to build with CONFIG_SEMIHOSTING=
 disabled'
005/5:[0005] [FC] 'target/mips: Add stubs to build with CONFIG_SEMIHOSTIN=
G disabled'

Philippe Mathieu-Daud=C3=A9 (5):
  target/arm: Always enable CONFIG_SEMIHOSTING
  target/mips: Always enable CONFIG_SEMIHOSTING
  hw/semihosting: Allow this feature to be disabled
  target/arm: Add stubs to build with CONFIG_SEMIHOSTING disabled
  target/mips: Add stubs to build with CONFIG_SEMIHOSTING disabled

 default-configs/aarch64-linux-user-common.mak |  4 ++++
 default-configs/aarch64-linux-user.mak        |  2 ++
 default-configs/aarch64_be-linux-user.mak     |  2 ++
 default-configs/arm-linux-user-common.mak     |  4 ++++
 default-configs/arm-linux-user.mak            |  2 ++
 default-configs/arm-softmmu.mak               |  4 +++-
 default-configs/armeb-linux-user.mak          |  2 ++
 default-configs/mips-linux-user-common.mak    |  4 ++++
 default-configs/mips-linux-user.mak           |  2 ++
 default-configs/mips-softmmu-common.mak       |  2 +-
 default-configs/mips64-linux-user.mak         |  2 ++
 default-configs/mips64el-linux-user.mak       |  2 ++
 default-configs/mipsel-linux-user.mak         |  2 ++
 default-configs/mipsn32-linux-user.mak        |  2 ++
 default-configs/mipsn32el-linux-user.mak      |  2 ++
 hw/semihosting/Kconfig                        |  3 ++-
 target/arm/Makefile.objs                      |  3 ++-
 target/arm/arm-semi-stubs.c                   | 21 ++++++++++++++++++
 target/mips/Makefile.objs                     |  3 ++-
 target/mips/mips-semi-stubs.c                 | 22 +++++++++++++++++++
 20 files changed, 85 insertions(+), 5 deletions(-)
 create mode 100644 default-configs/aarch64-linux-user-common.mak
 create mode 100644 default-configs/arm-linux-user-common.mak
 create mode 100644 default-configs/mips-linux-user-common.mak
 create mode 100644 target/arm/arm-semi-stubs.c
 create mode 100644 target/mips/mips-semi-stubs.c

--=20
2.20.1


