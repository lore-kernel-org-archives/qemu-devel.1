Return-Path: <SRS0=OFvx=W5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E387AC3A59E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2019 21:02:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACFBD208E4
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2019 21:02:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JQ2CAku9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACFBD208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i4tTT-0000Kk-Ea
	for qemu-devel@archiver.kernel.org; Mon, 02 Sep 2019 17:02:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33419)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <danielhb413@gmail.com>) id 1i4tPe-0005r3-EG
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 16:58:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <danielhb413@gmail.com>) id 1i4tPc-0004KB-6U
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 16:58:58 -0400
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742]:35789)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <danielhb413@gmail.com>)
 id 1i4tPc-0004J7-1v
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 16:58:56 -0400
Received: by mail-qk1-x742.google.com with SMTP id d26so6037372qkk.2
 for <qemu-devel@nongnu.org>; Mon, 02 Sep 2019 13:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=RkpF/3bkRRxXIQKIG0bVJK8VOHWsiINFvPG77fhS7YE=;
 b=JQ2CAku9rwLhcVOoSOuGKFgND/LqavPa0Rb4px+UhJHaYPfsWNmaCyLQye03zJOVSm
 o8Er1lOpzGtGaM1QrQvtyrkuEY6yVSpyB5XE633FQtSHNnKsdb/PvMQ4N1anA448wTxA
 nstkAjbun0cmPhXjCbwJ3mJnx71Lz3R2j9NAdwiz3Y3YWTHQqI1/iA3QMFoDVVXlnbxV
 y/itJ+elcMODhjqZMDaqKJQVuAcSF4b5pTgMExa1OBNkodArURVNiGx8mLSpIuBouPYs
 +EkVFvuYdfL9kCX59sKGJOuRR/p48pfipwyOIMuKrKXywYPGD+6qtbPs0EkltbApw8ZE
 q7nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=RkpF/3bkRRxXIQKIG0bVJK8VOHWsiINFvPG77fhS7YE=;
 b=UBZBjBTW23MgihZSAxSS1PzcCWReAxQ2Ed/AJ1LMpRVltSoc1W40DxDQucCP34eSDi
 GIIG857T2TNbRdYPX3hmBtlDko+V8tOeSioS50caYVpuHDOMRNbMyLtMtWQL1IWfgx6w
 pCYSX4Jbv5ANx06Ra4H01ghAfUpwuAmmjhuNhcDY0SB7i8TCepNWiIAetpojiinI4aAu
 pskJ67aWhihFn7TRibAHeFcHNFKAA/Cv6XWWjmnlfGsVzXWRhADrjoTcLlnPUCok9GdN
 fwMxIgHtpzO1+ofW9FR4HFvlGXlcQErmNqx0pVyl/jcvuQxXVOhKW9nnoxSseReewqbD
 2xFA==
X-Gm-Message-State: APjAAAW5pBZB04s7EhVT5az2PYydDnQj/N/b78i4AxOGcyzGlof7R8oN
 ZnvijNKTWsPCzeekHGpARqDNlD97
X-Google-Smtp-Source: APXvYqzBfD+7w24+bOMM/U4CBluY8YG9UuKj3XU9hlRW37Sxn7dnI79zQSz9QU8x+XuLwotWLCBCsw==
X-Received: by 2002:ae9:e648:: with SMTP id x8mr30511276qkl.247.1567457935488; 
 Mon, 02 Sep 2019 13:58:55 -0700 (PDT)
Received: from rekt.ibmuc.com ([2804:431:c7c6:9589:1351:c7eb:87b:c9d5])
 by smtp.gmail.com with ESMTPSA id w80sm4604038qka.62.2019.09.02.13.58.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Sep 2019 13:58:55 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Date: Mon,  2 Sep 2019 17:58:40 -0300
Message-Id: <20190902205842.1884-3-danielhb413@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190902205842.1884-1-danielhb413@gmail.com>
References: <20190902205842.1884-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::742
Subject: [Qemu-devel] [PATCH v6 2/4] block.c: adding bdrv_delete_file
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
Cc: kwolf@redhat.com,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Using the new 'bdrv_co_delete_file' interface, bdrv_delete_file
can be used in a way similar of the existing bdrv_create_file to
to clean up a created file.

The logic is also similar to what is already done in bdrv_create_file:
a qemu_coroutine is created if needed, a specialized function
bdrv_delete_co_entry is used to call the bdrv_co_delete_file
co-routine of the driver, if the driver implements it.

Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 block.c               | 78 +++++++++++++++++++++++++++++++++++++++++++
 include/block/block.h |  1 +
 2 files changed, 79 insertions(+)

diff --git a/block.c b/block.c
index 874a29a983..75212d873a 100644
--- a/block.c
+++ b/block.c
@@ -548,6 +548,84 @@ int bdrv_create_file(const char *filename, QemuOpts *opts, Error **errp)
     return ret;
 }
 
+typedef struct DeleteCo {
+    BlockDriver *drv;
+    BlockDriverState *bs;
+    int ret;
+    Error *err;
+} DeleteCo;
+
+static void coroutine_fn bdrv_delete_co_entry(void *opaque)
+{
+    Error *local_err = NULL;
+    DeleteCo *dco = opaque;
+
+    assert(dco->bs);
+
+    dco->ret = dco->drv->bdrv_co_delete_file(dco->bs, &local_err);
+    error_propagate(&dco->err, local_err);
+}
+
+int bdrv_delete_file(const char *filename, Error **errp)
+{
+    BlockDriver *drv = bdrv_find_protocol(filename, true, NULL);
+    BlockDriverState *bs = bdrv_open(filename, NULL, NULL,
+                                     BDRV_O_RDWR | BDRV_O_PROTOCOL,
+                                     NULL);
+    DeleteCo dco = {
+        .drv = drv,
+        .bs = bs,
+        .ret = NOT_DONE,
+        .err = NULL,
+    };
+    Coroutine *co;
+    int ret;
+
+    if (!drv) {
+        error_setg(errp, "File '%s' has unknown format", filename);
+        ret = -ENOMEDIUM;
+        goto out;
+    }
+
+    if (!drv->bdrv_co_delete_file) {
+        error_setg(errp, "Driver '%s' does not support image delete",
+                   drv->format_name);
+        ret = -ENOTSUP;
+        goto out;
+    }
+
+    if (!bs) {
+        error_setg(errp, "Could not open image '%s' for erasing",
+                   filename);
+        ret = -1;
+        goto out;
+    }
+
+    if (qemu_in_coroutine()) {
+        /* Fast-path if already in coroutine context */
+        bdrv_delete_co_entry(&dco);
+    } else {
+        co = qemu_coroutine_create(bdrv_delete_co_entry, &dco);
+        qemu_coroutine_enter(co);
+        while (dco.ret == NOT_DONE) {
+            aio_poll(qemu_get_aio_context(), true);
+        }
+    }
+
+    ret = dco.ret;
+    if (ret < 0) {
+        if (dco.err) {
+            error_propagate(errp, dco.err);
+        } else {
+            error_setg_errno(errp, -ret, "Could not delete image");
+        }
+    }
+
+out:
+    bdrv_unref(bs);
+    return ret;
+}
+
 /**
  * Try to get @bs's logical and physical block size.
  * On success, store them in @bsz struct and return 0.
diff --git a/include/block/block.h b/include/block/block.h
index 124ad40809..dbe737202b 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -374,6 +374,7 @@ bool bdrv_is_backing_chain_frozen(BlockDriverState *bs, BlockDriverState *base,
 int bdrv_freeze_backing_chain(BlockDriverState *bs, BlockDriverState *base,
                               Error **errp);
 void bdrv_unfreeze_backing_chain(BlockDriverState *bs, BlockDriverState *base);
+int bdrv_delete_file(const char *filename, Error **errp);
 
 
 typedef struct BdrvCheckResult {
-- 
2.21.0


