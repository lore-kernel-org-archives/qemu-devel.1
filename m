Received: from eggs.gnu.org ([2001:4830:134:3::10]:44144)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <SRS0=y3pv=Z6=redhat.com=mst@kernel.org>)
	id 1ceobp-000438-0H
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 14:54:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <SRS0=y3pv=Z6=redhat.com=mst@kernel.org>)
	id 1ceobm-0005Un-7U
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 14:54:25 -0500
Received: from mail.kernel.org ([198.145.29.136]:34332)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <SRS0=y3pv=Z6=redhat.com=mst@kernel.org>)
	id 1ceobm-0005UJ-0d
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 14:54:22 -0500
Date: Fri, 17 Feb 2017 21:54:17 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1487361200-29966-8-git-send-email-mst@redhat.com>
References: <1487361200-29966-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1487361200-29966-1-git-send-email-mst@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 07/23] exec: make address_space_cache_destroy
 idempotent
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>

From: Paolo Bonzini <pbonzini@redhat.com>

Clear cache->mr so that address_space_cache_destroy does nothing
the second time it is called.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 exec.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/exec.c b/exec.c
index 6fa337b..865a1e8 100644
--- a/exec.c
+++ b/exec.c
@@ -3166,6 +3166,7 @@ void address_space_cache_destroy(MemoryRegionCache =
*cache)
         xen_invalidate_map_cache_entry(cache->ptr);
     }
     memory_region_unref(cache->mr);
+    cache->mr =3D NULL;
 }
=20
 /* Called from RCU critical section.  This function has the same
--=20
MST
