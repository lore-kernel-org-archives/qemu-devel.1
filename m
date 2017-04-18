Received: from eggs.gnu.org ([2001:4830:134:3::10]:57782)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1d0XYb-0006Ad-40
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 14:08:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1d0XYW-0007LV-4l
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 14:08:53 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58406)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1d0XYV-0007L9-SU
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 14:08:48 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v3II3cSB026763
	for <qemu-devel@nongnu.org>; Tue, 18 Apr 2017 14:08:46 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0a-001b2d01.pphosted.com with ESMTP id 29wqptrcqj-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 18 Apr 2017 14:08:46 -0400
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 18 Apr 2017 12:08:45 -0600
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Tue, 18 Apr 2017 13:08:37 -0500
Message-Id: <149253891746.7320.8297076412968234242@loki>
Subject: [Qemu-devel] [ANNOUNCE] QEMU 2.9.0-rc5 is now available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

Hello,

On behalf of the QEMU Team, I'd like to announce the availability of the
sixth release candidate for the QEMU 2.9 release.  This release is meant
for testing purposes and should not be used in a production environment.

  http://download.qemu-project.org/qemu-2.9.0-rc5.tar.xz
  http://download.qemu-project.org/qemu-2.9.0-rc5.tar.xz.sig

A note from the maintainer:

  This has just two changes since rc4:
   * fix bug where a system_reset could hang if it
     happened while a block job was running
   * a security fix (CVE-2017-7471) for a bug in the 9pfs
     filesystem which could allow a guest to perform
     chmod and chown operations on the host filesystem
     root directory (if QEMU was running with privileges)
  =

  We plan to roll the final release on Thursday with
  no further changes.

You can help improve the quality of the QEMU 2.9 release by testing this
release and reporting bugs on Launchpad:

  https://bugs.launchpad.net/qemu/

The release plan, as well a documented known issues for release
candidates, are available at:

  http://wiki.qemu.org/Planning/2.9

The dates have been pushed back due to delays with the initial RC
and important fixes late in the release cycle.

Please add entries to the ChangeLog for the 2.9 release below:

  http://wiki.qemu.org/ChangeLog/2.9

Changes since rc4:

ca55019: Update version for v2.9.0-rc5 release (Peter Maydell)
91af091: block: Drain BH in bdrv_drained_begin (Fam Zheng)
178bd43: block: Walk bs->children carefully in bdrv_drain_recurse (Fam Zhen=
g)
9c6b899: 9pfs: local: set the path of the export root to "." (Greg Kurz)
