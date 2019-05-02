Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 010FFC43219
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 19:04:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBA6920651
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 19:04:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBA6920651
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57403 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMH0e-0007nh-20
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 15:04:44 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36405)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hMGvs-0003qG-1G
	for qemu-devel@nongnu.org; Thu, 02 May 2019 14:59:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hMGvq-00038P-16
	for qemu-devel@nongnu.org; Thu, 02 May 2019 14:59:47 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:49225)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>)
	id 1hMGvo-00036L-63; Thu, 02 May 2019 14:59:45 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
	mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA
	(Nemesis)
	id 1MulVd-1gUrBS2fkB-00rmX0; Thu, 02 May 2019 20:58:49 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Thu,  2 May 2019 20:58:25 +0200
Message-Id: <20190502185835.15185-4-laurent@vivier.eu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190502185835.15185-1-laurent@vivier.eu>
References: <20190502185835.15185-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:i8N48vf6fYeQrXRpmliB1WbbQePfY7u70TUSvgRUwugwD4qm+PH
	LPLdWWdX/TDJimYRhNRBrRbClzUyzlva6Nl7/bjaKkIQE3lof3IU0/YS8P8/+PONtT11Syl
	puSoX5vr5YsnSU6lmTMBdhipO++qof5PiWsTDF5xbKXHVrB5t6PL8768pcWZCagmNyxF4jP
	veBVFUtq+nADNt8DlQzdA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hdmbE3AA+90=:UDPPnU0TVO8VM3YtriMX0F
	3iK+TZOru1Qh/OtPoueav0a4Mx5ann9iSjpNNAm3TNFdDkqss0y5N4GZdlYS6AI0ooKhNVAc7
	IjH8QL6RQJxA6/RIk0F+7PlZrgwfeynR+ruM/i2tnvsrosKAFpUc1c4oVPc+oaZ6W/3LcqRLy
	zy5DBVSisyvv9jhjRJy5rAwydyToYUguJqO5jf3egxy6x2j5VUYEOQGp13VHyC5PE0i21Hk7+
	Vh9qfdsdVyJK7W4i2CUNPwr+1SOKGu4sWhHhykgQlgDBBCqtfbCal+RPYstygrUNh85fk54qo
	7+PbXlqm0ppYD79DWuzdBAi2LDEXBAAfpMY5BOMiuNEaWa21fka7a/x/nDrK+n4phKvXTYwtE
	UtrRQIKK1jdxevERlL9cH2/hxoQYGGGur8cMMFkmvreHn+eEyIgq8BuG84KJydvEvM+XQ3iJU
	LtW/zrLsb74xTgOVyItUK+iV2tKf2H2cAT5wc0TIzYBEkMLBgVP0uUwjfeEEsKz5CK3Q0LPT8
	pe3EGWdoNvNme8me/lBiuVkGwAwAXXY+rlNPQS4PmLuWOjSNojy02VRd/pt9v3m6HNcnChG7i
	wK6MVcbaW3Q2pHzt3SciZ1kD9rrttjiPUbkkxjPz89H3V6CXRpOpRrunjOaT+CiCPjTG69a7W
	VLc/lM/s/aNfmrlXAcPkfkvrKw0hhXGEhKdGAMmZzMI3OIHGO7CalWb3xxqsORflC2udqUqFJ
	TgxkZie0JRESHcq+K/AtvwutGNowcFHhRm3obFs5Jvyp5E14DGE6hFaXjMU=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.73
Subject: [Qemu-devel] [PULL 03/13] CODING_STYLE: indent example code as all
 others
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
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
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
Message-ID: <20190502185825.b4uiSPHaZqwKikHjp2mahXGQuvipi19k5fDKQbhwSvQ@z>

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


