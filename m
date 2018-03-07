Received: from eggs.gnu.org ([2001:4830:134:3::10]:54426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1etYYG-0003Xp-D0
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 07:52:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1etYYC-0008Fh-Gj
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 07:52:12 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36656
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1etYYC-0008Bp-Ak
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 07:52:08 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w27CpZBk032219
	for <qemu-devel@nongnu.org>; Wed, 7 Mar 2018 07:52:05 -0500
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2gjc34k03x-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 07 Mar 2018 07:52:05 -0500
Received: from localhost
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Wed, 7 Mar 2018 05:52:04 -0700
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Wed,  7 Mar 2018 07:51:54 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-Id: <1520427119-6236-1-git-send-email-stefanb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PULL v1 0/5] Merge tpm 2018/03/07
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

This series of patches converts the TPM code to use trace-events rather than
debug #define's.

    Stefan

The following changes since commit 8cb340c613ee3e626b070e0429c589f8a60ac657:

  Merge remote-tracking branch 'remotes/famz/tags/staging-pull-request' into staging (2018-03-01 12:32:31 +0000)

are available in the git repository at:

  git://github.com/stefanberger/qemu-tpm.git tags/pull-tpm-2018-03-07-1

for you to fetch changes up to fcbed221ff7230c6a5ebfb2ed27dc114ff5a30b0:

  tpm: convert tpm_tis.c to use trace-events (2018-03-06 13:00:41 -0500)

----------------------------------------------------------------
Stefan Berger (5):
      tpm: convert tpm_crb.c to use trace-events
      tpm: convert tpm_passthrough.c to use trace-events
      tpm: convert tpm_util.c to use trace-events
      tpm: convert tpm_emulator.c to use trace-events
      tpm: convert tpm_tis.c to use trace-events

 Makefile.objs            |  1 +
 hw/tpm/tpm_crb.c         | 17 +++++---------
 hw/tpm/tpm_emulator.c    | 45 +++++++++++++++++++------------------
 hw/tpm/tpm_passthrough.c | 13 +++--------
 hw/tpm/tpm_tis.c         | 98 +++++++++++++++++++++++++++++++++++++-------------------------------------------
 hw/tpm/tpm_util.c        | 29 ++++++++++--------------
 hw/tpm/trace-events      | 46 ++++++++++++++++++++++++++++++++++++++
 7 files changed, 135 insertions(+), 114 deletions(-)
 create mode 100644 hw/tpm/trace-events

-- 
2.5.5
