Received: from eggs.gnu.org ([2001:4830:134:3::10]:38550)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1e22Bs-0001tR-QM
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 17:35:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1e22Bn-0001N8-Rw
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 17:35:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47486)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1e22Bn-0001Ms-MH
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 17:35:47 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 10 Oct 2017 23:34:41 +0200
Message-Id: <20171010213506.22989-3-marcandre.lureau@redhat.com>
In-Reply-To: <20171010213506.22989-1-marcandre.lureau@redhat.com>
References: <20171010213506.22989-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 02/27] build-sys: fix libvhost-user.a build
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, changpeng.liu@intel.com, f4bug@amsat.org, felipe@nutanix.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

And actually link to it from vhost-user-bridge.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
 Makefile               | 1 +
 tests/Makefile.include | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index cee6e28659..64d3a9e244 100644
--- a/Makefile
+++ b/Makefile
@@ -357,6 +357,7 @@ Makefile: $(version-obj-y)
 # Build libraries
=20
 libqemuutil.a: $(util-obj-y) $(trace-obj-y) $(stub-obj-y)
+libvhost-user.a: $(libvhost-user-obj-y)
=20
 ######################################################################
=20
diff --git a/tests/Makefile.include b/tests/Makefile.include
index abc6707ef2..4ca15e6817 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -795,7 +795,7 @@ tests/test-filter-redirector$(EXESUF): tests/test-fil=
ter-redirector.o $(qtest-ob
 tests/test-x86-cpuid-compat$(EXESUF): tests/test-x86-cpuid-compat.o $(qt=
est-obj-y)
 tests/ivshmem-test$(EXESUF): tests/ivshmem-test.o contrib/ivshmem-server=
/ivshmem-server.o $(libqos-pc-obj-y) $(libqos-spapr-obj-y)
 tests/megasas-test$(EXESUF): tests/megasas-test.o $(libqos-spapr-obj-y) =
$(libqos-pc-obj-y)
-tests/vhost-user-bridge$(EXESUF): tests/vhost-user-bridge.o contrib/libv=
host-user/libvhost-user.o $(test-util-obj-y)
+tests/vhost-user-bridge$(EXESUF): tests/vhost-user-bridge.o $(test-util-=
obj-y) libvhost-user.a
 tests/test-uuid$(EXESUF): tests/test-uuid.o $(test-util-obj-y)
 tests/test-arm-mptimer$(EXESUF): tests/test-arm-mptimer.o
 tests/test-qapi-util$(EXESUF): tests/test-qapi-util.o $(test-util-obj-y)
--=20
2.15.0.rc0.40.gaefcc5f6f
