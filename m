Received: from eggs.gnu.org ([2001:4830:134:3::10]:36972)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gAMzL-0008Uv-0z
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 18:29:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gAMzJ-0002eV-Mj
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 18:29:54 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 11 Oct 2018 00:29:43 +0200
Message-Id: <20181010222944.29304-2-f4bug@amsat.org>
In-Reply-To: <20181010222944.29304-1-f4bug@amsat.org>
References: <20181010222944.29304-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] =?utf-8?q?=5BPATCH_1/2=5D_mailmap=3A_Fix_Reimar_D?=
 =?utf-8?q?=C3=B6ffinger_name?=
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>, =?UTF-8?q?Reimar=20D=C3=B6ffinger?= <Reimar.Doeffinger@gmx.de>, Eric Blake <eblake@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org

This probably happened when interpreting the utf8 name as latin1.

Fixes dbbaaff6867 and f4e94dfefb6.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 .mailmap | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index 2c2b9b1205..6f2ff22a45 100644
--- a/.mailmap
+++ b/.mailmap
@@ -33,5 +33,6 @@ Justin Terry (VM) <juterry@microsoft.com> Justin Terry (VM) via Qemu-devel <qemu
 
 
 # Also list preferred name forms where people have changed their
-# git author config
+# git author config, or having utf8/latin1 encoding issues.
 Daniel P. Berrangé <berrange@redhat.com>
+Reimar Döffinger <Reimar.Doeffinger@gmx.de>
-- 
2.19.1
