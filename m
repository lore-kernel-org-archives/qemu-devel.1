Received: from eggs.gnu.org ([2001:4830:134:3::10]:50505)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gHmlN-0003hu-HG
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 05:26:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gHmlC-0005sZ-Py
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 05:26:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35962)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1gHmlB-0005WE-Uc
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 05:25:58 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Wed, 31 Oct 2018 08:43:09 +0000
Message-Id: <20181031084309.9227-5-stefanha@redhat.com>
In-Reply-To: <20181031084309.9227-1-stefanha@redhat.com>
References: <20181031084309.9227-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH 4/4] gitmodules: use 'https://' instead of
 'git://'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Jeff Cody <jcody@redhat.com>, Markus Armbruster <armbru@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Daniel Berrange <berrange@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

When you clone the repository without previous commit history, 'git://'
doesn't protect from man-in-the-middle attacks.  HTTPS is more secure
since the client verifies the server certificate.

Also change git.qemu-project.org to git.qemu.org (we control both domain
names but qemu.org is used more widely).

Reported-by: Jann Horn <jannh@google.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 .gitmodules | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/.gitmodules b/.gitmodules
index a48d2a764c..6b91176098 100644
--- a/.gitmodules
+++ b/.gitmodules
@@ -1,51 +1,51 @@
 [submodule "roms/seabios"]
 	path = roms/seabios
-	url = git://git.qemu-project.org/seabios.git/
+	url = https://git.qemu.org/git/seabios.git/
 [submodule "roms/SLOF"]
 	path = roms/SLOF
-	url = git://git.qemu-project.org/SLOF.git
+	url = https://git.qemu.org/git/SLOF.git
 [submodule "roms/ipxe"]
 	path = roms/ipxe
-	url = git://git.qemu-project.org/ipxe.git
+	url = https://git.qemu.org/git/ipxe.git
 [submodule "roms/openbios"]
 	path = roms/openbios
-	url = git://git.qemu-project.org/openbios.git
+	url = https://git.qemu.org/git/openbios.git
 [submodule "roms/openhackware"]
 	path = roms/openhackware
-	url = git://git.qemu-project.org/openhackware.git
+	url = https://git.qemu.org/git/openhackware.git
 [submodule "roms/qemu-palcode"]
 	path = roms/qemu-palcode
-	url = git://git.qemu.org/qemu-palcode.git
+	url = https://git.qemu.org/git/qemu-palcode.git
 [submodule "roms/sgabios"]
 	path = roms/sgabios
-	url = git://git.qemu-project.org/sgabios.git
+	url = https://git.qemu.org/git/sgabios.git
 [submodule "dtc"]
 	path = dtc
-	url = git://git.qemu-project.org/dtc.git
+	url = https://git.qemu.org/git/dtc.git
 [submodule "roms/u-boot"]
 	path = roms/u-boot
-	url = git://git.qemu-project.org/u-boot.git
+	url = https://git.qemu.org/git/u-boot.git
 [submodule "roms/skiboot"]
 	path = roms/skiboot
-	url = git://git.qemu.org/skiboot.git
+	url = https://git.qemu.org/git/skiboot.git
 [submodule "roms/QemuMacDrivers"]
 	path = roms/QemuMacDrivers
-	url = git://git.qemu.org/QemuMacDrivers.git
+	url = https://git.qemu.org/git/QemuMacDrivers.git
 [submodule "ui/keycodemapdb"]
 	path = ui/keycodemapdb
-	url = git://git.qemu.org/keycodemapdb.git
+	url = https://git.qemu.org/git/keycodemapdb.git
 [submodule "capstone"]
 	path = capstone
-	url = git://git.qemu.org/capstone.git
+	url = https://git.qemu.org/git/capstone.git
 [submodule "roms/seabios-hppa"]
 	path = roms/seabios-hppa
-	url = git://github.com/hdeller/seabios-hppa.git
+	url = https://github.com/hdeller/seabios-hppa.git
 [submodule "roms/u-boot-sam460ex"]
 	path = roms/u-boot-sam460ex
-	url = git://git.qemu.org/u-boot-sam460ex.git
+	url = https://git.qemu.org/git/u-boot-sam460ex.git
 [submodule "tests/fp/berkeley-testfloat-3"]
 	path = tests/fp/berkeley-testfloat-3
-	url = git://github.com/cota/berkeley-testfloat-3
+	url = https://github.com/cota/berkeley-testfloat-3
 [submodule "tests/fp/berkeley-softfloat-3"]
 	path = tests/fp/berkeley-softfloat-3
-	url = git://github.com/cota/berkeley-softfloat-3
+	url = https://github.com/cota/berkeley-softfloat-3
-- 
2.17.2
