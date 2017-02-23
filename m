Received: from eggs.gnu.org ([2001:4830:134:3::10]:44400)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cgy9C-0004NO-JP
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 13:29:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cgy9B-0006ec-QI
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 13:29:46 -0500
Received: from mail-wr0-x234.google.com ([2a00:1450:400c:c0c::234]:34506)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cgy9B-0006dM-K1
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 13:29:45 -0500
Received: by mail-wr0-x234.google.com with SMTP id z61so27005868wrc.1
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 10:29:45 -0800 (PST)
MIME-Version: 1.0
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 23 Feb 2017 18:29:44 +0000
Message-ID: <CAJSP0QVjokCyvVtDcyWBhDqsWKwdNX6zyAo1uL9VmyzMfakS9A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Qemu-devel] Hang in aio/multi/mutex/mcs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, qemu-devel <qemu-devel@nongnu.org>

Hi Paolo,
Alex Benne reported that Travis CI is hanging in aio/multi/mutex/mcs:

https://travis-ci.org/qemu/qemu/builds/203811867

0x00007fe9d680052d in nanosleep () from
target:/lib/x86_64-linux-gnu/libpthread.so.0
(gdb) info threads
  Id   Target Id         Frame
* 1    LWP 15116 "test-aio-multit" 0x00007fe9d680052d in nanosleep ()
from target:/lib/x86_64-linux-gnu/libpthread.so.0
(gdb) bt
#0  0x00007fe9d680052d in nanosleep () from
target:/lib/x86_64-linux-gnu/libpthread.so.0
#1  0x00007fe9d74c6072 in g_usleep () from
target:/lib/x86_64-linux-gnu/libglib-2.0.so.0
#2  0x000055b90b2e9dca in test_multi_fair_mutex (seconds=1, threads=5)
at /tmp/qemu-test/src/tests/test-aio-multithread.c:363
#3  0x00007fe9d74c365b in ?? () from
target:/lib/x86_64-linux-gnu/libglib-2.0.so.0
#4  0x00007fe9d74c37d6 in ?? () from
target:/lib/x86_64-linux-gnu/libglib-2.0.so.0
#5  0x00007fe9d74c37d6 in ?? () from
target:/lib/x86_64-linux-gnu/libglib-2.0.so.0
#6  0x00007fe9d74c37d6 in ?? () from
target:/lib/x86_64-linux-gnu/libglib-2.0.so.0
#7  0x00007fe9d74c3b2b in g_test_run_suite () from
target:/lib/x86_64-linux-gnu/libglib-2.0.so.0
#8  0x000055b90b2e758c in main (argc=1, argv=0x7ffd65cb4928) at
/tmp/qemu-test/src/tests/test-aio-multithread.c:462

Stefan
