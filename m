Received: from eggs.gnu.org ([2001:4830:134:3::10]:33107)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1faNJV-0008E1-5Z
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 11:33:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1faNJS-0001MS-07
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 11:33:57 -0400
Received: from mail-qt0-x22c.google.com ([2607:f8b0:400d:c0d::22c]:37067)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1faNJR-0001Lw-Rx
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 11:33:53 -0400
Received: by mail-qt0-x22c.google.com with SMTP id a18-v6so1926991qtj.4
	for <qemu-devel@nongnu.org>; Tue, 03 Jul 2018 08:33:53 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue,  3 Jul 2018 12:33:34 -0300
Message-Id: <20180703153346.9050-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 00/12] linux-user: strace improvements
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

Philippe Mathieu-Daudé (12):
  linux-user/syscall: Verify recvfrom(addr) is user-writable
  linux-user/strace: Improve capget()/capset() output
  linux-user/strace: Display invalid pointer in print_timeval()
  linux-user/strace: Add print_timezone()
  linux-user/strace: Improve settimeofday()
  linux-user/syscall: Introduce target_sockaddr_nl
  linux-user/strace: Dump AF_NETLINK sockaddr content
  linux-user/strace: Improve recvmsg() output
  linux-user/strace: Add print_sockfd()
  linux-user/strace: Let print_sockaddr() have a 'last' argument
  linux-user/strace: Improve bind() output
  linux-user/strace: improve sendto() output

 linux-user/syscall_defs.h |   7 ++
 linux-user/strace.c       | 133 ++++++++++++++++++++++++++++++++++----
 linux-user/syscall.c      |  11 +++-
 linux-user/strace.list    |  12 ++--
 4 files changed, 142 insertions(+), 21 deletions(-)

-- 
2.18.0
