Return-Path: <SRS0=HB7V=X6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3901AC47404
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2019 22:18:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08FE22077B
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2019 22:18:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08FE22077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGsNF-0005B2-0I
	for qemu-devel@archiver.kernel.org; Sat, 05 Oct 2019 18:18:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47963)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iGs5U-0005IQ-Lm
 for qemu-devel@nongnu.org; Sat, 05 Oct 2019 17:59:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iGs5T-0004Ra-L6
 for qemu-devel@nongnu.org; Sat, 05 Oct 2019 17:59:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45824)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iGs5T-0004RM-Cy
 for qemu-devel@nongnu.org; Sat, 05 Oct 2019 17:59:39 -0400
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 97E4E369CA
 for <qemu-devel@nongnu.org>; Sat,  5 Oct 2019 21:59:38 +0000 (UTC)
Received: by mail-qk1-f197.google.com with SMTP id g65so10678694qkf.19
 for <qemu-devel@nongnu.org>; Sat, 05 Oct 2019 14:59:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=TIjODluR1dwfx5in3nPj8adbjCCWoVI4poFEHgVck48=;
 b=STy83Gw50oCJho4Q93P3Vnl7hR8lHvwq14pE7yEF+yReZhPQuZknikW4NJzoGXm3gT
 wsANCREgZDKiW1xL6dbN7whr+57N0U3c1HTj6qlvYna/8Cm5JxMxzh7vclMOoSUUTBxE
 BPDKfrpO4ehRMW7ibOei2iuHcJo54SCXETiZSV6wta3LtdbRSGF4zAIhL//7IK5o1f2P
 GkV1+Q3VpjnMp7OnKRcaU8+8qeVgAW71mmrO4ChcSRraaCrcY6On+tKCTvB7aVn3KDV4
 e4navhCHeSV4fRdY8RhIld6idiXjRyz7tu8D4avdAdl9yeHqUBuRYy8MgMLapvqx3YQv
 30Iw==
X-Gm-Message-State: APjAAAUG2A3Mf6ynmF03afVEM/wu1AtYReeGpgdYEKjJqEUTlrKL3hUf
 64YIt8f1wGOxZFbvY1SbHv2FVQ1DpFBrfN58xQt/KkljycoASzIRdq+L/Rgm4OblIPBIL4YmfKV
 AkfxqQwgVgDSj3FM=
X-Received: by 2002:ac8:70b:: with SMTP id g11mr22925743qth.58.1570312777602; 
 Sat, 05 Oct 2019 14:59:37 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwM52Mic4AIXUKcJ01oCy1Jz+Umt1pi+dq+8joUqOCLTHjFrxf8yaqmkB29i7kcbegi0ogdWQ==
X-Received: by 2002:ac8:70b:: with SMTP id g11mr22925734qth.58.1570312777428; 
 Sat, 05 Oct 2019 14:59:37 -0700 (PDT)
Received: from redhat.com (bzq-79-176-10-77.red.bezeqint.net. [79.176.10.77])
 by smtp.gmail.com with ESMTPSA id
 c8sm5126621qko.102.2019.10.05.14.59.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Oct 2019 14:59:36 -0700 (PDT)
Date: Sat, 5 Oct 2019 17:59:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 11/19] tests: Update ACPI tables list for upcoming arm/virt
 tests
Message-ID: <20190918130633.4872-11-shameerali.kolothum.thodi@huawei.com>
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20191005215933.0c69wiO3Zk2fNHjA_NHEMog8iDxBdEZx5evunHCdPmY@z>

From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>

This is in preparation to add numamem and memhp tests to
arm/virt platform. The bios-tables-test-allowed-diff.h
is updated with a list of expected ACPI tables that needs to be
present in tests/data/acpi/virt folder.

Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Message-Id: <20190918130633.4872-11-shameerali.kolothum.thodi@huawei.com>
Acked-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---
 tests/bios-tables-test-allowed-diff.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tests/bios-tables-test-allowed-diff.h b/tests/bios-tables-test-allowed-diff.h
index 7b4adbc822..3776dd2f3d 100644
--- a/tests/bios-tables-test-allowed-diff.h
+++ b/tests/bios-tables-test-allowed-diff.h
@@ -1,2 +1,17 @@
 /* List of comma-separated changed AML files to ignore */
 "tests/data/acpi/virt/DSDT",
+"tests/data/acpi/virt/APIC.memhp",
+"tests/data/acpi/virt/APIC.numamem",
+"tests/data/acpi/virt/DSDT.memhp",
+"tests/data/acpi/virt/DSDT.numamem",
+"tests/data/acpi/virt/FACP.memhp",
+"tests/data/acpi/virt/FACP.numamem",
+"tests/data/acpi/virt/GTDT.memhp",
+"tests/data/acpi/virt/GTDT.numamem",
+"tests/data/acpi/virt/MCFG.memhp",
+"tests/data/acpi/virt/MCFG.numamem",
+"tests/data/acpi/virt/SLIT.memhp",
+"tests/data/acpi/virt/SPCR.memhp",
+"tests/data/acpi/virt/SPCR.numamem",
+"tests/data/acpi/virt/SRAT.memhp",
+"tests/data/acpi/virt/SRAT.numamem",
-- 
MST


