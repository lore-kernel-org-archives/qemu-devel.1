Received: from eggs.gnu.org ([2001:4830:134:3::10]:38756)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gAN6K-0002dg-LY
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 18:37:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gAN6G-0000IX-KP
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 18:37:08 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:47072)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gAN6E-0000H1-OM
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 18:37:03 -0400
Received: by mail-wr1-x444.google.com with SMTP id n11-v6so7359696wru.13
	for <qemu-devel@nongnu.org>; Wed, 10 Oct 2018 15:37:01 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 11 Oct 2018 00:36:46 +0200
Message-Id: <20181010223656.31632-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v5 00/10] linux-user: strace improvements
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

Since v4:
- rebased on master (no change)

Since v3:
- addressed Laurent comments
- added print_sockfd()
- removed the print_sockaddr_ptr() patch, also the two
  getsockname()/recvfrom() patches for after 3.0.

Since v2:
- display invalid pointer in print_timeval() and print_timezone()
- do not display gettimeofday() arguments

Since v1:
- addressed Laurent comments
- added 'last' argument to print_sockaddr()
- reordered series, so patches already correct can get applied directly
- dropped "linux-user/syscall: simplify recvfrom()" for now

v1: http://lists.nongnu.org/archive/html/qemu-devel/2018-01/msg05855.html
v2: http://lists.nongnu.org/archive/html/qemu-devel/2018-06/msg08216.html
v3: http://lists.nongnu.org/archive/html/qemu-devel/2018-07/msg00411.html

$ git backport-diff
[----] : patches are identical
[####] : number of functional differences between upstream/downstream patch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respectively

001/12:[----] [--] 'linux-user/syscall: Verify recvfrom(addr) is user-writable'
002/12:[----] [--] 'linux-user/strace: Improve capget()/capset() output'
003/12:[0002] [FC] 'linux-user/strace: Display invalid pointer in print_timeval()'
004/12:[0002] [FC] 'linux-user/strace: Add print_timezone()'
005/12:[----] [--] 'linux-user/strace: Improve settimeofday()'
006/12:[down] 'linux-user/syscall: Introduce target_sockaddr_nl'
007/12:[0018] [FC] 'linux-user/strace: Dump AF_NETLINK sockaddr content'
008/12:[----] [--] 'linux-user/strace: Improve recvmsg() output'
009/12:[down] 'linux-user/strace: Add print_sockfd()'
010/12:[0004] [FC] 'linux-user/strace: Let print_sockaddr() have a 'last' argument'
011/12:[0004] [FC] 'linux-user/strace: Improve bind() output'
012/12:[0004] [FC] 'linux-user/strace: improve sendto() output'

Philippe Mathieu-Daudé (10):
  linux-user/syscall: Verify recvfrom(addr) is user-writable
  linux-user/strace: Display invalid pointer in print_timeval()
  linux-user/strace: Add print_timezone()
  linux-user/strace: Improve settimeofday()
  linux-user/syscall: Introduce target_sockaddr_nl
  linux-user/strace: Dump AF_NETLINK sockaddr content
  linux-user/strace: Add print_sockfd()
  linux-user/strace: Let print_sockaddr() have a 'last' argument
  linux-user/strace: Improve bind() output
  linux-user/strace: improve sendto() output

 linux-user/syscall_defs.h |   7 ++
 linux-user/strace.c       | 133 ++++++++++++++++++++++++++++++++++----
 linux-user/syscall.c      |  11 +++-
 linux-user/strace.list    |   6 +-
 4 files changed, 139 insertions(+), 18 deletions(-)

-- 
2.19.1
