Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEFA0C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:32:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F377206FA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:32:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F377206FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD7LD-0002lJ-Iw
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 10:32:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55640)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kD6za-0006B3-8A; Tue, 01 Sep 2020 10:10:34 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:39751)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kD6zY-00040U-CR; Tue, 01 Sep 2020 10:10:33 -0400
Received: from localhost.localdomain ([82.252.135.186]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MWAaw-1k5uuj3tyk-00Xd95; Tue, 01 Sep 2020 16:10:24 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 39/44] vfio/platform: Remove dead assignment in
 vfio_intp_interrupt()
Date: Tue,  1 Sep 2020 16:09:49 +0200
Message-Id: <20200901140954.889743-40-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200901140954.889743-1-laurent@vivier.eu>
References: <20200901140954.889743-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:lsDR0dEHCtExKSd9N3oIN428thZ82nBF4fKg8HBPzQNzaeOTCIY
 7Bs0o+KvIhLj5toScUInS9nf7Aez3cWSEI6dPi2r4HpR68D28Zq1zXbCn8jhFFkKFKVX2iP
 NWuGBRINpnAdiONWZf/i/dj7KkcoZ/LHchSm6y1vAcdg9gMI/Ufc1hHRjLu042SOEx0l60E
 SPjxYrZqSM0+GkZRpyhtQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Jdfz80TC3Hk=:UQy0koX5hT1Lb8VX/HsC5e
 kqORgrLW6dYbqBg8lvU9dChVvVnfVrLYrIiE3BGp/m+5DJk7e6+pqWUldwOvAeMPnjhZ1nBRa
 T1w6mF+tB0B2ytkPys5Gs5aIDnSJChFDxj7AHV/IjgDMHgKDoRWaBOOdtlNgEDfa3k27tMtdi
 2VUdySM1x6u84yYuHar96QcxUp5kWOhKGspoKDYYC9ZCwl2L9XmTrLq5OduTULz/7askIhs/4
 +Z/q1lX6a+2eIPPw7Wb1UzfAPavxdtAcuRVg5qnUxFd2FCtkons/o3tKm/x0gk4U4b+I47poO
 zTGRqzbk1VqVONaeDj0XpJrOAZzQBMNfEV3X8w148usu59AX8c8ZBrhvsGIkocag7PZGo76lG
 vpuZIbJh2ssNzMzsrV0neO/IJqIGVUjDq19JdlJL9t3jmWkZ5PlaBY+Ct1tdJ8EHgfArO7C8l
 LFO51FIUP4c0lYhe4tyv8nkvQ0R0EdjWAK5sMVFPear70M8lqzw4TfczgzoJS2UfGZmwrFaKa
 uft+a0SucrfSrAkcqIg8GrNv/5O/+se2bQSM98lp7JHdFkmwN72CNtiK/sKEszfSaoHLFXqR0
 P3zCub+IRdNdVueXaSzHLVV/xWfcwv5qf4vFsRfo/ixLIZzyctSnXt3gMEAY6+mA2r5ek5l3S
 moPUpY4d96s6/ZPiKeoxf36c0eUlhWZ5K8BXbjnUsWuGkkWzWgnhnD1CmJ5Vv3Sq2pfX5Vg5S
 nhAdh3Ku5rk2wEoblZ/pTheJZmzuBTbOmal1B6qNvpWJzunoJKUD6JNxrB8a03I3m4N5L7+gh
 j+18nEtBL3xh2nady720Pc8CFmDGY1Z6HYmMWMINTZKQfgXkvnvgVoN+yB1i52hienGdyBs
Received-SPF: none client-ip=212.227.126.130; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 10:10:08
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
Cc: qemu-trivial@nongnu.org, Li Qiang <liq3ea@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>, Eric Auger <eric.auger@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Euler Robot <euler.robot@huawei.com>,
 Chen Qun <kuhn.chenqun@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Chen Qun <kuhn.chenqun@huawei.com>

Clang static code analyzer show warning:
hw/vfio/platform.c:239:9: warning: Value stored to 'ret' is never read
        ret = event_notifier_test_and_clear(intp->interrupt);
        ^     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Reported-by: Euler Robot <euler.robot@huawei.com>
Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Li Qiang <liq3ea@gmail.com>
Message-Id: <20200827110311.164316-8-kuhn.chenqun@huawei.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/vfio/platform.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
index ac2cefc9b184..869ed2c39dcd 100644
--- a/hw/vfio/platform.c
+++ b/hw/vfio/platform.c
@@ -236,7 +236,7 @@ static void vfio_intp_interrupt(VFIOINTp *intp)
         trace_vfio_intp_interrupt_set_pending(intp->pin);
         QSIMPLEQ_INSERT_TAIL(&vdev->pending_intp_queue,
                              intp, pqnext);
-        ret = event_notifier_test_and_clear(intp->interrupt);
+        event_notifier_test_and_clear(intp->interrupt);
         return;
     }
 
-- 
2.26.2


