Received: from eggs.gnu.org ([209.51.188.92]:57654)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1goOuj-0001l0-M1
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 03:38:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1goOuh-0001rB-KJ
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 03:38:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34534)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1goOue-0001mT-Lc
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 03:38:34 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Tue, 29 Jan 2019 09:38:07 +0100
Message-Id: <20190129083807.11681-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] tests/test-qga: Reenable guest-agent qtest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Juan Quintela <quintela@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

Due to a misuse of rules.mak logical functions, commit f386df17448
disabled the guest-agent test.
Enable it back.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
>From rules.mak:

  # Logical functions (for operating on y/n values like CONFIG_FOO vars)
  # Usage: $(call land,$(CONFIG_FOO),$(CONFIG_BAR))
---
 tests/Makefile.include | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 19b4c0a696..172128b058 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -110,7 +110,7 @@ check-unit-y +=3D tests/test-crypto-secret$(EXESUF)
 check-unit-$(CONFIG_GNUTLS) +=3D tests/test-crypto-tlscredsx509$(EXESUF)
 check-unit-$(CONFIG_GNUTLS) +=3D tests/test-crypto-tlssession$(EXESUF)
 ifneq (,$(findstring qemu-ga,$(TOOLS)))
-check-unit-$(land,$(CONFIG_LINUX),$(CONFIG_VIRTIO_SERIAL)) +=3D tests/te=
st-qga$(EXESUF)
+check-unit-$(call land,$(CONFIG_LINUX),$(CONFIG_VIRTIO_SERIAL)) +=3D tes=
ts/test-qga$(EXESUF)
 endif
 check-unit-y +=3D tests/test-timed-average$(EXESUF)
 check-unit-y +=3D tests/test-util-sockets$(EXESUF)
--=20
2.20.1
