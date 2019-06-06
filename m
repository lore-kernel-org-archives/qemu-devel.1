Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 849E5C28D1E
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 11:12:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E6DD20868
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 11:12:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E6DD20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58447 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYqJU-000447-Ia
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 07:12:08 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60310)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hYqF8-0000BT-LB
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 07:07:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hYqF5-0003FA-Oa
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 07:07:36 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:58621)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>)
	id 1hYqF1-0002z6-0o; Thu, 06 Jun 2019 07:07:31 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
	mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA
	(Nemesis)
	id 1MauFB-1gy8V734dX-00cSgp; Thu, 06 Jun 2019 13:06:43 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Thu,  6 Jun 2019 13:06:12 +0200
Message-Id: <20190606110625.32127-4-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190606110625.32127-1-laurent@vivier.eu>
References: <20190606110625.32127-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:CaPomUUU0ZJp2dT6eUq05+g7tIBXfeNTk8JnnR47rG4Bb3m2Amu
	FYawHFxHtEN6ZwcplHPtkRE8L99QdHTARU0DkOY5IX6Khlx0ZOP1VVSVn6jDU4cyT9rzXkh
	OXaCHxOgKUg+NpeQ/u4xYfYdSNT/lncnGfEUNJS7Sjt6PStGn1qP322oM4iT75BrRb6CBMO
	Cd9LcRhoU7u+7OHe0NImA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:41tRHKGJyP0=:4ymjpaXSKln4RHBYeKTaxe
	eHWyXozSKm/GfW/N7OJ1Zc3S0QRUoGie3/x2d9eHdXM8jgRb3Bpn9trcYMOS7x23oa2QC51eF
	rD3Ajl+Kko9qZVsUpoPb2ZCQe+ejJdBGwmLLeGP634ant7VNwHnNNv1z1zyhv/IkfdTWFzLDz
	4fIOZ5dGwIBtoJSXHGGnfKMhaROJiy69Kc9jUQqIZKJRTuNAnGcYPSvagkCcwQ1WD8b3+6iAl
	c4eLCHB/4PBsauGmZRy2oA+6aczUWZrK1KUFML2K/dkFkF14ikiuRgve99MLwTYjw1IbRrG2t
	+xzLn7CXcojeu/kpbk+uqjJcSEMnzKm9iYey8ue05T0SV3y/5OKrYR8OZD1h9Kh7rZEnQvwd2
	4+ZmV2UPrsTozj2CiuOeeF1bu5k4q9kRh0vJm6gxy82O+Ah3g1JLz+Fh/lAG5Qi3GJ1v6/bDo
	/febZbm//dL/wxA/uqOSKjnqXZbtRuRZN2voi9/nvCrVYjWgsr2tqM/ejh6p6QgqxzwtfX4la
	S1xjp5j6K0s0Bu6hRtGUkOQ+EOjKE1XhN8xuHiVi/eG0Bsl4Y6D3XyADr3sPb1tl1reywT2q/
	sZpVLZwh6KWE/Kq735ggQAk+WI/Wy6QFC/5VYxHRGaxVp+Sd/8gGj/620fIP61ahFlb8rgyD5
	XJliIqnJR5W0CtqVhKlNYvQp7uhZohjAuRTnMB7ZziPVyuVr8pSAvZOFErkNOY9nqB9KraFQr
	WpyhXhuuvVMmOi/PNpcTo7iMvda2OWyk6sfLQsXAQBy8pliKk02eM/6Jlb8=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.73
Subject: [Qemu-devel] [PULL 03/16] vhost: fix incorrect print type
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
Cc: Fam Zheng <fam@euphon.net>, Dmitry Fleytman <dmitry.fleytman@gmail.com>,
	David Hildenbrand <david@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
	Gerd Hoffmann <kraxel@redhat.com>, Jie Wang <wangjie88@huawei.com>,
	Juan Quintela <quintela@redhat.com>,
	Aleksandar Rikalo <arikalo@wavecomp.com>,
	"Michael S. Tsirkin" <mst@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>,
	Yuval Shaia <yuval.shaia@oracle.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Richard Henderson <rth@twiddle.net>,
	=?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
	Laurent Vivier <laurent@vivier.eu>, qemu-trivial@nongnu.org,
	Michael Walle <michael@walle.cc>,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Jie Wang <wangjie88@huawei.com>

fix incorrect print type in vhost_virtqueue_stop

Signed-off-by: Jie Wang <wangjie88@huawei.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <1556605773-42019-1-git-send-email-wangjie88@huawei.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/virtio/vhost.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 7f61018f2a3f..286bb27c6539 100644
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
2.21.0


