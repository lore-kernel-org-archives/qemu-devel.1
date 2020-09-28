Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3448C2D0A8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 09:19:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DD5321D7F
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 09:19:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DD5321D7F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMpJD-0005o8-Gi
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 05:18:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47092)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kMpGg-0003rG-Cd; Mon, 28 Sep 2020 05:16:22 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:44089)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kMpGc-0002Xr-Oz; Mon, 28 Sep 2020 05:16:21 -0400
Received: from localhost.localdomain ([82.252.129.222]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1Movrq-1kmW6m2GR4-00qUMU; Mon, 28 Sep 2020 11:16:11 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 5/8] vhost-vdpa: remove useless variable
Date: Mon, 28 Sep 2020 11:15:59 +0200
Message-Id: <20200928091602.383870-6-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200928091602.383870-1-laurent@vivier.eu>
References: <20200928091602.383870-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:wJWrYVUu+QB9tF1t59MC8P8/2ARDgjDwbNMCs86f4jAoT24lCAv
 pFx6JizTH4bdFpvoY22YpxEXfhsv/2MKtbHjJ52HFsSCY7H/p+a2BnHbSzqvfuF0hPgJLD8
 rtLQzNrBEmpKA5DX7ZQ65oKNfSOowUrfnukRwJJ4TXs38mhgznWiAJIOvg68SXTRJ6Wv2BK
 MY3K9iSYPau5FRdlet2KA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:KJJI/RSHP88=:aQ6dnUa2BA68BEthZ2ZHQX
 79BmE2Uk6LOdoyKcD5ipvXrGWr72ubwY24YGy0dL5JQVykxcsefn0HFSDKPCd59WWgiVCsXdh
 pel1WM/ErdG3JED8xkZuIihmcR1T0brnTrTg1DZHyqwDETTiDJQegT/JE+R1GtjIm3GkaYHRv
 RaJw0KCG+icEg/GQyK2riYZkFwnjjt2uAoWQZu9OozMf7TH08Ab8qkOtgTXLrB5bd59qJVGzN
 /Xa7SQqNAmOMNKkT8br0BTsgU8SPXtQeeadpyiy6hgwF4n1J0ZrJ0A7pDRZhrJzXs2mv0iL8z
 cjLiqivYkvxvKlvZJU7bhx2suOzpUCTAyaGksWgB9qNa7T9QFX5ZqWEsiLpWlFyERjJZlsT2J
 t9D7RSedGCXjK0EFBZUoFflxxVnF26n7czUySjLmXpeRDcG3l9kPGgdi2Gre28fvoaqFbYidK
 FVF7pjbqBl3IFLxCNR2dL+62E1ewNUQBr06g4aEne4XMavNZdpDScTlh5Kh6c27WMtSt5mF/N
 gQT46GPQLZLALmn/6MZsfOXgnywlwSKatk10lBh0wVVyP+28mqNm9opmQ6ByDnjZK3bp2Ycu6
 8fbE/tJ1Y7vGiyX0QYgU+oogSAkH2myoHpWow7n0VRHtRLzG2SoA5/80IElAxImZlecXdJez/
 z0GDcsx4SkBSGmBHnS0K9DEFDg6bbFm8UFOPor6f0KLVsvKvyaCebwVEyoGAFCixQrO5N4cBI
 ZRfVUl8UdPHWdqSCO4WwO1GIVDxKzOjLXMMYaEp6pK1ROvfcgWi42Q4p/OpWq7JHvMI58NgFy
 Mhxr8NlsCoesp7HbI6DaZNYOzuYi75+5gUfm7nW61AD7SXsDa21yh+zcGFsMTHdfwKVVmWb
Received-SPF: none client-ip=212.227.126.135; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 05:16:13
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
Cc: Laurent Vivier <lvivier@redhat.com>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>, Li Qiang <liq3ea@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Laurent Vivier <lvivier@redhat.com>

in vhost_vdpa_listener_region_del(), try_unmap is always true and so,
vhost_vdpa_dma_unmap() is always called. We can remove the variable

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Li Qiang <liq3ea@gmail.com>
Message-Id: <20200920152024.860172-1-lvivier@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/virtio/vhost-vdpa.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index 97f4b2e353ab..aedc52c4d791 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -153,7 +153,6 @@ static void vhost_vdpa_listener_region_del(MemoryListener *listener,
     hwaddr iova;
     Int128 llend, llsize;
     int ret;
-    bool try_unmap = true;
 
     if (vhost_vdpa_listener_skipped_section(section)) {
         return;
@@ -176,11 +175,9 @@ static void vhost_vdpa_listener_region_del(MemoryListener *listener,
 
     llsize = int128_sub(llend, int128_make64(iova));
 
-    if (try_unmap) {
-        ret = vhost_vdpa_dma_unmap(v, iova, int128_get64(llsize));
-        if (ret) {
-            error_report("vhost_vdpa dma unmap error!");
-        }
+    ret = vhost_vdpa_dma_unmap(v, iova, int128_get64(llsize));
+    if (ret) {
+        error_report("vhost_vdpa dma unmap error!");
     }
 
     memory_region_unref(section->mr);
-- 
2.26.2


