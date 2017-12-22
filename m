Received: from eggs.gnu.org ([2001:4830:134:3::10]:41696)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eSTkG-00014L-2B
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 15:16:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eSTkB-0000dS-3d
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 15:16:40 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36936)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1eSTkA-0000cn-RG
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 15:16:35 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vBMKEjjU045098
	for <qemu-devel@nongnu.org>; Fri, 22 Dec 2017 15:16:33 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2f16dfx49b-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 22 Dec 2017 15:16:32 -0500
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Fri, 22 Dec 2017 13:16:32 -0700
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Fri, 22 Dec 2017 15:16:15 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-Id: <1513973785-14427-1-git-send-email-stefanb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PULL v1 00/10] Merge tpm 2017/12/22
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

The following series of patches most important parts add a caching layer
to the TPM emulator backend for reducing the number of control commands sent
to retrieve the TPMEstablished flag. They also simplify the TPM TIS internal
usage of buffers and r/w offsets in preparation for adding migration support
to the device.

    Stefan

The following changes since commit 281f327487c9c9b1599f93c589a408bbf4a651b8:

  Merge remote-tracking branch 'remotes/vivier/tags/m68k-for-2.12-pull-request' into staging (2017-12-22 00:11:36 +0000)

are available in the git repository at:

  git://github.com/stefanberger/qemu-tpm.git tags/pull-tpm-2017-12-22-1

for you to fetch changes up to 4a42fa0ee20b51b326f6494cb50218b52471a261:

  acpi: Update TPM2 ACPI table to more recent specs (2017-12-22 11:03:21 -0500)

----------------------------------------------------------------
Merge tpm 2017/12/22 v1

----------------------------------------------------------------
Stefan Berger (10):
      tpm_emulator: Add a caching layer for the TPM Established flag
      tpm_tis: convert uint32_t to size_t
      tpm_tis: limit size of buffer from backend
      tpm_tis: remove TPMSizeBuffer usage
      tpm_tis: move buffers from localities into common location
      tpm_tis: merge read and write buffer into single buffer
      tpm_tis: move r/w_offsets to TPMState
      tpm_tis: merge r/w_offset into rw_offset
      tpm: Implement tpm_sized_buffer_reset
      acpi: Update TPM2 ACPI table to more recent specs

 hw/i386/acpi-build.c        |  19 +++++++---
 hw/tpm/tpm_emulator.c       |  17 +++++++--
 hw/tpm/tpm_tis.c            | 130 ++++++++++++++++++++++++---------------------------------------------
 hw/tpm/tpm_util.c           |   7 ++++
 hw/tpm/tpm_util.h           |   7 ++++
 include/hw/acpi/acpi-defs.h |   7 ++--
 6 files changed, 92 insertions(+), 95 deletions(-)

-- 
2.5.5
