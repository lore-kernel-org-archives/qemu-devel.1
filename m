Return-Path: <SRS0=gOAu=AP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D8CFC433DF
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 16:32:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32CF320724
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 16:32:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32CF320724
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrl5u-0006ye-Dx
	for qemu-devel@archiver.kernel.org; Sat, 04 Jul 2020 12:32:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50250)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jrkzZ-0005Xy-PI
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 12:26:18 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:42201)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jrkzR-0002PX-V7
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 12:26:16 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MAOVx-1k3XV51xHf-00BtZK; Sat, 04 Jul 2020 18:26:00 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 08/12] linux-user: Add strace support for printing arguments of
 chown()/lchown()
Date: Sat,  4 Jul 2020 18:25:41 +0200
Message-Id: <20200704162545.311133-9-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200704162545.311133-1-laurent@vivier.eu>
References: <20200704162545.311133-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:czKZRX6NarPlZ1JUy9KbABIUfVDaLZV5B8Bw2Af3vsiwCk71Z4v
 yAniG3k4KCGd8QEOrV58BdTcfN8alpEaG7Hdw+ENrdytWP1MU9Tvghga1aBnW1fb508yg1w
 GGHMkpDuep9tPjFDV0L4x7aFAYZsydSHIDrEUoLYu8pPBXU2kGLvC087GaVXGZqHsvhpsIY
 8L4SsvvLfVBKGhn7D93DQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6JciE7Ux9sg=:9MPbnuu+lQU/wR/8KTKy93
 XLW5FzAhkXuPVR48QJ0jV9OS5m/jq+d5kDTWL0I3mDCLY5zWnx7Z5YtUZudVGwGFKYo73D4Pf
 KVGLh6hruFrZi8G7jSVKh8clTy55TegSQxND8GD9A2mtzNtEr8md3jsa/7Z7rxmfIygpVQbJY
 HCiw/C09BkJ1d5wErDt/a28wDKOHWzQHia2nzLw2PQ2qfjZ6aJXE1fbfz50lAkSvE2yowIe8o
 5MzHQABhBj9sFcQp1B6JByjR+XsKI0/CxAh61tyGYZXz0Bv44J/DxgS4JmbPeDcGQoE0AoaNb
 uGFmcZPg3wGRCwXNawwLLqXZi5P6Z2NfYHOoSx7szoTdfzP379zA151Q72UNPsvNF4TG/wjgm
 FZobGuvasPHZHMQXl6P3brRlFe6TSX3Ka8ajuGP01VXxK7FjpwID4/dYNOJkP8ww3smTOewfb
 VBmwEpcQ2VjlwLpNTB6+KEuHMU90OZ5WIX1HvxxMHQs/2JKVFcF/TT7pmGfgefJlzQVVmjWUd
 FkV4fzZbGEzh3Q69m3HxcSvQCbXOBbm06LkMBbGfixJ2NMgtPAlcVBzQFgx84HhZcO0FD1i+y
 +ox+YU+Gtpb698UhAcVVnjYoL21WbmmewIqimJ88w0vQSzmUz1bOGyb1fL3TxT8dvNzKQDl3N
 EggU1iHBgY4udgxjmsWF+d6qHqrXCbmlYTiqOW0G6ExtjZ/bOzq9PnH7QSUSU968+aPWvYrRx
 WquQzXlAMWCNPVByFGHwOrnaTymOUQGQVp0ZoF2zMXokUZ5Sx4hqffd1V2bQbCnXmcm5Gzkwk
 LowgribDZgU0esEgyEcGgAwqyLwdT3brD3qf9Cs1Hxlw3lpFiQ=
Received-SPF: none client-ip=217.72.192.75; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/04 12:25:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Filip Bozuta <Filip.Bozuta@syrmia.com>, Riku Voipio <riku.voipio@iki.fi>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>, Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Filip Bozuta <Filip.Bozuta@syrmia.com>

This patch implements strace argument printing functionality for syscalls:

    *chown, lchown - change ownership of a file

        int chown(const char *pathname, uid_t owner, gid_t group)
        int lchown(const char *pathname, uid_t owner, gid_t group)
        man page: https://www.man7.org/linux/man-pages/man2/lchown.2.html

Implementation notes:

    Both syscalls use strings as arguments and thus a separate
    printing function was stated in "strace.list" for them.
    Both syscalls share the same number and types of arguments
    and thus share a same definition in file "syscall.c".
    This defintion uses existing functions "print_string()" to
    print the string argument and "print_raw_param()" to print
    other two arguments that are of basic types.

Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20200619123331.17387-6-filip.bozuta@syrmia.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/strace.c    | 15 +++++++++++++++
 linux-user/strace.list |  4 ++--
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index a26736516bab..957f08f1adf2 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -1452,6 +1452,21 @@ print_chmod(const struct syscallname *name,
 }
 #endif
 
+#if defined(TARGET_NR_chown) || defined(TARGET_NR_lchown)
+static void
+print_chown(const struct syscallname *name,
+    abi_long arg0, abi_long arg1, abi_long arg2,
+    abi_long arg3, abi_long arg4, abi_long arg5)
+{
+    print_syscall_prologue(name);
+    print_string(arg0, 0);
+    print_raw_param("%d", arg1, 0);
+    print_raw_param("%d", arg2, 1);
+    print_syscall_epilogue(name);
+}
+#define print_lchown     print_chown
+#endif
+
 #ifdef TARGET_NR_clock_adjtime
 static void
 print_clock_adjtime(const struct syscallname *name,
diff --git a/linux-user/strace.list b/linux-user/strace.list
index a4a8c61969cd..e99030c9ef39 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -71,7 +71,7 @@
 { TARGET_NR_chmod, "chmod" , NULL, print_chmod, NULL },
 #endif
 #ifdef TARGET_NR_chown
-{ TARGET_NR_chown, "chown" , NULL, NULL, NULL },
+{ TARGET_NR_chown, "chown" , NULL, print_chown, NULL },
 #endif
 #ifdef TARGET_NR_chown32
 { TARGET_NR_chown32, "chown32" , NULL, NULL, NULL },
@@ -475,7 +475,7 @@
 { TARGET_NR_kill, "kill", NULL, print_kill, NULL },
 #endif
 #ifdef TARGET_NR_lchown
-{ TARGET_NR_lchown, "lchown" , NULL, NULL, NULL },
+{ TARGET_NR_lchown, "lchown" , NULL, print_lchown, NULL },
 #endif
 #ifdef TARGET_NR_lchown32
 { TARGET_NR_lchown32, "lchown32" , NULL, NULL, NULL },
-- 
2.26.2


