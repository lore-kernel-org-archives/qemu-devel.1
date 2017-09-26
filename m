Received: from eggs.gnu.org ([2001:4830:134:3::10]:51309)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dwsba-0008UM-69
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 12:21:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dwsbW-0007xm-N7
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 12:21:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39196)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dwsbW-0007vZ-Gl
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 12:21:02 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Tue, 26 Sep 2017 18:20:57 +0200
Message-Id: <20170926162058.30772-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PATCH 0/1] s390x: more zpci compat fun
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, david@redhat.com, zyimin@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, dgilbert@redhat.com, Cornelia Huck <cohuck@redhat.com>

Here's a (hopefully) less hackish variant of the fix in
<932ad4e2-a10c-77fc-fcb7-5dbbed0d2c7c@de.ibm.com>. Not really tested
(I had problems reproducing the problem on z12, but that might be
just me).

Please review & test, if possible. Patch against my s390-next branch
(but should fix on top of master as well, I think.)

Cornelia Huck (1):
  s390x: create a compat s390 phb for <=2.10

 hw/s390x/s390-virtio-ccw.c         | 8 +++++++-
 include/hw/s390x/s390-virtio-ccw.h | 1 +
 2 files changed, 8 insertions(+), 1 deletion(-)

-- 
2.13.5
