Received: from eggs.gnu.org ([2001:4830:134:3::10]:50530)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYbkx-00050A-I9
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 13:02:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYbkt-000653-N6
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 13:02:43 -0500
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:35160)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYbkt-00064w-J5
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 13:02:39 -0500
Received: by mail-qk0-x242.google.com with SMTP id w184so7056850qka.2
	for <qemu-devel@nongnu.org>; Mon, 08 Jan 2018 10:02:39 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon,  8 Jan 2018 15:02:24 -0300
Message-Id: <20180108180231.21122-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 0/7] use QEMU_PACKED and QEMU_ALIGNED macros
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jiri Pirko <jiri@resnulli.us>, Jason Wang <jasowang@redhat.com>, Dmitry Fleytman <dmitry@daynix.com>, Stefan Weil <sw@weilnetz.de>, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Richard Henderson <rth@twiddle.net>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>

Still trying to reduce clang -Waddress-of-packed-member warnings.

Philippe Mathieu-Daudé (7):
  net: struct MACAddr can use the QEMU_PACKED macro
  net/eth: use the QEMU_PACKED macro
  net/rocker: use QEMU_PACKED and QEMU_ALIGNED() macros
  net/rocker: move struct rocker_desc to C file
  net/eepro100: use QEMU_ALIGNED() macro
  net/eepro100: reduce alignment to DWORD (32bit)
  i386/pc: use the QEMU_ALIGNED() macro

 hw/net/rocker/rocker_hw.h   | 15 +--------------
 include/net/eth.h           | 26 +++++++++++++-------------
 include/net/net.h           |  2 +-
 hw/i386/pc.c                |  4 ++--
 hw/net/eepro100.c           |  2 +-
 hw/net/rocker/rocker_desc.c | 13 +++++++++++++
 6 files changed, 31 insertions(+), 31 deletions(-)

-- 
2.15.1
