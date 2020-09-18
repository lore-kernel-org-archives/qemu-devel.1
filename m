Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1C0CC43463
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 08:43:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E99672085B
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 08:43:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="ODSi3g8I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E99672085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJBz1-00038S-Uz
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 04:43:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36844)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kJBxQ-0001M6-J6
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 04:41:28 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:40745)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kJBxP-0007nN-0H
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 04:41:28 -0400
Received: by mail-pg1-x541.google.com with SMTP id j34so3058476pgi.7
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 01:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=+C/GKper9Hc1Rp3TxABDngRg3jAp3GhgbcS73g/TxHk=;
 b=ODSi3g8IEKjtH2sCiSkTd9j09orjjoLTvOC+USMeu7JNVcLyD2SZuo64NKbGRcPZe0
 xAvvhS++H3v67hbgjyLyDHsZrMAAEtPILZV93xskdkct+yr47izFGo42ZQ+CdEYkoVR2
 /PRnSnLnbzg0HgNYyMHsA/amDvU0JALKb6Sj5yezA23oi6M/TN9+yWNdyMmlgxR6RhVF
 AOc0rQjc00w851jTHCFrUTTTKi/OPnFZU9Mm7WpvnY/LnkQk8c3pKGwyqrmvxiulsZC4
 T9b5btVkglp2j26agkwkk7eep9kRQ/Tgu8jNce7O3QzJ2PbEQYNXwwxhBohUdJ+PRJIv
 nrzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=+C/GKper9Hc1Rp3TxABDngRg3jAp3GhgbcS73g/TxHk=;
 b=GG2WytWL5GDdx43aHi5NDYDnzlPiCENMbww/eM2fN7ecPGXAsA9V21RUr2YmNykFZb
 T30+N1qoAXf3vjVgu4BxJNecLL7orFnYhJCWus6Suf21HcumKdvOng4da8MPUbnV2bg6
 iZfLWtYryZe0lToRs4zrUSPB4hPc80Sk8L9bzxy1wNaW2AoduNGDCXrVEsFxgVZo+kRu
 0//o9c+B+ve9ohQtfWcDWGyV4LCaaK9c+T10cipNQ2IVa20xY9gxi6obbCxOoPlKapsO
 HBllF313hWxZn7b2hcNO6tez0mImMVSvH+ZkXAH8QvPirdMfdqHIzbKjlLXQl2Z77yjo
 PB/g==
X-Gm-Message-State: AOAM533O5GGfgXT4UG9OrhKpoZAWdY9dUqwdLMS1LgVXO8Hv3ic8tWsM
 G1yTjqjxT7pczc4WKGX/rcX/jg==
X-Google-Smtp-Source: ABdhPJx29SiWQ+I0wz5jXJnj4XwO1P4Zqm3/cFy+IO/mmkWiGzV4Wzo7GupTUaIMUFC93KyPF0CvfA==
X-Received: by 2002:a65:57cf:: with SMTP id q15mr20950704pgr.155.1600418485800; 
 Fri, 18 Sep 2020 01:41:25 -0700 (PDT)
Received: from localhost.localdomain ([115.96.124.157])
 by smtp.googlemail.com with ESMTPSA id gi20sm2120603pjb.28.2020.09.18.01.41.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2020 01:41:24 -0700 (PDT)
From: Ani Sinha <ani@anisinha.ca>
To: mst@redhat.com,
	qemu-devel@nongnu.org
Subject: [PATCH v10 01/13] tests/acpi: mark addition of table DSDT.roothp for
 unit testing root pci hotplug
Date: Fri, 18 Sep 2020 14:10:59 +0530
Message-Id: <20200918084111.15339-2-ani@anisinha.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200918084111.15339-1-ani@anisinha.ca>
References: <20200918084111.15339-1-ani@anisinha.ca>
Received-SPF: none client-ip=2607:f8b0:4864:20::541;
 envelope-from=ani@anisinha.ca; helo=mail-pg1-x541.google.com
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, jusual@redhat.com,
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


