Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB4E6C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 21:46:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A49B12083E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 21:46:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B7GB2iBu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A49B12083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39698 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixHe9-00071W-Qp
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 16:46:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59240)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <danielhb413@gmail.com>) id 1ixHWz-0003J0-K4
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 16:39:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <danielhb413@gmail.com>) id 1ixHWy-0001RJ-IS
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 16:39:21 -0500
Received: from mail-qv1-xf44.google.com ([2607:f8b0:4864:20::f44]:35310)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <danielhb413@gmail.com>)
 id 1ixHWy-0001R9-E0; Thu, 30 Jan 2020 16:39:20 -0500
Received: by mail-qv1-xf44.google.com with SMTP id u10so2278332qvi.2;
 Thu, 30 Jan 2020 13:39:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Z3xKI0QCTIV3oPS9zRDoReVS6YYhkQI77L8IETXIfdg=;
 b=B7GB2iBuFzISiVhb4QxFC8Af11DE7CtFramT15hHTTFdQnneEBieH7zCLXK9lm9DED
 3Hlzp14HSAAtJ6wSLYIkM4fSD+GzbxbZIRGXCC4jcVsLRlki6r8BUPS7yTKnw7iVTsqO
 KTiD+9WIhNJMT487Bz7pRAlCT/F4A9UzUiz21bXYqRbb7YVNewSng9siPpt0HILOsI47
 9ujhL5LgwwQkzFHoI++Dm02norSWjxHBXvbNuHFmj8bDrnbaG3nbH1UVma2EbY2ClK3l
 GSfnTx+li2G8KkgzQXPG8ZXl1YrvV/1RDmFhj3FBR4Ja/UIJ+RtGxtQcAE0mYo9FNnfz
 r3HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Z3xKI0QCTIV3oPS9zRDoReVS6YYhkQI77L8IETXIfdg=;
 b=Vagv2trYrBuk9i5FjkhMGjM/Qa9szy7jazOQgDJV0y2rVyWphLa9zxx6OZBcKHLteH
 AatIr9Zqs43wFzpJS9Ds07pzYVdDXzoJMgCUpcOJdqQz0IzbTYSdy+THXw+Ree0E0vCG
 3vvZaY5TbBCxz51J0JP/xRQOt9jAR6qJaHFAxiARXYOxpi40WRgtPuc90JP3MPLYr3A1
 KKqrQMGO40jTolTcAV76Xd38DWkAmVW6YeZLui+/TNOUgWgw1+pRXvO7Te0tAXigSJTL
 vp8UsBdpDMDiBD6Mdenomw4qMUMd96kwnUTgZqouhjQwyysX6UrOYyfu0uC80EqHTwve
 gWKw==
X-Gm-Message-State: APjAAAV61Xte9a15/wOsi9K13YDd3Wcg3h5zRrmUcHXjLOyq/Jq55W5t
 8o8nT2rXJ6VOZPOmpGjIz/LLDgmx
X-Google-Smtp-Source: APXvYqzc7yQ4eQ+CCQsq183Qbbmj05wEwZbF+FaxbKxm9/ZCHeKJY1rND6IqPwqspjCsHV2wpN1aSA==
X-Received: by 2002:ad4:442c:: with SMTP id e12mr7071424qvt.19.1580420359799; 
 Thu, 30 Jan 2020 13:39:19 -0800 (PST)
Received: from rekt.ibmuc.com ([2804:431:c7c7:c177:887c:ce1b:6a44:15ec])
 by smtp.gmail.com with ESMTPSA id f26sm3650597qtv.77.2020.01.30.13.39.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jan 2020 13:39:19 -0800 (PST)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 2/4] block.c: adding bdrv_co_delete_file
Date: Thu, 30 Jan 2020 18:39:05 -0300
Message-Id: <20200130213907.2830642-3-danielhb413@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200130213907.2830642-1-danielhb413@gmail.com>
References: <20200130213907.2830642-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::f44
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
Cc: kwolf@redhat.com, Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Using the new 'bdrv_co_delete_file' interface, a pure co_routine function
'bdrv_co_delete_file' inside block.c can can be used in a way similar of
the existing bdrv_create_file to to clean up a created file.

We're creating a pure co_routine because the only caller of
'bdrv_co_delete_file' will be already in co_routine context, thus there
is no need to add all the machinery to check for qemu_in_coroutine() and
create a separated co_routine to do the job.

Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 block.c               | 26 ++++++++++++++++++++++++++
 include/block/block.h |  1 +
 2 files changed, 27 insertions(+)

diff --git a/block.c b/block.c
index ecd09dbbfd..c26d8271a1 100644
--- a/block.c
+++ b/block.c
@@ -548,6 +548,32 @@ int bdrv_create_file(const char *filename, QemuOpts *opts, Error **errp)
     return ret;
 }
 
+int coroutine_fn bdrv_co_delete_file(BlockDriverState *bs, Error **errp)
+{
+    Error *local_err = NULL;
+    int ret;
+
+    assert(bs != NULL);
+
+    if (!bs->drv) {
+        error_setg(errp, "Block node '%s' is not opened", bs->filename);
+        return -ENOMEDIUM;
+    }
+
+    if (!bs->drv->bdrv_co_delete_file) {
+        error_setg(errp, "Driver '%s' does not support image deletion",
+                   bs->drv->format_name);
+        return -ENOTSUP;
+    }
+
+    ret = bs->drv->bdrv_co_delete_file(bs, &local_err);
+    if (ret < 0) {
+        error_propagate(errp, local_err);
+    }
+
+    return ret;
+}
+
 /**
  * Try to get @bs's logical and physical block size.
  * On success, store them in @bsz struct and return 0.
diff --git a/include/block/block.h b/include/block/block.h
index e9dcfef7fa..f7db094859 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -373,6 +373,7 @@ bool bdrv_is_backing_chain_frozen(BlockDriverState *bs, BlockDriverState *base,
 int bdrv_freeze_backing_chain(BlockDriverState *bs, BlockDriverState *base,
                               Error **errp);
 void bdrv_unfreeze_backing_chain(BlockDriverState *bs, BlockDriverState *base);
+int coroutine_fn bdrv_co_delete_file(BlockDriverState *bs, Error **errp);
 
 
 typedef struct BdrvCheckResult {
-- 
2.24.1


