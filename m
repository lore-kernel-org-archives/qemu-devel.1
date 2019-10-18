Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2785CCA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 13:37:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0659222C2
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 13:37:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0659222C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLSRW-0008Dy-N1
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 09:37:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52791)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iLSQF-00073b-8u
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 09:36:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iLSQC-0007W8-FP
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 09:36:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52888)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iLSQB-0007VP-Lk
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 09:35:59 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0D2192B89;
 Fri, 18 Oct 2019 13:35:58 +0000 (UTC)
Received: from x1w.redhat.com (unknown [10.40.205.74])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6DCEE194BE;
 Fri, 18 Oct 2019 13:35:50 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/4] mc146818rtc: Allow call object_initialize(MC146818_RTC)
 instead of rtc_init()
Date: Fri, 18 Oct 2019 15:35:43 +0200
Message-Id: <20191018133547.10936-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.71]); Fri, 18 Oct 2019 13:35:58 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Four RTC146818 patches extracted from a bigger series:
"hw/i386/pc: Split PIIX3 southbridge from i440FX northbridge"
https://lists.gnu.org/archive/html/qemu-devel/2019-10/msg03685.html

This step is required to be able to create a MC146818_RTC within
a QOM object (which will be used in the "piix4: add a mc146818rtc
controller" patch later).

No changes since previous post:
$ git backport-diff -u pc_split_i440fx_piix
Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream pat=
ch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respec=
tively

001/4:[----] [--] 'mc146818rtc: move structure to header file'
002/4:[----] [--] 'mc146818rtc: Move RTC_ISA_IRQ definition'
003/4:[----] [--] 'mc146818rtc: Include "mc146818rtc_regs.h" directly in =
mc146818rtc.c'
004/4:[----] [--] 'mc146818rtc: always register rtc to rtc list'

Herv=C3=A9 Poussineau (2):
  mc146818rtc: move structure to header file
  mc146818rtc: always register rtc to rtc list

Philippe Mathieu-Daud=C3=A9 (2):
  mc146818rtc: Move RTC_ISA_IRQ definition
  mc146818rtc: Include mc146818rtc_regs.h directly in mc146818rtc.c

 hw/timer/mc146818rtc.c              | 39 +++--------------------------
 include/hw/timer/mc146818rtc.h      | 36 +++++++++++++++++++++++++-
 include/hw/timer/mc146818rtc_regs.h |  2 --
 tests/rtc-test.c                    |  1 +
 4 files changed, 39 insertions(+), 39 deletions(-)

--=20
2.21.0


