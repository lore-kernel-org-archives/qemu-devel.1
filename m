Received: from eggs.gnu.org ([2001:4830:134:3::10]:36997)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gAMzM-0008VV-V1
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 18:29:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gAMzL-0002fM-3e
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 18:29:56 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 11 Oct 2018 00:29:44 +0200
Message-Id: <20181010222944.29304-3-f4bug@amsat.org>
In-Reply-To: <20181010222944.29304-1-f4bug@amsat.org>
References: <20181010222944.29304-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 2/2] mailmap: Split 'prefered emails' from
 'original git import' section
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Eric Blake <eblake@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 .mailmap | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/.mailmap b/.mailmap
index 6f2ff22a45..8475adf799 100644
--- a/.mailmap
+++ b/.mailmap
@@ -4,26 +4,31 @@
 # into proper addresses so that they are counted properly by git shortlog.
 Andrzej Zaborowski <balrogg@gmail.com> balrog <balrog@c046a42c-6fe2-441c-8c8c-71466251a162>
 Anthony Liguori <anthony@codemonkey.ws> aliguori <aliguori@c046a42c-6fe2-441c-8c8c-71466251a162>
-Anthony Liguori <anthony@codemonkey.ws> Anthony Liguori <aliguori@us.ibm.com>
 Aurelien Jarno <aurelien@aurel32.net> aurel32 <aurel32@c046a42c-6fe2-441c-8c8c-71466251a162>
 Blue Swirl <blauwirbel@gmail.com> blueswir1 <blueswir1@c046a42c-6fe2-441c-8c8c-71466251a162>
 Edgar E. Iglesias <edgar.iglesias@gmail.com> edgar_igl <edgar_igl@c046a42c-6fe2-441c-8c8c-71466251a162>
 Fabrice Bellard <fabrice@bellard.org> bellard <bellard@c046a42c-6fe2-441c-8c8c-71466251a162>
-James Hogan <jhogan@kernel.org> <james.hogan@imgtec.com>
 Jocelyn Mayer <l_indien@magic.fr> j_mayer <j_mayer@c046a42c-6fe2-441c-8c8c-71466251a162>
 Paul Brook <paul@codesourcery.com> pbrook <pbrook@c046a42c-6fe2-441c-8c8c-71466251a162>
-Aleksandar Markovic <amarkovic@wavecomp.com> <aleksandar.markovic@mips.com>
-Aleksandar Markovic <amarkovic@wavecomp.com> <aleksandar.markovic@imgtec.com>
-Paul Burton <pburton@wavecomp.com> <paul.burton@mips.com>
-Paul Burton <pburton@wavecomp.com> <paul.burton@imgtec.com>
-Paul Burton <pburton@wavecomp.com> <paul@archlinuxmips.org>
 Thiemo Seufer <ths@networkno.de> ths <ths@c046a42c-6fe2-441c-8c8c-71466251a162>
 malc <av1474@comtv.ru> malc <malc@c046a42c-6fe2-441c-8c8c-71466251a162>
-
 # There is also a:
 #    (no author) <(no author)@c046a42c-6fe2-441c-8c8c-71466251a162>
 # for the cvs2svn initialization commit e63c3dc74bf.
 
+
+# This section is to track prefered (or last up to date) email for people
+# that uses (or had use) various emails.
+# Example can be people changing from companies, or companies changing their
+# name.
+Aleksandar Markovic <amarkovic@wavecomp.com> <aleksandar.markovic@imgtec.com>
+Anthony Liguori <anthony@codemonkey.ws> Anthony Liguori <aliguori@us.ibm.com>
+James Hogan <jhogan@kernel.org> <james.hogan@imgtec.com>
+Paul Burton <pburton@wavecomp.com> <paul.burton@mips.com>
+Paul Burton <pburton@wavecomp.com> <paul.burton@imgtec.com>
+Paul Burton <pburton@wavecomp.com> <paul@archlinuxmips.org>
+
+
 # Next, translate a few commits where mailman rewrote the From: line due
 # to strict SPF, although we prefer to avoid adding more entries like that.
 Ed Swierk <eswierk@skyportsystems.com> Ed Swierk via Qemu-devel <qemu-devel@nongnu.org>
-- 
2.19.1
