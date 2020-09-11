Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C355C43461
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 18:11:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4ED4207FB
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 18:11:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="sKQdulpc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4ED4207FB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGnWH-00078k-ST
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 14:11:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53978)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kGnTV-0002xG-Ao
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 14:08:41 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:43996)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kGnTT-0005xw-Mz
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 14:08:40 -0400
Received: by mail-pg1-x542.google.com with SMTP id t14so7178133pgl.10
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2020 11:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=fmZ0zShxvpsHgpLnoq8aruXTkYTNo4xgCabQ1KXMZUo=;
 b=sKQdulpcLpdgPKeI+qu69CuQjlF0DPf8n4ur+lHZiQ1FNz1npvkmBYVOOqGfA0s0Fg
 ufyUfaiPojWH17n1NCtQ7EF9wyiOiqxXQrOHZHYn2EHWXyMeQlzBXxFV7xwkHxuZExTR
 glet0tD0OdWvWDulfMScDO66/hAoYKD+88F0ot5dNQM58hC7AmsBUHJXoY5dicRDlpsM
 vDnwMcojT81gImGI1n5uZCQFfvROAC+NtxofBwaRMNW1pUNd/4d9F9n2HbLLo/QWU0Uq
 lOY+WCaae7J/cwhPjom249+5bj+WIsnFRpbA77WCK4zvIsYi5Q2va/lomfmkW37D5mDf
 EtAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=fmZ0zShxvpsHgpLnoq8aruXTkYTNo4xgCabQ1KXMZUo=;
 b=uYcy49a7YTxCfu8b23Xlu8Bpo1ITkeaF5eYIIxoiZ2CqCFSvREDLIN+l29zf6e+Itw
 urvVYjfq8ZFxJdFqP+pwLnMCRlfev+dqZEju9bAVf5YSXq96F/b4d0+a1ifiEPwA2Unw
 IZcVQAax2U/IGHEz5tk7F4QqllxLxQaMK4fFzy0tk7y8ihl4iBXLvfO4J2krOU7S83Zz
 PLe2Qsn+4EYrElhBVbATGjPne9ySz6eXE3EeurCssGSydWipzcazoCMTt3DP7R2u+uwm
 YsKBlPv02hcDFeiYrCDduDExCQYsnF4uJ+IsP/KRjJCHmJdb+XvG9w1BdbSENlUbshTg
 bzLQ==
X-Gm-Message-State: AOAM532reWn/SiA00oL0z5+h5bSCWzj/Z80ZXYQzbeSJ8eLPhB5d1xRY
 09p9cvpkgp2zdgKTKNVLR5obN7ifmQCwVg==
X-Google-Smtp-Source: ABdhPJxmhvvUo2uWs/IHdZLNxLZWJlpxymQpobGxlZQoKs8Yt9mOjeLfbFHJd2HNUddJuL0k1/l7rg==
X-Received: by 2002:a63:4451:: with SMTP id t17mr2426027pgk.92.1599847718188; 
 Fri, 11 Sep 2020 11:08:38 -0700 (PDT)
Received: from localhost.localdomain ([115.96.135.201])
 by smtp.googlemail.com with ESMTPSA id n9sm2929135pfu.163.2020.09.11.11.08.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2020 11:08:37 -0700 (PDT)
From: Ani Sinha <ani@anisinha.ca>
To: qemu-devel@nongnu.org
Subject: [PATCH 6/9] tests/acpi: list added acpi table binary file for pci
 bridge hotplug test
Date: Fri, 11 Sep 2020 23:37:52 +0530
Message-Id: <20200911180755.28409-6-ani@anisinha.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200911180755.28409-1-ani@anisinha.ca>
References: <20200911180755.28409-1-ani@anisinha.ca>
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
Cc: Ani Sinha <ani@anisinha.ca>, Igor Mammedov <imammedo@redhat.com>,
 jusual@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>
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


