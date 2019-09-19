Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAB97C49ED7
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 14:06:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5449214AF
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 14:06:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5449214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAx4y-0007Zv-8l
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 10:06:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51677)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iAwx3-0007Ju-8T
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 09:58:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iAwtZ-0003iP-Dh
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 09:54:54 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:56749)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1iAwtZ-0003hQ-4m; Thu, 19 Sep 2019 09:54:53 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MzQPe-1hxhL10WUC-00vTB3; Thu, 19 Sep 2019 15:54:51 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Thu, 19 Sep 2019 15:54:42 +0200
Message-Id: <20190919135443.15164-8-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190919135443.15164-1-laurent@vivier.eu>
References: <20190919135443.15164-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ylawjwZlxVZ4xVBU3x9HCZaGo5YuJfOAOxnCb0ZVuv0AJoxjbkz
 U8Cgosd3FNVmqSUgJGzNTjaNJ8S9Cy9Q37FYVsyMxeLuABZ7wJrxOvdt2H8v04pnSnZBjf3
 2oeYXSo9uuv5b05Z0xs8XEzISF9KzYMpzPI1jn5LvdYZFIilLb29PjbYl8Y3w/5+n8X0l8k
 p/Rw0O3cLaujo5xBZ7V5Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:EXKRn/qhaHg=:JDyOyegwVGoyg+O/cBdeu3
 R+IKDxm9Jbh55COAbIORwLTccQKnAr7RGAkvqsrXq5bk2HM+NzxB6CCjaA2SYB846Imsgszpl
 eiRmLUH9v1tvTXv98zG7rnmbGx8C1uHmhA/O4/BQdn1siAUKbTzn4nCbW8ddbp0kW5CxhH2Vn
 LPj+4TElH91zVlZhjaA8nyizQFqZA3Og8BKRInEQkminx3ZG3H1berIUnYUWHfefiGlQ/FtIC
 av0m0RhuVah1asidfG4DgtlGGSVTuTrFqIhhSDyGZd3VtY6INChH6ffCyuUgj4Rwd0TVB1l4v
 dR3AHVRBDDCUKfEuKtAq+ACSlSul+zMl6e7qgPY2Zu+Cb3p1jrbtDnMcqOrR7QDMXeex7x45i
 4GrlsYxERtwSCK+r5Edza5B3kiSl9w3diqRhKONnBOfKCwrx8moDrZcTBri6c3wGo5TTLy3WE
 uY/M7h8nIJV/G3ygrlvww9mvZ3aTeZT9wbdgsYo096deFGFTJeeT9H0MCBEwRRUOri6IuBa+4
 13/WsNb4V48LxhwoCwuGQHgq6XBZGjZVpNEe+KDBfEnp4pGHWTVZ11CS+xlbgevvVnHeZH6ep
 MRTs98zXMfqpEJ5ntwGUxJZyYxTvaB/ZhgSFzyb7ww8IrQu3RVx2QtLNwYdhQ0zd6+ISTAcmG
 V3zowd1xG1TEhOKNyCalfgOTWIqwOmQjqjCwbodauZ/Gq9Ni8fIjV6SW/zKhx9JQgB8fXrB5K
 SMeAx/7mEajIDHbD02spVpE8PCnnBkwyfV1X1dPCyux6loHrrtZf0jxrtbHVHP+FgqYpVnXv0
 2AsirqpTc8coVUde7XoeEtsQdZuxQhQUtCaR4kQSVchDRkLLHECmY1QUcXtpMlyQUa9Dh2yuv
 az8fqaNrdnYGFfiYeWUQ==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.73
Subject: [Qemu-devel] [PULL 7/8] kvm: Fix typo in header of
 kvm_device_access()
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
Cc: qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 Laurent Vivier <laurent@vivier.eu>, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Greg Kurz <groug@kaod.org>

Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <156829664683.2070256.13400788010568373502.stgit@bahia.tls.ibm.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 include/sysemu/kvm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index 909bcd77cf82..fd674772ab31 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -308,7 +308,7 @@ int kvm_vm_check_attr(KVMState *s, uint32_t group, uint64_t attr);
 int kvm_device_check_attr(int fd, uint32_t group, uint64_t attr);
 
 /**
- * kvm_device_access - set or get value of a specific vm attribute
+ * kvm_device_access - set or get value of a specific device attribute
  * @fd: The device file descriptor
  * @group: the group
  * @attr: the attribute of that group to set or get
-- 
2.21.0


