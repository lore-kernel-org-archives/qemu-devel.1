Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40407CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 13:37:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14B18222C2
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 13:37:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14B18222C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLSRh-00006S-Sg
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 09:37:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52905)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iLSQY-0007Du-Cp
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 09:36:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iLSQU-0007i2-TU
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 09:36:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44240)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iLSQR-0007fY-Fk
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 09:36:16 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 31AB446671;
 Fri, 18 Oct 2019 13:36:13 +0000 (UTC)
Received: from x1w.redhat.com (unknown [10.40.205.74])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7AF34194BE;
 Fri, 18 Oct 2019 13:36:05 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/4] mc146818rtc: Include mc146818rtc_regs.h directly in
 mc146818rtc.c
Date: Fri, 18 Oct 2019 15:35:46 +0200
Message-Id: <20191018133547.10936-4-philmd@redhat.com>
In-Reply-To: <20191018133547.10936-1-philmd@redhat.com>
References: <20191018133547.10936-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Fri, 18 Oct 2019 13:36:13 +0000 (UTC)
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

Devices/boards wanting to use the MC146818 RTC don't need
the knowledge its internal registers. Move the "mc146818rtc_regs.h"
inclusion to mc146818rtc.c where it is required.

We can not move this file from include/hw/timer/ to hw/timer/ for
local inclusion because the ACPI FADT table use the RTC_CENTURY
register address.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/timer/mc146818rtc.c         | 1 +
 include/hw/timer/mc146818rtc.h | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/timer/mc146818rtc.c b/hw/timer/mc146818rtc.c
index e40b54e743..0c04b74c2e 100644
--- a/hw/timer/mc146818rtc.c
+++ b/hw/timer/mc146818rtc.c
@@ -41,6 +41,7 @@
 #include "qapi/qapi-events-misc-target.h"
 #include "qapi/visitor.h"
 #include "exec/address-spaces.h"
+#include "hw/timer/mc146818rtc_regs.h"
=20
 #ifdef TARGET_I386
 #include "hw/i386/apic.h"
diff --git a/include/hw/timer/mc146818rtc.h b/include/hw/timer/mc146818rt=
c.h
index 17761cf6d9..a857dcdc69 100644
--- a/include/hw/timer/mc146818rtc.h
+++ b/include/hw/timer/mc146818rtc.h
@@ -5,7 +5,6 @@
 #include "qemu/queue.h"
 #include "qemu/timer.h"
 #include "hw/isa/isa.h"
-#include "hw/timer/mc146818rtc_regs.h"
=20
 #define TYPE_MC146818_RTC "mc146818rtc"
 #define MC146818_RTC(obj) OBJECT_CHECK(RTCState, (obj), TYPE_MC146818_RT=
C)
--=20
2.21.0


