Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4266DC04AAC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 23:24:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 144BB20862
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 23:24:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 144BB20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43500 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSrdY-0001DL-8g
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 19:24:08 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45089)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hSrR1-0007bs-Jj
	for qemu-devel@nongnu.org; Mon, 20 May 2019 19:11:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hSrR0-0008Bd-Nl
	for qemu-devel@nongnu.org; Mon, 20 May 2019 19:11:11 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:33111)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hSrR0-0008B1-K0
	for qemu-devel@nongnu.org; Mon, 20 May 2019 19:11:10 -0400
Received: by mail-qt1-f193.google.com with SMTP id m32so18403694qtf.0
	for <qemu-devel@nongnu.org>; Mon, 20 May 2019 16:11:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to;
	bh=EBhBqzmf7dvCSZtcFzIQFoj7mET0nH0WKBXoVmSjL3Q=;
	b=CNjXvVUhtv791/tn1EHNqqA167ikBlZq7fb8XpX3Pgfb2123aoiy1aZBYsMpAR2Pgn
	NOJ48KUtbDLlpuAxrZkMWE9sNBB13Bw4a6I7sEYx73/7wYy7UbHPkacNwmIbcYdCTotb
	clsMaVkSGTGx8GC0jnD+bM2KnpWlCccQfNRqYyesF6t5VyJAWFrXYDOhSIIAPq8WPuQp
	TBbNW79d+HnyiaPm9RwFbokmdbQDqWEnNL9/KrpGk+oyaLmNMmnfJRl0+ZRZfe7hwQ89
	F+oUuqBKrUwQbor1XkmgxB2Yj+MKX9+CjbtpjHXoKV4C8PhV2ONcur2rB89qUzPZ+0gP
	2OHw==
X-Gm-Message-State: APjAAAWrTRQ4f6Vb8gOieu0dW4MO06JRC+eHTaqSlsXAvEoL1fHkJjgQ
	GdLMJcfcdfQW8ro8QFxRz5I/s55y4+U=
X-Google-Smtp-Source: APXvYqwQlpCyP1ZKsgJSYHHrnI57gtzNfc5RSXWKq62UPJfM5LiS7diQnAG0DzpvcMnAYEe96GoUDA==
X-Received: by 2002:ac8:26a4:: with SMTP id 33mr47116734qto.188.1558393868882; 
	Mon, 20 May 2019 16:11:08 -0700 (PDT)
Received: from redhat.com (pool-173-76-105-71.bstnma.fios.verizon.net.
	[173.76.105.71])
	by smtp.gmail.com with ESMTPSA id w5sm6465476qtc.50.2019.05.20.16.11.07
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Mon, 20 May 2019 16:11:08 -0700 (PDT)
Date: Mon, 20 May 2019 19:11:07 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <20190424041959.4087-2-david@gibson.dropbear.id.au>
References: <20190520231008.20140-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190520231008.20140-1-mst@redhat.com>
X-Mailer: git-send-email 2.17.1.1206.gb667731e2e.dirty
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.160.193
Subject: [Qemu-devel] [PULL v2 20/36] pcie: Remove redundant test in
 pcie_mmcfg_data_{read, write}()
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
	David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190520231107.E3jxL74MdrE-FQIn9FrbZ9JuLZzE_KtRsH9fcQ-uIr0@z>

From: David Gibson <david@gibson.dropbear.id.au>

These functions have an explicit test for accesses above the device's
config size.  But pci_host_config_{read,write}_common() which they're
about to call already have checks against the config space limit and
do the right thing.  So, remove the redundant tests.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Message-Id: <20190424041959.4087-2-david@gibson.dropbear.id.au>
---
 hw/pci/pcie_host.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/hw/pci/pcie_host.c b/hw/pci/pcie_host.c
index 553db56778..1ee4945a6d 100644
--- a/hw/pci/pcie_host.c
+++ b/hw/pci/pcie_host.c
@@ -47,11 +47,6 @@ static void pcie_mmcfg_data_write(void *opaque, hwaddr mmcfg_addr,
     }
     addr = PCIE_MMCFG_CONFOFFSET(mmcfg_addr);
     limit = pci_config_size(pci_dev);
-    if (limit <= addr) {
-        /* conventional pci device can be behind pcie-to-pci bridge.
-           256 <= addr < 4K has no effects. */
-        return;
-    }
     pci_host_config_write_common(pci_dev, addr, limit, val, len);
 }
 
@@ -70,11 +65,6 @@ static uint64_t pcie_mmcfg_data_read(void *opaque,
     }
     addr = PCIE_MMCFG_CONFOFFSET(mmcfg_addr);
     limit = pci_config_size(pci_dev);
-    if (limit <= addr) {
-        /* conventional pci device can be behind pcie-to-pci bridge.
-           256 <= addr < 4K has no effects. */
-        return ~0x0;
-    }
     return pci_host_config_read_common(pci_dev, addr, limit, len);
 }
 
-- 
MST


