Received: from eggs.gnu.org ([2001:4830:134:3::10]:45900)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1duLlQ-00059W-7g
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 12:52:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1duLlL-0001Md-OY
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 12:52:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46816)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1duLlL-0001Lz-IV
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 12:52:43 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 19 Sep 2017 18:52:01 +0200
Message-Id: <20170919165226.23022-3-marcandre.lureau@redhat.com>
In-Reply-To: <20170919165226.23022-1-marcandre.lureau@redhat.com>
References: <20170919165226.23022-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 02/27] build-sys: fix libvhost-user.a build
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
 Makefile               | 3 ++-
 tests/Makefile.include | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index b53fc69a60..8a64b6afb0 100644
--- a/Makefile
+++ b/Makefile
@@ -336,7 +336,7 @@ dtc/%:
 	mkdir -p $@
=20
 $(SUBDIR_RULES): libqemuutil.a libqemustub.a $(common-obj-y) $(chardev-o=
bj-y) \
-	$(qom-obj-y) $(crypto-aes-obj-$(CONFIG_USER_ONLY))
+	$(qom-obj-y) $(crypto-aes-obj-$(CONFIG_USER_ONLY)) libvhost-user.a
=20
 ROMSUBDIR_RULES=3D$(patsubst %,romsubdir-%, $(ROMS))
 # Only keep -O and -g cflags
@@ -357,6 +357,7 @@ Makefile: $(version-obj-y)
=20
 libqemustub.a: $(stub-obj-y)
 libqemuutil.a: $(util-obj-y) $(trace-obj-y)
+libvhost-user.a: $(libvhost-user-obj-y)
=20
 ######################################################################
=20
diff --git a/tests/Makefile.include b/tests/Makefile.include
index fae5715e9c..367d144275 100644
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
2.14.1.146.gd35faa819
