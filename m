Received: from eggs.gnu.org ([2001:4830:134:3::10]:43232)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <a175818323@gmail.com>) id 1cRcXB-0004V4-AR
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 05:23:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <a175818323@gmail.com>) id 1cRcX9-0006uw-4o
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 05:23:05 -0500
MIME-Version: 1.0
From: Bob Chen <a175818323@gmail.com>
Date: Thu, 12 Jan 2017 18:22:59 +0800
Message-ID: <CAMxP3BT7ncDLePmP7QfXMtbodJ81+9Frc01aCkipya3-BNL6AA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Qemu-devel] How to online resize qemu disk with nbd protocol?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org

Hi,


My qemu runs on a 3rd party distributed block storage, and the disk backend
protocol is nbd.

I notices that there are differences between default qcow2 local disk and
my nbd disk, in terms of resizing the disk on the fly.

Local qcow2 disk could work no matter using qemu-img resize or qemu monitor
'block_resize', but the nbd disk seemed to fail to detect the backend size
change(had resized the disk on EBS at first). It said "this feature or
command is not currently supported".

Is that possible to hack qemu nbd code, making it the same way as resizing
local qcow2 disk? I have the interface to resize EBS disk at backend.


Regards,
Bob
