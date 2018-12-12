Received: from eggs.gnu.org ([2001:4830:134:3::10]:35172)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1gX8LD-00070E-HL
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 12:30:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1gX8L8-00017S-DW
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 12:30:35 -0500
From: Laurent Vivier <lvivier@redhat.com>
Date: Wed, 12 Dec 2018 18:30:07 +0100
Message-Id: <20181212173007.11407-7-lvivier@redhat.com>
In-Reply-To: <20181212173007.11407-1-lvivier@redhat.com>
References: <20181212173007.11407-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 6/6] unicore32/puv3: remove definition of
 DPRINTF
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-trivial@nongnu.org, Guan Xuetao <gxt@mprc.pku.edu.cn>, Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <lvivier@redhat.com>

As previous patches have removed the use of DPRINTF from puv3 files,
we can remove the definition from puv3.h

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 include/hw/unicore32/puv3.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/include/hw/unicore32/puv3.h b/include/hw/unicore32/puv3.h
index f587a1f622..a876f21dfb 100644
--- a/include/hw/unicore32/puv3.h
+++ b/include/hw/unicore32/puv3.h
@@ -30,11 +30,4 @@
 #define PUV3_IRQS_PS2_AUX       (23)
 #define PUV3_IRQS_OST0          (26)
=20
-/* All puv3_*.c use DPRINTF for debug. */
-#ifdef DEBUG_PUV3
-#define DPRINTF(fmt, ...) printf("%s: " fmt , __func__, ## __VA_ARGS__)
-#else
-#define DPRINTF(fmt, ...) do {} while (0)
-#endif
-
 #endif /* QEMU_HW_PUV3_H */
--=20
2.19.2
