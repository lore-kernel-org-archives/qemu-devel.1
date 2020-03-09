Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FF76C18E5A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 15:21:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33EF42067C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 15:21:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33EF42067C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBKEA-0000KI-9P
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 11:21:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34269)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jBK3D-0000pN-BH
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 11:10:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jBK3C-0008Hk-3A
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 11:10:39 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:54773)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1jBK2w-00082l-PU; Mon, 09 Mar 2020 11:10:23 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MUokB-1ilAKi13Dt-00Qh5L; Mon, 09 Mar 2020 16:09:41 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 25/33] hw/i386/pc: Clean up includes
Date: Mon,  9 Mar 2020 16:08:29 +0100
Message-Id: <20200309150837.3193387-26-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200309150837.3193387-1-laurent@vivier.eu>
References: <20200309150837.3193387-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ELlgxbZLN6XY/sIJ9/sOXL2kw+iCrvUYX26HkdzVN63MSnFG9dR
 kiTBIj9Bjznl24O5TFF6LYx1MZpMEU4Ih6wjOLhMT5LS3ct6v+gkHtLTVMl91+SwWBtqVDq
 ypom+FRfLReSdff6zlQveYXzTENnRdqgqPC/RE7gbQJ7tk+UVrcuNNEydN/+FZpJPADbgba
 88q6b5JHmtcBgXA58rpBA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Kjo3KdQiq3M=:Lwea4OC/jBe3UKpAowpHwt
 sDVUaek9ZRP0mJkBlumXRKRQbNh9H3uKoc+kbKxOHLrHbASGhK1v7Q4jgPbftwc9esKJm5zsc
 G//XouxcRWMi0tYLPWXI7QQP8gKASbM4nejI9YAuViiZose+ijYyTb2Rg9Z8mNhdqQbl3ZXi4
 rRcaTm2ZjfilEsIYFFQfhIAC+Rw8PftbYAqpLEMeEcpgomIu8J/zaSQhZR2jpUi/yFd0cZmiU
 hlHXY6UmKkWURFiOLDqGwcE9c6nDerJSU8VKesepaSu22wQ6XdKOis6XuHna8skb/dZ8CDsNl
 VNQZSn1GnQK2MGsoSETnqPLXjKHSYzZYX/bjo2/YGBL7MV/AY+vuC1Bo4U66OGq44AZNSE64M
 weRR1JnWjF+U6BnUxWcPbvTRZVy6nNqofHwVxH3ekbbcFf9EGAL1YHA0qfbOZE8mtYZQ60NAJ
 iK6BZsDfIYbP/kWu8adnYMRJvpp0TUuMdBimW1RSzmOFaQB9kTgluPhEXry/rgQiTx3HyZGWv
 IkKuLV181txzhPNOajpPkGgWGz5aMXbCbaqdS1uhXI7uZzigCS92gRo1vz8W6y9wt0CnJSiy1
 CJJFoJqICNRlkm+yv1w1lwrOQK1dQRUJQMTwah9jud0rGW4ZHW/vPbx1E1r9vPcXlTD3QEo6G
 4xtu7GaImOxz905M6XX4xmcqj8K1R37bin0OTOUvxDNkyVrg4MXYuKmQlOofOY5btjbJKcVf3
 6kjtmC/jAW70gNmruYZ/8a38bn8pmA++gCb3HAGK1L5E/33PQQfQzp2XTiiAJGf5VGAU0YH2T
 JZosvmCkAiFqs6DHJoH5hJjP75Y3keszRJKUxvULoPnfBjsCg1W9d1CB/8LK5+z9swLMkfy
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.13
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

Various headers are not required by hw/i386/pc.h:

 - "qemu/range.h"
 - "qemu/bitmap.h"
 - "qemu/module.h"
 - "exec/memory.h"
 - "hw/pci/pci.h"
 - "hw/mem/pc-dimm.h"
 - "hw/mem/nvdimm.h"
 - "net/net.h"

Remove them.

Add 3 headers that were missing:

 - "hw/hotplug.h"

   PCMachineState::acpi_dev is of type HotplugHandler

 - "qemu/notify.h"

   PCMachineState::machine_done is of type Notifier

 - "qapi/qapi-types-common.h"

   PCMachineState::vmport/smm is of type OnOffAuto

Acked-by: John Snow <jsnow@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200228114649.12818-19-philmd@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 include/hw/i386/pc.h | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index d5ac76d54e1f..6ab6eda046fd 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -1,20 +1,15 @@
 #ifndef HW_PC_H
 #define HW_PC_H
 
-#include "exec/memory.h"
+#include "qemu/notify.h"
+#include "qapi/qapi-types-common.h"
 #include "hw/boards.h"
 #include "hw/block/fdc.h"
 #include "hw/block/flash.h"
-#include "net/net.h"
 #include "hw/i386/x86.h"
 
-#include "qemu/range.h"
-#include "qemu/bitmap.h"
-#include "qemu/module.h"
-#include "hw/pci/pci.h"
-#include "hw/mem/pc-dimm.h"
-#include "hw/mem/nvdimm.h"
 #include "hw/acpi/acpi_dev_interface.h"
+#include "hw/hotplug.h"
 
 #define HPET_INTCAP "hpet-intcap"
 
-- 
2.24.1


