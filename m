Received: from eggs.gnu.org ([2001:4830:134:3::10]:60748)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eo5Uo-00013l-6w
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 05:50:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eo5Ul-0000uc-4q
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 05:50:02 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48402
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1eo5Uk-0000pc-PK
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 05:49:59 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w1KAmhXI026318
	for <qemu-devel@nongnu.org>; Tue, 20 Feb 2018 05:49:50 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2g8hunh0u2-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 20 Feb 2018 05:49:50 -0500
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Tue, 20 Feb 2018 10:49:49 -0000
From: Greg Kurz <groug@kaod.org>
Date: Tue, 20 Feb 2018 11:49:40 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20180220104942.14531-1-groug@kaod.org>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/2] 9p patches for 2.12 20180220
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

The following changes since commit 299a2e6fac397be9b82c66583d53d1daaa3ffe=
6c:

  Merge remote-tracking branch 'remotes/marcel/tags/rdma-pull-request' in=
to staging (2018-02-19 12:51:11 +0000)

are available in the git repository at:

  https://github.com/gkurz/qemu.git tags/for-upstream

for you to fetch changes up to 6ce7177ae2e547999ef9e6f467415963991e28da:

  9p: fix leak in synth_name_to_path() (2018-02-19 18:27:32 +0100)

----------------------------------------------------------------
Fix memory leak in synth backend.

----------------------------------------------------------------
Marc-Andr=C3=A9 Lureau (2):
      9p: v9fs_path_copy() readability
      9p: fix leak in synth_name_to_path()

 hw/9pfs/9p-synth.c | 1 +
 hw/9pfs/9p.c       | 9 ++++-----
 hw/9pfs/9p.h       | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)
--=20
2.13.6
