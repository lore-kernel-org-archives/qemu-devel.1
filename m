Return-Path: <SRS0=MBD3=C4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18D86C43463
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2020 18:49:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0CB120874
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2020 18:49:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0CB120874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJhvp-0002K5-UQ
	for qemu-devel@archiver.kernel.org; Sat, 19 Sep 2020 14:49:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51846)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kJhrL-0006A9-1A; Sat, 19 Sep 2020 14:45:19 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:40393)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kJhrJ-0001MA-7B; Sat, 19 Sep 2020 14:45:18 -0400
Received: from localhost.localdomain ([82.252.129.222]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MHEPI-1kFK7y1S3E-00DHk0; Sat, 19 Sep 2020 20:45:11 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 06/17] hw/timer/hpet: Remove unused functions hpet_ram_readb,
 hpet_ram_readw
Date: Sat, 19 Sep 2020 20:44:40 +0200
Message-Id: <20200919184451.2129349-7-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200919184451.2129349-1-laurent@vivier.eu>
References: <20200919184451.2129349-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:+f0CKISPN4I8D1fl8jFmTnvM2m0WQPyQPUNg7uFBXkPVaL5b/I2
 nz7ZqSE4jViHlr8m/IKCRbFM0jqUWRH+tlZ0UHWx+rkGtm+yO+v8y2L8vivMq/cpcmrn0j6
 ElVNa10od7F/uF/dQJ/4Hu0kYij5dmYZ7amkRG8DFMRuSY66iLjk5YT5wb1CVkmqAufh/aL
 ld4BVLRtiz8X99O9XCY1A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:HJAjLwYZTO4=:gIEKMcDlBNpPAMTKHq8Yny
 w8QXeiYp/J+2/v2gLsR1VYSX3T4LMDfKjBwY/JHrTtPM64tMnkLpOiL5IDe0kq0yONu1DZl6f
 XzGwqrYtGYvGzaGeCzOiFQEPvVdyh930A2jo0gChyezjxKfHkdyl0m7fKTLvkShujyfv/+avQ
 pu1SLA7llw4PNlMeYo6C5nKKJCKEjbvGUoVnnnCtEv11XxU8W0NMqK1nLld+gqdZRlm5TW9Np
 yL9oqTIhY6Uj3YgXk0NjHcyQhkZX184rgjeL0cwRw/C1qUwCpMNRkm5swqaJ6n3/cgMwt9iCh
 Fk9Y7AYxCM5fKBmrM+J9ndmNjHPF6cidWu7ljRxtu0LiBr5XkjJ3dlK8gwUy46cP8X8V4N5H/
 J+p1o1KN+SAtj4M6ERimTcsdR47SXEVWI41/6MxPBp/ecX83qj8fwOnrIy5yaR+COpsYwIPde
 dsslxuf3e3r/Vy3Jhen27pGtxItLFC7VEClgpHPjprNsJMx15k8iyPY3KALJQnXQ05sHJJsgp
 KS0uI8r5imILUmdL6vAeBP+5JDqO60uY2JlkyTlfZ1YSqCm22TWKyCgirNfVvr0H2jVmQbpkA
 F98cUDVybyDEY138ZzDbVXeYBEBHXnB9mhe4dHBYRVE5b1UYfOXwNKcqYo0l2RBtcrRHowuAf
 2m26u9PDVImSc7H16n4cinqMeJjngJ8vjcJE8NcL4Tvk93rIXueWMBApwLV6R7Nla55PDgd0H
 +5ouY6PxT0P8NMlFTazj5gEQtJseD1U8xiqvB4oEXmlEpY5GIy+C+64f+fafcapg4UxPZ2IyE
 Z3twavIoHckkOIDL9df96oLTdr9edwECQCsWHyFR46UkUIkEV7jQuCRQQk5jsG7VLREHx7L
Received-SPF: none client-ip=212.227.126.130; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/19 14:45:03
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Dov Murik <dovmurik@linux.vnet.ibm.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Dov Murik <dovmurik@linux.vnet.ibm.com>

Fix compiler error about defined but not used functions when compiling
with -DHPET_DEBUG by deleting the unused debug functions hpet_ram_readb
and hpet_ram_readw.

Signed-off-by: Dov Murik <dovmurik@linux.vnet.ibm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200909083650.46771-2-dovmurik@linux.vnet.ibm.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/timer/hpet.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/hw/timer/hpet.c b/hw/timer/hpet.c
index 44bbe3a5361e..07ff82b33358 100644
--- a/hw/timer/hpet.c
+++ b/hw/timer/hpet.c
@@ -419,20 +419,6 @@ static void hpet_del_timer(HPETTimer *t)
     update_irq(t, 0);
 }
 
-#ifdef HPET_DEBUG
-static uint32_t hpet_ram_readb(void *opaque, hwaddr addr)
-{
-    printf("qemu: hpet_read b at %" PRIx64 "\n", addr);
-    return 0;
-}
-
-static uint32_t hpet_ram_readw(void *opaque, hwaddr addr)
-{
-    printf("qemu: hpet_read w at %" PRIx64 "\n", addr);
-    return 0;
-}
-#endif
-
 static uint64_t hpet_ram_read(void *opaque, hwaddr addr,
                               unsigned size)
 {
-- 
2.26.2


