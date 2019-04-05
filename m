Return-Path: <SRS0=1I+v=SH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF24FC282CE
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 23:16:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 752A72175B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 23:16:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 752A72175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48073 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hCY4T-0006Nn-9f
	for qemu-devel@archiver.kernel.org; Fri, 05 Apr 2019 19:16:29 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hCY0t-0003Yv-1a
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 19:12:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hCY0s-0003oe-5S
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 19:12:47 -0400
Received: from mail-qt1-f175.google.com ([209.85.160.175]:45214)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hCY0r-0003ks-KR
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 19:12:46 -0400
Received: by mail-qt1-f175.google.com with SMTP id v20so9301384qtv.12
	for <qemu-devel@nongnu.org>; Fri, 05 Apr 2019 16:12:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to;
	bh=MVOXtsb2YrBTbkuBhqpXbmOgis7xBwIRHOVg/IfZ32w=;
	b=dHQxsWljQqC/UfDHUu6t84Ua8y8fWwlTKDfLzEE+0PIwoJ7Da1+WTd77SgcVyovRG4
	4SMlKFjgIrhA9ERE7fqwZWLkSR7tA1Ev2pg7lV8hP2+v96SZ0We63nYTcTsgh02GGPc+
	NuDxCF2XsWe4QY1I4aRAcnBoOa3SbEwnqI6XXeYh92/zoymOl1gFMwTvQKCoTPA6hRYl
	3TkMPamDWjoBl8v9A9LRjWp7ql0vWbbuFW0VvrRlbz7NnkABNyQaAXIVQhNz2WpHW6WC
	x2vqPJTIY+gRcO9E4QVOEI1ESlF1tFS+0cnI4amFmjCv3P7Q9FAwyvAPRqu5DR9nanl1
	2WxA==
X-Gm-Message-State: APjAAAVhkjaAG0vYPss55iSfxAlnnBpqhFJSJueBU7kx05Wlw2TjPem1
	QFY39g/Q6sF9i6DYGpWpWFJSvccDv8g=
X-Google-Smtp-Source: APXvYqzpnPOxVlSih+2HisjGBJyiovvXI6HIiDCR/5ZImHAGx0CkdLtWM6URuvkIuyygMJIIz+mX4Q==
X-Received: by 2002:ac8:255d:: with SMTP id 29mr13560214qtn.36.1554505964849; 
	Fri, 05 Apr 2019 16:12:44 -0700 (PDT)
Received: from redhat.com (pool-173-76-246-42.bstnma.fios.verizon.net.
	[173.76.246.42]) by smtp.gmail.com with ESMTPSA id
	x201sm12874797qkb.92.2019.04.05.16.12.43
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 05 Apr 2019 16:12:44 -0700 (PDT)
Date: Fri, 5 Apr 2019 19:12:43 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <20190321161832.10533-1-yuval.shaia@oracle.com>
References: <20190405231225.30165-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190405231225.30165-1-mst@redhat.com>
X-Mailer: git-send-email 2.17.1.1206.gb667731e2e.dirty
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.160.175
Subject: [Qemu-devel] [PULL 3/5] virtio-net: Fix typo in comment
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
	Yuval Shaia <yuval.shaia@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190405231243.KkX2ic3HpxX4v4MLIxClzV7FMjk3N-E_Gpu_AoWtKc4@z>

From: Yuval Shaia <yuval.shaia@oracle.com>

Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
Message-Id: <20190321161832.10533-1-yuval.shaia@oracle.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/net/virtio-net.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 7e2c2a6f6a..ffe0872fff 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -2281,7 +2281,7 @@ static void virtio_net_change_num_queues(VirtIONet *n, int new_max_queues)
     /*
      * We always need to remove and add ctrl vq if
      * old_num_queues != new_num_queues. Remove ctrl_vq first,
-     * and then we only enter one of the following too loops.
+     * and then we only enter one of the following two loops.
      */
     virtio_del_queue(vdev, old_num_queues - 1);
 
-- 
MST


