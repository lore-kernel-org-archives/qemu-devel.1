Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D44D7C433E3
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 22:00:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1570206D7
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 22:00:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SXJZqhuY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1570206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56624 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0BAi-0000tu-RL
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 18:00:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47628)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nirsof@gmail.com>)
 id 1k0B97-0007p6-W1; Mon, 27 Jul 2020 17:58:58 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:33977)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nirsof@gmail.com>)
 id 1k0B94-0004Kh-Pq; Mon, 27 Jul 2020 17:58:57 -0400
Received: by mail-wm1-x341.google.com with SMTP id g10so14241786wmc.1;
 Mon, 27 Jul 2020 14:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=0SYxtxkPqDhdL0SY95r16v3wmBbeg7zalBIYXgGxdzI=;
 b=SXJZqhuYQFD6+kitOGX+vVAzArtn0FoQWQ384D1ugzh3mZsrv0yTH0AEIHDeWcvMKD
 1dLj7J8RIDE31kf87P+DZpF15RFHp3x1sVGk0b1BBpIrLGxdHNOYwqBwWgVnfzvKLgn1
 EIMURh6/QPRQAB/RomQJ3V9ASWxTvU0cAd/wkpTRDJzUv3jt4FdXy3/coME6UBvqu8m2
 TiC+9T59ks8kcGsfqqAv/Lvj9ttbTdrE6lige+bqqE3yE6pxY3iJwv6SQ9x1GmKjxCo3
 suUPuMX1KY6I+bzkFaP0Okhw7AqQp1EPe3n4yR6A0468mnwqr2JoOJwz4FdFNZHpSoNz
 8ezA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=0SYxtxkPqDhdL0SY95r16v3wmBbeg7zalBIYXgGxdzI=;
 b=n5NTEe+F58WJbXeku2DuNZdGhm3UQtEIdI5uZC9eYNNvzTM7+8pGNNShn5XLPCh+uX
 /0uZa8K1pmP7Uj7hltuYff5rLjcdNW4k+W2nIHu3YMblVAKrnmIxyigNrpEJzDisEGR7
 BuIz5hvlbjL2vNCk7kWTfag6F3DXX7/cb6kqvJh78bdGmnC0eniM2ZmgZUhf480tWbKJ
 qfN6mIMHpmhi+AKS5suxV8RvtCVf/TxBumNuiozx4A5S2PWKkYBa1cfr/UzvAE4muu5l
 kw23ptXpygjjv4bEgnRwfSEKuV0dUFI7k8QoXaJL9F/w43+3Vo2+YUzo/iC12MwmlLwW
 cVsA==
X-Gm-Message-State: AOAM532hYJjQjncSOcOq3ZZ2ZrDsTDlkTxUBV+XqHU1pCrrpdVxsmiyu
 lYPX6LHrOfqqiq788qtYT7GVdNqBpVE=
X-Google-Smtp-Source: ABdhPJznSiwH/8PIl6exw5a9+QIc+heo6Q8YXHi+CjIAEhAbPJ0S2ZKiCqzBdBS+SATRzApMEeoWuw==
X-Received: by 2002:a1c:2095:: with SMTP id g143mr1056121wmg.78.1595887132256; 
 Mon, 27 Jul 2020 14:58:52 -0700 (PDT)
Received: from localhost.localdomain (109-186-134-209.bb.netvision.net.il.
 [109.186.134.209])
 by smtp.gmail.com with ESMTPSA id p14sm14492940wrx.90.2020.07.27.14.58.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2020 14:58:51 -0700 (PDT)
From: Nir Soffer <nirsof@gmail.com>
X-Google-Original-From: Nir Soffer <nsoffer@redhat.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Subject: [PATCH v2 1/4] block: nbd: Fix convert qcow2 compressed to nbd
Date: Tue, 28 Jul 2020 00:58:43 +0300
Message-Id: <20200727215846.395443-2-nsoffer@redhat.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200727215846.395443-1-nsoffer@redhat.com>
References: <20200727215846.395443-1-nsoffer@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=nirsof@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Nir Soffer <nsoffer@redhat.com>,
 vsementsov@virtuozzo.com, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When converting to qcow2 compressed format, the last step is a special
zero length compressed write, ending in call to bdrv_co_truncate(). This
call always fails for the nbd driver since it does not implement
bdrv_co_truncate().

For block devices, which have the same limits, the call succeeds since
file driver implements bdrv_co_truncate(). If the caller asked to
truncate to the same or smaller size with exact=false, the truncate
succeeds. Implement the same logic for nbd.

Example failing without this change:

In one shell starts qemu-nbd:

$ truncate -s 1g test.tar
$ qemu-nbd --socket=/tmp/nbd.sock --persistent --format=raw --offset 1536 test.tar

In another shell convert an image to qcow2 compressed via NBD:

$ echo "disk data" > disk.raw
$ truncate -s 1g disk.raw
$ qemu-img convert -f raw -O qcow2 -c disk1.raw nbd+unix:///?socket=/tmp/nbd.sock; echo $?
1

qemu-img failed, but the conversion was successful:

$ qemu-img info nbd+unix:///?socket=/tmp/nbd.sock
image: nbd+unix://?socket=/tmp/nbd.sock
file format: qcow2
virtual size: 1 GiB (1073741824 bytes)
...

$ qemu-img check nbd+unix:///?socket=/tmp/nbd.sock
No errors were found on the image.
1/16384 = 0.01% allocated, 100.00% fragmented, 100.00% compressed clusters
Image end offset: 393216

$ qemu-img compare disk.raw nbd+unix:///?socket=/tmp/nbd.sock
Images are identical.

Fixes: https://bugzilla.redhat.com/1860627
Signed-off-by: Nir Soffer <nsoffer@redhat.com>
---
 block/nbd.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/block/nbd.c b/block/nbd.c
index 65a4f56924..dcb0b03641 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -1966,6 +1966,33 @@ static void nbd_close(BlockDriverState *bs)
     nbd_clear_bdrvstate(s);
 }
 
+/*
+ * NBD cannot truncate, but if the caller asks to truncate to the same size, or
+ * to a smaller size with exact=false, there is no reason to fail the
+ * operation.
+ *
+ * Preallocation mode is ignored since it does not seems useful to fail when
+ * when never change anything.
+ */
+static int coroutine_fn nbd_co_truncate(BlockDriverState *bs, int64_t offset,
+                                        bool exact, PreallocMode prealloc,
+                                        BdrvRequestFlags flags, Error **errp)
+{
+    BDRVNBDState *s = bs->opaque;
+
+    if (offset != s->info.size && exact) {
+        error_setg(errp, "Cannot resize NBD nodes");
+        return -ENOTSUP;
+    }
+
+    if (offset > s->info.size) {
+        error_setg(errp, "Cannot grow NBD nodes");
+        return -EINVAL;
+    }
+
+    return 0;
+}
+
 static int64_t nbd_getlength(BlockDriverState *bs)
 {
     BDRVNBDState *s = bs->opaque;
@@ -2045,6 +2072,7 @@ static BlockDriver bdrv_nbd = {
     .bdrv_co_flush_to_os        = nbd_co_flush,
     .bdrv_co_pdiscard           = nbd_client_co_pdiscard,
     .bdrv_refresh_limits        = nbd_refresh_limits,
+    .bdrv_co_truncate           = nbd_co_truncate,
     .bdrv_getlength             = nbd_getlength,
     .bdrv_detach_aio_context    = nbd_client_detach_aio_context,
     .bdrv_attach_aio_context    = nbd_client_attach_aio_context,
@@ -2072,6 +2100,7 @@ static BlockDriver bdrv_nbd_tcp = {
     .bdrv_co_flush_to_os        = nbd_co_flush,
     .bdrv_co_pdiscard           = nbd_client_co_pdiscard,
     .bdrv_refresh_limits        = nbd_refresh_limits,
+    .bdrv_co_truncate           = nbd_co_truncate,
     .bdrv_getlength             = nbd_getlength,
     .bdrv_detach_aio_context    = nbd_client_detach_aio_context,
     .bdrv_attach_aio_context    = nbd_client_attach_aio_context,
@@ -2099,6 +2128,7 @@ static BlockDriver bdrv_nbd_unix = {
     .bdrv_co_flush_to_os        = nbd_co_flush,
     .bdrv_co_pdiscard           = nbd_client_co_pdiscard,
     .bdrv_refresh_limits        = nbd_refresh_limits,
+    .bdrv_co_truncate           = nbd_co_truncate,
     .bdrv_getlength             = nbd_getlength,
     .bdrv_detach_aio_context    = nbd_client_detach_aio_context,
     .bdrv_attach_aio_context    = nbd_client_attach_aio_context,
-- 
2.25.4


