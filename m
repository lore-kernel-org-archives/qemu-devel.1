Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 989BEC49ED7
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 16:38:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71978208E4
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 16:38:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71978208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7j9r-0006iP-Q1
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 12:38:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53103)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1i7j7r-0004WF-1M
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 12:36:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1i7j7q-00021U-2F
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 12:36:18 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:50173)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1i7j7p-00020p-Pg
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 12:36:18 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MC2o9-1hzngw2Qv7-00CRge; Tue, 10 Sep 2019 18:36:15 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Tue, 10 Sep 2019 18:35:55 +0200
Message-Id: <20190910163600.19971-11-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190910163600.19971-1-laurent@vivier.eu>
References: <20190910163600.19971-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:HUVvV838EzmYfbOXW2KgtkzBNxo/KVs7dc/jLXCYjpGP/YnZO2/
 z8GvrK7cpBi1h/Fx8dzBxk4ACbEm3iA+5Y3sPyhpA7lW9fl0p228go0gnSG/tWvwkJB23KF
 zeimzRvJVlyatjSSC69lvTVjTTX7z3U0UvxMwBnkFqp2jJPhato8nDoz0JElQ1HfJu5FhoW
 3YPYuPQVPQG5ZqRm3n6ww==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZR1l7HXMZS8=:4PAsNddvlM1DYCEJ3tti6Y
 G9uDsvzUpcuzToDR6uJ3WuOlFFY2PR58tRurr3L/1mzeuYPgZxUHSdRa0pPmYEfgaD7HpQ+2C
 6HNrkK3YCKnkKAu8bo7WM6nmudNGstBdjpiUSNLhQ80EGW4Vv5C9JPElunt3uoGDe3X56ektB
 HF5mlPBrWGxJWVawyNLtgFEvwTVfKXKsCP79JmjGfr/V4AohrU/MbIVUYsLps5ulP465hZ7+Z
 H44H1XhbCnHiE0dZfBiFjP5qjx7nBPnhlIrQf1rdtiy7pWF0g8An8vlID2RWGbjR3sdQ4csKs
 ExX4s/7t5AD3+cHAnhfAS9q5cVXtOIl/UOLclqMFCCZxu4/RKdHnTtAX7WWAX11Y3bk7C2juG
 g+8Ys9X/aFZ0zolZ/y4fFjLSpx4/HJpL3DxTCujJla+Rflim1h7dfd9wBywfIeBBMachiGsGT
 tIiZrQfhnGz0FTN1t8iL901btVE7xIAZ1XnL98GGBejBVKm/UlgrQSZbd+/CKS39TIUUCTBSA
 vqTRakn6q3/favZ3hZuyiJj1wcBMp6ln59w94IU8ISaS+zKOz1T9gpa/Da3Ifuf0TBYMz5GyH
 7MAvxCbItaVr6MCS9RbiGNK+Z2VuCkLuoKVm2yp8nuDEDrOanAn9d2YH9B0/51kd3VhpaUUxj
 D/XEiRZ3mFjkm/1tT5vvx7NqHGTKxgEFL/Of9Ks4WRQZM0skBtxGsej0vTk2jmiyP0BkxpWPD
 5lJ2XR7J0NSLqIpp1C8fBTAzeBWCc69v7rRZkrM+6xCmJ0xCe76N9aDUaHMxGCoYX9j0LeidT
 3c7O3i7BWzobQI1l4Bug/eld0R2/Hy+JMCdUutakipy0P/aCrg=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.131
Subject: [Qemu-devel] [PULL 10/15] linux-user: drop redundant handling of
 environment variables
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
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Max Filippov <jcmvbkbc@gmail.com>

QEMU_STRACE and QEMU_RAND_SEED are handled by the parse_args, no need to
do it again in main.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20190906165736.5612-1-jcmvbkbc@gmail.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/main.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/linux-user/main.c b/linux-user/main.c
index 27d9a87bc83d..560d053f7249 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -706,13 +706,6 @@ int main(int argc, char **argv, char **envp)
         reserved_va = max_reserved_va & qemu_host_page_mask;
     }
 
-    if (getenv("QEMU_STRACE")) {
-        do_strace = 1;
-    }
-
-    if (seed_optarg == NULL) {
-        seed_optarg = getenv("QEMU_RAND_SEED");
-    }
     {
         Error *err = NULL;
         if (seed_optarg != NULL) {
-- 
2.21.0


