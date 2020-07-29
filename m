Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2FC9C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 22:19:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC2A120656
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 22:19:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iooUtnXb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC2A120656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0uPw-0003Wb-0c
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 18:19:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56538)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <e.emanuelegiuseppe@gmail.com>)
 id 1k0uOc-0001bq-Vd
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 18:17:58 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:44968)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <e.emanuelegiuseppe@gmail.com>)
 id 1k0uOb-0001iP-8M
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 18:17:58 -0400
Received: by mail-wr1-x42a.google.com with SMTP id b6so23036511wrs.11
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2020 15:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=k/Yx5yOHpsjSDbCkwhAkr4UfKKLqMqfAkrAKDj7bYGo=;
 b=iooUtnXbJg8RZ60tB+u+uT5ZCG98pX0gh8nWR/OUIvMJ69Ph7o8tcMPOzrHcXRaEni
 nO4IyHJUMAVKR/AWWj1fXnTqZWLNqrdSDDPYOWYx9WOz4ZcFgJrCogo4mJyz9zFJBEyG
 LhRRk3XS/4zFnxPHOxDWq6QSdj+/33DEnyvlgGk/jDZ/oP9svrg2ZhoRFaZ81MNF0Xd7
 7Bbr1/ORZLn8SUUR5eS4jgKR5w+hfqoin+rPzzfss0+CbDSMcFzTycZ6LShlfjF2INty
 XcsBWtyxAQSFtwSQIzQLkGawR+NbeCC8/FqIy+z+FnXHcmAnjrmFbQOesJu1piYhmtZp
 4o6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=k/Yx5yOHpsjSDbCkwhAkr4UfKKLqMqfAkrAKDj7bYGo=;
 b=udx/zbhnKhXTJ+evGrB0UbF55G4rhC/UIL570RP+kT9Y12RJX0ohbU+nS0UMX5kIvW
 7kp8+49C9XsfRXnMPoDmiYIGW/tu7Un/mcyXznS2wmv3zeuaU+C2ooG0ufLSDIn8kLfn
 w34s7hYx5q7maU9TBmILoKB1NfcG1NWAbpz/sOrrH96t3RXOERqLrsHK7dXcfQhhEfLJ
 6ej/CGZdT41mphCAf9zXJSywy4RUGyXi1ANFi96V+fQLIhAHhHnD+qop+vm8zrUggwZ/
 K7zDZh7+XBEKTfRjrLf9xF2+sv4rI495cmNHMAEFdnul3grOeV9QIqeIGHqqkNz+O9s+
 oXFA==
X-Gm-Message-State: AOAM530VWkWhQbd8DVO79DZX0q/P8R9qNzaJA5xO3KYFRzfjyr4LokWQ
 0JU+yjzE/QTIJDlTCYpf5SaNmtw9nkQ=
X-Google-Smtp-Source: ABdhPJzxw8pKLo8hhy2Y4YNb4GJrhK/bHmahJqHb/z6Z5ZLObbWgg+vlsXb0U2dnhLoQ1JHYI70gsg==
X-Received: by 2002:a5d:6646:: with SMTP id f6mr31661499wrw.155.1596061074991; 
 Wed, 29 Jul 2020 15:17:54 -0700 (PDT)
Received: from emanuele-MacBookPro.station
 (net-130-25-47-175.cust.vodafonedsl.it. [130.25.47.175])
 by smtp.gmail.com with ESMTPSA id r16sm9150057wrr.13.2020.07.29.15.17.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2020 15:17:54 -0700 (PDT)
From: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] pci_dma_rw: return correct value instead of 0
Date: Thu, 30 Jul 2020 00:17:32 +0200
Message-Id: <20200729221732.29041-1-e.emanuelegiuseppe@gmail.com>
X-Mailer: git-send-email 2.17.1
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=e.emanuelegiuseppe@gmail.com; helo=mail-wr1-x42a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

pci_dma_rw currently always returns 0, regardless
of the result of dma_memory_rw. Adjusted to return
the correct value.

Signed-off-by: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
---
 include/hw/pci/pci.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index c1bf7d5356..41c4ab5932 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -787,8 +787,7 @@ static inline AddressSpace *pci_get_address_space(PCIDevice *dev)
 static inline int pci_dma_rw(PCIDevice *dev, dma_addr_t addr,
                              void *buf, dma_addr_t len, DMADirection dir)
 {
-    dma_memory_rw(pci_get_address_space(dev), addr, buf, len, dir);
-    return 0;
+    return dma_memory_rw(pci_get_address_space(dev), addr, buf, len, dir);
 }
 
 static inline int pci_dma_read(PCIDevice *dev, dma_addr_t addr,
-- 
2.17.1


