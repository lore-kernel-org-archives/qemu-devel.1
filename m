Received: from eggs.gnu.org ([2001:4830:134:3::10]:52319)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e7E2A-0002iz-PD
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 01:15:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e7E27-000292-DU
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 01:15:18 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33652
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1e7E27-00026t-4K
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 01:15:15 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9P5DuKV046433
	for <qemu-devel@nongnu.org>; Wed, 25 Oct 2017 01:15:11 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2dtcvcj45g-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 25 Oct 2017 01:15:11 -0400
Received: from localhost
	by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Wed, 25 Oct 2017 01:15:10 -0400
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Wed, 25 Oct 2017 01:14:55 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <1508908500-25274-1-git-send-email-stefanb@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/5] Merge tpm 2017/10/24
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

*The following changes since commit 3d7196d43bfe12efe98568cb60057e273652b=
99b:

  Merge remote-tracking branch 'remotes/kraxel/tags/usb-20171023-pull-req=
uest' into staging (2017-10-24 16:05:57 +0100)

are available in the git repository at:

  git://github.com/stefanberger/qemu-tpm.git tags/pull-tpm-2017-10-24-1

for you to fetch changes up to 298d8b81d45d2297f88d93604bd5eebfd653d6cf:

  tpm: print buffers received from TPM when debugging (2017-10-25 01:05:5=
3 -0400)

----------------------------------------------------------------
Merge tpm 2017/10/24 v1

----------------------------------------------------------------
Philippe Mathieu-Daud=C3=A9 (4):
      tpm: add missing include
      tpm: add stubs
      tpm: remove unnecessary #ifdef CONFIG_TPM
      vl: remove unnecessary #ifdef CONFIG_TPM

Stefan Berger (1):
      tpm: print buffers received from TPM when debugging

 MAINTAINERS          |  1 +
 Makefile.objs        |  2 +-
 hw/tpm/tpm_tis.c     |  2 ++
 include/sysemu/tpm.h |  1 +
 stubs/Makefile.objs  |  1 +
 stubs/tpm.c          | 33 +++++++++++++++++++++++++++++++++
 tpm.c                |  4 ----
 vl.c                 |  2 --
 8 files changed, 39 insertions(+), 7 deletions(-)
 create mode 100644 stubs/tpm.c


--=20
2.5.5
