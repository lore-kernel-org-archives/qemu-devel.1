Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 861D5C43461
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 15:14:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AB6220795
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 15:14:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="h0p+bUJf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AB6220795
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIvcI-0003jQ-QO
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 11:14:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54508)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kIvPb-0001im-LN
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 11:01:28 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:38990)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kIvPX-00011h-Om
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 11:01:27 -0400
Received: by mail-pf1-x441.google.com with SMTP id n14so1373612pff.6
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2020 08:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=V/i6UARRudUJoRdXtPW9d7XXfNZPRvXdDsElEekj7OA=;
 b=h0p+bUJfNtR6WpKeqJsU6F8ojj3VcnSLGwuYow+H7L5t7jbDUefPU1kxTWuWrc35Gj
 /FdegjWtpjWN7jisAl4uUWrP/sMHUAoKkFC1zbp5VlNqaB5jOSXj+euYtb4ta3wy+rT7
 zm0/ld67a7kPF6hqYnR8GoY2qn+YNwzztC0MLx6RQLsnV/RBUM7qj4f4HGIiF7TXQEor
 7LNQLmz7pG7Y0Z9c9y8k/zqd7CCGmzAwxXhUVaTDObb7+GyKFIhtjJSZ9yHm1qMLQKGe
 ipbWOt5HUouwfdkQgLIoJP+e0s2miC45uxgNXEjZV9oBhaQcOarQyQig5eYXHzLZvVl1
 x+Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=V/i6UARRudUJoRdXtPW9d7XXfNZPRvXdDsElEekj7OA=;
 b=ERBPKsglLLMzNear7rnp2lryRNPRuiYX3Zd3K2al6teiYl3pmEGAd5fpdeM3gPXVd3
 1Zz4QMV9Z4Z3+E7tmSoT9cMC/Ut4jwikwzBEf+xO8ZeysEKq5nzVLh4CPTDT0BKTHJZI
 kvRfER8ANMgaqDF02mPb4qy5QctbYEwjP4ZhRNud+eZFbndU6ZGAMa3+NaT36p3Yqwhy
 LDSjDTsk571nV2m/2e+XExKcqGOTC1kUykqXl4p3Mabsx+svqmtO2KmU7mp0aeyCqasK
 hXaOPAgChnky1U0WxRI4cxhE8jacJLlSmEFszyT4dUfwWlUFSMlGfooSH3vw4a9TvPuP
 kWLQ==
X-Gm-Message-State: AOAM531pknc+5t4uYXrz27LuriYfGiukS+Kenk2EnQn5QxG9bMM8TUOl
 0Ucn64czbBe3yG7yCymsNDgO18suN6DcYiRA
X-Google-Smtp-Source: ABdhPJyHRRbzPkGPGAjSR9na58vs0xyTjNass6PqhsR7iQhd/DxWRArJARejBvUZs6LnRp6jpRgTsg==
X-Received: by 2002:a62:1902:0:b029:13e:d13d:a12e with SMTP id
 2-20020a6219020000b029013ed13da12emr26935896pfz.22.1600354881894; 
 Thu, 17 Sep 2020 08:01:21 -0700 (PDT)
Received: from localhost.localdomain ([115.96.151.231])
 by smtp.googlemail.com with ESMTPSA id e10sm17674374pgb.45.2020.09.17.08.01.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2020 08:01:19 -0700 (PDT)
From: Ani Sinha <ani@anisinha.ca>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 06/12] tests/acpi: list added acpi table binary file for
 pci bridge hotplug test
Date: Thu, 17 Sep 2020 20:30:38 +0530
Message-Id: <20200917150044.23159-7-ani@anisinha.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200917150044.23159-1-ani@anisinha.ca>
References: <20200917150044.23159-1-ani@anisinha.ca>
Received-SPF: none client-ip=2607:f8b0:4864:20::441;
 envelope-from=ani@anisinha.ca; helo=mail-pf1-x441.google.com
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, jusual@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>, Ani Sinha <ani@anisinha.ca>,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The file 'tests/data/acpi/pc/DSDT.hpbridge' is a newly added acpi table file
for testing the pci bridge option 'acpi-pci-hotplug-with-bridge-support' under
i440fx. This change documents this fact.

Signed-off-by: Ani Sinha <ani@anisinha.ca>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..96a9237355 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,2 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/pc/DSDT.hpbridge",
-- 
2.17.1


