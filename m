Received: from eggs.gnu.org ([2001:4830:134:3::10]:34513)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dpGHI-0006I5-1t
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 12:00:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dpGHD-0000Jt-3o
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 12:00:40 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33350
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dpGHC-0000J0-Kz
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 12:00:34 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v85FwcAB078340
	for <qemu-devel@nongnu.org>; Tue, 5 Sep 2017 12:00:34 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2csvy9pxcv-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 05 Sep 2017 12:00:33 -0400
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Tue, 5 Sep 2017 17:00:31 +0100
From: Greg Kurz <groug@kaod.org>
Date: Tue,  5 Sep 2017 18:00:23 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20170905160027.15081-1-groug@kaod.org>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 0/4] 9pfs/virtfs patches for 2.11 20170905
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Greg Kurz <groug@kaod.org>

The following changes since commit 53e2c48d3f0db6a1598f49baf0b56dd4975e53=
a7:

  Merge remote-tracking branch 'remotes/mcayland/tags/qemu-sparc-signed' =
into staging (2017-09-04 18:53:46 +0100)

are available in the git repository at:

  https://github.com/gkurz/qemu.git tags/for-upstream

for you to fetch changes up to 32b6943699948f7adc35ada233fbd25daffad5e9:

  virtfs: error out gracefully when mandatory suboptions are missing (201=
7-09-05 17:56:58 +0200)

----------------------------------------------------------------
Some trivial fixes/cleanup and a fix to cause QEMU to error out gracefull=
y
instead of aborting.

----------------------------------------------------------------
Greg Kurz (2):
      9pfs: local: clarify fchmodat_nofollow() implementation
      virtfs: error out gracefully when mandatory suboptions are missing

Philippe Mathieu-Daud=C3=A9 (1):
      9pfs: avoid sign conversion error simplifying the code

ZhiPeng Lu (1):
      fsdev: fix memory leak in main()

 fsdev/virtfs-proxy-helper.c |  2 ++
 hw/9pfs/9p-local.c          | 12 ++++++++----
 hw/9pfs/9p.c                |  6 ++----
 vl.c                        | 16 ++++++++++------
 4 files changed, 22 insertions(+), 14 deletions(-)
--=20
2.13.5
