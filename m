Received: from eggs.gnu.org ([209.51.188.92]:55540)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gydbu-0007FN-UT
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 09:21:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gydbt-00031v-2g
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 09:21:30 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37756)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gydbq-0002yH-UQ
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 09:21:28 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x1QEJIIj074458
	for <qemu-devel@nongnu.org>; Tue, 26 Feb 2019 09:21:15 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2qw74085an-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 26 Feb 2019 09:21:14 -0500
Received: from localhost
	by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Tue, 26 Feb 2019 14:21:12 -0000
From: Greg Kurz <groug@kaod.org>
Date: Tue, 26 Feb 2019 15:21:07 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <155119086741.1037569.12734854713022304642.stgit@bahia.lan>
Subject: [Qemu-devel] [PATCH] bswap: Fix accessors syntax in comment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Laurent Vivier <lvivier@redhat.com>

All accessors that have an endian infix DO have an underscore between
{size} and {endian}.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 include/qemu/bswap.h |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/qemu/bswap.h b/include/qemu/bswap.h
index a684c1a7a298..5a70f78c0ba4 100644
--- a/include/qemu/bswap.h
+++ b/include/qemu/bswap.h
@@ -255,9 +255,9 @@ typedef union {
 /*
  * the generic syntax is:
  *
- * load: ld{type}{sign}{size}{endian}_p(ptr)
+ * load: ld{type}{sign}{size}_{endian}_p(ptr)
  *
- * store: st{type}{size}{endian}_p(ptr, val)
+ * store: st{type}{size}_{endian}_p(ptr, val)
  *
  * Note there are small differences with the softmmu access API!
  *
@@ -293,10 +293,10 @@ typedef union {
  *
  * For cases where the size to be used is not fixed at compile time,
  * there are
- *  stn{endian}_p(ptr, sz, val)
+ *  stn_{endian}_p(ptr, sz, val)
  * which stores @val to @ptr as an @endian-order number @sz bytes in size
  * and
- *  ldn{endian}_p(ptr, sz)
+ *  ldn_{endian}_p(ptr, sz)
  * which loads @sz bytes from @ptr as an unsigned @endian-order number
  * and returns it in a uint64_t.
  */
