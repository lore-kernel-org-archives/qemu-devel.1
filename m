Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8D32C4CECD
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 17:25:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0EE220862
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 17:25:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0EE220862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48858 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAHE3-0006n7-VQ
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 13:25:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51904)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dan.streetman@canonical.com>) id 1iAHDO-0006O4-25
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 13:24:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dan.streetman@canonical.com>) id 1iAHDN-0001Xp-4G
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 13:24:33 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:59352)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dan.streetman@canonical.com>)
 id 1iAHDM-0001Vz-Vf
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 13:24:33 -0400
Received: from mail-yw1-f72.google.com ([209.85.161.72])
 by youngberry.canonical.com with esmtps
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <dan.streetman@canonical.com>) id 1iAHDL-00081n-6i
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 17:24:31 +0000
Received: by mail-yw1-f72.google.com with SMTP id n3so3248630ywh.11
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2019 10:24:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=GxZTLv6z+trL7A8JZcUcwFRrpOQeNJa9PCTY8H3Bizs=;
 b=K4r7aQ4Kp+EqvK/GIumALssWYi571kOf+NQAh9oKyZENY3AZeXJAW6fpZYmExOsDIu
 ouOpiQwdjNtu7bWL4gjEDGJIDH1VNq9V2AGc+TZ4za5QNFQhnZHpHw/HaKFXRyBC4yKX
 LF0ppPcpnNS+mot/vVbvMtOQyZy685XfHrFdYzO1tp69xP5iM12BPz6+BURtnlODLrrr
 XilXXPtm6xj9L/UvDyw96SL2AFq4bEhsQ9Qd1VodduWmhJOal/cABOl30NSJ43cWis7i
 KtC7DTEgK5dKDDUp7E0x55aJfivR7L184d86jGVr2PdSwBpeqOzeg7Dfhk9fyrGxEU3s
 RsIQ==
X-Gm-Message-State: APjAAAU4OYM7f1e0GzODT5PSHAF32wrO84SpRsgbC6pgDA5r2cHQKOyK
 O5rQkVjHQXodLlx7Meg6YPX7Y5yvfmWYbfkQ9ZIF82DziGb1gWZj2ZQCN0ZZrA41biOX4vJJJbU
 dycyvL+DGz8sKwsWoyPBq+oiyFoTYqhDI
X-Received: by 2002:a81:3d07:: with SMTP id k7mr3368374ywa.188.1568741070202; 
 Tue, 17 Sep 2019 10:24:30 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyLpFZngo0oNHC/SFkx3d356Dlu6ujNC8IG9A31pjleePedT4eiKzfM8mw5TlcJyoGRI8uJrw==
X-Received: by 2002:a81:3d07:: with SMTP id k7mr3368353ywa.188.1568741069678; 
 Tue, 17 Sep 2019 10:24:29 -0700 (PDT)
Received: from thorin.lan (45-27-90-188.lightspeed.rlghnc.sbcglobal.net.
 [45.27.90.188])
 by smtp.gmail.com with ESMTPSA id v8sm565094ywg.91.2019.09.17.10.24.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Sep 2019 10:24:29 -0700 (PDT)
From: Dan Streetman <dan.streetman@canonical.com>
To: qemu-devel@nongnu.org
Date: Tue, 17 Sep 2019 13:24:22 -0400
Message-Id: <20190917172422.5134-1-dan.streetman@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 91.189.89.112
Subject: [Qemu-devel] [PATCH] hw/arm: set machine 'virt' as default
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Dan Streetman <ddstreet@canonical.com>

There is currently no default machine type for arm so one must be specified
with --machine.  This sets the 'virt' machine type as default.

Signed-off-by: Dan Streetman <ddstreet@canonical.com>
---
 hw/arm/virt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index d74538b021..e9fe888ca2 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -78,6 +78,7 @@
         mc->desc = "QEMU " # major "." # minor " ARM Virtual Machine"; \
         if (latest) { \
             mc->alias = "virt"; \
+            mc->is_default = 1; \
         } \
     } \
     static const TypeInfo machvirt_##major##_##minor##_info = { \
-- 
2.20.1


