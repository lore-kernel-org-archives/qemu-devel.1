Received: from eggs.gnu.org ([209.51.188.92]:49449)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gua3V-00005l-5A
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 04:45:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gua3U-0004pb-EZ
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 04:45:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34724)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gua3U-0004mJ-8D
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 04:45:12 -0500
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Fri, 15 Feb 2019 09:45:01 +0000
Message-Id: <20190215094502.32149-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 1/2] .travis.yml: Test with disable-replication
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, alex.bennee@linaro.org

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

We've had the build break with replication disabled, so lets
test that case in travis.

Suggsted-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 .travis.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.travis.yml b/.travis.yml
index baa06b976a..95c554897b 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -90,7 +90,7 @@ matrix:
=20
=20
     - env:
-        - CONFIG=3D"--disable-linux-aio --disable-cap-ng --disable-attr =
--disable-brlapi --disable-uuid --disable-libusb --disable-user"
+        - CONFIG=3D"--disable-linux-aio --disable-cap-ng --disable-attr =
--disable-brlapi --disable-uuid --disable-libusb --disable-user --disable=
-replication"
=20
=20
     - env:
--=20
2.20.1
