Received: from eggs.gnu.org ([2001:4830:134:3::10]:52304)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1gG2uH-00026u-8j
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 10:16:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1gG2uF-0006DD-FV
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 10:16:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48730)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1gG2uF-0006Cn-82
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 10:16:07 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri, 26 Oct 2018 22:15:28 +0800
Message-Id: <20181026141529.4305-9-famz@redhat.com>
In-Reply-To: <20181026141529.4305-1-famz@redhat.com>
References: <20181026141529.4305-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 8/9] tests/vm: Do not use -enable-kvm if HOST !=
 TARGET architecture
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-Id: <20181013004034.6968-8-f4bug@amsat.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 tests/vm/basevm.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index b2e0de2022..9f4794898a 100755
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -74,7 +74,7 @@ class BaseVM(object):
             "-serial", "file:%s" % os.path.join(self._tmpdir, "serial.ou=
t")]
         if vcpus and vcpus > 1:
             self._args +=3D ["-smp", str(vcpus)]
-        if kvm_available():
+        if kvm_available(self.arch):
             self._args +=3D ["-enable-kvm"]
         else:
             logging.info("KVM not available, not using -enable-kvm")
--=20
2.17.1
