Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8AC8C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 16:27:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70033206D5
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 16:27:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BJkkVF2p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70033206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixCf3-0007eG-J5
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 11:27:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43173)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ixCTz-0005fk-Ih
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 11:15:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ixCTx-00030z-QP
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 11:15:55 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:51405)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ixCTx-00030E-Io
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 11:15:53 -0500
Received: by mail-wm1-x32e.google.com with SMTP id t23so4414745wmi.1
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2020 08:15:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=olZMl9ovKm/UMnsw+bXUgBT5hb6vuOVJTzcLPD6KZi4=;
 b=BJkkVF2pFQtn1PqG110vCZWUKx2oQSzw7HVriebf7YxBrpQZC0KhQ0poqd1kGcGbi1
 A+9SXvh7RWkLa2cg4/tg9kTFWSxzr0z9uqQHncrKP0mXAft5mJhpn0ysc7lZY09cvcAw
 ZZudHUALhUn7we9iex+CVoZEHZmdkcADgwfXiNz9zRQ55LkYiG5EmSJuMhPuyS+XcrkJ
 4TcgPpmRF29fAAaauLGLd6ZyEs+RA9uJf0hxvcivA+43A3bRio708087zZNNHF7oV8yM
 AwwlMZEuxAGgRXTt425LDzcwEfW6mcpKxsO4v4sTjUTmsLzQxwcjKggxpz+/YqmvsiU8
 C8WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=olZMl9ovKm/UMnsw+bXUgBT5hb6vuOVJTzcLPD6KZi4=;
 b=YKlLPusJWPenETZtaBuvxwkCPVu8gdix69xE2oVbo7vF+L0uZiixV6WT2YrAskRiIP
 Lyr4aeI/vKfJjsrgy7Y9el3As/YFgfZyx51y7qoDFFbjoNkkTOp6Ttuphv1CMtcSiyDU
 uBCe+4/7f3TIszX3FmqOKf5Em8B5VKXrdXDhj2fOsIzfxxNh5OoM60JR3GcAiAnuLes2
 5c1rz7g0PHydCsx7Ooaj+5/ktVqjhWaQFtHXe7IH8YGI8qP7vBWv2JnoME4PyVom0+AC
 23C7oexMJw9rmZTt7ql+gPW7TEE8a860ufByGeghxFWoqZ70earXI0f9tfnfpTp8FoHO
 im0Q==
X-Gm-Message-State: APjAAAVhWeK13KKy1V7RvUX2LAanfBqhvQ3ySpVBRAJcQgZ+U1fHoMPN
 Jc8BfUzSztxZffbwJXXuvQh5UyIgeLAEbw==
X-Google-Smtp-Source: APXvYqyfSenn8eQn5se/VSLpBVqmlaGxKaC/OZmHmafnYYEikYjLIvIPWIConoOGwOLNYXD2Y/56Dw==
X-Received: by 2002:a1c:e28a:: with SMTP id z132mr6261328wmg.157.1580400952135; 
 Thu, 30 Jan 2020 08:15:52 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id a22sm6994442wmd.20.2020.01.30.08.15.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jan 2020 08:15:51 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/26] hw/core/qdev: handle parent bus change regarding
 resettable
Date: Thu, 30 Jan 2020 16:15:21 +0000
Message-Id: <20200130161533.8180-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200130161533.8180-1-peter.maydell@linaro.org>
References: <20200130161533.8180-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32e
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Damien Hedde <damien.hedde@greensocs.com>

In qdev_set_parent_bus(), when changing the parent bus of a
realized device, if the source and destination buses are not in the
same reset state, some adaptations are required. This patch adds
needed call to resettable_change_parent() to make sure a device reset
state stays coherent with its parent bus.

The addition is a no-op if:
1. the device being parented is not realized.
2. the device is realized, but both buses are not under reset.

Case 2 means that as long as qdev_set_parent_bus() is called
during the machine realization procedure (which is before the
machine reset so nothing is in reset), it is a no op.

There are 52 call sites of qdev_set_parent_bus(). All but one fall
into the no-op case:
+ 29 trivial calls related to virtio (in hw/{s390x,display,virtio}/
  {vhost,virtio}-xxx.c) to set a vdev(or vgpu) composing device
  parent bus just before realizing the same vdev(vgpu).
+ hw/core/qdev.c: when creating a device in qdev_try_create()
+ hw/core/sysbus.c: when initializing a device in the sysbus
+ hw/i386/amd_iommu.c: before realizing AMDVIState/pci
+ hw/isa/piix4.c: before realizing PIIX4State/rtc
+ hw/misc/auxbus.c: when creating an AUXBus
+ hw/misc/auxbus.c: when creating an AUXBus child
+ hw/misc/macio/macio.c: when initializing a MACIOState child
+ hw/misc/macio/macio.c: before realizing NewWorldMacIOState/pmu
+ hw/misc/macio/macio.c: before realizing NewWorldMacIOState/cuda
+ hw/net/virtio-net.c: Used for migration when using the failover
                       mechanism to migration a vfio-pci/net. It is
                       a no-op because at this point the device is
                       already on the bus.
+ hw/pci-host/designware.c: before realizing DesignwarePCIEHost/root
+ hw/pci-host/gpex.c: before realizing GPEXHost/root
+ hw/pci-host/prep.c: when initialiazing PREPPCIState/pci_dev
+ hw/pci-host/q35.c: before realizing Q35PCIHost/mch
+ hw/pci-host/versatile.c: when initializing PCIVPBState/pci_dev
+ hw/pci-host/xilinx-pcie.c: before realizing XilinxPCIEHost/root
+ hw/s390x/event-facility.c: when creating SCLPEventFacility/
                             TYPE_SCLP_QUIESCE
+ hw/s390x/event-facility.c: ditto with SCLPEventFacility/
                             TYPE_SCLP_CPU_HOTPLUG
+ hw/s390x/sclp.c: Not trivial because it is called on a SLCPDevice
  just after realizing it. Ok because at this point the destination
  bus (sysbus) is not in reset; the realize step is before the
  machine reset.
+ hw/sd/core.c: Not OK. Used in sdbus_reparent_card(). See below.
+ hw/ssi/ssi.c: Used to put spi slave on spi bus and connect the cs
  line in ssi_auto_connect_slave(). Ok because this function is only
  used in realize step in hw/ssi/aspeed_smc.ci, hw/ssi/imx_spi.c,
  hw/ssi/mss-spi.c, hw/ssi/xilinx_spi.c and hw/ssi/xilinx_spips.c.
+ hw/xen/xen-legacy-backend.c: when creating a XenLegacyDevice device
+ qdev-monitor.c: in device hotplug creation procedure before realize

Note that this commit alone will have no effect, right now there is no
use of resettable API to reset anything. So a bus will never be tagged
as in-reset by this same API.

The one place where side-effect will occurs is in hw/sd/core.c in
sdbus_reparent_card(). This function is only used in the raspi machines,
including during the sysbus reset procedure. This case will be
carrefully handled when doing the multiple phase reset transition.

Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20200123132823.1117486-7-damien.hedde@greensocs.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/core/qdev.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index b2affd8f92b..28fc93b1074 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -96,25 +96,31 @@ static void bus_add_child(BusState *bus, DeviceState *child)
 
 void qdev_set_parent_bus(DeviceState *dev, BusState *bus)
 {
-    bool replugging = dev->parent_bus != NULL;
+    BusState *old_parent_bus = dev->parent_bus;
 
-    if (replugging) {
+    if (old_parent_bus) {
         trace_qdev_update_parent_bus(dev, object_get_typename(OBJECT(dev)),
-            dev->parent_bus, object_get_typename(OBJECT(dev->parent_bus)),
+            old_parent_bus, object_get_typename(OBJECT(old_parent_bus)),
             OBJECT(bus), object_get_typename(OBJECT(bus)));
         /*
          * Keep a reference to the device while it's not plugged into
          * any bus, to avoid it potentially evaporating when it is
          * dereffed in bus_remove_child().
+         * Also keep the ref of the parent bus until the end, so that
+         * we can safely call resettable_change_parent() below.
          */
         object_ref(OBJECT(dev));
         bus_remove_child(dev->parent_bus, dev);
-        object_unref(OBJECT(dev->parent_bus));
     }
     dev->parent_bus = bus;
     object_ref(OBJECT(bus));
     bus_add_child(bus, dev);
-    if (replugging) {
+    if (dev->realized) {
+        resettable_change_parent(OBJECT(dev), OBJECT(bus),
+                                 OBJECT(old_parent_bus));
+    }
+    if (old_parent_bus) {
+        object_unref(OBJECT(old_parent_bus));
         object_unref(OBJECT(dev));
     }
 }
-- 
2.20.1


