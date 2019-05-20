Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 612F9C04AAC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 23:30:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3541E20863
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 23:30:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3541E20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43593 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSrjX-0006mQ-84
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 19:30:19 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44976)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hSrQm-0007FF-LV
	for qemu-devel@nongnu.org; Mon, 20 May 2019 19:10:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hSrQl-00084g-O0
	for qemu-devel@nongnu.org; Mon, 20 May 2019 19:10:56 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:43580)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hSrQl-00084K-Jv
	for qemu-devel@nongnu.org; Mon, 20 May 2019 19:10:55 -0400
Received: by mail-qt1-f196.google.com with SMTP id i26so18313607qtr.10
	for <qemu-devel@nongnu.org>; Mon, 20 May 2019 16:10:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:content-transfer-encoding
	:in-reply-to;
	bh=K1SuAxXuNDDL/u5ZoPcF8ZaVNsHULTvHgBcd3QhfKbY=;
	b=daS2+DHXLfPAslyrhINXL1s78O+dMAnN95Y15gZPlbsClfmfZc6wjrbtl1MC3c1GBE
	IEigMnuN6qQYAd0VgXdoRLSWLiQd/95ssxy1U0LhCvRc9I/IxYHZ5HysjL9dlrPjxN2c
	D69Pjft2xLvk97oDssMWEf3qcmQGHlPHjxZ4mpy/cZuNCiIQRaO962ZBS3Cm00CSj0yk
	o36QBeVrSX2OJiOeQR4+r1cm8frVjrI5R/5T1Sbt9T1TQvVrzmmXpyQccWH127BX0FVW
	+W7DMFOlMLH9txnTk1DZvd1vhKP8sNFouXV0zCNKYiStcV6KfDGs4CkGTOiMKVcrkkJF
	HzfQ==
X-Gm-Message-State: APjAAAW5Eb4j7Vw8+oUFicUeLAJvgA3C1I8pZdFszyCRdhOBWEKnS1Ak
	jO3q9YBsC6QzJ3suIusuatakQt0EVhk=
X-Google-Smtp-Source: APXvYqztn4DxiLeJXBBy+IA1jUsnK2CWqK98GXY4vqH6F30HOZyqdseqrrTRexDbU605lpYIqDeskQ==
X-Received: by 2002:ac8:325c:: with SMTP id y28mr66065041qta.48.1558393854754; 
	Mon, 20 May 2019 16:10:54 -0700 (PDT)
Received: from redhat.com (pool-173-76-105-71.bstnma.fios.verizon.net.
	[173.76.105.71])
	by smtp.gmail.com with ESMTPSA id o6sm8847509qtc.47.2019.05.20.16.10.53
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Mon, 20 May 2019 16:10:54 -0700 (PDT)
Date: Mon, 20 May 2019 19:10:52 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <20190402161900.7374-4-armbru@redhat.com>
References: <20190520231008.20140-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190520231008.20140-1-mst@redhat.com>
X-Mailer: git-send-email 2.17.1.1206.gb667731e2e.dirty
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.160.196
Subject: [Qemu-devel] [PULL v2 13/36] acpi/pcihp: Add a few more trace
 points related to unplug
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	Markus Armbruster <armbru@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190520231052.Q2BPllBGtFi3PToPu0sQWMtnitSQgluHX4jU7TzdxMA@z>

From: Markus Armbruster <armbru@redhat.com>

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20190402161900.7374-4-armbru@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/acpi/pcihp.c      | 7 +++++++
 hw/acpi/trace-events | 3 +++
 2 files changed, 10 insertions(+)

diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
index 7729c5338b..613406d09b 100644
--- a/hw/acpi/pcihp.c
+++ b/hw/acpi/pcihp.c
@@ -152,6 +152,8 @@ static void acpi_pcihp_eject_slot(AcpiPciHpState *s, unsigned bsel, unsigned slo
     int slot = ctz32(slots);
     PCIBus *bus = acpi_pcihp_find_hotplug_bus(s, bsel);
 
+    trace_acpi_pci_eject_slot(bsel, slot);
+
     if (!bus) {
         return;
     }
@@ -263,6 +265,8 @@ void acpi_pcihp_device_plug_cb(HotplugHandler *hotplug_dev, AcpiPciHpState *s,
 void acpi_pcihp_device_unplug_cb(HotplugHandler *hotplug_dev, AcpiPciHpState *s,
                                  DeviceState *dev, Error **errp)
 {
+    trace_acpi_pci_unplug(PCI_SLOT(PCI_DEVICE(dev)->devfn),
+                          acpi_pcihp_get_bsel(pci_get_bus(PCI_DEVICE(dev))));
     object_property_set_bool(OBJECT(dev), false, "realized", NULL);
 }
 
@@ -273,6 +277,9 @@ void acpi_pcihp_device_unplug_request_cb(HotplugHandler *hotplug_dev,
     PCIDevice *pdev = PCI_DEVICE(dev);
     int slot = PCI_SLOT(pdev->devfn);
     int bsel = acpi_pcihp_get_bsel(pci_get_bus(pdev));
+
+    trace_acpi_pci_unplug_request(bsel, slot);
+
     if (bsel < 0) {
         error_setg(errp, "Unsupported bus. Bus doesn't have property '"
                    ACPI_PCIHP_PROP_BSEL "' set");
diff --git a/hw/acpi/trace-events b/hw/acpi/trace-events
index 98a56baa6f..96b8273297 100644
--- a/hw/acpi/trace-events
+++ b/hw/acpi/trace-events
@@ -32,6 +32,9 @@ cpuhp_acpi_write_ost_ev(uint32_t slot, uint32_t ev) "idx[0x%"PRIx32"] OST EVENT:
 cpuhp_acpi_write_ost_status(uint32_t slot, uint32_t st) "idx[0x%"PRIx32"] OST STATUS: 0x%"PRIx32
 
 # pcihp.c
+acpi_pci_eject_slot(unsigned bsel, unsigned slot) "bsel: %u slot: %u"
+acpi_pci_unplug(int bsel, int slot) "bsel: %d slot: %d"
+acpi_pci_unplug_request(int bsel, int slot) "bsel: %d slot: %d"
 acpi_pci_up_read(uint32_t val) "%" PRIu32
 acpi_pci_down_read(uint32_t val) "%" PRIu32
 acpi_pci_features_read(uint32_t val) "%" PRIu32
-- 
MST


