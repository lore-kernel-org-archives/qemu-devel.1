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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9BE4C33C9E
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 19:16:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 838872072E
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 19:16:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rfk3Gxix"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 838872072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioXrN-0003eW-E3
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 14:16:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46377)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <danielhb413@gmail.com>) id 1ioX53-0003bn-Mg
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 13:26:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <danielhb413@gmail.com>) id 1ioX52-00059A-Kv
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 13:26:21 -0500
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742]:41166)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <danielhb413@gmail.com>)
 id 1ioX52-00058q-HE; Mon, 06 Jan 2020 13:26:20 -0500
Received: by mail-qk1-x742.google.com with SMTP id x129so40279646qke.8;
 Mon, 06 Jan 2020 10:26:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=fAxjxUHh9JaiR6VmZW01ZkN0LXgZJSoQuf5vn+XIRdw=;
 b=rfk3GxixlysDr45BPkf2u2KqFAkKa0GmFiVAVKpJUP4Zr8BnRwQLCwkXm0c0y///bt
 mBMNXqNMOLIo1T8xLwqHx6GiexrLw7h+v+9OKOhPSEsZXzRt0xWxajGjyY1HgCohi6Yv
 4xBnd4pcnK5rrg9tuEyFoOD6zSmBuE8YCn6CgXYcYIeQbs04UB89nVeg4cpIV2N3+YmR
 HQMjfPdl4KxMPKMjXi9MWFCJhBcRp7pBorZOlSke4orsAG1l7ztNlHJ4Mj2NklPwBA33
 IrdcbWT17kPDvYy0kt//+pGymVrEOdkQZs/mQf8TZzmQvnnjI9Dz6XK2LBw5hvrsCNgn
 fCfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=fAxjxUHh9JaiR6VmZW01ZkN0LXgZJSoQuf5vn+XIRdw=;
 b=SkHXXHOxRdescD8MmAsCXMQYd130AXc8S64fevrve2SkKf/bZ658vUzhnjVMB1Um3z
 6NjUF3MVtvS8DvRNcllWgblKtAeM3ItcUN++LjffUW/xqZ5WQHjZri+uoJomyco0/jZY
 AFpg8dMTH55Z6UO2lCYZVDHkpyrPnxURAe/uNv+n9iXymXmJECI59rG2ecNLql768ual
 sxZ0btppyBCjEO5YOfG8Th1YNUAZWayySnZUyBAaqKYmhhQo3lubrs8jSPSFDZ3tiTFp
 8pq04GfYM+B998MQpG5wCDr38wxe4j0HT8AgAVTgWSW9L0s1pZQp92HO4pZDlONkuWPp
 9Q3w==
X-Gm-Message-State: APjAAAW0OhQPASEb6/OXrnDVXCzMCGP/bNtOH9I7Ntb2efuqrZvSicDY
 rg2jsZoPSRcyf6D0KAqXpcOIjpMN
X-Google-Smtp-Source: APXvYqw/aCh3zfgRbSaEj6maI+tanxesOlhxR/XyK5a1KtVEXQzovhATZA+9ouabFCdOpv4Gm3edbQ==
X-Received: by 2002:a05:620a:139b:: with SMTP id
 k27mr83022316qki.112.1578335179982; 
 Mon, 06 Jan 2020 10:26:19 -0800 (PST)
Received: from rekt.ibmuc.com ([2804:431:c7c6:655b:9e1c:e865:3705:e1df])
 by smtp.gmail.com with ESMTPSA id b81sm21026522qkc.135.2020.01.06.10.26.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2020 10:26:19 -0800 (PST)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 49/59] rdma/rdma_rm.c: remove unneeded label in
 rdma_rm_alloc_pd()
Date: Mon,  6 Jan 2020 15:24:15 -0300
Message-Id: <20200106182425.20312-50-danielhb413@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200106182425.20312-1-danielhb413@gmail.com>
References: <20200106182425.20312-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::742
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

'out' label can be replaced by 'return ret'. Since 'ret' will
be set to -ENOMEM in 'goto' time, we can replace it to
'return -ENOMEM'.

After this change, the 'ret' var is used to store the
result of rdma_backend_create_pd(), see if it's not zero,
then 'ret' is set to -EIO before the jump to out_tbl_dealloc.
-EIO is the only error being thrown by out_tbl_dealloc too.
This means we can go a step further in the code simplification
by also removing the 'ret' variable and making out_tbl_dealloc
return -EIO directly.

CC: Yuval Shaia <yuval.shaia@oracle.com>
CC: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 hw/rdma/rdma_rm.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/hw/rdma/rdma_rm.c b/hw/rdma/rdma_rm.c
index 1524dfaeaa..f049fda38a 100644
--- a/hw/rdma/rdma_rm.c
+++ b/hw/rdma/rdma_rm.c
@@ -161,16 +161,13 @@ int rdma_rm_alloc_pd(RdmaDeviceResources *dev_res, RdmaBackendDev *backend_dev,
                      uint32_t *pd_handle, uint32_t ctx_handle)
 {
     RdmaRmPD *pd;
-    int ret = -ENOMEM;
 
     pd = rdma_res_tbl_alloc(&dev_res->pd_tbl, pd_handle);
     if (!pd) {
-        goto out;
+        return -ENOMEM;
     }
 
-    ret = rdma_backend_create_pd(backend_dev, &pd->backend_pd);
-    if (ret) {
-        ret = -EIO;
+    if (rdma_backend_create_pd(backend_dev, &pd->backend_pd)) {
         goto out_tbl_dealloc;
     }
 
@@ -180,9 +177,7 @@ int rdma_rm_alloc_pd(RdmaDeviceResources *dev_res, RdmaBackendDev *backend_dev,
 
 out_tbl_dealloc:
     rdma_res_tbl_dealloc(&dev_res->pd_tbl, *pd_handle);
-
-out:
-    return ret;
+    return -EIO;
 }
 
 RdmaRmPD *rdma_rm_get_pd(RdmaDeviceResources *dev_res, uint32_t pd_handle)
-- 
2.24.1


