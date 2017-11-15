Received: from eggs.gnu.org ([2001:4830:134:3::10]:60714)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eEwqi-0002yT-DO
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 07:31:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eEwqe-00028V-FF
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 07:31:24 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34886
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1eEwqe-00028F-9l
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 07:31:20 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vAFCSX1s094289
	for <qemu-devel@nongnu.org>; Wed, 15 Nov 2017 07:31:15 -0500
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2e8kvbwejd-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 15 Nov 2017 07:31:14 -0500
Received: from localhost
	by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Wed, 15 Nov 2017 07:31:14 -0500
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Wed, 15 Nov 2017 07:31:05 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <1510749069-22059-1-git-send-email-stefanb@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/4] Merge tpm 2017/11/15 v1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, marcandre.lureau@gmail.com, Stefan Berger <stefanb@linux.vnet.ibm.com>

This pull request is for 2.11 and extends documentation as well as fixes
bugs related to concurrency and failure mode.

The following changes since commit 4ffa88c99c54d2a30f79e3dbecec50b023eff1=
c8:

  Merge remote-tracking branch 'remotes/berrange/tags/pull-qcrypto-2017-1=
1-08-1' into staging (2017-11-10 16:01:35 +0000)

are available in the git repository at:

  git://github.com/stefanberger/qemu-tpm.git tags/pull-tpm-2017-11-15-1

for you to fetch changes up to 6cd65969da57eaa9bdff07b80ecca2becce0597a:

  tpm_tis: Return 0 for every register in case of failure mode (2017-11-1=
5 06:47:35 -0500)

----------------------------------------------------------------
Merge tpm 2017/11/15 v1

----------------------------------------------------------------
Marc-Andr=C3=A9 Lureau (1):
      tpm-emulator: protect concurrent ctrl_chr access

Stefan Berger (3):
      specs: Extend TPM spec with TPM emulator description
      tpm_tis: Return TPM_VERSION_UNSPEC in case of BE failure
      tpm_tis: Return 0 for every register in case of failure mode

 docs/specs/tpm.txt    | 79 +++++++++++++++++++++++++++++++++++++++++++++=
++++++
 hw/tpm/tpm_emulator.c | 44 +++++++++++++++++-----------
 hw/tpm/tpm_tis.c      |  6 +++-
 3 files changed, 112 insertions(+), 17 deletions(-)


--=20
2.5.5
