Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E4AAC2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 16:08:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF53A206F0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 16:08:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="Cn9rPD9h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF53A206F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47352 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iw6wB-0004Xj-3k
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 11:08:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55273)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yuri.benditovich@daynix.com>) id 1iw6rC-0000Gi-FA
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 11:03:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yuri.benditovich@daynix.com>) id 1iw6rB-00005b-Bi
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 11:03:22 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:39430)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <yuri.benditovich@daynix.com>)
 id 1iw6rB-00005B-1O
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 11:03:21 -0500
Received: by mail-wr1-x444.google.com with SMTP id y11so11984846wrt.6
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2020 08:03:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id;
 bh=AIWtQBvIG6Lr4Ru2WkatZ9cwdRhOTo31fuXr+snCDZI=;
 b=Cn9rPD9h1owjIAnoXorZwUk9leD1DOl8+bckgAVPTLXo7hNSYcngASblPQU6yg+FrD
 JzMVV1bYRBwHhGOSS/PbxbqdWaVcYtqRUtBaqUQMDoLJBQZS7CL1R1t4YfIf5nNbgh8e
 BEw4ZncYsREGmoPevCXtZN48MQsV7Zo+odcwy4RcFY6XfQ9Et5U5B60IxsIl2pNdf3Vn
 NiKJ6wmoe2zAx9ZzVAO2TdcqLpcwx0MLe0gc453uC+myPbCY+cuOxGIdzqqctIEYvBLL
 64p4/IYUMCdWP+YUEbKg4AacgWCMmGai/w+22vBR1C7ZSRmNTm0FD65kJvYPxwLFWTlc
 vuFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=AIWtQBvIG6Lr4Ru2WkatZ9cwdRhOTo31fuXr+snCDZI=;
 b=bkNXpS51v3ss8XPuLrBgGohO4mdo7cKYKey/z60tivz3DBDe9kgdHt1lobLVLjfS+Q
 dy6GpGBJbkaUsVnQaIpZnNmwZyXv11HTqD0agSxHyv7jyKFcSmBIoQG1GYi/anODI3D2
 3XszchP/bN0odWlIbxyYhkEUdaBZeHNOcMFsIVCJoofuiPxFi7jOKVUPeERmGcT7EBfo
 YcsN1+zShA7V7H+r7qtKWhsTL4mUrdFO9FjzzH4Ul+Se/w7Z4TnFVmeoaA7q+pYuS1E0
 Sp5CjalzZA1YcW4t0qBVQ2uq1C15gM0uv7jxsrmSXHeNZAh1KAC3H19oBYIwaqW6ipab
 k3Sg==
X-Gm-Message-State: APjAAAXYdZXCfVugDGVPtowrUoFXJ+CPkbYdNL8UvRHJzQ3J0kRfCEhX
 sTkx1iIAYfjVnLcOUtJQml7jHw==
X-Google-Smtp-Source: APXvYqxIvdX/a2dKldyy9qpr8Gq0V0VTfA14Qh7lZoOH+CehGuHU0Mc4wR5DrdedvcRGagCwwJh23A==
X-Received: by 2002:adf:eb8e:: with SMTP id t14mr22297089wrn.384.1580140999839; 
 Mon, 27 Jan 2020 08:03:19 -0800 (PST)
Received: from f2.redhat.com (bzq-79-177-42-131.red.bezeqint.net.
 [79.177.42.131])
 by smtp.gmail.com with ESMTPSA id q6sm23201735wrx.72.2020.01.27.08.03.18
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 27 Jan 2020 08:03:19 -0800 (PST)
From: Yuri Benditovich <yuri.benditovich@daynix.com>
To: dmitry.fleytman@gmail.com,
	jasowang@redhat.com,
	qemu-devel@nongnu.org
Subject: [PATCH] e1000e: Avoid hw_error if legacy mode used
Date: Mon, 27 Jan 2020 18:03:12 +0200
Message-Id: <20200127160312.31367-1-yuri.benditovich@daynix.com>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: yan@daynix.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

https://bugzilla.redhat.com/show_bug.cgi?id=1787142
The emulation issues hw_error if PSRCTL register
is written, for example, with zero value.
Such configuration does not present any problem when
DTYP bits of RCTL register define legacy format of
transfer descriptors. Current commit discards check
for BSIZE0 and BSIZE1 when legacy mode used.

Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
---
 hw/net/e1000e_core.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
index 5b05c8ea8a..94ea34dca5 100644
--- a/hw/net/e1000e_core.c
+++ b/hw/net/e1000e_core.c
@@ -2813,12 +2813,15 @@ e1000e_set_eitr(E1000ECore *core, int index, uint32_t val)
 static void
 e1000e_set_psrctl(E1000ECore *core, int index, uint32_t val)
 {
-    if ((val & E1000_PSRCTL_BSIZE0_MASK) == 0) {
-        hw_error("e1000e: PSRCTL.BSIZE0 cannot be zero");
-    }
+    if (core->mac[RCTL] & E1000_RCTL_DTYP_MASK) {
+
+        if ((val & E1000_PSRCTL_BSIZE0_MASK) == 0) {
+            hw_error("e1000e: PSRCTL.BSIZE0 cannot be zero");
+        }
 
-    if ((val & E1000_PSRCTL_BSIZE1_MASK) == 0) {
-        hw_error("e1000e: PSRCTL.BSIZE1 cannot be zero");
+        if ((val & E1000_PSRCTL_BSIZE1_MASK) == 0) {
+            hw_error("e1000e: PSRCTL.BSIZE1 cannot be zero");
+        }
     }
 
     core->mac[PSRCTL] = val;
-- 
2.17.1


