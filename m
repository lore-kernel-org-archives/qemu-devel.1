Received: from eggs.gnu.org ([209.51.188.92]:37957)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1h0pp2-00041M-WC
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 10:48:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1h0pp2-0005zT-8l
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 10:48:08 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39146
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1h0pp2-0005Zq-1D
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 10:48:08 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x24Fl6C8064944
	for <qemu-devel@nongnu.org>; Mon, 4 Mar 2019 10:47:45 -0500
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2r14y9p99y-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 04 Mar 2019 10:47:45 -0500
Received: from localhost
	by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Mon, 4 Mar 2019 15:47:44 -0000
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Mon,  4 Mar 2019 10:47:37 -0500
Message-Id: <20190304154739.758486-1-stefanb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PULL v1 0/2] Merge tpm 2019/02/25 v1
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

The 1st patch in this series fixes a bug in the TPM TIS emulator that
skipped a locality when resetting the seize flag when a higher locality
seized access from a lower locality. The 2nd patch converts debugging
code to tracing.

   Stefan


The following changes since commit 8eb29f1bf5a974dc4c11d2d1f5e7c7f7a62be116:

  Merge remote-tracking branch 'remotes/awilliam/tags/vfio-updates-20190221.0' into staging (2019-02-22 15:48:04 +0000)

are available in the Git repository at:

  git://github.com/stefanberger/qemu-tpm.git tags/pull-tpm-2019-02-25-1

for you to fetch changes up to cd38cc519b60bbe5dd8d85f6aaa72b2d7902930b:

  tpm_tis: convert tpm_tis_show_buffer() to use trace event (2019-02-24 14:46:14 -0500)

----------------------------------------------------------------
Liam Merwick (2):
      tpm_tis: fix loop that cancels any seizure by a lower locality
      tpm_tis: convert tpm_tis_show_buffer() to use trace event

 hw/tpm/tpm_tis.c    | 33 ++++++++++++++++++++-------------
 hw/tpm/trace-events |  1 +
 2 files changed, 21 insertions(+), 13 deletions(-)

-- 
2.17.2
