Received: from eggs.gnu.org ([2001:4830:134:3::10]:48107)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1cinFe-0001I1-Lk
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 14:15:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1cinFa-0001t7-Nm
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 14:15:58 -0500
Received: from mail.kernel.org ([198.145.29.136]:38456)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1cinFa-0001sD-HA
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 14:15:54 -0500
Date: Tue, 28 Feb 2017 11:15:50 -0800 (PST)
From: Stefano Stabellini <sstabellini@kernel.org>
Message-ID: <alpine.DEB.2.10.1702281106420.5551@sstabellini-ThinkPad-X260>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [Qemu-devel] [PULL 0/2] tags/xen-20170228-tag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, stefanha@gmail.com
Cc: sstabellini@kernel.org, stefanha@redhat.com, anthony.perard@citrix.com, xen-devel@lists.xenproject.org, qemu-devel@nongnu.org

The following changes since commit 7d1730b7d9d8272a13245adfc9b0405e5a4bd0c2:

  Merge remote-tracking branch 'remotes/mjt/tags/trivial-patches-fetch' into staging (2017-02-28 16:22:41 +0000)

are available in the git repository at:


  git://xenbits.xen.org/people/sstabellini/qemu-dm.git tags/xen-20170228-tag

for you to fetch changes up to daa33c52153df48ef0a7d06013f8ca6f24eff92f:

  Add a new qmp command to do checkpoint, query xen replication status (2017-02-28 11:02:12 -0800)

----------------------------------------------------------------
Xen 2017/02/28

----------------------------------------------------------------
Zhang Chen (2):
      Add a new qmp command to start/stop replication
      Add a new qmp command to do checkpoint, query xen replication status

 migration/colo.c | 49 +++++++++++++++++++++++++++++++++++++
 qapi-schema.json | 73 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 122 insertions(+)
