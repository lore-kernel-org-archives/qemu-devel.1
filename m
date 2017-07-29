Received: from eggs.gnu.org ([2001:4830:134:3::10]:34286)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dbRXR-0005Hq-2q
	for qemu-devel@nongnu.org; Sat, 29 Jul 2017 09:12:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dbRXN-00067Q-Qp
	for qemu-devel@nongnu.org; Sat, 29 Jul 2017 09:12:13 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:45660 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dbRXN-00062f-Fc
	for qemu-devel@nongnu.org; Sat, 29 Jul 2017 09:12:09 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Sat, 29 Jul 2017 16:11:56 +0300
Message-Id: <20170729131159.24949-2-vsementsov@virtuozzo.com>
In-Reply-To: <20170729131159.24949-1-vsementsov@virtuozzo.com>
References: <20170729131159.24949-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v2 1/4] coding_style: add point about 0x in
 trace-events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, eblake@redhat.com, mreitz@redhat.com, jsnow@redhat.com, vsementsov@virtuozzo.com, den@openvz.org, stefanha@gmail.com, peter.maydell@linaro.org, berrange@redhat.com

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 CODING_STYLE | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/CODING_STYLE b/CODING_STYLE
index 2fa0c0b65b..2e6a0507be 100644
--- a/CODING_STYLE
+++ b/CODING_STYLE
@@ -123,3 +123,26 @@ We use traditional C-style /* */ comments and avoid // comments.
 
 Rationale: The // form is valid in C99, so this is purely a matter of
 consistency of style. The checkpatch script will warn you about this.
+
+8. trace-events style
+
+In trace-events files use '0x' prefix to specify hex numbers, as in:
+
+some_trace(unsigned x, uint64_t y) "x 0x%x y 0x" PRIx64
+
+The exclusion is a group of numbers, separated by symbols '.', '/', ':', ' ':
+
+some_other_trace(unsigned a, unsigned b, unsigned c) "num %x.%x.%x"
+
+However, you can use '0x' for such groups if you want. Anyway, be sure that
+it is obvious that numbers are in hex, ex.:
+
+data_dump(uint8_t c1, uint8_t c2, uint8_t c3) "bytes (in hex): %02x %02x %02x"
+
+For consistency do not use printf flag '#', like '%#x'.
+
+Rationale: hex numbers are hard to read in logs when there no 0x prefix,
+especially when (occasionally) the representation doesn't contain any letters
+and especially in one line with other decimal numbers. Number groups are
+allowed to not use '0x' because for some things notations like %x.%x.%x are
+used not only in Qemu. Also dumping raw data bytes with '0x' is less readable.
-- 
2.11.1
