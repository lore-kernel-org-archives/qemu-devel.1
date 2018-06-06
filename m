Received: from eggs.gnu.org ([2001:4830:134:3::10]:46785)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fQag3-0008Hg-41
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 11:48:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fQag0-0003HW-I6
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 11:48:47 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:38045)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fQag0-0003HG-DK
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 11:48:44 -0400
Received: by mail-qt0-x243.google.com with SMTP id x34-v6so6838264qtk.5
	for <qemu-devel@nongnu.org>; Wed, 06 Jun 2018 08:48:44 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed,  6 Jun 2018 12:48:34 -0300
Message-Id: <20180606154835.2276-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH v3 0/1] SDCard: support UHS-I
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Alistair Francis <alistair@alistair23.me>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

Hi Peter,

This is a rewrite of the previous series after running tests and sniffed
traffic on real hardware.
Tagged RFC to be sure this particular patch is going in the correct
direction, before reposting the series with the 'uhs' property patches.

Regards,

Phil.

Since v2:
- rewrite from scratch following Peter's comment [1] and the Specs [2]
- tested/compared with real hardware behavior

[1] http://lists.nongnu.org/archive/html/qemu-devel/2018-05/msg04840.html
[2] http://lists.nongnu.org/archive/html/qemu-devel/2018-05/msg05088.html

v1 http://lists.nongnu.org/archive/html/qemu-devel/2018-03/msg02828.html
v2 http://lists.nongnu.org/archive/html/qemu-devel/2018-05/msg01911.html

Philippe Mathieu-Daudé (1):
  sdcard: Implement the UHS-I Switch Function entries (Spec v3)

 hw/sd/sd.c         | 238 ++++++++++++++++++++++++++++++++++++++++-----
 hw/sd/trace-events |   1 +
 2 files changed, 217 insertions(+), 22 deletions(-)

-- 
2.17.1
