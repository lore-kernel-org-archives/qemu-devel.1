Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DD58C04AB5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 18:11:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42FF122ADF
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 18:11:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42FF122ADF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38985 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXrQB-0003Mv-DM
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 14:10:59 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56411)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hXrOH-00026f-Ks
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 14:09:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hXrOA-0000EU-Uu
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 14:08:58 -0400
Received: from mail-qt1-f177.google.com ([209.85.160.177]:45931)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hXrO9-00006l-Es
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 14:08:54 -0400
Received: by mail-qt1-f177.google.com with SMTP id j19so6807195qtr.12
	for <qemu-devel@nongnu.org>; Mon, 03 Jun 2019 11:08:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:content-transfer-encoding
	:in-reply-to;
	bh=iiDzl4UMV1aoKP5peI6KxUVyGaqr+EjtWQoUZIGhRlM=;
	b=j9L96QiYuHHa/tRNdyIpS+CLgMoPqSpH4JyuhMx7v4ww0kdojJTlqM4Bs29la5t5Ti
	o2rUUxyq0CK7Co+Hwnzz8ANDgsGwZ4M3QWzHE+CSvKbY+xrqDnEpLrawVo8ex0/MAp3X
	rAQDy0qSsvAJiViBy8xsnBKWE+eU8wSVCBiWdGF5n6ve6mzg2YVlxftED5dOGsJDo6Dv
	Wgy6h8Yww6TP0y8HqoBUaWVZ0cJn+lrZZ9rKBUISX4e3NaWHAEY/tOZknCes8YjJFy4D
	9o6mAn4YtqlQYLK/2dP2HwKX7hjTrxHMs4LcNYPLuCP9fL6teIpmCBb2RLOP2N6mA1Mx
	66bA==
X-Gm-Message-State: APjAAAXryQ43Tv0hWbh6pyBtGgWHp1cQQfPbGWtWCpTpi0PPXuGnTd8C
	jp/7L2OEEZOG9b63weCA1wwAQeFVGm4=
X-Google-Smtp-Source: APXvYqzswbAufNWBbAf7fn+yscEjjU91aiXGqJ47l+rt2HFZSkmrPxv3aLzqMYmoHDecEfwVZOTC6A==
X-Received: by 2002:ac8:869:: with SMTP id x38mr20231786qth.392.1559585331745; 
	Mon, 03 Jun 2019 11:08:51 -0700 (PDT)
Received: from redhat.com (pool-100-0-197-103.bstnma.fios.verizon.net.
	[100.0.197.103]) by smtp.gmail.com with ESMTPSA id
	p37sm9724836qtc.35.2019.06.03.11.08.50
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Mon, 03 Jun 2019 11:08:51 -0700 (PDT)
Date: Mon, 3 Jun 2019 14:08:49 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <1556605773-42019-1-git-send-email-wangjie88@huawei.com>
References: <20190603180807.16140-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190603180807.16140-1-mst@redhat.com>
X-Mailer: git-send-email 2.17.1.1206.gb667731e2e.dirty
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.160.177
Subject: [Qemu-devel] [PULL v2 08/14] vhost: fix incorrect print type
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
Message-ID: <20190603180849.3udaKz-UXik85zcDhoyTZvzNVHIv519FXxilAzUEuKw@z>

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


