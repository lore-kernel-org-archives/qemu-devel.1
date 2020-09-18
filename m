Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 078A7C43463
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 07:28:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9522820795
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 07:28:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="piBczwzi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9522820795
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42956 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJAow-0001cH-N1
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 03:28:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34920)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kJAku-0003Oa-5m
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 03:24:28 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:32808)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kJAkr-0003NV-LB
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 03:24:27 -0400
Received: by mail-pg1-x542.google.com with SMTP id s65so2964680pgb.0
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 00:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=iYSIbOnnSn3T+3SJ4V+IEXXiDDie26XYTCZq6+x9/Ks=;
 b=piBczwziOQ7rwgHY6wwHMcIxsTFUoG6W2ye3CnT8RqpVphVFD8SKweSlKQjLksl3Wi
 zHz5fHlIoUKtcBLsSdQo5GkIWM+3e6hAKZScJprXrlnZdzORRvcZFe/OIyT2EZdXuDSc
 QCf10VCLSwlcpaeQb1RfyBB39D1HLcVYrXpBMm4YX/KAwttLM8i0F+lp7h0IH5UfwPrs
 /aU9hIskM3HAykm8+GAkdUA1DdaftqxQC5gMX3dW5SubylZ0MhiPULyTXSLIIavupYqi
 T/Sepb8zf9tnOnylIz6axwGlZ+/VOQWhLgEr1GoKyTabOi/01sinpfgy7phnbtCEZ9AP
 ELGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=iYSIbOnnSn3T+3SJ4V+IEXXiDDie26XYTCZq6+x9/Ks=;
 b=f3SOaHq+7tNVnXbZjdGDZYJl3qNu5MhHNS/yp1cHFvUOnRCuB8Sh1HIzgYFY4GV1gg
 lqPuIRxwwjDzf1QhSzXwqgw8oKFxOuG9qoV1wqTmU/JaSolW8OsQ1u1Dt59Uq6ysS9oF
 5G2V5ZfMp9KTB8q480+dhwlpODX0Mm5JQusn38Gtc1thPKsSUJ1iuR2UOaahqqxLuwPP
 80C1mxFbvI6PpIT+kz/S2/CfmpFCigUz6s913KnhhBxM1qShVTDDVMlGkZ2+1G8SJhk/
 A2s5qvcwuR7l69kEidFyVo/Z/NmGg5KssfLR070LpHRvfTljGmbNGdSzkkVgZIgJxFNk
 WB7g==
X-Gm-Message-State: AOAM532Idy5ejh7NjQTfXJ0DThJfb9mHqa4B81dU4qyD7gZQF7YR+i7A
 cFCQ7bA8BqzD4vEvCRn8HzBANwkSlmLx0FDC
X-Google-Smtp-Source: ABdhPJycJXST/nKxrQlIJFdlrBNxn61fxlroB4KnZA0N+UojRA3VxMtzFrAbceYQYpj9vdyipm1Y+w==
X-Received: by 2002:a63:521c:: with SMTP id g28mr19192625pgb.43.1600413864095; 
 Fri, 18 Sep 2020 00:24:24 -0700 (PDT)
Received: from localhost.localdomain ([115.96.124.157])
 by smtp.googlemail.com with ESMTPSA id b18sm2010782pfr.4.2020.09.18.00.24.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2020 00:24:23 -0700 (PDT)
From: Ani Sinha <ani@anisinha.ca>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 09/13] Add ACPI DSDT tables for q35 that are being updated
 by the next patch
Date: Fri, 18 Sep 2020 12:53:21 +0530
Message-Id: <20200918072325.9933-10-ani@anisinha.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200918072325.9933-1-ani@anisinha.ca>
References: <20200918072325.9933-1-ani@anisinha.ca>
Received-SPF: none client-ip=2607:f8b0:4864:20::542;
 envelope-from=ani@anisinha.ca; helo=mail-pg1-x542.google.com
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

The following patch 7b7d8ff077 ("piix4: don't reserve hw resources when
hotplug is off globally") modifies certain ACPI tables for q35 machines.
This patch adds those table names to tests/qtest/bios-tables-test-allowed-diff.h
so that unit tests continues to pass and bisection is not broken.

Signed-off-by: Ani Sinha <ani@anisinha.ca>
---
 tests/qtest/bios-tables-test-allowed-diff.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..631703142c 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,11 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/q35/DSDT",
+"tests/data/acpi/q35/DSDT.acpihmat",
+"tests/data/acpi/q35/DSDT.bridge",
+"tests/data/acpi/q35/DSDT.cphp",
+"tests/data/acpi/q35/DSDT.dimmpxm",
+"tests/data/acpi/q35/DSDT.ipmibt",
+"tests/data/acpi/q35/DSDT.memhp",
+"tests/data/acpi/q35/DSDT.mmio64",
+"tests/data/acpi/q35/DSDT.numamem",
+"tests/data/acpi/q35/DSDT.tis",
-- 
2.17.1


