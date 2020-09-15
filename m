Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3628BC433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 14:47:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A59B4206B5
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 14:47:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="sJLXYDNU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A59B4206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kICFM-0001p7-QX
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 10:47:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33114)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kICBZ-0005dR-K6
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 10:43:57 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:54684)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kICBX-0003wY-Si
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 10:43:57 -0400
Received: by mail-pj1-x1042.google.com with SMTP id mm21so1877875pjb.4
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2020 07:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=fmZ0zShxvpsHgpLnoq8aruXTkYTNo4xgCabQ1KXMZUo=;
 b=sJLXYDNUVVBG6iFbN/fmRuiCQNJVCoQxe6oWDVqxmXyvC4whl+3xMzZ0Qlgk6XYlIw
 FnSqtqKoYYOoiyJ1WOY/CrKxxM/Zu5Wa/inWAwQDTEhIoP8iIsiAnxDmg825KJ+Tw99a
 HXDZ9UPFpO8zi7JX23hGKgjJe+TonqPmdrp2uOH8aKF3PwB0OgjX3Hfq6K8DRbK4pDfQ
 gH7vMtd6uQ3w/Jw7CWdNL4z387J9AdLziB5Zl4EQa+LgmDX+zqwYmPlMDYfK77U1+D0s
 fxeoG+n8tJkv0eJlzf83hwsFP+cO6PNm+1qIjfiex1zJi59dh9ep0jHkKSP+R4OU0IpG
 ZEaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=fmZ0zShxvpsHgpLnoq8aruXTkYTNo4xgCabQ1KXMZUo=;
 b=gZBuID8YelH7SEgcgA7OrTSL3AdImide6OF7ZSilcLC5ZmG7P7Irukavi2IrSSj0e+
 q83htY+70iJ7pHHD+pT77qJZDdjFsO56QBll7ptQAhJUaqqDscgvcQZWNmTOELB3Hc5o
 XEHQqFqLtcm/S796DZs64ygvoDtSqV/4/9CyQLDv6HG/4BCr4dMStLXqRTNsHTSF+t3w
 PWXzLOS3GHg8+AyJqM030154SXHn7pAHqHoFJu6TGKAaMXa0z2V8UZgNJdRNPAiteW5M
 HoIG/XsL0MVqGJbrDXlw7mD2VmcJNbOkjQta+1LfsGAAAt8E2g21kmFSJaV5X9RHPAu8
 WgHg==
X-Gm-Message-State: AOAM5335WthveliG9TC/Xe9j+L2UA/Reno1hmPIVFOEG4jwPI0GonRdq
 y+BIKQg6oUgaInQopisCAMnMxTqGtwVl2DQd
X-Google-Smtp-Source: ABdhPJwghds48BP67HU/Cm3pKFVw+cjupcXmI5XU7R7AWT0ohwniNBStBkB4mZom8lGkr5GrX4JtnA==
X-Received: by 2002:a17:90a:d991:: with SMTP id
 d17mr4226319pjv.95.1600181034204; 
 Tue, 15 Sep 2020 07:43:54 -0700 (PDT)
Received: from localhost.localdomain ([115.96.128.178])
 by smtp.googlemail.com with ESMTPSA id r2sm11520693pga.94.2020.09.15.07.43.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2020 07:43:53 -0700 (PDT)
From: Ani Sinha <ani@anisinha.ca>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 6/9] tests/acpi: list added acpi table binary file for pci
 bridge hotplug test
Date: Tue, 15 Sep 2020 20:13:10 +0530
Message-Id: <20200915144314.4997-7-ani@anisinha.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200915144314.4997-1-ani@anisinha.ca>
References: <20200915144314.4997-1-ani@anisinha.ca>
Received-SPF: none client-ip=2607:f8b0:4864:20::1042;
 envelope-from=ani@anisinha.ca; helo=mail-pj1-x1042.google.com
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


