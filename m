Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3C63C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 19:39:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85D12204EC
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 19:39:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="iMyEo7j3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85D12204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbr2W-0002EG-Oe
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 15:39:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39162)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1jbqpr-0007tJ-Cs
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:26:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:46370)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1jbqpq-0002Yu-Dy
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:26:31 -0400
Received: from sstabellini-ThinkPad-T480s.hsd1.ca.comcast.net
 (c-67-164-102-47.hsd1.ca.comcast.net [67.164.102.47])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2764B20829;
 Thu, 21 May 2020 19:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1590089189;
 bh=qth0gZ5xBbaWEKdqHxl0V348J7lsE6oOo/kwx1SoOOg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=iMyEo7j32pCrxOnF9egdv4Uwx6R32QNKGD+ACg/qr2frOpcD3wK/xz0AgXRoEISsp
 uI8Z/AtNXF6IFKZ6YxFF5qr/P72r9EywZH/omTw7DbNwRZ5WT+AY8923/rXiBSFkNk
 bKwPA/c4oO8HacbNFmGHKWpGt1R3BBHWeudOH5oc=
From: Stefano Stabellini <sstabellini@kernel.org>
To: groug@kaod.org
Subject: [PATCH v2 3/3] xen/9pfs: increase max ring order to 9
Date: Thu, 21 May 2020 12:26:27 -0700
Message-Id: <20200521192627.15259-3-sstabellini@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <alpine.DEB.2.21.2005211225030.27502@sstabellini-ThinkPad-T480s>
References: <alpine.DEB.2.21.2005211225030.27502@sstabellini-ThinkPad-T480s>
Received-SPF: pass client-ip=198.145.29.99;
 envelope-from=sstabellini@kernel.org; helo=mail.kernel.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/21 15:26:19
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -70
X-Spam_score: -7.1
X-Spam_bar: -------
X-Spam_report: (-7.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: sstabellini@kernel.org, paul@xen.org, qemu_oss@crudebyte.com,
 qemu-devel@nongnu.org, anthony.perard@citrix.com,
 Stefano Stabellini <stefano.stabellini@xilinx.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Stefano Stabellini <stefano.stabellini@xilinx.com>

The max order allowed by the protocol is 9. Increase the max order
supported by QEMU to 9 to increase performance.

Signed-off-by: Stefano Stabellini <stefano.stabellini@xilinx.com>
---
Changes in v2:
- patch added
---
 hw/9pfs/xen-9p-backend.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/9pfs/xen-9p-backend.c b/hw/9pfs/xen-9p-backend.c
index 3c84c86ab8..a969fcc54c 100644
--- a/hw/9pfs/xen-9p-backend.c
+++ b/hw/9pfs/xen-9p-backend.c
@@ -21,7 +21,7 @@
 
 #define VERSIONS "1"
 #define MAX_RINGS 8
-#define MAX_RING_ORDER 8
+#define MAX_RING_ORDER 9
 
 typedef struct Xen9pfsRing {
     struct Xen9pfsDev *priv;
-- 
2.17.1


