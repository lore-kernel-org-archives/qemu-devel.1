Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3311C4346E
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 07:40:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D42E206DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 07:40:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E+d4WIV1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D42E206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNAFp-0004PY-Cf
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 03:40:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57686)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kN9xo-0003qU-BO
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 03:22:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39489)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kN9xm-0001hx-A8
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 03:22:15 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601364131;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wRDcvukq68plAW9qSOLeFsCLVUWLBF3/01C54Ke/hXI=;
 b=E+d4WIV19pUAHwcdGnCwWl+Gcj3CNIY+ZKZmP4EqMa+o7q7fJGo9Y1wxRn1eHptKle0xPP
 E1lgH1c5iZuNbWMaCUWgqnC8ynNckphQh2F3OKpmSk5lQgQba2pbPZDg/VXEaIgwiQscUb
 Ue+wWjjxBXDwfGxi+Nr8t3S4HBept9k=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-105-XpaYprbdMG-PV9Hv1LDQQg-1; Tue, 29 Sep 2020 03:22:09 -0400
X-MC-Unique: XpaYprbdMG-PV9Hv1LDQQg-1
Received: by mail-wm1-f69.google.com with SMTP id y18so1355353wma.4
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 00:22:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=wRDcvukq68plAW9qSOLeFsCLVUWLBF3/01C54Ke/hXI=;
 b=mSo1EGIOdqJS1Z4WgZ1zL9I0khgpd9zfiAKwBaiCw3+7SfKpI2wO1WLAXgDgBbvct1
 zHxeBVcBG/PZAQKHL2xbNgpSpgaRIcUxumMDmvopZcns08uZGMyMCAhbC5R0gnCCrmi6
 Jql2to2qlD24Jka5RB7dMHZbVVqxNLErMw6UwbaRVe+5CemxBA/HveoN1b90Q+K42eNj
 FLFEN7w1lLda+Z2GV7iDlDD5GFe4UieLHmAINqFwq66Q+jJnO9u7SOVjG7uxYedL/Y31
 xcmNbmSTPqmPVTEOqPyyUkdjnLdnzJbXw+1PltX118nrXTAjCQhzrcYiL77sJwxF3vIY
 QIJA==
X-Gm-Message-State: AOAM531TcB6/fbxEGzfvbYqwE6qAp4E3+Moy8ZTmbCb7NSokQbL8s6Zo
 I2egCqaZ91TRdpOC96ZatUJnoAY/OaChrvncoPuAmdGG9U4u1WoEgC3AEybOJrVu3t0yK2udKuA
 7eearwiV7eOd69Vw=
X-Received: by 2002:a1c:7f8b:: with SMTP id a133mr3120960wmd.155.1601364127669; 
 Tue, 29 Sep 2020 00:22:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyYn6LeHtMiBsMSFTKoFEIIK2S/8wHprmvy+6N3uIYoUSoQlE3gK/6+3qJjcR6i2tbFG526uQ==
X-Received: by 2002:a1c:7f8b:: with SMTP id a133mr3120947wmd.155.1601364127506; 
 Tue, 29 Sep 2020 00:22:07 -0700 (PDT)
Received: from redhat.com (bzq-79-179-71-128.red.bezeqint.net. [79.179.71.128])
 by smtp.gmail.com with ESMTPSA id h8sm4382128wrw.68.2020.09.29.00.22.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2020 00:22:06 -0700 (PDT)
Date: Tue, 29 Sep 2020 03:22:05 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v4 27/48] x86: acpi: introduce AcpiPmInfo::smi_on_cpuhp
Message-ID: <20200929071948.281157-28-mst@redhat.com>
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Igor Mammedov <imammedo@redhat.com>

Translate the "CPU hotplug with SMI" feature bit, from the property
added in the last patch, to a dedicated boolean in AcpiPmInfo.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Laszlo Ersek <lersek@redhat.com>
Tested-by: Laszlo Ersek <lersek@redhat.com>
Message-Id: <20200923094650.1301166-8-imammedo@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/acpi-build.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 0e0535d2e3..b408d62560 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -95,6 +95,7 @@ typedef struct AcpiPmInfo {
     bool s3_disabled;
     bool s4_disabled;
     bool pcihp_bridge_en;
+    bool smi_on_cpuhp;
     uint8_t s4_val;
     AcpiFadtData fadt;
     uint16_t cpu_hp_io_base;
@@ -194,6 +195,7 @@ static void acpi_get_pm_info(MachineState *machine, AcpiPmInfo *pm)
     pm->cpu_hp_io_base = 0;
     pm->pcihp_io_base = 0;
     pm->pcihp_io_len = 0;
+    pm->smi_on_cpuhp = false;
 
     assert(obj);
     init_common_fadt_data(machine, obj, &pm->fadt);
@@ -207,12 +209,16 @@ static void acpi_get_pm_info(MachineState *machine, AcpiPmInfo *pm)
             object_property_get_uint(obj, ACPI_PCIHP_IO_LEN_PROP, NULL);
     }
     if (lpc) {
+        uint64_t smi_features = object_property_get_uint(lpc,
+            ICH9_LPC_SMI_NEGOTIATED_FEAT_PROP, NULL);
         struct AcpiGenericAddress r = { .space_id = AML_AS_SYSTEM_IO,
             .bit_width = 8, .address = ICH9_RST_CNT_IOPORT };
         pm->fadt.reset_reg = r;
         pm->fadt.reset_val = 0xf;
         pm->fadt.flags |= 1 << ACPI_FADT_F_RESET_REG_SUP;
         pm->cpu_hp_io_base = ICH9_CPU_HOTPLUG_IO_BASE;
+        pm->smi_on_cpuhp =
+            !!(smi_features & BIT_ULL(ICH9_LPC_SMI_F_CPU_HOTPLUG_BIT));
     }
 
     /* The above need not be conditional on machine type because the reset port
-- 
MST


