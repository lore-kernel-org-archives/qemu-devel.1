Received: from eggs.gnu.org ([2001:4830:134:3::10]:54928)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dQZjv-00034B-S2
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 09:44:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dQZjq-0002pa-W9
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 09:44:11 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44827)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dQZjq-0002pI-MX
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 09:44:06 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v5TDcoME027739
	for <qemu-devel@nongnu.org>; Thu, 29 Jun 2017 09:44:05 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bcy9qs6t3-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 29 Jun 2017 09:44:04 -0400
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Thu, 29 Jun 2017 14:44:01 +0100
From: Greg Kurz <groug@kaod.org>
Date: Thu, 29 Jun 2017 15:43:43 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <1498743831-28676-1-git-send-email-groug@kaod.org>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/8] 9pfs patches for 2.10 20170629
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

The following changes since commit 464588675455afda2899e20a0b120e4075de50=
c7:

  Merge remote-tracking branch 'remotes/sstabellini/tags/xen-20170627-tag=
' into staging (2017-06-29 11:45:01 +0100)

are available in the git repository at:

  https://github.com/gkurz/qemu.git tags/for-upstream

for you to fetch changes up to 06a37db7b12e4d42a6699c2fef820158f470ec4f:

  9pfs: handle transport errors in pdu_complete() (2017-06-29 15:11:51 +0=
200)

----------------------------------------------------------------
- fixes a minor bug that could possibly prevent old guests to remove
  directories
- makes default permissions for new files configurable from the cmdline
  when using mapped security modes
- handle transport errors
- g_malloc()+memcpy() converted to g_memdup()

----------------------------------------------------------------
Bruce Rogers (1):
      9pfs: local: remove: use correct path component

Greg Kurz (4):
      virtio-9p: record element after sanity checks
      virtio-9p: message header is 7-byte long
      virtio-9p: break device if buffers are misconfigured
      9pfs: handle transport errors in pdu_complete()

Marc-Andr=C3=A9 Lureau (1):
      9pfs: replace g_malloc()+memcpy() with g_memdup()

Stefano Stabellini (1):
      xen-9pfs: disconnect if buffers are misconfigured

Tobias Schramm (1):
      9pfs: local: Add support for custom fmode/dmode in 9ps mapped secur=
ity modes

 fsdev/file-op-9p.h         |  4 +++
 fsdev/qemu-fsdev-opts.c    | 12 +++++++
 hw/9pfs/9p-local.c         | 27 +++++++++++---
 hw/9pfs/9p-synth.c         |  3 +-
 hw/9pfs/9p.c               | 28 ++++++++++-----
 hw/9pfs/9p.h               |  7 +++-
 hw/9pfs/virtio-9p-device.c | 51 +++++++++++++++++++++------
 hw/9pfs/xen-9p-backend.c   | 88 ++++++++++++++++++++++++++++++++++------=
------
 qemu-options.hx            | 20 ++++++++---
 9 files changed, 187 insertions(+), 53 deletions(-)
--=20
2.7.5
