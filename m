Return-Path: <SRS0=HB7V=X6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 327EDC4740A
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2019 22:01:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06707222C5
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2019 22:01:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06707222C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGs7b-0006XR-ST
	for qemu-devel@archiver.kernel.org; Sat, 05 Oct 2019 18:01:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47782)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iGs4q-0004h8-3I
 for qemu-devel@nongnu.org; Sat, 05 Oct 2019 17:59:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iGs4o-000411-5G
 for qemu-devel@nongnu.org; Sat, 05 Oct 2019 17:58:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48706)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iGs4m-0003z7-4o
 for qemu-devel@nongnu.org; Sat, 05 Oct 2019 17:58:58 -0400
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 461B8C057F2C
 for <qemu-devel@nongnu.org>; Sat,  5 Oct 2019 21:58:55 +0000 (UTC)
Received: by mail-qk1-f199.google.com with SMTP id s3so10648148qkd.6
 for <qemu-devel@nongnu.org>; Sat, 05 Oct 2019 14:58:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=2d0GgkptC5czDBqkYL9o96lkRdbl/W8ygNyroZFgspE=;
 b=c40XyB5C73JYpkEDqPcNklkBNCAQp5luVxpSkqw05dly6J/tfrGGJ10pyyaQfXsssN
 tSMg3nydZ8LLZVq5fY91yx1WeBCt+rRQXNSWoXHxXtG4h2bLjYK4ShWQH9xUKadvFTBP
 vCQgFS8jvmDZYehwnGowBbqUZdqMpL+iePpXTLk/DVlgkOnBuOEyZt7I5laDwvDJ7Vjv
 9BKikkiluQ/SkSkFgl3nzOqvk3lVnpN7qTpSXKspZpVIwEmErqxW2bdfuy+Vd1CA1Zpr
 pVvfDcSXO0eg/H9x2MPUsguTdS7/adRRZSSfntTqmXJaTo5LwfDSat/GmVEvUtp2M0BB
 R4Yg==
X-Gm-Message-State: APjAAAVtwLaKPFLsfpyGItQbhkG2Hg8eXumTGGn4UmpQCQoKN9HitVBP
 W464EyJthvcviwNXqyDLgT8q7j0NfMlzGNSffOg67YFaa0P7UFHKPOOCRGxbUmLG+weI4/9+SCO
 3/cMCL7CJFavVud8=
X-Received: by 2002:ac8:1289:: with SMTP id y9mr22874561qti.201.1570312734270; 
 Sat, 05 Oct 2019 14:58:54 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzNUosrE6Q5glLmOuHw3uxOlSCuERhbPPw97/4+H5xStEg8VHfFbC0j3VQHX2vQQyBMU8ABDg==
X-Received: by 2002:ac8:1289:: with SMTP id y9mr22874549qti.201.1570312734092; 
 Sat, 05 Oct 2019 14:58:54 -0700 (PDT)
Received: from redhat.com (bzq-79-176-10-77.red.bezeqint.net. [79.176.10.77])
 by smtp.gmail.com with ESMTPSA id
 g194sm5891088qke.46.2019.10.05.14.58.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Oct 2019 14:58:53 -0700 (PDT)
Date: Sat, 5 Oct 2019 17:58:49 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 03/19] hw/acpi: Do not create memory hotplug method when
 handler is not defined
Message-ID: <20190918130633.4872-3-shameerali.kolothum.thodi@huawei.com>
References: <20191005215508.28754-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20191005215508.28754-1-mst@redhat.com>
X-Mailer: git-send-email 2.22.0.678.g13338e74b8
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
 Igor Mammedov <imammedo@redhat.com>, Samuel Ortiz <sameo@linux.intel.com>,
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 Eric Auger <eric.auger@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20191005215849.loE0G9h6PAL9PofYPeJcZwFqjlfehIT9G1inlflZVSU@z>

From: Samuel Ortiz <sameo@linux.intel.com>

With Hardware-reduced ACPI, the GED device will manage ACPI
hotplug entirely. As a consequence, make the memory specific
events AML generation optional. The code will only be added
when the method name is not NULL.

Signed-off-by: Samuel Ortiz <sameo@linux.intel.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20190918130633.4872-3-shameerali.kolothum.thodi@huawei.com>
Acked-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/acpi/memory_hotplug.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/hw/acpi/memory_hotplug.c b/hw/acpi/memory_hotplug.c
index 9b0b150f4f..8d2e82240f 100644
--- a/hw/acpi/memory_hotplug.c
+++ b/hw/acpi/memory_hotplug.c
@@ -712,10 +712,12 @@ void build_memory_hotplug_aml(Aml *table, uint32_t nr_mem,
     }
     aml_append(table, dev_container);
 
-    method = aml_method(event_handler_method, 0, AML_NOTSERIALIZED);
-    aml_append(method,
-        aml_call0(MEMORY_DEVICES_CONTAINER "." MEMORY_SLOT_SCAN_METHOD));
-    aml_append(table, method);
+    if (event_handler_method) {
+        method = aml_method(event_handler_method, 0, AML_NOTSERIALIZED);
+        aml_append(method, aml_call0(MEMORY_DEVICES_CONTAINER "."
+                                     MEMORY_SLOT_SCAN_METHOD));
+        aml_append(table, method);
+    }
 
     g_free(mhp_res_path);
 }
-- 
MST


