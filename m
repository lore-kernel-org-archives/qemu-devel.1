Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D672C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 18:59:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B7112080D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 18:58:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fwnkbtq9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B7112080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaNzm-0003uQ-LS
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 13:58:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52812)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kaNk9-0001yo-B3
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 13:42:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39388)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kaNk7-00028U-BO
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 13:42:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604515365;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lgzOL39RvILiPn2GJxc4fQ6TNHjpeFII29h+nk2BQE8=;
 b=Fwnkbtq9BaHYh3pHRe9cQ99tIkcyXMV6llRZdXjtRCzETNPgR2XNUH65S5xJi+znTUkC5E
 11jhhsqBmK7y/eg6hp1ZhkFpwrDwMm5FPh8CGmW8+nzMW6eoH2fThYuxtA/OMgkw54u+D3
 CZ6f5YgMn6k5TcGiOLdXtwcHeO9ROSw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-359-lfyuBmhFNWakw0cdJBMx4A-1; Wed, 04 Nov 2020 13:42:44 -0500
X-MC-Unique: lfyuBmhFNWakw0cdJBMx4A-1
Received: by mail-wm1-f70.google.com with SMTP id s85so937419wme.3
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2020 10:42:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=lgzOL39RvILiPn2GJxc4fQ6TNHjpeFII29h+nk2BQE8=;
 b=fDFf9FoICewMaqjftrEZkYreOmZxc9/DKbmG0ef8vsIYsrsW2hWbGmMOc5HnG18A1G
 Vg8qMb492JlrxtE8T4eQdXjLc/6NixFx1SFcMW2Xkg7WDwcL6fPiYGJFE/R8yWvgbDPZ
 0ZHNHbbwU1DW4D+nSIHiaQ5b/DCc+HXV5Ql8Hf4k2MGd8Rz0BfoDU6tmBiW+hOBBjlS1
 jwHESARZuMWgDbYs80VYf22cWUiiekIE28RNoZ+w2q9/ronX9+p8N7Wc9skJC8Kfj0vQ
 nOkohM4XALyrHcIP9hlkdOCfZ64OrP53VA81lLXTBXdll6g1HUZSAy/PlJ+pGot+b+nA
 0Mxw==
X-Gm-Message-State: AOAM532BvxwY5k/NegVsNJgGnkMYR0Q4JeU6yL1lANo0shXhLyZD4krx
 NoM8uFCXJZIFoECEGs0G3G8RLss5Mq9EpPRkxh6D9NAGMwLiPDoN72jciHOduScBUSvwR+Ice+s
 yc5VFygV62Ksqic8=
X-Received: by 2002:adf:e9c9:: with SMTP id l9mr8431599wrn.124.1604515361808; 
 Wed, 04 Nov 2020 10:42:41 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxTcJLSHxH3PGFi/fNvLyrrS4HgRYD6PEumFBMr7BMTzfz416uV3ndBtMzgulumqZcCK34lMg==
X-Received: by 2002:adf:e9c9:: with SMTP id l9mr8431583wrn.124.1604515361600; 
 Wed, 04 Nov 2020 10:42:41 -0800 (PST)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
 by smtp.gmail.com with ESMTPSA id d3sm3528606wre.91.2020.11.04.10.42.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2020 10:42:40 -0800 (PST)
Date: Wed, 4 Nov 2020 13:42:39 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v3 29/31] block/export: make vhost-user-blk config space
 little-endian
Message-ID: <20201104184040.285057-30-mst@redhat.com>
References: <20201104184040.285057-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201104184040.285057-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 00:03:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org, Coiby Xu <Coiby.Xu@gmail.com>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Stefan Hajnoczi <stefanha@redhat.com>

VIRTIO 1.0 devices have little-endian configuration space. The
vhost-user-blk-server.c code already uses little-endian for virtqueue
processing but not for the configuration space fields. Fix this so the
vhost-user-blk export works on big-endian hosts.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-Id: <20201027173528.213464-4-stefanha@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 block/export/vhost-user-blk-server.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/block/export/vhost-user-blk-server.c b/block/export/vhost-user-blk-server.c
index 41f4933d6e..33cc0818b8 100644
--- a/block/export/vhost-user-blk-server.c
+++ b/block/export/vhost-user-blk-server.c
@@ -264,7 +264,6 @@ static uint64_t vu_blk_get_protocol_features(VuDev *dev)
 static int
 vu_blk_get_config(VuDev *vu_dev, uint8_t *config, uint32_t len)
 {
-    /* TODO blkcfg must be little-endian for VIRTIO 1.0 */
     VuServer *server = container_of(vu_dev, VuServer, vu_dev);
     VuBlkExport *vexp = container_of(server, VuBlkExport, vu_server);
     memcpy(config, &vexp->blkcfg, len);
@@ -343,18 +342,18 @@ vu_blk_initialize_config(BlockDriverState *bs,
                          uint32_t blk_size,
                          uint16_t num_queues)
 {
-    config->capacity = bdrv_getlength(bs) >> BDRV_SECTOR_BITS;
-    config->blk_size = blk_size;
-    config->size_max = 0;
-    config->seg_max = 128 - 2;
-    config->min_io_size = 1;
-    config->opt_io_size = 1;
-    config->num_queues = num_queues;
-    config->max_discard_sectors = 32768;
-    config->max_discard_seg = 1;
-    config->discard_sector_alignment = config->blk_size >> 9;
-    config->max_write_zeroes_sectors = 32768;
-    config->max_write_zeroes_seg = 1;
+    config->capacity = cpu_to_le64(bdrv_getlength(bs) >> BDRV_SECTOR_BITS);
+    config->blk_size = cpu_to_le32(blk_size);
+    config->size_max = cpu_to_le32(0);
+    config->seg_max = cpu_to_le32(128 - 2);
+    config->min_io_size = cpu_to_le16(1);
+    config->opt_io_size = cpu_to_le32(1);
+    config->num_queues = cpu_to_le16(num_queues);
+    config->max_discard_sectors = cpu_to_le32(32768);
+    config->max_discard_seg = cpu_to_le32(1);
+    config->discard_sector_alignment = cpu_to_le32(config->blk_size >> 9);
+    config->max_write_zeroes_sectors = cpu_to_le32(32768);
+    config->max_write_zeroes_seg = cpu_to_le32(1);
 }
 
 static void vu_blk_exp_request_shutdown(BlockExport *exp)
-- 
MST


