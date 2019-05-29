Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEC84C28CC0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 16:46:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B486D23E30
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 16:46:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B486D23E30
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57984 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hW1j4-0007EW-V0
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 12:46:54 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39673)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hW1a4-00009e-MT
	for qemu-devel@nongnu.org; Wed, 29 May 2019 12:37:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hW1a3-0002sr-Ov
	for qemu-devel@nongnu.org; Wed, 29 May 2019 12:37:36 -0400
Received: from mail-qt1-f173.google.com ([209.85.160.173]:35182)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hW1a3-0002sd-Km
	for qemu-devel@nongnu.org; Wed, 29 May 2019 12:37:35 -0400
Received: by mail-qt1-f173.google.com with SMTP id w1so3401682qts.2
	for <qemu-devel@nongnu.org>; Wed, 29 May 2019 09:37:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:content-transfer-encoding
	:in-reply-to;
	bh=iiDzl4UMV1aoKP5peI6KxUVyGaqr+EjtWQoUZIGhRlM=;
	b=RihmqOlpMVnelhWlJIvOGNQEx6KyUlc3kFN2VqsyJTMGMhcf08gRGSTNaANE3/Yqyz
	KjGQe8y/WpmZnKGRNbhp9hYjnpipEJU7izsIK4Cez06fc1W/awml+RrGvWXYIFLH2lCG
	eEv1i9pQcWbSOBB58DbvgcGKx/LJyBKiyPhY3lEsYiOs/3msPYo4rTK6aog8FMXNR68n
	ndnNpXTrWM4g3H2mcOGhoFWRjWZMo74oa9vUnN0EKPYUiluluiofhWd/MF6wdYBtivs4
	qB8lNt/qhXzvV1HlhXwBOqC1Fma5BEKDcV4pEJ/UnDOPVAOtbEWQ2kxWYeN0921hoD1b
	J9tw==
X-Gm-Message-State: APjAAAUq2z1dX5oSHug2iZXgV9yFF4uLbP2n4pCwgXkJ9PpL7181e8jX
	u443bMRWvLpnAIgIuWjepqRFtMr+vm0=
X-Google-Smtp-Source: APXvYqwfPEXRZFxOlMKYpV5KHvBLMHoQ5yf4zntBNKntULB5d8VAq4SErFI/n1rBtQmmFVXDYa+Iog==
X-Received: by 2002:aed:39e5:: with SMTP id m92mr92855637qte.106.1559147854764;
	Wed, 29 May 2019 09:37:34 -0700 (PDT)
Received: from redhat.com (pool-100-0-197-103.bstnma.fios.verizon.net.
	[100.0.197.103])
	by smtp.gmail.com with ESMTPSA id x1sm4759171qkf.61.2019.05.29.09.37.33
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Wed, 29 May 2019 09:37:33 -0700 (PDT)
Date: Wed, 29 May 2019 12:37:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <1556605773-42019-1-git-send-email-wangjie88@huawei.com>
References: <20190529163604.18560-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190529163604.18560-1-mst@redhat.com>
X-Mailer: git-send-email 2.17.1.1206.gb667731e2e.dirty
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.160.173
Subject: [Qemu-devel] [PULL 09/10] vhost: fix incorrect print type
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
Message-ID: <20190529163732.VY320yC3QytZgiNPJOcpUQ8RVWq9h29U5B40wpaMvzg@z>

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


