Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97881C10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 15:15:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E6E020873
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 15:15:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E6E020873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44648 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBK8B-0000gs-Go
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 11:15:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33460)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jBK2Y-000834-BT
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 11:09:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jBK2X-0007kn-6w
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 11:09:58 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:37407)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1jBK2W-0007jm-SS; Mon, 09 Mar 2020 11:09:57 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1McH1O-1jlkF31NLY-00clTu; Mon, 09 Mar 2020 16:09:13 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 13/33] hw/i386/intel_iommu: Remove unused includes
Date: Mon,  9 Mar 2020 16:08:17 +0100
Message-Id: <20200309150837.3193387-14-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200309150837.3193387-1-laurent@vivier.eu>
References: <20200309150837.3193387-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:hUNOQQrwqIsLR/pdizzKGBHcH3bkdrISqVe8Mw7EHPQIxgV+Aim
 DbHw3T2O7tbiVWMBey5GeCJKbut/UJAlziDIRecGpxRzQBMrFA3E9e1zKyLI+scUOkr55hL
 o/phW9FOnB/RwrQLHhMj9TAl38RfV9YGJpzZBqHLPP+Mt58PrNKsW+8GzcSVHrw83R5dikh
 EB+MWnisgL5Wde/ZRujIg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pdg3X9/wsbQ=:5cLZxw/XnD0ZGQtnIzD3y6
 PwhEQ01lY8lffq8X8YSHEp0Gj3kSF+lldTXTlqePUQSY4Lc7oNmKB78jrc9xNI5Yhq5YCYLrX
 ghz/xwFqbCZ6M2l8Qp4xP/sjLOtO/c6vKVP28MIZoWMuDkLhX8NXtmB9b+9W4Z9V2h7FdhuOd
 xbRlfZavaYjlaUhADICdBGDuQS2Kmx9ptR+/GUI6Q4xMqSSiKPt+3eFJbjGv9cY1C2RHH6g9D
 1kPyPU2dQsOtcFlKE4NfhNCkLvYY00fKIWicRBNGJDWGAcIFypEeFwHd67ijN7j82pXUJ+I2Y
 stVTi4aZDq1isRIIxQ3WApPrGVvsRAzOLratOfB/LsoDavZGrffZfeksfwQDzqYHw4Mk09utw
 MGo97jUiEJtpzwZCQEUdydAt2JZ4kCksRsXVMYPy1HnR5nEhWQ5NBZUOR/2/M4dUpGcIMp/cW
 kqWieiTutEZ8Ygnq/ruH44AiaDi5d3OO8yxsPEnCqGKAiKrTD3HoPeKXcm+J3Ifjkiiw8NADu
 65FsvRTR1xv0LUHTHxwC5ZiGifaWhlkJk0VAkSpK1yRPBhAQHW2y9sChZmTKJ85HPM3sWEBPJ
 vNDXfWMohz4aUhI/DGmqrdot228lK8EnB1yO/58XPrPKEhgJWDKabx/VuWgAgFVHkiIpfk6LZ
 Tm2VqmTRcSN2nbUjNv5M03nozAKKp4VoeoUe8ASJ0zsiNoDxtnEusaEXoqowUQcyvx9UVopPP
 QJkfY1BU9TqmyBvqZq0FtgAML1FwfFPnGlu8swnAROzqCWg1IDxdieCo9+XrDjUSyp7299f89
 lgh9Az1KsvdnEG/+jaLD/kQb8UbeJYVRZk7XfdcVqSp8dcvPwELQM9tZ0RtPq6x1n8E+7qU
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

intel_iommu.h does not use any of these includes, remove them.

Acked-by: John Snow <jsnow@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200228114649.12818-7-philmd@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 include/hw/i386/intel_iommu.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
index 66b931e52628..a1c4afcda5c9 100644
--- a/include/hw/i386/intel_iommu.h
+++ b/include/hw/i386/intel_iommu.h
@@ -22,11 +22,7 @@
 #ifndef INTEL_IOMMU_H
 #define INTEL_IOMMU_H
 
-#include "sysemu/dma.h"
 #include "hw/i386/x86-iommu.h"
-#include "hw/i386/ioapic.h"
-#include "hw/pci/msi.h"
-#include "hw/sysbus.h"
 #include "qemu/iova-tree.h"
 
 #define TYPE_INTEL_IOMMU_DEVICE "intel-iommu"
-- 
2.24.1


