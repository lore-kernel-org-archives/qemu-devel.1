Received: from eggs.gnu.org ([2001:4830:134:3::10]:58394)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tobleminer@gmail.com>) id 1dMbay-0005sL-SO
	for qemu-devel@nongnu.org; Sun, 18 Jun 2017 10:54:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tobleminer@gmail.com>) id 1dMbay-0003ok-8p
	for qemu-devel@nongnu.org; Sun, 18 Jun 2017 10:54:32 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:33042)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tobleminer@gmail.com>)
	id 1dMbay-0003oP-2k
	for qemu-devel@nongnu.org; Sun, 18 Jun 2017 10:54:32 -0400
Received: by mail-wm0-x244.google.com with SMTP id f90so12725037wmh.0
	for <qemu-devel@nongnu.org>; Sun, 18 Jun 2017 07:54:31 -0700 (PDT)
From: Tobias Schramm <tobleminer@gmail.com>
Date: Sun, 18 Jun 2017 16:52:57 +0200
Message-Id: <20170618145258.16231-1-tobleminer@gmail.com>
Subject: [Qemu-devel] [PATCH v2 0/1] Add fmask/dmask option for 9p mapped
 mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aneesh.kumar@linux.vnet.ibm.com, groug@kaod.org, Tobias Schramm <tobleminer@gmail.com>

Hi,

as suggested by the automated tests I adjusted the code style to be
compatible with QEMUs existing code base.
The previous failed test seems to be irrelevant since it passes fine on my dev
machine and the failure is in a totally unrelated component.

Tobias Schramm

Tobias Schramm (1):
  Add support for custom fmasks/dmasks in 9ps mapped mode

 fsdev/file-op-9p.h      |  4 ++++
 fsdev/qemu-fsdev-opts.c | 12 ++++++++++++
 hw/9pfs/9p-local.c      | 29 +++++++++++++++++++++++++----
 hw/9pfs/9p.c            |  3 +++
 4 files changed, 44 insertions(+), 4 deletions(-)

-- 
2.13.1
