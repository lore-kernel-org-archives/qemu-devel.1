Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49242C00A89
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 14:20:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B40672076E
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 14:20:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V+KoyEvk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B40672076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYVGg-00044j-Nd
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 10:20:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46002)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kYV8f-0003iN-UZ
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 10:12:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60533)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kYV8a-0007G5-9f
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 10:12:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604067133;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hB2moo/cmsKV0TlRa+A5mqgcufQ43ovjOtrGZziNS+A=;
 b=V+KoyEvkiRU3MIQ+gYQoeJj4cGyDmqJbFJFhqnQUngEA0xykjOK912jFGR/d3KYLb0dlbB
 dGVuWZmxaFrWZ3hmmDxBRTRWdy9HZwiJe5AtadbFFv2oF9pJbB9Xfdrw+e26J7nxOAZgB3
 Lj1AJsNF8C1ZrybbilKgSuQpdd9kPwY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-529-FqOT1Xs7OLSgcj_hswXgng-1; Fri, 30 Oct 2020 10:12:11 -0400
X-MC-Unique: FqOT1Xs7OLSgcj_hswXgng-1
Received: by mail-wm1-f69.google.com with SMTP id c10so440124wmh.6
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2020 07:12:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=hB2moo/cmsKV0TlRa+A5mqgcufQ43ovjOtrGZziNS+A=;
 b=gnl156ttR+6Gn1CTu3JqqBlcfYAJStYiX4oVLeWsy5SU8r0hgT3Z9tDel4csd4OH+2
 Wo7ImTqVL2NAKqEqK039dWMjAMtOv0p6TymTWa9bqb/23rY+LBoCNAS2oMmDk3jfJVyx
 owdLR0Mt5KVV4gV5piR9+xmyprQnzGTLQYohK5RTziW9pTdjTjv7D1q8ldtAYxiiLXGI
 KAdOD/dXFo4DmfUc3tdrVSeH1NmFH0vcVS6Dxwoc7Q/bRwUq9TglkyisMXJmeYf+81N+
 Dkz7CGCDOSz1Dw+MyLHInq5InHCyfSuwC7qVwNQV3HituenUkc39kCpIX/dKceDna93b
 ATiw==
X-Gm-Message-State: AOAM532GAR0NBDPsZyHgV8rNNhxs+6EGqNgdaiOLVUbucNhNB8XpJG96
 oL/Sda4nTCbY5vFAewbuvsmopwCsVkVuCtp8SiYqshROeqAQLNfbWo6n3bEDHTQVMa8U0XPlU4w
 O6NksOIoYq5hzbNY=
X-Received: by 2002:adf:cf10:: with SMTP id o16mr3136186wrj.264.1604067129560; 
 Fri, 30 Oct 2020 07:12:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwOXgFNg4LO+U7irrJ4ZfGItiEcSJhOgCYjGmSqPSQQuLf8S0P2kbGnfhHYpJFDbFCO6lf5vQ==
X-Received: by 2002:adf:cf10:: with SMTP id o16mr3136118wrj.264.1604067128824; 
 Fri, 30 Oct 2020 07:12:08 -0700 (PDT)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
 by smtp.gmail.com with ESMTPSA id p4sm11205572wrf.67.2020.10.30.07.12.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2020 07:12:08 -0700 (PDT)
Date: Fri, 30 Oct 2020 10:12:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 08/15] vhost: Don't special case vq->used_phys in
 vhost_get_log_size()
Message-ID: <20201030141136.1013521-9-mst@redhat.com>
References: <20201030141136.1013521-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201030141136.1013521-1-mst@redhat.com>
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
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/30 02:24:40
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Greg Kurz <groug@kaod.org>

The first loop in vhost_get_log_size() computes the size of the dirty log
bitmap so that it allows to track changes in the entire guest memory, in
terms of GPA.

When not using a vIOMMU, the address of the vring's used structure,
vq->used_phys, is a GPA. It is thus already covered by the first loop.

When using a vIOMMU, vq->used_phys is a GIOVA that will be translated
to an HVA when the vhost backend needs to update the used structure. It
will log the corresponding GPAs into the bitmap but it certainly won't
log the GIOVA.

So in any case, vq->used_phys shouldn't be explicitly used to size the
bitmap. Drop the second loop.

This fixes a crash of the source when migrating a guest using in-kernel
vhost-net and iommu_platform=on on POWER, because DMA regions are put
over 0x800000000000000ULL. The resulting insanely huge log size causes
g_malloc0() to abort.

BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1879349
Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <160208823418.29027.15172801181796272300.stgit@bahia.lan>
Acked-by: Jason Wang <jasowang@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/vhost.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 3077fa6ef5..79b2be20df 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -172,16 +172,6 @@ static uint64_t vhost_get_log_size(struct vhost_dev *dev)
                                        reg->memory_size);
         log_size = MAX(log_size, last / VHOST_LOG_CHUNK + 1);
     }
-    for (i = 0; i < dev->nvqs; ++i) {
-        struct vhost_virtqueue *vq = dev->vqs + i;
-
-        if (!vq->used_phys && !vq->used_size) {
-            continue;
-        }
-
-        uint64_t last = vq->used_phys + vq->used_size - 1;
-        log_size = MAX(log_size, last / VHOST_LOG_CHUNK + 1);
-    }
     return log_size;
 }
 
-- 
MST


