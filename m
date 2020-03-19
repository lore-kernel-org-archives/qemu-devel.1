Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1265CC4332D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 09:27:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB19A20753
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 09:27:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB19A20753
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35240 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jErSt-0007EH-16
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 05:27:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40910)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jErRw-0005OR-UE
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 05:26:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jErRv-0004De-Lh
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 05:26:48 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:42449)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1jErRv-0004DF-CS
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 05:26:47 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1Mae7u-1jppp83Dcw-00c6Sh; Thu, 19 Mar 2020 10:26:36 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL v3 08/16] linux-user: fix socket() strace
Date: Thu, 19 Mar 2020 10:26:19 +0100
Message-Id: <20200319092627.51487-9-laurent@vivier.eu>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200319092627.51487-1-laurent@vivier.eu>
References: <20200319092627.51487-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:T0Pw2XAbqF+FRnv5/5E+PLfpIAGQ/mjGE631hQ6KfqEOPaXO2Bo
 mzgHfPnLrtAYJEFW1X4vch5ewYklfLAgjDId7u6k/5MZia3Dj+AcGQyMk5hZIXYFyTaLigz
 BwajaeeB6AmD6kr27Ru3w6USZ82uCQ2dewjPiO+UHIbFZK6+3sFbNqVHqZjVl+k0pSqPgwH
 7QFDVq0F8HoU+YpT5+dew==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CyOx+EHhtSU=:sr4B/5yQ6VXdbApVpeyTTM
 9O26ZtUXxUr+T9uQWC+wUH3GRmFzjoraHWFuzYzCjeUayOo0MGa3/owd6S9NNC7fyaW4eOvoW
 cmSZVGhRztE4Saq2P76DzZoyvvUo17b8YefyB3ch6Qwvtvyjvvkk5YopxIcP5mSmr7Zjv2Oqe
 H12c/v3VF3czFtL/q5wmFVfiW0YaydcSL1vICiwXz+eFUwUVNME0km69vJH70VjCZWWnuz6/e
 jgbHbzeP2FD8uvRnnqFTR4/LV+hggQNFh6PeHiyF+ejxGB8pTuqh2uZoRY8kwBGmiCBFImlp4
 KXn+UgU46kwFUwAIu70V+IbHadcVN1Oxl4wyMywEo/6cx/X9WxJPoeKMykthQFjLorp45sVbK
 E6sj233ruPcjL5PKa5QphuAR1VuKvAd9nX6oNG1fnNfGFLm1T5bfqktUP7q/XgHj9/pQKoOJ1
 +6VQ6MU8p2jEhbwEXPq6eVNx/rdWf0FeJOYjdHhsLb+yRu77tmLci7vBidZmuliDVKME3YbmY
 Nq9m0W+NOH6HJ9UMmQsBzcH4kYIU7HEmP58pNHKG46YdMz3bZSBrBt9RfM/v8jgGyi/UDnyfp
 WDagEgAvesaFHvHBJN5HNeJ/jSvS+HkMnB/qe5Z+tOsWK3fz2EKswB7dFywVNQ1qO9wVfyPLI
 f2gFIgwmkCTnBeX8OgimgbIsreN6+mARU+j2dY191xhoua3MEir8HYLYNM1+9pFfLHSkwLCQY
 Qwvp4Ik3llYqWHxE8KjMMNIy9vErkG3KJ7k+92e9fso4IeMEXF4aJRcA4R/PnFBnppgzwCZzC
 wLn5TrjZocGOVu1a6/QsHNHhwH1JL2Z/ixBeXvEznHxANdo78eGfsZC+lS9RD2OCZljRegL
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.131
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


