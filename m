Received: from eggs.gnu.org ([2001:4830:134:3::10]:56889)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1ffBJ1-00063C-6p
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 17:45:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1ffBIy-00041o-3E
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 17:45:19 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45206
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1ffBIx-00041V-EI
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 17:45:15 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w6GLe9iN140919
	for <qemu-devel@nongnu.org>; Mon, 16 Jul 2018 17:45:14 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2k8yxpyxu7-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 16 Jul 2018 17:45:14 -0400
Received: from localhost
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 16 Jul 2018 17:45:13 -0400
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 16 Jul 2018 16:44:48 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20180716214450.17758-1-mdroth@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL for-3.0 0/2] qemu-ga patch queue for hard-freeze
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

The following changes since commit 102ad0a80f5110483efd06877c29c4236be267=
f9:

  Merge remote-tracking branch 'remotes/armbru/tags/pull-misc-2018-07-16'=
 into staging (2018-07-16 15:34:38 +0100)

are available in the git repository at:

  git://github.com/mdroth/qemu.git tags/qga-pull-2018-07-16-tag

for you to fetch changes up to d9c745c1768727aadd77e352c85114bc61e67bd4:

  qga: fix file descriptor leak (2018-07-16 15:05:58 -0500)

----------------------------------------------------------------
qemu-ga patch queue for hard-freeze

* fix file descriptor leak in suspend command
* fix leak in guest-get-fsinfo

----------------------------------------------------------------
Marc-Andr=C3=A9 Lureau (1):
      qga: fix 'driver' leak in guest-get-fsinfo

Paolo Bonzini (1):
      qga: fix file descriptor leak

 qga/commands-posix.c | 2 ++
 1 file changed, 2 insertions(+)
