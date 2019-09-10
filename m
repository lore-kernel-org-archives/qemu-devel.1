Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAD45C49ED7
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 16:41:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73E972081B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 16:41:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73E972081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7jD9-00027f-WB
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 12:41:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53126)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1i7j7r-0004X1-J1
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 12:36:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1i7j7q-00021s-JD
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 12:36:19 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:48125)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1i7j7q-00021B-AU
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 12:36:18 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MsqIi-1iRKL50RYW-00tAs1; Tue, 10 Sep 2019 18:36:11 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Tue, 10 Sep 2019 18:35:49 +0200
Message-Id: <20190910163600.19971-5-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190910163600.19971-1-laurent@vivier.eu>
References: <20190910163600.19971-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Snl31syHCaRUwPZeR5XWR6Csa5PyqsiRk6pbWTvrU2g9jMoikBf
 Yh7q/CyPLwmmJXTQ6L0N3tMIVEAktqdNuo9qbvj4tGNXPnj5oDAe4vPsPmiz4rVutI4X1tT
 4O+iil0yIhC5B2F+BL5RrpdTp86neml/SZWBueax5nExFhsMSclMV2KfUopxE1eWCapaKpt
 9SC+OFyTzHaJO8r4cAYeg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:aswRB7F3vmY=:ZIV49uQwCuIrOMSeDbp618
 2GpOMkCf2+dHx6H1++YrgDF504Y6iiVnWyMZ7PFEKbQuAHQ0wVELVADa0EXAvLf92kgscsy/m
 CF5ddfI3378gNfSVI4P1dZ1og3zidRBh5N3Q1aQIT9pBS+/chiC6B7NCx/wk1IT2JpVT6n3xS
 QT6iGslUP4+YbJXmzQcOUWY/99jkTbHrzdg7sfQFDt0wUvfcYdgjGtifjDql/BAUQPaQbjjRB
 ktoehj2hwfRq6GXWdOvZqpAp8vDBrfEUKIwd7dTirw3LKppxmThLjCzkGhszsl9lPaScUMIO5
 6lPtzgsYSAreSi5ANXs8QhmIItz1oL22eAYesMab6zY/r6sFLNB/dAY+zFybQK9vQtGBkm5eG
 ik7jiqSWAbPMTKqr/f/5vswQZchK0n7SupjX3uEfkH5OslovbY9jDYKfjYASr0B2Hkx7xzZVb
 9tiJQyR1ZutNR/YQxsKz9zHPz2x9anzFrsfoRDuqXVPJOg5FZkS34ESBfNBTdjkFHWOT2YVf8
 vcvr5ZHfL8X2bp+MgWQmYECVK8OPkrZgI9XMFNGdUWc47Xvh5ix+Bg1Ls6G14454z2yQcfOwq
 oCDSDiahYezGzd0LqARYgLfeYyDesoQmDYP4FLIvUZlYZ1pKrxyz+CbP+36X5gudi8lvwvNye
 AN75ec+dfjNbTAVXJoCTxz5trpMutvC+GJFM5LitWNgXi86oO5EudEQXmKDfJ8hnFp/COZbLj
 KOFmBBXpiXz/fcskrLWyuKcjqImwtAA5Wg+4OjZR+SThWgDRhoHDlBFGGXFI+lUQ7Ri55Kntp
 dghiev9OxkKESTHb/9k/lwUuXXtMWA+TT81u+iIN3cvDTb5M4Q=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.133
Subject: [Qemu-devel] [PULL 04/15] linux-user: fail and report on bad
 dfilter specs
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
Cc: Max Filippov <jcmvbkbc@gmail.com>, Riku Voipio <riku.voipio@iki.fi>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alex Bennée <alex.bennee@linaro.org>

Just passing NULL means we end up ignoring the bad dfilter spec
instead of reporting it and exiting as we should.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20190830143648.2967-1-alex.bennee@linaro.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/main.c b/linux-user/main.c
index 28f0065b6ddf..c257b063dbc1 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -235,7 +235,7 @@ static void handle_arg_log(const char *arg)
 
 static void handle_arg_dfilter(const char *arg)
 {
-    qemu_set_dfilter_ranges(arg, NULL);
+    qemu_set_dfilter_ranges(arg, &error_fatal);
 }
 
 static void handle_arg_log_filename(const char *arg)
-- 
2.21.0


