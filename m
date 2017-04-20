Received: from eggs.gnu.org ([2001:4830:134:3::10]:54645)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1d1LI5-0003YR-IC
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 19:15:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1d1LI2-0006QZ-DU
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 19:15:09 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36470
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1d1LI2-0006QD-6a
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 19:15:06 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v3KNE85e037120
	for <qemu-devel@nongnu.org>; Thu, 20 Apr 2017 19:15:05 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
	by mx0b-001b2d01.pphosted.com with ESMTP id 29xvy2ar77-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 20 Apr 2017 19:15:05 -0400
Received: from localhost
	by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Thu, 20 Apr 2017 19:15:04 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Thu, 20 Apr 2017 18:14:54 -0500
Message-Id: <149273009469.5829.1877204641747528305@loki>
Subject: [Qemu-devel] [ANNOUNCE] QEMU 2.8.1.1 CVE update released
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org

Hi everyone,

A security update to the QEMU 2.8 series is now available at:

  http://wiki.qemu.org/download/qemu-2.8.1.1.tar.xz
  http://wiki.qemu.org/download/qemu-2.8.1.1.tar.xz.sig

v2.8.1.1 is now tagged in the official qemu.git repository,
and the stable-2.8 branch has been updated accordingly:

  http://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Drefs/heads/stable-2.8

This release includes security fixes for:

  virtfs/virtio-9p shared directories (CVE-2017-7471)  =


Please see the changelogs and relevant CVEs for more information, and
update accordingly.

Thank you to everyone involved!

CHANGELOG:

d1b725e: Update version for 2.8.1.1 release (Michael Roth)
96bae14: 9pfs: local: set the path of the export root to "." (Greg Kurz)
