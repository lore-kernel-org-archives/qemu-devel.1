Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0129EC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 13:23:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9C1B2070A
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 13:23:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XHJaghFr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9C1B2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbOh3-00080t-Th
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 09:23:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47610)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jbOdz-0001fr-Vk
 for qemu-devel@nongnu.org; Wed, 20 May 2020 09:20:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22885
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jbOdz-0000AV-5Z
 for qemu-devel@nongnu.org; Wed, 20 May 2020 09:20:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589980822;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=MzZODsBz007pRLcd54leFfF+Mh0RbKq9+V9Rg9SxbkY=;
 b=XHJaghFrTxSsiA37jwlhbp6Cl0xQDQCGQ94zZmGaDjc4F6a7j1mwvrqqV4ixaC92eXKYIF
 QpLDZCoCKGCFoKfFbUK9S/0owbsQ0SsW07gKAb0B27q2AhPW1aADTEcCa2a4K9NwipeuSB
 FP8ZSOGt2qRK1ojtLZmbavVlSfoEzdE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-54-0xj23SLuOHSRLVNCn_danQ-1; Wed, 20 May 2020 09:20:18 -0400
X-MC-Unique: 0xj23SLuOHSRLVNCn_danQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 872DA8015D1;
 Wed, 20 May 2020 13:20:17 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-50.ams2.redhat.com
 [10.36.113.50])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E5BDF6AD0F;
 Wed, 20 May 2020 13:20:09 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id A865E9DAF; Wed, 20 May 2020 15:20:03 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 03/22] [testing] seabios: update config & build rules
Date: Wed, 20 May 2020 15:19:44 +0200
Message-Id: <20200520132003.9492-4-kraxel@redhat.com>
In-Reply-To: <20200520132003.9492-1-kraxel@redhat.com>
References: <20200520132003.9492-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/19 22:48:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>,
 qemu-arm@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 roms/Makefile               |  5 ++++-
 roms/config.seabios-128k    |  3 +++
 roms/config.seabios-microvm | 26 ++++++++++++++++++++++++++
 3 files changed, 33 insertions(+), 1 deletion(-)
 create mode 100644 roms/config.seabios-microvm

diff --git a/roms/Makefile b/roms/Makefile
index d6d4948bfc31..f7cdad027374 100644
--- a/roms/Makefile
+++ b/roms/Makefile
@@ -72,9 +72,12 @@ default help:
 	@echo "  clean              -- delete the files generated by the previous" \
 	                              "build targets"
 
-bios: build-seabios-config-seabios-128k build-seabios-config-seabios-256k
+bios: build-seabios-config-seabios-128k \
+		build-seabios-config-seabios-256k \
+		build-seabios-config-seabios-microvm
 	cp seabios/builds/seabios-128k/bios.bin ../pc-bios/bios.bin
 	cp seabios/builds/seabios-256k/bios.bin ../pc-bios/bios-256k.bin
+	cp seabios/builds/seabios-microvm/bios.bin ../pc-bios/bios-microvm.bin
 
 vgabios seavgabios: $(patsubst %,seavgabios-%,$(vgabios_variants))
 
diff --git a/roms/config.seabios-128k b/roms/config.seabios-128k
index c43912bf9de4..d18c802c46e9 100644
--- a/roms/config.seabios-128k
+++ b/roms/config.seabios-128k
@@ -11,8 +11,11 @@ CONFIG_USB_UAS=n
 CONFIG_SDCARD=n
 CONFIG_TCGBIOS=n
 CONFIG_MPT_SCSI=n
+CONFIG_ESP_SCSI=n
+CONFIG_MEGASAS=n
 CONFIG_PVSCSI=n
 CONFIG_NVME=n
 CONFIG_USE_SMM=n
 CONFIG_VGAHOOKS=n
 CONFIG_HOST_BIOS_GEOMETRY=n
+CONFIG_ACPI_PARSE=n
diff --git a/roms/config.seabios-microvm b/roms/config.seabios-microvm
new file mode 100644
index 000000000000..a253e2edc6ec
--- /dev/null
+++ b/roms/config.seabios-microvm
@@ -0,0 +1,26 @@
+CONFIG_QEMU=y
+CONFIG_QEMU_HARDWARE=y
+CONFIG_PERMIT_UNALIGNED_PCIROM=y
+CONFIG_ROM_SIZE=128
+CONFIG_XEN=n
+CONFIG_BOOTSPLASH=n
+CONFIG_ATA=n
+CONFIG_AHCI=n
+CONFIG_SDCARD=n
+CONFIG_PVSCSI=n
+CONFIG_ESP_SCSI=n
+CONFIG_LSI_SCSI=n
+CONFIG_MEGASAS=n
+CONFIG_MPT_SCSI=n
+CONFIG_FLOPPY=n
+CONFIG_FLASH_FLOPPY=n
+CONFIG_NVME=n
+CONFIG_PS2PORT=n
+CONFIG_USB=n
+CONFIG_LPT=n
+CONFIG_RTC_TIMER=n
+CONFIG_USE_SMM=n
+CONFIG_PMTIMER=n
+CONFIG_TCGBIOS=n
+CONFIG_HARDWARE_IRQ=n
+CONFIG_ACPI_PARSE=y
-- 
2.18.4


