Received: from eggs.gnu.org ([2001:4830:134:3::10]:40980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fDphf-0002mE-Ix
	for qemu-devel@nongnu.org; Wed, 02 May 2018 07:13:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fDphb-0005iw-LX
	for qemu-devel@nongnu.org; Wed, 02 May 2018 07:13:43 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53822
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fDphb-0005h8-GL
	for qemu-devel@nongnu.org; Wed, 02 May 2018 07:13:39 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w42BAC4e048440
	for <qemu-devel@nongnu.org>; Wed, 2 May 2018 07:13:31 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2hq6sy5cna-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 02 May 2018 07:13:31 -0400
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Wed, 2 May 2018 12:13:29 +0100
From: Greg Kurz <groug@kaod.org>
Date: Wed,  2 May 2018 13:13:17 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-Id: <20180502111318.129888-1-groug@kaod.org>
Subject: [Qemu-devel] [PULL 0/1] 9p patches for 2.13 20180502
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

The following changes since commit 26bd8d98c4b3284a4c6fe3b67c98b1edd00e9beb:

  Merge remote-tracking branch 'remotes/vivier/tags/m68k-for-2.13-pull-request' into staging (2018-05-01 15:26:06 +0100)

are available in the Git repository at:

  https://github.com/gkurz/qemu.git tags/for-upstream

for you to fetch changes up to 8f9c64bfa584ab66b8bcbfc162efa179f7f1cd41:

  9p: add trace event for v9fs_setattr() (2018-05-02 08:59:24 +0200)

----------------------------------------------------------------
Just one trace

----------------------------------------------------------------
Greg Kurz (1):
      9p: add trace event for v9fs_setattr()

 hw/9pfs/9p.c         | 5 +++++
 hw/9pfs/trace-events | 2 ++
 2 files changed, 7 insertions(+)
-- 
2.14.3
