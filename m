Received: from eggs.gnu.org ([2001:4830:134:3::10]:59403)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fsUMw-0000Fa-UA
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 10:44:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fsUMt-0003FK-57
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 10:44:22 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34362
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fsUMs-0003DZ-7i
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 10:44:19 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w7MEdBC8143578
	for <qemu-devel@nongnu.org>; Wed, 22 Aug 2018 10:44:16 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2m18hy4220-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 22 Aug 2018 10:44:16 -0400
Received: from localhost
	by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Wed, 22 Aug 2018 15:44:14 +0100
From: Greg Kurz <groug@kaod.org>
Date: Wed, 22 Aug 2018 16:43:39 +0200
Message-Id: <20180822144340.91828-1-groug@kaod.org>
Subject: [Qemu-devel] [PULL 0/1] 9p patches 2018-08-22
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

The following changes since commit 13b7b188501d419a7d63c016e00065bcc693b7d4:

  Merge remote-tracking branch 'remotes/kraxel/tags/vga-20180821-pull-request' into staging (2018-08-21 15:57:56 +0100)

are available in the Git repository at:

  https://github.com/gkurz/qemu.git tags/for-upstream

for you to fetch changes up to adbffc2074754aff8d806843d9e83443590ce5e0:

  fsdev: fix compilation with VIRTIO but not VIRTIO_9P (2018-08-22 12:21:13 +0200)

----------------------------------------------------------------
Just a build fix that I had queued during soft freeze.

----------------------------------------------------------------
Paolo Bonzini (1):
      fsdev: fix compilation with VIRTIO but not VIRTIO_9P

 fsdev/Makefile.objs | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)
-- 
2.14.4
