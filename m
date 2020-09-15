Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2F2CC43461
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 15:39:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24812206B2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 15:39:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="LpSbo8AW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24812206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kID3C-0004Vv-Rl
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 11:39:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48632)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kID2O-0003lm-JN
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 11:38:32 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:34938)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kID2M-0004VC-Cg
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 11:38:32 -0400
Received: by mail-pj1-x1044.google.com with SMTP id jw11so1903724pjb.0
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2020 08:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id;
 bh=gXiOvMvsO2MIYCeiPpobDfK2KkdtpOURDUyBDd8MVyk=;
 b=LpSbo8AW3YY/IwRpDN167N/WFndZAotjBx6ib+rBT/XWI3RkqiJvg/xBol4BYdwVCH
 a3WfWKFaRtgG+c2W2GL9ykHbMXoYmXa6A/eaRINpqBfuUBDViAv0unxZUNQMUeZJH5Bc
 VIbRGaExnUxEfQx5E4jCPI6mqngxpEldNP2/+4d+Au46mbHY1dxAXI20fpCEXDrvSb4f
 x8r134Yo7rzZwIlcOQKTV07talk4QcqMTwQk2sELz/1qj8qpkhVRE4UxzH/K1pEUN5u9
 NyM2G1fgzvCHpQLpi90sWXtDYmLhA60PZjMHHvHd/a8lzc34xS6XOxohS3m+OKzNb/sC
 183g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=gXiOvMvsO2MIYCeiPpobDfK2KkdtpOURDUyBDd8MVyk=;
 b=cKKEowFidkehksaDKg9QtFAVrnwbZom4JZspo6R/x6xHtNiwOdMmyKxGRcCk0y++CR
 W6gTKVIVRjXYINAsuPDDGigE+nttIHPM19tez9W+odZOwlzWFVUKfj1ajBwLqwkCm4b9
 JPaW3duwvgPT+8cYNyWHtr3MgoRinqwD7DwcUJ5vRch0ytdnBh/dv9L97PPvXL7xho1G
 Qod6yte/2SpWOL3egvUII786jW9Vqvzu2f3s8ElRBPEHiWMQl7/M2opb0HkWwFeGqgKD
 zAoCH9aB9/mGjq14PPPC21dcJHaReyVUF1aN62znzfUnI7HQpw0GW0Io3dXZIdhUmhpb
 urrw==
X-Gm-Message-State: AOAM5327B9TPaw8lOck77WVr16Rm70o7SoOGz4omDMoIspbNS7QkEMeu
 Bj/5o5h2B7HKGsRtp2NGHiJq0/c98tMJOPPg
X-Google-Smtp-Source: ABdhPJwFEBkBAxcKk+wYZv/MPdcvczO5CfxiPvSm9SC4yUMRr+gRPHO6RQDrlZOzdm4JCXsAQ/51og==
X-Received: by 2002:a17:90a:ee16:: with SMTP id
 e22mr4194600pjy.81.1600184308394; 
 Tue, 15 Sep 2020 08:38:28 -0700 (PDT)
Received: from localhost.localdomain ([115.96.130.76])
 by smtp.googlemail.com with ESMTPSA id 194sm13283547pfy.44.2020.09.15.08.38.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2020 08:38:27 -0700 (PDT)
From: Ani Sinha <ani@anisinha.ca>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 0/9] i440fx/acpi: addition of feature and bug fixes.
Date: Tue, 15 Sep 2020 21:08:09 +0530
Message-Id: <20200915153818.13020-1-ani@anisinha.ca>
X-Mailer: git-send-email 2.17.1
Received-SPF: none client-ip=2607:f8b0:4864:20::1044;
 envelope-from=ani@anisinha.ca; helo=mail-pj1-x1044.google.com
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
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Ani Sinha <ani@anisinha.ca>,
 Igor Mammedov <imammedo@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In v3, I fixed another bug with patch #9. Now, with hotplug disabled on both
root bus and pci bridges, we  get a clean DSDT table as can be seen here:

https://pastebin.ubuntu.com/p/JSZhfyBFD7/

The AML corresponding to the root bus is:

   Scope (\_SB)
    {
        Scope (PCI0)
        {
            Device (S00)
            {
                Name (_ADR, Zero)  // _ADR: Address
            }

            Device (S10)
            {
                Name (_ADR, 0x00020000)  // _ADR: Address
                Method (_S1D, 0, NotSerialized)  // _S1D: S1 Device State
                {
                    Return (Zero)
                }

                Method (_S2D, 0, NotSerialized)  // _S2D: S2 Device State
                {
                    Return (Zero)
                }

                Method (_S3D, 0, NotSerialized)  // _S3D: S3 Device State
                {
                    Return (Zero)
                }
            }

            Device (S18)
            {
                Name (_ADR, 0x00030000)  // _ADR: Address
            }
        }
    }


The AML was generated by making the following change to the test:

diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index 7632cfe1be..39b5c213ef 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -750,7 +750,7 @@ static void test_acpi_piix4_root_hotplug(void)
     data.required_struct_types = base_required_struct_types;
     data.required_struct_types_len = ARRAY_SIZE(base_required_struct_types);
     test_acpi_one("-global PIIX4_PM.acpi-root-pci-hotplug=off "
-                  "-device pci-bridge,chassis_nr=1", &data);
+                  "-device pci-bridge,chassis_nr=1 -global PIIX4_PM.acpi-pci-hotplug-with-bridge-support=off", &data);
     free_test_data(&data);
 }


and then running the test using:
$ make tests/qtest/bios-tables-test && \
  V=1 QTEST_QEMU_BINARY=x86_64-softmmu/qemu-system-x86_64 QTEST_QEMU_IMG=qemu-img tests/qtest/bios-tables-test


Ani Sinha (9):
  tests/acpi: document addition of table DSDT.roothp for unit testing
    root pci hotplug on/off
  tests/acpi: add a new unit test to test hotplug off/on feature on the
    root pci bus
  tests/acpi: add a new ACPI table in order to test root pci hotplug
    on/off
  Fix a gap where acpi_pcihp_find_hotplug_bus() returns a
    non-hotpluggable bus
  i440fx/acpi: do not add hotplug related amls for cold plugged bridges
  tests/acpi: list added acpi table binary file for pci bridge hotplug
    test
  tests/acpi: unit test for 'acpi-pci-hotplug-with-bridge-support'
    bridge flag
  tests/acpi: add newly added acpi DSDT table blob for pci bridge
    hotplug flag
  piix4: don't reserve hw resources when hotplug is off globally

 hw/acpi/pcihp.c                   |  15 ++++++++++++
 hw/acpi/piix4.c                   |   6 +++--
 hw/i386/acpi-build.c              |  37 +++++++++++++++++++-----------
 tests/data/acpi/pc/DSDT.hpbridge  | Bin 0 -> 4895 bytes
 tests/data/acpi/pc/DSDT.roothp    | Bin 0 -> 5130 bytes
 tests/data/acpi/q35/DSDT          | Bin 7678 -> 7670 bytes
 tests/data/acpi/q35/DSDT.acpihmat | Bin 9002 -> 8994 bytes
 tests/data/acpi/q35/DSDT.bridge   | Bin 7695 -> 7688 bytes
 tests/data/acpi/q35/DSDT.cphp     | Bin 8141 -> 8133 bytes
 tests/data/acpi/q35/DSDT.dimmpxm  | Bin 9331 -> 9323 bytes
 tests/data/acpi/q35/DSDT.ipmibt   | Bin 7753 -> 7745 bytes
 tests/data/acpi/q35/DSDT.memhp    | Bin 9037 -> 9029 bytes
 tests/data/acpi/q35/DSDT.mmio64   | Bin 8808 -> 8801 bytes
 tests/data/acpi/q35/DSDT.numamem  | Bin 7684 -> 7676 bytes
 tests/data/acpi/q35/DSDT.tis      | Bin 8283 -> 8276 bytes
 tests/qtest/bios-tables-test.c    |  30 ++++++++++++++++++++++++
 16 files changed, 73 insertions(+), 15 deletions(-)
 create mode 100644 tests/data/acpi/pc/DSDT.hpbridge
 create mode 100644 tests/data/acpi/pc/DSDT.roothp

-- 
2.17.1


