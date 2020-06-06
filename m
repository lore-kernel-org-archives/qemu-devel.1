Return-Path: <SRS0=faK4=7T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 116B0C433E1
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2020 13:19:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAEA9206A2
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2020 13:19:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAEA9206A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhYjU-0002iw-3X
	for qemu-devel@archiver.kernel.org; Sat, 06 Jun 2020 09:19:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38958)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jhYfc-00061r-Q3
 for qemu-devel@nongnu.org; Sat, 06 Jun 2020 09:15:32 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:33563)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jhYfa-0007Zw-UD
 for qemu-devel@nongnu.org; Sat, 06 Jun 2020 09:15:32 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MYNW8-1jTtOc45Uw-00VQi8; Sat, 06 Jun 2020 15:15:21 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL v2 01/19] linux-user, alpha: fix oldumount syscall
Date: Sat,  6 Jun 2020 15:14:59 +0200
Message-Id: <20200606131517.1250346-2-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200606131517.1250346-1-laurent@vivier.eu>
References: <20200606131517.1250346-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:fUnHutHA0ugdfgc+RZwN39djWZCuGpsPP7zroYTbwqqj5FZ9LfG
 GS4EVanCAXxKZqh4lPDwlPIEO2V6jsErmlm/pawQHqHK1szpu2IzKw4KNDLDc6EU5bhEl2B
 2VF/mv6AUWDEhi7UJQD2lfLiZS6tO7kl5062MMal4VYcP4+tCLumsngdB00ROaRgQ892g9m
 cugiLJDBVcwLTt0ahbxaQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:N8hVkgN1z8c=:hXBNbTVBNBA9iEzMpsE5QY
 3lCoAJ2IvLakYi3Pub+IP9ZxUkvrucORRDo+2QkNqm4YL3gjzO+SqCa4gxCLH3f5kdChnm0fQ
 C8N/+MangqBx/RKNbW6BvAF8kPv32imxo/eCXExHvbJK+qDLkJOlqebobaxIRQvibASCVngGP
 VYQCqOOHzzYEvSHNHtZjN0ElUaifE6DvKogWjhqPsCMahdyHpNsJCN1PPkCIzNCI+FOQveBcp
 e1OT82xuuhB6bx8K3eq1I/jQQpNOPAZuPdJM4K35P5l2uNu0upaNcnz07WJyx+qwilBZc9PKg
 hxTg5CTVHFvBrqzowC8nPnoL1WhfSsDkYlXwPxrp6eLyB2neIuaQVSMk/Q684DtGOCdNjdoGN
 e5yHdV9SQme+mvUka61m4AfWSN32NX7mCUP5JA2CENRYgj6kPrNALkNkc6iKRJ9PG9dmYsRsW
 H6ZTrYRdHI52xw39SKiv/TIOAjXei0EDE5NucEHIn7RHSWfDXs11BI9X2K6P1T5JztaTCVETI
 G+EEeTCvIHVbtof9uvbIsHTu1ik2Qc2xXvhTxPhVqiyCFhraKymN0LZeZyTRAVflQpZxQV19Z
 q0mkOJD0pSn36oBBL+MutQkeGReCUT/VHu9GlatveOPCLZR5VHgUwhD9QTylTukWVQBoFfQeG
 UNgFSX9vXdxUG/GPuQxnY66zRi4nRfjiAE60RCTAB/lzQk295+b/MgnuJDU64JbHJNvsdM2QT
 BhfQ2jezbyi6HpVOpP23LLextTOFzZA4or9ZHYn8XFTcVs94pvZKxCeAuNLTRgMCkZdvJyZvC
 Jz8zHEF2SwkTYRzOt++BKXRFsfsaixNwqMuUjK50Q5sFTZqolDmKlovU90xni6GyTUlpl1r
Received-SPF: none client-ip=217.72.192.75; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/06 09:15:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Message-Id: <20200502194642.32823-1-laurent@vivier.eu>
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


