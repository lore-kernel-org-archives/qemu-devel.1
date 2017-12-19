Received: from eggs.gnu.org ([2001:4830:134:3::10]:43848)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eRGV0-0001Ku-8P
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 06:55:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eRGUv-0001V0-BY
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 06:55:54 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54704)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1eRGUv-0001UR-2P
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 06:55:49 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vBJBsjN0015576
	for <qemu-devel@nongnu.org>; Tue, 19 Dec 2017 06:55:46 -0500
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ey0u84g6y-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 19 Dec 2017 06:55:46 -0500
Received: from localhost
	by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Tue, 19 Dec 2017 04:55:45 -0700
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Tue, 19 Dec 2017 06:55:39 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-Id: <1513684540-13949-1-git-send-email-stefanb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PULL v1] Merge tpm 2017/12/19
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Stefan Berger <stefanb@linux.vnet.ibm.com>

The patch in this pull request fixes a linker error when --disable-tpm is used.

   Stefan

The following changes since commit eaefea537b476cb853e2edbdc68e969ec777e4bb:

  Merge remote-tracking branch 'remotes/mjt/tags/trivial-patches-fetch' into staging (2017-12-18 14:17:42 +0000)

are available in the git repository at:

  git://github.com/stefanberger/qemu-tpm.git tags/pull-tpm-2017-12-19-1

for you to fetch changes up to 89be9e99c83095af25ce16907143c31f2959188b:

  tpm: move qdev_prop_tpm to hw/tpm/ (2017-12-19 06:40:04 -0500)

----------------------------------------------------------------
Merge tpm 2017/12/19 v1

----------------------------------------------------------------
Cornelia Huck (1):
      tpm: move qdev_prop_tpm to hw/tpm/

 hw/core/qdev-properties-system.c | 64 --------------------------------------------------------------
 hw/tpm/Makefile.objs             |  5 +++--
 hw/tpm/tpm_util.c                | 67 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 hw/tpm/tpm_util.h                |  3 +++
 include/hw/qdev-properties.h     |  2 --
 5 files changed, 73 insertions(+), 68 deletions(-)

-- 
2.5.5
