Return-Path: <SRS0=qU7A=VV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEF02C76186
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 16:57:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B52B521841
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 16:57:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B52B521841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqKaL-0003er-T9
	for qemu-devel@archiver.kernel.org; Wed, 24 Jul 2019 12:57:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44139)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <groug@kaod.org>) id 1hqKa1-0002Z7-Rh
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 12:57:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1hqKa0-0001GN-Bn
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 12:57:29 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43872)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1hqKa0-0001Dk-3b
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 12:57:28 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x6OGuvDe054413
 for <qemu-devel@nongnu.org>; Wed, 24 Jul 2019 12:57:27 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2txswhme5p-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 24 Jul 2019 12:57:26 -0400
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <groug@kaod.org>;
 Wed, 24 Jul 2019 17:57:24 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
 by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 24 Jul 2019 17:57:21 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x6OGvKRX59441162
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 24 Jul 2019 16:57:21 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DB8D1A4040;
 Wed, 24 Jul 2019 16:57:20 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ADBC5A4051;
 Wed, 24 Jul 2019 16:57:20 +0000 (GMT)
Received: from bahia.lan (unknown [9.145.15.116])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed, 24 Jul 2019 16:57:20 +0000 (GMT)
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>,
 =?utf-8?q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Date: Wed, 24 Jul 2019 18:57:20 +0200
In-Reply-To: <156398742921.546975.8822387598242513827.stgit@bahia.lan>
References: <156398742921.546975.8822387598242513827.stgit@bahia.lan>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19072416-0012-0000-0000-00000335CE73
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19072416-0013-0000-0000-0000216F6330
Message-Id: <156398744035.546975.7029414194633598474.stgit@bahia.lan>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-07-24_06:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1907240182
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
Subject: [Qemu-devel] [PATCH for-4.1 2/2] xics/kvm: Fix fallback to emulated
 XICS
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Commit 4812f2615288 tried to fix rollback path of xics_kvm_connect() but
it isn't enough. If we fail to create the KVM device, the guest fails
to boot later on with:

[    0.010817] pci 0000:00:00.0: Adding to iommu group 0
[    0.010863] irq: unknown-1 didn't like hwirq-0x1200 to VIRQ17 mapping (rc=-22)
[    0.010923] pci 0000:00:01.0: Adding to iommu group 0
[    0.010968] irq: unknown-1 didn't like hwirq-0x1201 to VIRQ17 mapping (rc=-22)
[    0.011543] EEH: No capable adapters found
[    0.011597] irq: unknown-1 didn't like hwirq-0x1000 to VIRQ17 mapping (rc=-22)
[    0.011651] audit: type=2000 audit(1563977526.000:1): state=initialized audit_enabled=0 res=1
[    0.011703] ------------[ cut here ]------------
[    0.011729] event-sources: Unable to allocate interrupt number for /event-sources/epow-events
[    0.011776] WARNING: CPU: 0 PID: 1 at arch/powerpc/platforms/pseries/event_sources.c:34 request_event_sources_irqs+0xbc/0x150
[    0.011828] Modules linked in:
[    0.011850] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.1.17-300.fc30.ppc64le #1
[    0.011886] NIP:  c0000000000d4fac LR: c0000000000d4fa8 CTR: c0000000018f0000
[    0.011923] REGS: c00000001e4c38d0 TRAP: 0700   Not tainted  (5.1.17-300.fc30.ppc64le)
[    0.011966] MSR:  8000000002029033 <SF,VEC,EE,ME,IR,DR,RI,LE>  CR: 28000284  XER: 20040000
[    0.012012] CFAR: c00000000011b42c IRQMASK: 0
[    0.012012] GPR00: c0000000000d4fa8 c00000001e4c3b60 c0000000015fc400 0000000000000051
[    0.012012] GPR04: 0000000000000001 0000000000000000 0000000000000081 772d6576656e7473
[    0.012012] GPR08: 000000001edf0000 c0000000014d4830 c0000000014d4830 6e6576652f20726f
[    0.012012] GPR12: 0000000000000000 c0000000018f0000 c000000000010bf0 0000000000000000
[    0.012012] GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
[    0.012012] GPR20: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
[    0.012012] GPR24: 0000000000000000 0000000000000000 c000000000ebbf00 c0000000000d5570
[    0.012012] GPR28: c000000000ebc008 c00000001fff8248 0000000000000000 0000000000000000
[    0.012372] NIP [c0000000000d4fac] request_event_sources_irqs+0xbc/0x150
[    0.012409] LR [c0000000000d4fa8] request_event_sources_irqs+0xb8/0x150
[    0.012445] Call Trace:
[    0.012462] [c00000001e4c3b60] [c0000000000d4fa8] request_event_sources_irqs+0xb8/0x150 (unreliable)
[    0.012513] [c00000001e4c3bf0] [c000000001042848] __machine_initcall_pseries_init_ras_IRQ+0xc8/0xf8
[    0.012563] [c00000001e4c3c20] [c000000000010810] do_one_initcall+0x60/0x254
[    0.012611] [c00000001e4c3cf0] [c000000001024538] kernel_init_freeable+0x35c/0x444
[    0.012655] [c00000001e4c3db0] [c000000000010c14] kernel_init+0x2c/0x148
[    0.012693] [c00000001e4c3e20] [c00000000000bdc4] ret_from_kernel_thread+0x5c/0x78
[    0.012736] Instruction dump:
[    0.012759] 38a00000 7c7f1b78 7f64db78 2c1f0000 2fbf0000 78630020 4180002c 409effa8
[    0.012805] 7fa4eb78 7f43d378 48046421 60000000 <0fe00000> 3bde0001 2c1e0010 7fde07b4
[    0.012851] ---[ end trace aa5785707323fad3 ]---

This happens because QEMU fell back on XICS emulation but didn't unregister
the RTAS calls from KVM. The emulated RTAS calls are hence never called and
the KVM ones return an error to the guest since the KVM device is absent.

The sanity checks in xics_kvm_disconnect() are abusive since we're freeing
the KVM device. Simply drop them.

Fixes: 4812f2615288 "xics/kvm: Add proper rollback to xics_kvm_init()"
Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/intc/xics_kvm.c |   11 -----------
 1 file changed, 11 deletions(-)

diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
index 2df1f3e92c7e..65c35f90f9af 100644
--- a/hw/intc/xics_kvm.c
+++ b/hw/intc/xics_kvm.c
@@ -430,17 +430,6 @@ fail:
 
 void xics_kvm_disconnect(SpaprMachineState *spapr, Error **errp)
 {
-    /* The KVM XICS device is not in use */
-    if (kernel_xics_fd == -1) {
-        return;
-    }
-
-    if (!kvm_enabled() || !kvm_check_extension(kvm_state, KVM_CAP_IRQ_XICS)) {
-        error_setg(errp,
-                   "KVM and IRQ_XICS capability must be present for KVM XICS device");
-        return;
-    }
-
     /*
      * Only on P9 using the XICS-on XIVE KVM device:
      *


