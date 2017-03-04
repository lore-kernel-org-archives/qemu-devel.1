Received: from eggs.gnu.org ([2001:4830:134:3::10]:57703)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ckEqk-0005pM-OG
	for qemu-devel@nongnu.org; Sat, 04 Mar 2017 13:56:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ckEqh-0007Ni-NL
	for qemu-devel@nongnu.org; Sat, 04 Mar 2017 13:56:14 -0500
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:35467)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ckEqh-0007Lw-Jx
	for qemu-devel@nongnu.org; Sat, 04 Mar 2017 13:56:11 -0500
Received: by mail-qk0-x243.google.com with SMTP id n127so35016770qkf.2
	for <qemu-devel@nongnu.org>; Sat, 04 Mar 2017 10:56:09 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sat,  4 Mar 2017 15:55:30 -0300
Message-Id: <20170304185533.10618-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 0/3] easy-to-fix clang warnings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Alexander Graf <agraf@suse.de>, Gerd Hoffmann <kraxel@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

This patchset fixes three easy-to-fix clang warnings.

Philippe Mathieu-Daudé (3):
  usb-ccid: make ccid_write_data_block() cope with null buffers
  device_tree: fix compiler warnings (clang 5)
  qga: fix compiler warnings (clang 5)

 device_tree.c                 | 1 +
 hw/usb/dev-smartcard-reader.c | 8 +++++++-
 qga/commands-posix.c          | 8 +++++---
 3 files changed, 13 insertions(+), 4 deletions(-)

-- 
2.11.0
