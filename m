Received: from eggs.gnu.org ([2001:4830:134:3::10]:34626)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zyimin@linux.ibm.com>) id 1fFWt3-0000vr-CE
	for qemu-devel@nongnu.org; Sun, 06 May 2018 23:32:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zyimin@linux.ibm.com>) id 1fFWt0-0002YX-99
	for qemu-devel@nongnu.org; Sun, 06 May 2018 23:32:29 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59160
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <zyimin@linux.ibm.com>)
	id 1fFWt0-0002Wm-37
	for qemu-devel@nongnu.org; Sun, 06 May 2018 23:32:26 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w473TPqY057329
	for <qemu-devel@nongnu.org>; Sun, 6 May 2018 23:32:24 -0400
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2htbs1we1g-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Sun, 06 May 2018 23:32:23 -0400
Received: from localhost
	by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <zyimin@linux.ibm.com>;
	Sun, 6 May 2018 23:32:23 -0400
From: Yi Min Zhao <zyimin@linux.ibm.com>
Date: Mon,  7 May 2018 11:32:13 +0800
Message-Id: <20180507033214.19219-1-zyimin@linux.ibm.com>
Subject: [Qemu-devel] [PATCH 0/1] Bug: Sandbox: libvirt breakdowns qemu guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jtomko@redhat.com, jferlan@redhat.com, berrange@redhat.com, otubo@redhat.com, borntraeger@de.ibm.com, fiuczy@linux.ibm.com, zyimin@linux.ibm.com

1. Problem Description
======================
If QEMU is built without seccomp support, 'elevatorprivileges' remains compiled.
This option of sandbox is treated as an indication for seccomp blacklist support
in libvirt. This behavior is introduced by the libvirt commits 31ca6a5 and
3527f9d. It would make libvirt build wrong QEMU cmdline, and then the guest
startup would fail.

2. Libvirt Log
==============
qemu-system-s390x: -sandbox on,obsolete=deny,elevateprivileges=deny,spawn=deny,\
resourcecontrol=deny: seccomp support is disabled

3. Fixup
========
Wrap the options except 'enable' for qemu_sandbox_opts by CONFIG_SECCOMP.

Yi Min Zhao (1):
  sandbox: avoid to compile options if CONFIG_SECCOMP undefined

 vl.c | 2 ++
 1 file changed, 2 insertions(+)

-- 
2.15.1 (Apple Git-101)
