Received: from eggs.gnu.org ([2001:4830:134:3::10]:36070)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fYtKh-0004Wy-UK
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 09:21:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fYtKe-0007bV-P9
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 09:21:03 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42780)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fYtKe-0007Vv-FT
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 09:21:00 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w5TDIkB7074628
	for <qemu-devel@nongnu.org>; Fri, 29 Jun 2018 09:20:58 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2jwn7x15n7-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 29 Jun 2018 09:20:58 -0400
Received: from localhost
	by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Fri, 29 Jun 2018 14:20:56 +0100
From: Greg Kurz <groug@kaod.org>
Date: Fri, 29 Jun 2018 15:20:43 +0200
Message-Id: <20180629132045.429006-1-groug@kaod.org>
Subject: [Qemu-devel] [PULL 0/2] 9p patches 2018-06-29
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

The following changes since commit 609ef9f451759151d0bfe7c3843410ab94d68f18:

  Merge remote-tracking branch 'remotes/berrange/tags/qio-next-pull-request' into staging (2018-06-28 17:53:31 +0100)

are available in the Git repository at:

  https://github.com/gkurz/qemu.git tags/for-upstream

for you to fetch changes up to 230f1b31c5d58a852e1ac46e1ef05cfa7d5d9280:

  9p: darwin: Explicitly cast comparisons of mode_t with -1 (2018-06-29 12:32:10 +0200)

----------------------------------------------------------------
The Darwin host support still needs some more work. It won't make it for
soft-freeze, but I'd like these preparatory patches to be merged anyway.

----------------------------------------------------------------
Keno Fischer (2):
      cutils: Provide strchrnul
      9p: darwin: Explicitly cast comparisons of mode_t with -1

 configure             | 18 ++++++++++++++++++
 hmp.c                 |  8 ++++----
 hw/9pfs/9p-local.c    |  6 +++---
 include/qemu/cutils.h |  8 ++++++++
 monitor.c             |  8 ++------
 util/cutils.c         | 15 +++++++++++++++
 util/qemu-option.c    |  6 +-----
 util/uri.c            |  6 ++----
 8 files changed, 53 insertions(+), 22 deletions(-)
-- 
2.14.4
