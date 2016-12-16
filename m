Received: from eggs.gnu.org ([2001:4830:134:3::10]:37490)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cHxxT-0001aT-Vr
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 14:14:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cHxxS-0000PW-VW
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 14:14:19 -0500
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:33799)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cHxxS-0000PD-RA
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 14:14:18 -0500
Received: by mail-pg0-x241.google.com with SMTP id b1so506470pgc.1
	for <qemu-devel@nongnu.org>; Fri, 16 Dec 2016 11:14:18 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Fri, 16 Dec 2016 11:13:52 -0800
Message-Id: <20161216191405.9473-14-rth@twiddle.net>
In-Reply-To: <20161216191405.9473-1-rth@twiddle.net>
References: <20161216191405.9473-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH 13/26] linux-user: Add HPPA target_structs.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>

Cc: Riku Voipio <riku.voipio@iki.fi>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 linux-user/hppa/target_structs.h | 54 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)
 create mode 100644 linux-user/hppa/target_structs.h

diff --git a/linux-user/hppa/target_structs.h b/linux-user/hppa/target_structs.h
new file mode 100644
index 0000000..b560b18
--- /dev/null
+++ b/linux-user/hppa/target_structs.h
@@ -0,0 +1,54 @@
+/*
+ * HPPA specific structures for linux-user
+ *
+ * Copyright (c) 2016  Richard Henderson
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ */
+#ifndef HPPA_TARGET_STRUCTS_H
+#define HPPA_TARGET_STRUCTS_H
+
+struct target_ipc_perm {
+    abi_int __key;                      /* Key.  */
+    abi_uint uid;                       /* Owner's user ID.  */
+    abi_uint gid;                       /* Owner's group ID.  */
+    abi_uint cuid;                      /* Creator's user ID.  */
+    abi_uint cgid;                      /* Creator's group ID.  */
+    abi_ushort __pad1;
+    abi_ushort mode;                    /* Read/write permission.  */
+    abi_ushort __pad2;
+    abi_ushort __seq;                   /* Sequence number.  */
+    abi_uint __pad3;
+    uint64_t __unused1;
+    uint64_t __unused2;
+};
+
+struct target_shmid_ds {
+    struct target_ipc_perm shm_perm;    /* operation permission struct */
+    abi_uint __pad1;
+    abi_ulong shm_atime;                /* time of last shmat() */
+    abi_uint __pad2;
+    abi_ulong shm_dtime;                /* time of last shmdt() */
+    abi_uint __pad3;
+    abi_ulong shm_ctime;                /* time of last change by shmctl() */
+    abi_uint __pad4;
+    abi_long shm_segsz;                 /* size of segment in bytes */
+    abi_int shm_cpid;                   /* pid of creator */
+    abi_int shm_lpid;                   /* pid of last shmop */
+    abi_ulong shm_nattch;               /* number of current attaches */
+    abi_ulong __unused1;
+    abi_ulong __unused2;
+};
+
+#endif
-- 
2.9.3
