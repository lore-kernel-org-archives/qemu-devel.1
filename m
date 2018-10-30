Received: from eggs.gnu.org ([2001:4830:134:3::10]:36373)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1gHcNl-0002z3-VN
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 18:21:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1gHcNi-0005AW-Qt
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 18:21:05 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48188
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1gHbsR-0006KX-9e
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 17:48:43 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w9ULi8XD175451
	for <qemu-devel@nongnu.org>; Tue, 30 Oct 2018 17:48:31 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2nevwye7an-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 30 Oct 2018 17:48:30 -0400
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Tue, 30 Oct 2018 21:48:29 -0000
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Tue, 30 Oct 2018 17:47:35 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20181030214740.2294043-1-stefanb@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 0/5] Merge tpm 2018/10/29 v2
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

This pull request fixes a couple of TPM support related issues,
such as full initialization of a variable to quiet down valgrind,
a possible race in the TPM related test cases and marking test
cases as skipped if swtpm was not found in PATH.

   Stefan


The following changes since commit a4d710251fa5aa9ec26de4626f11c78500195d=
12:

  Merge remote-tracking branch 'remotes/berrange/tags/qcrypto-next-pull-r=
equest' into staging (2018-10-24 22:08:42 +0100)

are available in the Git repository at:

  git://github.com/stefanberger/qemu-tpm.git tags/pull-tpm-2018-10-29-2

for you to fetch changes up to eff1fe9fd0cebe2293eea9597616f792b6b5ad18:

  tpm: Zero-init structure to avoid uninitialized variables in valgrind l=
og (2018-10-30 17:34:22 -0400)

----------------------------------------------------------------
Marc-Andr=C3=A9 Lureau (2):
      tests/tpm: fix tpm_util_swtpm_has_tpm2()
      tests/tpm: Display if swtpm is not found or --tpm2 not supported

Stefan Berger (3):
      docs: tpm: Mention implemented TPM CRB interface emulation and spec=
s
      MAINTAINERS: Change my email address to the new domain
      tpm: Zero-init structure to avoid uninitialized variables in valgri=
nd log

 MAINTAINERS           |  2 +-
 docs/specs/tpm.txt    | 15 +++++++++++++++
 hw/tpm/tpm_emulator.c |  1 +
 tests/tpm-tests.c     | 33 +++++++++++++++++++++------------
 tests/tpm-util.c      | 52 ++++++++++++++++++++-------------------------=
-------
 tests/tpm-util.h      |  2 ++
 6 files changed, 60 insertions(+), 45 deletions(-)

--=20
2.17.1
