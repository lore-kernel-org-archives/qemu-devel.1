Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D32BAC10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 15:25:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9EDC2067C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 15:25:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9EDC2067C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBKHF-0004SM-Pm
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 11:25:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34237)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jBK3C-0000mD-5B
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 11:10:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jBK3A-0008G6-W7
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 11:10:38 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:43417)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1jBK2x-00084l-V5; Mon, 09 Mar 2020 11:10:24 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MsYzF-1jUuUL3qrz-00u1cL; Mon, 09 Mar 2020 16:09:39 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 24/33] hw/pci-host/q35: Remove unused includes
Date: Mon,  9 Mar 2020 16:08:28 +0100
Message-Id: <20200309150837.3193387-25-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200309150837.3193387-1-laurent@vivier.eu>
References: <20200309150837.3193387-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:cqGUVqFz0+KF0LRi5VIcZbqyx9M9UPXIN5Kzt7Yg9my36JVWn+c
 3xKXP80eZcQkj68NSZTcOVQ30pZZ//ES7vNkf9sRCEMaboosQE6zsxUEGnifBI/WW9UmHBn
 /YiJBDWEXx7tF9Y9o2aYz+o5Xj9VNWjFaOtdQdMdYtatk9rocHb3tUsU5c/EvXgwAWgUsKm
 VcJFJprz7zRHUZ8+x5Wqw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:AbVoaywEwjI=:qChUKr5HtGVoYie9+YZsVx
 Fpz+LcsOPQEqq4wUTLn4dq+W8yIbgMW/lsg19TnlJ5Hh+6vElXi6rD+7Xccm8DeFpM4/z51pU
 ZPufQ29RR4rfyQk/bfyF/Ul47avG078JjTFuC58vEqA35agdzhomSjRPySYl9mJVVKPgOvxV8
 5lQ+mUcdyiUmUBczZVuKUVDfJTNJca31HmQ59EUPAryaj27yohW6LSG5H7gCg2yBHn4WmGGsW
 j3JjwXijJ5J+80A2f0tiY9O+622r7BH5bin0gJtUI7HDUBRbQrP+/dw6b3FXCYUaLomWW1bKO
 +FqwvO9fc6D9G+VSWwEGztLnlv0/o6XCK1+OIHA/GHfomIjOXwGrYSUL7Mui2F6Rg2OD3iwFj
 zu/LlNVyK+SgExF3STssCpUpQxLv/NMvT3lMU93VRcmmZKPDpc/ga4/iBOP4gh4E7o2oPl2yp
 VEtX7lP4DqZSSztsRVEsoRJfA7ZI9GcPympQ0WuLie1/9+CuiRYsfBHuaF5eoIfeG64bgINBy
 6HAIo8x1zGWrV3o0FYEeTBHlS4s+iMKoJAzDNfZG8IIt5yBYvKhdDGwQBZW5szQB/VLajbjh7
 wN7UUc/qHIyT8rSFDtcH2Zw7vCbEF84sHJqJ6MxXiODvkLGh7XNLHSFI8GNJJyTuU6HM2kM9T
 rFMmKHfv0hcwzcKj/UlrLOaW+X6+Vi0OTWhIZIc8/eZWjOW5+nx7c3OFpQkeXfMGv774+Qvvm
 qH6ThHfLlEk/6l7gsUZZwtfrkGF5iWJ6QoxmB8VACN1SpxLykGC0RjWTTH7f7tZtf6GwVS0j/
 4iQyfVYZEaYKPWRvj05xB5FJCzyAzFAkNW5StpNg9ZY4O/SsrOcA1ASxqJ5N0DDPf+BYlj/
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.24
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

Only q35.c requires declarations from "hw/i386/pc.h", move it there.
Remove all the includes not used by "q35.h".

Acked-by: John Snow <jsnow@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200228114649.12818-18-philmd@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/pci-host/q35.c         | 1 +
 include/hw/pci-host/q35.h | 7 -------
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
index a9b9ccc87657..993f467668dc 100644
--- a/hw/pci-host/q35.c
+++ b/hw/pci-host/q35.c
@@ -29,6 +29,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "hw/i386/pc.h"
 #include "hw/pci-host/q35.h"
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
diff --git a/include/hw/pci-host/q35.h b/include/hw/pci-host/q35.h
index 47086c645e9f..070305f83dfd 100644
--- a/include/hw/pci-host/q35.h
+++ b/include/hw/pci-host/q35.h
@@ -22,16 +22,9 @@
 #ifndef HW_Q35_H
 #define HW_Q35_H
 
-#include "hw/isa/isa.h"
-#include "hw/sysbus.h"
-#include "hw/i386/pc.h"
-#include "hw/isa/apm.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/pcie_host.h"
-#include "hw/acpi/acpi.h"
-#include "hw/acpi/ich9.h"
 #include "hw/pci-host/pam.h"
-#include "hw/i386/intel_iommu.h"
 #include "qemu/units.h"
 #include "qemu/range.h"
 
-- 
2.24.1


