Received: from eggs.gnu.org ([2001:4830:134:3::10]:53809)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <xin.zeng@intel.com>) id 1dDCMU-0003BC-1Z
	for qemu-devel@nongnu.org; Tue, 23 May 2017 12:08:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <xin.zeng@intel.com>) id 1dDCMQ-0003R3-T4
	for qemu-devel@nongnu.org; Tue, 23 May 2017 12:08:42 -0400
Received: from mga01.intel.com ([192.55.52.88]:16931)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <xin.zeng@intel.com>) id 1dDCMQ-0003Qn-Ia
	for qemu-devel@nongnu.org; Tue, 23 May 2017 12:08:38 -0400
From: "Zeng, Xin" <xin.zeng@intel.com>
Date: Tue, 23 May 2017 16:08:25 +0000
Message-ID: <82063967A54EF84C8AFCD6BD7F6AD93310D199A2@SHSMSX103.ccr.corp.intel.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] virtio crypto device implemenation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "mst@redhat.com" <mst@redhat.com>
Cc: "Gonglei (Arei)" <arei.gonglei@huawei.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

Hi, Michael,=20
   As you know, Lei Gong from Huawei and I are co-working  on virtio crypto=
 device spec, he is focusing on symmetric algorithm part, I am focusing on =
asymmetric part.  Now I am planning the implementation for asymmetric part,=
 would you please give me your point regarding the questions below?
   Current virtio crypto device implementation from Lei Gong:
   The virtio crypto device implementation has been upstreamed to QEMU and =
it has a qemu backend implementation for symmetric algorithm part, the fron=
t end Linux device driver for symmetric part has been upstreamed to Linux k=
ernel as well.
   My questions:
   From my side, I planned to add the asymmetric part support in upstreamed=
 front end device driver, and I don't want to add the asymmetric algorithm =
support to current virtio crypto device's qemu backend, instead, I would li=
ke to implement and upstream a DPDK vhost-user based backend for asymmetric=
 algorithm, and accordingly Lei Gong will help to upstream a vhost user age=
nt for virtio crypto device in QEMU,  is this approach acceptable? Is a qem=
u backend a mandatory requirement for the virtio crypto device?  Is there a=
 general policy for this?

Thanks
