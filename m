Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6DD3C43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 11:21:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA396206C3
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 11:21:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA396206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38352 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMWFt-000147-Sk
	for qemu-devel@archiver.kernel.org; Fri, 03 May 2019 07:21:29 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59408)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hMWDv-00085e-8h
	for qemu-devel@nongnu.org; Fri, 03 May 2019 07:19:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hMWDu-0001AX-CI
	for qemu-devel@nongnu.org; Fri, 03 May 2019 07:19:27 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:35825)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>)
	id 1hMWDs-00016N-3p; Fri, 03 May 2019 07:19:24 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
	mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA
	(Nemesis)
	id 1MmyzH-1gvwtI32mN-00k80g; Fri, 03 May 2019 13:18:59 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Fri,  3 May 2019 13:18:22 +0200
Message-Id: <20190503111832.30316-3-laurent@vivier.eu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190503111832.30316-1-laurent@vivier.eu>
References: <20190503111832.30316-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:YZFnRmL1uAf+BVo5uQl59oP3wQVC+h9qdTXynIc+JHl4Ea/oGtH
	pkFj8BCrKy8Pxn0Q/FUKynxvnUnvZLD7NdjP5NdiuZazfWHK1Kuu3+u3DwadF0m1tIydvOF
	ThWtcKfebQXpbw+KNDEZLmawkANecvLH5TYaDxtCClxD/Kyow6CkffI5n7dh/u6cM8flmvE
	1DIuNi6U9+ROC0zyuzAAQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xpfLY+SdAms=:O8IAWir5NvTSlUDoXRpgr+
	en6y5E06+Fu/l/K65sJ8Lwp2hcOFJhIGMZBluQ+DfLdfIkq+GYxjnbtsBAekJyLq3uHZOAT9O
	XL7P+nWR/OZny1ToU5u/SX6k/x9aMU62Hk2PsSXxQoy2Mq9fk6rDsajFf+gZJNS31MwshO0Bv
	pu7BQtoK/XJxoY35vqM5cWgeavkcaPTRa4kt571ffNL92hiuOWSUw86MTzJeBOPiJThgDFARV
	NAGpHQK+FuH53E4XrDOMDh92u/5d7FO9LzEwVbuWLWR2W3/CwWTXOzVwQJBmG2oIL4Hx0U52W
	KjGz9ceezipZ6B9pKHkFzEZVhvV9hbokB7UTN57aIfLJZHSpWnk2gm1m0AJ8lG2JAd0Kr6/mH
	K3YVHTpsua0nwaFq7YikKRHET89eXILHvEAtEvqgH6q6JA6P9OUU/1YHuvHp8DG4abxADfwB2
	NJKRM1dU1OL5PB9z0TJuOm3gMb9C/6mghYpiXwu/+4MXzLqz4yrNdxhLzR+Dcps6LSYi2AQXn
	/RtdlS4/UiJwr0SfDLakxEgUGTrqEqxm1uMT0Z3TFFxtiQLnggPt+Wj8fG+bBld0fIS3jyN56
	7z0gIh60Q+4RTkqvUkJoUfGH5adApcPVJpdJFupc384bNW8LARIRKsgCHdEAOpApq4XqEgJ+e
	SylsbZK505U5WWNIOLdSKetGJ0rRIuxAnb2TphQETmEhtGLxZWXiSoX1YMnz5yfzgxGdKCB5y
	MKvKJ0kq0jQQBsfatV+ZKyXLBvWNVemUcuNZqA==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.187
Subject: [Qemu-devel] [PULL v2 02/12] CODING_STYLE: specify the indent rule
 for multiline code
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-trivial@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	Jason Wang <jasowang@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
	Laurent Vivier <laurent@vivier.eu>, Fabien Chouteau <chouteau@adacore.com>,
	Michael Roth <mdroth@linux.vnet.ibm.com>,
	Wei Yang <richardw.yang@linux.intel.com>,
	Gerd Hoffmann <kraxel@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	=?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
	Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190503111822.eIas0I-yEMEQXqJ9GXgPGlReK-xyTHOtA8a3uJTdKNk@z>

From: Wei Yang <richardw.yang@linux.intel.com>

We didn't specify the indent rule for multiline code here, which may
mislead users. And in current code, the code use various styles.

Add this rule in CODING_STYLE to make sure this is clear to every one.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
Suggested-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Message-Id: <20190304071631.27567-2-richardw.yang@linux.intel.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 CODING_STYLE | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/CODING_STYLE b/CODING_STYLE
index ec075dedc4a8..90321e9c2821 100644
--- a/CODING_STYLE
+++ b/CODING_STYLE
@@ -29,6 +29,45 @@ Spaces of course are superior to tabs because:
 
 Do not leave whitespace dangling off the ends of lines.
 
+1.1 Multiline Indent
+
+There are several places where indent is necessary:
+
+ - if/else
+ - while/for
+ - function definition & call
+
+When breaking up a long line to fit within line width, we need a proper indent
+for the following lines.
+
+In case of if/else, while/for, align the secondary lines just after the
+opening parenthesis of the first.
+
+For example:
+
+    if (a == 1 &&
+        b == 2) {
+
+    while (a == 1 &&
+           b == 2) {
+
+In case of function, there are several variants:
+
+    * 4 spaces indent from the beginning
+    * align the secondary lines just after the opening parenthesis of the
+      first
+
+For example:
+
+    do_something(x, y,
+        z);
+
+    do_something(x, y,
+                 z);
+
+    do_something(x, do_another(y,
+                               z));
+
 2. Line width
 
 Lines should be 80 characters; try not to make them longer.
-- 
2.20.1


