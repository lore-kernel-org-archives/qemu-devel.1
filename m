Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C6A8C55179
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 14:58:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F3422067C
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 14:58:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F3422067C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kY9Nz-0001ea-IK
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 10:58:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51618)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chaihaoyu1@huawei.com>)
 id 1kY8sN-0001la-Hc
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 10:26:05 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2425)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chaihaoyu1@huawei.com>)
 id 1kY8sK-0005tw-JH
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 10:26:03 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CMSR55RKMzLrCm;
 Thu, 29 Oct 2020 22:25:53 +0800 (CST)
Received: from [10.108.235.54] (10.108.235.54) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.487.0; Thu, 29 Oct 2020 22:25:42 +0800
From: chaihaoyu <chaihaoyu1@huawei.com>
Subject: [PATCH] spaces are required in some places
To: <pbonzini@redhat.com>
Message-ID: <34e5417e-f81d-e399-ae2c-0f27467a5f43@huawei.com>
Date: Thu, 29 Oct 2020 22:25:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.108.235.54]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.191;
 envelope-from=chaihaoyu1@huawei.com; helo=szxga05-in.huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/29 08:11:09
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 29 Oct 2020 10:57:05 -0400
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
Cc: alex.chen@huawei.com, hunongda@huawei.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Date: Thu, 29 Oct 2020 22:01:33 +0800
signed-off-by: Haoyu Chai<chaihaoyu1@huawei.com>
Reported-by: Euler Robot <euler.robot@huawei.com>

While reading softmmu related code, I found some style problems. Some spaces are required in softmmu/memory.c
---
 softmmu/memory.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/softmmu/memory.c b/softmmu/memory.c
index ee4a6bc168..550cffe8f6 100644
--- a/softmmu/memory.c
+++ b/softmmu/memory.c
@@ -158,7 +158,7 @@ enum ListenerDirection { Forward, Reverse };
         MemoryRegionSection mrs = section_from_flat_range(fr,           \
                 address_space_to_flatview(as));                         \
         MEMORY_LISTENER_CALL(as, callback, dir, &mrs, ##_args);         \
-    } while(0)
+    } while (0)

 struct CoalescedMemoryRange {
     AddrRange addr;
@@ -329,7 +329,7 @@ static void flatview_simplify(FlatView *view)
     while (i < view->nr) {
         j = i + 1;
         while (j < view->nr
-               && can_merge(&view->ranges[j-1], &view->ranges[j])) {
+               && can_merge(&view->ranges[j - 1], &view->ranges[j])) {
             int128_addto(&view->ranges[i].addr.size, view->ranges[j].addr.size);
             ++j;
         }
@@ -834,8 +834,8 @@ static void address_space_update_ioeventfds(AddressSpace *as)
                     ioeventfds = g_realloc(ioeventfds,
                             ioeventfd_max * sizeof(*ioeventfds));
                 }
-                ioeventfds[ioeventfd_nb-1] = fr->mr->ioeventfds[i];
-                ioeventfds[ioeventfd_nb-1].addr = tmp;
+                ioeventfds[ioeventfd_nb - 1] = fr->mr->ioeventfds[i];
+                ioeventfds[ioeventfd_nb - 1].addr = tmp;
             }
         }
     }
@@ -2343,8 +2343,8 @@ void memory_region_add_eventfd(MemoryRegion *mr,
     ++mr->ioeventfd_nb;
     mr->ioeventfds = g_realloc(mr->ioeventfds,
                                   sizeof(*mr->ioeventfds) * mr->ioeventfd_nb);
-    memmove(&mr->ioeventfds[i+1], &mr->ioeventfds[i],
-            sizeof(*mr->ioeventfds) * (mr->ioeventfd_nb-1 - i));
+    memmove(&mr->ioeventfds[i + 1], &mr->ioeventfds[i],
+            sizeof(*mr->ioeventfds) * (mr->ioeventfd_nb - 1 - i));
     mr->ioeventfds[i] = mrfd;
     ioeventfd_update_pending |= mr->enabled;
     memory_region_transaction_commit();
@@ -2376,11 +2376,11 @@ void memory_region_del_eventfd(MemoryRegion *mr,
         }
     }
     assert(i != mr->ioeventfd_nb);
-    memmove(&mr->ioeventfds[i], &mr->ioeventfds[i+1],
-            sizeof(*mr->ioeventfds) * (mr->ioeventfd_nb - (i+1)));
+    memmove(&mr->ioeventfds[i], &mr->ioeventfds[i + 1],
+            sizeof(*mr->ioeventfds) * (mr->ioeventfd_nb - (i + 1)));
     --mr->ioeventfd_nb;
     mr->ioeventfds = g_realloc(mr->ioeventfds,
-                                  sizeof(*mr->ioeventfds)*mr->ioeventfd_nb + 1);
+                                  sizeof(*mr->ioeventfds) * mr->ioeventfd_nb + 1);
     ioeventfd_update_pending |= mr->enabled;
     memory_region_transaction_commit();
 }
-- 

