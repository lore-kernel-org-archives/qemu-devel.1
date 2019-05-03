Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42EBFC43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 11:33:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 164152075C
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 11:33:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 164152075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38550 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMWR2-0003mP-6q
	for qemu-devel@archiver.kernel.org; Fri, 03 May 2019 07:33:00 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59960)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hMWF3-0000cg-D2
	for qemu-devel@nongnu.org; Fri, 03 May 2019 07:20:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hMWF2-0002UF-D9
	for qemu-devel@nongnu.org; Fri, 03 May 2019 07:20:37 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:52677)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>)
	id 1hMWEz-0002Pv-Vy; Fri, 03 May 2019 07:20:34 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
	mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA
	(Nemesis)
	id 1MiakT-1grbKw1aCd-00flhN; Fri, 03 May 2019 13:20:09 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Fri,  3 May 2019 13:19:48 +0200
Message-Id: <20190503111958.30825-3-laurent@vivier.eu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190503111958.30825-1-laurent@vivier.eu>
References: <20190503111958.30825-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Mo0DHmSk3NXOQ39/99q/lX9tdbs4b1ZFlo11KKPGiKVH2+VmJKa
	0Cd0YVYHpijJ3+gDGvWdA0yaN1yOXchrDhi8R9TF0CpCtKQZ74J+3AZ5sSFtOJ11UyNDoWk
	ovvZ4wElGnjhzG0t26GioGcRU0sXQNHtRlBX8+iFUv4Hux2QGV7e8Wu9ApYcvwVBtbqNQ5X
	xMBShRn2O39O56lK53mKQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4D1AAZDHlv0=:xIB9Y2RHqtxeTDvzVQnygV
	+2vQhicwVLUHTHmfF5DqI3Sc/7CBJIYl3CxGx/K6FDd/hLrnckHr67zsMOB9THNQC8cANZnzD
	Qut8GjSpgd+FszRd9HRcisewgw3YmSay2ZIbTK3Elw7a8/F/vmHg5zf8q0YVVToAZRw+6bQd/
	YEtC20znLRW6V7FryjeC1WxYE/mCKWMflbk9GV7V85c4KmA4sTsYfM4lwhp5190mS5IVNvSt+
	VM9NTdDLxVYyrinqkSvRwMf79cp33mXiB1MqVNNyV8V9/buKXqak1F61hCqA8Xw+pxsSX0gnX
	zmKQuXQokWS6KIS7roXuCGRAGPtH89rmR5q7T7rpm8yx1DIvVD9JJbwBABHtstc83VaCtLyTl
	Y5NkTV44IqtMLy/tpypxjuLeZ/zEd3LvoaR1LiaclGdHXsw3Uz/aIBlCI76iRL7r0DW5WyzAM
	BKAhFSJCCmeIyJyRHmjM7JIWOnNewyTfObMHD8OWs6TzrKbA4WKt09a7tbbNFRGINScpItAl2
	HXwgiVvjE8jqfXEJiXzGE1VIv/cEjUti4Deoq5gz3bGOANawGRKmbcE7sVQV8T4bexTDJ0Bjb
	dPGpSOtnIJew2LXd7fmH8awH7joTXOC29zre5BI8OE4/i9wWalx5nxlhOQkRR0VbbaMthwEwO
	hvvoV8jfIpVgO3GcFJFfooVAld/acsYPH1C/iP/8ZjbP1GDNY3cOfXE6/7PphPCO3IRUyTdP/
	xrpXRnNzrYuDN5TcFNfZZpCp/GoK1V5WQ0k23w==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.74
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
Message-ID: <20190503111948.PZ6tCY-gAe1LO6V8T5VXc0IU_hTdT1qlsHkhtPF71H0@z>

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


