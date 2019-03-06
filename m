Received: from eggs.gnu.org ([209.51.188.92]:35415)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1h1UPS-00054S-Fq
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 06:08:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1h1UPQ-0002HC-4V
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 06:08:26 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Wed,  6 Mar 2019 12:07:08 +0100
Message-Id: <20190306110711.309-8-laurent@vivier.eu>
In-Reply-To: <20190306110711.309-1-laurent@vivier.eu>
References: <20190306110711.309-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 07/10] bswap: Fix accessors syntax in comment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Riku Voipio <riku.voipio@iki.fi>, Zhang Chen <zhangckid@gmail.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Richard Henderson <rth@twiddle.net>, Thomas Huth <thuth@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, John Snow <jsnow@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Laurent Vivier <laurent@vivier.eu>, Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Tony Krowiak <akrowiak@linux.ibm.com>, Max Reitz <mreitz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-trivial@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>, qemu-s390x@nongnu.org, Corey Minyard <minyard@acm.org>, Pierre Morel <pmorel@linux.ibm.com>, Greg Kurz <groug@kaod.org>, Richard Henderson <richard.henderson@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

From: Greg Kurz <groug@kaod.org>

All accessors that have an endian infix DO have an underscore between
{size} and {endian}.

Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <155119086741.1037569.12734854713022304642.stgit@bahia.lan>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 include/qemu/bswap.h | 8 ++++----
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
-- 
2.20.1
