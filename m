Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72443C43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 11:33:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 032AF2075C
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 11:33:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 032AF2075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38552 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMWRI-0003yT-U3
	for qemu-devel@archiver.kernel.org; Fri, 03 May 2019 07:33:16 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59866)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hMWEw-0000XO-KK
	for qemu-devel@nongnu.org; Fri, 03 May 2019 07:20:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hMWEv-0002LL-Kg
	for qemu-devel@nongnu.org; Fri, 03 May 2019 07:20:30 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:36083)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>)
	id 1hMWEv-0002KB-C9; Fri, 03 May 2019 07:20:29 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
	mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA
	(Nemesis)
	id 1N2m3G-1gbPDa3EFg-01346I; Fri, 03 May 2019 13:20:11 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Fri,  3 May 2019 13:19:49 +0200
Message-Id: <20190503111958.30825-4-laurent@vivier.eu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190503111958.30825-1-laurent@vivier.eu>
References: <20190503111958.30825-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:pKsN4+cluC+r1rmhDvMgjMvs/XYsPlaoMp8SyHySKqZejIZkDA9
	TYrZgIRGOhIV2jswJ2BAEajyAJk1hFDUJwGnCv801u/lOk4zyAQmBQDTYm04ZqNL5mDE90p
	m0clE4IdV3ENr/FvsYb6bsNyCXupboqIKsovooVmp9WAn+lvziFm1aZYcRPLT4X04UGxyZG
	0bkXBO0oD4i9d822EZ9lQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7pjqB3X4dFY=:NWCUEDvJCZHyzQSMg2SBiw
	1fHilwJ/onNDhoF/rwSx1l1z/P567pSI+cwGVzmgxRdXvhrcNSvygoltiHLbuRAqKDdNP5eDL
	MLnhKRqIa5GwuwG3dXJuEpekGxJ2N6UzleCY6iH4WRlVty09IoGK4itn4mqV/FaOd91suI7Fn
	JsZ8SBnkM5nRQVxKRT1NGkybNQHvYTrZlX87Jh5e3nLPTMKdYYbk3tmxHbNUoYLJafcVZgbjC
	3Oz7qduSEX4yGqRoEfrN6mNrPVbmIcisseDZpaeg5kETLxX5wQ4LvPKf8Drv0CISzjLRnKa7m
	mdAmSJ0g2ZhxjXomdnlBoWSScEapTfkwJxwMXPOTXAL6V+B26GlEavceTIIB0SprgHdr+Ft05
	Gd7JeqIBz3kp5dMDEp1cEI/M/lhRveWpAGNTlWE5MDARBQVOPtkOpHzppw/5b3y6wQFpSkO3r
	L9EjJ6KXlMpTcZGE6RINu7xj6ohsQGps7/kVSHIXTv3R6Ii4+I6HVMuZAuVNb6VLIDf9yEIzQ
	QnohH1T4f7ZYGp1a/xkILd+2AsfjsrOzcXooOKOO8+IQLeveLrDznSsin6gpXjbOJ4xGJN4mM
	tmdlqjsK/4szs6pc2DM3Z6LpNskLefU6acleGU6DSjBowymGK2FK2MIv7/OIcnxD8usPi19Gi
	hqqF/qtr+hUHl1b1aSoGzAm+jWBt00EHA+OKRjqhxSEex0bssSiSNe1D4pOMJSyCVTCsYehaF
	mfO8lJAJkflSpTHK6+d59JCtDto0dbt+Gvf3KWirpLrXXBL+PiN3FJ/2+vY=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.73
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
Message-ID: <20190503111949.fsjYBijqeq3gCDG5TCgdxlPuMYFECfafsjDLwvB5dEY@z>

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


