Received: from eggs.gnu.org ([2001:4830:134:3::10]:39208)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jinguojie@loongson.cn>) id 1cQWlq-0007hd-9N
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 05:01:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jinguojie@loongson.cn>) id 1cQWlo-0006Bh-3n
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 05:01:42 -0500
Received: from [114.242.206.163] (port=51978 helo=mail.loongson.cn)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jinguojie@loongson.cn>) id 1cQWln-00069c-84
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 05:01:40 -0500
From: Jin Guojie <jinguojie@loongson.cn>
Date: Mon,  9 Jan 2017 18:01:22 +0800
Message-Id: <20170109100123.5080-1-jinguojie@loongson.cn>
Subject: [Qemu-devel] [PATCH 0/1] Change default CFLAGS to -O3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jin Guojie <jinguojie@loongson.cn>

* in configure, the default optimization level is changed to O3.
* Tested successfully on following machines:

  | Host machine | Host OS  | qemu-system | Debian ISO  |
  |-----------------------------------------------------|
  |   x86 64     | Fedora25 |    i386     |    i386     |
  | mips 64 le   | Fedora25 |    i386     |    i386     |

Signed-off-by: Jin Guojie <jinguojie@loongson.cn>

Jin Guojie (1):
  Change default CFLAGS to -O3

 configure | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.9.3
