Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88543C33C8C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 18:26:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50E0624676
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 18:26:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NYbCZL8k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50E0624676
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioX5V-0003hh-O0
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 13:26:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44949)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <danielhb413@gmail.com>) id 1ioX3h-0001OH-B3
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 13:24:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <danielhb413@gmail.com>) id 1ioX3g-0003el-Ao
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 13:24:57 -0500
Received: from mail-qt1-x843.google.com ([2607:f8b0:4864:20::843]:43278)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <danielhb413@gmail.com>)
 id 1ioX3g-0003eZ-77; Mon, 06 Jan 2020 13:24:56 -0500
Received: by mail-qt1-x843.google.com with SMTP id d18so40492830qtj.10;
 Mon, 06 Jan 2020 10:24:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9UmeSQEs5rob9wrTq2qmb04fnkLXv4NpiQ8wHgmBhdQ=;
 b=NYbCZL8kRRwem5Io6W0Rv8fJs/luyPrKXDV1i3FI2TMztdEE2dMIcwM/vU9maVNhMr
 3t/FqCrKWy4GHh/Eg5tg83YQSid3KvIYEt8oVX4BgLS31EPmbiAUw8D1N6od7AN6EWgJ
 +gC9gaEX5EMeVvc1Yi/7276dYGW2YURBRGmzphfT2dY1/+vDAcKaXMgx43iNa8rbcgP4
 xM+UQIbFsd9WrLaQR+WgCTNlPOW2AM+BfM/04WqOozqXaqChsE8o1y9RxXaHQ1iC3h5m
 h9s5IJyzmh8oFC9Ec9/VrAaPyUn7a4fJH66QHNm75vUZCcIGWd0C2cZA7bVwMgjLkRnt
 7sGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9UmeSQEs5rob9wrTq2qmb04fnkLXv4NpiQ8wHgmBhdQ=;
 b=uSMNsWNDtZAxifOBhv6UdFoU77ISvgEyW4xfG/QQBUdP0vLxGtUMQFjR1H/4yLKkci
 8a9g81aQ8cQ26DDg4pE2zCvAPQCBLY1Mv8xgmEEWG8/FiDtbbIfJwjbVt6DsHGlyAhIb
 yZt2fl9qdANBlWTLe8DU4TC1STGYneY8P1EFp+VfHas/q+7uJWEgyOkiYDy0rab1Z8cy
 UpTA6eGVjCfwod9yncj70h63KC3gAifHzDyjzhiWcT0Lz/C3+f+a8f0bvrnwps4XWKJe
 J6IROnXqwGMqmIsoJOZ0cPbRqjz1YDXtk+1grvpVWbdJ0S64qM9IzTprZHClvm8zp/Kw
 AfFQ==
X-Gm-Message-State: APjAAAWLusAsaR/Ob/rKS7V9luK8O6NmyLkydjNtjry/y8jiEK+eomRr
 3jklzHwDz9jAPl9Nm73vnwbac4vM
X-Google-Smtp-Source: APXvYqysG9Euycb7WM82W/Td0I147yU5XTejtd+bqGoAlGKBmm3Qvmlpmn7SqAtCcQzqSKytc+nEPw==
X-Received: by 2002:ac8:59:: with SMTP id i25mr76889454qtg.110.1578335095624; 
 Mon, 06 Jan 2020 10:24:55 -0800 (PST)
Received: from rekt.ibmuc.com ([2804:431:c7c6:655b:9e1c:e865:3705:e1df])
 by smtp.gmail.com with ESMTPSA id b81sm21026522qkc.135.2020.01.06.10.24.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2020 10:24:55 -0800 (PST)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 02/59] ppc440_bamboo.c: remove label from
 bamboo_load_device_tree()
Date: Mon,  6 Jan 2020 15:23:28 -0300
Message-Id: <20200106182425.20312-3-danielhb413@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200106182425.20312-1-danielhb413@gmail.com>
References: <20200106182425.20312-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::843
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
Cc: qemu-trivial@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

'out' label can be replaced by 'return -1' in all cases.

CC: David Gibson <david@gibson.dropbear.id.au>
CC: qemu-ppc@nongnu.org
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 hw/ppc/ppc440_bamboo.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/hw/ppc/ppc440_bamboo.c b/hw/ppc/ppc440_bamboo.c
index 4d95c0f8a8..b782641b23 100644
--- a/hw/ppc/ppc440_bamboo.c
+++ b/hw/ppc/ppc440_bamboo.c
@@ -71,12 +71,12 @@ static int bamboo_load_device_tree(hwaddr addr,
 
     filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, BINARY_DEVICE_TREE_FILE);
     if (!filename) {
-        goto out;
+        return -1;
     }
     fdt = load_device_tree(filename, &fdt_size);
     g_free(filename);
     if (fdt == NULL) {
-        goto out;
+        return -1;
     }
 
     /* Manipulate device tree in memory. */
@@ -117,10 +117,6 @@ static int bamboo_load_device_tree(hwaddr addr,
     rom_add_blob_fixed(BINARY_DEVICE_TREE_FILE, fdt, fdt_size, addr);
     g_free(fdt);
     return 0;
-
-out:
-
-    return ret;
 }
 
 /* Create reset TLB entries for BookE, spanning the 32bit addr space.  */
-- 
2.24.1


