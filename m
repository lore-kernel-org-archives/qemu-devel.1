Received: from eggs.gnu.org ([2001:4830:134:3::10]:33773)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eFIpT-0001f9-FM
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 06:59:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eFIpS-000066-Al
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 06:59:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39760)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eFIpS-0008WU-4Q
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 06:59:34 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 16 Nov 2017 12:59:18 +0100
Message-Id: <20171116115926.16627-4-pbonzini@redhat.com>
In-Reply-To: <20171116115926.16627-1-pbonzini@redhat.com>
References: <20171116115926.16627-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 03/11] Makefile: simpler/faster "make help"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Using obscure black magic introduced in eaa2ddbb767 :)

In an out-of-tree directory, running "../configure && make help" will gen=
erate
some required files (.mak), then clone some submodules, compile at least
the capstone submodule, generate QMP and Trace files, and finally display
the help.

On an outdated computer (Sun Blade workstation), running "make help" took
more than 5h :) With this patch it took roughly 37min.

Suggested-by: Daniel P. Berrange <berrange@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-Id: <20171108032052.20029-1-f4bug@amsat.org>
Reviewed-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Daniel P. Berrange <berrange@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index ec73acfa9a..143ac81736 100644
--- a/Makefile
+++ b/Makefile
@@ -6,7 +6,7 @@ BUILD_DIR=3D$(CURDIR)
 # Before including a proper config-host.mak, assume we are in the source=
 tree
 SRC_PATH=3D.
=20
-UNCHECKED_GOALS :=3D %clean TAGS cscope ctags docker docker-%
+UNCHECKED_GOALS :=3D %clean TAGS cscope ctags docker docker-% help
=20
 # All following code might depend on configuration variables
 ifneq ($(wildcard config-host.mak),)
--=20
2.14.3
