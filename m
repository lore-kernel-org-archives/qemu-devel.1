Received: from eggs.gnu.org ([2001:4830:134:3::10]:47750)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1evqFF-0001YQ-IU
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 16:10:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1evqFE-0007Ih-Bc
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 16:10:01 -0400
Received: from mail-yw0-x22d.google.com ([2607:f8b0:4002:c05::22d]:37973)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1evqFE-0007IC-64
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 16:10:00 -0400
Received: by mail-yw0-x22d.google.com with SMTP id y203so635041ywg.5
	for <qemu-devel@nongnu.org>; Tue, 13 Mar 2018 13:10:00 -0700 (PDT)
MIME-Version: 1.0
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Tue, 13 Mar 2018 13:09:58 -0700
Message-ID: <CAMo8BfLuAdsdRScY+CgTzd0EBn3_kAFc=ysEwgp3MrM_+42viQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] regression in timer code?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgaluk <Pavel.Dovgaluk@ispras.ru>, qemu-devel <qemu-devel@nongnu.org>

Hi Pavel,

the commit b39e3f34c9de7ead6a11a74aa2de78baf41d81a7
("icount: fixed saving/restoring of icount warp timers") has changed
something that made timers test for target/xtensa unstable.
Specifically ccount_write case in the tests/tcg/xtensa/test_timer.S
now fails for me about half of the times it is run. Given that it is run
under -icount I guess this is a bug. Could you please take a look?

The minimal test case is available here:
  http://jcmvbkbc.spb.ru/~dumb/tmp/201803131306/test_timer.tst
It is run as
  qemu-system-xtensa -M sim -cpu dc232b -nographic -semihosting
-icount 7  -kernel ./test_timer.tst

-- 
Thanks.
-- Max
