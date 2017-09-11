Received: from eggs.gnu.org ([2001:4830:134:3::10]:35817)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1drDI1-00062c-77
	for qemu-devel@nongnu.org; Sun, 10 Sep 2017 21:13:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1drDHy-00050F-LH
	for qemu-devel@nongnu.org; Sun, 10 Sep 2017 21:13:29 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2316)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1drDHy-0004yX-1g
	for qemu-devel@nongnu.org; Sun, 10 Sep 2017 21:13:26 -0400
From: "Longpeng(Mike)" <longpeng2@huawei.com>
Date: Mon, 11 Sep 2017 09:12:40 +0800
Message-ID: <1505092362-10544-1-git-send-email-longpeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH REPOST v19 0/2] virtio-crypto: virtio crypto
 device specification
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org
Cc: luonengjun@huawei.com, mst@redhat.com, cohuck@redhat.com, stefanha@redhat.com, denglingli@chinamobile.com, Jani.Kokkonen@huawei.com, Ola.Liljedahl@arm.com, Varun.Sethi@freescale.com, xin.zeng@intel.com, brian.a.keating@intel.com, liang.j.ma@intel.com, john.griffin@intel.com, weidong.huang@huawei.com, mike.caraman@nxp.com, agraf@suse.de, jasowang@redhat.com, vincent.jardin@6wind.com, arei.gonglei@hotmail.com, pasic@linux.vnet.ibm.com, wangxinxin.wang@huawei.com, arei.gonglei@huawei.com, "Longpeng(Mike)" <longpeng2@huawei.com>

Hi guys,

I'll work on the virtio-crypto spec with Gonglei together, Because He is
so busy on the inner production project.

---
v19 -> v18:
 - fix some typos and grammar fixes [Stefan, Halil]
 - rename VIRTIO_CRYPTO_F_STATELESS_MODE to VIRTIO_CRYPTO_F_MUX_MODE
 - describe the VIRTIO_CRYPTO_STATUS in detial. [Halil]
 - refactor and redescribe the controlq/dataq request's format
   of mux mode. [Halil]
 - other small fixes. [Halil]

v18 -> v17:
 - fix many English grammar problems suggested by Stefan, Thanks a lot!

v17 -> v16:
 - Some grammar fixes [Stefan, Halil, Michael]
 - add a section named "Supported crypto services" in order to explain bit
   numbers and valuse clearly. [Halil, Cornelia]
 - avoid word reptition [Halil]
 - rename non-session mode to stateless mode [Halil]
 - change descriptions for all elements in struct virtio_crypto_config [Halil]
 - add Halil as a reviewer in the ackonwledgement part, thanks for his work.
 - other fixes here and there.

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
 - correct a sentence about dataqueue and controlq in the first paragraph. 
[Halil]
 - change a MAY to MUST about max_dataqueues. [Halil]
 - add non-session mode support
   a) add four features for different crypto services to identify wheather 
support session mode.
   b) rewrite some

For pervious versions of virtio crypto spec, Pls see:

[v18]:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg444897.html

[v14]:
https://lists.gnu.org/archive/html/qemu-devel/2016-11/msg02212.html

[v13]:
https://lists.gnu.org/archive/html/qemu-devel/2016-10/msg07348.html

For more information, please see:
 http://qemu-project.org/Features/VirtioCrypto

---
Gonglei (2):
  virtio-crypto: Add virtio crypto device specification
  virtio-crypto: Add conformance clauses

 acknowledgements.tex |    3 +
 conformance.tex      |   29 +
 content.tex          |    2 +
 virtio-crypto.tex    | 1470 ++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 1504 insertions(+)
 create mode 100644 virtio-crypto.tex

-- 
2.7.4
