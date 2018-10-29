Received: from eggs.gnu.org ([2001:4830:134:3::10]:34005)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.ibm.com>) id 1gH9Kv-0007rw-Pj
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 11:20:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.ibm.com>) id 1gH9Kq-00032g-Gr
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 11:20:13 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:28463
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.ibm.com>)
	id 1gH9Kq-00031Z-52
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 11:20:08 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w9TFJDu5006379
	for <qemu-devel@nongnu.org>; Mon, 29 Oct 2018 11:20:07 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ne337dv5c-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 29 Oct 2018 11:20:06 -0400
Received: from localhost
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.ibm.com>;
	Mon, 29 Oct 2018 11:20:03 -0400
From: Stefan Berger <stefanb@linux.ibm.com>
Date: Mon, 29 Oct 2018 11:19:51 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20181029151956.2164336-1-stefanb@linux.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v1 0/5] Merge tpm 2018/10/29 v1
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

From: Stefan Berger <stefanb@linux.vnet.ibm.com>

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

  git://github.com/stefanberger/qemu-tpm.git tags/pull-tpm-2018-10-29-1

for you to fetch changes up to f9da599490730cf0c3016f15225d7f1ee15bec75:

  tpm: Zero-init structure to avoid uninitialized variables in valgrind l=
og (2018-10-27 10:33:18 -0400)

----------------------------------------------------------------
Marc-Andr=C3=A9 Lureau (2):
      tests/tpm: fix tpm_util_swtpm_has_tpm2()
      tests/tpm: mark swtpm test as skipped instead of successful

Stefan Berger (3):
      docs: tpm: Mention implemented TPM CRB interface emulation and spec=
s
      MAINTAINERS: Change my email address to the new domain
      tpm: Zero-init structure to avoid uninitialized variables in valgri=
nd log

 MAINTAINERS           |  2 +-
 docs/specs/tpm.txt    | 15 +++++++++++++++
 hw/tpm/tpm_emulator.c |  2 +-
 tests/tpm-tests.c     | 33 +++++++++++++++++++++------------
 tests/tpm-util.c      | 52 ++++++++++++++++++++-------------------------=
-------
 tests/tpm-util.h      |  2 ++
 6 files changed, 60 insertions(+), 46 deletions(-)

--=20
2.17.1
