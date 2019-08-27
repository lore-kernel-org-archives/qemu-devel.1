Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 396CFC3A5A6
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 19:02:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0980621881
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 19:02:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LhU/QzLQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0980621881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2gjd-0001aq-3I
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 15:02:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33875)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nirsof@gmail.com>) id 1i2ggd-0008Kl-V0
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 14:59:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nirsof@gmail.com>) id 1i2ggc-0006NL-OK
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 14:59:23 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:38620)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nirsof@gmail.com>)
 id 1i2ggc-0006Mq-HK; Tue, 27 Aug 2019 14:59:22 -0400
Received: by mail-wr1-x444.google.com with SMTP id e16so2768733wro.5;
 Tue, 27 Aug 2019 11:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5WYteARbw4F5SMsy3ezROwY8/lmuvqrn3c2e82dR+CI=;
 b=LhU/QzLQDQJPOddPNAx507pS8CqPjDObAoivk4qQmawxg80NZUpd0QodcwNzwkBU7w
 7Pk7xlDiu0lH2WMVyXDcsTZChJJNnr+hA+WRL9A98Fl1z61vcxJKQjnTD3YkdTjlTKae
 t2WLbcDkGzxVDO83xGsSFRI/9NVYPmP8jotf+n5V2Bklp2g2ydYQWqiWHZcvTYUZpXxg
 iDbjgGx1cMIzGU3xDhT6ZlYsqtpshiFNBAaF8wQcCsNxn+EKViaT0UDlhZnuP2NBsWPg
 H/gRULi18Cczx4LmzN5ngtjkxVupc6hgqYXIfpbm0tao57qmfV8uSoLHLGyJe7IP0jyS
 cJ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5WYteARbw4F5SMsy3ezROwY8/lmuvqrn3c2e82dR+CI=;
 b=uQUES4srtRUJKZrTUUsyYjKoxhZwS7ag9N8aUyEK15iBVZ8c1QA7NzjmSUXUSH97/d
 lP+QKVRkrwkU2HxinOfigQipFJvCQPKOw/zMcPpYyrkz5+sJ0psNrS2hv9aqReGiewWA
 aqOSR9ms/B3kJmhFLvXVbcfx5GCXCNzL15nZXrUiunwO704OwVkznimAKrp2CuaaeYWt
 ZHR+PEJs89PsrlueT9oyvxE23219ICUlaI0KH8hy2m0x7chmxqZ5gcqIeAvA9QSVItYD
 7AD+UEB31qp2Gj97us9TEO1wUjBuZT41P4IjKDlFKl6CwJwByMlQNs9ksCWRlV6xaoSc
 MbCg==
X-Gm-Message-State: APjAAAVrZ1iGGc4OfMxYRMe936eis6BUbcutd84nE+D5MguzDugXCphu
 XJQSgIsauPtq6MifP2ngqpOSXw6LnPXWEQ==
X-Google-Smtp-Source: APXvYqxagZS3jZc/wJugW9RjPGZP+DNUcsuwLNApbRn7tzxMqzGP4AhTsnXh4mZN/jjZwgGJuBZjuQ==
X-Received: by 2002:a5d:6a05:: with SMTP id m5mr32331916wru.305.1566932361121; 
 Tue, 27 Aug 2019 11:59:21 -0700 (PDT)
Received: from localhost.localdomain (109-186-142-128.bb.netvision.net.il.
 [109.186.142.128])
 by smtp.gmail.com with ESMTPSA id g26sm9926wmh.32.2019.08.27.11.59.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Aug 2019 11:59:20 -0700 (PDT)
From: Nir Soffer <nirsof@gmail.com>
X-Google-Original-From: Nir Soffer <nsoffer@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 27 Aug 2019 21:59:13 +0300
Message-Id: <20190827185913.27427-3-nsoffer@redhat.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190827185913.27427-1-nsoffer@redhat.com>
References: <20190827185913.27427-1-nsoffer@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: [Qemu-devel] [PATCH v2 2/2] block: Remove unused masks
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Nir Soffer <nsoffer@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Replace confusing usage:

    ~BDRV_SECTOR_MASK

With more clear:

    (BDRV_SECTOR_SIZE - 1)

Remove BDRV_SECTOR_MASK and the unused BDRV_BLOCK_OFFSET_MASK which was
it's last user.

Signed-off-by: Nir Soffer <nsoffer@redhat.com>
---
 include/block/block.h | 2 --
 migration/block.c     | 2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index 124ad40809..37c9de7446 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -143,7 +143,6 @@ typedef struct HDGeometry {
 
 #define BDRV_SECTOR_BITS   9
 #define BDRV_SECTOR_SIZE   (1ULL << BDRV_SECTOR_BITS)
-#define BDRV_SECTOR_MASK   ~(BDRV_SECTOR_SIZE - 1)
 
 #define BDRV_REQUEST_MAX_SECTORS MIN(SIZE_MAX >> BDRV_SECTOR_BITS, \
                                      INT_MAX >> BDRV_SECTOR_BITS)
@@ -195,7 +194,6 @@ typedef struct HDGeometry {
 #define BDRV_BLOCK_ALLOCATED    0x10
 #define BDRV_BLOCK_EOF          0x20
 #define BDRV_BLOCK_RECURSE      0x40
-#define BDRV_BLOCK_OFFSET_MASK  BDRV_SECTOR_MASK
 
 typedef QSIMPLEQ_HEAD(BlockReopenQueue, BlockReopenQueueEntry) BlockReopenQueue;
 
diff --git a/migration/block.c b/migration/block.c
index aa747b55fa..92c36b68ec 100644
--- a/migration/block.c
+++ b/migration/block.c
@@ -906,7 +906,7 @@ static int block_load(QEMUFile *f, void *opaque, int version_id)
     do {
         addr = qemu_get_be64(f);
 
-        flags = addr & ~BDRV_SECTOR_MASK;
+        flags = addr & (BDRV_SECTOR_SIZE - 1);
         addr >>= BDRV_SECTOR_BITS;
 
         if (flags & BLK_MIG_FLAG_DEVICE_BLOCK) {
-- 
2.20.1


