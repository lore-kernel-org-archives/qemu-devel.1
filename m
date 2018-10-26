Received: from eggs.gnu.org ([2001:4830:134:3::10]:52269)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1gG2uE-00024p-Su
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 10:16:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1gG2uE-0006Bz-1d
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 10:16:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55102)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1gG2uD-0006BA-QA
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 10:16:05 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri, 26 Oct 2018 22:15:27 +0800
Message-Id: <20181026141529.4305-8-famz@redhat.com>
In-Reply-To: <20181026141529.4305-1-famz@redhat.com>
References: <20181026141529.4305-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 7/9] tests/vm: Let kvm_available() work in cross
 environments
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
Message-Id: <20181013004034.6968-7-f4bug@amsat.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 scripts/qemu.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/qemu.py b/scripts/qemu.py
index 9fc0be4828..bcd24aad82 100644
--- a/scripts/qemu.py
+++ b/scripts/qemu.py
@@ -27,6 +27,8 @@ LOG =3D logging.getLogger(__name__)
=20
=20
 def kvm_available(target_arch=3DNone):
+    if target_arch and target_arch !=3D os.uname()[4]:
+        return False
     return os.access("/dev/kvm", os.R_OK | os.W_OK)
=20
=20
--=20
2.17.1
