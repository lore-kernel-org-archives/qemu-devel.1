Received: from eggs.gnu.org ([2001:4830:134:3::10]:52300)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from
	<bounce+7309d1.7d7329-qemu-devel=nongnu.org@mg-relay.tolva.net>)
	id 1g9YVQ-0005OG-3F
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 12:35:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from
	<bounce+7309d1.7d7329-qemu-devel=nongnu.org@mg-relay.tolva.net>)
	id 1g9YVM-0002dI-SO
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 12:35:40 -0400
Received: from mail2.static.mailgun.info ([104.130.122.2]:17627)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from
	<bounce+7309d1.7d7329-qemu-devel=nongnu.org@mg-relay.tolva.net>)
	id 1g9YVJ-0002Ya-DB
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 12:35:34 -0400
Sender: cst=tolva.net@mg-relay.tolva.net
From: =?UTF-8?q?Cortland=20T=C3=B6lva?= <cst@tolva.net>
Date: Mon,  8 Oct 2018 09:35:18 -0700
Message-Id: <20181008163521.17341-1-cst@tolva.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 0/3] Linux usermode emulation user mode USB
 driver support.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Cortland=20T=C3=B6lva?= <cst@tolva.net>, Laurent Vivier <laurent@vivier.eu>

This patch series enables programs running under QEMU Linux user mode
emulation to implement user-space USB drivers via the USBFS ioctl()s.
Support is limited to control, bulk, and possibly interrupt transfers.

The series compiles for i386, ppc64, ppc64le, mips, mipsel, xtensa, and
xtensaeb with an armv7l host and an x86_64 host.  The i386-linux-user target is
tested working with a USB scanner driver on an armv7l host.  Additionally, a
patched copy of strace was used to verify the conversion for reaping.
Additionally, a MIPS binary of lsusb was run on armv7l host to check reaping
and other functionality across endianness.

Changes from v1:
  use check_include in configure
  move struct definitions to later patch where possible
  improve pointer cast to int compatibility
  remove unimplemented types for usb streams

Changes from v2:
  calculate ioctl arg size at runtime
  organize urb metadata with struct
  hold lock_user memory from submit until reap
  supersedes patch series 'linux-user: usbfs improvements'

Cortland Tölva (3):
  linux-user: Check for Linux USBFS in configure
  linux-user: Define ordinary usbfs ioctls.
  linux-user: Implement special usbfs ioctls.

 configure                  |  12 ++-
 linux-user/ioctls.h        |  46 ++++++++++++
 linux-user/syscall.c       | 180 +++++++++++++++++++++++++++++++++++++++++++++
 linux-user/syscall_defs.h  |  28 +++++++
 linux-user/syscall_types.h |  68 +++++++++++++++++
 5 files changed, 333 insertions(+), 1 deletion(-)

-- 
2.11.0
