Received: from eggs.gnu.org ([2001:4830:134:3::10]:35785)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cOiQj-0000N5-7S
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 05:04:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cOiQe-0006Zp-WA
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 05:04:25 -0500
Received: from szxga02-in.huawei.com ([119.145.14.65]:28356)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cOiQe-0006SC-Ap
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 05:04:20 -0500
From: Gonglei <arei.gonglei@huawei.com>
Date: Wed, 4 Jan 2017 18:03:03 +0800
Message-ID: <1483524185-9036-1-git-send-email-arei.gonglei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v15 0/2] virtio-crypto: virtio crypto device
 specification
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org
Cc: luonengjun@huawei.com, mst@redhat.com, cornelia.huck@de.ibm.com, stefanha@redhat.com, denglingli@chinamobile.com, Jani.Kokkonen@huawei.com, Ola.Liljedahl@arm.com, Varun.Sethi@freescale.com, xin.zeng@intel.com, brian.a.keating@intel.com, liang.j.ma@intel.com, john.griffin@intel.com, weidong.huang@huawei.com, mike.caraman@nxp.com, agraf@suse.de, claudio.fontana@huawei.com, jianjay.zhou@huawei.com, nmorey@kalray.eu, vincent.jardin@6wind.com, wu.wubin@huawei.com, Shiqing.Fan@huawei.com, arei.gonglei@hotmail.com, pasic@linux.vnet.ibm.com, Gonglei <arei.gonglei@huawei.com>

Changes since v14:
 - drop VIRTIO_CRYPTO_S_STARTED status [Halil & Cornelia]
 - correct a sentence about dataqueue and controlq in the first paragraph. [Halil]
 - change a MAY to MUST about max_dataqueues. [Halil]
 - add non-session mode support
   1) add four features for different crypto services to identify wheather support session mode.
   2) extend virtio_crypto_*_para structures, for example, add the content of
     struct virtio_crypto_cipher_session_para into struct virtio_crypto_cipher_para.
   3) use the flag property of struct virtio_crypto_op_header to identify the
     type of crypto request. Aka Is it a session-based or non-session request

For pervious versions of virtio crypto spec, Pls see:

[v14]:
https://lists.gnu.org/archive/html/qemu-devel/2016-11/msg02212.html

[v13]:
https://lists.gnu.org/archive/html/qemu-devel/2016-10/msg07348.html

For more information, please see:
 http://qemu-project.org/Features/VirtioCrypto

Please help to review, thanks.

Gonglei (2):
  virtio-crypto: Add virtio crypto device specification
  virtio-crypto: Add conformance clauses

 conformance.tex   |   30 ++
 content.tex       |    2 +
 virtio-crypto.tex | 1029 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 1061 insertions(+)
 create mode 100644 virtio-crypto.tex

-- 
1.7.12.4
