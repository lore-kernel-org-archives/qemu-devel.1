Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 393E0C10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 15:28:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CB212067C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 15:28:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CB212067C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBKKc-0001w1-7r
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 11:28:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33570)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jBK2c-0008Ct-Eq
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 11:10:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jBK2b-0007qI-E0
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 11:10:02 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:55201)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1jBK2Y-0007lh-OO; Mon, 09 Mar 2020 11:09:58 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1Moex5-1jik6Y1NUX-00p5hP; Mon, 09 Mar 2020 16:09:27 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 19/33] hw/pci-host/q35: Include "qemu/range.h"
Date: Mon,  9 Mar 2020 16:08:23 +0100
Message-Id: <20200309150837.3193387-20-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200309150837.3193387-1-laurent@vivier.eu>
References: <20200309150837.3193387-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:bDf+R+TkyUWaYGGT4Rw8RwyZQRZFhUKc76uXRlzIYLOjqGHIbry
 aog87OGgxYXkb+GEk5vws7NgiRPu1/0Mfrbe6ahc7llLY5adLC4PB4xZuTgedJltIOK+rvv
 IjhMmrsrT2wIZV8hhvJri1k4E/nTqlJhEM+7qhjpyrZDy8wcOPKeNYts9nnN75fx86dzqmi
 cIwCWwzsT6mUNUSmTgnIQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:oTF7Y6BYuTM=:m0dC/7n1v0qsJFRdheP0yz
 O9X7FXs1T6jt4MUX38OC3mqAv+flzFusYESDYhH80Gxs/e7wYwmJ2G0vzk5WPIUSO2eqvikhV
 BlNauqZH4g3r/MzkBdh6kl+qeEAQUBv9VZblVNZYYMgjCncCPiVKxqpuFNumUysRqeHGzKg6W
 ILaP80lK5KXW8qahodoA0MzX5RASYlkf9wH/xnvMx0tNkX9AhGNbPl1z3BnndgTD2NCGs0LOB
 qBLEO2lHpSB7Xivc2udzA+TTW/gt3Fi55YPpUspM8hq/wsJ3pjRITIvDxb81l0/S0n9F1rRaS
 6NyC1kW6c49RtlXfprpEr9lPaaKKd3hmD3Tcor63GMAfSjmm1LpjE3fg8XoLoN/7HidYFCreH
 jVei8qZFWpzcEhMKcnMv1MRgpPQoRUv/cWjaImH5RGrQGWT7com7Xh7bMa6LAnCOO5+2vbc95
 Mm3Ki5dCbLZfUey9NU/VCz+opifeQBtzuPADxsYL8qT/E3Do7KPh97+Mw6NB8BNE9qOFuTUvK
 J+WNn1deRQVwKIjcVg4508Y4YSvinC4yMgCsQZxwjTEFfFK/bbo1yPOMn4r7h1kgrfTAuD9w7
 pxbQuxPDBGT5hIKB0LlHLR0odXDixhpOrW2qsb4hgBxO2ATN/F+j7xi1yGZGh1U88ZF4/4wvL
 CwX1vj2LyO8azMHF8NgzrJSlqCf/t7SndWOSBLwvZj90vz0rErkJFBf9HjAeoAQAEkXMFG68Z
 CcUMmm+v3wm7bPZvXH/ADBjpOrrUZawuoA8flQg+tkPcd6uW0ZlY7cpXKVvR8hCfMjyTeVl+k
 TdI2MNk3KYAdxcmgBpQRw0pmqp3rAivVMgLc/gHEWMswTuvahh31DAHLSWS4NuzO/XJWYXx
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.74
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

The MCHPCIState structure uses the Range type which is declared in
"qemu/range.h". Include it.

This fixes (when modifying unrelated headers):

  In file included from hw/pci-host/q35.c:32:
  include/hw/pci-host/q35.h:57:11: error: field has incomplete type 'Range' (aka 'struct Range')
      Range pci_hole;
            ^
  include/qemu/typedefs.h:116:16: note: forward declaration of 'struct Range'
  typedef struct Range Range;
                 ^

Acked-by: John Snow <jsnow@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200228114649.12818-13-philmd@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 include/hw/pci-host/q35.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/hw/pci-host/q35.h b/include/hw/pci-host/q35.h
index 976fbae5996b..47086c645e9f 100644
--- a/include/hw/pci-host/q35.h
+++ b/include/hw/pci-host/q35.h
@@ -33,6 +33,7 @@
 #include "hw/pci-host/pam.h"
 #include "hw/i386/intel_iommu.h"
 #include "qemu/units.h"
+#include "qemu/range.h"
 
 #define TYPE_Q35_HOST_DEVICE "q35-pcihost"
 #define Q35_HOST_DEVICE(obj) \
-- 
2.24.1


