Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F10EC7618B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 15:33:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7897A229F3
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 15:33:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7897A229F3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33012 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqfju-000751-4n
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 11:33:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48986)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mst@redhat.com>) id 1hqfiW-0002rh-MH
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 11:31:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1hqfiV-0001sB-Jh
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 11:31:40 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:46901)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1hqfiV-0001rt-GS
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 11:31:39 -0400
Received: by mail-qt1-f195.google.com with SMTP id h21so49427550qtn.13
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2019 08:31:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=GDp8j9NviBwiadQVNh7husgN8Q3GImxt9I1Zswm0kPk=;
 b=jf3v6H0dLr8w5bGdVMiByLJhOfnlY/DtUIrH9hO+7mAahseErn2J1/D23Hxss7cr85
 Bbvs636J1xgT/eyUzeouPjtfDMpNvnCRgnXudH6E/gX5zwl9l+/zdKrAo1UYq34nceJy
 aXzWrP5KTFhCzO4oG8s3hhGcpn4A6vSU99HupxIS1WCkDJUBUqO0y5C/r6+pB7IfJyPi
 82UFI9PyPY8et+9vZxcN4qxmD1lVH01x8kZ2LV/brtoXrPm/3qtZrXJYD5EPISyLtdez
 tMMPW7vgiyab3z5B5AYmNAmQutBSrZxni8tKZIL7Ug/cNXpgezoH7AcroVkyqN/xVuMC
 Q2rQ==
X-Gm-Message-State: APjAAAXOD/jia/+HWtpiJlCCGtCKweHX/KBPfj54oOhCGT6mXRbXOBoY
 H9f98kei/1+s48Uge/7U/sWQhlibNWanIw==
X-Google-Smtp-Source: APXvYqw99hI9kPNmINbA0Y0Su/xjM2Zm5om9x5ZyQpkyC72LVHfDhTpcSKLcBeELTI1vu9G8vldWyQ==
X-Received: by 2002:a0c:b999:: with SMTP id v25mr64792777qvf.36.1564068698775; 
 Thu, 25 Jul 2019 08:31:38 -0700 (PDT)
Received: from redhat.com (bzq-79-181-91-42.red.bezeqint.net. [79.181.91.42])
 by smtp.gmail.com with ESMTPSA id
 w80sm24007737qka.74.2019.07.25.08.31.35
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 25 Jul 2019 08:31:38 -0700 (PDT)
Date: Thu, 25 Jul 2019 11:31:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <1563466463-26012-1-git-send-email-wrfsh@yandex-team.ru>
References: <20190725153059.7313-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190725153059.7313-1-mst@redhat.com>
X-Mailer: git-send-email 2.22.0.678.g13338e74b8
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.160.195
Subject: [Qemu-devel] [PULL 02/12] i386/acpi: fix gint overflow in
 crs_range_compare
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
Message-ID: <20190725153133.eU3mDvXveKuSELmitdCtIC6MQ4mqK9UKWHcI2j8aTI4@z>

From: Evgeny Yakovlev <wrfsh@yandex-team.ru>

When very large regions (32GB sized in our case, PCI pass-through of GPUs)
are compared substraction result does not fit into gint.

As a result crs_replace_with_free_ranges does not get sorted ranges and
incorrectly computes PCI64 free space regions. Which then makes linux
guest complain about device and PCI64 hole intersection and device
becomes unusable.

Fix that by returning exactly fitting ranges.

Also fix indentation of an entire crs_replace_with_free_ranges to make
checkpatch happy.

Cc: qemu-stable@nongnu.org
Signed-off-by: Evgeny Yakovlev <wrfsh@yandex-team.ru>
Message-Id: <1563466463-26012-1-git-send-email-wrfsh@yandex-team.ru>
Signed-off-by: Evgeny Yakovlev <wrfsh@yandex-team.ru>
---
 hw/i386/acpi-build.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index d281ffa89e..e7b756b51b 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -755,10 +755,16 @@ static void crs_range_set_free(CrsRangeSet *range_set)
 
 static gint crs_range_compare(gconstpointer a, gconstpointer b)
 {
-     CrsRangeEntry *entry_a = *(CrsRangeEntry **)a;
-     CrsRangeEntry *entry_b = *(CrsRangeEntry **)b;
+    CrsRangeEntry *entry_a = *(CrsRangeEntry **)a;
+    CrsRangeEntry *entry_b = *(CrsRangeEntry **)b;
 
-     return (int64_t)entry_a->base - (int64_t)entry_b->base;
+    if (entry_a->base < entry_b->base) {
+        return -1;
+    } else if (entry_a->base > entry_b->base) {
+        return 1;
+    } else {
+        return 0;
+    }
 }
 
 /*
-- 
MST


