Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26408C00A89
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 20:38:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 639CB20678
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 20:38:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ssb4m1hn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 639CB20678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZgab-0007GV-00
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 15:38:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45430)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kZgYu-0006oO-TL
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 15:36:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36147)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kZgYs-0007V8-3L
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 15:36:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604349375;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=BU3kv5r4pwOUhlFCQ3R/8SVU+fQ/GS0GrUyOz60uz1E=;
 b=Ssb4m1hnU6+v6ZLc9U1kxyWie+d2bsDc7JvVKap7m1OFxobw09hzsUM3gNx+g2mFvCuvRe
 dEdmZ2YQ4XbnQiuQs8uohOjKZEz6ounKHbPXjLtt7vv3cgaSHQOdISTXT/ty+YScYSHJql
 Rw/ExTey8WrO34xzOfGcXLlL2TDXedU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-380-syvk8gmRP92DVxIOdElI-Q-1; Mon, 02 Nov 2020 15:36:14 -0500
X-MC-Unique: syvk8gmRP92DVxIOdElI-Q-1
Received: by mail-wr1-f70.google.com with SMTP id 2so6905567wrd.14
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2020 12:36:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=BU3kv5r4pwOUhlFCQ3R/8SVU+fQ/GS0GrUyOz60uz1E=;
 b=rsGnzT+TRMhlrrR0EODqC0PuSDjze8yPn0EK3b5skO8oyjJ2rAOeziAUAhpxNnBIjV
 v9b4ko43HBnx90lhy+8b4cWV9OB5FuR28bv4URgsTqnP6JtMrsl91w+6Kg6mAKq/A8ot
 39xpoP0pBKbcB0LbZzFsOX7cDFmHaY9rtcHrGdSj+Tw3qPi0PwKZ5kpvx8R93OKXOnD/
 oirtP1iEzj9O/98AmxrY/Xhdd7qTfkE99JyeojRNu3xpSZNQ3f4HMXThxBFI0yzJroYm
 DarNFMkqX5O0CimllmzZrBiT8RmypaEMD5H47OhlfIMivYtfVuWV6OyKY51WOomHIOBI
 XLPQ==
X-Gm-Message-State: AOAM5310F6DadlHh5teDNydX0tTMNFOGeDxq8fV8/6ebcNLkPpT0vCto
 whUuAShJhXvmL2Do1eObkMVWproIvwvY/y/hP18a2bY3wGlME4Uun/YeTZuDQlL1SZXZNWeXusT
 ivNMOpwN9phhSVXw=
X-Received: by 2002:adf:b109:: with SMTP id l9mr9364860wra.279.1604349371870; 
 Mon, 02 Nov 2020 12:36:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxT4uH0wNFvHO9xWbOQYEGYq8YE56GMSao42N/Al3Oi1HbomM0qZXevWYHxXzCAtce5LRITlA==
X-Received: by 2002:adf:b109:: with SMTP id l9mr9364845wra.279.1604349371643; 
 Mon, 02 Nov 2020 12:36:11 -0800 (PST)
Received: from x1w.redhat.com (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id x10sm22738918wrp.62.2020.11.02.12.36.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2020 12:36:10 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.2] hw/virtio/vhost-backend: Fix Coverity CID 1432871
Date: Mon,  2 Nov 2020 21:36:09 +0100
Message-Id: <20201102203609.2228309-1-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 03:02:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fix uninitialized value issues reported by Coverity:

  Field 'msg.reserved' is uninitialized when calling write().

Reported-by: Coverity (CID 1432864: UNINIT)
Fixes: c471ad0e9bd ("vhost_net: device IOTLB support")
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/virtio/vhost-backend.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/vhost-backend.c b/hw/virtio/vhost-backend.c
index 88c8ecc9e03..222bbcc62de 100644
--- a/hw/virtio/vhost-backend.c
+++ b/hw/virtio/vhost-backend.c
@@ -257,7 +257,7 @@ static int vhost_kernel_send_device_iotlb_msg(struct vhost_dev *dev,
                                               struct vhost_iotlb_msg *imsg)
 {
     if (dev->backend_cap & (1ULL << VHOST_BACKEND_F_IOTLB_MSG_V2)) {
-        struct vhost_msg_v2 msg;
+        struct vhost_msg_v2 msg = {};
 
         msg.type = VHOST_IOTLB_MSG_V2;
         msg.iotlb = *imsg;
@@ -267,7 +267,7 @@ static int vhost_kernel_send_device_iotlb_msg(struct vhost_dev *dev,
             return -EFAULT;
         }
     } else {
-        struct vhost_msg msg;
+        struct vhost_msg msg = {};
 
         msg.type = VHOST_IOTLB_MSG;
         msg.iotlb = *imsg;
-- 
2.26.2


