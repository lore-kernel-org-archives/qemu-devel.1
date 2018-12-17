Received: from eggs.gnu.org ([2001:4830:134:3::10]:48498)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gYvXv-00046c-1u
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 11:15:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gYvXr-00045Q-De
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 11:15:06 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:36748 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gYvXo-0003Uq-In
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 11:15:00 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon, 17 Dec 2018 17:13:43 +0100
Message-Id: <20181217161347.4270-2-aleksandar.markovic@rt-rk.com>
In-Reply-To: <20181217161347.4270-1-aleksandar.markovic@rt-rk.com>
References: <20181217161347.4270-1-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH 1/5] disas: nanoMIPS: Fix preamble text
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, smarkovic@wavecomp.com, amarkovic@wavecomp.com

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Fix several mistakes in preambles of nanomips disassembler source
files.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 disas/nanomips.cpp | 7 ++++---
 disas/nanomips.h   | 7 ++++---
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/disas/nanomips.cpp b/disas/nanomips.cpp
index 1238c2ff33..f9ef0a25f4 100644
--- a/disas/nanomips.cpp
+++ b/disas/nanomips.cpp
@@ -1,13 +1,13 @@
 /*
  *  Source file for nanoMIPS disassembler component of QEMU
  *
- *  Copyright (C) 2018  Wave Computing
+ *  Copyright (C) 2018  Wave Computing, Inc.
  *  Copyright (C) 2018  Matthew Fortune <matthew.fortune@mips.com>
- *  Copyright (C) 2018  Aleksandar Markovic <aleksandar.markovic@wavecomp.com>
+ *  Copyright (C) 2018  Aleksandar Markovic <amarkovic@wavecomp.com>
  *
  *  This program is free software: you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation, either version 3 of the License, or
+ *  the Free Software Foundation, either version 2 of the License, or
  *  (at your option) any later version.
  *
  *  This program is distributed in the hope that it will be useful,
@@ -17,6 +17,7 @@
  *
  *  You should have received a copy of the GNU General Public License
  *  along with this program.  If not, see <https://www.gnu.org/licenses/>.
+ *
  */
 
 extern "C" {
diff --git a/disas/nanomips.h b/disas/nanomips.h
index 84cc9a6dfc..3df138d63f 100644
--- a/disas/nanomips.h
+++ b/disas/nanomips.h
@@ -1,13 +1,13 @@
 /*
  *  Header file for nanoMIPS disassembler component of QEMU
  *
- *  Copyright (C) 2018  Wave Computing
+ *  Copyright (C) 2018  Wave Computing, Inc.
  *  Copyright (C) 2018  Matthew Fortune <matthew.fortune@mips.com>
- *  Copyright (C) 2018  Aleksandar Markovic <aleksandar.markovic@wavecomp.com>
+ *  Copyright (C) 2018  Aleksandar Markovic <amarkovic@wavecomp.com>
  *
  *  This program is free software: you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation, either version 3 of the License, or
+ *  the Free Software Foundation, either version 2 of the License, or
  *  (at your option) any later version.
  *
  *  This program is distributed in the hope that it will be useful,
@@ -17,6 +17,7 @@
  *
  *  You should have received a copy of the GNU General Public License
  *  along with this program.  If not, see <https://www.gnu.org/licenses/>.
+ *
  */
 
 #ifndef NANOMIPS_DISASSEMBLER_H
-- 
2.17.1
