Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D540C10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 17:18:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E27D2067C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 17:18:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E27D2067C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46412 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCRTI-000569-ID
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 13:18:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37485)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jCR7T-0002DA-N4
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:55:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jCR7S-0003SS-Km
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:55:39 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:47953)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1jCR7S-0003R9-C0
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:55:38 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1Mgvev-1jpMF9276T-00hLz3; Thu, 12 Mar 2020 17:55:34 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PATCH v2] linux-user: fix socket() strace
Date: Thu, 12 Mar 2020 17:55:30 +0100
Message-Id: <20200312165530.53450-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:S8VBigd0/pfnZuC1hFc18/4bvMs6PXJ6lf+oPtaFy8YD2L1eQYO
 AYE68kjRW64/v/CInWp87+LDb84B5FFQQe2cz9ZOUjRKglTSJsoceJ/YvNeRhaXeusrRqDx
 k8eO5DJD8TYiFFhE7V0D2ZF9aILPZ0sTkrnhRPBclQ+9ctUBxw66aWHIkoRFzC1V0gefhvh
 Szp9eV37s7DlkqUcvVNug==
X-UI-Out-Filterresults: notjunk:1;V03:K0:U70d+VLByeA=:Z+B5d7u5C+bHRc2P4xcqh8
 tb2ovQnjd7PwU07wtvY7e9I/Akbyx4htJKp4aWDhOTA5HveY0ko4DTpkjGj2Iw8M5a34bO2wH
 Q02CsilPn/qqv/uemeV1S3BiYWckEC375ZbxmYgVYoMFgmh6xOWiCmYN9RcNJO/YuHlG7pDvn
 NZC2NPpKKr2hKRG/iMUrAE7ZcLDRkQj7/S6+QYtpjoiZ2NxC/+4WgHoBH8n7t5KaN/FV58raz
 ZUhy91afj8/Vdxj89Y1KmfaOu4U0fIdrHcVo1wOqgX2Rj/5cdFta5IFhqZ0o8NwWNeCDUJvM8
 EvvFi9QCSE44R3AByjKkRxM5VWS9djaClMF8GmeVT05EdrOB6iG6gxioVbIyVPWXc2ahv8Yt0
 AxeuH1WHnGiZK8wzCWnu6bKpjcruY47R2t4j/HpKrSkis5YGSySjgWRAGVZ0ZHKgKZh8ppt2n
 YRviOP1ZfFyHNpudJDxX8zk4WuMpbNn18U+ObN+bieD+XNnC5nWU99Sry/Goed6dyinT50p7S
 vyn2SLe8DkpjbHxeESHTTkmashBADSSi1LUhSLGSQzhXg9S8/JfRrRTLzfoYvwS6U0klUz/3M
 UD8xCvkDsHw6wN4NQM90HcgJmEkYn/fUumYOZApxF/dvuZgoHW3bpfdjGKq8ixLMAHPuOJ7Ie
 /7MydGqGKA5v/ui9zCnDjMjJE6dlQGZ7YtvnYJxURqCBR1Esl3uaRllUUQVKmjPl9OZZvUW/F
 tHDmoq4nP9nupf5a4vJfxR85J2FR9gI7+FIaR8WoLZYdfdpzdjcd4PuoYm1Cqe1fzXh8znY/5
 fOk9tSTeT/tpn4n3hDHqb8Wg5V/DLoQsbCkPOhQnNsZFQSRc8yi4tFUhSptP2fel7p9U4c1
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.134
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
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

print_socket_type() doesn't manage flags and the correct type cannot
be displayed

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---

Notes:
    v2: replace gemu_log() by qemu_log() as it has been removed from qemu

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
2.24.1


