Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5277CC43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 11:35:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E6842075C
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 11:35:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E6842075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38574 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMWTA-0005iE-C2
	for qemu-devel@archiver.kernel.org; Fri, 03 May 2019 07:35:12 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33875)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hMWLf-0007kD-Op
	for qemu-devel@nongnu.org; Fri, 03 May 2019 07:27:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hMWLe-0003Lj-R4
	for qemu-devel@nongnu.org; Fri, 03 May 2019 07:27:27 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:41031)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>)
	id 1hMWLc-0003Hr-J1; Fri, 03 May 2019 07:27:24 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
	mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA
	(Nemesis)
	id 1MXXZf-1hFhg93Xnr-00Ywj9; Fri, 03 May 2019 13:27:03 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Fri,  3 May 2019 13:26:45 +0200
Message-Id: <20190503112654.4393-4-laurent@vivier.eu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190503112654.4393-1-laurent@vivier.eu>
References: <20190503112654.4393-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Vwma6Rzlj1kjDOfuerTs47edBiyFSJN5reaPmOSAYvp+eeoE27q
	z7EK4W3bbUHt68eLqFhPcwTWR5qMBgnVQk2GCgwd7h4KbQSfUZVMUh9YcekhNZhicQYbIta
	kf8MJVWBrtp/CJL5KfwNilVi+VSgI5Extlxd8CWU/oFYmZf98UUJb87WyzQIIEbkGSuUq4v
	C8yVoT+erKbxXgJ4En/oA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:IfgB+E8W+KY=:tPvxorVaOzTttZtQOwl0Vm
	AUBoMI6dZ0YqIRGyqLuQ01qCXYAp5k9fl+o2Uno3tnaTuRg+WhcjCeS1X1oslG0BApq+kkKsk
	XFeHszHpSWVMkaUKi0kTw6AFFyjh7Zf2YSVtyIgC7owhYk+uji124tIvosY2KGpDt1UMqLY1X
	oQlnmISEmQL7kmLU78LxWrM3KCtvS3yjtgztYZxXRlYM/4hnmz2+xCu2UTvplohpMrrEeuBVv
	gPjZKUcDw2kC2wo8014cYtOG/o1apYXrQVbuY2YzgktMZ1J4Ryyz3HvXaEiAclaolbcHso2hg
	8/n2smotmkV551YbPb259USzGMsIivJFwfxWSrqlj+ivwPIq3jWks14MHRP1ZKijek78h9qX/
	fMQm6Z5kkaiBtB4K0KtYYGxuzmOVEm3Fuivw97x49ctDM6/U0Oj8Sl4o6psM38bUochVwZiDL
	BuMbxitEuKDjhu1C0CxrmGrHOkQaQzvhZhEZ7QATHlI2d+6EO/tlLU8Rx7rrjpTjQRIfm5Xp8
	vqYuOV9CbBnVKLY0q0yFhuYMMZxtH6HjhYSBnWdApeAe16ThHU4NzWD4iwqH2B904XQKTSkZP
	wFiZALze0g6EBLj1AmEKSK0Y+7VTxDzkUQdv10EbM6ge8A+ykbzwCB7CFG/iYYmU7CXb5idTJ
	26WJwDc6+UHqVUuuxwtujuveJpZpW+RRnReNW6MM525R0PJGPMsiYVwIXR++hp+5ZtaeC8CAr
	q1Ee8Fuwd1uXO8nm5m6tdV9Krwccsv4R/qb0HeLcs4VSWWBS/YJCTLo+VcQ=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.134
Subject: [Qemu-devel] [PULL v2 03/12] CODING_STYLE: indent example code as
 all others
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
	Jason Wang <jasowang@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
	Fabien Chouteau <chouteau@adacore.com>,
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
Message-ID: <20190503112645.q-cM6Do6qPLWm2xzfASMK7Mw93Apznaqh7KB8Gsq0C4@z>

From: Wei Yang <richardw.yang@linux.intel.com>

All the example code are indented with four spaces except this one.

Fix this by adding four spaces here.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Message-Id: <20190304071631.27567-3-richardw.yang@linux.intel.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 CODING_STYLE | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/CODING_STYLE b/CODING_STYLE
index 90321e9c2821..cb8edcbb3692 100644
--- a/CODING_STYLE
+++ b/CODING_STYLE
@@ -147,10 +147,10 @@ block to a separate function altogether.
 When comparing a variable for (in)equality with a constant, list the
 constant on the right, as in:
 
-if (a == 1) {
-    /* Reads like: "If a equals 1" */
-    do_something();
-}
+    if (a == 1) {
+        /* Reads like: "If a equals 1" */
+        do_something();
+    }
 
 Rationale: Yoda conditions (as in 'if (1 == a)') are awkward to read.
 Besides, good compilers already warn users when '==' is mis-typed as '=',
-- 
2.20.1


