Received: from eggs.gnu.org ([209.51.188.92]:51521)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gzKny-0001ru-8w
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 07:28:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gzKnw-0007q1-8S
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 07:28:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35470)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gzKnv-0007gO-MN
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 07:28:47 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Thu, 28 Feb 2019 13:27:54 +0100
Message-Id: <1551356875-30676-13-git-send-email-thuth@redhat.com>
In-Reply-To: <1551356875-30676-1-git-send-email-thuth@redhat.com>
References: <1551356875-30676-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 12/13] tests/test-qga: Reenable guest-agent qtest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Due to a misuse of rules.mak logical functions, commit f386df17448
disabled the guest-agent test.
Enable it back.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Laurent Vivier <lvivier@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/Makefile.include | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 370de59..4154da2 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -112,7 +112,7 @@ check-unit-y +=3D tests/test-crypto-secret$(EXESUF)
 check-unit-$(CONFIG_GNUTLS) +=3D tests/test-crypto-tlscredsx509$(EXESUF)
 check-unit-$(CONFIG_GNUTLS) +=3D tests/test-crypto-tlssession$(EXESUF)
 ifneq (,$(findstring qemu-ga,$(TOOLS)))
-check-unit-$(land,$(CONFIG_LINUX),$(CONFIG_VIRTIO_SERIAL)) +=3D tests/te=
st-qga$(EXESUF)
+check-unit-$(call land,$(CONFIG_LINUX),$(CONFIG_VIRTIO_SERIAL)) +=3D tes=
ts/test-qga$(EXESUF)
 endif
 check-unit-y +=3D tests/test-timed-average$(EXESUF)
 check-unit-$(CONFIG_INOTIFY1) +=3D tests/test-util-filemonitor$(EXESUF)
--=20
1.8.3.1
