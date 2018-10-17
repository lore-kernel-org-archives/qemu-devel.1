Received: from eggs.gnu.org ([2001:4830:134:3::10]:53441)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gCii9-0005xq-NW
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 06:05:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gCii4-00026k-UP
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 06:05:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:64245)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gCihw-0001BO-N0
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 06:05:44 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Wed, 17 Oct 2018 12:05:02 +0200
Message-Id: <1539770707-7289-11-git-send-email-thuth@redhat.com>
In-Reply-To: <1539770707-7289-1-git-send-email-thuth@redhat.com>
References: <1539770707-7289-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] =?utf-8?q?=5BPULL_10/15=5D_mailmap=3A_Fix_Reimar_D?=
 =?utf-8?q?=C3=B6ffinger_name?=
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

This probably happened when interpreting the utf8 name as latin1.

Fixes dbbaaff6867 and f4e94dfefb6.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 .mailmap | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index 2c2b9b1..6f2ff22 100644
--- a/.mailmap
+++ b/.mailmap
@@ -33,5 +33,6 @@ Justin Terry (VM) <juterry@microsoft.com> Justin Terry =
(VM) via Qemu-devel <qemu
=20
=20
 # Also list preferred name forms where people have changed their
-# git author config
+# git author config, or having utf8/latin1 encoding issues.
 Daniel P. Berrang=C3=A9 <berrange@redhat.com>
+Reimar D=C3=B6ffinger <Reimar.Doeffinger@gmx.de>
--=20
1.8.3.1
