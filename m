Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D24A5C4727D
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 08:52:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F43D207F7
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 08:52:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="pYY6Gdj3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F43D207F7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPMES-0004vM-Gy
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 04:52:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38540)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@daynix.com>) id 1kPLtS-0007qN-7B
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 04:30:50 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:38876)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <andrew@daynix.com>) id 1kPLtO-0008OY-HJ
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 04:30:49 -0400
Received: by mail-lj1-x243.google.com with SMTP id w3so6596101ljo.5
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2020 01:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=081ribZzsJC9K8QhvxDETxbGA4OIAPk4ZwZgtVwhNbg=;
 b=pYY6Gdj3b5gAdovqxO0KbcqY0TH1ukTcODULAQe3WsZKMrEDrcSp0ihR7RLFm0eDqQ
 A+sm+KwkXz6Vw568Cany4F4+zmlWqazWitxVTa2fzGgkOBlf5HSFP8eyLWISVXX7xGrS
 mg8mc/b4/Zl0KX27BJJ7Zdxl1cwHjskJiQgNdyahU+/Erm8On8ZE2AmqWxmgduOioPde
 pPEu+XVvsXiBUAGU/+KYj2zbEx4KjCg/dbEsXKUxzp65azxiRGHawJGHkKcrgH94+7C1
 lEaFfj/4AKmX5KhfIBAnsNY0O/StH9HJWz+xy0ZiXtk/pTN//xRLChpDRkGeSy1gsmpx
 CPlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=081ribZzsJC9K8QhvxDETxbGA4OIAPk4ZwZgtVwhNbg=;
 b=KBX1jMnrHTcPVhTg8KiaEAJqj0KNvswwlHy+G0aCUxxbq3Byi75eLQq+UDWsg3dsqX
 8QGlqRtAM7nwQmfkfFrepne+ozrIVvXu7cM7SiIdkD7eYvybnFljQLVuTAgKSEYu4zdo
 tzSw3DjAWkpHt4tfBBGz9mIOZQVOpSzIH2Uz20tPYjph+TMtGteW6sIjfmKyjTxw4Jbv
 LFFNtEDdSWr2zGeAo9NfL2FiMQbIqkw/HnovEqEV6kEvjlDUXAXlM9sOZhyAr5pvFgsl
 udwq0bILzJq4Gmb4vuOCD5I/ZVPXGGT5M1ALOCEC829EZNv3401LxQuF4tjQ6DUglRu5
 hOGg==
X-Gm-Message-State: AOAM530Si2B8TEbUDwy7JpwF4gXpPMWZfQAke/TZyfeOXokYKrWWBH4S
 s4p2dS0ipwpjQYsJNNoEnd+Q37UMfIB46w==
X-Google-Smtp-Source: ABdhPJwlP+Z8jpXwJ086Q1FlcMc4k5oKs9+so3chfSKP1ENj4X38ptIUOV0q6UUO+edtjqQhYhyB0w==
X-Received: by 2002:a2e:9ad4:: with SMTP id p20mr4049747ljj.456.1601886641211; 
 Mon, 05 Oct 2020 01:30:41 -0700 (PDT)
Received: from navi.cosmonova.net.ua ([95.67.24.131])
 by smtp.gmail.com with ESMTPSA id o27sm2585693lfb.306.2020.10.05.01.30.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2020 01:30:40 -0700 (PDT)
From: andrew@daynix.com
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/2] hw/virtio-pci Added counter for pcie capabilities
 offsets.
Date: Mon,  5 Oct 2020 12:01:39 +0300
Message-Id: <20201005090140.90461-2-andrew@daynix.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201005090140.90461-1-andrew@daynix.com>
References: <20201005090140.90461-1-andrew@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2a00:1450:4864:20::243;
 envelope-from=andrew@daynix.com; helo=mail-lj1-x243.google.com
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
index 5bc769f685..ae60c1e249 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -1788,6 +1788,7 @@ static void virtio_pci_realize(PCIDevice *pci_dev, Error **errp)
 
     if (pcie_port && pci_is_express(pci_dev)) {
         int pos;
+        uint16_t last_pcie_cap_offset = PCI_CONFIG_SPACE_SIZE;
 
         pos = pcie_endpoint_cap_init(pci_dev, 0);
         assert(pos > 0);
@@ -1823,7 +1824,8 @@ static void virtio_pci_realize(PCIDevice *pci_dev, Error **errp)
         }
 
         if (proxy->flags & VIRTIO_PCI_FLAG_ATS) {
-            pcie_ats_init(pci_dev, 256);
+            pcie_ats_init(pci_dev, last_pcie_cap_offset);
+            last_pcie_cap_offset += PCI_EXT_CAP_ATS_SIZEOF;
         }
 
         if (proxy->flags & VIRTIO_PCI_FLAG_INIT_FLR) {
-- 
2.28.0


