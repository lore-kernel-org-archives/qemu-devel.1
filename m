Received: from eggs.gnu.org ([2001:4830:134:3::10]:60705)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eel6p-0004aj-Vx
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 12:14:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eel6l-0004xp-15
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 12:14:43 -0500
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:39883)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eel6k-0004xi-TF
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 12:14:38 -0500
Received: by mail-qt0-x241.google.com with SMTP id f4so21003109qtj.6
	for <qemu-devel@nongnu.org>; Thu, 25 Jan 2018 09:14:38 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 25 Jan 2018 14:14:29 -0300
Message-Id: <20180125171432.13554-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 0/3] usb-ccid: convert to realize/unrealize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, Mao Zhongyi <maozy.fnst@cn.fujitsu.com>, Cao jin <caoj.fnst@cn.fujitsu.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

Hi Gerd, this is the previous patch rebased.

since v2:
- fixed an incorrectly placed assignment in ccid_card_realize()
- rebased

Regards,

Phil.

Mao Zhongyi (1):
  hw/usb/ccid: Make ccid_card_init() take an error parameter

Philippe Mathieu-Daudé (2):
  usb-ccid: inline ccid_card_initfn() in ccid_card_realize()
  usb-ccid: convert CCIDCardClass::exitfn() -> unrealize()

 hw/usb/ccid.h                 |  6 +++--
 hw/usb/ccid-card-emulated.c   | 48 ++++++++++++++++-----------------
 hw/usb/ccid-card-passthru.c   | 13 ++++-----
 hw/usb/dev-smartcard-reader.c | 63 +++++++++++++++++++------------------------
 4 files changed, 62 insertions(+), 68 deletions(-)

-- 
2.15.1
