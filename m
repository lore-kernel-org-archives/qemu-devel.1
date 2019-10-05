Return-Path: <SRS0=HB7V=X6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B8C4C47404
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2019 22:11:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31029222C5
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2019 22:11:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31029222C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGsGU-00074y-Jp
	for qemu-devel@archiver.kernel.org; Sat, 05 Oct 2019 18:11:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47952)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iGs5T-0005GM-7H
 for qemu-devel@nongnu.org; Sat, 05 Oct 2019 17:59:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iGs5P-0004Qt-V0
 for qemu-devel@nongnu.org; Sat, 05 Oct 2019 17:59:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45820)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iGs5P-0004QP-DS
 for qemu-devel@nongnu.org; Sat, 05 Oct 2019 17:59:35 -0400
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B8496369CA
 for <qemu-devel@nongnu.org>; Sat,  5 Oct 2019 21:59:33 +0000 (UTC)
Received: by mail-qk1-f200.google.com with SMTP id r17so10631728qkm.16
 for <qemu-devel@nongnu.org>; Sat, 05 Oct 2019 14:59:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ZUsRuHusQn13NajHmVe0uglldXJ2FT++dNwEWoKKktk=;
 b=ojEhi4WhvOrGnBSAPqLpagCM/8EzzFDOUWhzvmlgE5DGAezRaS1HIywdVsNFsZ5O33
 a+lmnl89FGy4MrD3fj8/aHg+kGDY976H088YuPN6ncnsL/pSo4FUYz6lcOese7BMU6Y1
 PMglcdkGa0Jxaic32rGdotFD/p5gIuL0qNWbMH0lmM3Gh3C5EYHI0AeDUesmVkk+M+zH
 zBHETrfzE0+7ItIvRgy2wQRKoTkve6alEMLcLCFXOIQvkP25bkfP4cQE3CuG0UAPyYYo
 MOXYhZ9Pj0mU5Kq1wEaZnGDGpxnwmNdFspMkmB4LxH0HLhttjjKi1zF9kM1UsguF6ftN
 9JWg==
X-Gm-Message-State: APjAAAXkr2Z8Aqn/TZxzHnnItij86KEx3CQCmy7IgRY/L967e6HrwFmJ
 xc3F4TfSXVX6k/39c3wUUPvx3oQ+orze4kIAxM6FX0qmHun5EOGpW6CTDpqtnKKLU8D/RNt/MWZ
 fj2I6HiUBlrYufs4=
X-Received: by 2002:a37:a2cd:: with SMTP id
 l196mr17055283qke.357.1570312772653; 
 Sat, 05 Oct 2019 14:59:32 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyAZSymRm758gv0ALEROxHgwcwcx+i7pqDm7F1DhAbqL9v/+kWgecQcfUR8KBwsBRQh5ldKWg==
X-Received: by 2002:a37:a2cd:: with SMTP id
 l196mr17055268qke.357.1570312772399; 
 Sat, 05 Oct 2019 14:59:32 -0700 (PDT)
Received: from redhat.com (bzq-79-176-10-77.red.bezeqint.net. [79.176.10.77])
 by smtp.gmail.com with ESMTPSA id
 x12sm7114595qtb.32.2019.10.05.14.59.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Oct 2019 14:59:31 -0700 (PDT)
Date: Sat, 5 Oct 2019 17:59:27 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 10/19] docs/specs: Add ACPI GED documentation
Message-ID: <20190918130633.4872-10-shameerali.kolothum.thodi@huawei.com>
References: <20191005215508.28754-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20191005215508.28754-1-mst@redhat.com>
X-Mailer: git-send-email 2.22.0.678.g13338e74b8
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 Eric Auger <eric.auger@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20191005215927.S9jr83ouhwvuv7Kq-JL7Gm45dk53XvFzhczZ4A1M-20@z>

From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>

Documents basic concepts of ACPI Generic Event device(GED)
and interface between QEMU and the ACPI BIOS.

Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Message-Id: <20190918130633.4872-10-shameerali.kolothum.thodi@huawei.com>
Acked-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 docs/specs/acpi_hw_reduced_hotplug.rst | 70 ++++++++++++++++++++++++++
 docs/specs/index.rst                   |  1 +
 2 files changed, 71 insertions(+)
 create mode 100644 docs/specs/acpi_hw_reduced_hotplug.rst

diff --git a/docs/specs/acpi_hw_reduced_hotplug.rst b/docs/specs/acpi_hw_reduced_hotplug.rst
new file mode 100644
index 0000000000..911a98255b
--- /dev/null
+++ b/docs/specs/acpi_hw_reduced_hotplug.rst
@@ -0,0 +1,70 @@
+==================================================
+QEMU and ACPI BIOS Generic Event Device interface
+==================================================
+
+The ACPI *Generic Event Device* (GED) is a HW reduced platform
+specific device introduced in ACPI v6.1 that handles all platform
+events, including the hotplug ones. GED is modelled as a device
+in the namespace with a _HID defined to be ACPI0013. This document
+describes the interface between QEMU and the ACPI BIOS.
+
+GED allows HW reduced platforms to handle interrupts in ACPI ASL
+statements. It follows a very similar approach to the _EVT method
+from GPIO events. All interrupts are listed in  _CRS and the handler
+is written in _EVT method. However, the QEMU implementation uses a
+single interrupt for the GED device, relying on an IO memory region
+to communicate the type of device affected by the interrupt. This way,
+we can support up to 32 events with a unique interrupt.
+
+**Here is an example,**
+
+::
+
+   Device (\_SB.GED)
+   {
+       Name (_HID, "ACPI0013")
+       Name (_UID, Zero)
+       Name (_CRS, ResourceTemplate ()
+       {
+           Interrupt (ResourceConsumer, Edge, ActiveHigh, Exclusive, ,, )
+           {
+               0x00000029,
+           }
+       })
+       OperationRegion (EREG, SystemMemory, 0x09080000, 0x04)
+       Field (EREG, DWordAcc, NoLock, WriteAsZeros)
+       {
+           ESEL,   32
+       }
+       Method (_EVT, 1, Serialized)
+       {
+           Local0 = ESEL // ESEL = IO memory region which specifies the
+                         // device type.
+           If (((Local0 & One) == One))
+           {
+               MethodEvent1()
+           }
+           If ((Local0 & 0x2) == 0x2)
+           {
+               MethodEvent2()
+           }
+           ...
+       }
+   }
+
+GED IO interface (4 byte access)
+--------------------------------
+**read access:**
+
+::
+
+   [0x0-0x3] Event selector bit field (32 bit) set by QEMU.
+
+    bits:
+       0: Memory hotplug event
+       1: System power down event
+    2-31: Reserved
+
+**write_access:**
+
+Nothing is expected to be written into GED IO memory
diff --git a/docs/specs/index.rst b/docs/specs/index.rst
index 40adb97c5e..984ba44029 100644
--- a/docs/specs/index.rst
+++ b/docs/specs/index.rst
@@ -12,3 +12,4 @@ Contents:
 
    ppc-xive
    ppc-spapr-xive
+   acpi_hw_reduced_hotplug
-- 
MST


