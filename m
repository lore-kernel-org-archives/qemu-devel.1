Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D063AC433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 15:42:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 369CA20872
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 15:42:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="NG6T35Yy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 369CA20872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kID6R-0001Af-4Z
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 11:42:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48784)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kID2q-0004Sy-Cf
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 11:39:00 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:41014)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kID2o-0004aC-Nz
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 11:39:00 -0400
Received: by mail-pg1-x544.google.com with SMTP id y1so2176319pgk.8
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2020 08:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=fmZ0zShxvpsHgpLnoq8aruXTkYTNo4xgCabQ1KXMZUo=;
 b=NG6T35Yy1HdoC8Q27IcKJ3xbCVpFlbXMDJQgFz8KQnPRM4ZlW3gNLD7IsGfj9/CA1E
 Xop4iziwIyzgsJLwToGMzdE+OIET4Vr3PSOMuUWWq4f8gSeMt1kGrghq9w8WDtL2c3ug
 uRs3v3ESMuKPDSa5Z6Id8+dqwwrpZAwXdt/Fu8GlscwXbyuHacm5hr3xm6hGnD7skCtE
 5ZZdEPAIGKJ/fVS9uWwai2I7uyv3eY4HCT6t227yb4qfBaU0jMy4E8Hrc0Y/ZSMb7sJQ
 QOEhlhJA7iiikI06KNn9xVlTraq/OwXfH5w8jXWDgKq32JfjzyaxMbB7LNxW9+/7EQsu
 2Zbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=fmZ0zShxvpsHgpLnoq8aruXTkYTNo4xgCabQ1KXMZUo=;
 b=BSg3Im6vktNlT7gNeKIh/Ab7eIms0wFCYrX/8cTbhlmvXeMHptASrDt5TNMZaTLFjW
 OUbD9ZQiH55vmqhJYe4161saknSYpbCWai/1g65E98RDOyNzVPRLj4w5VChUi77bvZyA
 56gb89oAv9XGLqaeF/15aYXCOQhW3DkVRxw1YGUNC09DTM8maymxkkFTQrxnXmTbGfny
 tw+E9a4eQOnbQ9vaVYns631r2fD2QKpzCuIp5Oq9vt5GTmuOwJ0eeu9zizg1Qc0qeUyZ
 ZOAntJUqaHoUtx2N+oSdkVUldXRiZyUgPEO53gIURTzW4PiRSc/mTy+RcmGgBmlQsCLn
 fSPw==
X-Gm-Message-State: AOAM531nX2tJYu630NHTD/3mslsuNmWZ4ltJX8ipBt4qMtkmiOk/4LcV
 QFMdwg4nzOd+Yf7geoBhM70YcdDsnwkO/Hxh
X-Google-Smtp-Source: ABdhPJyqHPPMfa3OjSvIJeXiwiX4VuiZ7FJ5lXDfzRvzoEgo/SkaRVLgpDNRNKQJrSp7WkBoZPbiaA==
X-Received: by 2002:a63:4405:: with SMTP id r5mr15164184pga.382.1600184337126; 
 Tue, 15 Sep 2020 08:38:57 -0700 (PDT)
Received: from localhost.localdomain ([115.96.130.76])
 by smtp.googlemail.com with ESMTPSA id 194sm13283547pfy.44.2020.09.15.08.38.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2020 08:38:56 -0700 (PDT)
From: Ani Sinha <ani@anisinha.ca>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 6/9] tests/acpi: list added acpi table binary file for pci
 bridge hotplug test
Date: Tue, 15 Sep 2020 21:08:15 +0530
Message-Id: <20200915153818.13020-7-ani@anisinha.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200915153818.13020-1-ani@anisinha.ca>
References: <20200915153818.13020-1-ani@anisinha.ca>
Received-SPF: none client-ip=2607:f8b0:4864:20::544;
 envelope-from=ani@anisinha.ca; helo=mail-pg1-x544.google.com
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


