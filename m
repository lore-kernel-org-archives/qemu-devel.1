Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3022AC76191
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 15:32:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE3B2229F3
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 15:32:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE3B2229F3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqfjX-0005nm-00
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 11:32:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49075)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mst@redhat.com>) id 1hqfih-0003UF-T6
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 11:31:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1hqfig-0001xW-PL
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 11:31:51 -0400
Received: from mail-qt1-f181.google.com ([209.85.160.181]:34856)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1hqfig-0001xI-JR
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 11:31:50 -0400
Received: by mail-qt1-f181.google.com with SMTP id d23so49520349qto.2
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2019 08:31:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=qK4MNfjcAxJwf+DeGNG4n+y7iHUMdDAt4rT1q9ypIWg=;
 b=ulzR4xRYrchXHdBxkirjtmTjaLfbHxoqDzbMJQJZ7X90s18PAa0PnzKr2m4LZV1NWx
 tyyrEmGVLoUl7hGFKgcFutgQrZj4cMWCekkEOGctC58esO5MiEFi7iyPDHAxZ6PGNWwh
 5bCJ32G66mjMsdJu7TZIUYv3fH3NE4C1c4Qe+I2wsGE+6sY/5Yo94XJjV8bllspmARTa
 ID95qHkfKwe/bNbppYLQBbR2Wmq6YWXtFVspJY0/i7OQ3i7feZGXe4zKPJG2k6bKsLRc
 TXdHLw3VDM8Vx16+UbtIpNjCm1BGQTJVIzrah+fgcg8fsvJgjmEj9AqR3hZVkU968Egw
 j/1g==
X-Gm-Message-State: APjAAAWAbOhWOY2+id5NGxGDsgnRjh7a8vzuYzvKJ9ZqUC6Ajd9VIt38
 rqJUbLuY5uQwNSwG029s7IJAAn8cBQJpnA==
X-Google-Smtp-Source: APXvYqzjpiSbFKXphSVJyw/9WNRAWLbNDzN/nKVNGc25cI3u6sp14JolaqA9gskP93DKekZstKQ4ew==
X-Received: by 2002:ac8:65d4:: with SMTP id t20mr58015844qto.249.1564068709815; 
 Thu, 25 Jul 2019 08:31:49 -0700 (PDT)
Received: from redhat.com (bzq-79-181-91-42.red.bezeqint.net. [79.181.91.42])
 by smtp.gmail.com with ESMTPSA id
 g3sm20953801qkk.125.2019.07.25.08.31.46
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 25 Jul 2019 08:31:49 -0700 (PDT)
Date: Thu, 25 Jul 2019 11:31:44 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <1563526469-15588-1-git-send-email-wrfsh@yandex-team.ru>
References: <20190725153059.7313-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190725153059.7313-1-mst@redhat.com>
X-Mailer: git-send-email 2.22.0.678.g13338e74b8
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.160.181
Subject: [Qemu-devel] [PULL 04/12] i386/acpi: show PCI Express bus on
 pxb-pcie expanders
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-stable@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Evgeny Yakovlev <wrfsh@yandex-team.ru>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190725153144.TnMO5KSGx4158_k1vYVQSH7G47pH9X1C-G-URtQ509k@z>

From: Evgeny Yakovlev <wrfsh@yandex-team.ru>

Show PCIe host bridge PNP id with PCI host bridge as a compatible id
when expanding a pcie bus.

Cc: qemu-stable@nongnu.org
Signed-off-by: Evgeny Yakovlev <wrfsh@yandex-team.ru>
Message-Id: <1563526469-15588-1-git-send-email-wrfsh@yandex-team.ru>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/acpi-build.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index e7b756b51b..f3fdfefcd5 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1914,10 +1914,13 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
             scope = aml_scope("\\_SB");
             dev = aml_device("PC%.02X", bus_num);
             aml_append(dev, aml_name_decl("_UID", aml_int(bus_num)));
-            aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0A03")));
             aml_append(dev, aml_name_decl("_BBN", aml_int(bus_num)));
             if (pci_bus_is_express(bus)) {
+                aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0A08")));
+                aml_append(dev, aml_name_decl("_CID", aml_eisaid("PNP0A03")));
                 aml_append(dev, build_q35_osc_method());
+            } else {
+                aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0A03")));
             }
 
             if (numa_node != NUMA_NODE_UNASSIGNED) {
-- 
MST


