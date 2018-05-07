Received: from eggs.gnu.org ([2001:4830:134:3::10]:45192)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fFcrx-0002AK-Ac
	for qemu-devel@nongnu.org; Mon, 07 May 2018 05:55:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fFcru-0005CF-Ao
	for qemu-devel@nongnu.org; Mon, 07 May 2018 05:55:45 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon,  7 May 2018 11:55:35 +0200
Message-Id: <20180507095539.19584-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/4] ui: use qapi-based parser for most
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
Cc: Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>, qemu-trivial@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, Markus Armbruster <armbru@redhat.com>

v2: rebase, adapt to gl= option changes.

Gerd Hoffmann (4):
  ui: add qapi parser for -display
  ui: switch trivial displays to qapi parser
  ui: switch gtk display to qapi parser
  ui: document non-qapi parser cases.

 ui/gtk.c |  6 ++++-
 vl.c     | 76 ++++++++++++++++++++++++++++++----------------------------------
 2 files changed, 41 insertions(+), 41 deletions(-)

-- 
2.9.3
