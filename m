Received: from eggs.gnu.org ([2001:4830:134:3::10]:52140)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1gG2u7-0001yM-GO
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 10:16:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1gG2u6-000636-Kd
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 10:15:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33910)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1gG2u6-0005ve-AV
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 10:15:58 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri, 26 Oct 2018 22:15:24 +0800
Message-Id: <20181026141529.4305-5-famz@redhat.com>
In-Reply-To: <20181026141529.4305-1-famz@redhat.com>
References: <20181026141529.4305-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 4/9] tests/vm: Do not use the -smp option with a
 single cpu
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
Message-Id: <20181013004034.6968-4-f4bug@amsat.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 tests/vm/basevm.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index 2bd32dc6ce..9415e7c33a 100755
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -70,7 +70,7 @@ class BaseVM(object):
             "-device", "virtio-net-pci,netdev=3Dvnet",
             "-vnc", "127.0.0.1:0,to=3D20",
             "-serial", "file:%s" % os.path.join(self._tmpdir, "serial.ou=
t")]
-        if vcpus:
+        if vcpus and vcpus > 1:
             self._args +=3D ["-smp", str(vcpus)]
         if kvm_available():
             self._args +=3D ["-enable-kvm"]
--=20
2.17.1
