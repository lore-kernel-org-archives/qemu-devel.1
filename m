Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45F34C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 06:57:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0954720791
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 06:57:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="cJPpc8eL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0954720791
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k67BP-0002E2-6E
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 02:57:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60476)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@daynix.com>) id 1k673e-0006hx-BZ
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 02:49:50 -0400
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:46866)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <andrew@daynix.com>) id 1k673c-0004ei-IA
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 02:49:49 -0400
Received: by mail-lf1-x144.google.com with SMTP id i80so2450872lfi.13
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2020 23:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=7t2aLtgfSFeGdII/O5Rmb9o+PLKqDSh+1So2xG3+0ss=;
 b=cJPpc8eLdmjomK0dGlbCC9Nx5u2C7W1oe79SDCZqn+U81ncq35K7VGvr0LyE/mPgU2
 QzKLamAyYaEXGGDX18nJWe6T7D+CGM0x9rYHGrTX/17E7v+sqpNOWA4aMervhryQtYFc
 YEzf6vOF0Z1u5MDpv3aQ1CyswfQQ47h20FxK1zuIVcT90HxYh7b0BxSL/Rgokb/cK7JR
 Hg5oi76D0H5x9Ty2FzrSNGEcZajrFLrbBL4PIBuqR8q2uUcKkGY1wS71iZMIoo4GpV1a
 fQCmZyeb0JYqmrviqoPY51kilqeNTifzqwu/OSMgC47ZjeyEq0WAAcNvLwJPtzQcK1RK
 wagg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=7t2aLtgfSFeGdII/O5Rmb9o+PLKqDSh+1So2xG3+0ss=;
 b=Jg2WoqHtQkKTXRUgKoADX72oLHlLyNtftjjD4noeexPUVBxeGOHiIhVYZrafZUVsWN
 GaruRXQa6MlVBTmknQqgNMZMTJeznw/nBkzB0jydEMSrqg/sMpDh2woczEywlO4ibcLI
 lhIXYro3g7YEPRiuX5a9JOqkoC6BlyfnQnMqPr9+0MR1MvhAQUn7PvR9N9tcw53g7JvT
 Xj10zC9AILWvfy4frH7zni4CP5KNbsvNFrdIkYurpaXHQl86yF639U+/OmwqKFy+ufsS
 yVeB8DV2bjhPK1MZib6ohSLLcFqF/nz4jSJ+UMXNo5mZPJuyET1tsUAOtJPonw3dCLl/
 rnjA==
X-Gm-Message-State: AOAM531UrvXwYpD0hevpOlhtCBEH6GNlTVuxrMd9me/GpTUyKRPHEXUD
 SyLUSRLsA67zOTu7qICx0LvFKX7mLCY=
X-Google-Smtp-Source: ABdhPJy4Bq4muNKj2s5eqYjeM2ii3zQfq/zJguT/Ik+Jcrc8805ToGGFcWwnlXCu+Z14fyC/9xJKBw==
X-Received: by 2002:ac2:5dc1:: with SMTP id x1mr1436823lfq.217.1597301380281; 
 Wed, 12 Aug 2020 23:49:40 -0700 (PDT)
Received: from navi.cosmonova.net.ua ([95.67.24.131])
 by smtp.gmail.com with ESMTPSA id e25sm890794ljp.47.2020.08.12.23.49.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2020 23:49:39 -0700 (PDT)
From: andrew@daynix.com
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] hw/virtio-pci Added counter for pcie capabilities offsets.
Date: Thu, 13 Aug 2020 10:19:30 +0300
Message-Id: <20200813071931.19846-1-andrew@daynix.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2a00:1450:4864:20::144;
 envelope-from=andrew@daynix.com; helo=mail-lf1-x144.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Andrew <andrew@daynix.com>

Removed hardcoded offset for ats. Added cap offset counter
for future capabilities like AER.

Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
---
 hw/virtio/virtio-pci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index ccdf54e81c..8e02709605 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -1787,6 +1787,7 @@ static void virtio_pci_realize(PCIDevice *pci_dev, Error **errp)
 
     if (pcie_port && pci_is_express(pci_dev)) {
         int pos;
+        uint16_t last_pcie_cap_offset = PCI_CONFIG_SPACE_SIZE;
 
         pos = pcie_endpoint_cap_init(pci_dev, 0);
         assert(pos > 0);
@@ -1822,7 +1823,8 @@ static void virtio_pci_realize(PCIDevice *pci_dev, Error **errp)
         }
 
         if (proxy->flags & VIRTIO_PCI_FLAG_ATS) {
-            pcie_ats_init(pci_dev, 256);
+            pcie_ats_init(pci_dev, last_pcie_cap_offset);
+            last_pcie_cap_offset += PCI_EXT_CAP_ATS_SIZEOF;
         }
 
         if (proxy->flags & VIRTIO_PCI_FLAG_INIT_FLR) {
-- 
2.27.0


