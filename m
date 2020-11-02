Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3EA6C00A89
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 10:19:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72332222B9
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 10:19:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IlVPlXAu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72332222B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZWvw-0005U8-A7
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 05:19:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55346)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kZWps-0007cu-Nc
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 05:13:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28645)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kZWpq-00072h-U6
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 05:13:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604311990;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type;
 bh=+e5m0qkU8IZ1dkUMkaUXDUZye21tgFmNOZ5OFmTpaQY=;
 b=IlVPlXAuvHyvsLi0P1VAImGn/lLCvJUSe5MIgSL1ANRtgjVu0YGouRgHXPM3e96Igf85Jc
 S9GlR5LZrzVHQ/QM+NsMyJ0WsinJAlMu9+6LeXT3zRm3Qmf3Fyzo59adMiipo8IuNUY0vf
 e9D3j95+Pqec/7/Q2hzFgrREXp6V8fA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-368-ivWxeIMYNHGU6B1N86XyiQ-1; Mon, 02 Nov 2020 05:13:08 -0500
X-MC-Unique: ivWxeIMYNHGU6B1N86XyiQ-1
Received: by mail-wm1-f69.google.com with SMTP id o19so3170245wme.2
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2020 02:13:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:subject:message-id:mime-version
 :content-disposition;
 bh=+e5m0qkU8IZ1dkUMkaUXDUZye21tgFmNOZ5OFmTpaQY=;
 b=DaV5SIE1WDVlazhFiX9Lo2cAhXYDA3x/WoHwVia9SrguU6o0zvdEhVE/QICrC9S+XV
 dQH7iLhWTumzaL+681+CBUXsEynzK6BI++ERDRr9jMJ7+1561eyW4A24gwzCvtkxlpHH
 jYngYCrWDeWgXS25Zx8V/wnY6HTIgL/tDJfOErzwOqLM5rfjvpYGKkd6WzrT0b6h6SOC
 K5Fq592dvkiLpPJNc0DnXDgYibxEXpXQBPUVcRzLF4ti7kkXwbe3b3J/rIQw3kdJJIDq
 g6j3i06kBmQTaCwary515MKSj7EAXsNgRMzbgTKyPZoYKW/nLFKGymxbXyVfOuqwtKIz
 ju6w==
X-Gm-Message-State: AOAM532B4k7og2B77d5tL1glYOtL059zsbQtpS//VTc9O9BOnn3/EmHY
 dj+Hbleaya1uONx0851SckroSA3lNNoXXu7s2XGLD1m5bXt+tP4k6SP2ZQfWwUmgdCqhOUXljVA
 /FgWftVneS/tRWJU=
X-Received: by 2002:a1c:328a:: with SMTP id y132mr1715037wmy.134.1604311986721; 
 Mon, 02 Nov 2020 02:13:06 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyjAWvXeD+rIJuxobM89Y2OFGB8ddJ0KgUuVNAh7+BbG+RvaQbfepB6esYpa9clkoeil2gL0w==
X-Received: by 2002:a1c:328a:: with SMTP id y132mr1715029wmy.134.1604311986581; 
 Mon, 02 Nov 2020 02:13:06 -0800 (PST)
Received: from redhat.com (bzq-79-182-97-190.red.bezeqint.net. [79.182.97.190])
 by smtp.gmail.com with ESMTPSA id y187sm3040903wmg.33.2020.11.02.02.13.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2020 02:13:05 -0800 (PST)
Date: Mon, 2 Nov 2020 05:13:03 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] vhost: fix up trailing whitespace
Message-ID: <20201102101301.1101378-1-mst@redhat.com>
MIME-Version: 1.0
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 03:02:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Drop trailing whitespace in vhost.c

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/vhost.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index f2482378c6..2e904bbd62 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1648,12 +1648,12 @@ int vhost_dev_load_inflight(struct vhost_inflight *inflight, QEMUFile *f)
 int vhost_dev_prepare_inflight(struct vhost_dev *hdev)
 {
     int r;
- 
+
     if (hdev->vhost_ops->vhost_get_inflight_fd == NULL ||
         hdev->vhost_ops->vhost_set_inflight_fd == NULL) {
         return 0;
     }
- 
+
     r = vhost_dev_set_features(hdev, hdev->log_enabled);
     if (r < 0) {
         VHOST_OPS_DEBUG("vhost_dev_prepare_inflight failed");
-- 
MST


