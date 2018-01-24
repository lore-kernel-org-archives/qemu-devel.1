Received: from eggs.gnu.org ([2001:4830:134:3::10]:50762)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eeKgK-00032b-9D
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 08:01:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eeKgG-0005Gp-C2
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 08:01:36 -0500
Received: from mail-qt0-x22f.google.com ([2607:f8b0:400d:c0d::22f]:33276)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eeKgG-0005GL-8z
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 08:01:32 -0500
Received: by mail-qt0-x22f.google.com with SMTP id d8so10044263qtm.0
	for <qemu-devel@nongnu.org>; Wed, 24 Jan 2018 05:01:32 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 24 Jan 2018 10:01:15 -0300
Message-Id: <20180124130126.20871-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 00/11] linux-user: improve NETLINK strace
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>

Few patches I'v been writting while trying to figure out this issue:
http://lists.nongnu.org/archive/html/qemu-arm/2018-01/msg00514.html

Regards,

Phil.

Philippe Mathieu-Daudé (11):
  linux-user/strace: dump AF_NETLINK sockaddr content
  linux-user/strace: improve sendto() output
  linux-user/strace: add print_sockaddr_ptr() to handle plain/pointer addrlen
  linux-user/strace: improve recvfrom() output
  linux-user/strace: improve getsockname() output
  linux-user/strace: improve recvmsg() output
  linux-user/strace: improve bind() output
  linux-user/strace: improve gettimeofday() output
  linux-user/strace: improve capget()/capset() output
  linux-user/syscall: verify recvfrom(addr) is user-writable
  linux-user/syscall: simplify recvfrom()

 linux-user/syscall_defs.h |   7 +++
 linux-user/strace.c       | 122 +++++++++++++++++++++++++++++++++++++++++++++-
 linux-user/syscall.c      |  16 +++---
 linux-user/strace.list    |  16 +++---
 4 files changed, 144 insertions(+), 17 deletions(-)

-- 
2.15.1
