Received: from eggs.gnu.org ([2001:4830:134:3::10]:36339)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e5FAR-0007RZ-Vz
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 14:03:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e5FAL-0007Pu-3X
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 14:03:40 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51654)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1e5FAK-0007O4-Om
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 14:03:32 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9JI365Y048843
	for <qemu-devel@nongnu.org>; Thu, 19 Oct 2017 14:03:29 -0400
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2dpvu3rt43-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 19 Oct 2017 14:03:29 -0400
Received: from localhost
	by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Thu, 19 Oct 2017 14:03:28 -0400
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Thu, 19 Oct 2017 14:02:34 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <1508436175-1596-1-git-send-email-stefanb@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v1 00/21] Merge tpm 2017/10/19
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, marcandre.lureau@gmail.com, Stefan Berger <stefanb@linux.vnet.ibm.com>

The following changes since commit f2a48d696c12aaac12993364371daae9f6233c=
37:

  Merge remote-tracking branch 'remotes/riku/tags/pull-linux-user-2017101=
8' into staging (2017-10-19 14:39:30 +0100)

are available in the git repository at:

  git://github.com/stefanberger/qemu-tpm.git tags/pull-tpm-2017-10-19-1

for you to fetch changes up to 05a699985c001927a50f8f276251f2af1e0c5b58:

  tpm: move recv_data_callback to TPM interface (2017-10-19 11:42:33 -040=
0)

----------------------------------------------------------------
Merge tpm 2017/10/19 v1

----------------------------------------------------------------
Marc-Andr=C3=A9 Lureau (21):
      tpm-tis: remove unused hw_access argument
      tpm-tis: remove RAISE_STS_IRQ
      tpm: make tpm_get_backend_driver() static
      tpm: lookup tpm backend class in tpm_driver_find_by_type()
      tpm: replace tpm_get_backend_driver() to drop be_drivers
      tpm: remove tpm_register_driver()
      tpm: move TPMSizedBuffer to tpm_tis.h
      tpm: remove TPMDriverOps
      tpm: remove init() class method
      tpm: remove configure_tpm() hop
      tpm: remove unused TPMBackendCmd
      tpm: remove needless cast
      tpm: remove locty argument from receive_cb
      tpm: add TPMBackendCmd to hold the request state
      tpm-emulator: fix error handling
      tpm: remove locty_data from TPMState
      tpm-tis: move TPMState to TIS header
      tpm-tis: remove tpm_tis.h header
      tpm-tis: fold TPMTISEmuState in TPMState
      tpm: add a QOM TPM interface
      tpm: move recv_data_callback to TPM interface

 backends/tpm.c               |  54 ++++-----
 hw/tpm/tpm_emulator.c        |  84 ++++++--------
 hw/tpm/tpm_int.h             |  36 +++---
 hw/tpm/tpm_passthrough.c     |  71 ++++--------
 hw/tpm/tpm_tis.c             | 459 +++++++++++++++++++++++++++++++++++++=
+++------------------------------------
 hw/tpm/tpm_tis.h             |  70 ------------
 hw/tpm/tpm_util.c            |   1 +
 include/sysemu/tpm_backend.h |  45 +++-----
 scripts/checkpatch.pl        |   1 -
 tpm.c                        |  49 ++++-----
 10 files changed, 383 insertions(+), 487 deletions(-)
 delete mode 100644 hw/tpm/tpm_tis.h

--=20
2.5.5
