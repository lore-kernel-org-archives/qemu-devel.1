Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A655C43463
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 11:37:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF40720BED
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 11:37:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N234ZGF4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF40720BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKK7z-00037k-Ma
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 07:37:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42510)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kKK16-0002ir-HQ
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 07:29:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27039
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kKK14-0000fw-La
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 07:29:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600687793;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Msq8goiUIrREy947KknDtEH1ZqD2k0E/AfsZQGv/SGY=;
 b=N234ZGF4POsHlYU3kKZWv6ex0ai//lf/vUAYC02vLLb2FTpemfpZ8qUGUMxDxHBoBT8t7X
 KoV87ojDAvTfdsr7ODRph+tvJnKcv9lfoc/fGwQbmOwpZiGJGxC5WSo3Op21NHl7pFUJ6i
 MdJ08h52P2JHJ5ji1nrlRNxx9rRGjGM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-164-yHIKNOdKNhiRV2ymp9RrTw-1; Mon, 21 Sep 2020 07:29:51 -0400
X-MC-Unique: yHIKNOdKNhiRV2ymp9RrTw-1
Received: by mail-wm1-f69.google.com with SMTP id l15so3619201wmh.9
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2020 04:29:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Msq8goiUIrREy947KknDtEH1ZqD2k0E/AfsZQGv/SGY=;
 b=ff2uySe4jDkqvPvyUiyN/sJCwNUyrHlyqPbvaR5d6c4bWx9vKk/10EwrzbmP5PYYNx
 7eUyrOC47odqxTPiTshb1pVj1T+z/YGXGv72Wz64ekJx3HLnbp0cy8CuDbSEYTYWfvY4
 2S962eiP1KMWvstO/5RBEQnhCC0/jwEA8yAJRNJACa19GzlxUnlxpPa8hGYOceqYYgs9
 5QirBdLPhHclfvSqEJMHN0Gh2pArhRSEflkTqkCCp6vCGJoL/8rzfafY1KkMPpFeP+D2
 1Saa6T5GiNw5/7AfnntNE8bvlF92gfXGTLmWKzf+Pf2zeAr6vsPcvqWEr2V0807BvThC
 DNYA==
X-Gm-Message-State: AOAM530R1xcMowAh6yWZcvEEFXsqa/SDTnOOEqgHAIw5pVpFiHKhLrW8
 WN66IuG4VkWqLqO7MPekMuvAkadvBaIJVS3cKnzaIOyl7bRsUKhM9BbobuHm+U3rvm1/QRkEzVk
 MC3k9rwNm7z5giTQ=
X-Received: by 2002:a1c:dec2:: with SMTP id v185mr29269727wmg.1.1600687789879; 
 Mon, 21 Sep 2020 04:29:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzCJrDHaWQhXZOcIDWttSNTjKvZZYBkk9I2tAvMFQ+hE/lPA4vt2knzTCIUSK2JEgiksYiZyw==
X-Received: by 2002:a1c:dec2:: with SMTP id v185mr29269706wmg.1.1600687789666; 
 Mon, 21 Sep 2020 04:29:49 -0700 (PDT)
Received: from redhat.com (bzq-109-65-116-225.red.bezeqint.net.
 [109.65.116.225])
 by smtp.gmail.com with ESMTPSA id j26sm21906061wrc.79.2020.09.21.04.29.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2020 04:29:49 -0700 (PDT)
Date: Mon, 21 Sep 2020 07:29:47 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v3 04/15] virtio-mem: detach the element from the virtqueue
 when error occurs
Message-ID: <20200921112913.555392-5-mst@redhat.com>
References: <20200921112913.555392-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200921112913.555392-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 04:38:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Li Qiang <liq3ea@163.com>,
 David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Li Qiang <liq3ea@163.com>

If error occurs while processing the virtio request we should call
'virtqueue_detach_element' to detach the element from the virtqueue
before free the elem.

Signed-off-by: Li Qiang <liq3ea@163.com>
Message-Id: <20200816142245.17556-1-liq3ea@163.com>
Fixes: 910b25766b ("virtio-mem: Paravirtualized memory hot(un)plug")
Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio-mem.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
index 8fbec77ccc..7c8ca9f28b 100644
--- a/hw/virtio/virtio-mem.c
+++ b/hw/virtio/virtio-mem.c
@@ -318,6 +318,7 @@ static void virtio_mem_handle_request(VirtIODevice *vdev, VirtQueue *vq)
         if (iov_to_buf(elem->out_sg, elem->out_num, 0, &req, len) < len) {
             virtio_error(vdev, "virtio-mem protocol violation: invalid request"
                          " size: %d", len);
+            virtqueue_detach_element(vq, elem, 0);
             g_free(elem);
             return;
         }
@@ -327,6 +328,7 @@ static void virtio_mem_handle_request(VirtIODevice *vdev, VirtQueue *vq)
             virtio_error(vdev, "virtio-mem protocol violation: not enough space"
                          " for response: %zu",
                          iov_size(elem->in_sg, elem->in_num));
+            virtqueue_detach_element(vq, elem, 0);
             g_free(elem);
             return;
         }
@@ -348,6 +350,7 @@ static void virtio_mem_handle_request(VirtIODevice *vdev, VirtQueue *vq)
         default:
             virtio_error(vdev, "virtio-mem protocol violation: unknown request"
                          " type: %d", type);
+            virtqueue_detach_element(vq, elem, 0);
             g_free(elem);
             return;
         }
-- 
MST


