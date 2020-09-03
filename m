Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6DC5C433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 22:38:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B26B20716
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 22:38:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m9Ew61LO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B26B20716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDxsD-0002lM-EA
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 18:38:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52254)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tom.ty89@gmail.com>)
 id 1kDxrI-00023j-54
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 18:37:32 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:40328)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tom.ty89@gmail.com>)
 id 1kDxrG-0002ms-BH
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 18:37:31 -0400
Received: by mail-pj1-x1043.google.com with SMTP id gf14so2140355pjb.5
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 15:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=pav0OrE6Btb36xX/7Tp1ibEuKci58Ujxp0moi+WBeic=;
 b=m9Ew61LO+vzoZN7jt1WatM2Sglcm8loYFraIlluvyFSDA4annPxc1VoWYwkvRTJyww
 JSnMjB0/93UWPcFNFWAQBuL/iCDzfBvbmx8Q4AmE7KcKbfiS0rNJ+dqB1WS9QXIf/S9L
 0rbxZewbp2dJo4tUu5jXU2a6ppvk7xtDaJ+qxpymj2nWObgl7SmKfPkTZ1QumA+WGm2u
 wA8Xqev4XlsDIYPw3UfBlETBq75FcnooYmr4d6r/Vw7aupKRvDe5ZzdCNOGGVBJUQEh6
 86VVDt6AbKqsGq11VJh3sMJ/RBHdfK+tqmxeEFbwkTHKLKxVy4PtFSV5IulHWlHjirPW
 ADpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=pav0OrE6Btb36xX/7Tp1ibEuKci58Ujxp0moi+WBeic=;
 b=rWLtx+rXdQBWgcLn4iLkO88AiINViOnNn8oe9WK53iXXQk4LnP5Bm200B2anJqtFZx
 7Sbi7YTXKEKv2mFyg38NEeAYy4uw+51tM9Icho1Rr2qZ80EpfQ4Ach2fNDVxXC0LEqSb
 eL65lIFMeHn/qeIflJzokhd/VFFfdyeO0ZWfz9wtkB6pJHVWNKDHLs4aLl4/DgJRNGNR
 yjNu7O3slaQKDh1Wj8WnokkWPoDZNPn7GEpjzSo+5iF+QnTmXwubG99yQRUqpy1SWDlj
 pRJq4ASRrrbz8vOYdEQ4h3dnDvX2Mx84t3Rc7dpktYoSP8K6OZ8YgB/ZXPUWMBDPVilO
 wNxQ==
X-Gm-Message-State: AOAM533a/EfYzk7vHbgab5AZwWKarmCqJo9e3WveK96hcymV/0zRuorK
 cxWQZlYwHMQ5lHkHKvVn+YUOXbc6OGw=
X-Google-Smtp-Source: ABdhPJyI48MSA4vciEPNi0IGpz5Wdsm0TSKOfwhd6lG2PzbAYgTl1MhUESmYAlcFbokX53S1JByo0Q==
X-Received: by 2002:a17:90a:e391:: with SMTP id
 b17mr5310328pjz.127.1599172648049; 
 Thu, 03 Sep 2020 15:37:28 -0700 (PDT)
Received: from localhost.localdomain ([161.81.62.213])
 by smtp.gmail.com with ESMTPSA id o30sm3893345pgc.45.2020.09.03.15.37.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2020 15:37:27 -0700 (PDT)
From: Tom Yan <tom.ty89@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] file-posix: split hdev_refresh_limits from raw_refresh_limits
Date: Fri,  4 Sep 2020 06:37:21 +0800
Message-Id: <20200903223721.84459-1-tom.ty89@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1043;
 envelope-from=tom.ty89@gmail.com; helo=mail-pj1-x1043.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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
Cc: Tom Yan <tom.ty89@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

sg_get_max_transfer_length() and sg_get_max_segments() have nothing
to do with the sg driver or SG_IO at all. They can be and should be
used on all host devices / cdroms (on Linux).

Also use MIN_NON_ZERO instead when we clamp max_sectors against
max_segments.

Signed-off-by: Tom Yan <tom.ty89@gmail.com>
---
 block/file-posix.c | 39 ++++++++++++++++++++++-----------------
 1 file changed, 22 insertions(+), 17 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index 9a00d4190a..a38f43af4f 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -1163,7 +1163,7 @@ static void raw_reopen_abort(BDRVReopenState *state)
     s->reopen_state = NULL;
 }
 
-static int sg_get_max_transfer_length(int fd)
+static int get_max_transfer_length(int fd)
 {
 #ifdef BLKSECTGET
     int max_bytes = 0;
@@ -1178,7 +1178,7 @@ static int sg_get_max_transfer_length(int fd)
 #endif
 }
 
-static int sg_get_max_segments(int fd)
+static int get_max_segments(int fd)
 {
 #ifdef CONFIG_LINUX
     char buf[32];
@@ -1233,23 +1233,28 @@ static void raw_refresh_limits(BlockDriverState *bs, Error **errp)
 {
     BDRVRawState *s = bs->opaque;
 
-    if (bs->sg) {
-        int ret = sg_get_max_transfer_length(s->fd);
+    raw_probe_alignment(bs, s->fd, errp);
+    bs->bl.min_mem_alignment = s->buf_align;
+    bs->bl.opt_mem_alignment = MAX(s->buf_align, qemu_real_host_page_size);
+}
 
-        if (ret > 0 && ret <= BDRV_REQUEST_MAX_BYTES) {
-            bs->bl.max_transfer = pow2floor(ret);
-        }
+static void hdev_refresh_limits(BlockDriverState *bs, Error **errp)
+{
+    BDRVRawState *s = bs->opaque;
 
-        ret = sg_get_max_segments(s->fd);
-        if (ret > 0) {
-            bs->bl.max_transfer = MIN(bs->bl.max_transfer,
-                                      ret * qemu_real_host_page_size);
-        }
+    int ret = get_max_transfer_length(s->fd);
+
+    if (ret > 0 && ret <= BDRV_REQUEST_MAX_BYTES) {
+        bs->bl.max_transfer = pow2floor(ret);
     }
 
-    raw_probe_alignment(bs, s->fd, errp);
-    bs->bl.min_mem_alignment = s->buf_align;
-    bs->bl.opt_mem_alignment = MAX(s->buf_align, qemu_real_host_page_size);
+    ret = get_max_segments(s->fd);
+    if (ret > 0) {
+        bs->bl.max_transfer = MIN_NON_ZERO(bs->bl.max_transfer,
+                                           ret * qemu_real_host_page_size);
+    }
+
+    raw_refresh_limits(bs, errp);
 }
 
 static int check_for_dasd(int fd)
@@ -3604,7 +3609,7 @@ static BlockDriver bdrv_host_device = {
     .bdrv_co_pdiscard       = hdev_co_pdiscard,
     .bdrv_co_copy_range_from = raw_co_copy_range_from,
     .bdrv_co_copy_range_to  = raw_co_copy_range_to,
-    .bdrv_refresh_limits = raw_refresh_limits,
+    .bdrv_refresh_limits = hdev_refresh_limits,
     .bdrv_io_plug = raw_aio_plug,
     .bdrv_io_unplug = raw_aio_unplug,
     .bdrv_attach_aio_context = raw_aio_attach_aio_context,
@@ -3728,7 +3733,7 @@ static BlockDriver bdrv_host_cdrom = {
     .bdrv_co_preadv         = raw_co_preadv,
     .bdrv_co_pwritev        = raw_co_pwritev,
     .bdrv_co_flush_to_disk  = raw_co_flush_to_disk,
-    .bdrv_refresh_limits = raw_refresh_limits,
+    .bdrv_refresh_limits = hdev_refresh_limits,
     .bdrv_io_plug = raw_aio_plug,
     .bdrv_io_unplug = raw_aio_unplug,
     .bdrv_attach_aio_context = raw_aio_attach_aio_context,
-- 
2.28.0


