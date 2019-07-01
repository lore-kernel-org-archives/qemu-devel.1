Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 325B7C0650E
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 13:28:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0844320665
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 13:28:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0844320665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhwMW-0004Sx-5m
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 09:28:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40590)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hhwJS-0001EZ-Ag
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 09:25:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hhwJQ-0001Mp-PZ
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 09:25:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60956)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>)
 id 1hhwJK-0001FL-Fz; Mon, 01 Jul 2019 09:25:35 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BFD6AC0524FB;
 Mon,  1 Jul 2019 13:25:30 +0000 (UTC)
Received: from x1w.redhat.com (unknown [10.40.205.170])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8F01C6085B;
 Mon,  1 Jul 2019 13:25:18 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon,  1 Jul 2019 15:24:49 +0200
Message-Id: <20190701132516.26392-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Mon, 01 Jul 2019 13:25:33 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 00/27] Support disabling TCG on ARM
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
Cc: Yang Zhong <yang.zhong@intel.com>, Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jones <drjones@redhat.com>, Samuel Ortiz <sameo@linux.intel.com>,
 Rob Bradford <robert.bradford@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Paolo motived me to salvage this (other!) previous series fromi
Samuel Ortiz (NEMU project).

v1 cover from Samuel [1]:

  This patchset allows for building and running ARM targets with TCG
  disabled. It splits the target/arm/helper.c file into logical TCG and
  non TCG dependent files so that one can build and run QEMU binaries wit=
h
  or without TCG enabled.

  The rationale behind this work comes from the NEMU project where we're
  trying to only support x86 and ARM 64-bit architectures, without
  including the TCG code base. We can only do so if we can build and run
  ARM binaries with TCG disabled.

v2:

Most of the patches from v1 got adapted, except the "Move all
interrupt handlers" patch, because Peter disagreed with it.
See threads:
 https://lists.gnu.org/archive/html/qemu-devel/2018-11/msg03908.html
 https://lists.gnu.org/archive/html/qemu-devel/2019-05/msg07304.html
Anyway this is not a blocking issue, and can be done once this series
get merged.

v3:
(since v2: https://lists.gnu.org/archive/html/qemu-devel/2019-06/msg03271=
.html)
- Addressed Alex's review comments from v2.
- added RFC patches to remove (pre-v7, M-profile, R-profile) from KVM-onl=
y build

Patches 1-9 are ready for the ARM queue.

--

This is a kind of series you don't want to rebase (as in, the quicker
it get merged, the saner). It is also one of my most painful QEMU
series, and really wish it was worthwhile.

Regards,

Phil.

[1]: https://lists.gnu.org/archive/html/qemu-devel/2018-11/msg02451.html

Philippe Mathieu-Daud=C3=A9 (26):
  target/arm: Makefile cleanup (Aarch64)
  target/arm: Makefile cleanup (ARM)
  target/arm: Makefile cleanup (KVM)
  target/arm: Makefile cleanup (softmmu)
  target/arm: Add copyright boilerplate
  target/arm/helper: Remove unused include
  target/arm: Fix multiline comment syntax
  target/arm: Fix coding style issues
  target/arm: Move CPU state dumping routines to cpu.c
  target/arm: Declare get_phys_addr() function publicly
  target/arm: Move TLB related routines to tlb_helper.c
  target/arm: Move debug routines to debug_helper.c
  target/arm/vfp_helper: Move code around
  target/arm/vfp_helper: Extract vfp_set_fpscr_to_host()
  target/arm/vfp_helper: Extract vfp_set_fpscr_from_host()
  target/arm/vfp_helper: Restrict the SoftFloat use to TCG
  target/arm: Restrict semi-hosting to TCG
  target/arm: Restrict PSCI to TCG
  target/arm: Declare arm_log_exception() function publicly
  target/arm: Declare some M-profile functions publicly
  target/arm/helper: Move M profile routines to m_helper.c
  target/arm: Restrict pre-ARMv7 cpus to TCG
  target/arm: Do not build pre-ARMv7 cpus when using KVM
  target/arm: Restrict R and M profiles to TCG
  target/arm: Do not build A/M-profile cpus when using KVM
  target/arm: Do not build TCG objects when TCG is off

Samuel Ortiz (1):
  target/arm: Move the DC ZVA helper into op_helper

 default-configs/arm-softmmu.mak |   47 +-
 hw/arm/Kconfig                  |   42 +-
 target/arm/Makefile.objs        |   31 +-
 target/arm/cpu.c                |  259 ++-
 target/arm/cpu.h                |    9 +-
 target/arm/debug_helper.c       |  334 ++++
 target/arm/helper.c             | 2837 +------------------------------
 target/arm/internals.h          |   69 +-
 target/arm/m_helper.c           | 2676 +++++++++++++++++++++++++++++
 target/arm/op_helper.c          |  505 +-----
 target/arm/tlb_helper.c         |  200 +++
 target/arm/translate-a64.c      |  128 --
 target/arm/translate.c          |   91 +-
 target/arm/translate.h          |    5 -
 target/arm/vfp_helper.c         |  199 ++-
 15 files changed, 3873 insertions(+), 3559 deletions(-)
 create mode 100644 target/arm/debug_helper.c
 create mode 100644 target/arm/m_helper.c
 create mode 100644 target/arm/tlb_helper.c

--=20
2.20.1


