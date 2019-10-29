Return-Path: <SRS0=qR42=YW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 188B3CA9EAE
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 23:11:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD1C020862
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 23:11:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD1C020862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPaeK-0001bW-Tr
	for qemu-devel@archiver.kernel.org; Tue, 29 Oct 2019 19:11:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43854)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iPaUS-0000ol-Jn
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 19:01:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iPaUN-0004oN-LN
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 19:01:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59888)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iPaUN-0004nL-F5
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 19:01:23 -0400
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 457B485537
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2019 23:01:22 +0000 (UTC)
Received: by mail-qt1-f199.google.com with SMTP id j18so485428qtp.23
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2019 16:01:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=SAGSm3HdYmq5vXqb4Jwep3dozuZUGtFJaG0w35dhzss=;
 b=l1Ql5wOc7oRYahHRTtQI282rVArN5BcegUt6l+Q1or5NF5aN1HpzDQQ1pHWzIXfF6d
 3Jp6nuEuWix04m33HAU+A1tw0mTxbA8WRulpoP7z3LrFnAWBv4/T1XKVR0cafLLSvUQ2
 V2vzDl0dvKu5NV/skor7wmHTAv/ekWkFjK3Jmcx+hSs5L8rSkYG9KyL1q/K5fAQoHFZJ
 yiTJxiYpOpxyfJkE6bbFJASV8hE5WidHLji8Fb8V2sVDorGx+dag+3q++pqzQZUobB1w
 lji7WI/HnljV17V6fmK1kqD5CClu6B2K/O0OLgvNwTLAE1MEsdv6HNnrWL2Wuth3i8vc
 IJUA==
X-Gm-Message-State: APjAAAV5Xz3ZowATk96YxXm3oOqPuLXgXc3xEmSVbH2ptK/v4VgAOZUQ
 G+DOPG1KNJEBgh61VaKd4hqRyPqYak/Nkb2PbBBC3u+nT5NffiSgQA8RrHNlJ4A2X1fuCv0XLHk
 DaDR0gXYfAWbhQLo=
X-Received: by 2002:a0c:cdc5:: with SMTP id a5mr18908557qvn.121.1572390081056; 
 Tue, 29 Oct 2019 16:01:21 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxLu0oJglOMw5JqfzkyT8jshUMYtiHl6vUa2MaQmuEE6uNgGEHSorDDaTlVfudHkazMx5+NeQ==
X-Received: by 2002:a0c:cdc5:: with SMTP id a5mr18908520qvn.121.1572390080780; 
 Tue, 29 Oct 2019 16:01:20 -0700 (PDT)
Received: from redhat.com (94.222.26.109.rev.sfr.net. [109.26.222.94])
 by smtp.gmail.com with ESMTPSA id 189sm394719qki.10.2019.10.29.16.01.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2019 16:01:20 -0700 (PDT)
Date: Tue, 29 Oct 2019 19:01:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 12/14] virtio/vhost: Use auto_rcu_read macros
Message-ID: <20191029225932.14585-13-mst@redhat.com>
References: <20191029225932.14585-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191029225932.14585-1-mst@redhat.com>
X-Mailer: git-send-email 2.22.0.678.g13338e74b8
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Use RCU_READ_LOCK_GUARD instead of manual rcu_read_(un)lock

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Message-Id: <20191025103403.120616-2-dgilbert@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/vhost.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 99de5f196f..4da0d5a6c5 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -924,7 +924,7 @@ int vhost_device_iotlb_miss(struct vhost_dev *dev, uint64_t iova, int write)
     uint64_t uaddr, len;
     int ret = -EFAULT;
 
-    rcu_read_lock();
+    RCU_READ_LOCK_GUARD();
 
     trace_vhost_iotlb_miss(dev, 1);
 
@@ -956,8 +956,6 @@ int vhost_device_iotlb_miss(struct vhost_dev *dev, uint64_t iova, int write)
     trace_vhost_iotlb_miss(dev, 2);
 
 out:
-    rcu_read_unlock();
-
     return ret;
 }
 
-- 
MST


