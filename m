Received: from eggs.gnu.org ([2001:4830:134:3::10]:43691)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dstes-0004fO-5I
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 12:40:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dstep-00071J-Ja
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 12:40:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47982)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dstep-00070H-DQ
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 12:39:59 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Fri, 15 Sep 2017 18:39:51 +0200
Message-Id: <20170915163952.32147-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PATCH RFC v2 0/1] s390x: pci compat handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, thuth@redhat.com, david@redhat.com, pmorel@linux.vnet.ibm.com, zyimin@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, Cornelia Huck <cohuck@redhat.com>

As David has identified the reason why only 2.7 and older are affected
(thanks!), we can fix migration of these machines by unconditionally
providing the zpci feature bit if cpu models are off.

Still RFC, as I have only sniff-tested it.

We still need to think about what to do with compat machines on pci-less
builds. Probably we should disable compat machines (at least 2.7 and older)
on those builds. Not a pressing issue, as switching off CONFIG_PCI needs
to be done manually.

Changes RFC -> RFC v2:
- switch from machine class property to enabling zpci bit for non-cpu model
  compat machines

Cornelia Huck (1):
  s390x/ccw: create s390 phb for compat reasons as well

 hw/s390x/s390-virtio-ccw.c | 2 ++
 target/s390x/cpu_models.c  | 3 +++
 2 files changed, 5 insertions(+)

-- 
2.13.5
