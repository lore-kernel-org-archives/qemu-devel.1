Received: from eggs.gnu.org ([2001:4830:134:3::10]:33631)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dxlp3-0007dE-Rh
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 23:18:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dxlp2-0002Yf-RG
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 23:18:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52746)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dxlp2-0002YD-LV
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 23:18:40 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri, 29 Sep 2017 11:18:29 +0800
Message-Id: <20170929031831.10179-4-famz@redhat.com>
In-Reply-To: <20170929031831.10179-1-famz@redhat.com>
References: <20170929031831.10179-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 3/5] tests/docker/run: don't source /etc/profile
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
List-ID: <qemu-devel.nongnu.org>

From: Alex Benn=C3=A9e <alex.bennee@linaro.org>

The usual behaviour of /etc/profile is to set the default PATH for
users. This runs into problems when we have updated PATH in our
dockerfile e.g. to access a cross-compiler in a non-standard
location. It shouldn't be needed anyway as we inherit the env from the
image when it was setup.

Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
CC: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-Id: <20170926133622.14991-1-alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 tests/docker/run | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tests/docker/run b/tests/docker/run
index 0fd2f358ce..642084bcb8 100755
--- a/tests/docker/run
+++ b/tests/docker/run
@@ -18,7 +18,6 @@ fi
 BASE=3D"$(dirname $(readlink -e $0))"
=20
 # Prepare the environment
-. /etc/profile
 export PATH=3D/usr/lib/ccache:$PATH
=20
 if test -n "$J"; then
--=20
2.13.5
