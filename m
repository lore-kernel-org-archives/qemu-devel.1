Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DFEAC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 15:28:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 159852073E
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 15:28:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 159852073E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jr18T-0002Fl-9p
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 11:28:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43172)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jr17V-0000SC-6T
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 11:27:25 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:53833)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jr17R-0006IG-Ix
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 11:27:24 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MTi9N-1jMved0xQr-00U4JY; Thu, 02 Jul 2020 17:27:18 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL v2 07/12] linux-user: Add strace support for printing arguments
 of lseek()
Date: Thu,  2 Jul 2020 17:27:05 +0200
Message-Id: <20200702152710.84602-8-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200702152710.84602-1-laurent@vivier.eu>
References: <20200702152710.84602-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:MS247B+cncjovVzKNv2NhuUL3/8iqUyBUSgZ1hmQE++EIQRwNLx
 jPatrNpAbmjUICNEd57J0k/QUUFuj9TzuXgX5AJfBsjUieDK6M1j/XgpD/PE2uXLjFc6t64
 sVASvCdKUXeBnrJGNBhN5Lw+Vmlosbmhkf4FQKBZ7m2+xk9xbOwXnS5dDFR0zWJfNYl/Vx1
 kZDmwn/k7Xclxcouw3lag==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kyeEI88sOJk=:Y2bHPOyoGrJ7VtdQhmFkzS
 inZq9SICvnStcpBuYQw2yD0iNAMIUI2p1sEKiPlZV8MCmRsNUJ3Bu/j0LCzXqcXtgAkCxa61I
 2rmF5QRNzsoA7AL/8ZHJjWTLLVpdlAYnDOyp1csm+BNExfT+70mEnlOgQhXT/JZpdBwinRM0J
 QqQ6GDloQjkTausxe9zXZdGD1bL7yWP+Y/T05JDOaq5vd2iUiwWIu4Hq5WbfHl8KYNBwcklX9
 Lp4pEMOQrxH3Y9Csb9JXH+9hb+bnmJggUzqUwbIRKWK0l4NVAa7mIGEheyLJr/8s2GFxF/2/o
 FMf59gct92nJOGPQiQNzt+6Yu2TW/lpH10Zd1A2P+NjyBUZAAX0JEJpeGl8dOXmuy+128aTHz
 JQdYNZ1yCIi/e0/w+5Y7iR1yUKG20epHZ2RiAaPNpl1lS2ZSrMKzmtjLrY3dadydAaPF+waBJ
 amMUy5/WIG7Km7Hxf/3L22u+W+kiSiu7yFlL5G/o91jiLbWm+S5P9/bvhE/v8F2cJo4Zeew7Y
 wX2Fs32eZnSuhqcQ4N9+mCyg+/sbwdikrwtuBSvX2568mjUxvtTczyJ9Wlg7ggtJ4hOoceZ4Q
 QLwFxa/n5UD0Owv3lkHphRVFSgo8gVC1PjmaONp3U72BUR0dlYgjAwK+ATHjq8tSdR86ILWN5
 DQTf9yeZrR7XSMQqoK5Q+5nw/nDAHwSrAggmiorIZui/d15YzQ6Sg4We/YbzYjua2O/Yvnk+O
 +CxehaHRa6Ik/OlbTxHdP5aXr59fYmBew/baAQoKrZY1spZNkG8q2AAQpx5W+3mGvWoa0EgSj
 WUJ7H+878L4p64HSqjOPtWClvFZ1dwQXLOBQXSlCASaYaO/PUc=
Received-SPF: none client-ip=212.227.126.133; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 11:27:18
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

This patch implements strace argument printing functionality for syscall:

    *lseek - reposition read/write file offset

         off_t lseek(int fd, off_t offset, int whence)
         man page: https://www.man7.org/linux/man-pages/man2/lseek.2.html

Implementation notes:

    The syscall's third argument "whence" has predefined values:
    "SEEK_SET","SEEK_CUR","SEEK_END","SEEK_DATA","SEEK_HOLE"
    and thus a separate printing function "print_lseek" was stated
    in file "strace.list". This function is defined in "strace.c"
    by using an existing function "print_raw_param()" to print
    the first and second argument and a switch(case) statement
    for the predefined values of the third argument.
    Values "SEEK_DATA" and "SEEK_HOLE" are defined in kernel version 3.1.
    That is the reason why case statements for these values are
    enwrapped in #ifdef directive.

Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20200619123331.17387-5-filip.bozuta@syrmia.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/strace.c    | 31 +++++++++++++++++++++++++++++++
 linux-user/strace.list |  2 +-
 2 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index 760020132b5a..a26736516bab 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -1833,6 +1833,37 @@ print__llseek(const struct syscallname *name,
 }
 #endif
 
+#ifdef TARGET_NR_lseek
+static void
+print_lseek(const struct syscallname *name,
+    abi_long arg0, abi_long arg1, abi_long arg2,
+    abi_long arg3, abi_long arg4, abi_long arg5)
+{
+    print_syscall_prologue(name);
+    print_raw_param("%d", arg0, 0);
+    print_raw_param(TARGET_ABI_FMT_ld, arg1, 0);
+    switch (arg2) {
+    case SEEK_SET:
+        qemu_log("SEEK_SET"); break;
+    case SEEK_CUR:
+        qemu_log("SEEK_CUR"); break;
+    case SEEK_END:
+        qemu_log("SEEK_END"); break;
+#ifdef SEEK_DATA
+    case SEEK_DATA:
+        qemu_log("SEEK_DATA"); break;
+#endif
+#ifdef SEEK_HOLE
+    case SEEK_HOLE:
+        qemu_log("SEEK_HOLE"); break;
+#endif
+    default:
+        print_raw_param("%#x", arg2, 1);
+    }
+    print_syscall_epilogue(name);
+}
+#endif
+
 #if defined(TARGET_NR_socket)
 static void
 print_socket(const struct syscallname *name,
diff --git a/linux-user/strace.list b/linux-user/strace.list
index d04ad507b0fb..a4a8c61969cd 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -516,7 +516,7 @@
 { TARGET_NR_lremovexattr, "lremovexattr" , NULL, print_lremovexattr, NULL },
 #endif
 #ifdef TARGET_NR_lseek
-{ TARGET_NR_lseek, "lseek" , NULL, NULL, NULL },
+{ TARGET_NR_lseek, "lseek" , NULL, print_lseek, NULL },
 #endif
 #ifdef TARGET_NR_lsetxattr
 { TARGET_NR_lsetxattr, "lsetxattr" , NULL, NULL, NULL },
-- 
2.26.2


