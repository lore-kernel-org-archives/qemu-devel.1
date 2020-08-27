Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C52FC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 13:43:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D749B207CD
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 13:43:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LGkRak9+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D749B207CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBIBI-00067I-5H
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 09:43:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48464)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kBI8w-0001Im-2z
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 09:40:42 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36446
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kBI8s-0006KA-M1
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 09:40:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598535637;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hb3d5Gp+QjFQPJjKtY1sbRQvW/6sObSlypIuoM9UNYY=;
 b=LGkRak9+qjDl1gNtqq2W1IphVr+C9jwWSM4/55BbppJXakLvVcUUtzGS16+baSfrq15GQ3
 zcU4eyEj5S1av7uPlw5lnFRPInxJMGFDksGggZpGlq3SkaF1M82u8YKMcJTmox8SWBhyUp
 897RXREW3813qH3//Eaq3Fvcf9BZELM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-79-mDX-HXqmON-bLsPExGNwDA-1; Thu, 27 Aug 2020 09:40:35 -0400
X-MC-Unique: mDX-HXqmON-bLsPExGNwDA-1
Received: by mail-wm1-f70.google.com with SMTP id z25so2070213wmk.4
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2020 06:40:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=hb3d5Gp+QjFQPJjKtY1sbRQvW/6sObSlypIuoM9UNYY=;
 b=VWLqBbuOLOr6SdKNEfw4xDE9wsJYR7EEnOxFkGVV0/v4oTj3zFJ6psu9G/GYAZ2oAl
 jrWadEUbAe8FnUz9C2Zn2B6udlfrOHInQ3yl83dXTtKsL8xORFYJnB3xU/Zbujs0CTHj
 Lq/TbB4/0QXoK9Bwz35VRzfiLwezq7Ul2psg2u6Gu2Ww2p6+hW3heA5pR8sQQ4qt6du4
 JhkgyKh0PKFSbqg/+QXRS2j2pMDq8BjbrY9ukOf0aOSjyPMOQdHMMgYxW08cjg1+PRwd
 Fo5BrbzqcSQtms3LEMv+HeqoV76GK2mKan3za6TuL+MCzQg/DzOAp/oAIYUcRAwJlUag
 y7Ag==
X-Gm-Message-State: AOAM5325t8Ng/UBL+sZwOxfzaDTOCFRbOgLxKY2HVHJhyoxJcrEZ472A
 QBzB4iXfcA49wJeQDSjvrv5EXUbSiwYWi9tvhbkhZ6flBGWsii7mSObl1JcvRCZAO4g61J+h8iP
 xUYQqbYk7xpnBXhM=
X-Received: by 2002:a7b:c317:: with SMTP id k23mr11259961wmj.167.1598535633961; 
 Thu, 27 Aug 2020 06:40:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwISVGmljPd/L8BFrP++CrroqrMdGATA1VvrUrhEWIaGwNwxMBl3tjXNn3TfYOtKg52nXuMfg==
X-Received: by 2002:a7b:c317:: with SMTP id k23mr11259929wmj.167.1598535633335; 
 Thu, 27 Aug 2020 06:40:33 -0700 (PDT)
Received: from redhat.com (bzq-109-67-46-169.red.bezeqint.net. [109.67.46.169])
 by smtp.gmail.com with ESMTPSA id 92sm6638312wra.19.2020.08.27.06.40.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2020 06:40:32 -0700 (PDT)
Date: Thu, 27 Aug 2020 09:40:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 05/13] acpi: update expected DSDT files with _UID changes
Message-ID: <20200827133954.2118749-6-mst@redhat.com>
References: <20200827133954.2118749-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200827133954.2118749-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 02:56:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

_UID of the PCI root has been changed to 0.

Update expected files accordingly, and re-enable their testing.

Full diff of changed files disassembly:

diff -ru /tmp/old/tests/data/acpi/pc/DSDT.acpihmat.dsl /tmp/new/tests/data/acpi/pc/DSDT.acpihmat.dsl
--- /tmp/old/tests/data/acpi/pc/DSDT.acpihmat.dsl	2020-08-04 17:37:55.727798633 -0400
+++ /tmp/new/tests/data/acpi/pc/DSDT.acpihmat.dsl	2020-08-04 17:42:57.258859861 -0400
@@ -50,7 +50,7 @@
         {
             Name (_HID, EisaId ("PNP0A03") /* PCI Bus */)  // _HID: Hardware ID
             Name (_ADR, Zero)  // _ADR: Address
-            Name (_UID, One)  // _UID: Unique ID
+            Name (_UID, Zero)  // _UID: Unique ID
         }
     }

diff -ru /tmp/old/tests/data/acpi/pc/DSDT.bridge.dsl /tmp/new/tests/data/acpi/pc/DSDT.bridge.dsl
--- /tmp/old/tests/data/acpi/pc/DSDT.bridge.dsl	2020-08-04 17:37:55.737798601 -0400
+++ /tmp/new/tests/data/acpi/pc/DSDT.bridge.dsl	2020-08-04 17:42:57.262859849 -0400
@@ -50,7 +50,7 @@
         {
             Name (_HID, EisaId ("PNP0A03") /* PCI Bus */)  // _HID: Hardware ID
             Name (_ADR, Zero)  // _ADR: Address
-            Name (_UID, One)  // _UID: Unique ID
+            Name (_UID, Zero)  // _UID: Unique ID
         }
     }

diff -ru /tmp/old/tests/data/acpi/pc/DSDT.cphp.dsl /tmp/new/tests/data/acpi/pc/DSDT.cphp.dsl
--- /tmp/old/tests/data/acpi/pc/DSDT.cphp.dsl	2020-08-04 17:37:55.745798576 -0400
+++ /tmp/new/tests/data/acpi/pc/DSDT.cphp.dsl	2020-08-04 17:42:57.265859839 -0400
@@ -50,7 +50,7 @@
         {
             Name (_HID, EisaId ("PNP0A03") /* PCI Bus */)  // _HID: Hardware ID
             Name (_ADR, Zero)  // _ADR: Address
-            Name (_UID, One)  // _UID: Unique ID
+            Name (_UID, Zero)  // _UID: Unique ID
         }
     }

diff -ru /tmp/old/tests/data/acpi/pc/DSDT.dimmpxm.dsl /tmp/new/tests/data/acpi/pc/DSDT.dimmpxm.dsl
--- /tmp/old/tests/data/acpi/pc/DSDT.dimmpxm.dsl	2020-08-04 17:37:55.759798533 -0400
+++ /tmp/new/tests/data/acpi/pc/DSDT.dimmpxm.dsl	2020-08-04 17:42:57.268859830 -0400
@@ -52,7 +52,7 @@
         {
             Name (_HID, EisaId ("PNP0A03") /* PCI Bus */)  // _HID: Hardware ID
             Name (_ADR, Zero)  // _ADR: Address
-            Name (_UID, One)  // _UID: Unique ID
+            Name (_UID, Zero)  // _UID: Unique ID
         }
     }

diff -ru /tmp/old/tests/data/acpi/pc/DSDT.dsl /tmp/new/tests/data/acpi/pc/DSDT.dsl
--- /tmp/old/tests/data/acpi/pc/DSDT.dsl	2020-08-04 17:37:55.713798676 -0400
+++ /tmp/new/tests/data/acpi/pc/DSDT.dsl	2020-08-04 17:42:57.256859867 -0400
@@ -50,7 +50,7 @@
         {
             Name (_HID, EisaId ("PNP0A03") /* PCI Bus */)  // _HID: Hardware ID
             Name (_ADR, Zero)  // _ADR: Address
-            Name (_UID, One)  // _UID: Unique ID
+            Name (_UID, Zero)  // _UID: Unique ID
         }
     }

diff -ru /tmp/old/tests/data/acpi/pc/DSDT.ipmikcs.dsl /tmp/new/tests/data/acpi/pc/DSDT.ipmikcs.dsl
--- /tmp/old/tests/data/acpi/pc/DSDT.ipmikcs.dsl	2020-08-04 17:37:55.765798514 -0400
+++ /tmp/new/tests/data/acpi/pc/DSDT.ipmikcs.dsl	2020-08-04 17:42:57.270859824 -0400
@@ -50,7 +50,7 @@
         {
             Name (_HID, EisaId ("PNP0A03") /* PCI Bus */)  // _HID: Hardware ID
             Name (_ADR, Zero)  // _ADR: Address
-            Name (_UID, One)  // _UID: Unique ID
+            Name (_UID, Zero)  // _UID: Unique ID
         }
     }

diff -ru /tmp/old/tests/data/acpi/pc/DSDT.memhp.dsl /tmp/new/tests/data/acpi/pc/DSDT.memhp.dsl
--- /tmp/old/tests/data/acpi/pc/DSDT.memhp.dsl	2020-08-04 17:37:55.773798489 -0400
+++ /tmp/new/tests/data/acpi/pc/DSDT.memhp.dsl	2020-08-04 17:42:57.273859814 -0400
@@ -50,7 +50,7 @@
         {
             Name (_HID, EisaId ("PNP0A03") /* PCI Bus */)  // _HID: Hardware ID
             Name (_ADR, Zero)  // _ADR: Address
-            Name (_UID, One)  // _UID: Unique ID
+            Name (_UID, Zero)  // _UID: Unique ID
         }
     }

diff -ru /tmp/old/tests/data/acpi/pc/DSDT.numamem.dsl /tmp/new/tests/data/acpi/pc/DSDT.numamem.dsl
--- /tmp/old/tests/data/acpi/pc/DSDT.numamem.dsl	2020-08-04 17:37:55.782798461 -0400
+++ /tmp/new/tests/data/acpi/pc/DSDT.numamem.dsl	2020-08-04 17:42:57.276859805 -0400
@@ -50,7 +50,7 @@
         {
             Name (_HID, EisaId ("PNP0A03") /* PCI Bus */)  // _HID: Hardware ID
             Name (_ADR, Zero)  // _ADR: Address
-            Name (_UID, One)  // _UID: Unique ID
+            Name (_UID, Zero)  // _UID: Unique ID
         }
     }

diff -ru /tmp/old/tests/data/acpi/q35/DSDT.acpihmat.dsl /tmp/new/tests/data/acpi/q35/DSDT.acpihmat.dsl
--- /tmp/old/tests/data/acpi/q35/DSDT.acpihmat.dsl	2020-08-04 17:37:55.911798060 -0400
+++ /tmp/new/tests/data/acpi/q35/DSDT.acpihmat.dsl	2020-08-04 17:42:57.327859646 -0400
@@ -51,7 +51,7 @@
             Name (_HID, EisaId ("PNP0A08") /* PCI Express Bus */)  // _HID: Hardware ID
             Name (_CID, EisaId ("PNP0A03") /* PCI Bus */)  // _CID: Compatible ID
             Name (_ADR, Zero)  // _ADR: Address
-            Name (_UID, One)  // _UID: Unique ID
+            Name (_UID, Zero)  // _UID: Unique ID
             Method (_OSC, 4, NotSerialized)  // _OSC: Operating System Capabilities
             {
                 CreateDWordField (Arg3, Zero, CDW1)
diff -ru /tmp/old/tests/data/acpi/q35/DSDT.bridge.dsl /tmp/new/tests/data/acpi/q35/DSDT.bridge.dsl
--- /tmp/old/tests/data/acpi/q35/DSDT.bridge.dsl	2020-08-04 17:37:55.920798032 -0400
+++ /tmp/new/tests/data/acpi/q35/DSDT.bridge.dsl	2020-08-04 17:42:57.331859634 -0400
@@ -51,7 +51,7 @@
             Name (_HID, EisaId ("PNP0A08") /* PCI Express Bus */)  // _HID: Hardware ID
             Name (_CID, EisaId ("PNP0A03") /* PCI Bus */)  // _CID: Compatible ID
             Name (_ADR, Zero)  // _ADR: Address
-            Name (_UID, One)  // _UID: Unique ID
+            Name (_UID, Zero)  // _UID: Unique ID
             Method (_OSC, 4, NotSerialized)  // _OSC: Operating System Capabilities
             {
                 CreateDWordField (Arg3, Zero, CDW1)
diff -ru /tmp/old/tests/data/acpi/q35/DSDT.cphp.dsl /tmp/new/tests/data/acpi/q35/DSDT.cphp.dsl
--- /tmp/old/tests/data/acpi/q35/DSDT.cphp.dsl	2020-08-04 17:37:55.930798001 -0400
+++ /tmp/new/tests/data/acpi/q35/DSDT.cphp.dsl	2020-08-04 17:42:57.336859618 -0400
@@ -51,7 +51,7 @@
             Name (_HID, EisaId ("PNP0A08") /* PCI Express Bus */)  // _HID: Hardware ID
             Name (_CID, EisaId ("PNP0A03") /* PCI Bus */)  // _CID: Compatible ID
             Name (_ADR, Zero)  // _ADR: Address
-            Name (_UID, One)  // _UID: Unique ID
+            Name (_UID, Zero)  // _UID: Unique ID
             Method (_OSC, 4, NotSerialized)  // _OSC: Operating System Capabilities
             {
                 CreateDWordField (Arg3, Zero, CDW1)
diff -ru /tmp/old/tests/data/acpi/q35/DSDT.dimmpxm.dsl /tmp/new/tests/data/acpi/q35/DSDT.dimmpxm.dsl
--- /tmp/old/tests/data/acpi/q35/DSDT.dimmpxm.dsl	2020-08-04 17:37:55.942797963 -0400
+++ /tmp/new/tests/data/acpi/q35/DSDT.dimmpxm.dsl	2020-08-04 17:42:57.340859606 -0400
@@ -53,7 +53,7 @@
             Name (_HID, EisaId ("PNP0A08") /* PCI Express Bus */)  // _HID: Hardware ID
             Name (_CID, EisaId ("PNP0A03") /* PCI Bus */)  // _CID: Compatible ID
             Name (_ADR, Zero)  // _ADR: Address
-            Name (_UID, One)  // _UID: Unique ID
+            Name (_UID, Zero)  // _UID: Unique ID
             Method (_OSC, 4, NotSerialized)  // _OSC: Operating System Capabilities
             {
                 CreateDWordField (Arg3, Zero, CDW1)
diff -ru /tmp/old/tests/data/acpi/q35/DSDT.dsl /tmp/new/tests/data/acpi/q35/DSDT.dsl
--- /tmp/old/tests/data/acpi/q35/DSDT.dsl	2020-08-04 17:37:55.898798100 -0400
+++ /tmp/new/tests/data/acpi/q35/DSDT.dsl	2020-08-04 17:42:57.323859659 -0400
@@ -51,7 +51,7 @@
             Name (_HID, EisaId ("PNP0A08") /* PCI Express Bus */)  // _HID: Hardware ID
             Name (_CID, EisaId ("PNP0A03") /* PCI Bus */)  // _CID: Compatible ID
             Name (_ADR, Zero)  // _ADR: Address
-            Name (_UID, One)  // _UID: Unique ID
+            Name (_UID, Zero)  // _UID: Unique ID
             Method (_OSC, 4, NotSerialized)  // _OSC: Operating System Capabilities
             {
                 CreateDWordField (Arg3, Zero, CDW1)
diff -ru /tmp/old/tests/data/acpi/q35/DSDT.ipmibt.dsl /tmp/new/tests/data/acpi/q35/DSDT.ipmibt.dsl
--- /tmp/old/tests/data/acpi/q35/DSDT.ipmibt.dsl	2020-08-04 17:37:55.952797932 -0400
+++ /tmp/new/tests/data/acpi/q35/DSDT.ipmibt.dsl	2020-08-04 17:42:57.344859593 -0400
@@ -51,7 +51,7 @@
             Name (_HID, EisaId ("PNP0A08") /* PCI Express Bus */)  // _HID: Hardware ID
             Name (_CID, EisaId ("PNP0A03") /* PCI Bus */)  // _CID: Compatible ID
             Name (_ADR, Zero)  // _ADR: Address
-            Name (_UID, One)  // _UID: Unique ID
+            Name (_UID, Zero)  // _UID: Unique ID
             Method (_OSC, 4, NotSerialized)  // _OSC: Operating System Capabilities
             {
                 CreateDWordField (Arg3, Zero, CDW1)
diff -ru /tmp/old/tests/data/acpi/q35/DSDT.memhp.dsl /tmp/new/tests/data/acpi/q35/DSDT.memhp.dsl
--- /tmp/old/tests/data/acpi/q35/DSDT.memhp.dsl	2020-08-04 17:37:55.962797901 -0400
+++ /tmp/new/tests/data/acpi/q35/DSDT.memhp.dsl	2020-08-04 17:42:57.348859581 -0400
@@ -51,7 +51,7 @@
             Name (_HID, EisaId ("PNP0A08") /* PCI Express Bus */)  // _HID: Hardware ID
             Name (_CID, EisaId ("PNP0A03") /* PCI Bus */)  // _CID: Compatible ID
             Name (_ADR, Zero)  // _ADR: Address
-            Name (_UID, One)  // _UID: Unique ID
+            Name (_UID, Zero)  // _UID: Unique ID
             Method (_OSC, 4, NotSerialized)  // _OSC: Operating System Capabilities
             {
                 CreateDWordField (Arg3, Zero, CDW1)
diff -ru /tmp/old/tests/data/acpi/q35/DSDT.mmio64.dsl /tmp/new/tests/data/acpi/q35/DSDT.mmio64.dsl
--- /tmp/old/tests/data/acpi/q35/DSDT.mmio64.dsl	2020-08-04 17:37:55.972797870 -0400
+++ /tmp/new/tests/data/acpi/q35/DSDT.mmio64.dsl	2020-08-04 17:42:57.351859572 -0400
@@ -51,7 +51,7 @@
             Name (_HID, EisaId ("PNP0A08") /* PCI Express Bus */)  // _HID: Hardware ID
             Name (_CID, EisaId ("PNP0A03") /* PCI Bus */)  // _CID: Compatible ID
             Name (_ADR, Zero)  // _ADR: Address
-            Name (_UID, One)  // _UID: Unique ID
+            Name (_UID, Zero)  // _UID: Unique ID
             Method (_OSC, 4, NotSerialized)  // _OSC: Operating System Capabilities
             {
                 CreateDWordField (Arg3, Zero, CDW1)
diff -ru /tmp/old/tests/data/acpi/q35/DSDT.numamem.dsl /tmp/new/tests/data/acpi/q35/DSDT.numamem.dsl
--- /tmp/old/tests/data/acpi/q35/DSDT.numamem.dsl	2020-08-04 17:37:55.983797836 -0400
+++ /tmp/new/tests/data/acpi/q35/DSDT.numamem.dsl	2020-08-04 17:42:57.354859562 -0400
@@ -51,7 +51,7 @@
             Name (_HID, EisaId ("PNP0A08") /* PCI Express Bus */)  // _HID: Hardware ID
             Name (_CID, EisaId ("PNP0A03") /* PCI Bus */)  // _CID: Compatible ID
             Name (_ADR, Zero)  // _ADR: Address
-            Name (_UID, One)  // _UID: Unique ID
+            Name (_UID, Zero)  // _UID: Unique ID
             Method (_OSC, 4, NotSerialized)  // _OSC: Operating System Capabilities
             {
                 CreateDWordField (Arg3, Zero, CDW1)
diff -ru /tmp/old/tests/data/acpi/q35/DSDT.tis.dsl /tmp/new/tests/data/acpi/q35/DSDT.tis.dsl
--- /tmp/old/tests/data/acpi/q35/DSDT.tis.dsl	2020-08-04 17:37:55.993797804 -0400
+++ /tmp/new/tests/data/acpi/q35/DSDT.tis.dsl	2020-08-04 17:42:57.358859550 -0400
@@ -51,7 +51,7 @@
             Name (_HID, EisaId ("PNP0A08") /* PCI Express Bus */)  // _HID: Hardware ID
             Name (_CID, EisaId ("PNP0A03") /* PCI Bus */)  // _CID: Compatible ID
             Name (_ADR, Zero)  // _ADR: Address
-            Name (_UID, One)  // _UID: Unique ID
+            Name (_UID, Zero)  // _UID: Unique ID
             Method (_OSC, 4, NotSerialized)  // _OSC: Operating System Capabilities
             {
                 CreateDWordField (Arg3, Zero, CDW1)
diff -ru /tmp/old/tests/data/acpi/virt/DSDT.dsl /tmp/new/tests/data/acpi/virt/DSDT.dsl
--- /tmp/old/tests/data/acpi/virt/DSDT.dsl	2020-08-04 17:37:56.121797406 -0400
+++ /tmp/new/tests/data/acpi/virt/DSDT.dsl	2020-08-04 17:42:57.408859394 -0400
@@ -641,7 +641,7 @@
             Name (_CID, "PNP0A03" /* PCI Bus */)  // _CID: Compatible ID
             Name (_SEG, Zero)  // _SEG: PCI Segment
             Name (_BBN, Zero)  // _BBN: BIOS Bus Number
-            Name (_UID, "PCI0")  // _UID: Unique ID
+            Name (_UID, Zero)  // _UID: Unique ID
             Name (_STR, Unicode ("PCIe 0 Device"))  // _STR: Description String
             Name (_CCA, One)  // _CCA: Cache Coherency Attribute
             Name (_PRT, Package (0x80)  // _PRT: PCI Routing Table
diff -ru /tmp/old/tests/data/acpi/virt/DSDT.memhp.dsl /tmp/new/tests/data/acpi/virt/DSDT.memhp.dsl
--- /tmp/old/tests/data/acpi/virt/DSDT.memhp.dsl	2020-08-04 17:37:56.129797381 -0400
+++ /tmp/new/tests/data/acpi/virt/DSDT.memhp.dsl	2020-08-04 17:42:57.411859385 -0400
@@ -643,7 +643,7 @@
             Name (_CID, "PNP0A03" /* PCI Bus */)  // _CID: Compatible ID
             Name (_SEG, Zero)  // _SEG: PCI Segment
             Name (_BBN, Zero)  // _BBN: BIOS Bus Number
-            Name (_UID, "PCI0")  // _UID: Unique ID
+            Name (_UID, Zero)  // _UID: Unique ID
             Name (_STR, Unicode ("PCIe 0 Device"))  // _STR: Description String
             Name (_CCA, One)  // _CCA: Cache Coherency Attribute
             Name (_PRT, Package (0x80)  // _PRT: PCI Routing Table
diff -ru /tmp/old/tests/data/acpi/virt/DSDT.numamem.dsl /tmp/new/tests/data/acpi/virt/DSDT.numamem.dsl
--- /tmp/old/tests/data/acpi/virt/DSDT.numamem.dsl	2020-08-04 17:37:56.141797343 -0400
+++ /tmp/new/tests/data/acpi/virt/DSDT.numamem.dsl	2020-08-04 17:42:57.413859379 -0400
@@ -641,7 +641,7 @@
             Name (_CID, "PNP0A03" /* PCI Bus */)  // _CID: Compatible ID
             Name (_SEG, Zero)  // _SEG: PCI Segment
             Name (_BBN, Zero)  // _BBN: BIOS Bus Number
-            Name (_UID, "PCI0")  // _UID: Unique ID
+            Name (_UID, Zero)  // _UID: Unique ID
             Name (_STR, Unicode ("PCIe 0 Device"))  // _STR: Description String
             Name (_CCA, One)  // _CCA: Cache Coherency Attribute
             Name (_PRT, Package (0x80)  // _PRT: PCI Routing Table

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h |  21 --------------------
 tests/data/acpi/pc/DSDT                     | Bin 4934 -> 4934 bytes
 tests/data/acpi/pc/DSDT.acpihmat            | Bin 6258 -> 6258 bytes
 tests/data/acpi/pc/DSDT.bridge              | Bin 6793 -> 6793 bytes
 tests/data/acpi/pc/DSDT.cphp                | Bin 5397 -> 5397 bytes
 tests/data/acpi/pc/DSDT.dimmpxm             | Bin 6587 -> 6587 bytes
 tests/data/acpi/pc/DSDT.ipmikcs             | Bin 5006 -> 5006 bytes
 tests/data/acpi/pc/DSDT.memhp               | Bin 6293 -> 6293 bytes
 tests/data/acpi/pc/DSDT.numamem             | Bin 4940 -> 4940 bytes
 tests/data/acpi/q35/DSDT                    | Bin 7678 -> 7678 bytes
 tests/data/acpi/q35/DSDT.acpihmat           | Bin 9002 -> 9002 bytes
 tests/data/acpi/q35/DSDT.bridge             | Bin 7695 -> 7695 bytes
 tests/data/acpi/q35/DSDT.cphp               | Bin 8141 -> 8141 bytes
 tests/data/acpi/q35/DSDT.dimmpxm            | Bin 9331 -> 9331 bytes
 tests/data/acpi/q35/DSDT.ipmibt             | Bin 7753 -> 7753 bytes
 tests/data/acpi/q35/DSDT.memhp              | Bin 9037 -> 9037 bytes
 tests/data/acpi/q35/DSDT.mmio64             | Bin 8808 -> 8808 bytes
 tests/data/acpi/q35/DSDT.numamem            | Bin 7684 -> 7684 bytes
 tests/data/acpi/q35/DSDT.tis                | Bin 8283 -> 8283 bytes
 tests/data/acpi/virt/DSDT                   | Bin 5205 -> 5200 bytes
 tests/data/acpi/virt/DSDT.memhp             | Bin 6566 -> 6561 bytes
 tests/data/acpi/virt/DSDT.numamem           | Bin 5205 -> 5200 bytes
 22 files changed, 21 deletions(-)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index ea46c3399e..dfb8523c8b 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,22 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/q35/DSDT.mmio64",
-"tests/data/acpi/q35/DSDT.memhp",
-"tests/data/acpi/q35/DSDT.tis",
-"tests/data/acpi/q35/DSDT.acpihmat",
-"tests/data/acpi/q35/DSDT.bridge",
-"tests/data/acpi/q35/DSDT.ipmibt",
-"tests/data/acpi/q35/DSDT.numamem",
-"tests/data/acpi/q35/DSDT.dimmpxm",
-"tests/data/acpi/q35/DSDT.cphp",
-"tests/data/acpi/q35/DSDT",
-"tests/data/acpi/pc/DSDT.memhp",
-"tests/data/acpi/pc/DSDT.acpihmat",
-"tests/data/acpi/pc/DSDT.bridge",
-"tests/data/acpi/pc/DSDT.numamem",
-"tests/data/acpi/pc/DSDT.ipmikcs",
-"tests/data/acpi/pc/DSDT.dimmpxm",
-"tests/data/acpi/pc/DSDT.cphp",
-"tests/data/acpi/pc/DSDT",
-"tests/data/acpi/virt/DSDT.memhp",
-"tests/data/acpi/virt/DSDT.numamem",
-"tests/data/acpi/virt/DSDT",
diff --git a/tests/data/acpi/pc/DSDT b/tests/data/acpi/pc/DSDT
index 6d0aaf729ac7d64cf966621adf276534de5cc555..b121bb5bc124be522e233516efb17cdc94de5a75 100644
GIT binary patch
delta 24
gcmX@6c1(@SCD<jzO_+g!@xVl`Hb#bx6SoQh09#!LR{#J2

delta 24
gcmX@6c1(@SCD<jzO_+g!asNcFHb%yc6SoQh09#lGR{#J2

diff --git a/tests/data/acpi/pc/DSDT.acpihmat b/tests/data/acpi/pc/DSDT.acpihmat
index 2e5e02400b1bd2842989d395c573fc593f45503b..b0dbb943f4cea83a5adde23aefa54f1678c560a1 100644
GIT binary patch
delta 24
fcmexl@X3J7CD<jTNP>ZZv2P+*8zaNUi4VmAW<Uq?

delta 24
fcmexl@X3J7CD<jTNP>ZZv3DX@8zbY!i4VmAW;+M-

diff --git a/tests/data/acpi/pc/DSDT.bridge b/tests/data/acpi/pc/DSDT.bridge
index 623c4c03585c47d4d28adc611823b7cce8f4a5c7..7b6c7a47875fc73b03fbe88807890f3867ddba1a 100644
GIT binary patch
delta 24
fcmeA)?KI_b33dtTlwx3D<ebRW#>lX7;txpxP_YKs

delta 24
fcmeA)?KI_b33dtTlwx3D<e13S#>lvF;txpxP^<>n

diff --git a/tests/data/acpi/pc/DSDT.cphp b/tests/data/acpi/pc/DSDT.cphp
index e0a43ccdadae150c0f39599c85e4e21ed8fff2a4..c0e8aa5b32d84f39e5d6c9a5024505f818707c12 100644
GIT binary patch
delta 24
fcmbQLHC2ntCD<iIRFr{%(Q+bJ8zaNUi7g@kO4bG#

delta 24
fcmbQLHC2ntCD<iIRFr{%(PAQ38zbY!i7g@kO3?-w

diff --git a/tests/data/acpi/pc/DSDT.dimmpxm b/tests/data/acpi/pc/DSDT.dimmpxm
index 21eb065a0ee3bd96f1a2e7601aa83fefa833349a..1649953b6cccb933e4a440dc56507dc9197c4a8a 100644
GIT binary patch
delta 24
fcmdmOyxW+|CD<iow<H4tqvAxaHb#bx6SX7(TZsm<

delta 24
fcmdmOyxW+|CD<iow<H4tqryb4Hb%yc6SX7(TZ9I)

diff --git a/tests/data/acpi/pc/DSDT.ipmikcs b/tests/data/acpi/pc/DSDT.ipmikcs
index b8f08f266b5735fe6967d4e105ee6b3662dad7e6..92748d49dcd418e4a734da47e8d5c0268aedfc29 100644
GIT binary patch
delta 24
fcmeBE?^EY;33dtT6J}sw44KH)#>lX7;$I;EQV9nQ

delta 24
fcmeBE?^EY;33dtT6J}sw44%l<#>lvF;$I;EQUnJL

diff --git a/tests/data/acpi/pc/DSDT.memhp b/tests/data/acpi/pc/DSDT.memhp
index 9a9418f4bde5fb18883c244ea956122e371ff01a..4026772906e910af514beb76de6e4cca0bc2171b 100644
GIT binary patch
delta 24
gcmbPgIMtBLCD<iosssZA<EDvRZHx>XC$dNY09SGbrT_o{

delta 24
ecmbPgIMtBLCD<iosssZA<Hm_xZHz#YMFId<Z3d<Q

diff --git a/tests/data/acpi/pc/DSDT.numamem b/tests/data/acpi/pc/DSDT.numamem
index 6eec385c2ec00544c6eaa7e19d32b2ccd5a51915..4d9ba337a82954af094e739b8a83467f89a37cc0 100644
GIT binary patch
delta 24
fcmX@3c1DfMCD<jzN0@<uF>4}M8zaNUiMxdWS$hW=

delta 24
fcmX@3c1DfMCD<jzN0@<uF>@kU8zbY!iMxdWS#}2*

diff --git a/tests/data/acpi/q35/DSDT b/tests/data/acpi/q35/DSDT
index e63676d7a63afec714debeb465ee478ea4714337..bba8884073a27427b88ac0d733c9c87330a59366 100644
GIT binary patch
delta 24
gcmexo{m+`qCD<k8pDY6d<C=+FlNcE`&P|jB0CR8%ZU6uP

delta 24
gcmexo{m+`qCD<k8pDY6d<LZfAlNcE{&P|jB0CQ^yZU6uP

diff --git a/tests/data/acpi/q35/DSDT.acpihmat b/tests/data/acpi/q35/DSDT.acpihmat
index cd97b819824e4140d087e465d179b71775d6a494..9cac92418b5fcc2767dc74603d599642b59623fe 100644
GIT binary patch
delta 24
fcmZ4Gw#tpmCD<iIOPPUzv2r5UBu0jfb9<ElSc3-)

delta 24
fcmZ4Gw#tpmCD<iIOPPUzv0@_EBu2)Kb9<ElSbhf#

diff --git a/tests/data/acpi/q35/DSDT.bridge b/tests/data/acpi/q35/DSDT.bridge
index 8b0fb497dbbaeba18e9d0e1503de4396f1c230b0..f08b7245f59aad491fcaa60e2bab1085c369ea1c 100644
GIT binary patch
delta 24
fcmeCT>9^r>33dtLmt$aH^q$ByiIHLB+#*>3P7elD

delta 24
fcmeCT>9^r>33dtLmt$aH^qR;uiIH*R+#*>3P6`H8

diff --git a/tests/data/acpi/q35/DSDT.cphp b/tests/data/acpi/q35/DSDT.cphp
index d9bb414e9bf15d9b9149f38c9bb5d8b993f88650..57d859cef9fa16a8f125c4b338611c8472699f38 100644
GIT binary patch
delta 24
gcmX?Wf7YJMCD<k8tULn)qv}MiNsJ5|=NiZZ0AlF}F8}}l

delta 24
gcmX?Wf7YJMCD<k8tULn)qsm0CNsNpe=NiZZ0Al0^F8}}l

diff --git a/tests/data/acpi/q35/DSDT.dimmpxm b/tests/data/acpi/q35/DSDT.dimmpxm
index 29f19b22a38f9d8e7dc9870f0c1aa3d4470643ff..9d5bd5744e2ba2e0f6126c3aba0bb36af865e499 100644
GIT binary patch
delta 24
gcmezD@!5mRCD<jTScQRs@!dqONsJ5|=U!6=0B>^$s{jB1

delta 24
gcmezD@!5mRCD<jTScQRs@$E#eNsNpe=U!6=0B>#xs{jB1

diff --git a/tests/data/acpi/q35/DSDT.ipmibt b/tests/data/acpi/q35/DSDT.ipmibt
index e8dea1ea42af765babcb747af998b0d912abdcbd..5cd11de6a8fe47324e5f922823a22746882f19f5 100644
GIT binary patch
delta 24
gcmX?UbJB*(CD<jzQ;vaw@%}`vNsJ5|=dO_j0Ad{n&;S4c

delta 24
gcmX?UbJB*(CD<jzQ;vaw@!mwPNsNpe=dO_j0Ad&i&;S4c

diff --git a/tests/data/acpi/q35/DSDT.memhp b/tests/data/acpi/q35/DSDT.memhp
index dca76db15b943122efd5c200cb54ce3dbc97a55f..05a7a73ec43130d5c3018bb462fd84981bfb151c 100644
GIT binary patch
delta 24
gcmX@>cGiu{CD<jzSDAr<aqdK}NsJ5|=Wb8}0Ah#-yZ`_I

delta 24
gcmX@>cGiu{CD<jzSDAr<an3}pNsNpe=Wb8}0Ahm&yZ`_I

diff --git a/tests/data/acpi/q35/DSDT.mmio64 b/tests/data/acpi/q35/DSDT.mmio64
index 6d8facd9e179140682ad5d4302f3dad14dbec342..efd3f1188f2b55da1514212d4be081a61c2a96e9 100644
GIT binary patch
delta 24
gcmaFi^1_A7CD<h-Ly3WbF>)f;Bu0jfb5AP*0A?Ns-T(jq

delta 24
gcmaFi^1_A7CD<h-Ly3WbF=8UuBu2)Kb5AP*0A?8n-T(jq

diff --git a/tests/data/acpi/q35/DSDT.numamem b/tests/data/acpi/q35/DSDT.numamem
index 737325dc3082fdf06283857811f6f5174e0ff2a9..1978b55f1255402bf9bade0b91150b5cb49789a4 100644
GIT binary patch
delta 24
fcmZp%X|dsQ33dr#kz-(B44ud|iIHLB+;mw0OTGp&

delta 24
fcmZp%X|dsQ33dr#kz-(B44KF^iIH*R+;mw0OSuLz

diff --git a/tests/data/acpi/q35/DSDT.tis b/tests/data/acpi/q35/DSDT.tis
index 27ee927fc5ac05b89724c154197304c39e653269..638de3872673d17b1958497d0e62c83653de1602 100644
GIT binary patch
delta 24
gcmccZaNB{)CD<h-T7iLqv1KCHBu0jfbN9&u0AtGs$p8QV

delta 24
gcmccZaNB{)CD<h-T7iLqv3VlbBu2)KbN9&u0At1n$p8QV

diff --git a/tests/data/acpi/virt/DSDT b/tests/data/acpi/virt/DSDT
index e669508d175f1e3ddf355f8a9b0d419266cac8aa..9b002836f35fd03afeab9e827fdde3134d26ed2e 100644
GIT binary patch
delta 36
scmcbraY2L2CD<h-K!kyT>DNRqX{K(cjp`Ddj82msIE^-!bKc_u0L51dc>n+a

delta 42
ycmcbhaaDuMCD<h-RD^+n>ET2!X{H9}jp`DdjP8>iIE`3&1Drh#HWzW;;{pKve+zj4

diff --git a/tests/data/acpi/virt/DSDT.memhp b/tests/data/acpi/virt/DSDT.memhp
index 4cb81f692d73526542493a0c4da9c9793cc8366e..545a18c3657781d350a006adfa5e58fa63e63922 100644
GIT binary patch
delta 36
scmZ2xywI4-CD<iop(FzXlk`L`X{Mg(8`UK^8J#9Oa2jnc=hPPf0JT*KRR910

delta 42
ycmZ2zyv&%(CD<ionIr=P6VpU4X{N>*8`UK^8Qmv4a2m1l1~_{fY%b!|7XSe2n+jC`

diff --git a/tests/data/acpi/virt/DSDT.numamem b/tests/data/acpi/virt/DSDT.numamem
index e669508d175f1e3ddf355f8a9b0d419266cac8aa..9b002836f35fd03afeab9e827fdde3134d26ed2e 100644
GIT binary patch
delta 36
scmcbraY2L2CD<h-K!kyT>DNRqX{K(cjp`Ddj82msIE^-!bKc_u0L51dc>n+a

delta 42
ycmcbhaaDuMCD<h-RD^+n>ET2!X{H9}jp`DdjP8>iIE`3&1Drh#HWzW;;{pKve+zj4

-- 
MST


