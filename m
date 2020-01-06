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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FE90C33C8C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 19:01:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54CCA2072C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 19:01:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZdeMQ8UH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54CCA2072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58250 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioXdC-0006wE-R2
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 14:01:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46328)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <danielhb413@gmail.com>) id 1ioX50-0003VQ-D0
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 13:26:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <danielhb413@gmail.com>) id 1ioX4z-00055X-4F
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 13:26:18 -0500
Received: from mail-qk1-x741.google.com ([2607:f8b0:4864:20::741]:44335)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <danielhb413@gmail.com>)
 id 1ioX4z-00055D-0m; Mon, 06 Jan 2020 13:26:17 -0500
Received: by mail-qk1-x741.google.com with SMTP id w127so40269614qkb.11;
 Mon, 06 Jan 2020 10:26:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5WuUZRHCzkwWxWtzKtgDX4yjtDTeyRFxW7kIUanwn6c=;
 b=ZdeMQ8UHGy9hLj8PGaHr7+C9CS/OBtbby1PzCL5s2mgv39PtzN33JHp18JaIperBym
 x2TCpieDr4KiqMD93kIaMu1kqKk7bkRvpylCn9mEJNuVKi7Ifno1sPwJX7qMQMvvapKr
 RZtiKkB3HatUEa60q8wMRIoaPhPcCzrNrLxZ1sDMEJuRx50wP/YmXUQhyUV4Sj1xo40P
 bKiFd0QYkWn3t8Dv4Hq/9y7SD9FtSyEz6sLmLeWgO0dzop/pZ6UIFVEzTNt5yJBLcBto
 VjX+ttm5VJvevbNX7j6JH5lLnrmdXwql9lvSC+FAjSqrwLkEBjQL3knp7ia4kaYfXteF
 edEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5WuUZRHCzkwWxWtzKtgDX4yjtDTeyRFxW7kIUanwn6c=;
 b=OzR02z0T9SGFMXJvwkManZKqzvDHuKWtkKPJtUCFHp/UoKyBwUaDiEAxxryELENYD5
 KVHzHbUhKR6NwJ26i5oaa3/SCCx5nldklVnlrPQvgWxVxdlhpp+ArOAf0qMVOrsrXP1o
 dsyz+PsV09JgLd8Z7OUAYgO31vt1EzsFUYS5XJ4jPg7sYZzLmK6o0z8/1pYpOceOr6Lk
 mPqi5OYZ0cu+duaoeRJoQcDljP48giCs0dbbZbP9Y1YMRDNFMLqY2duD89/Adpp5vW34
 FBLPdQVY+fOLnvTXjYv0L+6s7wFUXMoDdDQ7qSgiNZfuolVv2QjhYkHP3JxacgFRDOFS
 Dagw==
X-Gm-Message-State: APjAAAXJ9lOSt5PaFmo9g2eDExYrAJQKPRmBFvLunLptHUDInFjiqdwt
 gmAMvGYSs5S1m0GOdcGizOrvuu5J
X-Google-Smtp-Source: APXvYqxCy2hs/oidkSAxrapt51pghQzPFsLbYQUe1RGrC8YZUTyrg7kcIvafxKXgzgeM0igPdlRzdg==
X-Received: by 2002:a37:c244:: with SMTP id j4mr82727323qkm.433.1578335176481; 
 Mon, 06 Jan 2020 10:26:16 -0800 (PST)
Received: from rekt.ibmuc.com ([2804:431:c7c6:655b:9e1c:e865:3705:e1df])
 by smtp.gmail.com with ESMTPSA id b81sm21026522qkc.135.2020.01.06.10.26.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2020 10:26:16 -0800 (PST)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 47/59] pvrdma_main.c: remove unneeded labels
Date: Mon,  6 Jan 2020 15:24:13 -0300
Message-Id: <20200106182425.20312-48-danielhb413@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200106182425.20312-1-danielhb413@gmail.com>
References: <20200106182425.20312-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::741
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
 Yuval Shaia <yuval.shaia@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Label 'out' from init_dev_ring() and load_dsr() can be
replaced by 'return' with the adequate value.

CC: Yuval Shaia <yuval.shaia@oracle.com>
CC: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 hw/rdma/vmw/pvrdma_main.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/hw/rdma/vmw/pvrdma_main.c b/hw/rdma/vmw/pvrdma_main.c
index 6f0fc405c7..fcaf829e30 100644
--- a/hw/rdma/vmw/pvrdma_main.c
+++ b/hw/rdma/vmw/pvrdma_main.c
@@ -94,8 +94,7 @@ static int init_dev_ring(PvrdmaRing *ring, struct pvrdma_ring **ring_state,
     dir = rdma_pci_dma_map(pci_dev, dir_addr, TARGET_PAGE_SIZE);
     if (!dir) {
         rdma_error_report("Failed to map to page directory (ring %s)", name);
-        rc = -ENOMEM;
-        goto out;
+        return -ENOMEM;
     }
     tbl = rdma_pci_dma_map(pci_dev, dir[0], TARGET_PAGE_SIZE);
     if (!tbl) {
@@ -134,7 +133,6 @@ out_free_tbl:
 out_free_dir:
     rdma_pci_dma_unmap(pci_dev, dir, TARGET_PAGE_SIZE);
 
-out:
     return rc;
 }
 
@@ -177,8 +175,7 @@ static int load_dsr(PVRDMADev *dev)
                               sizeof(struct pvrdma_device_shared_region));
     if (!dev->dsr_info.dsr) {
         rdma_error_report("Failed to map to DSR");
-        rc = -ENOMEM;
-        goto out;
+        return -ENOMEM;
     }
 
     /* Shortcuts */
@@ -221,7 +218,7 @@ static int load_dsr(PVRDMADev *dev)
         goto out_free_rsp;
     }
 
-    goto out;
+    return rc;
 
 out_free_rsp:
     rdma_pci_dma_unmap(pci_dev, dsr_info->rsp, sizeof(union pvrdma_cmd_resp));
@@ -234,7 +231,6 @@ out_free_dsr:
                        sizeof(struct pvrdma_device_shared_region));
     dsr_info->dsr = NULL;
 
-out:
     return rc;
 }
 
-- 
2.24.1


