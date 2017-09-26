Received: from eggs.gnu.org ([2001:4830:134:3::10]:42589)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=435739c2e=owen.smith@citrix.com>)
	id 1dwrBF-0005sN-Cp
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 10:49:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=435739c2e=owen.smith@citrix.com>)
	id 1dwrBC-00040u-Bo
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 10:49:49 -0400
Received: from smtp.citrix.com ([66.165.176.89]:54430)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=435739c2e=owen.smith@citrix.com>)
	id 1dwrBB-00040M-TE
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 10:49:46 -0400
From: Owen Smith <owen.smith@citrix.com>
Date: Tue, 26 Sep 2017 14:43:36 +0000
Message-ID: <1506437019-17946-1-git-send-email-owen.smith@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 0/3 v4] xenfb: Enablement for Windows PV HID
 frontend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: sstabellini@kernel.org, anthony.perard@citrix.com, kraxel@redhat.com
Cc: xen-devel@lists.xenproject.org, qemu-devel@nongnu.org, Owen Smith <owen.smith@citrix.com>

Improve the input device model in xenfb, by updating the
Qemu input handlers and adding a feature to allow for
raw (unscaled) absolute coordinates to be represented.

By using a reverse mapping call, the Linux input.h #defines
are not pulled into xenfb, and so should remove the compiler
warnings reported.

Owen Smith (3):
  ui/input: add qemu_input_qcode_to_linux
  xenfb: Use Input Handlers directly
  xenfb: Add [feature|request]-raw-pointer

 hw/display/xenfb.c | 300 +++++++++++++++++++++++++----------------------------
 include/ui/input.h |   1 +
 ui/input-keymap.c  |  16 +++
 3 files changed, 161 insertions(+), 156 deletions(-)

-- 
2.1.4
