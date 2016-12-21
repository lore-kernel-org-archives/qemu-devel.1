Received: from eggs.gnu.org ([2001:4830:134:3::10]:34303)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cJbny-0004sm-HD
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 02:59:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cJbnv-0002aM-GW
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 02:59:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52824)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cJbnv-0002a2-Ak
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 02:59:15 -0500
From: Peter Xu <peterx@redhat.com>
Date: Wed, 21 Dec 2016 15:58:55 +0800
Message-Id: <1482307137-5106-1-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 0/2] memory: extend "info mtree" with flat
 view dump
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, marcandre.lureau@gmail.com, peterx@redhat.com

v2:
- fix a size error in patch 2
- add r-b for Marc-Andr=C3=A9 in patch 1

Each address space has its own flatview. It's another way to observe
memory info besides the default memory region hierachy, for example,
if we want to know which memory region will handle the write to
specific address, a flatview will suite more here than the default
hierachical dump.

I used it to debug a vt-d memory region overlap issue. Do we need
this? I think we can at least consider patch 1, which is a cleanup of
existing codes. :)

Please review. Thanks,

Peter Xu (2):
  memory: provide common macros for mtree_print_mr()
  memory: hmp: dump flat view for 'info mtree'

 memory.c | 65 +++++++++++++++++++++++++++++++++++++++++++++-------------=
------
 1 file changed, 46 insertions(+), 19 deletions(-)

--=20
2.7.4
