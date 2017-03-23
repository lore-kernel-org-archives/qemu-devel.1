Received: from eggs.gnu.org ([2001:4830:134:3::10]:37546)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cr4Qi-0007rP-NC
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 11:13:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cr4Qh-0004G7-MZ
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 11:13:36 -0400
Received: from mail-wr0-x229.google.com ([2a00:1450:400c:c0c::229]:33698)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cr4Qh-0004Fl-F3
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 11:13:35 -0400
Received: by mail-wr0-x229.google.com with SMTP id y90so31962935wrb.0
	for <qemu-devel@nongnu.org>; Thu, 23 Mar 2017 08:13:35 -0700 (PDT)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 Mar 2017 15:13:13 +0000
Message-ID: <CAFEAcA8EgBp8=xjyfR+nuYw5KvdptNC++o39nAJiwu-SWWM+yw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Qemu-devel] qga-test failure on Linux/sparc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>

Hi; I find that qga-test fails on Linux/sparc host:

test-qga.c:286:test_qga_get_fsinfo: assertion failed
ret: GenericError opendir("/sys/devices/virtual/block/md0/md0p1/slaves")

On this box /sys/devices/virtual/block/md0/md0p1/ does indeed
not have a slaves/ subdirectory. There is a slaves/ subdirectory
in the md0/ directory one level up, though.

Looking at the code in qga/commands-posix.c it seems to just assume
that slaves/ exists and throws an error otherwise. Should this
code be coping with the missing directory more gracefully, or
does it have a bug where it's looking for slaves/ in the wrong
place in the tree?

thanks
-- PMM
