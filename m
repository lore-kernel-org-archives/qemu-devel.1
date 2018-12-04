Received: from eggs.gnu.org ([2001:4830:134:3::10]:46493)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1gUCj9-0007Q6-7s
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 10:35:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1gUCj4-0001b1-NV
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 10:35:11 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53594
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1gUCj4-0001aI-FZ
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 10:35:06 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wB4FSsdq145216
	for <qemu-devel@nongnu.org>; Tue, 4 Dec 2018 10:35:05 -0500
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2p5utq9v8g-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 04 Dec 2018 10:35:05 -0500
Received: from localhost
	by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Tue, 4 Dec 2018 15:34:54 -0000
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Tue,  4 Dec 2018 10:34:44 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-Id: <20181204153447.2462189-1-stefanb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PULL 0/3] Merge tpm 2018/12/04 v1
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

This series of patches removes an unnecessary parameter from tpm_tis_abort()
and adds a locality range check (using assert()) to tpm_tis_prep_abort() and
tpm_tis_request_completed().

   Stefan

The following changes since commit 83ea23cd207a03c5736be0231acbf7f8b05dbf52:

  i386: hvf: Fix overrun of _decode_tbl1 (2018-12-03 15:09:55 +0000)

are available in the Git repository at:

  git://github.com/stefanberger/qemu-tpm.git tags/pull-tpm-2018-12-04-1

for you to fetch changes up to a639f96111eadb3b8e3021fd3f27e2948ad1c640:

  tpm: Make sure the locality received from backend is valid (2018-12-04 10:21:25 -0500)

----------------------------------------------------------------
Stefan Berger (3):
      tpm: Remove unused locty parameter from tpm_tis_abort()
      tpm: Make sure new locality passed to tpm_tis_prep_abort() is valid
      tpm: Make sure the locality received from backend is valid

 hw/tpm/tpm_tis.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

-- 
2.17.1
