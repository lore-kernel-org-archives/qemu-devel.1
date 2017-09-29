Received: from eggs.gnu.org ([2001:4830:134:3::10]:53384)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <michael@fritscher.net>) id 1dxtF5-0005vo-Oe
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 07:14:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <michael@fritscher.net>) id 1dxtF3-0007jr-1c
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 07:14:03 -0400
Received: from mifritscher.de ([188.40.170.105]:32918
	helo=mail.mifritscher.vserverkompetenz.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <michael@fritscher.net>)
	id 1dxtF2-0007j1-Rs
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 07:14:00 -0400
From: Michael Fritscher <michael@fritscher.net>
Date: Fri, 29 Sep 2017 13:13:05 +0200
Message-Id: <20170929111323.6308-1-michael@fritscher.net>
Subject: [Qemu-devel] Make 9pfs buildable for Windows
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: gkurz@linux.vnet.ibm.com, sw@weilnetz.de, aneesh.kumar@linux.vnet.ibm.com, mst@redhat.com, qemu-devel@nongnu.org
List-ID: <qemu-devel.nongnu.org>


Good day,

this is the patch series to make 9pfs buildable (not working!) on Windows.
It is compiling and starts, but obvousily 9pfs is not working - in fact it
spits out a initializing error.

Next step: Implement the directory and file handling stuff.

Quoting myself:

"
The biggest issue seems to be the *at stuff. I'll
try to workaround this via getting the directories' path from the file
descriptor with the /proc (as it is already done in the 9pfs_utils) -
luckily,the mingw environment emulates the /proc. If this doesn't work
I've another idea (the file descriptors needs to be "registered" with the
path (and saved in a sparse vector or map with the fd as key and the path
as value). The "big" solution would be to write a 9p_local_windows.c from
scratch, but I would like to avoid it.
"

I know that some people want to have compiling and working together, but I
hope(!) that I get a first working version next week.

Best regards,
Michael Fritscher
