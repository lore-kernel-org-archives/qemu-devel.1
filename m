Return-Path: <SRS0=xvb4=SS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A0FAC10F0E
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 01:46:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45DE420854
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 01:46:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SviWkZY4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45DE420854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57888 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGDAe-00021s-It
	for qemu-devel@archiver.kernel.org; Mon, 15 Apr 2019 21:46:00 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44071)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1hGD4U-0006VI-7K
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 21:39:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1hGD4T-0007pr-87
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 21:39:38 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:42189)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <andrew.smirnov@gmail.com>)
	id 1hGD4Q-0007nx-VF; Mon, 15 Apr 2019 21:39:35 -0400
Received: by mail-pl1-x643.google.com with SMTP id cv12so9486410plb.9;
	Mon, 15 Apr 2019 18:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=CcQQ1rkcReYyRFd9q5NYZ7+MasgATUr095l6CTEOr7Y=;
	b=SviWkZY4+p8LG0okjkXBCXUUPEEe4r/RynlgwM8g6ISPu1s0/hHQzETzjSRtdIUi3P
	rDByzE2ABy9xwI+nFiDXhD3k5JjUSlwwRwe6Ff6rKrZZaEaSvQ1hv4xy8VT+57gXeOYK
	Sq5EkFKyLDl9AC+xyjnC1Kmr+jYMN7GNTBkuSs0QnvfvU5KIRJS+GhHDLyxfeIkEVSDm
	s3CEveuEckhlGNRYgreYt/hiaN3SoOV0X4tc4s6rD5WIxt3M6D9g+Mq8+JrTTC423WEv
	98yEho6T+8kct0O+Q5xS5jTOsxFRaZXIityMK2tSKJ13fX2H4Dabqy9RuMpLXG9CzB7y
	MyLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=CcQQ1rkcReYyRFd9q5NYZ7+MasgATUr095l6CTEOr7Y=;
	b=PYIrsVQRqg/5GGI606879Vjo5BezDPH+fBPgNT1Mo4y9ewXDzPj/FFMDUzEGfEJDS6
	96quGuwKYHf8yOn25jmOuyXqOOfgr3jDe+orlu4R5Eqs7JPVPTS738szudWT+9pFMdIb
	4bN5Mj0Cyupa9VAedHT4cjodeUv552nkqIrH7Q6dJ4dPVlKE3DxmTc/AjfK/jJdJP+rM
	X6HH2ckdPq8lc0eO/UQtrOr9ELXGxNP3C/+BiYpC3aiDyqUnHsMkaTDNOErquTh1sFEO
	6IlS09YxmHlA7//8tuW34k3+fpZmkcW/X8rTnF+b/clFYAQl3ShnBsOVIFn2NwOXtR+L
	D09w==
X-Gm-Message-State: APjAAAU5w6MRajiJt6jT/xB38zPRKfvxtFPk6svOi68aOG6AQ4NGzS7R
	/cLtdigEbbzX41k+0p60AvRpMlfJ
X-Google-Smtp-Source: APXvYqzQEbHbzkGup+C4dsh0Lmvvr1yzsQTEBT6Rlf5/x14HowIamk8wcSWbc6cU4Ozjs9ISYE4uJQ==
X-Received: by 2002:a17:902:2aeb:: with SMTP id
	j98mr12371326plb.38.1555378773820; 
	Mon, 15 Apr 2019 18:39:33 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net.
	[24.22.235.96]) by smtp.gmail.com with ESMTPSA id
	v20sm74710362pfn.116.2019.04.15.18.39.32
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Mon, 15 Apr 2019 18:39:32 -0700 (PDT)
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: qemu-arm@nongnu.org
Date: Mon, 15 Apr 2019 18:39:01 -0700
Message-Id: <20190416013902.4941-5-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190416013902.4941-1-andrew.smirnov@gmail.com>
References: <20190416013902.4941-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::643
Subject: [Qemu-devel] [PATCH 4/5] pci: designware: Update MSI mapping when
 MSI address changes
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
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>,
	Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
	"Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190416013901.ErJcgaZT946LgCC1FBr5nUlDgrE_PWfVSSE49Z5qYvc@z>

MSI mapping needs to be update when MSI address changes, so add the
code to do so.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
---
 hw/pci-host/designware.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/pci-host/designware.c b/hw/pci-host/designware.c
index 6affe823c0..e80facc4a0 100644
--- a/hw/pci-host/designware.c
+++ b/hw/pci-host/designware.c
@@ -289,11 +289,13 @@ static void designware_pcie_root_config_write(PCIDevice *d, uint32_t address,
     case DESIGNWARE_PCIE_MSI_ADDR_LO:
         root->msi.base &= 0xFFFFFFFF00000000ULL;
         root->msi.base |= val;
+        designware_pcie_root_update_msi_mapping(root);
         break;
 
     case DESIGNWARE_PCIE_MSI_ADDR_HI:
         root->msi.base &= 0x00000000FFFFFFFFULL;
         root->msi.base |= (uint64_t)val << 32;
+        designware_pcie_root_update_msi_mapping(root);
         break;
 
     case DESIGNWARE_PCIE_MSI_INTR0_ENABLE:
-- 
2.20.1


