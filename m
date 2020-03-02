Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55303C3F2D2
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 13:09:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AE5C21739
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 13:09:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AE5C21739
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8kow-00085Y-8d
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 08:09:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48766)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kuhn.chenqun@huawei.com>) id 1j8knl-0006GT-6H
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 08:08:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kuhn.chenqun@huawei.com>) id 1j8knj-0003ON-UT
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 08:08:05 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:51758 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kuhn.chenqun@huawei.com>)
 id 1j8knj-0003Mj-IJ; Mon, 02 Mar 2020 08:08:03 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 326837649F9E2992C69B;
 Mon,  2 Mar 2020 21:07:58 +0800 (CST)
Received: from huawei.com (10.133.205.93) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Mon, 2 Mar 2020
 21:07:52 +0800
From: Chen Qun <kuhn.chenqun@huawei.com>
To: <qemu-devel@nongnu.org>, <qemu-trivial@nongnu.org>
Subject: [PATCH v3 11/12] usb/hcd-ehci: Remove redundant statements
Date: Mon, 2 Mar 2020 21:07:14 +0800
Message-ID: <20200302130715.29440-13-kuhn.chenqun@huawei.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20200302130715.29440-1-kuhn.chenqun@huawei.com>
References: <20200302130715.29440-1-kuhn.chenqun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Originating-IP: [10.133.205.93]
X-CFilter-Loop: Reflected
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.32
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
Cc: peter.maydell@linaro.org, zhang.zhanghailiang@huawei.com,
 Gerd Hoffmann <kraxel@redhat.com>, Euler Robot <euler.robot@huawei.com>,
 Chen Qun <kuhn.chenqun@huawei.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The "again" assignment is meaningless before g_assert_not_reached.
In addition, the break statements no longer needs to be after
g_assert_not_reached.

Clang static code analyzer show warning:
hw/usb/hcd-ehci.c:2108:13: warning: Value stored to 'again' is never read
            again =3D -1;
            ^       ~~

Reported-by: Euler Robot <euler.robot@huawei.com>
Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/usb/hcd-ehci.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c
index 56ab2f457f..29d49c2d7e 100644
--- a/hw/usb/hcd-ehci.c
+++ b/hw/usb/hcd-ehci.c
@@ -1301,7 +1301,6 @@ static void ehci_execute_complete(EHCIQueue *q)
         /* should not be triggerable */
         fprintf(stderr, "USB invalid response %d\n", p->packet.status);
         g_assert_not_reached();
-        break;
     }
=20
     /* TODO check 4.12 for splits */
@@ -2105,9 +2104,7 @@ static void ehci_advance_state(EHCIState *ehci, int=
 async)
=20
         default:
             fprintf(stderr, "Bad state!\n");
-            again =3D -1;
             g_assert_not_reached();
-            break;
         }
=20
         if (again < 0 || itd_count > 16) {
--=20
2.23.0



