Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6A4ACA9EA1
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 13:38:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C091222C3
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 13:38:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C091222C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLSSp-0001oi-LD
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 09:38:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52845)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iLSQO-00076P-6P
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 09:36:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iLSQI-0007aC-Am
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 09:36:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56828)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iLSQH-0007Yg-PT
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 09:36:06 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 071E810F12;
 Fri, 18 Oct 2019 13:36:05 +0000 (UTC)
Received: from x1w.redhat.com (unknown [10.40.205.74])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 082D1194BE;
 Fri, 18 Oct 2019 13:36:01 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/4] mc146818rtc: Move RTC_ISA_IRQ definition
Date: Fri, 18 Oct 2019 15:35:45 +0200
Message-Id: <20191018133547.10936-3-philmd@redhat.com>
In-Reply-To: <20191018133547.10936-1-philmd@redhat.com>
References: <20191018133547.10936-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Fri, 18 Oct 2019 13:36:05 +0000 (UTC)
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

The ISA default number for the RTC devices is not related to its
registers neither. Move this definition to "hw/timer/mc146818rtc.h".

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 include/hw/timer/mc146818rtc.h      | 2 ++
 include/hw/timer/mc146818rtc_regs.h | 2 --
 tests/rtc-test.c                    | 1 +
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/hw/timer/mc146818rtc.h b/include/hw/timer/mc146818rt=
c.h
index 0f1c886e5b..17761cf6d9 100644
--- a/include/hw/timer/mc146818rtc.h
+++ b/include/hw/timer/mc146818rtc.h
@@ -39,6 +39,8 @@ typedef struct RTCState {
     QLIST_ENTRY(RTCState) link;
 } RTCState;
=20
+#define RTC_ISA_IRQ 8
+
 ISADevice *mc146818_rtc_init(ISABus *bus, int base_year,
                              qemu_irq intercept_irq);
 void rtc_set_memory(ISADevice *dev, int addr, int val);
diff --git a/include/hw/timer/mc146818rtc_regs.h b/include/hw/timer/mc146=
818rtc_regs.h
index bfbb57e570..631f71cfd9 100644
--- a/include/hw/timer/mc146818rtc_regs.h
+++ b/include/hw/timer/mc146818rtc_regs.h
@@ -27,8 +27,6 @@
=20
 #include "qemu/timer.h"
=20
-#define RTC_ISA_IRQ 8
-
 #define RTC_SECONDS             0
 #define RTC_SECONDS_ALARM       1
 #define RTC_MINUTES             2
diff --git a/tests/rtc-test.c b/tests/rtc-test.c
index 6309b0ef6c..18f895690f 100644
--- a/tests/rtc-test.c
+++ b/tests/rtc-test.c
@@ -15,6 +15,7 @@
=20
 #include "libqtest-single.h"
 #include "qemu/timer.h"
+#include "hw/timer/mc146818rtc.h"
 #include "hw/timer/mc146818rtc_regs.h"
=20
 #define UIP_HOLD_LENGTH           (8 * NANOSECONDS_PER_SECOND / 32768)
--=20
2.21.0


