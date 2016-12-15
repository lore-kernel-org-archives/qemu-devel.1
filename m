Received: from eggs.gnu.org ([2001:4830:134:3::10]:53802)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cHWqg-0007MX-TW
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 09:17:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cHWqd-00022X-JT
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 09:17:30 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46581
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cHWqd-00022P-EL
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 09:17:27 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uBFEDWHB032579
	for <qemu-devel@nongnu.org>; Thu, 15 Dec 2016 09:17:26 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0b-001b2d01.pphosted.com with ESMTP id 27bt84rpv8-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 15 Dec 2016 09:17:26 -0500
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Thu, 15 Dec 2016 07:17:24 -0700
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Thu, 15 Dec 2016 08:17:11 -0600
Message-Id: <20161215141711.14429.4742@loki>
Subject: [Qemu-devel] [ANNOUNCE] QEMU 2.8.0-rc4 is now available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com

Hello,

On behalf of the QEMU Team, I'd like to announce the availability of the
fifth release candidate for the QEMU 2.8 release.  This release is meant
for testing purposes and should not be used in a production environment.

http://wiki.qemu.org/download/qemu-2.8.0-rc4.tar.bz2

Barring the discovery of any major issues, this is the last planned RC
before the release of QEMU 2.8, so your testing is greatly appreciated.

You can help improve the quality of the QEMU 2.8 release by testing this
release and reporting bugs on Launchpad or directly to the mailing list:

https://bugs.launchpad.net/qemu/

The release plan, as well a documented known issues for release
candidates, are available at:

http://wiki.qemu.org/Planning/2.8

Please add entries to the ChangeLog for the 2.8 release below:

http://wiki.qemu.org/ChangeLog/2.8

Changes since rc3:

6a928d2: Update version for v2.8.0-rc4 release (Stefan Hajnoczi)
66d1c4c: virtio-pci: Fix cross-version migration with older machines (Maxim=
e Coquelin)
d70678a: po: add missing translations in de, fr, it, zh (Stefan Hajnoczi)
a081563: ui/gtk: fix "Copy" menu item segfault (Stefan Hajnoczi)
3753c75: Update language files for QEMU 2.8.0 (Stefan Hajnoczi)
