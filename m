Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F93EC10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 15:17:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 575EC20578
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 15:17:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 575EC20578
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44698 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBKAG-0003hZ-DI
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 11:17:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34138)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jBK39-0000cY-3J
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 11:10:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jBK37-0008DC-QM
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 11:10:34 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:52167)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1jBK34-00089Z-PV; Mon, 09 Mar 2020 11:10:31 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MVNEv-1ijVu8455z-00SLFB; Mon, 09 Mar 2020 16:09:32 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 21/33] hw/pci-host/piix: Include "qemu/range.h"
Date: Mon,  9 Mar 2020 16:08:25 +0100
Message-Id: <20200309150837.3193387-22-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200309150837.3193387-1-laurent@vivier.eu>
References: <20200309150837.3193387-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:haYMxJVRXzVW0hYOJCRTrEMLEtH4cwttsRRYvJAL/M1lUNCla+1
 HCyndljMQ5dWOqyAn/mTV7An6tP6oGZ1qu4uY+cMOrrXs8yLQis3rKJILw0VX20Pp0liIpA
 scv0V69rv++UazF8zy7Q/i6rZcXxcPKLRhOyp/p1/tE5af8IUp8fbuqc6zBrcxXtE9QT32R
 Uh41WmmMnbrqy6QluAzfg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PG9DHECbHZw=:w6hC1i9Mr2jROOLcIYZVhU
 Cs4t4l0MQMKJe5eIxLKy//Max3kmtwFbo2xim2sLdptA0wVuY9z3MI9SmqTgTa5Jzji41KWHc
 WawZYNaPfREOZHQULjXxjlOV7rW/TjZRN4wx+4uMh+DCHIRjUwu526wn8leI9xlIGdtuzH+aY
 4H0/lgXCzfEhX8Mm40D77t78DiCOLgBjmeHa67IAh2TCkyMxQLCyKl+28bKKm99aEPwhJDhZt
 LYSGUFrZiit0TxPbzB0yprXQDUqfSNJlRVX/hqq2f2+MfYY4EohK578BlNgyRjmpW1KjwwaHB
 tGcjJLRzG9irhapv/7gTKweaRDaF1iNoDm8KlMF6cRtrUwJmyiCKgSQok0KQciBV+cq81izhr
 y0cFKvh2jb6s/BLGDtcO8h1Z9C89/sZf8ZIL7pA3ZPbkrs2RWD8hkZNOOT0lS5lpf01sdc3rP
 1uGKCI3wryWzp4Nr4QNPVZNG1tLAflEFyzkDB+JduLTl4lzcZDUfR8THuYsgoPank9eEUqvvR
 Zl0qHuHMTRo3vOeARLptMjgx99tGElPKIXE/hxLmwenGdZUSGF6TWjAkWwzQFQu7O+rxQ4el1
 g6PJYLXRfgJVW3uYKM/QR/2fFMHEpPg97efcVoNdHFSu7EXDVja4qB6flps/B5XtmI3mMMC9Y
 vynuBRDeeDeortGcRL2VoN24Bw+vsAD1bj+8Epb0ORHA4AioajzfttjCf9JscENxFkA4gwaq9
 nilCplfreNpHoB0IBt3z1ie8tY4ZEgHuFwChqZV6VW+meONWC9azV+SGiYiUbViK/HEZ6q3lD
 6k/D907N2oL0h3QgOyDrt0UzEaoJFzgnNr8F+KZH8uTKFv2XDsX1FINJelvdDkVQ1tcH8MA
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.75
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-block@nongnu.org,
 qemu-trivial@nongnu.org, Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>, Greg Kurz <groug@kaod.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Max Reitz <mreitz@redhat.com>, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Igor Mammedov <imammedo@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

hw/pci-host/piix.c calls various functions from the Range API.
Include "qemu/range.h" which declares them.

This fixes (when modifying unrelated headers):

  hw/pci-host/i440fx.c:54:11: error: field has incomplete type 'Range' (aka 'struct Range')
      Range pci_hole;
           ^
  include/qemu/typedefs.h:116:16: note: forward declaration of 'struct Range'
  typedef struct Range Range;
                 ^
  hw/pci-host/i440fx.c:126:9: error: implicit declaration of function 'ranges_overlap' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
      if (ranges_overlap(address, len, I440FX_PAM, I440FX_PAM_SIZE) ||
          ^
  hw/pci-host/i440fx.c:126:9: error: this function declaration is not a prototype [-Werror,-Wstrict-prototypes]
  hw/pci-host/i440fx.c:127:9: error: implicit declaration of function 'range_covers_byte' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
          range_covers_byte(address, len, I440FX_SMRAM)) {
          ^
  hw/pci-host/i440fx.c:127:9: error: this function declaration is not a prototype [-Werror,-Wstrict-prototypes]
  hw/pci-host/i440fx.c:189:13: error: implicit declaration of function 'range_is_empty' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
      val64 = range_is_empty(&s->pci_hole) ? 0 : range_lob(&s->pci_hole);
              ^

Acked-by: John Snow <jsnow@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200228114649.12818-15-philmd@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/pci-host/i440fx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/pci-host/i440fx.c b/hw/pci-host/i440fx.c
index 11050a0f8bb9..d980c9704906 100644
--- a/hw/pci-host/i440fx.c
+++ b/hw/pci-host/i440fx.c
@@ -23,6 +23,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/range.h"
 #include "hw/i386/pc.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_host.h"
-- 
2.24.1


