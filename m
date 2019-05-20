Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD3ECC04AAC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 23:29:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80A2220863
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 23:29:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80A2220863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43581 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSriz-0006KO-L4
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 19:29:45 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45281)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hSrRa-0008DN-Vp
	for qemu-devel@nongnu.org; Mon, 20 May 2019 19:11:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hSrRZ-0008Rt-Pi
	for qemu-devel@nongnu.org; Mon, 20 May 2019 19:11:46 -0400
Received: from mail-qt1-f170.google.com ([209.85.160.170]:32845)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hSrRZ-0008NL-1E
	for qemu-devel@nongnu.org; Mon, 20 May 2019 19:11:45 -0400
Received: by mail-qt1-f170.google.com with SMTP id m32so18404610qtf.0
	for <qemu-devel@nongnu.org>; Mon, 20 May 2019 16:11:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to;
	bh=+WXo3EqETBhGlQu1W7AYn425p9hkEPi839GhvLKqIZo=;
	b=PxgUNVzkJTs9GMk24SR8/jtqidz9y8uQeag5J5dPyeNHNY88tk1Y2sEuHaLDbaOHIO
	vSmkPhja8t7uF31SV2cv69+m7yzTbWk44pIZj8275RGFV8j7sb03UPXZpnf+Kpj8bOig
	eGFF4o0h9iGjcbQpwJMIXL+HHLhGYFnHQRr4K+6ikNB8v33urAmqmc4AtWAwv+TO9coW
	GTW/GCmrbzvIEEHwAOtPVNs2a1YTJ49/z3fgFh6DH8JHJtnh5hgbHPKomCWm81mVdcVg
	7knOGkXNu9iucBMU8YeG9I+SnorfpCbM9PwBTKuCj2RCs1u+t5qRjao/7lK9EhNi+uaR
	bIGg==
X-Gm-Message-State: APjAAAVhxm+nb5jSDD5+uj6EOi4yiRE4ArKvHtATTT8q7bf9hrR7HRvO
	G1j0T9lbjY3lZ+dC+bAUUiLvOH1wEs4=
X-Google-Smtp-Source: APXvYqzV2hhv7A9nWaRAkXcem5H9NUjG5mdon8ImHl+GEmlUbkfCVRHWt1hKsLDSRU7QIflEWt6pDg==
X-Received: by 2002:ad4:5146:: with SMTP id g6mr60245693qvq.136.1558393893067; 
	Mon, 20 May 2019 16:11:33 -0700 (PDT)
Received: from redhat.com (pool-173-76-105-71.bstnma.fios.verizon.net.
	[173.76.105.71])
	by smtp.gmail.com with ESMTPSA id c7sm1290574qkk.74.2019.05.20.16.11.31
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Mon, 20 May 2019 16:11:32 -0700 (PDT)
Date: Mon, 20 May 2019 19:11:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <1556808723-226478-12-git-send-email-imammedo@redhat.com>
References: <20190520231008.20140-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190520231008.20140-1-mst@redhat.com>
X-Mailer: git-send-email 2.17.1.1206.gb667731e2e.dirty
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.160.170
Subject: [Qemu-devel] [PULL v2 32/36] tests: acpi: allow to override default
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
Message-ID: <20190520231131.biiaUSUUDrqmOaylN-r6M7mGeezLuM3LlmtJEJtUs2M@z>

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


