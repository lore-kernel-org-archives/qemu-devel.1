Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E0CFC3404B
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 21:33:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03DBC2173E
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 21:33:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03DBC2173E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42120 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4AUN-0005jn-4l
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 16:33:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56942)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1j4AT1-0005G6-TE
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 16:31:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1j4AT1-0007ym-0s
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 16:31:43 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:46895)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1j4AT0-0007u2-N0
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 16:31:42 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1Mx0VH-1jOqdw2E71-00yU3y; Tue, 18 Feb 2020 22:31:35 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PATCH] linux-user: fix socket() strace
Date: Tue, 18 Feb 2020 22:31:31 +0100
Message-Id: <20200218213131.907655-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:pTUrIo67Ly8It6wQ9cb6x0oTCZnTvG8px37HdfAFvr/2GDSJ2sG
 GP9US+Clte9+p9MNPw4aYLZ4KGdocxpJl7qEG8E6hj5SkdkoyB6ji1/KTBiH8Jasn5GlYRM
 5ovho6CdCU/X3avp4ylfTXPRoZDprSN0xNfDIbeojPt9VWVwWp31orxB3Rb6o63yYFvAq3V
 04p37M9Y4AGN4kV0zPDoA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:cUw9oVG7O+E=:HCD1s3LZwdjPvLTffnLBHQ
 M44wKgPGbBU69kR0Rj6OEEK/BHWvLCPf78H6FvDv8rJv0QhjdsyvkkA20wrJVzOghS7b7XYcO
 bcyH4cXtI60wEQECNJ2Mx6cvVrxthN4C4wKomCTt2sKTUw0xdomVLJ0cGZRryylRp7Zw7Ic8w
 9L1yCyObZVqqePJ7JOI4GIaakeQI0f+6Wb3H17yia/emqh767KcSIte5lsu5mvJX4XdJ9p0df
 N757XShe4ZlJ6hzC9cUjtlxtW1s05gK1V1lO+29GKXPJXZLhcNW8RO4xkfZGpnCYu0Knwsm5H
 kGq/R77QUbx1mMVJ6wp8w6Y1kieDyBIaqOqV48Ps7M7c9YS3wC7sKMJbNb6H/etHXidVL11wZ
 cM3jsteMnjT0ogR0KgDbugSBGrEW2HAGlnJSF1xQtpLSSyp/eusnEscj5QEf1aqKz0jZ8mhpj
 IQTZo7Ymp78nq7Qi+MKnAJ9RjF/Oqc0lTEPsxpjkt0S6NFhlnnqd3zc0N2dO7UV/QcfYy6pVA
 0TNrjMm8pMWbuUcJ/UU/oOrzDfw5wTpzgrWxlbxMw4dKGfzw0tW9OSna6Ryxlfwhn4r6QYya5
 F1MQRPhpn9AGEsH645Cpl3GUHuCWR8X/hixnhPLES4II6cdUYNiai9kuYLsUwluF5g0XP24rA
 wksKXuZNKEE6JnXsA2MnA0o6WK+X10EQTj2VJOyXELCcNyctJawajDjOQrCSuySbBoLdH/MOl
 UFGBwt3Lr0iv8RDfu2e1NgleCOmsVUSnR+zwj2hCy4J9Nrf4L3cmuk1XzRnV+YJ5wFlx9xXNr
 RDeiSEAHDxzEcvnH1xlLZ9wuD9xrvEiNCvdwRC0igX/iHntvt/ZQqbrml8aV1vT/aD9jffc
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.187
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
 linux-user/strace.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index 4f7130b2ff63..bdfc5177555e 100644
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
+        gemu_log("|SOCK_CLOEXEC");
+    }
+    if (type & TARGET_SOCK_NONBLOCK) {
+        gemu_log("|SOCK_NONBLOCK");
+    }
 }
 
 static void
-- 
2.24.1


