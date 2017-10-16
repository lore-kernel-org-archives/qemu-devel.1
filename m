Received: from eggs.gnu.org ([2001:4830:134:3::10]:37980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1e475i-0000Qz-Jb
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 11:14:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1e475e-0001Ma-L3
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 11:14:06 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39922)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1e475e-0001Ln-Aj
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 11:14:02 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9GF99Yw029917
	for <qemu-devel@nongnu.org>; Mon, 16 Oct 2017 11:13:58 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2dmvec26m2-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 16 Oct 2017 11:13:58 -0400
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Mon, 16 Oct 2017 16:13:55 +0100
From: Greg Kurz <groug@kaod.org>
Date: Mon, 16 Oct 2017 17:13:36 +0200
Message-Id: <20171016151337.4121-1-groug@kaod.org>
Subject: [Qemu-devel] [PULL 0/1] 9pfs patches for 2.11 20171016
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Greg Kurz <groug@kaod.org>

The following changes since commit 40a1e8ac2e10155b5df13a2508ac080b00cd7e23:

  Merge remote-tracking branch 'remotes/elmarco/tags/vu-pull-request' into staging (2017-10-16 10:22:39 +0100)

are available in the git repository at:

  https://github.com/gkurz/qemu.git tags/for-upstream

for you to fetch changes up to 7bd92756303f2158a68d5166264dc30139b813b6:

  9pfs: use g_malloc0 to allocate space for xattr (2017-10-16 14:21:59 +0200)

----------------------------------------------------------------
This fixes a potential data leak to the guest.

----------------------------------------------------------------
Prasad J Pandit (1):
      9pfs: use g_malloc0 to allocate space for xattr

 hw/9pfs/9p.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
-- 
2.13.6
