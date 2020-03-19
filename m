Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C42E3C4332D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 09:29:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98A2420753
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 09:29:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98A2420753
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jErU4-0001cW-P8
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 05:29:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40800)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jErRo-0005Cw-Pg
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 05:26:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jErRn-00043Z-Pr
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 05:26:40 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:37157)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1jErRn-0003zU-H7
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 05:26:39 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1McZfZ-1jrDX714V3-00cvwS; Thu, 19 Mar 2020 10:26:36 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL v3 07/16] linux-user: do prlimit selectively
Date: Thu, 19 Mar 2020 10:26:18 +0100
Message-Id: <20200319092627.51487-8-laurent@vivier.eu>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200319092627.51487-1-laurent@vivier.eu>
References: <20200319092627.51487-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:rNWNRgLphq1+tfycTpE6pfTbHrdBb7OgawwDi5sc66TjRBIsEHh
 cQOxF7RlCXjGUNa1UxxofphRkVUc7NicCDMcNGtDZGLZKmjLfz96f6tqsLqN9XvZ4Bh21JQ
 ZwGv5D0i4xr1/d1DeQeZjHVbags0OhRB/HBwNACdwVWmC3ECEWLaSO4bWME8Bub9JxA+46q
 72oV1py5fEJm/dbisLVKA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:KOVr46hHLfw=:Q5ocxgyiKCGl33lpHGkJRF
 NE+awer5gjCNnPgr7JDRx5l14a5xYkSTadwA5/7yySF0/msUvbxhIIVQ6oPEMoq3npEKnyLuQ
 g+0PteqzOlej7meneDJXIMG9HitxmTnxQ4yx39WknyWPrA9GpHc67y8h/G2jFg0LvpRCz2BIe
 EZ2aqWKFOI+85OCDs6zO3VeaixQRNzQ8vn291sjvBmkAFPV/eHIV5egYO0E3hz8MuTffptrdf
 xoVHASTUxMEPH7TJJ4puyX4WlONP1APxrLR+3+ccwnb9sVviLDl8IImpHnK5r7li5DpX7coRc
 6U+ey3vdkrpjUUPNF1SwdyiKoy1dowSA7X2W9WkFYdfjZyDjZixnQLeq7c1tEqgPorTj376gK
 0p3UkE/A2TZBydWAu87gYY1kqnoQr5/JRBCzSw0DBpAdqyxWQO938PJw65u+MXL+XUd7/iXKM
 3qClhrVVQD9SIoqQqFDKKMexoEkdiyDZrnMlB+nYzJqBZj+neeEOVlXgqk84S532x6Be7CiNT
 3xCTlBudkPl1mEKtaVNYyRhgJHuP41XcUt92KOVUTPusFZnABCQZxJZQypAPzmKUG72k0mgvJ
 k56DwvF6culRd0G5oZ0klXLeozQwAUT1cRkAqlWlQUQIhz6mZoAh+Ti3ytdK9Rz0Wn7J+u7gR
 OiATUHd0gmpleiaCAoTpuKkDZPWfjXQYslifHV01DR0M7yHzRL5RuUgCRCnyirpJRNVztZgA5
 TIchcgx1KIoISAkpzc8G6ERMzXIhCwsV8oEvx/fNRqB/ufSCur2ZbxJLhmrahnMF/TiTFUWYe
 IhyO1hhE0y7ibzGy0+8Uk2YKP4WrGZEo3+u42g+KSSWZZ6yvxY8M2lPUZjgwSuA2ZFrfNTe
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.130
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
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Tobias Koch <tobias.koch@nonterra.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Tobias Koch <tobias.koch@nonterra.com>

Analogous to what commit 5dfa88f7 did for setrlimit, this commit
selectively ignores limits for memory-related resources in prlimit64
calls. This is to prevent too restrictive limits from causing QEMU
itself to malfunction.

Signed-off-by: Tobias Koch <tobias.koch@nonterra.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20200305202400.27574-1-tobias.koch@nonterra.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/syscall.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 811495c3a0bc..be676c3a4fb4 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -11904,7 +11904,10 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         struct target_rlimit64 *target_rnew, *target_rold;
         struct host_rlimit64 rnew, rold, *rnewp = 0;
         int resource = target_to_host_resource(arg2);
-        if (arg3) {
+
+        if (arg3 && (resource != RLIMIT_AS &&
+                     resource != RLIMIT_DATA &&
+                     resource != RLIMIT_STACK)) {
             if (!lock_user_struct(VERIFY_READ, target_rnew, arg3, 1)) {
                 return -TARGET_EFAULT;
             }
-- 
2.25.1


