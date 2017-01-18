Received: from eggs.gnu.org ([2001:4830:134:3::10]:41035)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cTlWt-0004Lq-M5
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 03:23:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cTlWp-0002wa-Co
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 03:23:39 -0500
Received: from szxga02-in.huawei.com ([119.145.14.65]:29164)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cTlWo-0002uH-PI
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 03:23:35 -0500
From: Gonglei <arei.gonglei@huawei.com>
Date: Wed, 18 Jan 2017 16:22:35 +0800
Message-ID: <1484727757-41240-1-git-send-email-arei.gonglei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v16 0/2] virtio-crypto: virtio crypto device
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
Cc: luonengjun@huawei.com, mst@redhat.com, cornelia.huck@de.ibm.com, stefanha@redhat.com, denglingli@chinamobile.com, Jani.Kokkonen@huawei.com, Ola.Liljedahl@arm.com, Varun.Sethi@freescale.com, xin.zeng@intel.com, brian.a.keating@intel.com, liang.j.ma@intel.com, john.griffin@intel.com, weidong.huang@huawei.com, mike.caraman@nxp.com, agraf@suse.de, claudio.fontana@huawei.com, jianjay.zhou@huawei.com, nmorey@kalray.eu, vincent.jardin@6wind.com, wu.wubin@huawei.com, longpeng2@huawei.com, arei.gonglei@hotmail.com, pasic@linux.vnet.ibm.com, Gonglei <arei.gonglei@huawei.com>

Changes since v15:
 - use feature bits for non-session mode in order to keep compatibility with
   pre-existing code. [Halil & Michael]
 - introduce VIRTIO_CRYPTO_F_ NON_SESSION_MODE feature bit to control all other
   non-session mode feature bits.
 - fix some typos. [Stefan]
 - introduce struct virtio_crypto_op_data_req_mux to support both session
   and non-session based crypto operations and keep compatibility with
   pre-existing code.

Changes since v14:
 - drop VIRTIO_CRYPTO_S_STARTED status [Halil & Cornelia]
 - correct a sentence about dataqueue and controlq in the first paragraph. [Halil]
 - change a MAY to MUST about max_dataqueues. [Halil]
 - add non-session mode support
   a) add four features for different crypto services to identify wheather support session mode.
   b) rewrite some

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
 virtio-crypto.tex | 1245 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 1277 insertions(+)
 create mode 100644 virtio-crypto.tex

-- 
1.7.12.4
