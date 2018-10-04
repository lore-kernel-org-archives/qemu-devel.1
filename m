Received: from eggs.gnu.org ([2001:4830:134:3::10]:38598)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dcsapak@zita.proxmox.com>) id 1g822Y-0004WX-00
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 07:43:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dcsapak@zita.proxmox.com>) id 1g822T-0005vL-1B
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 07:43:33 -0400
Received: from proxmox-new.maurer-it.com ([212.186.127.180]:25570)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dcsapak@zita.proxmox.com>)
	id 1g822S-0005SL-BE
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 07:43:28 -0400
From: Dominik Csapak <d.csapak@proxmox.com>
Date: Thu,  4 Oct 2018 13:43:09 +0200
Message-Id: <20181004114312.27346-1-d.csapak@proxmox.com>
Subject: [Qemu-devel] [PATCH v2 0/3] add exit-script option to qemu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, sw@weilnetz.de, jasowang@redhat.com, thuth@redhat.com, philmd@redhat.com

this patch series aims to execute a script when qemu exits
so that one can do cleanups when using --daemonize without
having to use the qmp monitor

changes since v1:

* refactored as qemu_launch_script, only for non-windows platforms
* updated net/tap.c to use qemu_launch_script instead of launch_script
* fixed a small error in the option description

Dominik Csapak (3):
  osdep: add qemu_launch_script for executing scripts
  tap: use qemu_launch_script instead of launch_script
  vl.c: call optional script when exiting

 include/qemu/osdep.h | 12 +++++++++++
 net/tap.c            | 56 ++++++++++------------------------------------------
 qemu-options.hx      | 20 +++++++++++++++++++
 util/oslib-posix.c   | 34 +++++++++++++++++++++++++++++++
 util/oslib-win32.c   |  8 ++++++++
 vl.c                 | 29 +++++++++++++++++++++++++++
 6 files changed, 113 insertions(+), 46 deletions(-)

-- 
2.11.0
