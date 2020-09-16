Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6D2DC43461
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 06:20:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 528C02067C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 06:20:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="o3qwXZHl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 528C02067C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57598 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIQo5-0000jK-AV
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 02:20:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59510)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kIQhx-00022Q-Iz
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 02:14:21 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:43709)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kIQhv-0005mU-Q1
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 02:14:21 -0400
Received: by mail-pf1-x444.google.com with SMTP id f18so3336017pfa.10
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2020 23:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=fmZ0zShxvpsHgpLnoq8aruXTkYTNo4xgCabQ1KXMZUo=;
 b=o3qwXZHlstNr1lKXanIrCPjDnUDYaRnRTolEGqaDHNDtDLQBdXb1pa1dKHGV3HntjW
 /sOcDC3JM4cEaqKyUqMGf2vpovwyUKg5CMT8EtRUN9b0mgRVLjhB1Pe55qwG6GoPK8H7
 XBoyQbGC04k+rnOlH8QjCJM09pewt1lGRictVL9mCvlu0tCsRxLB8pG8gUhmcEBO9PNR
 DEjn3qWSsvP9d+WSIHbI/TWyKUTUmzYBJjCfTZJpaOa1KzAkkFO9NejloIBe+EqUKj/r
 bN4kK56nXDPTVdx9ClKzzC8V5mQFonfZ4sTcyE99T8NYyiOkKx4SJmCaCpoYRQE+QS+H
 1pXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=fmZ0zShxvpsHgpLnoq8aruXTkYTNo4xgCabQ1KXMZUo=;
 b=INB85eDtAj65ihyfFBDH0n+5a7s2uzD1JERSxwsunRY+/nNkOWUUAOniFRLJ6Y0mBP
 J087rEh+/fjI3L3yi+IFfIWSDpFPG/yBofDGrDNCgG3HqyOGr7snOa0pxpe1/IK6NVf7
 7tkSAIYXhGCZSgc4O/yO7mRkJwqIsipYDULeNOymQiBfTAhju3KfSWHabnavDqeCOHjH
 oWagGqGnLnWhGdPIGCe/w1b8WcNwUmOz24Py9MbZCdUYNuWgKxN6rw1dS8WqOmBkr2g5
 CD4AoCQ0diZY12f8n2Cqq1+0gVPVcZjGz0UktSczbi5RJZol8eJVi2e8UUtppvjXBWsm
 KJrA==
X-Gm-Message-State: AOAM532a/ALJT9Gwwr2PCRj4tIbsF+9fZjOrFZCHe5Ju2mzjv4nAqnHQ
 bA0tsZMiI3iKpqsrCYXMJHRLdgHmfuYEFcl1
X-Google-Smtp-Source: ABdhPJyFq0CWY8fBpUHXvxc5uTl0gVpG6Vz4UtCQKPyFIMolv7N1XFNor56Me1jD5C9UedCF8JRlCw==
X-Received: by 2002:a63:4a19:: with SMTP id x25mr16774931pga.56.1600236858247; 
 Tue, 15 Sep 2020 23:14:18 -0700 (PDT)
Received: from localhost.localdomain ([203.163.234.244])
 by smtp.googlemail.com with ESMTPSA id c20sm583164pfc.209.2020.09.15.23.14.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2020 23:14:17 -0700 (PDT)
From: Ani Sinha <ani@anisinha.ca>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 06/11] tests/acpi: list added acpi table binary file for
 pci bridge hotplug test
Date: Wed, 16 Sep 2020 11:43:30 +0530
Message-Id: <20200916061335.14045-7-ani@anisinha.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200916061335.14045-1-ani@anisinha.ca>
References: <20200916061335.14045-1-ani@anisinha.ca>
Received-SPF: none client-ip=2607:f8b0:4864:20::444;
 envelope-from=ani@anisinha.ca; helo=mail-pf1-x444.google.com
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

The file 'tests/data/acpi/pc/DSDT.hpbridge' is a newly added acpi table file for
testing the pci bridge option 'acpi-pci-hotplug-with-bridge-support' under i440fx.
This change documents this fact.

Signed-off-by: Ani Sinha <ani@anisinha.ca>
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


