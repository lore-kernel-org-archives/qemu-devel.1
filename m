Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AE13C43219
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 19:08:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF9102081C
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 19:08:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF9102081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57476 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMH4T-00031z-4k
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 15:08:41 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36503)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hMGvw-0003vW-B2
	for qemu-devel@nongnu.org; Thu, 02 May 2019 14:59:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hMGvv-0003G5-6g
	for qemu-devel@nongnu.org; Thu, 02 May 2019 14:59:52 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:43817)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>)
	id 1hMGvp-00037H-V9; Thu, 02 May 2019 14:59:47 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
	mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA
	(Nemesis)
	id 1MpDa5-1gyQDg3Xkl-00qlx4; Thu, 02 May 2019 20:58:48 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Thu,  2 May 2019 20:58:24 +0200
Message-Id: <20190502185835.15185-3-laurent@vivier.eu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190502185835.15185-1-laurent@vivier.eu>
References: <20190502185835.15185-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:6WagXE00vi4QQwZmMsAKXeAEG8kmGBrv5XeQQE+7L0RCxCtE7Js
	jq6jbWP61ZHHNq+v7NLOMfdcrnu28ZBfEYOWFS5ovRmHItkypDs/yRNfjbxEFe6/hZTCs01
	fVuG1JxM86snyRsthdUTLnSKry+a6IttZgcISmGu4hkyFaLckwTWhxkpSGWbdACHR34MT8s
	GYoZu6M4d3REkxe8o2p6g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4gERy3jqQls=:n7b7aYxZ6tzSKomNnFGpSP
	H7CApcDXg6j5EC7aTR8gunAfjZXEQFVpei4LS0pSyZf2DGadLpWE8LDfBHW7/zpofrergnfTx
	PpRtm3BL0Q5kRNLVCiY2gpRhOnj1IE2N+4bmro4ZBcJNeSRDbaL7w87VkQC+u9Z6dpxzAfMHS
	ib7c5IdfIhOXxQ/xNWIlCVNMvXFBkjL6p/5xym3kpl9t0YVFrgEi/yFIx6qcM/mGysbMY7pcK
	cRs46XQqLV01c9HbHVRHo0L26v16YQD5zUfYq04zsrVqhmamfE3C1QiZ4VJAUoIBuvZo2keJ7
	G7DVz48DOzk05M5D/FsZSLPGomBQ7nkVP2+n0x8Wqq7TFA8a4E7D1Z6Bz3Z17XMN67FWQmPc9
	xieFXWlzXDwvfcnNVzf+7tSL4a6SD6VddfMRzrb66kP0DYq8BuduJTHwIs9iCowlVxWQuFsPg
	40XD0oh+AIMcwQJH+DLhL/DwTYXTb2TAEWpzKPe91+vVdrGh91309V+c3SexmkARzoiLEFnoJ
	INTRcBeWLdEFgJkxoy23wILmuQU5DzgmTUcNSgNQmvejHOk+gVtYkav0lniIhRpbZgVgPlJPe
	byNLtKf8CjqFnr56sM+tVEGWzw3bSB0fUBsZy6Yr79GliJMzBGnE6Pu2A8/ubdk2JF/Lf9/zB
	LrXYUtCrXwlNOOICAGa+hMyQuiFTe5oW8B4AE1qqT/pT95LeKZyK3tHl5r/cJTq1r875r5q7l
	CPMCB4RGcPt409+weCzOlFWNX5UdetFESeWEEw==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.13
Subject: [Qemu-devel] [PULL 02/13] CODING_STYLE: specify the indent rule for
 multiline code
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
	Michael Tokarev <mjt@tls.msk.ru>,
	Gerd Hoffmann <kraxel@redhat.com>, qemu-trivial@nongnu.org,
	Michael Roth <mdroth@linux.vnet.ibm.com>,
	Artyom Tarasenko <atar4qemu@gmail.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
	Eduardo Habkost <ehabkost@redhat.com>,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	Fabien Chouteau <chouteau@adacore.com>,
	Igor Mammedov <imammedo@redhat.com>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Richard Henderson <rth@twiddle.net>,
	Viktor Prutyanov <viktor.prutyanov@phystech.edu>,
	Laurent Vivier <laurent@vivier.eu>,
	Wei Yang <richardw.yang@linux.intel.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
	Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190502185824.i4JLhvzcDq3KIz4Jrk9_pN_qT12JMOxgu21KrFRxpLg@z>

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


