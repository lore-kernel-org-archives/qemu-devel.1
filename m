Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB2EDC43219
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 17:28:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 744112075E
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 17:28:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kG1MXo4S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 744112075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60987 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLA54-0003DP-O6
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 13:28:42 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34429)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL9et-0004uX-AG
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:01:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL9er-0006mr-OU
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:01:39 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:40485)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hL9eq-0006fx-6N
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:01:36 -0400
Received: by mail-wr1-x42e.google.com with SMTP id h4so17116702wre.7
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 10:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=dtay1t/8F0wroE/4gRl+DMjWaRAg1S7IMqSKkwsLaCo=;
	b=kG1MXo4S3I1ItrI3uyPt/Hj6W21N7HbTD9J7HHhFeC0tBAcCvNsImuMAmnETWXcwfQ
	oCmjxudfPApUFH1g3pv5o2PfaWJKwQJZIn8UXg2eckn+aLFWgNqUc3jmIwB3vs1REqWI
	gcPykMS2Vw9HoGbdSY/QSWthnl2d7IirC3riEeuvcpAYJ/HI3bmXym4c8CQLxfc7gp/P
	6i/gI34DAElDG/P2n0zXoZOebsZPCPCLhsIVParDdqHrvuXvswxhdZVwLqeaiQQEU7pA
	cyYZxEnJLhsqhs21gxTeoDCdcsJyn+EG5j4gzwVhpJHpDiPhix0qMJ+Fu0GtiYNPfCCl
	G6Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=dtay1t/8F0wroE/4gRl+DMjWaRAg1S7IMqSKkwsLaCo=;
	b=Vfw8EjJxT13n09CTHnA3F+vSUR5SDmac1TsoyjeGAeAVwxn8e1o58m0RY6Rhsx/AfY
	kXEIGv21IE/BL4y27uaAnxNLPJGCoOVSD/6yPpV4CkKWBmDHm66DTcrvzqc+splrPBNf
	NxLvj9RIpNF8ad9TWpWejXEVUnwSHToTtKJkWZhd2IAfARrTA4xcj6C+mkoRWWuQYT8b
	z8eTEg8l2SxjJy5P3WyI78jGAj78ZUMAjgdo+rWR5MDxb2Bba7yZaTr4Cp2wFGl1UpHx
	j4PrHZLkuLfb9+Rqb1lIgf/x1lLRLEQgj8CBKIWYUf0j2DIZAOyZ+oOlSWVag8+rk3Pf
	DI8Q==
X-Gm-Message-State: APjAAAUloQhlhsrsameaoBQQFvNvJRfVKYBkiLu4ZICf5RCO+DByoCe7
	4Wh0+DoyDrEUAxKpNyJJC8y5xS0/iw4=
X-Google-Smtp-Source: APXvYqxL0dUPCywfeqB1pvGKiX0JjqbiYDcPGNmoDgbMFGWFIKSkGYPAjRWiwl6VEKXMhQzeGNrq+g==
X-Received: by 2002:adf:f14e:: with SMTP id y14mr25310800wro.276.1556557285145;
	Mon, 29 Apr 2019 10:01:25 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id a13sm36896wmj.39.2019.04.29.10.01.23
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 29 Apr 2019 10:01:24 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 29 Apr 2019 18:00:29 +0100
Message-Id: <20190429170030.11323-42-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190429170030.11323-1-peter.maydell@linaro.org>
References: <20190429170030.11323-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::42e
Subject: [Qemu-devel] [PULL 41/42] hw/net/lan9118: Export TYPE_LAN9118 and
 use it instead of hardcoded string
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190429170029.7_Mn30_FAefTYKRFdhYdCJLjRCRON-2_byS2G8_cEYU@z>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20190412165416.7977-12-philmd@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/net/lan9118.h | 2 ++
 hw/arm/exynos4_boards.c  | 3 ++-
 hw/arm/mps2-tz.c         | 3 ++-
 hw/net/lan9118.c         | 1 -
 4 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/include/hw/net/lan9118.h b/include/hw/net/lan9118.h
index d13d8cd3d22..500acb4c143 100644
--- a/include/hw/net/lan9118.h
+++ b/include/hw/net/lan9118.h
@@ -14,6 +14,8 @@
 #include "hw/irq.h"
 #include "net/net.h"
 
+#define TYPE_LAN9118 "lan9118"
+
 void lan9118_init(NICInfo *, uint32_t, qemu_irq);
 
 #endif
diff --git a/hw/arm/exynos4_boards.c b/hw/arm/exynos4_boards.c
index 750162cc95a..ea8100f65a8 100644
--- a/hw/arm/exynos4_boards.c
+++ b/hw/arm/exynos4_boards.c
@@ -32,6 +32,7 @@
 #include "hw/arm/arm.h"
 #include "exec/address-spaces.h"
 #include "hw/arm/exynos4210.h"
+#include "hw/net/lan9118.h"
 #include "hw/boards.h"
 
 #undef DEBUG
@@ -92,7 +93,7 @@ static void lan9215_init(uint32_t base, qemu_irq irq)
     /* This should be a 9215 but the 9118 is close enough */
     if (nd_table[0].used) {
         qemu_check_nic_model(&nd_table[0], "lan9118");
-        dev = qdev_create(NULL, "lan9118");
+        dev = qdev_create(NULL, TYPE_LAN9118);
         qdev_set_nic_properties(dev, &nd_table[0]);
         qdev_prop_set_uint32(dev, "mode_16bit", 1);
         qdev_init_nofail(dev);
diff --git a/hw/arm/mps2-tz.c b/hw/arm/mps2-tz.c
index f79f090a4ac..7832408bb70 100644
--- a/hw/arm/mps2-tz.c
+++ b/hw/arm/mps2-tz.c
@@ -56,6 +56,7 @@
 #include "hw/arm/armsse.h"
 #include "hw/dma/pl080.h"
 #include "hw/ssi/pl022.h"
+#include "hw/net/lan9118.h"
 #include "net/net.h"
 #include "hw/core/split-irq.h"
 
@@ -244,7 +245,7 @@ static MemoryRegion *make_eth_dev(MPS2TZMachineState *mms, void *opaque,
      * except that it doesn't support the checksum-offload feature.
      */
     qemu_check_nic_model(nd, "lan9118");
-    mms->lan9118 = qdev_create(NULL, "lan9118");
+    mms->lan9118 = qdev_create(NULL, TYPE_LAN9118);
     qdev_set_nic_properties(mms->lan9118, nd);
     qdev_init_nofail(mms->lan9118);
 
diff --git a/hw/net/lan9118.c b/hw/net/lan9118.c
index a428b16eda5..b29e3fee49f 100644
--- a/hw/net/lan9118.c
+++ b/hw/net/lan9118.c
@@ -175,7 +175,6 @@ static const VMStateDescription vmstate_lan9118_packet = {
     }
 };
 
-#define TYPE_LAN9118 "lan9118"
 #define LAN9118(obj) OBJECT_CHECK(lan9118_state, (obj), TYPE_LAN9118)
 
 typedef struct {
-- 
2.20.1


