Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AD0CC4332B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 09:25:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAF9920739
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 09:25:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cDtHJOwd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAF9920739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFDua-0007PH-Q5
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 05:25:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53218)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1jFDtY-0005oy-BQ
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 05:24:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1jFDtW-0007ee-Qb
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 05:24:48 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:22551)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1jFDtW-0007Ye-L7
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 05:24:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584696285;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=IeMxV+nJyYzaQLc3wwNQ9aEwBnBicqgUTnOCjDW6Sxo=;
 b=cDtHJOwdBSE+u1up9vDsINoYWQPnaF5lsTsjXGRsYWS1Wk0R0sHsv1EGA7UYj2Nb4NyEy7
 cer4cZJT2G0Mk97mnh6M4ho9+zBBMFEz2fWrP7tkb4/fs0P0+qpbTXwiXHm4zP7k9AiCyW
 owaex6uRxBgTGzqSQUvxlEgppl+lmtw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-451-MnieVj2aM-qS15lDWykShA-1; Fri, 20 Mar 2020 05:24:41 -0400
X-MC-Unique: MnieVj2aM-qS15lDWykShA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A75451083E80;
 Fri, 20 Mar 2020 09:24:39 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-113-142.ams2.redhat.com [10.36.113.142])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A84B45C1D8;
 Fri, 20 Mar 2020 09:24:32 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, maz@kernel.org,
 kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Subject: [kvm-unit-tests PATCH v7 00/13] arm/arm64: Add ITS tests
Date: Fri, 20 Mar 2020 10:24:15 +0100
Message-Id: <20200320092428.20880-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: peter.maydell@linaro.org, drjones@redhat.com, andre.przywara@arm.com,
 thuth@redhat.com, yuzenghui@huawei.com, alexandru.elisei@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series is a revival of an RFC series sent in Dec 2016 [1].
Given the amount of code and the lack of traction at that time,
I haven't respinned until now. However a recent bug found related
to the ITS migration convinced me that this work may deserve to be
respinned and enhanced.

Tests exercise main ITS commands and also test migration.
With the migration framework, we are able to trigger the
migration from guest and that is very practical actually.

What is particular with the ITS programming is that most of
the commands are passed through queues and there is real error
handling. Invalid commands are just ignored and that is not
really tester friendly.

The series can be fount at:
https://github.com/eauger/kut/tree/its-v7

Applies on top of arm/queue.

Best Regards

Eric

History:
v6 -> v7:
- Fixed issue reported by Drew in its-migrate-unmapped-collection (a coll=
ection
  could be allocated twice depending on the SMP value)
- Integrated changes prepared by Drew
- Use for_each_present_cpu()

v5 -> v6:
- Took into account Zenghui's comments, mostly functional: see invidual
  history logs
- fix wrong assert!

v4 -> v5:
- 32b stubs moved back to arm/gic.c
- some changes reordering
- minor style issues

v3 -> v4:
- addressed comments from Drew and Zenghui
- added "page_alloc: Introduce get_order()"
- removed "arm: gic: Provide per-IRQ helper functions"
- ITS files moved to lib64
- and many more, see individual logs

v2 -> v3:
- fix 32b compilation
- take into account Drew's comments (see individual diff logs)

v1 -> v2:
- took into account Zenghui's comments
- collect R-b's from Thomas

References:
[1] [kvm-unit-tests RFC 00/15] arm/arm64: add ITS framework
    https://lists.gnu.org/archive/html/qemu-devel/2016-12/msg00575.html

Execution:
x For other ITS tests:
  ./run_tests.sh -g its

x non migration tests can be launched invidually. For instance:
  ./arm-run arm/gic.flat -smp 8 -append 'its-trigger'

x also tests can be compiled in standalone mode with
  "make standalone" and tests (even migration ones) can also be
  launched that way, for instance:
  MAX_SMP=3D4 tests/its-migrate-unmapped-collection

Eric Auger (13):
  libcflat: Add other size defines
  page_alloc: Introduce get_order()
  arm/arm64: gic: Introduce setup_irq() helper
  arm/arm64: gicv3: Add some re-distributor defines
  arm/arm64: gicv3: Set the LPI config and pending tables
  arm/arm64: ITS: Introspection tests
  arm/arm64: ITS: its_enable_defaults
  arm/arm64: ITS: Device and collection Initialization
  arm/arm64: ITS: Commands
  arm/arm64: ITS: INT functional tests
  arm/run: Allow Migration tests
  arm/arm64: ITS: migration tests
  arm/arm64: ITS: pending table migration test

 arm/Makefile.arm64         |   1 +
 arm/Makefile.common        |   2 +-
 arm/gic.c                  | 460 ++++++++++++++++++++++++++++++++++--
 arm/run                    |   2 +-
 arm/unittests.cfg          |  38 +++
 lib/alloc_page.c           |   7 +-
 lib/alloc_page.h           |   1 +
 lib/arm/asm/gic-v3-its.h   |  27 +++
 lib/arm/asm/gic-v3.h       |  29 +++
 lib/arm/asm/gic.h          |   1 +
 lib/arm/asm/processor.h    |   2 +
 lib/arm/gic-v3.c           |  78 +++++++
 lib/arm/gic.c              |  40 +++-
 lib/arm/io.c               |  28 +++
 lib/arm64/asm/gic-v3-its.h | 174 ++++++++++++++
 lib/arm64/gic-v3-its-cmd.c | 463 +++++++++++++++++++++++++++++++++++++
 lib/arm64/gic-v3-its.c     | 171 ++++++++++++++
 lib/libcflat.h             |   3 +
 18 files changed, 1496 insertions(+), 31 deletions(-)
 create mode 100644 lib/arm/asm/gic-v3-its.h
 create mode 100644 lib/arm64/asm/gic-v3-its.h
 create mode 100644 lib/arm64/gic-v3-its-cmd.c
 create mode 100644 lib/arm64/gic-v3-its.c

--=20
2.20.1


