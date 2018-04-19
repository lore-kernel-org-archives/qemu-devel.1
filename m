Received: from eggs.gnu.org ([2001:4830:134:3::10]:46669)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1f99UU-0004dI-3d
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 09:20:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1f99UQ-0006LI-Uj
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 09:20:46 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 19 Apr 2018 15:20:22 +0200
Message-Id: <20180419132026.5494-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 0/4] ui: use qapi-based parser for most
 -display options.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>, qemu-trivial@nongnu.org, Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>



Gerd Hoffmann (4):
  ui: add qapi parser for -display
  ui: switch trivial displays to qapi parser
  ui: switch gtk display to qapi parser
  ui: document non-qapi parser cases.

 vl.c | 81 ++++++++++++++++++++++++++++++++++----------------------------------
 1 file changed, 41 insertions(+), 40 deletions(-)

-- 
2.9.3
