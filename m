Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3E8EC5B578
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 22:11:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6A01205C9
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 22:11:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6A01205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hi4WX-0002T2-0f
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 18:11:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53567)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hi3VC-0005w2-LI
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 17:06:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hi3V8-0004r2-CM
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 17:06:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56400)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>)
 id 1hi3Uq-0004hN-9y; Mon, 01 Jul 2019 17:05:58 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9270C8667B;
 Mon,  1 Jul 2019 19:49:50 +0000 (UTC)
Received: from x1w.redhat.com (unknown [10.40.205.170])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 488F912A6B;
 Mon,  1 Jul 2019 19:49:45 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon,  1 Jul 2019 21:49:34 +0200
Message-Id: <20190701194942.10092-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Mon, 01 Jul 2019 19:49:57 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v4 0/8] Support disabling TCG on ARM
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
 Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
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

v2: https://lists.gnu.org/archive/html/qemu-devel/2019-06/msg03271.html

Most of the patches from v1 got adapted, except the "Move all
interrupt handlers" patch, because Peter disagreed with it.
See threads:
 https://lists.gnu.org/archive/html/qemu-devel/2018-11/msg03908.html
 https://lists.gnu.org/archive/html/qemu-devel/2019-05/msg07304.html
Anyway this is not a blocking issue, and can be done once this series
get merged.

v3: http://mid.mail-archive.com/20190701132516.26392-1-philmd@redhat.com
- Addressed Alex's review comments from v2.
- added RFC patches to remove (pre-v7, M-profile, R-profile) from KVM-onl=
y build

v4:
- patches 1-12, 14-17, 19-21 accepted, rebased on target-arm.next
- addressed Peter's comment (described in each patch).
Based-on: target-arm.next

$ git backport-diff -u v3 -r target-arm.next..v4
Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream pat=
ch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respec=
tively

001/8:[0048] [FC] 'target/arm: Move debug routines to debug_helper.c'
002/8:[0004] [FC] 'target/arm: Restrict semi-hosting to TCG'
003/8:[0027] [FC] 'target/arm/helper: Move M profile routines to m_helper=
.c'
004/8:[----] [--] 'RFC target/arm: Restrict pre-ARMv7 cpus to TCG'
005/8:[----] [--] 'RFC target/arm: Do not build pre-ARMv7 cpus when using=
 KVM'
006/8:[----] [--] 'RFC target/arm: Restrict R and M profiles to TCG'
007/8:[----] [--] 'RFC target/arm: Do not build A/M-profile cpus when usi=
ng KVM'
008/8:[----] [--] 'target/arm: Do not build TCG objects when TCG is off'

Patches 4-8 are included as RFC for series completeness, but are not
meant for review for the 4.1 release.

Paolo, the RFC patches are ARM but Kconfig related, you might want to
have a look at them ;) Cc'ing Thomas for the same reason.

Thanks a lot to Alex and Peter for their review time, and Samuel for
the original effort.

Regards,

Phil.

[1]: https://lists.gnu.org/archive/html/qemu-devel/2018-11/msg02451.html

Philippe Mathieu-Daud=C3=A9 (8):
  target/arm: Move debug routines to debug_helper.c
  target/arm: Restrict semi-hosting to TCG
  target/arm/helper: Move M profile routines to m_helper.c
  RFC target/arm: Restrict pre-ARMv7 cpus to TCG
  RFC target/arm: Do not build pre-ARMv7 cpus when using KVM
  RFC target/arm: Restrict R and M profiles to TCG
  RFC target/arm: Do not build A/M-profile cpus when using KVM
  target/arm: Do not build TCG objects when TCG is off

 default-configs/arm-softmmu.mak |   47 +-
 hw/arm/Kconfig                  |   42 +-
 target/arm/Makefile.objs        |    9 +-
 target/arm/cpu.c                |   25 +-
 target/arm/cpu.h                |    7 +
 target/arm/debug_helper.c       |  311 ++++
 target/arm/helper.c             | 2669 +-----------------------------
 target/arm/m_helper.c           | 2676 +++++++++++++++++++++++++++++++
 target/arm/op_helper.c          |  295 ----
 9 files changed, 3091 insertions(+), 2990 deletions(-)
 create mode 100644 target/arm/debug_helper.c
 create mode 100644 target/arm/m_helper.c

--=20
2.20.1


