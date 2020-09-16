Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B37DDC43461
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 06:26:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49C1620684
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 06:26:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="CEBULknC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49C1620684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIQtq-0008MG-6X
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 02:26:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59316)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kIQha-0001SZ-7X
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 02:13:58 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:36744)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kIQhW-0005hg-Tk
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 02:13:57 -0400
Received: by mail-pj1-x1041.google.com with SMTP id b17so999452pji.1
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2020 23:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=HHdiOGLkXts4NNVu4SCMzFcJi56aYTGQpkW5PEoj6js=;
 b=CEBULknCTRQF7PfgSYBeZ8rGdbc9UpqyIMiSlrkOMB/y6ZVVFmB2nN0nL3rDSBhUe2
 ghNfKqKVXMjmvJS8NcqzNuqunsMR0RkCb1ejC2b3fJ1Io/FkPY2lWJ29klH5o+SouE55
 +APEOcNyqt6IZSSOLaiRfTc3IxKMUzknQi0meJ0i+LLc1ebcof1ujeyopyCcbj7kt2H4
 KjFtvqnYdxcGOcQ8ztqojVPKmXRemEF8R7MSo/vjFT/aGW8pY1z6Q+dCnhbX3dLKYLJ3
 Kd02L4mEVYLq0S+btu6fAi5r8RPBz9TeBvA4M6wW7YsxfQvEl6o6yDmJKMZmsulR3xOM
 jYBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=HHdiOGLkXts4NNVu4SCMzFcJi56aYTGQpkW5PEoj6js=;
 b=q7rPoEtEf65BXcONaohoj5HlaGB34loo+ZFiq9PUJeAlVoLAKjD2pjYafCdXG4nky6
 aAHQsEOnjhmbvTGjhBrypszQ5sRnMg3kZ3i1eCLoGSC7Y6yPGQar3xAyicjAF50uOIsh
 D58FSJrnzlxpNsgGt9fZVWQV1TVWy+RxzqpzRUpaWrRXBSMjvrIqKjUp6TcM/HohKWU4
 NfuE2Fj/H1WLcpT5+fZPcJrwj7pEpK8vEiKSza7s6P+UbcNizSRnTw44MEjc3oMC2Kmz
 rOKZNbUXBz4Kc7lAlUoxG7gRu2L7z6Hv0Xr6uv7tRP30z6of75zxHrRcsYZ/9Up1Ha7z
 iFcA==
X-Gm-Message-State: AOAM5324ekuBrCAI1QsK0mUiBhg54/BHsI+lVlx/8FB2KsOQ9/Bjacqa
 6YdWC8FkS5z2e4+eQlfJ3KuZNzDw+//6vnAP
X-Google-Smtp-Source: ABdhPJzEZLj8HxdjUKRyrml4a0Mh+Yjva2nXP9Jfpi38ky6zXKAiBDzYdFYQumvUymmkGrDdZGDl0g==
X-Received: by 2002:a17:902:a706:b029:d0:89f3:28c9 with SMTP id
 w6-20020a170902a706b02900d089f328c9mr22400984plq.5.1600236833243; 
 Tue, 15 Sep 2020 23:13:53 -0700 (PDT)
Received: from localhost.localdomain ([203.163.234.244])
 by smtp.googlemail.com with ESMTPSA id c20sm583164pfc.209.2020.09.15.23.13.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2020 23:13:52 -0700 (PDT)
From: Ani Sinha <ani@anisinha.ca>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 01/11] tests/acpi: document addition of table DSDT.roothp
 for unit testing root pci hotplug on/off
Date: Wed, 16 Sep 2020 11:43:25 +0530
Message-Id: <20200916061335.14045-2-ani@anisinha.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200916061335.14045-1-ani@anisinha.ca>
References: <20200916061335.14045-1-ani@anisinha.ca>
Received-SPF: none client-ip=2607:f8b0:4864:20::1041;
 envelope-from=ani@anisinha.ca; helo=mail-pj1-x1041.google.com
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

A new binary acpi table tests/data/acpi/pc/DSDT.roothp is added in order to unit test
the feature flag that can disable/enable root pci bus hotplug on i440fx. This feature was
added with the commit:
3d7e78aa7777f0 ("Introduce a new flag for i440fx to disable PCI hotplug on the root bus")

This change documents the fact that this new file addition was made as a part of the
unit test change.

Signed-off-by: Ani Sinha <ani@anisinha.ca>
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


