Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30B23C388F9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 16:35:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F5A421655
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 16:35:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F5A421655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXRwo-0003Ea-9l
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 12:35:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50516)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kXRrh-0006rx-IS; Tue, 27 Oct 2020 12:30:29 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:38125)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kXRrf-0001XV-1h; Tue, 27 Oct 2020 12:30:29 -0400
Received: from localhost.localdomain ([82.252.139.38]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1M6EOc-1kQrDR0hh2-006iwh; Tue, 27 Oct 2020 17:30:21 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 5/8] cryptodev: Fix Lesser GPL version number
Date: Tue, 27 Oct 2020 17:30:11 +0100
Message-Id: <20201027163014.247336-6-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201027163014.247336-1-laurent@vivier.eu>
References: <20201027163014.247336-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:KfAuoOPWt+4I8jCTUMLREd/BJqxj4W02chCzPPUbBPassCyxRCh
 LouzyoGf2pYuU/3UmfhnRQ8AODiN3fd+fI1HDnYxljpsYhkvoZxP2h4+2+xZvZ3RLY28dg3
 WniWDMproGWqZR+PrLKio4x5pyD7aaD/okGUoLAu5FjqnbU5oFeG12GcVgNPaOozx3PphtF
 QKwDDozhAfeLN0wTrGNUw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Vzfw3nHmOyM=:sHg9dLDP/XEZwqj5syZQpn
 rmvYVvghM02jZ77nBt03UeWH9m42ZDcyiLS6P0FItclK0efyM3d+f5LySjXT5EBs2uHbg5SLV
 D5WTpJBoscFWR7GkeaiDkRabyP1Xc+FwLpHrSP1KywUo0KayfpdPlPhDBXB3DJPP3NOM5qB0C
 pEBLlUw2uqSStiP5/3eZvJMoMGxz54a7i51e19qiLJM/MigwIFU5TkD5opKk+qcFubqh/CGyA
 cV32vTxBgnJDQR0eHb556+D4EHj0vnk4Yv/7c9bs9Bk1khO6Cch5LjV9ddtqyRTClCTtJ6RWq
 B2K5DcfOdTXiX1irVM6vhJ81W0HYlKy5ICqUNGgnep6wlOcVUq9Fumc5YsYBqx6XJzX/OdCTr
 5WeYVwqKHUypcUFqhJ4PG9qE+I8FLwNt84kdnoC2Txfhw8pKt+fct6vtmhMosiVacNodTbU14
 T7DWCm8Nnw==
Received-SPF: none client-ip=212.227.17.10; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 12:30:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: qemu-trivial@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 Chetan Pant <chetan4windows@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Chetan Pant <chetan4windows@gmail.com>

There is no "version 2" of the "Lesser" General Public License.
It is either "GPL version 2.0" or "Lesser GPL version 2.1".
This patch replaces all occurrences of "Lesser GPL version 2" with
"Lesser GPL version 2.1" in comment section.

Signed-off-by: Chetan Pant <chetan4windows@gmail.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20201014133722.14041-1-chetan4windows@gmail.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 backends/cryptodev-builtin.c          | 2 +-
 backends/cryptodev-vhost-user.c       | 2 +-
 backends/cryptodev-vhost.c            | 2 +-
 backends/cryptodev.c                  | 2 +-
 include/sysemu/cryptodev-vhost-user.h | 2 +-
 include/sysemu/cryptodev-vhost.h      | 2 +-
 include/sysemu/cryptodev.h            | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/backends/cryptodev-builtin.c b/backends/cryptodev-builtin.c
index c6edb1b28af6..0671bf9f3e5e 100644
--- a/backends/cryptodev-builtin.c
+++ b/backends/cryptodev-builtin.c
@@ -9,7 +9,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/backends/cryptodev-vhost-user.c b/backends/cryptodev-vhost-user.c
index e1df073de2d8..bedb4524742e 100644
--- a/backends/cryptodev-vhost-user.c
+++ b/backends/cryptodev-vhost-user.c
@@ -9,7 +9,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/backends/cryptodev-vhost.c b/backends/cryptodev-vhost.c
index 8337c9a495f0..8231e7f1bca9 100644
--- a/backends/cryptodev-vhost.c
+++ b/backends/cryptodev-vhost.c
@@ -10,7 +10,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/backends/cryptodev.c b/backends/cryptodev.c
index 3f141f61ed65..bf524761663a 100644
--- a/backends/cryptodev.c
+++ b/backends/cryptodev.c
@@ -9,7 +9,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/include/sysemu/cryptodev-vhost-user.h b/include/sysemu/cryptodev-vhost-user.h
index 0d3421e7e8ca..60710502c2d1 100644
--- a/include/sysemu/cryptodev-vhost-user.h
+++ b/include/sysemu/cryptodev-vhost-user.h
@@ -9,7 +9,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/include/sysemu/cryptodev-vhost.h b/include/sysemu/cryptodev-vhost.h
index f42824fbde43..e8cab1356e49 100644
--- a/include/sysemu/cryptodev-vhost.h
+++ b/include/sysemu/cryptodev-vhost.h
@@ -10,7 +10,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
diff --git a/include/sysemu/cryptodev.h b/include/sysemu/cryptodev.h
index b458aa4dae8d..f4d4057d4da6 100644
--- a/include/sysemu/cryptodev.h
+++ b/include/sysemu/cryptodev.h
@@ -9,7 +9,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
-- 
2.26.2


