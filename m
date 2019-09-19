Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F269C3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 21:49:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 362E4217D6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 21:49:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hru8wI97"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 362E4217D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iB4Ig-0002Ac-2I
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 17:49:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56228)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tcminyard@gmail.com>) id 1iB49R-0001Tu-79
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 17:39:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tcminyard@gmail.com>) id 1iB49M-00069e-WA
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 17:39:44 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:42040)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1iB49M-00069Y-R2
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 17:39:40 -0400
Received: by mail-oi1-x241.google.com with SMTP id i185so9735oif.9
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2019 14:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=cVK217iyCckYWeLWjL20H8sYo3oU/9iWz2Z9ZL5bhw8=;
 b=hru8wI973heFuYi/HxwK1UZ45mIPRZqK5XJdwzGl6uUQeG96OsTQUIhGYKy9gBb/DQ
 W+dYf3fYBUeqCUlIaEg9gX7rBH93OZFPbt+aJSIg7ntTGMJoEnlULq6CN2BtkkJqAkd/
 oZSo3oFTcHtaWjw2ROGFosYqOXK+cQUDBDK+TcJl1PlWLR1ISdHL7E/REOdWPD7LOZl4
 6OiYthZoyjz8qGUVtwnD9HN0kxqaBxxEEuhbx2v+6pam6D+D80UQ3sg3GZyIndqh7Paq
 S4e+jTZKTWXABFIv3IoFhw6SmpuMk/tSMDIDgPSuzw18fIUSp3vn37gke2AiyF7nl2xP
 zBHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=cVK217iyCckYWeLWjL20H8sYo3oU/9iWz2Z9ZL5bhw8=;
 b=e0cAbKuHLul+yT91i5TL/CRXHQDNFAr6z4k55FuhN2NRsGE3l574bazr3y4so+lYJM
 h0hv3sA/HdzOTVoYMc65GvbrExX5s/9jSN9G740mrD473pv3uskKo8ZF9kXAu3+m4dpy
 tnX44GDEMGQD2ClnSt8MkqKoGJoAauNmhjzB6mNkTyjpG2yXBoIkVASXVNQuab9lK5AT
 agL6ZcMgO3IY+0KPSOz+WX1Ee3BGZlSULjs/yDKbycJ+uwdePK6vr2fne65IOgJ0zZkR
 sEZhcZ1iP3HavYxHF4RbV3xLqhGGK2Oe20BfvTp4xnL/2KZxDoXFEv//kg4Bu/2VCsIj
 Otdg==
X-Gm-Message-State: APjAAAXg6Yj5/cqA9E9LSYE/0V+AujuUK7s9yjJrzDcjrDuFLcxbhZfu
 WqrVzlU2nFv9AMbZK8KXvg==
X-Google-Smtp-Source: APXvYqzDNP0IC6aL+Nq1/7VRCiTRB1CQRvuZ02UGd3SaqgAxo/UoHfg3rjUltDldqKoXFU7MMms9pw==
X-Received: by 2002:a54:4382:: with SMTP id u2mr63112oiv.96.1568929179958;
 Thu, 19 Sep 2019 14:39:39 -0700 (PDT)
Received: from serve.minyard.net ([47.184.136.59])
 by smtp.gmail.com with ESMTPSA id v6sm38601oie.4.2019.09.19.14.39.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2019 14:39:36 -0700 (PDT)
Received: from t560.minyard.net (unknown [192.168.27.180])
 by serve.minyard.net (Postfix) with ESMTPA id 1D93918059D;
 Thu, 19 Sep 2019 21:39:36 +0000 (UTC)
From: minyard@acm.org
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 04/15] tests:ipmi: Fix IPMI BT tests
Date: Thu, 19 Sep 2019 16:39:13 -0500
Message-Id: <20190919213924.31852-5-minyard@acm.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190919213924.31852-1-minyard@acm.org>
References: <20190919213924.31852-1-minyard@acm.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
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
Cc: Corey Minyard <cminyard@mvista.com>, Fam Zheng <famz@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Corey Minyard <cminyard@mvista.com>

The IPMI BT tests had a race condition, if it receive an IPMI command
to enable interrupt, it would write the message to enable interrupts
after it wrote the command response.  So the test code could
receive the command response and issue the next command before the
device handled the interrupt enable command, and thus no interrupt.

So send the message to enable interrupt before the command response.

Also add some sleeps to give qemu time to handle responses, there was
no delay before, and it could result in an invalid timeout.

And re-enable the tests, as hopefully they are fixed now.

Note that I was unable to reproduce this even with the instructions
Peter gave me, but hopefully this fixes the issue.

Cc: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Corey Minyard <cminyard@mvista.com>
---
 tests/Makefile.include | 3 +--
 tests/ipmi-bt-test.c   | 6 ++++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 793632ca72..479664f899 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -170,8 +170,7 @@ check-qtest-i386-$(CONFIG_SGA) += tests/boot-serial-test$(EXESUF)
 check-qtest-i386-$(CONFIG_SLIRP) += tests/pxe-test$(EXESUF)
 check-qtest-i386-y += tests/rtc-test$(EXESUF)
 check-qtest-i386-$(CONFIG_ISA_IPMI_KCS) += tests/ipmi-kcs-test$(EXESUF)
-# Disabled temporarily as it fails intermittently especially under NetBSD VM
-# check-qtest-i386-$(CONFIG_ISA_IPMI_BT) += tests/ipmi-bt-test$(EXESUF)
+check-qtest-i386-$(CONFIG_ISA_IPMI_BT) += tests/ipmi-bt-test$(EXESUF)
 check-qtest-i386-y += tests/i440fx-test$(EXESUF)
 check-qtest-i386-y += tests/fw_cfg-test$(EXESUF)
 check-qtest-i386-y += tests/device-plug-test$(EXESUF)
diff --git a/tests/ipmi-bt-test.c b/tests/ipmi-bt-test.c
index fc4c83b5db..a42207d416 100644
--- a/tests/ipmi-bt-test.c
+++ b/tests/ipmi-bt-test.c
@@ -30,7 +30,7 @@
 #include <netinet/tcp.h>
 
 
-#include "libqtest.h"
+#include "libqtest-single.h"
 #include "qemu-common.h"
 
 #define IPMI_IRQ        5
@@ -99,6 +99,7 @@ static void bt_wait_b_busy(void)
     unsigned int count = 1000;
     while (IPMI_BT_CTLREG_GET_B_BUSY() != 0) {
         g_assert(--count != 0);
+        usleep(100);
     }
 }
 
@@ -107,6 +108,7 @@ static void bt_wait_b2h_atn(void)
     unsigned int count = 1000;
     while (IPMI_BT_CTLREG_GET_B2H_ATN() == 0) {
         g_assert(--count != 0);
+        usleep(100);
     }
 }
 
@@ -240,13 +242,13 @@ static void emu_msg_handler(void)
         write_emu_msg(msg, msg_len);
     } else if ((msg[1] == set_bmc_globals_cmd[0]) &&
                (msg[2] == set_bmc_globals_cmd[1])) {
+        write_emu_msg(enable_irq_cmd, sizeof(enable_irq_cmd));
         memcpy(msg + 1, set_bmc_globals_rsp, sizeof(set_bmc_globals_rsp));
         msg_len = sizeof(set_bmc_globals_rsp) + 1;
         msg[msg_len] = -ipmb_checksum(msg, msg_len, 0);
         msg_len++;
         msg[msg_len++] = 0xa0;
         write_emu_msg(msg, msg_len);
-        write_emu_msg(enable_irq_cmd, sizeof(enable_irq_cmd));
     } else {
         g_assert(0);
     }
-- 
2.17.1


