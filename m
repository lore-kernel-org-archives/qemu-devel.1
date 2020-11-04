Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDD34C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 05:02:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55E0A208C7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 05:02:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RjjaQe38"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55E0A208C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaAwc-00078x-Bt
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 00:02:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59556)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kaAmH-0006wu-6I
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 23:52:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43011)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kaAmF-0004oa-CF
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 23:52:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604465526;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lgzOL39RvILiPn2GJxc4fQ6TNHjpeFII29h+nk2BQE8=;
 b=RjjaQe38X7hk9q9I8nfkWRk6TKy8W1ddu4MPpd1WT+BXWs4j6I4YiuYe3zjRkokG4VSU3m
 Ab1aC/GPkrXUBItAer1KOUUui6qUSE09oaxg8w0Ux8ZTGRqu7MJJhhM6hOEbTeQ8qxPXUL
 glkHhXZ7ISTiSUu2w1DEJw2xGtszGL4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-513-F_7sRAEnPaOJbbcuYb50tw-1; Tue, 03 Nov 2020 23:52:04 -0500
X-MC-Unique: F_7sRAEnPaOJbbcuYb50tw-1
Received: by mail-wr1-f70.google.com with SMTP id w1so8715746wrr.5
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 20:52:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=lgzOL39RvILiPn2GJxc4fQ6TNHjpeFII29h+nk2BQE8=;
 b=maM/5e1M7OgENOKqAzqVTTHGM4ljum1qGFdXQA3KyPlD64+5ri0XZgl3wTXQ5qayko
 0cbRU5TOmJ/oC3r1ekh0atbi25eXSnme7ByoIXfnRH51WhnLqO4L0ovTG7xqNWVRFRSD
 r6iv9LgmyDM20Sl2bnDEobBl8QyehLts1f6YzK69ScgC6lvs+T8N7b5SzISU7MCAk6e7
 EImDAlqOV8kkvaT169WkD/QOK43DD8Zsuk9eNAWJ834pn8fDqL4rWrk8cabkYigQYcqn
 soaJ1c0oGVfYLyw7pPP78u4WUQ+Mlhm5Pn0VDEM4TBMRLs+l/P9K+zXi/ikk5COa5B1V
 OCBQ==
X-Gm-Message-State: AOAM530IkwFNjGpaovoCp4Tplr3klDXjPVG9cp19QscgLVs65UHZGY3b
 i60+7bwqsheBfj7aeP31+jz/O4s3RdMkcpvHQJAYD3iKRm4tgT9LGhy4IVdXma7WWVJ141ANRJF
 qp6F/K1gDMlWeuwI=
X-Received: by 2002:a1c:7c0e:: with SMTP id x14mr2475926wmc.88.1604465522788; 
 Tue, 03 Nov 2020 20:52:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz5DhDAtpcepurpUgZdYPNJw26kJOIbtD7ONwZ0YooCQ7nfCZwZbMFRlvOd/Mw6cR3XBcrJFA==
X-Received: by 2002:a1c:7c0e:: with SMTP id x14mr2475911wmc.88.1604465522517; 
 Tue, 03 Nov 2020 20:52:02 -0800 (PST)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
 by smtp.gmail.com with ESMTPSA id c2sm794577wmf.47.2020.11.03.20.52.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2020 20:52:01 -0800 (PST)
Date: Tue, 3 Nov 2020 23:52:00 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 29/38] block/export: make vhost-user-blk config space
 little-endian
Message-ID: <20201104044937.226370-30-mst@redhat.com>
References: <20201104044937.226370-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201104044937.226370-1-mst@redhat.com>
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


