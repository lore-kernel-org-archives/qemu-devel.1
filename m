Received: from eggs.gnu.org ([2001:4830:134:3::10]:56551)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gsomlo@gmail.com>) id 1ctzjN-0004v7-Bt
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 12:48:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gsomlo@gmail.com>) id 1ctzjI-0004p3-HS
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 12:48:57 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:33716)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <gsomlo@gmail.com>) id 1ctzjI-0004oL-DA
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 12:48:52 -0400
Received: by mail-qt0-x243.google.com with SMTP id r45so10929749qte.0
	for <qemu-devel@nongnu.org>; Fri, 31 Mar 2017 09:48:52 -0700 (PDT)
From: "Gabriel L. Somlo" <gsomlo@gmail.com>
Date: Fri, 31 Mar 2017 12:48:38 -0400
Message-Id: <1490978921-3782-1-git-send-email-gsomlo@gmail.com>
Subject: [Qemu-devel] [PATCH v1 0/3] Update AppleSMC for OS X Sierra 10.12.4
 guests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: agraf@suse.de, eshelton@pobox.com

As of 10.12.4 (currently the latest Sierra update), OS X refuses to boot
unless the AppleSMC supports a third I/O port, which provides the current
error status when read.

This series consists of three patches:

	- 1/3: indentation/whitespace cleanup for applesmc.c to the point
		where it now passes scripts/checkpatc.pl, and allows
		subsequent changes to look nice in diff-patch format :)

	- 2/3: consolidate Port I/O into a single region, and invoke
		appropriate read/write methods based on the offset being
		accessed

	- 3/3: implement read-only error/status port, and update
		data and command read/write methods to correctly
		maintain the state machine for keeping the status_1e
		value up to date.

Thanks,
  --Gabriel

Gabriel L. Somlo (3):
  applesmc: cosmetic whitespace and indentation cleanup
  applesmc: consolidate port i/o into single contiguous region
  applesmc: implement error status port

 hw/misc/applesmc.c | 254 +++++++++++++++++++++++++++++++++++------------------
 1 file changed, 167 insertions(+), 87 deletions(-)

-- 
2.7.4
