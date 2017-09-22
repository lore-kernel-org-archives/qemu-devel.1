Received: from eggs.gnu.org ([2001:4830:134:3::10]:38233)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jreiser@bitwagon.com>) id 1dvRsI-0005N7-T8
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 13:36:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jreiser@bitwagon.com>) id 1dvRsE-0000xc-RR
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 13:36:26 -0400
Received: from bitwagon.com ([2001:470:0:e6::4a52:27af]:39241)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jreiser@bitwagon.com>)
	id 1dvRsE-0000vW-JP
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 13:36:22 -0400
Received: from f25e64.local ([24.21.156.164]) by bitwagon.com
	for <qemu-devel@nongnu.org>; Fri, 22 Sep 2017 10:36:14 -0700
From: John Reiser <jreiser@bitwagon.com>
Message-ID: <ee4887b4-5c75-b6e8-6fa6-11d73b80f81a@bitwagon.com>
Date: Fri, 22 Sep 2017 10:36:14 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] qemu-ppc 'tweq' vs gdb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

"qemu-ppc -g 1234 foo" emulating the 32-bit PowerPC instruction 0x7c800008
("tweq r0,r0") terminates with "fatal: Tried to call a TRAP".
Instead, when co-operating with gdbserver (-g <port>) then qemu-ppc
should generate a SIGTRAP, just like real execution under gdb.

The "tweq r0,r0" and others are useful as compiled-in breakpoints,
particularly when the location is within just-in-time compiled code.
They also can be used without gdb (in which case execution aborts
if the trap is true), and even with gdb if the condition is false
then they are thousands of times faster than a gdb breakpoint
that has a conditional stop.

--
John
