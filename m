Received: from eggs.gnu.org ([2001:4830:134:3::10]:41823)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1gUJ3A-0002MV-3d
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 17:20:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1gUIst-0008Te-SE
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 17:09:43 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47828)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1gUIst-0008Sh-IP
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 17:09:39 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wB4M9ZRJ027162
	for <qemu-devel@nongnu.org>; Tue, 4 Dec 2018 17:09:37 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2p5xp60g6s-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 04 Dec 2018 17:09:36 -0500
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 4 Dec 2018 22:09:35 -0000
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Tue, 04 Dec 2018 16:09:25 -0600
Message-Id: <154396136510.28165.4535783800828361377@sif>
Subject: [Qemu-devel] [ANNOUNCE] QEMU 3.1.0-rc4 is now available
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
fifth release candidate for the QEMU 3.1 release.  This release is meant
for testing purposes and should not be used in a production environment.

  http://download.qemu-project.org/qemu-3.1.0-rc4.tar.xz
  http://download.qemu-project.org/qemu-3.1.0-rc4.tar.xz.sig

A note from the maintainer:

  We had a handful of late-breaking fixes for security and other
  major issues, so we needed to have an rc4. Unless anything catastrophic
  turns up in the next week, this will be the final release candidate
  and we will make the final release next Tuesday on the 11th.

You can help improve the quality of the QEMU 3.1 release by testing this
release and reporting bugs on Launchpad:

  https://bugs.launchpad.net/qemu/

The release plan, as well a documented known issues for release
candidates, are available at:

  http://wiki.qemu.org/Planning/3.1

Please add entries to the ChangeLog for the 3.1 release below:

  http://wiki.qemu.org/ChangeLog/3.1

Thank you to everyone involved!

Changes since rc3:

80422b0019: Update version for v3.1.0-rc4 release (Peter Maydell)
118cafff25: virtio-net-test: add large tx buffer test (Jason Wang)
432a82d727: virtio-net-test: remove unused macro (Jason Wang)
ae4c445c6f: virtio-net-test: accept variable length argument in pci_test_st=
art() (Jason Wang)
56512e1dc1: net: hub: suppress warnings of no host network for qtest (Jason=
 Wang)
25c01bd19d: net: drop too large packet early (Jason Wang)
c52d46e041: usb-mtp: outlaw slashes in filenames (Gerd Hoffmann)
6de02a1323: usb-mtp: fix utf16_to_str (Gerd Hoffmann)
db5e8210ad: iotests: simple mirror test with kvm on 1G image (Vladimir Seme=
ntsov-Ogievskiy)
d12ade5732: mirror: fix dead-lock (Vladimir Sementsov-Ogievskiy)
83ea23cd20: i386: hvf: Fix overrun of _decode_tbl1 (Roman Bolshakov)
629457a130: i2c: Add a length check to the SMBus write handling (Corey Miny=
ard)
c688e6ca7b: nbd/client: Send NBD_CMD_DISC if open fails after connect (Eric=
 Blake)
47829c4079: nbd/client: Make x-dirty-bitmap more reliable (Eric Blake)
e31d802479: nbd/server: Advertise all contexts in response to bare LIST (Er=
ic Blake)
