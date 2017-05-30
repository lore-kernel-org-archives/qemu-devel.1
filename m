Received: from eggs.gnu.org ([2001:4830:134:3::10]:37170)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dFkBQ-0007LN-7Z
	for qemu-devel@nongnu.org; Tue, 30 May 2017 12:39:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dFkBP-0003uI-6e
	for qemu-devel@nongnu.org; Tue, 30 May 2017 12:39:48 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37133)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1dFkBO-0003s6-Rf
	for qemu-devel@nongnu.org; Tue, 30 May 2017 12:39:47 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 May 2017 17:39:35 +0100
Message-Id: <1496162375-1571-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH risu] ppc64.risu: Fix broken constraints
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, Sandipan Das <sandipandas1990@gmail.com>, Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Commit c10b97092 changed some field names in rldicr and rldimi patterns
but forgot to update the constraints to match the change. Since the
field (previously 'rb' and now 'sh') is an immediate rather than a
register number, the correct fix is to just delete the constraint
since we don't need to avoid particular values.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 ppc64.risu | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/ppc64.risu b/ppc64.risu
index dd304e2..e2fd4f6 100644
--- a/ppc64.risu
+++ b/ppc64.risu
@@ -1473,17 +1473,17 @@ RLDICLd PPC64LE 011110 rs:5 ra:5 sh:5 mb:6 000 sha:1 1 \
 
 # format:MD book:I page:105 PPC SR rldicr[.] Rotate Left Dword Immediate then Clear Right
 RLDICR PPC64LE 011110 rs:5 ra:5 sh:5 me:6 001 sha:1 0 \
-!constraints { $rs != 1 && $ra != 1 && $rb != 1 && $rs != 13 && $ra != 13 && $rb != 13; }
+!constraints { $rs != 1 && $ra != 1 && $rs != 13 && $ra != 13; }
 # format:MD book:I page:105 PPC SR rldicr[.] Rotate Left Dword Immediate then Clear Right
 RLDICRd PPC64LE 011110 rs:5 ra:5 sh:5 me:6 001 sha:1 1 \
-!constraints { $rs != 1 && $ra != 1 && $rb != 1 && $rs != 13 && $ra != 13 && $rb != 13; }
+!constraints { $rs != 1 && $ra != 1 && $rs != 13 && $ra != 13; }
 
 # format:MD book:I page:105 PPC SR rldimi[.] Rotate Left Dword Immediate then Mask Insert
 RLDIMI PPC64LE 011110 rs:5 ra:5 sh:5 me:6 011 sha:1 0 \
-!constraints { $rs != 1 && $ra != 1 && $rb != 1 && $rs != 13 && $ra != 13 && $rb != 13; }
+!constraints { $rs != 1 && $ra != 1 && $rs != 13 && $ra != 13; }
 # format:MD book:I page:105 PPC SR rldimi[.] Rotate Left Dword Immediate then Mask Insert
 RLDIMId PPC64LE 011110 rs:5 ra:5 sh:5 me:6 011 sha:1 1 \
-!constraints { $rs != 1 && $ra != 1 && $rb != 1 && $rs != 13 && $ra != 13 && $rb != 13; }
+!constraints { $rs != 1 && $ra != 1 && $rs != 13 && $ra != 13; }
 
 # format:M book:I page:102 v:P1 SR rlwimi[.] Rotate Left Word Immediate then Mask Insert
 RLWIMI PPC64LE 010100 rs:5 ra:5 sh:5 mb:5 me:5 0 \
-- 
2.7.4
