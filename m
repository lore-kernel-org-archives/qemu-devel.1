Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A840C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 06:41:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DDFC2076E
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 06:41:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="PkcUJTGv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DDFC2076E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joi3F-0002lb-Lu
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 02:41:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49700)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1joi2N-0001PG-7i; Fri, 26 Jun 2020 02:40:35 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:48735 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1joi2L-0001ER-Cw; Fri, 26 Jun 2020 02:40:34 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 49tS1l5zWtz9sT6; Fri, 26 Jun 2020 16:40:27 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1593153627;
 bh=3YYjwnPyp550Q+yo6TL9Otc/NC6+mV01kdh4w7Mzckk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=PkcUJTGvkmBtOAq1pmuy4urmJz8ik/0MMF95QSuIgQXdoAR/OVnVNjXfaqoiuNXIu
 olXnWPdbvSxFJ2JT5Uq8SVkhEr0cVvVWIhdqMTP6ZCQgqfECFVUkLCXFlbRG5spibv
 mtEEP8dr3tUJjdsay/1MDW2Ws1q379kgWnYcw7OM=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 3/4] ppc/pnv: Silence missing BMC warning with qtest
Date: Fri, 26 Jun 2020 16:40:23 +1000
Message-Id: <20200626064024.383996-4-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200626064024.383996-1-david@gibson.dropbear.id.au>
References: <20200626064024.383996-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Cc: qemu-devel@nongnu.org, groug@kaod.org, qemu-ppc@nongnu.org, clg@kaod.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Greg Kurz <groug@kaod.org>

The device introspect test in qtest emits some warnings with the
the pnv machine types during the "nodefaults" phase:

TEST check-qtest-ppc64: tests/qtest/device-introspect-test
qemu-system-ppc64: warning: machine has no BMC device. Use '-device
ipmi-bmc-sim,id=bmc0 -device isa-ipmi-bt,bmc=bmc0,irq=10' to define
one
qemu-system-ppc64: warning: machine has no BMC device. Use '-device
ipmi-bmc-sim,id=bmc0 -device isa-ipmi-bt,bmc=bmc0,irq=10' to define
one
qemu-system-ppc64: warning: machine has no BMC device. Use '-device
ipmi-bmc-sim,id=bmc0 -device isa-ipmi-bt,bmc=bmc0,irq=10' to define
one

This is expected since the pnv machine doesn't create the internal
BMC simulator fallback when "-nodefaults" is passed on the command
line, but these warnings appear in ci logs and confuse people.

Not having a BMC isn't recommended but it is still a supported
configuration, so a straightforward fix is to just silent this
warning when qtest is enabled.

Fixes: 25f3170b0654 ("ppc/pnv: Create BMC devices only when defaults are enabled")
Reported-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <159280903824.485572.831378159272329707.stgit@bahia.lan>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/pnv.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 8bd03f3b10..643098ad5f 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -21,6 +21,7 @@
 #include "qemu-common.h"
 #include "qemu/units.h"
 #include "qapi/error.h"
+#include "sysemu/qtest.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/numa.h"
 #include "sysemu/reset.h"
@@ -587,9 +588,11 @@ static void pnv_reset(MachineState *machine)
     bmc = pnv_bmc_find(&error_fatal);
     if (!pnv->bmc) {
         if (!bmc) {
-            warn_report("machine has no BMC device. Use '-device "
-                        "ipmi-bmc-sim,id=bmc0 -device isa-ipmi-bt,bmc=bmc0,irq=10' "
-                        "to define one");
+            if (!qtest_enabled()) {
+                warn_report("machine has no BMC device. Use '-device "
+                            "ipmi-bmc-sim,id=bmc0 -device isa-ipmi-bt,bmc=bmc0,irq=10' "
+                            "to define one");
+            }
         } else {
             pnv_bmc_set_pnor(bmc, pnv->pnor);
             pnv->bmc = bmc;
-- 
2.26.2


