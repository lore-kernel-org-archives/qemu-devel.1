Received: from eggs.gnu.org ([2001:4830:134:3::10]:50764)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <patricktsen@gmail.com>) id 1eYJDa-0003Fk-NM
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 17:15:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <patricktsen@gmail.com>) id 1eYJDa-0001Jd-14
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 17:15:02 -0500
Received: from mail-pf0-x22f.google.com ([2607:f8b0:400e:c00::22f]:43941)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <patricktsen@gmail.com>)
	id 1eYJDZ-0001J5-RM
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 17:15:01 -0500
Received: by mail-pf0-x22f.google.com with SMTP id e3so4642618pfi.10
	for <qemu-devel@nongnu.org>; Sun, 07 Jan 2018 14:15:01 -0800 (PST)
From: byxk <patricktsen@gmail.com>
Date: Sun,  7 Jan 2018 14:14:54 -0800
Message-Id: <20180107221455.25504-1-patricktsen@gmail.com>
Subject: [Qemu-devel] [PATCH v2 0/1] input-linux: provide hotkeys for evdev
 toggle
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com, byxk <patricktsen@gmail.com>

Added some functionality to change the key combo for evdev toggle.
example:
-object input-linux,rhotkey=29,lhotkey=56,evdev=[etc...]

Set the defaults to LCTRL and RCTRL if not provided.

This is my first patch to anything so feedback/help appreciated!

byxk (1):
  input-linux: provide hotkeys for evdev toggle

 ui/input-linux.c | 77 ++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 75 insertions(+), 2 deletions(-)

-- 
2.15.1
