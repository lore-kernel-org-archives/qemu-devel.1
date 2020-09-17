Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4567C43461
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 15:11:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CE222078D
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 15:11:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="kFfT7mjZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CE222078D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38858 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIvZa-0007yG-UB
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 11:11:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54534)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kIvPp-0001jo-Kp
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 11:01:41 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:34795)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kIvPc-00012I-EP
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 11:01:41 -0400
Received: by mail-pj1-x1041.google.com with SMTP id s14so2946769pju.1
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2020 08:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=djDyPCHV2KQRcs6lHtT3AJbP4Jr32BITnAiU+WVBllU=;
 b=kFfT7mjZI/pJ+Un6j2BG051k8LgB+LCkCs+WtWYZpj779NFovHt3tGzTj5wpE1EeLB
 ofVo9376vLuvLB611dzWvT/OqlSkA56C3WPs8qLr/4xRiArx4OA5vkWOBHN4OtvD2/uJ
 BOaKfEt+8TN9tWEfsITnc0C0W4LOevoVYCL9EN4cnJBqUhY5a5i37AWkT0VbXinY7y9k
 /jMg5HwzDw50q5RsEMiBbpoNkiBnAcvefDk+1lvunGxqBj5UeLVMvGBZZTVTGk4mjKlo
 CHbwvxyjdV9bJ4Ap/Ek+HsUq2+3NDGnHFxkY9TDBZZOzaRhgpPPiI+z2IFPDWN4gv73A
 YL7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=djDyPCHV2KQRcs6lHtT3AJbP4Jr32BITnAiU+WVBllU=;
 b=Vn1E4rYJBQ/QidZoJPQnaCeprmH3wRRQuSku/EAsZvu8u3vusjI8aK10jxsQWRIyhO
 3r8GU6mtZgVe0mdIPFFPu0gf/FJrnz8KoBEOOL/MLHnincJk5EyjxKNz4DxQn0fGSFsq
 BhRbA0Gs+1lL9p3yuGKs0+j08pLasDy3Ye6fArhVkc8JArtxsKkzWTVqvCI4V/AMbD1P
 rfTl7HYiHMmw8vhL1hXBcZxT14ibrRdywCqsLoZ5ypHhgpi+DuQba54m501l27OgW7Je
 igCbkHy6lkOKGklCPFwum0S1rJYHGQOr2utoJVz9YWKME1vBAKqdUt2mmc5JRIu1cGXM
 N7Tw==
X-Gm-Message-State: AOAM530BDCOYlPJKXysxp1nbjHdoR/ZpgHf1xItZFFG8cI4cLycyeCxb
 IU0GoUJWrmCc4pG52rPTPoBe+JsFetCqvn12
X-Google-Smtp-Source: ABdhPJzXXTFlkJJNnYjhWPcvCx/HTfSv/MU3cmtR2WWUqG62GRLj+IGVAvPKHHoPLzkpnV+LGNSfbw==
X-Received: by 2002:a17:90a:9317:: with SMTP id
 p23mr8623166pjo.160.1600354886049; 
 Thu, 17 Sep 2020 08:01:26 -0700 (PDT)
Received: from localhost.localdomain ([115.96.151.231])
 by smtp.googlemail.com with ESMTPSA id e10sm17674374pgb.45.2020.09.17.08.01.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2020 08:01:25 -0700 (PDT)
From: Ani Sinha <ani@anisinha.ca>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 07/12] tests/acpi: unit test for
 'acpi-pci-hotplug-with-bridge-support' bridge flag
Date: Thu, 17 Sep 2020 20:30:39 +0530
Message-Id: <20200917150044.23159-8-ani@anisinha.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200917150044.23159-1-ani@anisinha.ca>
References: <20200917150044.23159-1-ani@anisinha.ca>
Received-SPF: none client-ip=2607:f8b0:4864:20::1041;
 envelope-from=ani@anisinha.ca; helo=mail-pj1-x1041.google.com
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, jusual@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>, Ani Sinha <ani@anisinha.ca>,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This change adds a new unit test for the global flag
'acpi-pci-hotplug-with-bridge-support' which is available for cold plugged pci
bridges in i440fx. The flag can be used to turn off ACPI based hotplug support
on all pci bridges.

Signed-off-by: Ani Sinha <ani@anisinha.ca>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---
 tests/qtest/bios-tables-test.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index ad157ef05d..c970556795 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -754,6 +754,20 @@ static void test_acpi_piix4_no_root_hotplug(void)
     free_test_data(&data);
 }
 
+static void test_acpi_piix4_no_bridge_hotplug(void)
+{
+    test_data data;
+
+    memset(&data, 0, sizeof(data));
+    data.machine = MACHINE_PC;
+    data.variant = ".hpbridge";
+    data.required_struct_types = base_required_struct_types;
+    data.required_struct_types_len = ARRAY_SIZE(base_required_struct_types);
+    test_acpi_one("-global PIIX4_PM.acpi-pci-hotplug-with-bridge-support=off "
+                  "-device pci-bridge,chassis_nr=1", &data);
+    free_test_data(&data);
+}
+
 static void test_acpi_q35_tcg(void)
 {
     test_data data;
@@ -1160,6 +1174,8 @@ int main(int argc, char *argv[])
         qtest_add_func("acpi/piix4/bridge", test_acpi_piix4_tcg_bridge);
         qtest_add_func("acpi/piix4/pci-hotplug/no_root_hotplug",
                        test_acpi_piix4_no_root_hotplug);
+        qtest_add_func("acpi/piix4/pci-hotplug/no_bridge_hotplug",
+                       test_acpi_piix4_no_bridge_hotplug);
         qtest_add_func("acpi/q35", test_acpi_q35_tcg);
         qtest_add_func("acpi/q35/bridge", test_acpi_q35_tcg_bridge);
         qtest_add_func("acpi/q35/mmio64", test_acpi_q35_tcg_mmio64);
-- 
2.17.1


