Received: from eggs.gnu.org ([2001:4830:134:3::10]:43958)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from
	<bounce+7309d1.7d7329-qemu-devel=nongnu.org@mg-relay.tolva.net>)
	id 1g9N9N-0006aO-G6
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 00:28:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from
	<bounce+7309d1.7d7329-qemu-devel=nongnu.org@mg-relay.tolva.net>)
	id 1g9N9I-0002Ue-Ff
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 00:28:09 -0400
Received: from mail2.static.mailgun.info ([104.130.122.2]:45007)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from
	<bounce+7309d1.7d7329-qemu-devel=nongnu.org@mg-relay.tolva.net>)
	id 1g9N9G-0002SO-T8
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 00:28:03 -0400
Sender: cst=tolva.net@mg-relay.tolva.net
From: =?UTF-8?q?Cortland=20T=C3=B6lva?= <cst@tolva.net>
Date: Sun,  7 Oct 2018 21:27:45 -0700
Message-Id: <20181008042747.10130-1-cst@tolva.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 0/2] linux-user: usbfs improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Cortland=20Setlow=20T=C3=B6lva?= <cst@tolva.net>, Laurent Vivier <laurent@vivier.eu>

From: Cortland Setlow Tölva <cst@tolva.net>

This patch series enables programs running under QEMU Linux user mode
emulation to implement user-space USB drivers via the USBFS ioctl()s.
Support is limited to control, bulk, and possibly interrupt transfers.

Usbfs ioctl codes were incorrect whenever host and target disagreed on
struct size.  The submit, discard, and reap usbfs ioctls require special
memory buffer handling and the second commit implements this but not for
USB3 streams or isochronous transfers.

Cortland Tölva (2):
  linux-user: Use calculated sizes for usbfs ioctls.
  linux-user: Implement special usbfs ioctls.

 linux-user/ioctls.h        |   8 ++
 linux-user/syscall.c       | 177 +++++++++++++++++++++++++++++++++++++
 linux-user/syscall_defs.h  |  42 ++++-----
 linux-user/syscall_types.h |  20 +++++
 4 files changed, 227 insertions(+), 20 deletions(-)

-- 
2.17.1
