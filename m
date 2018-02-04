Received: from eggs.gnu.org ([2001:4830:134:3::10]:44543)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <whois.zihan.yang@gmail.com>) id 1eiEkE-0003Tj-Lx
	for qemu-devel@nongnu.org; Sun, 04 Feb 2018 02:29:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <whois.zihan.yang@gmail.com>) id 1eiEkB-0002qo-Ax
	for qemu-devel@nongnu.org; Sun, 04 Feb 2018 02:29:46 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:37099)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <whois.zihan.yang@gmail.com>)
	id 1eiEkB-0002ow-4c
	for qemu-devel@nongnu.org; Sun, 04 Feb 2018 02:29:43 -0500
Received: by mail-wm0-x241.google.com with SMTP id v71so20030994wmv.2
	for <qemu-devel@nongnu.org>; Sat, 03 Feb 2018 23:29:42 -0800 (PST)
From: Zihan Yang <whois.zihan.yang@gmail.com>
Date: Sun,  4 Feb 2018 15:28:21 +0800
Message-Id: <1517729303-32043-1-git-send-email-whois.zihan.yang@gmail.com>
Subject: [Qemu-devel] [PATCH 0/2] vmmouse: convert qdev pointer property to
 QOM link relationship
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Zihan Yang <whois.zihan.yang@gmail.com>

The ps2_mouse property of vmmouse is still pointer type which
is defined by DEFINE_PROP_PTR. But qdev pointer property should
be avoided according to qdev-properties.h. Convert it to 
QOM link relationship.

It involves two patches because it requires the TYPE_I8042
macro which is defined in another file. The first patch put
this macro into a single header file so that the macro can
be used elsewhere. The second patch does the actual work.

Zihan Yang (2):
  hw/input/pckdb: put TYPE_I8042 into a single header file
  vmmouse: change qdev pointer property to qom link

 hw/i386/pc.c      |  2 +-
 hw/i386/vmmouse.c | 19 ++++++++++++-------
 hw/input/pckbd.c  |  2 +-
 hw/input/pckbd.h  |  6 ++++++
 4 files changed, 20 insertions(+), 9 deletions(-)
 create mode 100644 hw/input/pckbd.h

-- 
2.7.4
