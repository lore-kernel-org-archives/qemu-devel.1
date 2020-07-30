Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B980DC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 16:03:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 848AF206F5
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 16:03:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dGsj6BxS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 848AF206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1B1s-00009E-Qi
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 12:03:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58614)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1k1AxK-0002sD-Fj
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 11:58:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53645
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1k1AxF-0005QY-L5
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 11:58:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596124728;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=t9vJ8om9B5hkPXUycSKjtBZ/Wy7eZdvCHEAUsm4nZrw=;
 b=dGsj6BxSvle6Qj2Pum+YK9rfpA89cRDpLRABWlq4iky2sizX6lcpK4BXs74jrxkaeoHJd6
 FqESWKL87dTMw3XHuiPGLG7pbdOV2B9f2Zas/jQFCB22m2ypMPZUEA79Ds171bWjhVoAVk
 o5y8uLlH2rVtn82xlz53ZFphk4ahslE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-507-Dg4gw8a8NW-oaJVHeshX7g-1; Thu, 30 Jul 2020 11:58:46 -0400
X-MC-Unique: Dg4gw8a8NW-oaJVHeshX7g-1
Received: by mail-wm1-f71.google.com with SMTP id z1so544345wmf.9
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2020 08:58:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=t9vJ8om9B5hkPXUycSKjtBZ/Wy7eZdvCHEAUsm4nZrw=;
 b=eUeUcwhiT61j9kJYeMoHOVUytvfHxb4PqlifJsu6JyZxDa5GqtbvX/kk2qklSm91P7
 CdkqizYyIWv42xfVrlezFayVE0XkqFCiqy1o9GBV3Czb7lCXQQTNvbBxPxTgCgZzYd9C
 AQSprsWKfWCI3kmGQ5bkSx+bg1zXbbvWF7NPJAcIXjtHfLh+93foFodCkP25Jym5PtwK
 PN7iorG3ZD5SJ6nNkElxJfZSVeDri0qbY4T/dmywhcq51WRMi8me7Lh3QbIJYIm5l3xh
 22F3l/YNWUWD5U0whbThiVifZ1z2ukVMhIO/RHXVFRE2BYJt+6us3NtmRtudKFcSR972
 ofgA==
X-Gm-Message-State: AOAM530SBRaSlA2Nrt31/UGOBEzSqL96WkA8xSMJcT5JhRihuHG1wX5K
 xhtwm4DxWQ+gWhufUrahrLGMnynvUK+czXGa/RrZdZ6fa2DELTs0vEbtTvIKIlT60Uj/wY76TaA
 7Qm9eURmNVzqlMsI=
X-Received: by 2002:adf:8445:: with SMTP id 63mr31327049wrf.375.1596124724765; 
 Thu, 30 Jul 2020 08:58:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzRss6Ca9nrb8UdgktrSSQYouHKJJyWPnFLa3HSGKYMKx2DYRNnrpBhWF7E1lg67BrsCR0KKw==
X-Received: by 2002:adf:8445:: with SMTP id 63mr31327032wrf.375.1596124724566; 
 Thu, 30 Jul 2020 08:58:44 -0700 (PDT)
Received: from redhat.com (bzq-79-179-105-63.red.bezeqint.net. [79.179.105.63])
 by smtp.gmail.com with ESMTPSA id s14sm9447543wrv.24.2020.07.30.08.58.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2020 08:58:43 -0700 (PDT)
Date: Thu, 30 Jul 2020 11:58:41 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] arm/acpi: fix an out of spec _UID for PCI root
Message-ID: <20200730155755.188845-2-mst@redhat.com>
References: <20200730155755.188845-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200730155755.188845-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/30 03:59:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, vit9696 <vit9696@protonmail.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On ARM/virt machine type QEMU currently reports an incorrect _UID in
ACPI.

The particular node in question is the primary PciRoot (PCI0 in ACPI),
which gets assigned PCI0 in ACPI UID and 0 in the
DevicePath. This is due to the _UID assigned to it by build_dsdt in
hw/arm/virt-acpi-build.c Which does not correspond to the primary PCI
identifier given by pcibus_num in hw/pci/pci.c

In UEFI v2.8, section "10.4.2 Rules with ACPI _HID and _UID" ends with
the paragraph,

    Root PCI bridges will use the plug and play ID of PNP0A03, This will
    be stored in the ACPI Device Path _HID field, or in the Expanded
    ACPI Device Path _CID field to match the ACPI name space. The _UID
    in the ACPI Device Path structure must match the _UID in the ACPI
    name space.

(See especially the last sentence.)

A similar bug has been reported on i386, on that architecture it has
been reported to confuse at least macOS which uses ACPI UIDs to build
the DevicePath for NVRAM boot options, while OVMF firmware gets them via
an internal channel through QEMU.  When UEFI firmware and ACPI have
different values, this makes the underlying operating system unable to
report its boot option.

Reported-by: vit9696 <vit9696@protonmail.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

Peter can you either ack or merge this one pls?

 hw/arm/virt-acpi-build.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 91f0df7b13..0a482ff6f7 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -170,7 +170,7 @@ static void acpi_dsdt_add_pci(Aml *scope, const MemMapEntry *memmap,
     aml_append(dev, aml_name_decl("_CID", aml_string("PNP0A03")));
     aml_append(dev, aml_name_decl("_SEG", aml_int(0)));
     aml_append(dev, aml_name_decl("_BBN", aml_int(0)));
-    aml_append(dev, aml_name_decl("_UID", aml_string("PCI0")));
+    aml_append(dev, aml_name_decl("_UID", aml_int(0)));
     aml_append(dev, aml_name_decl("_STR", aml_unicode("PCIe 0 Device")));
     aml_append(dev, aml_name_decl("_CCA", aml_int(1)));
 
-- 
MST


