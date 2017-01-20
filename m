Received: from eggs.gnu.org ([2001:4830:134:3::10]:39821)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1cUVmD-0003vk-5t
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 04:46:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1cUVm8-0003Aq-8y
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 04:46:33 -0500
Received: from mx-v6.kamp.de ([2a02:248:0:51::16]:49631 helo=mx01.kamp.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1cUVm7-000390-VF
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 04:46:28 -0500
From: Peter Lieven <pl@kamp.de>
Date: Fri, 20 Jan 2017 10:46:08 +0100
Message-Id: <1484905570-10520-1-git-send-email-pl@kamp.de>
Subject: [Qemu-devel] [PATCH 0/2] block/nfs: fix segfault and naming of
 runtime opts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, eblake@redhat.com, ashijeetacharya@gmail.com, jcody@redhat.com, mreitz@redhat.com, armbru@redhat.com, Peter Lieven <pl@kamp.de>

commit 94d6a7a accidently left the naming of runtime opts and QAPI
scheme inconsistent. Furthermore a NULL pointer dereference resulted
in a segfault when parsing URI parameters.

Peter Lieven (2):
  block/nfs: fix NULL pointer dereference in URI parsing
  block/nfs: fix naming of runtime opts

 block/nfs.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

-- 
1.9.1
