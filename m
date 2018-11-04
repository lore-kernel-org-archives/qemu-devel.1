Received: from eggs.gnu.org ([2001:4830:134:3::10]:41559)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gJGhD-00075k-If
	for qemu-devel@nongnu.org; Sun, 04 Nov 2018 06:36:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gJGh7-0002MW-5K
	for qemu-devel@nongnu.org; Sun, 04 Nov 2018 06:35:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49380)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1gJGh6-0002KC-U1
	for qemu-devel@nongnu.org; Sun, 04 Nov 2018 06:35:53 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Sun,  4 Nov 2018 11:24:17 +0000
Message-Id: <20181104112424.18663-2-stefanha@redhat.com>
In-Reply-To: <20181104112424.18663-1-stefanha@redhat.com>
References: <20181104112424.18663-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 1/8] README: use 'https://' instead of
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
Cc: eblake@redhat.com, cohuck@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>, Jeff Cody <jcody@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Daniel Berrange <berrange@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

When you clone the repository without previous commit history, 'git://'
doesn't protect from man-in-the-middle attacks.  HTTPS is more secure
since the client verifies the server certificate.

Reported-by: Jann Horn <jannh@google.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 README         | 4 ++--
 pc-bios/README | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/README b/README
index 49a9fd09cd..441c33eb2f 100644
--- a/README
+++ b/README
@@ -54,7 +54,7 @@ Submitting patches
=20
 The QEMU source code is maintained under the GIT version control system.
=20
-   git clone git://git.qemu.org/qemu.git
+   git clone https://git.qemu.org/git/qemu.git
=20
 When submitting patches, one common approach is to use 'git
 format-patch' and/or 'git send-email' to format & send the mail to the
@@ -70,7 +70,7 @@ the QEMU website
=20
 The QEMU website is also maintained under source control.
=20
-  git clone git://git.qemu.org/qemu-web.git
+  git clone https://git.qemu.org/git/qemu-web.git
   https://www.qemu.org/2017/02/04/the-new-qemu-website-is-up/
=20
 A 'git-publish' utility was created to make above process less
diff --git a/pc-bios/README b/pc-bios/README
index 90f0fa7aa7..b572e9eb00 100644
--- a/pc-bios/README
+++ b/pc-bios/README
@@ -23,7 +23,7 @@
   legacy x86 software to communicate with an attached serial console as
   if a video card were attached.  The master sources reside in a subvers=
ion
   repository at http://sgabios.googlecode.com/svn/trunk.  A git mirror i=
s
-  available at git://git.qemu.org/sgabios.git.
+  available at https://git.qemu.org/git/sgabios.git.
=20
 - The PXE roms come from the iPXE project. Built with BANNER_TIME 0.
   Sources available at http://ipxe.org.  Vendor:Device ID -> ROM mapping=
:
@@ -40,7 +40,7 @@
=20
 - The u-boot binary for e500 comes from the upstream denx u-boot project=
 where
   it was compiled using the qemu-ppce500 target.
-  A git mirror is available at: git://git.qemu.org/u-boot.git
+  A git mirror is available at: https://git.qemu.org/git/u-boot.git
   The hash used to compile the current version is: 2072e72
=20
 - Skiboot (https://github.com/open-power/skiboot/) is an OPAL
--=20
2.17.2
