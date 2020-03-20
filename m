Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 968D8C4332D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 15:25:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E7512072D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 15:25:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E7512072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54192 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFJWb-0006s1-Hd
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 11:25:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57801)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jFJVZ-0005Ib-R2
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 11:24:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jFJVY-0007UU-TN
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 11:24:25 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:54219)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1jFJVY-0007Tg-LD
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 11:24:24 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MnpwC-1jdv0z1jT8-00pLPs; Fri, 20 Mar 2020 16:24:20 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL v4 03/32] linux-user: fix socket() strace
Date: Fri, 20 Mar 2020 16:23:39 +0100
Message-Id: <20200320152408.182899-4-laurent@vivier.eu>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200320152408.182899-1-laurent@vivier.eu>
References: <20200320152408.182899-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:yxnzI9EYV6zAR6V6lYODWVrjh3HQYvpZ7N/VUa3Q3VJ+lJMlock
 paswI31yuAh77mEpdHPHWSao+BGmGlnomEyjsxqoTQXSTcdaxBLnhiJ5E64eAYKKw8Br+hY
 EnzaZDvt2ji5lN3/v56w24UATbkfVaQH/dKO/pgYbJ1bDWk0RBtXF4BfsdZ0ZB6m/Vc+qWu
 Md/ESIi6mtYpdS/MN6jkg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZJxNRXW50ys=:+x25o3LJhkiSxIvw2AeOYi
 1Ak+LsbxVEzbtJojyjyEU9tU6AAxaV2h8qtUv0PJFInX8cDlGW9AHk8QF3J1/h6yeK0HARp4J
 /F9rsm4ArHJYRqteVJ/dbvNK/p8q5JRqHexzJZwWXyewWD0SveMqh71/hkF+T14vVY5j6/2tb
 6GINbtBXxgh3WZN7pc49DRc9OfqtBieXqh+nr6oUfC+4tnZIfOUcVWYTCdws29eyLnSo1nnrQ
 gv3YiR4HauRrPqftU3sOssCPoKBxNidh8syTUkDrxarBqecIK9JL5TGEIwb/EFCU+JTyqZKJR
 utSISLpq+jWK8xsetADYifg1fPmmh/XFqtW6zi2BkOciKj0EUyejP2Ptp387UIGiHsxAiewr1
 OpZ8spRRHRxNd5dOQHcAodjXpZbT3t4kbv1k4ct1Iq1rT0WRnKb5kkU2wLPbE7ELUerxThsu2
 9eoZVaiiA8xYglcPPbLzwnBmHLPOcuJKOAZkmX/+Cj/P8tC9YVRaT+H3pERIgqMdMH/h3iW8Y
 MVjOCrLafhg5GJlxzqCjxYfQ4fGRuctZoPKqnxK5X0ZcZIN8Rdx3iSvPCnE01SV3ZlxSiRvlm
 quJoE27LtquuEdJwz55JYEF+2DhshCGtBNIZNOSH2zc9GFaQCTUt82QU1+fiXg77zdG5sbCeJ
 4q29h4K5EerK+WpDr9lYbuceJp+Fm9CCn+gR0JOsZ/eTt8Y8Ndsfdwk/1euWZu/T6gaL8hqi5
 veNp0cTrbRGCI5CC+5OnDYru5y2o3GLwm2wQMbFpoPfG/zHVosUXHW4cv7rHvMkplr+6AdNE6
 Bp7G4Vx0cWI77L29Cm84N8MWS9iiMe8kzJwhOwL1CB5vwxonHzNHYfn4KLK4wdiuDUkF57u
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.13
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
Cc: Riku Voipio <riku.voipio@iki.fi>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

print_socket_type() doesn't manage flags and the correct type cannot
be displayed

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200312165530.53450-1-laurent@vivier.eu>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/strace.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index 4f7130b2ff63..69232f7e27b8 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -444,7 +444,7 @@ print_socket_domain(int domain)
 static void
 print_socket_type(int type)
 {
-    switch (type) {
+    switch (type & TARGET_SOCK_TYPE_MASK) {
     case TARGET_SOCK_DGRAM:
         qemu_log("SOCK_DGRAM");
         break;
@@ -464,6 +464,12 @@ print_socket_type(int type)
         qemu_log("SOCK_PACKET");
         break;
     }
+    if (type & TARGET_SOCK_CLOEXEC) {
+        qemu_log("|SOCK_CLOEXEC");
+    }
+    if (type & TARGET_SOCK_NONBLOCK) {
+        qemu_log("|SOCK_NONBLOCK");
+    }
 }
 
 static void
-- 
2.25.1


