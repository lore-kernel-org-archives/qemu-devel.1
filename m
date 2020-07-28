Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DC13C433EB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 12:35:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9FE620775
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 12:35:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9FE620775
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0OpW-00062m-6y
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 08:35:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55732)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1k0Ooc-0004gn-Sp
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 08:34:42 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:54541)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1k0Ooa-0001sm-7H
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 08:34:42 -0400
Received: from localhost.localdomain ([82.252.135.186]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1M8QFi-1k4mWj1x8y-004UeB; Tue, 28 Jul 2020 14:34:37 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 3/3] linux-user: Use getcwd syscall directly
Date: Tue, 28 Jul 2020 14:34:32 +0200
Message-Id: <20200728123432.501354-4-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200728123432.501354-1-laurent@vivier.eu>
References: <20200728123432.501354-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:/m6m+2UHQjNwnywy/aks4shhDodjDeEv9vteG/MbstapZS/HIu7
 blVEWtpyRiB1kdUsP26SAM+6V1YTZfnSdIKtwSiAPNx9+SyVn76cqwfnvQsTh6JC2jBDuvY
 jkJxzxBwUAFKU1ZvwSKfiH0YjW0GeemzSoufCN4Cx+6EgU8wMeHn4mXJ0b+Jir7Cm68/vCG
 FWh0gOXHVO7FbN6o47vNA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wUMztYL5bCM=:3VjB2dsjuQubdg87GLs29Y
 xpfXruzuEiwxie7RF9pCRp+6Et4un740ca6dT2jDkg1uc31b15rBtTidzdW0a/UZcS1KVAd9H
 b4U/JEdWqBmR8gTbXonijEdErXYn8vWE1Xo63Kuqe5U2XwuFt43QJlsKZ5XdHzvSc8y5E8+Y5
 9flaeksbgrKDqOdEd3tTRAof2eMMrVk1tjB6osgyDZo77WKhnjD9u0eiAowE5yicTbbrmIY8f
 qfVSrWEdZ9YRLCU7hRXUmtaX3V3O/erN2eNN3Tfp8DhMY0swmMBnS1JUDaHMXjqiSbkccrZDC
 kx5skjOzPqVBeBZNAmDodO1EPEJPiWprdNbeUe8wr2ut8pOnoi8tDmjnMe+CC9tOB2V13ghJv
 uJcnN4+INKZ3935h3Nlr5OHhn0j/s07sxE4yEnix9MtSu7JTUcEfDtST9UpKDEFYWFJ18H1dD
 6u4CuPxrEnOFfmwbRpw4jBt5ummsqAqbmrNP3VgM9WDjErFlE/tZIR2TkF2IYojvu1YVmulLL
 5AlY++QDxB8gvgo0vhuFcSj9u04F6tzOd6kdQGOTfF3IP7kuGQFbMtdym/jP83c5f+zCk29uS
 lpSbmFx9xTah91RIM9bgm8VXovSBKgz903KrDwbS+mObHTTZbp6Y/IDUtVH/LdPuDu+6h29yE
 ulJepmCZ8pX+T/hp4Pp7wkHP6HvvSx6nRd36y4nyyDqNcYcvFABMpqV0ipiXk8uwiRKSCrb7x
 zSqHyvpQ6CpIDEGq1QHmptPEabBgzMLWjU86d8zc/M7q5XhuyPwZx4sG9eyipVwqIt/7Z7661
 189qycuYmsQeaL2cn9xDq4ej6V75WotUSZGNEEZw4B0y5yaaS9X/QUvBvA2AHEtZdOLBQVm
Received-SPF: none client-ip=217.72.192.74; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/28 08:34:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Andreas Schwab <schwab@suse.de>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Andreas Schwab <schwab@suse.de>

The glibc getcwd function returns different errors than the getcwd
syscall, which triggers an assertion failure in the glibc getcwd function
when running under the emulation.

When the syscall returns ENAMETOOLONG, the glibc wrapper uses a fallback
implementation that potentially handles an unlimited path length, and
returns with ERANGE if the provided buffer is too small.  The qemu
emulation cannot distinguish the two cases, and thus always returns ERANGE.
This is unexpected by the glibc wrapper.

Signed-off-by: Andreas Schwab <schwab@suse.de>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <mvmmu3qplvi.fsf@suse.de>
[lv: updated description]
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/syscall.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index c1ebf7b8f384..945fc252791c 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -388,14 +388,7 @@ static bitmask_transtbl fcntl_flags_tbl[] = {
   { 0, 0, 0, 0 }
 };
 
-static int sys_getcwd1(char *buf, size_t size)
-{
-  if (getcwd(buf, size) == NULL) {
-      /* getcwd() sets errno */
-      return (-1);
-  }
-  return strlen(buf)+1;
-}
+_syscall2(int, sys_getcwd1, char *, buf, size_t, size)
 
 #ifdef TARGET_NR_utimensat
 #if defined(__NR_utimensat)
-- 
2.26.2


