Received: from eggs.gnu.org ([2001:4830:134:3::10]:44570)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dfpvE-00022J-W7
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 12:02:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dfpvB-0000Yc-Us
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 12:02:57 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56002
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dfpvB-0000YD-ON
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 12:02:53 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7AG24c6126469
	for <qemu-devel@nongnu.org>; Thu, 10 Aug 2017 12:02:52 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2c8nfqyv76-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 10 Aug 2017 12:02:51 -0400
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Thu, 10 Aug 2017 17:02:50 +0100
From: Greg Kurz <groug@kaod.org>
Date: Thu, 10 Aug 2017 18:02:40 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-Id: <1502380961-16398-1-git-send-email-groug@kaod.org>
Subject: [Qemu-devel] [PULL] 9pfs fixes for 2.10 20170810
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

The following changes since commit b38df311c174c98ef8cce7dec9f46603b083018e:

  Merge remote-tracking branch 'remotes/dgibson/tags/ppc-for-2.10-20170809' into staging (2017-08-10 11:12:36 +0100)

are available in the git repository at:

  https://github.com/gkurz/qemu.git tags/for-upstream

for you to fetch changes up to 4751fd5328dfcd4fe2f9055728a72a0e3ae56512:

  9pfs: local: fix fchmodat_nofollow() limitations (2017-08-10 14:36:11 +0200)

----------------------------------------------------------------
Just a single fix for an annoying regression introduced in 2.9 when fixing
CVE-2016-9602.

----------------------------------------------------------------
Greg Kurz (1):
      9pfs: local: fix fchmodat_nofollow() limitations

 hw/9pfs/9p-local.c | 42 +++++++++++++++++++++++++++++++++++-------
 hw/9pfs/9p-util.h  | 24 +++++++++++++++---------
 2 files changed, 50 insertions(+), 16 deletions(-)
-- 
2.7.5
