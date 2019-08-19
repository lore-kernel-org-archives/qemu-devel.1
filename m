Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AA20C3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 20:21:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FCE1206DF
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 20:21:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ONOc/Xcf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FCE1206DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzo9P-0004AA-PU
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 16:21:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45460)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tcminyard@gmail.com>) id 1hzo5j-0007bV-Hc
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 16:17:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tcminyard@gmail.com>) id 1hzo5f-0003Dn-QP
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 16:17:23 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:36879)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1hzo5f-0003CL-Ky
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 16:17:19 -0400
Received: by mail-ot1-x344.google.com with SMTP id f17so2895545otq.4
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2019 13:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=2RTc8GIAmHAQeyoEa8ZN4sRA9/pcwsPzo1tgjJ/3mxo=;
 b=ONOc/XcfJJPxhaw1mpsh9nI5VbKmoLkmLR0KtYjOdSEiU8IgmRaa3k9yXbdsaIDCR7
 zxvpN1Q+J/C1/jjorA1pIne7qsWhs7gBLM2MCMKuQjoFHVpgJU5YPJdx0tbN2sh7M7nS
 7k8OVZ3Nhk/6Kbl0qvofIK3300MVd6hPqwH2Yg2MmkwHpfHccptd08SukyPZ4mkAA6iE
 ET/Gur2JToqtNT07ec4QpnQfDqknfeQ1oZ2Zw59r06R6nLvkxWuwDjb8X1I/GtWelU5T
 s2nt2leDjbcMfbOOkcQT+0izkLygeWqq4tWL9y3N3RoixyLTi+akTBS7Z0z93kttfnz0
 sr1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=2RTc8GIAmHAQeyoEa8ZN4sRA9/pcwsPzo1tgjJ/3mxo=;
 b=XNd0/XwboX4yt6JWZaqDi+0d1SRwQwGuQaB6njbBFXunw7pib3KpkeErrVB/tAhGqf
 wT9AUxQB2CXN0jmIF6+j5GYEwx7dKE6xtqpj6mfoL97JXjZ1/KHJpSXm8nklhPOZbmN6
 uMJfTrTdcrpIj0JCuSGJEvzVVTIF6jw3sdt0VDe0lNOL+JJdCBMEbSYxVWVhtIN9lPRI
 U7SVm1AjA0zmRwm7HXqSB0BSdN6ijlWAdPEiF2XxasVJPMLXS70mnPn5dWBfKxGRl8HA
 IcdiNikeroMPL3LF2KGU99GZwld/jMzrTxaIY54usOqFqrZyfFsSwrvjSDxF44PnObiU
 L4Kg==
X-Gm-Message-State: APjAAAXLzy6V5FWxoBV9YhXsmbU7Zu1rvhULi2ZC6OlKqmtuHjA1vkTy
 yyZ6Hw4+Bgqc+AGQKezKtoC/fmM=
X-Google-Smtp-Source: APXvYqwzezBrj2jmD8kQEoFFe36JkNlm4bHeDsSVNm4rN4ZxssubOsSzAFPxpPN2t3Yb9RNqm7r6Qw==
X-Received: by 2002:a05:6830:2094:: with SMTP id
 y20mr18872085otq.36.1566245838218; 
 Mon, 19 Aug 2019 13:17:18 -0700 (PDT)
Received: from serve.minyard.net ([47.184.134.43])
 by smtp.gmail.com with ESMTPSA id 11sm5957554otc.45.2019.08.19.13.17.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Aug 2019 13:17:17 -0700 (PDT)
Received: from t430.minyard.net (t430m.minyard.net [192.168.27.3])
 by serve.minyard.net (Postfix) with ESMTPA id E26EE1805A9;
 Mon, 19 Aug 2019 20:17:16 +0000 (UTC)
Received: by t430.minyard.net (Postfix, from userid 1000)
 id 9EC3E302506; Mon, 19 Aug 2019 15:17:16 -0500 (CDT)
From: minyard@acm.org
To: QEMU Developers <qemu-devel@nongnu.org>
Date: Mon, 19 Aug 2019 15:16:54 -0500
Message-Id: <20190819201705.31633-5-minyard@acm.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190819201705.31633-1-minyard@acm.org>
References: <20190819201705.31633-1-minyard@acm.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: [Qemu-devel] [PATCH 04/15] tests:ipmi: Fix IPMI BT tests
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
Cc: Corey Minyard <cminyard@mvista.com>,
 Peter Maydell <peter.maydell@linaro.org>
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
 tests/ipmi-bt-test.c   | 4 +++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index fd7fdb8658..6fc3abfc42 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -169,8 +169,7 @@ check-qtest-i386-$(CONFIG_SGA) += tests/boot-serial-test$(EXESUF)
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
index fc4c83b5db..9f3e638146 100644
--- a/tests/ipmi-bt-test.c
+++ b/tests/ipmi-bt-test.c
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


