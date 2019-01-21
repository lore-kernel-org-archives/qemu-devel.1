Received: from eggs.gnu.org ([209.51.188.92]:38880)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.ibm.com>) id 1gld6r-0001z8-Nh
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 12:11:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.ibm.com>) id 1gld37-0005bQ-RD
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 12:07:50 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42454)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.ibm.com>)
	id 1gld37-0005Yw-F1
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 12:07:49 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x0LH5CXm073955
	for <qemu-devel@nongnu.org>; Mon, 21 Jan 2019 12:07:46 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2q5ffpfxfw-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 21 Jan 2019 12:07:45 -0500
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.ibm.com>;
	Mon, 21 Jan 2019 17:07:45 -0000
From: Stefan Berger <stefanb@linux.ibm.com>
Date: Mon, 21 Jan 2019 12:07:27 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-Id: <20190121170731.2500692-1-stefanb@linux.ibm.com>
Subject: [Qemu-devel] [PATCH 0/4] TPM patches for stable-3.0.0 (v3.0.1)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-stable@nongnu.org, mdroth@linux.ibm.com
Cc: qemu-devel@nongnu.org, Stefan Berger <stefanb@linux.ibm.com>

Michael,

   please apply the following patches to v3.0.1. They are the equivalent of

git cherry-pick eff1fe
git cherry-pick 6a50bb
git cherry-pick e92b63
git cherry-pick a639f9

Regards,
   Stefan

Prasad J Pandit (1):
  tpm: use loop iterator to set sts data field

Stefan Berger (3):
  tpm: Zero-init structure to avoid uninitialized variables in valgrind
    log
  tpm: Make sure new locality passed to tpm_tis_prep_abort() is valid
  tpm: Make sure the locality received from backend is valid

 hw/tpm/tpm_emulator.c | 1 +
 hw/tpm/tpm_tis.c      | 8 ++++++--
 2 files changed, 7 insertions(+), 2 deletions(-)

-- 
2.17.2
