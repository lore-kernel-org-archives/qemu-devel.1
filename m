Received: from eggs.gnu.org ([2001:4830:134:3::10]:33323)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cyaoU-0000Xy-Rt
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 05:13:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cyaoR-0000DS-NF
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 05:13:14 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3033
	helo=dggrg01-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cyaoR-00009c-32
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 05:13:11 -0400
From: Gonglei <arei.gonglei@huawei.com>
Date: Thu, 13 Apr 2017 17:11:12 +0800
Message-ID: <1492074674-124192-1-git-send-email-arei.gonglei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v17 0/2] virtio-crypto: virtio crypto device
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
Cc: luonengjun@huawei.com, mst@redhat.com, cornelia.huck@de.ibm.com, stefanha@redhat.com, denglingli@chinamobile.com, Jani.Kokkonen@huawei.com, Ola.Liljedahl@arm.com, Varun.Sethi@freescale.com, xin.zeng@intel.com, brian.a.keating@intel.com, liang.j.ma@intel.com, john.griffin@intel.com, weidong.huang@huawei.com, mike.caraman@nxp.com, agraf@suse.de, jasowang@redhat.com, nmorey@kalray.eu, vincent.jardin@6wind.com, wu.wubin@huawei.com, arei.gonglei@hotmail.com, pasic@linux.vnet.ibm.com, zhbzg@huawei.com, eety.chen@huawei.com, amy.zhanghuimin@huawei.com, maoningning@huawei.com, Gonglei <arei.gonglei@huawei.com>

Thanks to Stefan, Michael, Halil, Cornelia for reviewing. The v17 has some
big changes, so I don't add Stefan's R-by until I get a response for the
new version :)

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

 acknowledgements.tex |    1 +
 conformance.tex      |   29 ++
 content.tex          |    2 +
 virtio-crypto.tex    | 1305 ++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 1337 insertions(+)
 create mode 100644 virtio-crypto.tex

-- 
1.7.12.4
