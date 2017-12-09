Received: from eggs.gnu.org ([2001:4830:134:3::10]:45161)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eNajv-0000iX-QA
	for qemu-devel@nongnu.org; Sat, 09 Dec 2017 03:44:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eNajr-0006pP-Uh
	for qemu-devel@nongnu.org; Sat, 09 Dec 2017 03:44:07 -0500
Received: from 2.mo6.mail-out.ovh.net ([46.105.76.65]:37173)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1eNajr-0006or-Pf
	for qemu-devel@nongnu.org; Sat, 09 Dec 2017 03:44:03 -0500
Received: from player735.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id 5C3E812605C
	for <qemu-devel@nongnu.org>; Sat,  9 Dec 2017 09:44:02 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Sat,  9 Dec 2017 09:43:20 +0100
Message-Id: <20171209084338.29395-2-clg@kaod.org>
In-Reply-To: <20171209084338.29395-1-clg@kaod.org>
References: <20171209084338.29395-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 01/19] dma-helpers: add a return value to
 store helpers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Greg Kurz <groug@kaod.org>
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/sysemu/dma.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/sysemu/dma.h b/include/sysemu/dma.h
index c228c6651360..74a9558af39c 100644
--- a/include/sysemu/dma.h
+++ b/include/sysemu/dma.h
@@ -153,12 +153,12 @@ static inline void dma_memory_unmap(AddressSpace *a=
s,
         dma_memory_read(as, addr, &val, (_bits) / 8);                   =
\
         return _end##_bits##_to_cpu(val);                               =
\
     }                                                                   =
\
-    static inline void st##_sname##_##_end##_dma(AddressSpace *as,      =
\
+    static inline int st##_sname##_##_end##_dma(AddressSpace *as,      \
                                                  dma_addr_t addr,       =
\
                                                  uint##_bits##_t val)   =
\
     {                                                                   =
\
         val =3D cpu_to_##_end##_bits(val);                              =
  \
-        dma_memory_write(as, addr, &val, (_bits) / 8);                  =
\
+        return dma_memory_write(as, addr, &val, (_bits) / 8);           =
\
     }
=20
 static inline uint8_t ldub_dma(AddressSpace *as, dma_addr_t addr)
--=20
2.13.6
