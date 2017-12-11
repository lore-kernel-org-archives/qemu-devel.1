Received: from eggs.gnu.org ([2001:4830:134:3::10]:41668)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eOSzk-0003A5-0n
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 13:40:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eOSzg-0008JX-Ta
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 13:40:04 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60018)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1eOSzg-0008IP-Kd
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 13:40:00 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vBBIahi3089876
	for <qemu-devel@nongnu.org>; Mon, 11 Dec 2017 13:39:58 -0500
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2esy6jrub4-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 11 Dec 2017 13:39:57 -0500
Received: from localhost
	by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 11 Dec 2017 13:39:56 -0500
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 11 Dec 2017 12:39:49 -0600
Message-Id: <151301758941.21308.5606939662970928439@sif>
Subject: [Qemu-devel] [ANNOUNCE] QEMU 2.11.0-rc5 is now available
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
sixth release candidate for the QEMU 2.11 release.  This release is meant
for testing purposes and should not be used in a production environment.

  http://download.qemu-project.org/qemu-2.11.0-rc5.tar.xz
  http://download.qemu-project.org/qemu-2.11.0-rc5.tar.xz.sig

A note from the maintainer:

  Unfortunately we had a late-breaking bug in QEMU's Arm CPU
  emulation, so we've had to roll a 5th release candidate.
  This has just one bugfix in it compared to rc4, and we
  plan to make the final 2.11 release on Wednesday.

You can help improve the quality of the QEMU 2.11 release by testing this
release and reporting bugs on Launchpad:

  https://bugs.launchpad.net/qemu/

The release plan, as well a documented known issues for release
candidates, are available at:

  http://wiki.qemu.org/Planning/2.11

Please add entries to the ChangeLog for the 2.11 release below:

  http://wiki.qemu.org/ChangeLog/2.11

Changes since rc4:

6afd0c1998: Update version for v2.11.0-rc5 release (Peter Maydell)
7472e2efb0: target/arm: Generate UNDEF for 32-bit Thumb2 insns (Peter Mayde=
ll)
