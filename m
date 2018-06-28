Received: from eggs.gnu.org ([2001:4830:134:3::10]:46033)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fYNti-0007qx-7D
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 23:47:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fYNte-0000Qg-8h
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 23:47:06 -0400
Received: from mail-qk0-x22a.google.com ([2607:f8b0:400d:c09::22a]:39409)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fYNte-0000QW-3B
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 23:47:02 -0400
Received: by mail-qk0-x22a.google.com with SMTP id f3-v6so2261203qkd.6
	for <qemu-devel@nongnu.org>; Wed, 27 Jun 2018 20:47:01 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 28 Jun 2018 00:46:40 -0300
Message-Id: <20180628034652.24152-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 00/12] linux-user: strace improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Riku Voipio <riku.voipio@iki.fi>, =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>

Hi Laurent,

Few patches I'v been writting while trying to figure out this issue:
http://lists.nongnu.org/archive/html/qemu-arm/2018-01/msg00514.html

As usual with linux-user files, this series will trigger some checkpatch
benign warnings.

Regards,

Phil.

Since v1:
- addressed Laurent comments
- added 'last' argument to print_sockaddr()
- reordered series, so patches already correct can get applied directly
- dropped "linux-user/syscall: simplify recvfrom()" for now

v1: http://lists.nongnu.org/archive/html/qemu-devel/2018-01/msg05855.html

$ git backport-diff
[----] : patches are identical
[####] : number of functional differences between upstream/downstream patch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respectively

001/12:[0010] [FC] 'linux-user/strace: Dump AF_NETLINK sockaddr content'
002/12:[down] 'linux-user/strace: Let print_sockaddr() have a 'last' argument'
003/12:[0002] [FC] 'linux-user/strace: Improve sendto() output'
004/12:[0036] [FC] 'linux-user/strace: Add print_sockaddr_ptr() to handle plain/pointer addrlen'
005/12:[0002] [FC] 'linux-user/strace: Improve recvfrom() output'
006/12:[0002] [FC] 'linux-user/strace: Improve getsockname() output'
007/12:[----] [--] 'linux-user/strace: Improve recvmsg() output'
008/12:[0002] [FC] 'linux-user/strace: Improve bind() output'
009/12:[down] 'linux-user/strace: Add print_timezone()'
010/12:[0016] [FC] 'linux-user/strace: Improve gettimeofday() and settimeofday() output'
011/12:[----] [--] 'linux-user/strace: Improve capget()/capset() output'
012/12:[----] [--] 'linux-user/syscall: Verify recvfrom(addr) is user-writable'

Philippe Mathieu-Daudé (12):
  linux-user/syscall: Verify recvfrom(addr) is user-writable
  linux-user/strace: Improve capget()/capset() output
  linux-user/strace: Add print_timezone()
  linux-user/strace: Improve gettimeofday() and settimeofday() output
  linux-user/strace: Dump AF_NETLINK sockaddr content
  linux-user/strace: Improve recvmsg() output
  linux-user/strace: Improve bind() output
  linux-user/strace: improve sendto() output
  linux-user/strace: Let print_sockaddr() have a 'last' argument
  linux-user/strace: Add print_sockaddr_ptr() to handle plain/pointer addrlen
  linux-user/strace: Improve getsockname() output
  linux-user/strace: Improve recvfrom() output

 linux-user/syscall_defs.h |   7 ++
 linux-user/strace.c       | 159 ++++++++++++++++++++++++++++++++++++--
 linux-user/syscall.c      |  11 ++-
 linux-user/strace.list    |  18 ++---
 4 files changed, 179 insertions(+), 16 deletions(-)

-- 
2.18.0
