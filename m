Return-Path: <SRS0=xvb4=SS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A10F9C10F0E
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 01:44:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26D2520854
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 01:44:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kryYvyWF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26D2520854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57849 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGD9X-0001I4-6b
	for qemu-devel@archiver.kernel.org; Mon, 15 Apr 2019 21:44:51 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44046)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1hGD4T-0006U1-3F
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 21:39:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1hGD4S-0007p5-4V
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 21:39:37 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:36822)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <andrew.smirnov@gmail.com>)
	id 1hGD4P-0007nC-RT; Mon, 15 Apr 2019 21:39:34 -0400
Received: by mail-pl1-x643.google.com with SMTP id ck15so9490824plb.3;
	Mon, 15 Apr 2019 18:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=HyeSXtTi0HQGgMHm9SM0E/AgTMzg6uy5FrM4vtsvYjI=;
	b=kryYvyWFlB1f7D/S0hTTm2TKpmJ0zAdUcYaou7GfWqVAs+0iSZGdI/c+2FMlqUkvLK
	NDRC7Z38xvI03qLCseG6Sk1GMDJiKpiwh4eD70NONO5VdIPQ2j7PzzwOgz2neVCc0nff
	rLbj/XcvWN4ZrNH3tmofXTLpGC7bYKPhvr2Yup2s11iukEzWrcAKcfxiXc8UT97LVfUx
	f/gzuBo7kJy+IklAv3jDK0qFlnCOb0WlNiRSBbgBOw7lalBUIZVFJqP7DQnmHU06CPoU
	/GqC3O0yoppDgluXmiT6k7C5dbhhmyC9v3MqXVHmx+ebz+XfIGib8KD4epIgqXpha0ST
	F72A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=HyeSXtTi0HQGgMHm9SM0E/AgTMzg6uy5FrM4vtsvYjI=;
	b=hyKdJHd9TUAmHyAZsDD+B6ohUWJY1Gyry3WcQk1SCoWEvPD56GWoHc4mKShZtmcUDs
	p2eCHziHbqa4z1K0fb3VlgiULS6gQMrzg8be8l822EN57CHVuXtiRvaDPW0OuPCSPg6L
	rNMSbG5dXTClpBdK5ww8QGyeKAkhRahMJZxNo25UopmpgSVwdlBxlmaTO05n3XmbmNoL
	ribqIO3inENvuPSjN4X/aTliL5ferGc93IhSvRH1iqWKYo0vTLJ/4VkLw0rwqT58/pCa
	H89H5CI+81Gc/3iD1ch9dvwS+pS9C9caa72vKmPCsDz4ukSPspoRuNX4Gyn8w8i79GZu
	8R/A==
X-Gm-Message-State: APjAAAWRQb1W45OQ7FsYXC1iIQ58jjq71jJq0X71LyY+gOrwHM9eJViY
	9i4pFBRlsNGuY16buCdKNwxrVy4x
X-Google-Smtp-Source: APXvYqzqNvGx7U0By9/TNQnOLn5AJOsA62uB5OFhsKoWIscy9BcpVOKniv+wQ6iZihJnljq2X5YmBQ==
X-Received: by 2002:a17:902:1124:: with SMTP id
	d33mr55345928pla.268.1555378772610; 
	Mon, 15 Apr 2019 18:39:32 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net.
	[24.22.235.96]) by smtp.gmail.com with ESMTPSA id
	v20sm74710362pfn.116.2019.04.15.18.39.31
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Mon, 15 Apr 2019 18:39:31 -0700 (PDT)
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: qemu-arm@nongnu.org
Date: Mon, 15 Apr 2019 18:39:00 -0700
Message-Id: <20190416013902.4941-4-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190416013902.4941-1-andrew.smirnov@gmail.com>
References: <20190416013902.4941-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::643
Subject: [Qemu-devel] [PATCH 3/5] pci: designware: Update MSI mapping
 unconditionally
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
Message-ID: <20190416013900.61gqXIxn5QBCS_TDf3L8bXgf1O9wZmeRQLobh-Pq8ro@z>

Expression to calculate update_msi_mapping in code handling writes to
DESIGNWARE_PCIE_MSI_INTR0_ENABLE is missing an ! operator and should
be:

    !!root->msi.intr[0].enable ^ !!val;

so that MSI mapping is updated when enabled transitions from either
"none" -> "any" or "any" -> "none". Since that register shouldn't be
written to very often, change the code to update MSI mapping
unconditionally instead of trying to fix the update_msi_mapping logic.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
---
 hw/pci-host/designware.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/hw/pci-host/designware.c b/hw/pci-host/designware.c
index 29ea313798..6affe823c0 100644
--- a/hw/pci-host/designware.c
+++ b/hw/pci-host/designware.c
@@ -296,16 +296,10 @@ static void designware_pcie_root_config_write(PCIDevice *d, uint32_t address,
         root->msi.base |= (uint64_t)val << 32;
         break;
 
-    case DESIGNWARE_PCIE_MSI_INTR0_ENABLE: {
-        const bool update_msi_mapping = !root->msi.intr[0].enable ^ !!val;
-
+    case DESIGNWARE_PCIE_MSI_INTR0_ENABLE:
         root->msi.intr[0].enable = val;
-
-        if (update_msi_mapping) {
-            designware_pcie_root_update_msi_mapping(root);
-        }
+        designware_pcie_root_update_msi_mapping(root);
         break;
-    }
 
     case DESIGNWARE_PCIE_MSI_INTR0_MASK:
         root->msi.intr[0].mask = val;
-- 
2.20.1


