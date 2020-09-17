Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D9E9C43461
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 10:11:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C092B206A2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 10:11:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="q0uH9bfZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C092B206A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIqtQ-0001wS-Bz
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 06:11:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60118)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kIqs0-0000Ql-U9
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 06:10:28 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:39705)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kIqrf-0003O2-GR
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 06:10:28 -0400
Received: by mail-pg1-x542.google.com with SMTP id d13so1082786pgl.6
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2020 03:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=YfALMwALzeYbzwckrxN8lzSGcpwno9FZ6SZJMeQ9frI=;
 b=q0uH9bfZ4EXPfsJBeB7j3pTa1SCBItpwi0YjKBgoCQcYBB5riAQvUT6nFNLVK3x0mb
 ACeazPsiE7GNDXzjt1tebLNwWNNpZjg/jyG00KGEwYwBNxxvo1tNYzHqIxtyUtteY9Oe
 WLJpxkMm+tzvfm7IXuNQOwVAd4/i4qgns4eFk6XhiwsvKVAYvAuetSCDcQOu881Fc/sz
 ye6hQ5Nv6Cs20+bhR6arCtzAgkYJLWZO5O2ZAkA+4Bvh7W7vVNp06MzUome5bqnQTjrl
 99acOGXHOcM1zSGuQuRgXV/PdG7NgqD/qxRC+lDioZsafpl3iZqZ4YmCd8Z0y3WkNBfN
 zy7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=YfALMwALzeYbzwckrxN8lzSGcpwno9FZ6SZJMeQ9frI=;
 b=diStiq5HkSnk7gpPrUwZ2x21WYdsRdE508PmhSXvwJoSF52Z5pP0uHUIbHane6Gi/s
 fd7/Cnq9epeNTILPSW5J8O449Z7ohg4q3cEW+jPk4DaKU6YtxEQfUCb/Cf9aqPqjI9IR
 cbkFKx10aIyG53+GYZpOnMKzUCMMUJC9nOreuQFSezKbBf5InBwedgAwEnXKKy+YAS+c
 jPYRwnZvzbQ6nm194KptsWivGuZpLSrEA5qRJQQTjbc1cGoSUzVsiQ9IcDrdgzjWI+Jl
 5bThaQSU9Cys8x873FEsZgZM7IvP71pQoh3zG8yDiJBfLDnT3mPt+Qxsm6atk1sfS302
 r0PA==
X-Gm-Message-State: AOAM530uVQko6iox1cdms05hVyz270oNyKg2gnmyXKqyIVCJkQ4+z7t3
 NtbaJE2RWR6GMMM1c4qzFrUyVegrWqS2ggHL
X-Google-Smtp-Source: ABdhPJzPs652/rYijhGceaYvN8197dUWhkU8W3RjDQs7yIrmFRRCTa40DIn28LbaigzKy1WTL6oalQ==
X-Received: by 2002:a62:b614:0:b029:142:2501:396c with SMTP id
 j20-20020a62b6140000b02901422501396cmr10198917pff.49.1600337405789; 
 Thu, 17 Sep 2020 03:10:05 -0700 (PDT)
Received: from localhost.localdomain ([115.96.122.113])
 by smtp.googlemail.com with ESMTPSA id d20sm5241559pjv.39.2020.09.17.03.10.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2020 03:10:04 -0700 (PDT)
From: Ani Sinha <ani@anisinha.ca>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 02/12] tests/acpi: add new unit test to test hotplug off/on
 feature on the root pci bus
Date: Thu, 17 Sep 2020 15:39:37 +0530
Message-Id: <20200917100947.21106-3-ani@anisinha.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200917100947.21106-1-ani@anisinha.ca>
References: <20200917100947.21106-1-ani@anisinha.ca>
Received-SPF: none client-ip=2607:f8b0:4864:20::542;
 envelope-from=ani@anisinha.ca; helo=mail-pg1-x542.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, jusual@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>, Ani Sinha <ani@anisinha.ca>,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Ability to turn hotplug off on the pci root bus for i440fx was added in commit:
3d7e78aa7777f0 ("Introduce a new flag for i440fx to disable PCI hotplug on the
root bus")

This change adds a unit test in order to test this feature.

Signed-off-by: Ani Sinha <ani@anisinha.ca>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---
 tests/qtest/bios-tables-test.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index 504b810af5..ad157ef05d 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -740,6 +740,20 @@ static void test_acpi_piix4_tcg_bridge(void)
     free_test_data(&data);
 }
 
+static void test_acpi_piix4_no_root_hotplug(void)
+{
+    test_data data;
+
+    memset(&data, 0, sizeof(data));
+    data.machine = MACHINE_PC;
+    data.variant = ".roothp";
+    data.required_struct_types = base_required_struct_types;
+    data.required_struct_types_len = ARRAY_SIZE(base_required_struct_types);
+    test_acpi_one("-global PIIX4_PM.acpi-root-pci-hotplug=off "
+                  "-device pci-bridge,chassis_nr=1", &data);
+    free_test_data(&data);
+}
+
 static void test_acpi_q35_tcg(void)
 {
     test_data data;
@@ -1144,6 +1158,8 @@ int main(int argc, char *argv[])
         qtest_add_func("acpi/q35/tpm-tis", test_acpi_q35_tcg_tpm_tis);
         qtest_add_func("acpi/piix4", test_acpi_piix4_tcg);
         qtest_add_func("acpi/piix4/bridge", test_acpi_piix4_tcg_bridge);
+        qtest_add_func("acpi/piix4/pci-hotplug/no_root_hotplug",
+                       test_acpi_piix4_no_root_hotplug);
         qtest_add_func("acpi/q35", test_acpi_q35_tcg);
         qtest_add_func("acpi/q35/bridge", test_acpi_q35_tcg_bridge);
         qtest_add_func("acpi/q35/mmio64", test_acpi_q35_tcg_mmio64);
-- 
2.17.1


