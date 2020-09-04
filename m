Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12DBFC43461
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 00:52:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF43B20709
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 00:52:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lBwJUhPJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF43B20709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDzxY-0007xl-0O
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 20:52:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52238)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tom.ty89@gmail.com>)
 id 1kDzwv-0007BS-3Q
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 20:51:29 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:52643)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tom.ty89@gmail.com>)
 id 1kDzwt-0001V9-Gj
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 20:51:28 -0400
Received: by mail-pj1-x1043.google.com with SMTP id o16so2382582pjr.2
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 17:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=LTKQBbgj8r6sHyXKfna5ZlCDFNvh5xC8gEHwgncf6ro=;
 b=lBwJUhPJsZFICMqIDCYczAGzqoPkn4Tk9awxgys5g/nK4CI8+8LMgB52XQZLlazR8l
 2qdQ2d9cmEkPQ7t1Na0fr+VQeCPyzEf17UbRdmquGOLLTVhO0gcgE5nfHvfaztJCPspx
 fEK3esT/uX1MXaFv3NiEWZXTHDyyc8JrnTTChGL9ZguR/YkLXOdOB3c3oAWWol0sGy9O
 mOg1fk8S2Sz7s9cZfJ8XSi1huMco0M/SxzC+ybg1gOx5T1JfTYWgZeAdKXeC/TR9fO6I
 zj8MQecoqq1Rj+OXAWHZkLHms5NlNEKbY25dD6HoLv5yQ2Bz3njk+osatc3v3JF0gqz5
 HHGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=LTKQBbgj8r6sHyXKfna5ZlCDFNvh5xC8gEHwgncf6ro=;
 b=BfwZcn/6L5WVmOrfg1Xj0/fGnQjyd+kYQk/SWZ+5sA5SIvSNyLU3Yz5f8dZpUtxQeR
 Vh0nYngl2PB6FooTVzIYthXnF/wzIhi5li99hwYFBWIMT+clHBgQH31i02GYC9Wei4jy
 hwAjGcN1IArZbn1nCgxKxgGm4BREaR1A9R4VDWK7/Sl4Jqtv2QDUFhhLzB9Q5+fk0Q53
 GBebhEV9i+pa+CJcT/2owuTWMAqppGmZdldoww+/GQxeVS5r5mR618ZM+T6Aoe9NN4qQ
 7KyB4Qcn8SQDIM8UVbhQ1se3Bcg3/boTHtu0gpXAb32vA4L5Ai+l8nL7uVUoZIdwHmw6
 KwAA==
X-Gm-Message-State: AOAM5333wCFuQhkaFas0WHoblP3D36AgPRnBrXNkOxjHzKyFN1cwvxLh
 TElMFxfEg3MME8eH7OHlFBrLKDETJI4=
X-Google-Smtp-Source: ABdhPJyFpmhcaL/zJcm3Dne2RcAGGlCSQ166HqlQY5DQCp2udW/0zQ2H9HmFDIdpyBPxpXiVtG8ttg==
X-Received: by 2002:a17:90a:ae15:: with SMTP id
 t21mr5833291pjq.224.1599180685726; 
 Thu, 03 Sep 2020 17:51:25 -0700 (PDT)
Received: from localhost.localdomain ([161.81.62.213])
 by smtp.gmail.com with ESMTPSA id u22sm3685652pgi.85.2020.09.03.17.51.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2020 17:51:25 -0700 (PDT)
From: Tom Yan <tom.ty89@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/2] file-posix: split hdev_refresh_limits from
 raw_refresh_limits
Date: Fri,  4 Sep 2020 08:51:17 +0800
Message-Id: <20200904005118.151296-1-tom.ty89@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <CAGnHSEnK_xPv_=kUBcLcPDw-UMh9XST_c=TLAo=NV2cMk9sHJw@mail.gmail.com>
References: <CAGnHSEnK_xPv_=kUBcLcPDw-UMh9XST_c=TLAo=NV2cMk9sHJw@mail.gmail.com>
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

We can and should get max transfer length and max segments for all host
devices / cdroms (on Linux).

Also use MIN_NON_ZERO instead when we clamp max transfer length against
max segments.

Signed-off-by: Tom Yan <tom.ty89@gmail.com>
---
v2: fix get_max_transfer_length for non-sg devices; also add/fix
sg_get_max_segments for sg devices
 block/file-posix.c | 56 +++++++++++++++++++++++++++++++++-------------
 1 file changed, 40 insertions(+), 16 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index 9a00d4190a..0c9124c8aa 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -1178,7 +1178,23 @@ static int sg_get_max_transfer_length(int fd)
 #endif
 }
 
-static int sg_get_max_segments(int fd)
+static int get_max_transfer_length(int fd)
+{
+#if defined(BLKSECTGET) && defined(BLKSSZGET)
+    int sect = 0;
+    int ssz = 0;
+
+    if (ioctl(fd, BLKSECTGET, &sect) == 0 && ioctl(fd, BLKSSZGET, &ssz)) {
+        return sect * ssz;
+    } else {
+        return -errno;
+    }
+#else
+    return -ENOSYS;
+#endif
+}
+
+static int get_max_segments(int fd)
 {
 #ifdef CONFIG_LINUX
     char buf[32];
@@ -1233,23 +1249,31 @@ static void raw_refresh_limits(BlockDriverState *bs, Error **errp)
 {
     BDRVRawState *s = bs->opaque;
 
-    if (bs->sg) {
-        int ret = sg_get_max_transfer_length(s->fd);
+    raw_probe_alignment(bs, s->fd, errp);
+    bs->bl.min_mem_alignment = s->buf_align;
+    bs->bl.opt_mem_alignment = MAX(s->buf_align, qemu_real_host_page_size);
+}
+
+static void hdev_refresh_limits(BlockDriverState *bs, Error **errp)
+{
+    BDRVRawState *s = bs->opaque;
+
+    /* BLKSECTGET has always been implemented wrongly in the sg driver
+       and BLKSSZGET has never been supported by it*/
+    int ret = bs->sg ? sg_get_max_transfer_length(s->fd) :
+                       get_max_transfer_length(s->fd);
 
-        if (ret > 0 && ret <= BDRV_REQUEST_MAX_BYTES) {
-            bs->bl.max_transfer = pow2floor(ret);
-        }
+    if (ret > 0 && ret <= BDRV_REQUEST_MAX_BYTES) {
+        bs->bl.max_transfer = pow2floor(ret);
+    }
 
-        ret = sg_get_max_segments(s->fd);
-        if (ret > 0) {
-            bs->bl.max_transfer = MIN(bs->bl.max_transfer,
-                                      ret * qemu_real_host_page_size);
-        }
+    ret = get_max_segments(s->fd);
+    if (ret > 0) {
+        bs->bl.max_transfer = MIN_NON_ZERO(bs->bl.max_transfer,
+                                           ret * qemu_real_host_page_size);
     }
 
-    raw_probe_alignment(bs, s->fd, errp);
-    bs->bl.min_mem_alignment = s->buf_align;
-    bs->bl.opt_mem_alignment = MAX(s->buf_align, qemu_real_host_page_size);
+    raw_refresh_limits(bs, errp);
 }
 
 static int check_for_dasd(int fd)
@@ -3604,7 +3628,7 @@ static BlockDriver bdrv_host_device = {
     .bdrv_co_pdiscard       = hdev_co_pdiscard,
     .bdrv_co_copy_range_from = raw_co_copy_range_from,
     .bdrv_co_copy_range_to  = raw_co_copy_range_to,
-    .bdrv_refresh_limits = raw_refresh_limits,
+    .bdrv_refresh_limits = hdev_refresh_limits,
     .bdrv_io_plug = raw_aio_plug,
     .bdrv_io_unplug = raw_aio_unplug,
     .bdrv_attach_aio_context = raw_aio_attach_aio_context,
@@ -3728,7 +3752,7 @@ static BlockDriver bdrv_host_cdrom = {
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


