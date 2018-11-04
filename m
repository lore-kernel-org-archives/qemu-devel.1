Received: from eggs.gnu.org ([2001:4830:134:3::10]:41737)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gJGhR-0007Dm-V8
	for qemu-devel@nongnu.org; Sun, 04 Nov 2018 06:36:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gJGhR-0002Zs-8l
	for qemu-devel@nongnu.org; Sun, 04 Nov 2018 06:36:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49488)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1gJGhR-0002ZX-2A
	for qemu-devel@nongnu.org; Sun, 04 Nov 2018 06:36:13 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Sun,  4 Nov 2018 11:24:18 +0000
Message-Id: <20181104112424.18663-3-stefanha@redhat.com>
In-Reply-To: <20181104112424.18663-1-stefanha@redhat.com>
References: <20181104112424.18663-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 2/8] get_maintainer: use 'https://' instead
 of 'git://'
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
 scripts/get_maintainer.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
index 43fb5f512f..fc7275b9e2 100755
--- a/scripts/get_maintainer.pl
+++ b/scripts/get_maintainer.pl
@@ -1376,7 +1376,7 @@ sub vcs_exists {
 	warn("$P: No supported VCS found.  Add --nogit to options?\n");
 	warn("Using a git repository produces better results.\n");
 	warn("Try latest git repository using:\n");
-	warn("git clone git://git.qemu.org/qemu.git\n");
+	warn("git clone https//git.qemu.org/git/qemu.git\n");
 	$printed_novcs =3D 1;
     }
     return 0;
--=20
2.17.2
