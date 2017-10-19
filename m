Received: from eggs.gnu.org ([2001:4830:134:3::10]:40532)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e5B2W-0006Ka-61
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 09:39:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e5B2V-000327-Bc
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 09:39:12 -0400
Received: from mail-wm0-x231.google.com ([2a00:1450:400c:c09::231]:49224)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e5B2V-00031j-3n
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 09:39:11 -0400
Received: by mail-wm0-x231.google.com with SMTP id b189so15974506wmd.4
	for <qemu-devel@nongnu.org>; Thu, 19 Oct 2017 06:39:10 -0700 (PDT)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Oct 2017 14:38:49 +0100
Message-ID: <CAFEAcA8Ag-Yv6WCA16xU8haaW17HzQ7aRvUGQYsbfA+LRSfASQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] qga/blacklist test failures
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>

Hi; I'm seeing /qga/blacklist test failures on one of my machines:

/qga/blacklist: **
ERROR:/home/petmay01/linaro/qemu-for-merges/tests/test-qga.c:674:test_qga_blacklist:
assertion failed ret: GenericError realpath("/sys/dev/block/8:33"): No
such file or directory
 FAIL

It's correct that there's no such file in /sys/dev/block.

This seems to have been caused by my having an entry in the
host's mount table which is stale (a USB block device which
was disconnected without running umount), but it would be
nice if the test didn't blow up because of minor oddities
like that in the host's configuration.

(At any rate, running umount on the offending mountpoint
causes the test to stop failing.)

thanks
-- PMM
