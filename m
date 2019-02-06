Received: from eggs.gnu.org ([209.51.188.92]:55869)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1grP81-00009Q-UD
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 10:28:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1grP80-0004PO-4Q
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 10:28:45 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Wed,  6 Feb 2019 16:28:02 +0100
Message-Id: <20190206152807.31896-3-laurent@vivier.eu>
In-Reply-To: <20190206152807.31896-1-laurent@vivier.eu>
References: <20190206152807.31896-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 2/7] target/moxie: Fix LGPL information in the
 file headers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Eduardo Habkost <ehabkost@redhat.com>, qemu-trivial@nongnu.org, Anthony Green <green@moxielogic.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-arm@nongnu.org, Andrzej Zaborowski <balrogg@gmail.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Michael Tokarev <mjt@tls.msk.ru>, Peter Maydell <peter.maydell@linaro.org>, Artyom Tarasenko <atar4qemu@gmail.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Thomas Huth <thuth@redhat.com>, Richard Henderson <richard.henderson@linaro.org>

From: Thomas Huth <thuth@redhat.com>

It's either "GNU *Library* General Public License version 2" or "GNU
Lesser General Public License version *2.1*", but there was no "version
2.0" of the "Lesser" license. So assume that version 2.1 is meant here.
Also the files mentioned the GPL instead of the LGPL after declaring
that the files are licensed under the LGPL, so change these spots to
use LGPL, too.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Acked-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <1549266858-5043-1-git-send-email-thuth@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 target/moxie/cpu.c       | 2 +-
 target/moxie/cpu.h       | 4 ++--
 target/moxie/helper.c    | 4 ++--
 target/moxie/mmu.c       | 4 ++--
 target/moxie/translate.c | 4 ++--
 5 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/target/moxie/cpu.c b/target/moxie/cpu.c
index 8d67eb6727..46434e65ba 100644
--- a/target/moxie/cpu.c
+++ b/target/moxie/cpu.c
@@ -13,7 +13,7 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  * Lesser General Public License for more details.
  *
- * You should have received a copy of the GNU General Public License
+ * You should have received a copy of the GNU Lesser General Public License
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
diff --git a/target/moxie/cpu.h b/target/moxie/cpu.h
index d40f1e6c45..080df4ee6f 100644
--- a/target/moxie/cpu.h
+++ b/target/moxie/cpu.h
@@ -6,14 +6,14 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  * Lesser General Public License for more details.
  *
- * You should have received a copy of the GNU General Public License
+ * You should have received a copy of the GNU Lesser General Public License
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
diff --git a/target/moxie/helper.c b/target/moxie/helper.c
index 5b1532b837..f3d8ee7d6b 100644
--- a/target/moxie/helper.c
+++ b/target/moxie/helper.c
@@ -6,14 +6,14 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  * Lesser General Public License for more details.
  *
- * You should have received a copy of the GNU General Public License
+ * You should have received a copy of the GNU Lesser General Public License
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
diff --git a/target/moxie/mmu.c b/target/moxie/mmu.c
index bd90b1eebc..87783a36f8 100644
--- a/target/moxie/mmu.c
+++ b/target/moxie/mmu.c
@@ -6,14 +6,14 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  * Lesser General Public License for more details.
  *
- * You should have received a copy of the GNU General Public License
+ * You should have received a copy of the GNU Lesser General Public License
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
diff --git a/target/moxie/translate.c b/target/moxie/translate.c
index 29da02bc05..68ca223e22 100644
--- a/target/moxie/translate.c
+++ b/target/moxie/translate.c
@@ -5,7 +5,7 @@
  *
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public License
- * as published by the Free Software Foundation; either version 2 of
+ * as published by the Free Software Foundation; either version 2.1 of
  * the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful, but
@@ -13,7 +13,7 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  * Lesser General Public License for more details.
  *
- * You should have received a copy of the GNU General Public License
+ * You should have received a copy of the GNU Lesser General Public License
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
-- 
2.20.1
