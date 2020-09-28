Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E050C2D0A8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 09:18:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E19F21D7F
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 09:18:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E19F21D7F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMpIp-0005Xu-13
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 05:18:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46982)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kMpGY-0003om-Ra; Mon, 28 Sep 2020 05:16:14 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:34017)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kMpGW-0002WX-Ke; Mon, 28 Sep 2020 05:16:14 -0400
Received: from localhost.localdomain ([82.252.129.222]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MV2Sk-1jy7Np0ROg-00S6t8; Mon, 28 Sep 2020 11:16:07 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 1/8] vhost-vdpa: fix indentation in vdpa_ops
Date: Mon, 28 Sep 2020 11:15:55 +0200
Message-Id: <20200928091602.383870-2-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200928091602.383870-1-laurent@vivier.eu>
References: <20200928091602.383870-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:77b7UHhIOGlSHExCgtdoqDOYMOVylEBGVMeCX20yI9eIcnBjVpn
 nxAlv5HMRSFdLkffrBfk50EwFop2c8xkpsfJzq7UjfcrY39LcMVyAL6qzNJU4LjJSaH+oTv
 Aw2hMPf8y19ovABjDeNwFsH8D9dHOUrqmGxZHzCuNRlpJisLVLwqCXe4WIECIL1Dzd24m3V
 Q5ZM5xo3I4hepHhvqhJrQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:BZqoKIMwtQg=:Bq4UVQ5Cjj7yu8IqbOwdHy
 i2Jbj4zQGshLBCZpEq9JqW+4dCCOy1w8cQpv4z8K8vVyjYQT52hxUHycnKARI+qCpwM8WULcN
 GEPL/Noq7jOlvHRPR2uhUCVQf5dKWfWq2hmRl0qz1EyR9ik62bR/L/V+gCetAPFEZPmg3q8Ac
 LENZfloTGmF0vFb8YHUa+rTpfU7DoduJ2pc9GXE6emzOYkvDT5qjOf0Swrs91CTyZ2VsjaFC7
 DVDUJXSiPpkZfWLIu0JgVvgg8e2Fo/4LxsdN2xyal3goqGDI7xmdw+1HMNSuWjEprwdmZBqXx
 5UT+RMeJvQ8CQIMFgaxApCO/XL1OlDwup5KK/EpTwIJTXotAsGMgzxokHI1XcBMNZo4JRQxBk
 MVABTXzEZB4Fa4tEGw9QElbIi8kCl7mJt89clCY6iATUhXLsMS1MStCP59ZX1EVOczHkDRpON
 +7CuKsjItwMVCtRgm60bmixtDLZntGJfFF/6hncXhPcZZozo6WU3E2MDMuMq/7Lr2vH/S0y6q
 b9orJDf/30ggwQOUmJUBT/o/gOAL4/81rR+fEcH6PnYpldC8cLbIPY2GeiWYH1R+w2e39ld67
 E3BXqe+7aCh77sLC6bGCZCVZinhNnTdBbhkEdqVBAi9XjriMUprkON1KuBZu3Lvg3UHlb3gKe
 f/N+IWq8bsEXa37rbwXfbVhKg5ZO+H4IWOt1W+5rkZU+UVgXS7e4lh17UXF6xWGz5+Sjh3ByG
 HMHeEsiVAYYAQ1rRL5flhOc9erJ12tDaP68gbPPf59PLD8Pq6kSgTtEEzfDRvozhOTT/G2BVU
 qPO39Z5YY88CvYiCtPNW3k084sY33HD0/XNaw9U8FieZAGNF8Muo0TMfhDXt6g10s2gI2Dj
Received-SPF: none client-ip=212.227.126.131; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 05:16:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.462, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-trivial@nongnu.org, Li Qiang <liq3ea@gmail.com>,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Stefano Garzarella <sgarzare@redhat.com>

This patch fixes wrong indentation of some vdpa_ops fields introduced
with the initial commit 108a64818e ("vhost-vdpa: introduce vhost-vdpa
backend")

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Li Qiang <liq3ea@gmail.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20200916152634.56917-1-sgarzare@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/virtio/vhost-vdpa.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index 4580f3efd8a2..e123837a55de 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -469,6 +469,6 @@ const VhostOps vdpa_ops = {
         .vhost_send_device_iotlb_msg = NULL,
         .vhost_dev_start = vhost_vdpa_dev_start,
         .vhost_get_device_id = vhost_vdpa_get_device_id,
-         .vhost_vq_get_addr = vhost_vdpa_vq_get_addr,
-         .vhost_force_iommu = vhost_vdpa_force_iommu,
+        .vhost_vq_get_addr = vhost_vdpa_vq_get_addr,
+        .vhost_force_iommu = vhost_vdpa_force_iommu,
 };
-- 
2.26.2


