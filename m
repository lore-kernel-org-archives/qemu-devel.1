Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6377CC43463
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 08:53:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB89B208C3
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 08:53:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="L65kxwba"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB89B208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJC99-0006Hs-P7
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 04:53:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37030)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kJBxp-0002IL-5l
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 04:41:53 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:43764)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kJBxn-0007qQ-Gk
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 04:41:52 -0400
Received: by mail-pf1-x442.google.com with SMTP id f18so2991528pfa.10
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 01:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=V/i6UARRudUJoRdXtPW9d7XXfNZPRvXdDsElEekj7OA=;
 b=L65kxwbaKaDYqM0gI3RXJTWzK/1gQ9cgXUhCNcpU4XJhVlPR7utNeGKk0VBk8W9l4s
 ygkjf09elqxZ0/yrbPhbjDAVPcLNuHrA2V+yI3C0auKTZD0dsfY+K81zEs0lB7A8y4Hi
 CQCqPDTv/Tnz/g4/RxL+wCE9hkXVcOdbbqpD+Q22lTTAAVTMcaZjufV8t4VIS8dAtRVH
 mYuQr7oyAy4nka0kmsFb8zdtTVmUb8ITrEFAtTLFJhzjjpamGQvBgKHhH9X8V43hqMIB
 ChPXFu4+KPtMMs+p3Dqjiy40tlHCqgn4Ms+e0n9YLPP3vrAj+nDOai89sRmH7yOKKuV5
 Oq6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=V/i6UARRudUJoRdXtPW9d7XXfNZPRvXdDsElEekj7OA=;
 b=Fs9FkQL/llGFE/W2UNjeO6NK5ueruGKI7mDWR4dSGwMbvJwOHQCF1VgMQELU8GFbLP
 3gtrqJlAE9tdpjRB3hRcxp7KBt2HEHjpMwwx0xEWle5AGkeT13X8527U6YWAOysJOMj1
 0gGTRcgzmIR3ssO5MhNA/DSMauB5suxbPWCHIur/xa8L0/3FyyDBzkcpZyqREN+HL0aX
 eHoItBYMjfujBh2Wwpfbn7HI+inzcOBNklsHbgUjpxVgrbgOScnjgj2sDvRRHkywnTdX
 8rPeWI4OCKohdKXGXAfdTo9QhUs1annslltET7KmvTrDKc6pDjUj+AnLF+1xBmOOBPwz
 TJ1w==
X-Gm-Message-State: AOAM531BChtqYbUkKXU3/Xw47BqPxlqNvFwk7XFqV1ociFVpWL1vk87H
 fLHzondYL8e9m6TI+moGYxnW7w==
X-Google-Smtp-Source: ABdhPJy3agh9ZP5ElxEdk3vlQptGKRdHxCRDEpIhg2YCND1HE2BnZDZsBdVNPqO4H+xxlz8Jzu0Mnw==
X-Received: by 2002:a63:184b:: with SMTP id 11mr12481235pgy.298.1600418510281; 
 Fri, 18 Sep 2020 01:41:50 -0700 (PDT)
Received: from localhost.localdomain ([115.96.124.157])
 by smtp.googlemail.com with ESMTPSA id gi20sm2120603pjb.28.2020.09.18.01.41.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2020 01:41:49 -0700 (PDT)
From: Ani Sinha <ani@anisinha.ca>
To: mst@redhat.com,
	qemu-devel@nongnu.org
Subject: [PATCH v10 06/13] tests/acpi: list added acpi table binary file for
 pci bridge hotplug test
Date: Fri, 18 Sep 2020 14:11:04 +0530
Message-Id: <20200918084111.15339-7-ani@anisinha.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200918084111.15339-1-ani@anisinha.ca>
References: <20200918084111.15339-1-ani@anisinha.ca>
Received-SPF: none client-ip=2607:f8b0:4864:20::442;
 envelope-from=ani@anisinha.ca; helo=mail-pf1-x442.google.com
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


