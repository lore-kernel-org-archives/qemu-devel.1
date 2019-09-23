Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D9BC4CEC4
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 16:43:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09F832089F
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 16:43:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09F832089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCRRD-00005J-Oh
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 12:43:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57109)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iCQxO-0002RC-QL
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 12:13:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iCQxM-0003iN-Ja
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 12:12:58 -0400
Received: from relay.sw.ru ([185.231.240.75]:39518)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iCQxM-0003aA-A1; Mon, 23 Sep 2019 12:12:56 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.2)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1iCQx1-0001Fp-Fq; Mon, 23 Sep 2019 19:12:35 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org
Subject: [RFC v2 8/9] fix-compilation: empty goto
Date: Mon, 23 Sep 2019 19:12:30 +0300
Message-Id: <20190923161231.22028-9-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190923161231.22028-1-vsementsov@virtuozzo.com>
References: <20190923161231.22028-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
X-Mailman-Approved-At: Mon, 23 Sep 2019 12:26:10 -0400
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
Cc: stefanha@redhat.com, codyprime@gmail.com, jan.kiszka@siemens.com,
 berto@igalia.com, zhang.zhanghailiang@huawei.com, qemu-block@nongnu.org,
 arikalo@wavecomp.com, pasic@linux.ibm.com, hpoussin@reactos.org,
 anthony.perard@citrix.com, samuel.thibault@ens-lyon.org, philmd@redhat.com,
 green@moxielogic.com, lvivier@redhat.com, ehabkost@redhat.com,
 xiechanglong.d@gmail.com, pl@kamp.de, dgilbert@redhat.com, b.galvani@gmail.com,
 eric.auger@redhat.com, alex.williamson@redhat.com, ronniesahlberg@gmail.com,
 jsnow@redhat.com, rth@twiddle.net, kwolf@redhat.com, vsementsov@virtuozzo.com,
 andrew@aj.id.au, crwulff@gmail.com, sundeep.lkml@gmail.com, michael@walle.cc,
 qemu-ppc@nongnu.org, kbastian@mail.uni-paderborn.de, imammedo@redhat.com,
 fam@euphon.net, peter.maydell@linaro.org, sheepdog@lists.wpkg.org,
 david@redhat.com, palmer@sifive.com, thuth@redhat.com, jcmvbkbc@gmail.com,
 den@openvz.org, hare@suse.com, sstabellini@kernel.org, arei.gonglei@huawei.com,
 namei.unix@gmail.com, atar4qemu@gmail.com, farman@linux.ibm.com,
 amit@kernel.org, sw@weilnetz.de, groug@kaod.org, qemu-s390x@nongnu.org,
 qemu-arm@nongnu.org, peter.chubb@nicta.com.au, clg@kaod.org, shorne@gmail.com,
 qemu-riscv@nongnu.org, cohuck@redhat.com, amarkovic@wavecomp.com,
 aurelien@aurel32.net, pburton@wavecomp.com, sagark@eecs.berkeley.edu,
 jasowang@redhat.com, kraxel@redhat.com, edgar.iglesias@gmail.com,
 gxt@mprc.pku.edu.cn, ari@tuxera.com, quintela@redhat.com,
 mdroth@linux.vnet.ibm.com, lersek@redhat.com, borntraeger@de.ibm.com,
 antonynpavlov@gmail.com, dillaman@redhat.com, joel@jms.id.au,
 xen-devel@lists.xenproject.org, integration@gluster.org, rjones@redhat.com,
 Andrew.Baumann@microsoft.com, mreitz@redhat.com, walling@linux.ibm.com,
 mst@redhat.com, mark.cave-ayland@ilande.co.uk, v.maffione@gmail.com,
 marex@denx.de, armbru@redhat.com, marcandre.lureau@redhat.com,
 alistair@alistair23.me, paul.durrant@citrix.com, pavel.dovgaluk@ispras.ru,
 g.lettieri@iet.unipi.it, rizzo@iet.unipi.it, david@gibson.dropbear.id.au,
 akrowiak@linux.ibm.com, berrange@redhat.com, xiaoguangrong.eric@gmail.com,
 pmorel@linux.ibm.com, wencongyang2@huawei.com, jcd@tribudubois.net,
 pbonzini@redhat.com, stefanb@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I don't understand, why these special cases are not handled by
coccinelle. Possibly, it's a bug in coccinelle itself.

If no other ideas, these fixes may be just merged to autogenerated
commit(commits), with appropriate notice in commit message.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 backends/cryptodev.c    | 7 -------
 hw/dma/xilinx_axidma.c  | 7 ++-----
 hw/net/xilinx_axienet.c | 7 ++-----
 hw/ppc/spapr.c          | 3 +--
 hw/ppc/spapr_cpu_core.c | 3 +--
 hw/s390x/s390-ccw.c     | 3 +--
 hw/vfio/ap.c            | 3 +--
 hw/vfio/ccw.c           | 3 +--
 8 files changed, 9 insertions(+), 27 deletions(-)

diff --git a/backends/cryptodev.c b/backends/cryptodev.c
index dcdb8481b2..aa4a62ace0 100644
--- a/backends/cryptodev.c
+++ b/backends/cryptodev.c
@@ -176,14 +176,7 @@ cryptodev_backend_complete(UserCreatable *uc, Error **errp)
 
     if (bc->init) {
         bc->init(backend, errp);
-        if (*errp) {
-            goto out;
-        }
     }
-
-    return;
-
-out:
 }
 
 void cryptodev_backend_set_used(CryptoDevBackend *backend, bool used)
diff --git a/hw/dma/xilinx_axidma.c b/hw/dma/xilinx_axidma.c
index b5f49e6f88..b5456f5db2 100644
--- a/hw/dma/xilinx_axidma.c
+++ b/hw/dma/xilinx_axidma.c
@@ -536,12 +536,12 @@ static void xilinx_axidma_realize(DeviceState *dev, Error **errp)
                              OBJ_PROP_LINK_STRONG,
                              errp);
     if (*errp) {
-        goto xilinx_axidma_realize_fail;
+        return;
     }
     object_property_set_link(OBJECT(ds), OBJECT(s), "dma", errp);
     object_property_set_link(OBJECT(cs), OBJECT(s), "dma", errp);
     if (*errp) {
-        goto xilinx_axidma_realize_fail;
+        return;
     }
 
     int i;
@@ -554,9 +554,6 @@ static void xilinx_axidma_realize(DeviceState *dev, Error **errp)
         st->ptimer = ptimer_init(st->bh, PTIMER_POLICY_DEFAULT);
         ptimer_set_freq(st->ptimer, s->freqhz);
     }
-    return;
-
-xilinx_axidma_realize_fail:
 }
 
 static void xilinx_axidma_init(Object *obj)
diff --git a/hw/net/xilinx_axienet.c b/hw/net/xilinx_axienet.c
index 5f87a6336b..372ca88956 100644
--- a/hw/net/xilinx_axienet.c
+++ b/hw/net/xilinx_axienet.c
@@ -963,12 +963,12 @@ static void xilinx_enet_realize(DeviceState *dev, Error **errp)
                              OBJ_PROP_LINK_STRONG,
                              errp);
     if (*errp) {
-        goto xilinx_enet_realize_fail;
+        return;
     }
     object_property_set_link(OBJECT(ds), OBJECT(s), "enet", errp);
     object_property_set_link(OBJECT(cs), OBJECT(s), "enet", errp);
     if (*errp) {
-        goto xilinx_enet_realize_fail;
+        return;
     }
 
     qemu_macaddr_default_if_unset(&s->conf.macaddr);
@@ -982,9 +982,6 @@ static void xilinx_enet_realize(DeviceState *dev, Error **errp)
     s->TEMAC.parent = s;
 
     s->rxmem = g_malloc(s->c_rxmem);
-    return;
-
-xilinx_enet_realize_fail:
 }
 
 static void xilinx_enet_init(Object *obj)
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 5ef043bd72..7b0ab71f23 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3503,7 +3503,7 @@ static void spapr_memory_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
 
     pc_dimm_plug(dimm, MACHINE(ms), errp);
     if (*errp) {
-        goto out;
+        return;
     }
 
     addr = object_property_get_uint(OBJECT(dimm),
@@ -3522,7 +3522,6 @@ static void spapr_memory_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
 
 out_unplug:
     pc_dimm_unplug(dimm, MACHINE(ms));
-out:
 }
 
 static void spapr_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index 93f9b0e0c9..c35696ff42 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -224,7 +224,7 @@ static void spapr_realize_vcpu(PowerPCCPU *cpu, SpaprMachineState *spapr,
 
     object_property_set_bool(OBJECT(cpu), true, "realized", errp);
     if (*errp) {
-        goto error;
+        return;
     }
 
     /* Set time-base frequency to 512 MHz */
@@ -251,7 +251,6 @@ static void spapr_realize_vcpu(PowerPCCPU *cpu, SpaprMachineState *spapr,
 error_unregister:
     qemu_unregister_reset(spapr_cpu_reset, cpu);
     cpu_remove_sync(CPU(cpu));
-error:
 }
 
 static PowerPCCPU *spapr_create_vcpu(SpaprCpuCore *sc, int i, Error **errp)
diff --git a/hw/s390x/s390-ccw.c b/hw/s390x/s390-ccw.c
index 0ae1951507..8695d2c445 100644
--- a/hw/s390x/s390-ccw.c
+++ b/hw/s390x/s390-ccw.c
@@ -94,7 +94,7 @@ static void s390_ccw_realize(S390CCWDevice *cdev, char *sysfsdev, Error **errp)
 
     s390_ccw_get_dev_info(cdev, sysfsdev, errp);
     if (*errp) {
-        goto out_err_propagate;
+        return;
     }
 
     sch = css_create_sch(ccw_dev->devno, errp);
@@ -127,7 +127,6 @@ out_err:
     g_free(sch);
 out_mdevid_free:
     g_free(cdev->mdevid);
-out_err_propagate:
 }
 
 static void s390_ccw_unrealize(S390CCWDevice *cdev, Error **errp)
diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
index e072a08f1d..8fbaa724c2 100644
--- a/hw/vfio/ap.c
+++ b/hw/vfio/ap.c
@@ -95,7 +95,7 @@ static void vfio_ap_realize(DeviceState *dev, Error **errp)
 
     vfio_group = vfio_ap_get_group(vapdev, errp);
     if (!vfio_group) {
-        goto out_err;
+        return;
     }
 
     vapdev->vdev.ops = &vfio_ap_ops;
@@ -122,7 +122,6 @@ static void vfio_ap_realize(DeviceState *dev, Error **errp)
 out_get_dev_err:
     vfio_ap_put_device(vapdev);
     vfio_put_group(vfio_group);
-out_err:
 }
 
 static void vfio_ap_unrealize(DeviceState *dev, Error **errp)
diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
index d2b526667e..c24ffdb3af 100644
--- a/hw/vfio/ccw.c
+++ b/hw/vfio/ccw.c
@@ -486,7 +486,7 @@ static void vfio_ccw_realize(DeviceState *dev, Error **errp)
     if (cdc->realize) {
         cdc->realize(cdev, vcdev->vdev.sysfsdev, errp);
         if (*errp) {
-            goto out_err_propagate;
+            return;
         }
     }
 
@@ -522,7 +522,6 @@ out_group_err:
     if (cdc->unrealize) {
         cdc->unrealize(cdev, NULL);
     }
-out_err_propagate:
 }
 
 static void vfio_ccw_unrealize(DeviceState *dev, Error **errp)
-- 
2.21.0


