Received: from eggs.gnu.org ([2001:4830:134:3::10]:54876)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nongiach@gmail.com>) id 1fpEjC-0004sj-EM
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 11:25:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nongiach@gmail.com>) id 1fpEjB-0003tP-7B
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 11:25:54 -0400
Received: from mail-yw1-xc2a.google.com ([2607:f8b0:4864:20::c2a]:35584)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <nongiach@gmail.com>) id 1fpEjB-0003sF-1H
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 11:25:53 -0400
Received: by mail-yw1-xc2a.google.com with SMTP id s68-v6so13829072ywg.2
	for <qemu-devel@nongnu.org>; Mon, 13 Aug 2018 08:25:52 -0700 (PDT)
MIME-Version: 1.0
From: nongiach nongiach <nongiach@gmail.com>
Date: Mon, 13 Aug 2018 17:25:51 +0200
Message-ID: <CABVn_oq5ij9mY7_BJe3UQfXMbNLDd_GA_L1+DSnN7TRMA2VQyA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] [qemu-web PATCH] arm_now
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, cdt-dev@eclipse.org

---
 _posts/2018-08-13-arm-now.md | 46 ++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100644 _posts/2018-08-13-arm-now.md

diff --git a/_posts/2018-08-13-arm-now.md b/_posts/2018-08-13-arm-now.md
new file mode 100644
index 0000000..f3ea3df
--- /dev/null
+++ b/_posts/2018-08-13-arm-now.md
@@ -0,0 +1,46 @@
+---
+layout: post
+title:  "arm_now: qemu out of the box for everyone"
+date:   2018-08-13 17:05:00:00 +0000
+last_modified_at: 2018-08-13 17:05:00:00 +0000
+author: @chaignc
+categories: [Wrapper, ARM, MIPS, POWERPC, x86]
+---
+
+[`arm_now`](https://github.com/nongiach/arm_now) is a qemu powered tool
that allows instant setup of
+virtual machines on arm cpu, mips, powerpc, nios2, x86 and more,
+for reverse, exploit, fuzzing and programming purpose.
+
+# Install
+
+    # pip3 install https://github.com/nongiach/arm_now/archive/master.zip
--upgrade
+
+# Start an ARM Virtual Machine
+
+    $ arm_now start armv5-eabi
+    Welcome to arm_now
+    buildroot login: root
+    # uname -m
+    armv7l
+
+# Debug the ls binary on mips
+
+    $ arm_now start mips32el
+    Welcome to arm_now
+    buildroot login: root
+    # gdb /bin/ls
+    (gdb) start
+    Temporary breakpoint 1, 0x00405434 in main ()
+    (gdb) x/i $pc
+    => 0x405434 <main+12>: li a0,-1
+
+# Why use arm_now?
+
+arm_now is just a qemu wrapper, if you have 2 minutes then you can already
start a VM using arm_now (Downloading time included).
+It's configured out of the box with a package manager, a nat network
interface and current directory syncing is one option away.
+No chroot, and no root right required to run.
+
+# Links
+
+https://github.com/nongiach/arm_now/wiki
+https://github.com/nongiach/arm_now
-- 
2.18.0
