Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D995C4CEC4
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 16:30:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6433820882
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 16:30:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6433820882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCREO-0005ii-8F
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 12:30:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57102)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iCQxO-0002Qw-Gn
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 12:13:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iCQxM-0003jC-S6
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 12:12:58 -0400
Received: from relay.sw.ru ([185.231.240.75]:39506)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iCQxM-0003a7-Gv; Mon, 23 Sep 2019 12:12:56 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.2)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1iCQx1-0001Fp-PU; Mon, 23 Sep 2019 19:12:35 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org
Subject: [RFC v2 9/9] fix-compilation: includes
Date: Mon, 23 Sep 2019 19:12:31 +0300
Message-Id: <20190923161231.22028-10-vsementsov@virtuozzo.com>
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

Hmm. Should we allow empty stubs with errp parameter without calling
new macro?

Or, just apply this commit before auto-generated commit.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 target/ppc/kvm_ppc.h        | 2 ++
 target/s390x/cpu_models.h   | 1 +
 hw/i386/kvm/apic.c          | 1 +
 hw/misc/arm11scu.c          | 1 +
 hw/misc/mps2-scc.c          | 1 +
 hw/pci-bridge/dec.c         | 1 +
 qapi/qapi-dealloc-visitor.c | 1 +
 stubs/xen-hvm.c             | 1 +
 8 files changed, 9 insertions(+)

diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
index 807c245e90..f6366c19aa 100644
--- a/target/ppc/kvm_ppc.h
+++ b/target/ppc/kvm_ppc.h
@@ -9,6 +9,8 @@
 #ifndef KVM_PPC_H
 #define KVM_PPC_H
 
+#include "qapi/error.h"
+
 #define TYPE_HOST_POWERPC_CPU POWERPC_CPU_TYPE_NAME("host")
 
 #ifdef CONFIG_KVM
diff --git a/target/s390x/cpu_models.h b/target/s390x/cpu_models.h
index 5329045a71..062161c5fa 100644
--- a/target/s390x/cpu_models.h
+++ b/target/s390x/cpu_models.h
@@ -16,6 +16,7 @@
 #include "cpu_features.h"
 #include "gen-features.h"
 #include "hw/core/cpu.h"
+#include "qapi/error.h"
 
 /* static CPU definition */
 struct S390CPUDef {
diff --git a/hw/i386/kvm/apic.c b/hw/i386/kvm/apic.c
index d125b370f4..cadf75b71c 100644
--- a/hw/i386/kvm/apic.c
+++ b/hw/i386/kvm/apic.c
@@ -18,6 +18,7 @@
 #include "sysemu/hw_accel.h"
 #include "sysemu/kvm.h"
 #include "target/i386/kvm_i386.h"
+#include "qapi/error.h"
 
 static inline void kvm_apic_set_reg(struct kvm_lapic_state *kapic,
                                     int reg_id, uint32_t val)
diff --git a/hw/misc/arm11scu.c b/hw/misc/arm11scu.c
index befc85f321..9c1fec7825 100644
--- a/hw/misc/arm11scu.c
+++ b/hw/misc/arm11scu.c
@@ -13,6 +13,7 @@
 #include "hw/qdev-properties.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
+#include "qapi/error.h"
 
 static uint64_t mpcore_scu_read(void *opaque, hwaddr offset,
                                 unsigned size)
diff --git a/hw/misc/mps2-scc.c b/hw/misc/mps2-scc.c
index f2a00d3235..c41e776996 100644
--- a/hw/misc/mps2-scc.c
+++ b/hw/misc/mps2-scc.c
@@ -26,6 +26,7 @@
 #include "hw/registerfields.h"
 #include "hw/misc/mps2-scc.h"
 #include "hw/qdev-properties.h"
+#include "qapi/error.h"
 
 REG32(CFG0, 0)
 REG32(CFG1, 4)
diff --git a/hw/pci-bridge/dec.c b/hw/pci-bridge/dec.c
index fbe781474e..06445e0545 100644
--- a/hw/pci-bridge/dec.c
+++ b/hw/pci-bridge/dec.c
@@ -31,6 +31,7 @@
 #include "hw/pci/pci_host.h"
 #include "hw/pci/pci_bridge.h"
 #include "hw/pci/pci_bus.h"
+#include "qapi/error.h"
 
 /* debug DEC */
 //#define DEBUG_DEC
diff --git a/qapi/qapi-dealloc-visitor.c b/qapi/qapi-dealloc-visitor.c
index 3ee4c7a2e7..e265e29234 100644
--- a/qapi/qapi-dealloc-visitor.c
+++ b/qapi/qapi-dealloc-visitor.c
@@ -16,6 +16,7 @@
 #include "qapi/dealloc-visitor.h"
 #include "qapi/qmp/qnull.h"
 #include "qapi/visitor-impl.h"
+#include "qapi/error.h"
 
 struct QapiDeallocVisitor
 {
diff --git a/stubs/xen-hvm.c b/stubs/xen-hvm.c
index 840a2a0d09..350c762c64 100644
--- a/stubs/xen-hvm.c
+++ b/stubs/xen-hvm.c
@@ -12,6 +12,7 @@
 #include "hw/xen/xen.h"
 #include "exec/memory.h"
 #include "qapi/qapi-commands-misc.h"
+#include "qapi/error.h"
 
 int xen_pci_slot_get_pirq(PCIDevice *pci_dev, int irq_num)
 {
-- 
2.21.0


