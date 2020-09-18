Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8872CC43463
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 07:25:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF5AC21D20
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 07:25:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="gQpejjjc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF5AC21D20
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJAlQ-0003tC-Rq
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 03:25:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34588)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kJAkD-0002Vj-B9
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 03:23:45 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:35696)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kJAkB-0003H7-2l
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 03:23:45 -0400
Received: by mail-pl1-x641.google.com with SMTP id bg9so2540649plb.2
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 00:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=+C/GKper9Hc1Rp3TxABDngRg3jAp3GhgbcS73g/TxHk=;
 b=gQpejjjc4rZLIPJvC9p9RJji27J7+VzxuBFeaIIoALI5cSj4F3/0PY5/7NiSWCUyrK
 8VcX+Zil/O9YpZ2rO5XV0AzAXBnwGroQshr5glmNcayGUkklqGWrMVRBcJLkZIPGk0lv
 UtS5moX6qjuMXNZyoOa/N5Zt2Rr/FEASAQWl7MEljXWl1EPX3MDPLirw4KGWc4/1XHN9
 9wwooRn8Pi2Z5pnYE6NAlzQoU8PBBYDomRXpFDhzFqVp8s5Fk/S1Cg9MRJY2CQ8AFN6N
 NYzS8rQF0usPMwR9rySv3Ky1egduM3rpKuzGiRrnXeDPHB1z9mwBDbEnX1/4TcFXudOt
 CW3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=+C/GKper9Hc1Rp3TxABDngRg3jAp3GhgbcS73g/TxHk=;
 b=jpqw44dbVZSys/TZogEteYacKN8mdMBFampvJQ4JuUiHTmD9+Cp3mUiiTFGqZFEhZF
 JMmHLILXxK2WniOC6VFgIRT2N6SMwtkTX+r7RMeaIwfh/zMJoAnGhBxu0SyiIKyQ88t/
 H7AItxEQ/vPHmjc6zaFrGlIbxssIF9Ff4R/OCEP3+8MKiT0V5jASMqJD6CR3MRdfeOax
 DsDBTqmHMtyAnfhWDNAj4n7kCh57SyhddOcE45JqwzfdXve4TPX/+zq76EFe98Qz7FxV
 HqhXCDsaWAJjAYxX/DT35m+N7U1F4pNWgzbbJODHn7mlZxRT9EPeUNVh+PRDWbcFVbVA
 qf1Q==
X-Gm-Message-State: AOAM532Ix6Tnb21qtSuzvycsPwAerbt6xl9nyLP6gUqUaWlpuibXewXV
 e+XYcf6v6kJ6+j6v0LmtdeBB5UXJTk5rsiA7
X-Google-Smtp-Source: ABdhPJwpYGDOc4Lfs7EB5QicAMrRBDQF8FeEBiZyH8t02kRgmNwthfQ9+6K5bFt7RWqydjyhCza1xA==
X-Received: by 2002:a17:902:ed43:b029:d1:e603:5439 with SMTP id
 y3-20020a170902ed43b02900d1e6035439mr13964388plb.81.1600413821318; 
 Fri, 18 Sep 2020 00:23:41 -0700 (PDT)
Received: from localhost.localdomain ([115.96.124.157])
 by smtp.googlemail.com with ESMTPSA id b18sm2010782pfr.4.2020.09.18.00.23.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2020 00:23:40 -0700 (PDT)
From: Ani Sinha <ani@anisinha.ca>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 01/13] tests/acpi: mark addition of table DSDT.roothp for
 unit testing root pci hotplug
Date: Fri, 18 Sep 2020 12:53:13 +0530
Message-Id: <20200918072325.9933-2-ani@anisinha.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200918072325.9933-1-ani@anisinha.ca>
References: <20200918072325.9933-1-ani@anisinha.ca>
Received-SPF: none client-ip=2607:f8b0:4864:20::641;
 envelope-from=ani@anisinha.ca; helo=mail-pl1-x641.google.com
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, jusual@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Ani Sinha <ani@anisinha.ca>,
 Igor Mammedov <imammedo@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

A new binary acpi table tests/data/acpi/pc/DSDT.roothp is added in order to
unit test the feature flag that can disable/enable root pci bus hotplug on
i440fx. This feature was added with the commit:
3d7e78aa7777f0 ("Introduce a new flag for i440fx to disable PCI hotplug on
the root bus")

This change documents the fact that this new file addition was made as a part
of the unit test change.

Signed-off-by: Ani Sinha <ani@anisinha.ca>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..ac864fc982 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,2 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/pc/DSDT.roothp",
-- 
2.17.1


