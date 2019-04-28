Return-Path: <SRS0=GiFh=S6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8577BC43219
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Apr 2019 11:19:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C8B0206C1
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Apr 2019 11:19:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=connect-hku-hk.20150623.gappssmtp.com header.i=@connect-hku-hk.20150623.gappssmtp.com header.b="tY7SWKCG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C8B0206C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=connect.hku.hk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42788 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hKhpp-0003dK-8c
	for qemu-devel@archiver.kernel.org; Sun, 28 Apr 2019 07:19:05 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60791)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liboxuan@connect.hku.hk>) id 1hKhp0-0003AA-Ok
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 07:18:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liboxuan@connect.hku.hk>) id 1hKhc1-00021B-CY
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 07:04:50 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:33662)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liboxuan@connect.hku.hk>)
	id 1hKhc0-0001yN-Ra
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 07:04:49 -0400
Received: by mail-pl1-x644.google.com with SMTP id y3so2873739plp.0
	for <qemu-devel@nongnu.org>; Sun, 28 Apr 2019 04:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=connect-hku-hk.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id;
	bh=AMRBSKPedQ/vao53wTQts4yAXAMhd5iduqdqKtH2vi0=;
	b=tY7SWKCGI4nvwv6XBmywg/wziBked8W6bZJgiVPY7BcbwdXPIXlunxLbAR6Rgeg2Hu
	/g5lwBZ5LuJMeDriIG5KDDxVzcMKl5y7q5kpb2+bmbP/w51fj3T4Tdzz+yLkBuqJ0Uv7
	IEO48cTIa+j2GcztWsmGtoYShuGK4nKSrEMkTTlhfXfc5xvoJ4moW0DTP0tvuH0JZXzn
	gW5JXLmuqDL9iQJ7w61NnmU3UF3+a51+BzQA0bnXLDVtTOQ56S8n/rqYFIYD2SCiqXAY
	J1WdgSaiQMmtdeoL00WcyoLrd1by+99azT+BtUYS3RANdAmhhBQUgJWwipxiiH/EXFbY
	n1xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=AMRBSKPedQ/vao53wTQts4yAXAMhd5iduqdqKtH2vi0=;
	b=OuK1UyKqSQl2yffy6LvzEP9SYXFG6u20iUb5VY7hig1GQ9KIv+dKJj8GY7+AGakusA
	yEES/235je5vWO3SB/4m22clkEGu1ZCfQGS/LOyRq7CeVxhZMAMY/7ydh69TfEXw+L7y
	ukzYuWeQQwCdn8zFlpDpwRoUeq1UX5mU1sASheosm24dp1PnmQ1BLeosEyBpHkhV9dDv
	i7dTwH0OWbZijA/Ot1kBFtkqbwTwdHYQYwWCrYeE6hIUCC4AoKjqewWmGSKzbNk1W68r
	5SX9vIA1/xAfbCiQdtgcdD/uxfKlqnKZen2Ijrm5Lwtl3KId9rKPZsWrpjJZiofY/OEY
	/vJw==
X-Gm-Message-State: APjAAAXYF4ePs6njp0mjvr/pWz3mjxajs1OOQPFDuH4nE7fvZoQrDkJH
	j6x6oalvUxvHMLTGWcSViyqS4uwhEZA=
X-Google-Smtp-Source: APXvYqw4nsWImWPBjHXMzmzoyQbEjYkogFsZ8Z5CltAI6PYZmzgwB+NEgg5vTx555ohOmb8+VWUeXA==
X-Received: by 2002:a17:902:e793:: with SMTP id
	cp19mr50673035plb.65.1556449485991; 
	Sun, 28 Apr 2019 04:04:45 -0700 (PDT)
Received: from MBP.local.hk ([202.189.108.96])
	by smtp.gmail.com with ESMTPSA id
	s198sm18386461pfs.34.2019.04.28.04.04.44
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Sun, 28 Apr 2019 04:04:45 -0700 (PDT)
From: Boxuan Li <liboxuan@connect.hku.hk>
To: qemu-devel@nongnu.org
Date: Sun, 28 Apr 2019 19:02:58 +0800
Message-Id: <20190428110258.86681-1-liboxuan@connect.hku.hk>
X-Mailer: git-send-email 2.13.2
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::644
Subject: [Qemu-devel] [PATCH] virtio-mmio: Always compile debug prints
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-trivial@nongnu.org, Boxuan Li <liboxuan@connect.hku.hk>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190428110258.ky3XbSHCFq6pVcYdC3gqibW2r8x5fCHpo1R33HvsYmo@z>

Wrap printf calls inside debug macros (DPRINTF) in `if` statement, and
change output to stderr as well. This will ensure that printf function
will always compile and prevent bitrot of the format strings.

Signed-off-by: Boxuan Li <liboxuan@connect.hku.hk>
---
 hw/virtio/virtio-mmio.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/hw/virtio/virtio-mmio.c b/hw/virtio/virtio-mmio.c
index 5807aa87fe..693b3c9eb4 100644
--- a/hw/virtio/virtio-mmio.c
+++ b/hw/virtio/virtio-mmio.c
@@ -28,15 +28,14 @@
 #include "hw/virtio/virtio-bus.h"
 #include "qemu/error-report.h"
 
-/* #define DEBUG_VIRTIO_MMIO */
-
-#ifdef DEBUG_VIRTIO_MMIO
-
-#define DPRINTF(fmt, ...) \
-do { printf("virtio_mmio: " fmt , ## __VA_ARGS__); } while (0)
-#else
-#define DPRINTF(fmt, ...) do {} while (0)
-#endif
+#define DEBUG_VIRTIO_MMIO 0
+
+#define DPRINTF(fmt, ...)                                            \
+    do {                                                             \
+        if (DEBUG_VIRTIO_MMIO) {                                     \
+            fprintf(stderr, "virtio_mmio: " fmt , ## __VA_ARGS__);   \
+        }                                                            \
+    } while (0)
 
 /* QOM macros */
 /* virtio-mmio-bus */
-- 
2.13.2


