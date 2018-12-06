Received: from eggs.gnu.org ([2001:4830:134:3::10]:57337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1gUzeY-000517-2b
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 14:49:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1gUzeT-0005ay-LO
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 14:49:41 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56034
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1gUzeR-0005NL-5c
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 14:49:35 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wB6JkdXY133141
	for <qemu-devel@nongnu.org>; Thu, 6 Dec 2018 14:49:25 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2p79gdac60-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 06 Dec 2018 14:49:24 -0500
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Thu, 6 Dec 2018 19:49:24 -0000
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Thu, 06 Dec 2018 13:49:16 -0600
Message-Id: <154412575675.28165.1045144454243662584@sif>
Subject: [Qemu-devel] [ANNOUNCE] QEMU 3.1.0-rc5 is now available
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
sixth release candidate for the QEMU 3.1 release.  This release is meant
for testing purposes and should not be used in a production environment.

  http://download.qemu-project.org/qemu-3.1.0-rc5.tar.xz
  http://download.qemu-project.org/qemu-3.1.0-rc5.tar.xz.sig

A note from the maintainer:

  This release candidate contains just one extra fix over rc4,
  which fixes a buffer overflow bug in the smbus i2c device model.
  Note that this bug is exploitable by a guest to escape from the
  virtual machine. However the commit which introduced the bug was
  only made after the 3.0 release, and so it is not present in any
  released QEMU versions (only in development snapshots and the
  previous release candidates).
  =

  We plan to make the final 3.1.0 release on schedule on
  Tuesday 11th.

You can help improve the quality of the QEMU 3.1 release by testing this
release and reporting bugs on Launchpad:

  https://bugs.launchpad.net/qemu/

The release plan, as well a documented known issues for release
candidates, are available at:

  http://wiki.qemu.org/Planning/3.1

Please add entries to the ChangeLog for the 3.1 release below:

  http://wiki.qemu.org/ChangeLog/3.1

Thank you to everyone involved!

Changes since rc4:

4f818e7b7f: Update version for v3.1.0-rc5 release (Peter Maydell)
f2609ffdf3: i2c: pm_smbus: check smb_index before block transfer write (Pra=
sad J Pandit)
