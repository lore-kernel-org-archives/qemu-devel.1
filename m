Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8377C28CC5
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 20:11:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1743206BB
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 20:11:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1743206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49222 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYcGF-0003PO-Ra
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 16:11:51 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34082)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hYc5P-00034G-2z
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 16:00:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hYc5K-0005Yb-LI
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 16:00:38 -0400
Received: from mail-qt1-f172.google.com ([209.85.160.172]:40908)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hYc5K-0005O7-Ep
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 16:00:34 -0400
Received: by mail-qt1-f172.google.com with SMTP id a15so5013126qtn.7
	for <qemu-devel@nongnu.org>; Wed, 05 Jun 2019 13:00:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:content-transfer-encoding
	:in-reply-to;
	bh=iiDzl4UMV1aoKP5peI6KxUVyGaqr+EjtWQoUZIGhRlM=;
	b=F6obAn+MzUySQfoYi1NyI/gAdn3KzrZEF5Y4FIpzKdAHpXdN6/vuyVDWnq/gRs4RRH
	Y66VMZ9giwatxIdq3gdhtQX3622AW5Ait2Bcrjj2P5ftqiWcWAyCEQmlIfRJLCgvyvkc
	Jmihiey2yRcKwraxApsT/QmYo8ay8OlgMBhij5Bv7zjbe1oG1hTWRHEK6I812D1+ur0G
	DSk7gTrzTt81A7YhekB9n1D8C98cVzXkF2ht/zrUvepTNsZFqpuDbn/sqzUhsjcAipec
	CxUe5EAUJ4nR3tEd71Wd3cYxnfqejcgO4d0ulyIH0nIr5zPEduXRFRZy85WqQpw48e2f
	qsug==
X-Gm-Message-State: APjAAAWPcPLrKsfavE5I23dirBWOKlAF41HMlqBjvZoAmUeMITIkhBuX
	1KF1r87//wrJM5z0hEzx0SX/7CLV/pc=
X-Google-Smtp-Source: APXvYqyJUlOErrtQNIVDXRJfs9ypAMXDQWHxbfLul+X8KzcHwVNhZ0nIKpPDWljWO6n7B97En7kSSg==
X-Received: by 2002:ac8:21f8:: with SMTP id 53mr36499768qtz.16.1559764829009; 
	Wed, 05 Jun 2019 13:00:29 -0700 (PDT)
Received: from redhat.com (pool-100-0-197-103.bstnma.fios.verizon.net.
	[100.0.197.103]) by smtp.gmail.com with ESMTPSA id
	d188sm12711328qkf.40.2019.06.05.13.00.27
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Wed, 05 Jun 2019 13:00:28 -0700 (PDT)
Date: Wed, 5 Jun 2019 16:00:27 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <1556605773-42019-1-git-send-email-wangjie88@huawei.com>
References: <20190605195913.12243-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190605195913.12243-1-mst@redhat.com>
X-Mailer: git-send-email 2.17.1.1206.gb667731e2e.dirty
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.160.172
Subject: [Qemu-devel] [PULL v3 08/17] vhost: fix incorrect print type
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	Jie Wang <wangjie88@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190605200027.XGvsxXjv-ZindZuB-nk8u6ZBbFhE3dEeBerM5H_G0cc@z>

From: Jie Wang <wangjie88@huawei.com>

fix incorrect print type in vhost_virtqueue_stop

Signed-off-by: Jie Wang <wangjie88@huawei.com>
Message-Id: <1556605773-42019-1-git-send-email-wangjie88@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/virtio/vhost.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 2303a8c206..60747a6f93 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1081,7 +1081,7 @@ static void vhost_virtqueue_stop(struct vhost_dev *dev,
 
     r = dev->vhost_ops->vhost_get_vring_base(dev, &state);
     if (r < 0) {
-        VHOST_OPS_DEBUG("vhost VQ %d ring restore failed: %d", idx, r);
+        VHOST_OPS_DEBUG("vhost VQ %u ring restore failed: %d", idx, r);
         /* Connection to the backend is broken, so let's sync internal
          * last avail idx to the device used idx.
          */
-- 
MST


