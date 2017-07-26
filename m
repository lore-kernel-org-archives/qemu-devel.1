Received: from eggs.gnu.org ([2001:4830:134:3::10]:57395)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1daKvk-0003rh-Dw
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 07:56:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1daKvh-00043S-Qp
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 07:56:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51134)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1daKvh-00042y-Ku
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 07:56:41 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9DAE667AD7
	for <qemu-devel@nongnu.org>; Wed, 26 Jul 2017 11:56:40 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 26 Jul 2017 13:56:32 +0200
Message-Id: <20170726115637.21558-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 0/5] ui: keymap fixes for 2.10
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, Gerd Hoffmann <kraxel@redhat.com>

This series adds multimedia keys to QKeyCodes, allowing them to be
supported (again) by the ps/2 keyboard emulation.  It also fixes
some minor keymap issues along the way.

Gerd Hoffmann (5):
  ui: add next and prior keysyms
  ui: move qemu_input_linux_to_qcode()
  ui: update keymaps
  ui: add multimedia keys
  ps2: enable multimedia keys

 include/ui/input.h |   1 +
 ui/curses_keys.h   |   2 +
 ui/vnc_keysym.h    |   2 +
 hw/input/ps2.c     |   4 --
 ui/input-keymap.c  | 166 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 ui/input-linux.c   | 113 ------------------------------------
 qapi-schema.json   |  17 +++++-
 7 files changed, 187 insertions(+), 118 deletions(-)

-- 
2.9.3
