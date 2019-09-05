Return-Path: <SRS0=/Jg5=XA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47CF1C3A5A5
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 08:38:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B7FD21743
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 08:38:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B7FD21743
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5nHN-0005rC-Gw
	for qemu-devel@archiver.kernel.org; Thu, 05 Sep 2019 04:38:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33080)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1i5nAS-0007nS-Gm
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 04:31:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1i5nAR-0005pc-5n
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 04:31:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39818)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1i5nAQ-0005oy-WB
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 04:30:59 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 421FE3082124;
 Thu,  5 Sep 2019 08:30:58 +0000 (UTC)
Received: from thuth.com (ovpn-116-96.ams2.redhat.com [10.36.116.96])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 70B405D712;
 Thu,  5 Sep 2019 08:30:57 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Date: Thu,  5 Sep 2019 10:30:45 +0200
Message-Id: <20190905083049.11645-5-thuth@redhat.com>
In-Reply-To: <20190905083049.11645-1-thuth@redhat.com>
References: <20190905083049.11645-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Thu, 05 Sep 2019 08:30:58 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 4/8] tests: Remove unnecessary global_qtest
 references
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We are going to remove global_qtest from the main libqtest library
soon, so tests that do not urgently need global_qtest anymore
should be cleaned from the unnecessary references.

Message-Id: <20190904130047.25808-5-thuth@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/ahci-test.c        | 1 -
 tests/bios-tables-test.c | 1 -
 tests/ivshmem-test.c     | 3 ---
 tests/rtas-test.c        | 1 -
 4 files changed, 6 deletions(-)

diff --git a/tests/ahci-test.c b/tests/ahci-test.c
index 086811e602..c8d42ceea0 100644
--- a/tests/ahci-test.c
+++ b/tests/ahci-test.c
@@ -200,7 +200,6 @@ static void ahci_shutdown(AHCIQState *ahci)
 {
     QOSState *qs = ahci->parent;
 
-    assert(!global_qtest);
     ahci_clean_mem(ahci);
     free_ahci_device(ahci->dev);
     g_free(ahci);
diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
index a356ac3489..9b3d8b0d1b 100644
--- a/tests/bios-tables-test.c
+++ b/tests/bios-tables-test.c
@@ -626,7 +626,6 @@ static void test_acpi_one(const char *params, test_data *data)
         test_smbios_structs(data);
     }
 
-    assert(!global_qtest);
     qtest_quit(data->qts);
     g_free(args);
 }
diff --git a/tests/ivshmem-test.c b/tests/ivshmem-test.c
index b76457948b..be9aa92a61 100644
--- a/tests/ivshmem-test.c
+++ b/tests/ivshmem-test.c
@@ -100,7 +100,6 @@ static inline void write_mem(IVState *s, uint64_t off,
 
 static void cleanup_vm(IVState *s)
 {
-    assert(!global_qtest);
     g_free(s->dev);
     qtest_shutdown(s->qs);
 }
@@ -388,7 +387,6 @@ static void test_ivshmem_hotplug(void)
 
     qts = qtest_init("-object memory-backend-ram,size=1M,id=mb1");
 
-    global_qtest = qts;  /* TODO: Get rid of global_qtest here */
     qtest_qmp_device_add(qts, "ivshmem-plain", "iv1",
                          "{'addr': %s, 'memdev': 'mb1'}",
                          stringify(PCI_SLOT_HP));
@@ -397,7 +395,6 @@ static void test_ivshmem_hotplug(void)
     }
 
     qtest_quit(qts);
-    global_qtest = NULL;
 }
 
 static void test_ivshmem_memdev(void)
diff --git a/tests/rtas-test.c b/tests/rtas-test.c
index ee888676ed..167b42db38 100644
--- a/tests/rtas-test.c
+++ b/tests/rtas-test.c
@@ -14,7 +14,6 @@ static void test_rtas_get_time_of_day(void)
     time_t t1, t2;
 
     qs = qtest_spapr_boot("-machine pseries");
-    global_qtest = qs->qts;
 
     t1 = time(NULL);
     ret = qrtas_get_time_of_day(qs->qts, &qs->alloc, &tm, &ns);
-- 
2.18.1


