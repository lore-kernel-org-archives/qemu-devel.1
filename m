Return-Path: <SRS0=t3yw=6Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4A58C3A5A9
	for <qemu-devel@archiver.kernel.org>; Sat,  2 May 2020 19:47:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8593D20731
	for <qemu-devel@archiver.kernel.org>; Sat,  2 May 2020 19:47:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8593D20731
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52642 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUy6z-0005dQ-O5
	for qemu-devel@archiver.kernel.org; Sat, 02 May 2020 15:47:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48224)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jUy6H-0005AE-Cb
 for qemu-devel@nongnu.org; Sat, 02 May 2020 15:47:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jUy6G-0006ZD-NY
 for qemu-devel@nongnu.org; Sat, 02 May 2020 15:47:01 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:39607)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jUy6G-0006Yn-2Q
 for qemu-devel@nongnu.org; Sat, 02 May 2020 15:47:00 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MOiYD-1jnsQj3BLr-00Q9b8; Sat, 02 May 2020 21:46:46 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PATCH] linux-user, alpha: fix oldumount syscall
Date: Sat,  2 May 2020 21:46:42 +0200
Message-Id: <20200502194642.32823-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:kM4Dnn/42aBkwf8laoK2Sls1BBvzfHO7+ow+oVAVPYToiRviT9o
 7CCteD4rJ0SSix3R1fQh6f/9SRgnTfEHb5p8jx6nYqmeAChamlkwCBl5IEVG5WckZRET3A2
 Cxiadyow5G+iFiG5ZXJ3CbTHlQbw1XxKnOt3fqoSL4B4ItWPvVWyeq7cOu26420oPvJCEqL
 gl+ZQn/g7N5OLkPz6DAlg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:u397iiZ2WEM=:kezUHaLhPY417HT5gJGzEz
 9v5TDiPJw9I+o4Ki20E41xGNmCOLkrG9/8cQ3/pIPzFdKhQe/O91C3PgR2ns475lOgbXp93EQ
 oAXEcLF9BwDafGGLmSzcmTwZN5PLzcEDwf1UF6LaSHMd2S7ux0yFe/aZZu+FVntuSS5745W3e
 Y7LE5lIWxz6RWqEiwTYKY6rIafTvHufbQLCQoCxGSEa4c83ZtHX19bmVwFLapRSKoZFP66MkC
 2wgD1XpLYYVFD5OIVvuY3xU3ZvfKdZ3/ciAhLvnv20XFEAAuEFkqsHo/vRccZkCav6uLA9Zgq
 1rRC1tgQchVO2SBl0kyohqz3JALC2C7+i7uzcB33dfqe/26bU7oaaSVAivclpPztxZmNkSQ2u
 ZdGEbt4/TAH616oCYpraTV824EgOd+8IFIyY28nk3bsNB5KswZKs6CPpiJ7MXVK+wnfBqBziD
 iLc2AskKQWwfzRXwtdw2TScRLd3Z6WWaQHprmOBPrqT9r4a81hbZt7/Otqu2R6InrwfN6Rc6M
 62mtQ/w3uW4gggEqHa4nCRaZIk/ESx3m5zPLkPsgECMQb9ydPOR0h/RR7tD/0Ivy0nenrCTIt
 8H2Scx07f2CIbI6dMksRsBcpx84bVjPXGlZXSZnX803kEVaiLNlyi+79Orpd20oUbMtHQqJ3p
 czxBR1nd7PbULQc4VmtI6zfnx0Dfyk1EDWPL4nGEQiOCbU4qTD4H2o1emADwS//U4iDS3D+MF
 7mSJZL+XRf+y+n6eWFTRqZLWl/PplVuLbHHqi6QvSl+6fYxw+i7Ob7nHpY9DCnIH/56+MpJ3y
 kqqEPK7HWEeUS679zMHshQzAsWRDfz8WUqfAWxkG89wl/YOLmDvz2rSbygQYrbGBngMzOD3
Received-SPF: none client-ip=217.72.192.75; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/02 15:46:58
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Received-From: 217.72.192.75
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
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When we try to bootstrap debian/lenny for alpha, it fails because
it cannot umount /.root directory:

  ...
  Setting up initscripts (2.86.ds1-61) ...
  umount: /.root: Function not implemented
  dpkg: error processing initscripts (--configure):
   subprocess post-installation script returned error exit status 1
  dpkg: sysvinit: dependency problems, but configuring anyway as you request:
   sysvinit depends on initscripts; however:
    Package initscripts is not configured yet.

This is because, when we switched from syscall_nr.h to syscall.tbl,
the syscall #321 has been renamed from umount to oldumount and
syscall.c has not been updated to manage the new name.

oldumount has been introduced in linux 2.1.116pre1 by:
  7d32756b2 ("Import 2.1.116pre1")
...
 * We now support a flag for forced unmount like the other 'big iron'
 * unixes. Our API is identical to OSF/1 to avoid making a mess of AMD
...

Fixes: 6116aea994 ("linux-user, alpha: add syscall table generation support")
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/syscall.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 05f03919ff07..e89b815ce983 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8028,8 +8028,13 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             }
         }
         return ret;
-#ifdef TARGET_NR_umount
+#if defined(TARGET_NR_umount) || defined(TARGET_NR_oldumount)
+#if defined(TARGET_NR_umount)
     case TARGET_NR_umount:
+#endif
+#if defined(TARGET_NR_oldumount)
+    case TARGET_NR_oldumount:
+#endif
         if (!(p = lock_user_string(arg1)))
             return -TARGET_EFAULT;
         ret = get_errno(umount(p));
-- 
2.26.2


