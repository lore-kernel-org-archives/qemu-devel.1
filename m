Received: from eggs.gnu.org ([2001:4830:134:3::10]:60469)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fa2yK-0004xL-2T
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 13:50:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fa2yG-0003Xo-4s
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 13:50:44 -0400
Received: from mail-vk0-x236.google.com ([2607:f8b0:400c:c05::236]:39840)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fa2yF-0003Xc-TR
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 13:50:40 -0400
Received: by mail-vk0-x236.google.com with SMTP id v16-v6so6539002vkd.6
	for <qemu-devel@nongnu.org>; Mon, 02 Jul 2018 10:50:39 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon,  2 Jul 2018 14:50:17 -0300
Message-Id: <20180702175030.18621-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 00/13] linux-user: strace improvements
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

$ git backport-diff
[----] : patches are identical
[####] : number of functional differences between upstream/downstream patch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respectively

001/13:[----] [--] 'linux-user/syscall: Verify recvfrom(addr) is user-writable'
002/13:[----] [--] 'linux-user/strace: Improve capget()/capset() output'
003/13:[down] 'linux-user/strace: Display invalid pointer in print_timeval()'
004/13:[0001] [FC] 'linux-user/strace: Add print_timezone()'
005/13:[down] 'linux-user/strace: Improve settimeofday()'
006/13:[----] [--] 'linux-user/strace: Dump AF_NETLINK sockaddr content'
007/13:[----] [--] 'linux-user/strace: Improve recvmsg() output'
008/13:[----] [--] 'linux-user/strace: Improve bind() output'
009/13:[----] [--] 'linux-user/strace: improve sendto() output'
010/13:[----] [--] 'linux-user/strace: Let print_sockaddr() have a 'last' argument'
011/13:[----] [--] 'linux-user/strace: Add print_sockaddr_ptr() to handle plain/pointer addrlen'
012/13:[----] [--] 'linux-user/strace: Improve getsockname() output'
013/13:[----] [--] 'linux-user/strace: Improve recvfrom() output'

Philippe Mathieu-Daudé (13):
  linux-user/syscall: Verify recvfrom(addr) is user-writable
  linux-user/strace: Improve capget()/capset() output
  linux-user/strace: Display invalid pointer in print_timeval()
  linux-user/strace: Add print_timezone()
  linux-user/strace: Improve settimeofday()
  linux-user/strace: Dump AF_NETLINK sockaddr content
  linux-user/strace: Improve recvmsg() output
  linux-user/strace: Improve bind() output
  linux-user/strace: improve sendto() output
  linux-user/strace: Let print_sockaddr() have a 'last' argument
  linux-user/strace: Add print_sockaddr_ptr() to handle plain/pointer addrlen
  linux-user/strace: Improve getsockname() output
  linux-user/strace: Improve recvfrom() output

 linux-user/syscall_defs.h |   7 ++
 linux-user/strace.c       | 164 ++++++++++++++++++++++++++++++++++++--
 linux-user/syscall.c      |  11 ++-
 linux-user/strace.list    |  16 ++--
 4 files changed, 182 insertions(+), 16 deletions(-)

-- 
2.18.0
