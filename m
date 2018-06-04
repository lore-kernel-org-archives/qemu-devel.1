Received: from eggs.gnu.org ([2001:4830:134:3::10]:36484)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fPrBr-0005gH-5s
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 11:14:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fPrBn-0001dg-5K
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 11:14:35 -0400
Received: from mail-qt0-x231.google.com ([2607:f8b0:400d:c0d::231]:41638)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fPrBn-0001dQ-0H
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 11:14:31 -0400
Received: by mail-qt0-x231.google.com with SMTP id y20-v6so14669721qto.8
	for <qemu-devel@nongnu.org>; Mon, 04 Jun 2018 08:14:30 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon,  4 Jun 2018 12:14:18 -0300
Message-Id: <20180604151421.23385-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 0/3] usb: fix bugs reported by Clang Static
 Analyzer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

Since v1 [1]:
- zero-initialize c->argv[] as suggested by Gerd Hoffmann
- drop 4th patch, bug already fixed in 53735bef108

[1] http://lists.nongnu.org/archive/html/qemu-devel/2017-07/msg07453.html

Philippe Mathieu-Daudé (3):
  usb: correctly handle Zero Length Packets
  usb/dev-mtp: Fix use of uninitialized values
  usb/dev-mtp: Fix use of uninitialized values

 hw/usb/dev-mtp.c  | 11 ++++++++++-
 hw/usb/redirect.c |  2 +-
 2 files changed, 11 insertions(+), 2 deletions(-)

-- 
2.17.1
