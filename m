Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2120EC433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 15:41:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D66720872
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 15:41:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="p0v1YiBU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D66720872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kID5B-00088P-9P
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 11:41:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48646)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kID2S-0003oq-3F
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 11:38:36 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:36395)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kID2Q-0004W7-Lj
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 11:38:35 -0400
Received: by mail-pj1-x1044.google.com with SMTP id b17so1901306pji.1
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2020 08:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=HHdiOGLkXts4NNVu4SCMzFcJi56aYTGQpkW5PEoj6js=;
 b=p0v1YiBUp3lHWdus5fOE6gnni+/s6sW9C0VAT2Aj9a4lsACft7c4po1vvT0O+sl+SD
 F64YwM4IeDDetVrxyLp6TUqH+reXA9cDWbg94PnOIBcP5MVkXGYc9nlvipTTnZhiZvit
 3rqsMvh8vvBEKk8+QZMgmx6D0IpA5kMDVSSTNAWW0BTnuJlJFPkvYglUlydRV32tBLUU
 8I4somFN/b3OZcQknZVZVrFCxOFcdyVbTDFNZt+845C9tLKNWYBTpGTeybRd4AgIIU+v
 4V5NxYCg/AZvhUoQ5KqkfYqD2JRlpfrGHRFjRYINE+BnAWXpPLiH8WR8r4ntm0WTCcVT
 3GNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=HHdiOGLkXts4NNVu4SCMzFcJi56aYTGQpkW5PEoj6js=;
 b=lFeuNP4DI3vI7PPaQpvuVtqPv5fpu4flOGNi5Y2KIjI0gZgMpm9zkuS+VAjNJkr+Yp
 WJ4hurxR5vHclbhcydxBvuQ2yS2mHHfK916IUWFlnOLfQ57ai++B21EYMfqBocV+XCuB
 iAbleCUFRzmgeQlLkO3TheQMWsZfrVfKMLWDT7ilr/hvtbOkLp5B0zEenHfkshZHYP+Y
 pv93h4fMp3/3ZnGI5MtH2ezOorrzwLCJyDDyIZ9bAvlH7sgHIw5cI5q+xMC56/SYIQDc
 WNau1lOlqiVr4NPny0A2OXLZL2ukC1myy9HLbyC7IRR2Ymp/JO3rHzpLX3iXQ0mArQMq
 Rv8Q==
X-Gm-Message-State: AOAM530xe+dvO4l8lZVusvfZXfVwWu9Z1KgQEk11YNwbqf0GP8JxkzWI
 2FLXFrfox7KX1tnZRboJTlNH5p6ZHwNQ7wMU
X-Google-Smtp-Source: ABdhPJxYQRzdwSOao+dvPjqslm2AAautRkG+jm+JeLcn2yZrEfbTq06Ix7UIy2DQaMbzLBl9aUn4BQ==
X-Received: by 2002:a17:902:760b:b029:d1:9be4:856b with SMTP id
 k11-20020a170902760bb02900d19be4856bmr19152307pll.1.1600184313086; 
 Tue, 15 Sep 2020 08:38:33 -0700 (PDT)
Received: from localhost.localdomain ([115.96.130.76])
 by smtp.googlemail.com with ESMTPSA id 194sm13283547pfy.44.2020.09.15.08.38.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2020 08:38:32 -0700 (PDT)
From: Ani Sinha <ani@anisinha.ca>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 1/9] tests/acpi: document addition of table DSDT.roothp for
 unit testing root pci hotplug on/off
Date: Tue, 15 Sep 2020 21:08:10 +0530
Message-Id: <20200915153818.13020-2-ani@anisinha.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200915153818.13020-1-ani@anisinha.ca>
References: <20200915153818.13020-1-ani@anisinha.ca>
Received-SPF: none client-ip=2607:f8b0:4864:20::1044;
 envelope-from=ani@anisinha.ca; helo=mail-pj1-x1044.google.com
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
 "Michael S. Tsirkin" <mst@redhat.com>,
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


