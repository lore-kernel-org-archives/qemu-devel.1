Received: from eggs.gnu.org ([2001:4830:134:3::10]:55711)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zyimin@linux.ibm.com>) id 1fIYGu-0003Vi-PB
	for qemu-devel@nongnu.org; Tue, 15 May 2018 07:38:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zyimin@linux.ibm.com>) id 1fIYDR-0003ZV-RZ
	for qemu-devel@nongnu.org; Tue, 15 May 2018 07:37:36 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57522)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <zyimin@linux.ibm.com>)
	id 1fIYDR-0003XV-4d
	for qemu-devel@nongnu.org; Tue, 15 May 2018 07:34:01 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w4FBTlUD109301
	for <qemu-devel@nongnu.org>; Tue, 15 May 2018 07:33:57 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2hyw8gc601-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 15 May 2018 07:33:56 -0400
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <zyimin@linux.ibm.com>;
	Tue, 15 May 2018 05:33:56 -0600
From: Yi Min Zhao <zyimin@linux.ibm.com>
Date: Tue, 15 May 2018 19:33:47 +0800
Message-Id: <20180515113348.10516-1-zyimin@linux.ibm.com>
Subject: [Qemu-devel] [PATCH v2 0/1] Bug: Sandbox: libvirt breakdowns qemu
 guest
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
If QEMU is built without seccomp support, 'elevateprivileges' remains compiled.
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
Compile the code related to sandbox only when CONFIG_SECCOMP is defined.

Yi Min Zhao (1):
  sandbox: disable -sandbox if CONFIG_SECCOMP undefined

 vl.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

-- 
Yi Min
