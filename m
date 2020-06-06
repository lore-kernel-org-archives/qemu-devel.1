Return-Path: <SRS0=faK4=7T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BFC7C433E1
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2020 13:21:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 750E6206DC
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2020 13:21:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 750E6206DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhYlH-0006Mp-N4
	for qemu-devel@archiver.kernel.org; Sat, 06 Jun 2020 09:21:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39012)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jhYgO-0006vl-54
 for qemu-devel@nongnu.org; Sat, 06 Jun 2020 09:16:20 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:46565)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jhYgN-0007dx-6b
 for qemu-devel@nongnu.org; Sat, 06 Jun 2020 09:16:19 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1M58vU-1jiebu1pDQ-001DYg; Sat, 06 Jun 2020 15:16:10 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL v2 01/19] linux-user, alpha: fix oldumount syscall
Date: Sat,  6 Jun 2020 15:15:49 +0200
Message-Id: <20200606131607.1250819-2-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200606131607.1250819-1-laurent@vivier.eu>
References: <20200606131607.1250819-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:bZwLyqN3aA/vnQtCiqR+H1k3Suwq80XSSM8MTVmU33K7Hh6BFEV
 04IdS0QP3GlndsDALpsaeNjlFK2avqP5bQbFlnl5SULr3ifbwh0/7jKaIGWV+YMV7O+6m1M
 PFe/rin3iv/gRhffDrD0Zfl2BJlKHuAv/ZYW6bubR3kqtB7HDH/H7lEQPG63fOQEkpJ0le8
 2ZP8vqxsCQjTMvAd/cfew==
X-UI-Out-Filterresults: notjunk:1;V03:K0:99abd0PLyYw=:8d2dMyzivEY2uw4jR8kTkN
 Nt8WqdXcWEGl82uLh4k+clMHFJeHVUCZym2kb2d4EPJYyk6TxphlpepU+JIWteetJqS8EzPcH
 nzH6wTg9JNwJ2wVA44MKOANP8q7+OHAEeRyloToPddf+jTJ6sdFsOsaxnZ8Tfbcf4g65Id5dS
 skqRPGAUMyzCeJJHb6eGF2uBJvSYsxcpqlb+TugrxP/8imgEXs4TOkratEnQR5qrGPvszBmQE
 rlfmaZ56zvhtNdenU1vaOI+wIXRPo7mOxXUfaa3Gm1JgqiO7VQzEus2e10p/C+S0KqtM0sR04
 DzZtTcUT1WrRBBxNki9PHSRoXd+BudVB0XUWbFOgNETwbHo4JBDkA3ch8gdUy+2BbCKs8jQrk
 +TkxEBB51Ovu5S4Kxz0a7mN5s9QHryK241x/JzroMpxGOIzcHRneVQiFj0QdS429vkNmu9SHD
 ELu0xfECJtOTGXh09UYPXyCe+y1qGpFgmX52hVpYPqvgT8kSK3R5xby9q5Ujr9wpd2galOleO
 CNEvVTJbMdpq2JUUyaN8O6WH7rAjNs/e+qXDpZwCl/7WyajK6ms0Q0evdOJx6wYzSyaezvb5Z
 JBj/dmeM629ljsKvRaCuHg9qHVeg4g/A9jFu1D8E7dJtJ3a4IEO7mRXusLVM0ZK8GfEx6+LNs
 2ZZlxPWy18q5FLAct5zI9H9rtiFclhO+FwWCn+P6S8eb+cxCJJis27kNTdPArSkj+QtqO3EJ0
 a+eO16jTZaiyxQcfPC6lfSgDxdz82tcv0ePLtdCFJ3J0QjiPGJrpeaE/1t24FiXd4rVgw2GJ/
 9PwGinuWSH/3IRcVXZxFaF4J0I9M5C0pUNaKEeP5HAkPmg7mVoCnFZs5S5lzj3fKbKhxS9Q
Received-SPF: none client-ip=212.227.126.187; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/06 09:16:17
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


