Return-Path: <SRS0=H6GY=TQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 203FCC04AAF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 12:40:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E95B120815
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 12:40:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E95B120815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54177 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRFgo-0001ww-64
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 08:40:50 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49262)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hRFNq-00026f-EC
	for qemu-devel@nongnu.org; Thu, 16 May 2019 08:21:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hRFNi-000347-KI
	for qemu-devel@nongnu.org; Thu, 16 May 2019 08:21:12 -0400
Received: from mail-qt1-f169.google.com ([209.85.160.169]:37470)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hRFNh-00033A-Lw
	for qemu-devel@nongnu.org; Thu, 16 May 2019 08:21:05 -0400
Received: by mail-qt1-f169.google.com with SMTP id o7so3579265qtp.4
	for <qemu-devel@nongnu.org>; Thu, 16 May 2019 05:21:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to;
	bh=+WXo3EqETBhGlQu1W7AYn425p9hkEPi839GhvLKqIZo=;
	b=sETnLPxTQfhlYIWOWgqTrt/8RQ7Nw1XCVYAzT/jyVZjAph//lmu1fF3ru1mTbBh7RG
	5zqbnzFRdshIzWZQ3h2fq0hVkisEK2KUOzT4byib/c3Qzh0cZVyN+kFkYfONwIlmcAAW
	qZED681S723FN48z0bxvYL0QBexq5V2PvwSNfK8vHdc7ZdSnUivx57sBL19RWgdq1rLU
	bOhtov/3Rr4asuid0vUNQNNfPm661KzOcEB3OSj4eknB1FsTqCEgvWR+pNLVkrdgsT55
	DUfcYhR9wodhL/GWwBvQiYCHdbD989S1BxzpPJc6Brz5/JRxOJQsp/vRahyHa6bupINZ
	BExw==
X-Gm-Message-State: APjAAAW6CMKvGnrGUObr/UtwR6nKvjDRvAz9lksTTX85+COgVg8qyI+0
	2uERaPtNDjosBgjI25RKtQppbC7PS3s=
X-Google-Smtp-Source: APXvYqxAKpMRS6rREj0jNsrLFE1i6EK2wKBR47E1S1NqSBJ6jMFgKf45ytiByrSRPlCAkGWDtToh+Q==
X-Received: by 2002:ac8:65c1:: with SMTP id t1mr42394220qto.13.1558009264656; 
	Thu, 16 May 2019 05:21:04 -0700 (PDT)
Received: from redhat.com ([185.54.206.10])
	by smtp.gmail.com with ESMTPSA id e3sm3366279qkn.93.2019.05.16.05.21.02
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Thu, 16 May 2019 05:21:03 -0700 (PDT)
Date: Thu, 16 May 2019 08:21:01 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <1556808723-226478-12-git-send-email-imammedo@redhat.com>
References: <20190515121146.7248-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190515121146.7248-1-mst@redhat.com>
X-Mailer: git-send-email 2.17.1.1206.gb667731e2e.dirty
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.160.169
Subject: [Qemu-devel] [PULL 33/37] tests: acpi: allow to override default
 accelerator
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Laurent Vivier <lvivier@redhat.com>,
	Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
	Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190516122101.KI1RPQLgDrnBPOfr8MuzFggS1XleKlp9-meclY877kY@z>

From: Igor Mammedov <imammedo@redhat.com>

By default test cases were run with 'kvm:tcg' accelerators to speed up
tests execution. While it works for x86, were change of accelerator
doesn't affect ACPI tables, the approach doesn't works for ARM usecase
though.

In arm/virt case, KVM mode requires using 'host' cpu model, which
isn't available in TCG mode. That could be worked around with 'max'
cpu model, which works both for KVM and TCG. However in KVM mode it
is necessary to specify matching GIC version, which also could use
'max' value to automatically pick GIC version suitable for host's CPU.
Depending on host cpu type, different GIC versions would be used,
which in turn leads to different ACPI tables (APIC) generated.
As result while comparing with reference blobs, test would fail if
host's GIC version won't match the version on the host where
reference blobs where generated.

Let's keep testing simple for now and allow ARM tests run in TCG only
mode. To do so introduce 'accel' parameter in test configuration, so
test case could override default "kvm:tcg" with accelerator of choice.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <1556808723-226478-12-git-send-email-imammedo@redhat.com>
Reviewed-by: Laszlo Ersek <lersek@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/bios-tables-test.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
index 8302ffc2cd..39c1e24efd 100644
--- a/tests/bios-tables-test.c
+++ b/tests/bios-tables-test.c
@@ -24,6 +24,7 @@
 #define ACPI_REBUILD_EXPECTED_AML "TEST_ACPI_REBUILD_AML"
 
 typedef struct {
+    const char *accel;
     const char *machine;
     const char *variant;
     const char *uefi_fl1;
@@ -532,8 +533,8 @@ static void test_acpi_one(const char *params, test_data *data)
         args = g_strdup_printf("-machine %s,accel=%s -nodefaults -nographic "
             "-drive if=pflash,format=raw,file=%s,readonly "
             "-drive if=pflash,format=raw,file=%s,snapshot=on -cdrom %s %s",
-            data->machine, "kvm:tcg", data->uefi_fl1, data->uefi_fl2,
-            data->cd, params ? params : "");
+            data->machine, data->accel ? data->accel : "kvm:tcg",
+            data->uefi_fl1, data->uefi_fl2, data->cd, params ? params : "");
 
     } else {
         /* Disable kernel irqchip to be able to override apic irq0. */
@@ -541,7 +542,8 @@ static void test_acpi_one(const char *params, test_data *data)
             "-net none -display none %s "
             "-drive id=hd0,if=none,file=%s,format=raw "
             "-device ide-hd,drive=hd0 ",
-             data->machine, "kvm:tcg", params ? params : "", disk);
+             data->machine, data->accel ? data->accel : "kvm:tcg",
+             params ? params : "", disk);
     }
 
     data->qts = qtest_init(args);
-- 
MST


