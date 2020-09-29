Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AD8DC4346E
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 07:50:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 234212076B
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 07:50:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U/82sJrT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 234212076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNAPH-0006qE-Ra
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 03:50:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58040)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kN9yO-0004fE-Ad
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 03:22:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60045)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kN9yM-0001pD-EV
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 03:22:52 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601364169;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2IqcTE+0obHGpTpMRr2vOhbKuY4H0mgUIz3ykNLSxsk=;
 b=U/82sJrTemIWP7Yz67KyUGY+i8ZfUpzELuMazyYApzZ8VCLjH1rxnKNBuPtydF20FPYQTP
 FHDL0b0uVX2aeraUthmijPY4A3yc5vLNsp5fyPCsiHk8/mweeTWXDCDzdGunYQgo/q1Ovt
 1Y4eU6Kg0AFUsbgrOMga6vf9r9WzOME=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-121-A3Eq5-7zOkaT3HwRYyhLQg-1; Tue, 29 Sep 2020 03:22:45 -0400
X-MC-Unique: A3Eq5-7zOkaT3HwRYyhLQg-1
Received: by mail-wm1-f70.google.com with SMTP id b14so1358283wmj.3
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 00:22:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=2IqcTE+0obHGpTpMRr2vOhbKuY4H0mgUIz3ykNLSxsk=;
 b=jj7eWKLGRtXwETShrhulJPFdkZrURI+cDUWipWIPgofSyN4lGXQYQMsQHdyuLXUvVC
 Alo2UXo4RO73AmDKhjIo89MNXB0JsZ8mVx3Hjuhl3G6ftO3FnuyPIR+BhSEudSFSOAzW
 KfeCsYJJumYf08DzsPc32WANP0DizfOnBtvd5pCYu5Ll/p1owREU9+l656BsI3O6KBuk
 ih1M9htjLsSppHNtRBdYEIdG0XLYpcjb1Og18n5LKvd9HLTkH0/BAFwjD2SImRwM0fDM
 3GXZKKD05SSU3vmTmN8fHLfbYUCcQUSewpK0D8y/Uf0PWL4KGgYFoIpwi0a9beatyPB5
 781Q==
X-Gm-Message-State: AOAM531LGtAQcp2BJO6E42PozMs8lNWB/TIDySCjoCn7BXJdnMSpFLxs
 YL8MCTKCDTokJKs8R8ifl8vdXDc3ELCaL9eSFH3JrEGmtWnZicRoIwkppEDxepBOuhdalF1lCJz
 3oB11aJN1UFdhJHk=
X-Received: by 2002:adf:dcd1:: with SMTP id x17mr2718672wrm.150.1601364164044; 
 Tue, 29 Sep 2020 00:22:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyzhqXm76RvhDF6+ugcBM6XtT27lZ2t7M+fjeuxqRYDwtK13jfcdNv1nwk51eQcpU5qUqsr4g==
X-Received: by 2002:adf:dcd1:: with SMTP id x17mr2718655wrm.150.1601364163884; 
 Tue, 29 Sep 2020 00:22:43 -0700 (PDT)
Received: from redhat.com (bzq-79-179-71-128.red.bezeqint.net. [79.179.71.128])
 by smtp.gmail.com with ESMTPSA id c16sm4938230wrx.31.2020.09.29.00.22.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2020 00:22:43 -0700 (PDT)
Date: Tue, 29 Sep 2020 03:22:41 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v4 41/48] tests/acpi: unit test for
 'acpi-pci-hotplug-with-bridge-support' bridge flag
Message-ID: <20200929071948.281157-42-mst@redhat.com>
References: <20200929071948.281157-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200929071948.281157-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/29 02:22:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <ani@anisinha.ca>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Ani Sinha <ani@anisinha.ca>

This change adds a new unit test for the global flag
'acpi-pci-hotplug-with-bridge-support' which is available for cold plugged pci
bridges in i440fx. The flag can be used to turn off ACPI based hotplug support
on all pci bridges.

Signed-off-by: Ani Sinha <ani@anisinha.ca>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20200918084111.15339-8-ani@anisinha.ca>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/bios-tables-test.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index bc932d0b9f..3c09b844f9 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -756,6 +756,20 @@ static void test_acpi_piix4_no_root_hotplug(void)
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
@@ -1176,6 +1190,8 @@ int main(int argc, char *argv[])
         qtest_add_func("acpi/piix4/bridge", test_acpi_piix4_tcg_bridge);
         qtest_add_func("acpi/piix4/pci-hotplug/no_root_hotplug",
                        test_acpi_piix4_no_root_hotplug);
+        qtest_add_func("acpi/piix4/pci-hotplug/no_bridge_hotplug",
+                       test_acpi_piix4_no_bridge_hotplug);
         qtest_add_func("acpi/q35", test_acpi_q35_tcg);
         qtest_add_func("acpi/q35/bridge", test_acpi_q35_tcg_bridge);
         qtest_add_func("acpi/q35/mmio64", test_acpi_q35_tcg_mmio64);
-- 
MST


