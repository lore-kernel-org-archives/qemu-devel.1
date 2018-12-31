Received: from eggs.gnu.org ([208.118.235.92]:57231)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gdz18-0005g0-6v
	for qemu-devel@nongnu.org; Mon, 31 Dec 2018 09:58:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gdz17-00042K-4q
	for qemu-devel@nongnu.org; Mon, 31 Dec 2018 09:58:10 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:60616 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gdz16-0003os-Tl
	for qemu-devel@nongnu.org; Mon, 31 Dec 2018 09:58:09 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon, 31 Dec 2018 15:56:11 +0100
Message-Id: <1546268200-26966-16-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1546268200-26966-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1546268200-26966-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PULL v2 15/44] disas: nanoMIPS: Fix preamble text in
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
Cc: peter.maydell@linaro.org, amarkovic@wavecomp.com

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Fix several mistakes in preambles of nanomips disassembler source
files.

Reviewed-by: Aleksandar Rikalo <arikalo@wavecomp.com>
Reviewed-by: Stefan Markovic <smarkovic@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 disas/nanomips.cpp | 7 ++++---
 disas/nanomips.h   | 7 ++++---
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/disas/nanomips.cpp b/disas/nanomips.cpp
index 28d78d6..e082a3f 100644
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
index 71428b3..c7477c2 100644
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
