Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22FA7C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 05:18:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9886922243
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 05:18:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NHeQlit9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9886922243
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43564 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaBBp-0002wU-HV
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 00:18:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33064)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kaAvz-0006cb-MV
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 00:02:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40311)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kaAvx-0008FD-Qb
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 00:02:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604466129;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=10gqAcInC2hOlA/e3e/PPVyOBwthTxnTi3QFwwaBdNU=;
 b=NHeQlit9TKHgeqKZ/sNJBPziujLe64bQDH/iDQ5V5W883r+SbScXp4FaWHb96DGYc+i74P
 6l3BB3MWd7y3+uq3porpvcPbBp9TYP5oS9PCwR/ifjO5+gLAwJsmlAmxD3tGJEb1oByJQ/
 8dJzftS09yOjHXpM3UGDGEf1qX0ZDo0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-10-WhqChcbEN6Ccp_DYeAL9Ig-1; Tue, 03 Nov 2020 23:52:09 -0500
X-MC-Unique: WhqChcbEN6Ccp_DYeAL9Ig-1
Received: by mail-wr1-f69.google.com with SMTP id b6so8661076wrn.17
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 20:52:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=10gqAcInC2hOlA/e3e/PPVyOBwthTxnTi3QFwwaBdNU=;
 b=Os4iKm6rksOTegP4uyZBldEajP8HYae1l4BlZRz4XDLHhIAb7R8DGgWAklNa27prDS
 jEi/HzC1QNC5hDOSXtwNNJNsN6d3zxhaIFXm2JbHn5Uy6o82j3OaMBgLbjNA1bcy14qb
 Oo5URHkljQovAvsJxDzRGknbSioi+ArjV3qBASKz6+2CKXjHeZEmJlqhB9/0ADZI5v77
 psKIBEeUcWiTqwUXr8ogUkeLx/PBgTnft+4I/ihtq0T+3Lw4xkt7T/jDusSgjSuJEaNt
 xpswLquudmsjff7ThGw84N80ctDV44jjBEUu4MJPUM1Eyl2WDV7CWVEPI9FppuElWnAi
 Onlw==
X-Gm-Message-State: AOAM532TSbur7HrxwjUlaqTDw8LCEopmAbgiewSxE5D4pHCT6rKllnQV
 MGpxA1/Xa5NCfJCN33iy6IUa4iqo3aI35UGJh/6MPFLu0/QdHJIN2bliUgqg/CeqBJtjzAdx2ay
 ZVhnHIz/18rthp7Y=
X-Received: by 2002:adf:fc83:: with SMTP id g3mr29712200wrr.200.1604465528200; 
 Tue, 03 Nov 2020 20:52:08 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzZXtbf+FdMMh6jOB0UaSiBhPZIf/pUwS6O64v5Dk/lV2cT25m3sqxDn1m4DjsjY1KdnsG3yA==
X-Received: by 2002:adf:fc83:: with SMTP id g3mr29712191wrr.200.1604465528027; 
 Tue, 03 Nov 2020 20:52:08 -0800 (PST)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
 by smtp.gmail.com with ESMTPSA id n22sm790091wmk.40.2020.11.03.20.52.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2020 20:52:07 -0800 (PST)
Date: Tue, 3 Nov 2020 23:52:05 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 31/38] contrib/vhost-user-blk: fix get_config() information
 leak
Message-ID: <20201104044937.226370-32-mst@redhat.com>
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Stefan Hajnoczi <stefanha@redhat.com>

Refuse get_config() in excess of sizeof(struct virtio_blk_config).

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-Id: <20201027173528.213464-6-stefanha@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 contrib/vhost-user-blk/vhost-user-blk.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/contrib/vhost-user-blk/vhost-user-blk.c b/contrib/vhost-user-blk/vhost-user-blk.c
index 25eccd02b5..caad88637e 100644
--- a/contrib/vhost-user-blk/vhost-user-blk.c
+++ b/contrib/vhost-user-blk/vhost-user-blk.c
@@ -404,6 +404,8 @@ vub_get_config(VuDev *vu_dev, uint8_t *config, uint32_t len)
     VugDev *gdev;
     VubDev *vdev_blk;
 
+    g_return_val_if_fail(len <= sizeof(struct virtio_blk_config), -1);
+
     gdev = container_of(vu_dev, VugDev, parent);
     vdev_blk = container_of(gdev, VubDev, parent);
     memcpy(config, &vdev_blk->blkcfg, len);
-- 
MST


