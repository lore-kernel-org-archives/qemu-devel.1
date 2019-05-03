Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76F52C43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 11:44:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B0382075E
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 11:44:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B0382075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38763 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMWcG-0006sa-IZ
	for qemu-devel@archiver.kernel.org; Fri, 03 May 2019 07:44:36 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33820)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hMWLb-0007fy-9Q
	for qemu-devel@nongnu.org; Fri, 03 May 2019 07:27:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hMWLa-0003Gq-Aw
	for qemu-devel@nongnu.org; Fri, 03 May 2019 07:27:23 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:47175)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>)
	id 1hMWLX-0003CW-Ua; Fri, 03 May 2019 07:27:20 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
	mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA
	(Nemesis)
	id 1MAchM-1hT5vZ258q-00B4K0; Fri, 03 May 2019 13:27:01 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Fri,  3 May 2019 13:26:44 +0200
Message-Id: <20190503112654.4393-3-laurent@vivier.eu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190503112654.4393-1-laurent@vivier.eu>
References: <20190503112654.4393-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:8SpV5q+wuYzAk9ypmqbApsD5yPUlesepmLhhH0Wesf46hT4PjrH
	63DLXxROIpeIrnMMLvoic81JGuRHJDvZlKR+5HC8M1kwZCojtpG57sTrkELWILiisw3B8OZ
	0KIr81YsL10QL3OeOqFB6s+A7ZQ3VgPKdd6tHdhpJFSZrspCqG50XTccLkO5hWw85IqCsYG
	uNlPx6EMD0m9yp9sK44bw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CNCT3k0LTiE=:mRpjnw/f8AHTlQR1hwcNBO
	MwCJvMSwg6eqJa2lx7mm+mwKmJgLbzq7v/rEx2NJk5sANBAUMpJ7RkEBIFW/pkCRzzRTnsN9G
	khOLByfBfaT2OeTsCNNZA1+mrdGEGpuuadS5dpK44VFWUrQlQTSfMfa92YwzMVzxBPTh0aF9R
	pYKBFjqLDhBs0sb5o3OCHamnVoslq2bxbdj055enId7ny5/Bzi4yWoGc1NgcKEP0m0Ax2hC4A
	cZhC9uBfNIRCf1X+wriaIn4yj46orU6hsvKXnD9RZ/3h1VfmmSnY9cbgLoVVp09XxxK7/RQWA
	XGClr6A1NQ2vkw5ZetMENXpoIQVFiwftVgS3TTu+qAEV/Q2LoS/sGk7/KjQvGpaetn6+Jl6fp
	h19Ht6f/Fa05cccuVN4PFIjxwMEmvfvrAfxt8xEHuldYyNsLV4g+CmS0qbWpydNx7MkHoSt9V
	vfm3ZWByn3QS8AOt5DAzGDZAJIDt8w1K20TOY7ERbRFQ1rqGiEVD1LgKGnNcx+/kj6/GaSuo+
	HHQ5kKeh8fu2f2jn1gnR4v1ZDKefc+ApUwh4rnQSjehbvnc8oqHvlJ1y1jxP9QwyJ8+SmXVjh
	6KlF5j2xUi/SJCAHjS2n0mHOghIpY0+UbkzeKo8l87CBeSqxk6Nj7Ag20Jw6xelmZ3qmcfFmO
	p72l8U+/2p6OTdg8nsyT87LTRRyTdAO9Z+xyOgtzaJjjVu8gobj/NLOUPMvxZl8VxDOr721F/
	hmMMBAMbKSYEXKBa0uvwJzYnU2qQe8jYFuxNBg==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.131
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
Message-ID: <20190503112644.ntXOG9GMBRsvVr8PdFLXpZUaugJF7XQmjSCAwROQ9vo@z>

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


