Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2FDCC433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 14:44:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2D87206A4
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 14:44:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="AHFYII3y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2D87206A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kICCN-0006jy-Oa
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 10:44:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33030)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kICBE-00056r-QN
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 10:43:36 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:43944)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kICBD-0003vG-6D
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 10:43:36 -0400
Received: by mail-pl1-x641.google.com with SMTP id e4so1458918pln.10
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2020 07:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=HHdiOGLkXts4NNVu4SCMzFcJi56aYTGQpkW5PEoj6js=;
 b=AHFYII3y8ndNEiZxlUPIjHgD0D6NrGfILnnbjoTzeFbt3p/OBCm/yr/1ULcKs2wv+3
 jANfqJV8TngyMevvcmA5H98yI1lY7Jz2ND7F5ujqnudcMAk57qQgKYevLRxXr2ePANd/
 Pg2VsShcmu4zWtWzkUplT6m8QwH+MME/7aQPiP7zMWe0GSUobnvzSVz1jRGwFL5oc9vr
 BDXBbE/DAdwIO7m9RBRZZkSPnxjARxsM2ke5M7j+AfcwqR7RTrMGTg7YrX3gdeEkzOz9
 zjtvaOjMr2mDjX2hFh1IKiH9g0xmqKWm56sx+YyMJrPQAa0uZEqpxAxqXTqE2AdJVFwF
 VNBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=HHdiOGLkXts4NNVu4SCMzFcJi56aYTGQpkW5PEoj6js=;
 b=HupnXYqAgx+IoKb9B2KEotaN6rtQiAYJru65r5cMg7cQYUFQvr9/EjbpmHKOo/p1EL
 WiXNTs0WopRasOAZC2Dm+O/Ec4JPc+YX2cJqiz0KQ/uVGZDW4U2Z/+hK1Ohj4RNN43HC
 nToQPjGJka+Pjo8Ow2cZJAp3ziUeKYq/eeELZu6KJ+yjL7lyLFYVk/RlbvFbs0NawgXw
 b2oA/R+gPShTyOwc5k0H6Ng+qCMHRCtliy3GDw5QMXbsWP46IAdDjQoRe93iXtKkuNJJ
 0n4ntmu7DpqpUUM8+dThpu36ChvpQEKlbt+hVOyJ6muglbVa3brvYc37pNfBCMVQnWyf
 RvIQ==
X-Gm-Message-State: AOAM530MsJ8X88eKu3AgppMWexO/o6HiBMIJhXf7v7JS4yIwME2nXJF5
 auZ+x5NmjqaepEU58SuFhvdahO5mK+IoeOfr
X-Google-Smtp-Source: ABdhPJw4nf6C53KY3rH0hpwEEL2mQ6ZFEOgxTp8wFQQh+r6xbXGXKNvZOLiuYga2uz5ZiRiDSs87DA==
X-Received: by 2002:a17:902:6ac7:b029:d0:89f3:28d1 with SMTP id
 i7-20020a1709026ac7b02900d089f328d1mr19071487plt.13.1600181010184; 
 Tue, 15 Sep 2020 07:43:30 -0700 (PDT)
Received: from localhost.localdomain ([115.96.128.178])
 by smtp.googlemail.com with ESMTPSA id r2sm11520693pga.94.2020.09.15.07.43.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2020 07:43:29 -0700 (PDT)
From: Ani Sinha <ani@anisinha.ca>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/9] tests/acpi: document addition of table DSDT.roothp for
 unit testing root pci hotplug on/off
Date: Tue, 15 Sep 2020 20:13:05 +0530
Message-Id: <20200915144314.4997-2-ani@anisinha.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200915144314.4997-1-ani@anisinha.ca>
References: <20200915144314.4997-1-ani@anisinha.ca>
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


