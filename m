Received: from eggs.gnu.org ([2001:4830:134:3::10]:41778)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1foGBU-0000ZG-Qt
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 18:47:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1foGBP-0005fh-VL
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 18:47:04 -0400
From: =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>
Date: Sat, 11 Aug 2018 00:46:45 +0200
Message-Id: <20180810224645.10659-1-hpoussin@reactos.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] qemu-doc: mark ppc/prep machine as deprecated
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, "reviewer:Incompatible changes" <libvir-list@redhat.com>

40p machine type should be used instead.

Signed-off-by: Hervé Poussineau <hpoussin@reactos.org>
---
 qemu-deprecated.texi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
index 9920a85adc..9c7ff3fe2d 100644
--- a/qemu-deprecated.texi
+++ b/qemu-deprecated.texi
@@ -218,6 +218,12 @@ support page sizes < 4096 any longer.
 These machine types are very old and likely can not be used for live migration
 from old QEMU versions anymore. A newer machine type should be used instead.
 
+@subsection prep (PowerPC) (since 3.1)
+
+This machine type uses an unmaintained firmware, broken in lots of ways,
+and unable to start post-2004 operating systems. 40p machine type should be
+used instead.
+
 @section Device options
 
 @subsection Block device options
-- 
2.11.0
