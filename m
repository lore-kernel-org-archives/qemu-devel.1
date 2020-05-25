Return-Path: <SRS0=XKWp=7H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A263C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 12:24:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34F1720812
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 12:24:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P1wi9erU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34F1720812
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdC9H-0002Jd-F4
	for qemu-devel@archiver.kernel.org; Mon, 25 May 2020 08:24:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36462)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jdC8l-0001uo-FE
 for qemu-devel@nongnu.org; Mon, 25 May 2020 08:23:35 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:50294)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jdC8k-0003OV-LI
 for qemu-devel@nongnu.org; Mon, 25 May 2020 08:23:35 -0400
Received: by mail-wm1-x341.google.com with SMTP id v19so9311330wmj.0
 for <qemu-devel@nongnu.org>; Mon, 25 May 2020 05:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=hxVdAqRBN33zJYNq1JPS0/5+xi8GLpRW0Exzc9/Ood4=;
 b=P1wi9erUO4QFO/s7Xg2V9tR8OUOjzauCQ41muzeOEcoYk4T2yKDcJpNbiiCRFxtEDa
 jDHLIzbCaQzhPxJktcuFbCU9E1y2QxolvNiTJDB3lXpQZq7x4s99f7bpRocZMO/oms1/
 x7vfDDIhmajB7y3zsyn37Afv2PAraSQxsbRYdJ2yG4oOAaIY7kaoMrqAnZUB6vHjbX+P
 uV/G0/SGT6iDCNgR7Vjd1I6k2zuaQDzXW6QHg+wKivKBhQ45roo0RosmiWz1t6hSFQsC
 qqIpzA1h+RkMX/DSveak1YvgmMr86CwXW1YnkgJnCwm9gRqXTYp0e+F5b90OOuc1JxDW
 H90Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=hxVdAqRBN33zJYNq1JPS0/5+xi8GLpRW0Exzc9/Ood4=;
 b=Mc9S304hN29sxrnxCTR2FbvYI+USfIUTskmQgRFl+xDa8Da+Bd5JR+EwoOib3QMYdE
 CtWcrqno9ROin7fhzN9Ct5xtBSFPSA83Cq9pZ9wS4oio/pgxd7fXutXWBja+Ho8d69If
 mycnB9X67pnlrvzS6xY27GFSQVfL0ysHOrqFOA2FmY1G495izfOVcoG+TP5T5CzR2wrp
 hHHKopckINMqGwM0aohgBwf9x4/BI5dxp1rBoK263/j30P788Bz4PT9aHjzP3noxcN+v
 iWFxh3597P68DsvDm+NGw93fd2WZehXnTvrG0Qj2S9/j1fs9GDG7O93lksH0XQVeYYQO
 oOaw==
X-Gm-Message-State: AOAM532/B4nGWcqKEEcv2v9wrHoRoTUJCxstLvcz8w/nbcU1zDSb2Q5c
 J44KJrFmvu4fPc3XhDCGYI/2IfY4fBI=
X-Google-Smtp-Source: ABdhPJzDwYL456y0qDdR6qkVKbhjmrB3bPAHXfm5fjwKp+UTpx5tUQxDbYv+uREfPgld2SQsjXAwgg==
X-Received: by 2002:a7b:c750:: with SMTP id w16mr26777762wmk.73.1590409412511; 
 Mon, 25 May 2020 05:23:32 -0700 (PDT)
Received: from localhost.localdomain (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id k131sm19114473wma.2.2020.05.25.05.23.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2020 05:23:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH] hw/net/e1000e: Do not abort() on invalid PSRCTL register
 value
Date: Mon, 25 May 2020 14:23:30 +0200
Message-Id: <20200525122330.3691-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

libFuzzer found using 'qemu-system-i386 -M q35':

qemu: hardware error: e1000e: PSRCTL.BSIZE0 cannot be zero
CPU #0:
EAX=00000000 EBX=00000000 ECX=00000000 EDX=00000663
ESI=00000000 EDI=00000000 EBP=00000000 ESP=00000000
EIP=0000fff0 EFL=00000002 [-------] CPL=0 II=0 A20=1 SMM=0 HLT=0
ES =0000 00000000 0000ffff 00009300
CS =f000 ffff0000 0000ffff 00009b00
SS =0000 00000000 0000ffff 00009300
DS =0000 00000000 0000ffff 00009300
FS =0000 00000000 0000ffff 00009300
GS =0000 00000000 0000ffff 00009300
LDT=0000 00000000 0000ffff 00008200
TR =0000 00000000 0000ffff 00008b00
GDT=     00000000 0000ffff
IDT=     00000000 0000ffff
CR0=60000010 CR2=00000000 CR3=00000000 CR4=00000000
DR0=00000000 DR1=00000000 DR2=00000000 DR3=00000000
DR6=ffff0ff0 DR7=00000400
EFER=0000000000000000
FCW=037f FSW=0000 [ST=0] FTW=00 MXCSR=00001f80
FPR0=0000000000000000 0000 FPR1=0000000000000000 0000
FPR2=0000000000000000 0000 FPR3=0000000000000000 0000
FPR4=0000000000000000 0000 FPR5=0000000000000000 0000
FPR6=0000000000000000 0000 FPR7=0000000000000000 0000
XMM00=00000000000000000000000000000000 XMM01=00000000000000000000000000000000
XMM02=00000000000000000000000000000000 XMM03=00000000000000000000000000000000
XMM04=00000000000000000000000000000000 XMM05=00000000000000000000000000000000
XMM06=00000000000000000000000000000000 XMM07=00000000000000000000000000000000
==1988== ERROR: libFuzzer: deadly signal
    #6 0x7fae4d3ea894 in __GI_abort (/lib64/libc.so.6+0x22894)
    #7 0x563f4cc59a1d in hw_error (qemu-fuzz-i386+0xe8ca1d)
    #8 0x563f4d7c93f2 in e1000e_set_psrctl (qemu-fuzz-i386+0x19fc3f2)
    #9 0x563f4d7b798f in e1000e_core_write (qemu-fuzz-i386+0x19ea98f)
    #10 0x563f4d7afc46 in e1000e_mmio_write (qemu-fuzz-i386+0x19e2c46)
    #11 0x563f4cc9a0a7 in memory_region_write_accessor (qemu-fuzz-i386+0xecd0a7)
    #12 0x563f4cc99c13 in access_with_adjusted_size (qemu-fuzz-i386+0xeccc13)
    #13 0x563f4cc987b4 in memory_region_dispatch_write (qemu-fuzz-i386+0xecb7b4)

It simply sent the following 2 I/O command to the e1000e
PCI BAR #2 I/O region:

  writew 0x0100 0x0c00 # RCTL =   E1000_RCTL_DTYP_MASK
  writeb 0x2170 0x00   # PSRCTL = 0

2813 static void
2814 e1000e_set_psrctl(E1000ECore *core, int index, uint32_t val)
2815 {
2816     if (core->mac[RCTL] & E1000_RCTL_DTYP_MASK) {
2817
2818         if ((val & E1000_PSRCTL_BSIZE0_MASK) == 0) {
2819             hw_error("e1000e: PSRCTL.BSIZE0 cannot be zero");
2820         }

Instead of calling hw_error() which abort the process (it is
meant for CPU fatal error condition, not for device logging),
log the invalid request with qemu_log_mask(LOG_GUEST_ERROR)
and return ignoring the request.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
RFC because there might be something clever than returning...
Probably worth a Cc:qemu-stable@ tag
---
 hw/net/e1000e_core.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
index d5676871fa..bcd186cac5 100644
--- a/hw/net/e1000e_core.c
+++ b/hw/net/e1000e_core.c
@@ -34,9 +34,9 @@
 */
 
 #include "qemu/osdep.h"
+#include "qemu/log.h"
 #include "net/net.h"
 #include "net/tap.h"
-#include "hw/hw.h"
 #include "hw/pci/msi.h"
 #include "hw/pci/msix.h"
 #include "sysemu/runstate.h"
@@ -2816,11 +2816,15 @@ e1000e_set_psrctl(E1000ECore *core, int index, uint32_t val)
     if (core->mac[RCTL] & E1000_RCTL_DTYP_MASK) {
 
         if ((val & E1000_PSRCTL_BSIZE0_MASK) == 0) {
-            hw_error("e1000e: PSRCTL.BSIZE0 cannot be zero");
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "e1000e: PSRCTL.BSIZE0 cannot be zero");
+            return;
         }
 
         if ((val & E1000_PSRCTL_BSIZE1_MASK) == 0) {
-            hw_error("e1000e: PSRCTL.BSIZE1 cannot be zero");
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "e1000e: PSRCTL.BSIZE1 cannot be zero");
+            return;
         }
     }
 
-- 
2.21.3


