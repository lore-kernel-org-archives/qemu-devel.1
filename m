Received: from eggs.gnu.org ([208.118.235.92]:57018)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gc72X-0007yV-PO
	for qemu-devel@nongnu.org; Wed, 26 Dec 2018 06:07:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gc72W-0001s2-Ns
	for qemu-devel@nongnu.org; Wed, 26 Dec 2018 06:07:53 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:53936 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gc72W-0001Cv-Fq
	for qemu-devel@nongnu.org; Wed, 26 Dec 2018 06:07:52 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Wed, 26 Dec 2018 12:06:09 +0100
Message-Id: <1545822388-10911-2-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1545822388-10911-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1545822388-10911-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v5 01/20] disas: nanoMIPS: Fix preamble text in
 nanomips.* files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, amarkovic@wavecomp.com, smarkovic@wavecomp.com

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Fix several mistakes in preambles of nanomips disassembler source
files.

Reviewed-by: Stefan Markovic <smarkovic@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 disas/nanomips.cpp | 7 ++++---
 disas/nanomips.h   | 7 ++++---
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/disas/nanomips.cpp b/disas/nanomips.cpp
index 1238c2f..f9ef0a2 100644
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
index 84cc9a6..3df138d 100644
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
2.7.4
