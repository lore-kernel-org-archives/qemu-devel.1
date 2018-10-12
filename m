Received: from eggs.gnu.org ([2001:4830:134:3::10]:33015)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gAlDw-0005Rs-LR
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 20:22:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gAlDt-0004uf-AP
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 20:22:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50062)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gAlDt-0004t8-3A
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 20:22:33 -0400
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Fri, 12 Oct 2018 02:22:07 +0200
Message-Id: <20181012002217.2864-2-philmd@redhat.com>
In-Reply-To: <20181012002217.2864-1-philmd@redhat.com>
References: <20181012002217.2864-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 01/11] hw/ipmi: Remove unnecessary
 declarations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Prasad J Pandit <ppandit@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, qemu-devel@nongnu.org, Corey Minyard <minyard@acm.org>

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/ipmi/ipmi_bmc_extern.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/hw/ipmi/ipmi_bmc_extern.c b/hw/ipmi/ipmi_bmc_extern.c
index bf0b7ee0f5..8c78b9804b 100644
--- a/hw/ipmi/ipmi_bmc_extern.c
+++ b/hw/ipmi/ipmi_bmc_extern.c
@@ -85,10 +85,6 @@ typedef struct IPMIBmcExtern {
     bool send_reset;
 } IPMIBmcExtern;
=20
-static int can_receive(void *opaque);
-static void receive(void *opaque, const uint8_t *buf, int size);
-static void chr_event(void *opaque, int event);
-
 static unsigned char
 ipmb_checksum(const unsigned char *data, int size, unsigned char start)
 {
--=20
2.17.1
