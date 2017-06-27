Received: from eggs.gnu.org ([2001:4830:134:3::10]:49873)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1dPybD-00084Z-Hm
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 18:04:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1dPyb8-0000HO-L0
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 18:04:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:40076)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1dPyb8-0000Gf-Er
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 18:04:38 -0400
Date: Tue, 27 Jun 2017 15:04:34 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
Message-ID: <alpine.DEB.2.10.1706271456310.24648@sstabellini-ThinkPad-X260>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [Qemu-devel] [PATCH 0/3] please pull xen-20170627-tag
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

The following changes since commit 577caa2672ccde7352fda3ef17e44993de862f0e:

  Merge remote-tracking branch 'remotes/edgar/tags/edgar/mmio-exec-v2.for-upstream' into staging (2017-06-27 16:56:55 +0100)

are available in the git repository at:


  git://xenbits.xen.org/people/sstabellini/qemu-dm.git tags/xen-20170627-tag

for you to fetch changes up to 3284fad7283596033cb810b4788fd1bb43312dbd:

  xen-disk: add support for multi-page shared rings (2017-06-27 15:01:56 -0700)

----------------------------------------------------------------
Xen 2017/06/27

----------------------------------------------------------------
Paul Durrant (2):
      xen-disk: only advertize feature-persistent if grant copy is not available
      xen-disk: add support for multi-page shared rings

Stefano Stabellini (1):
      xen/disk: don't leak stack data via response ring

 hw/block/xen_disk.c | 184 +++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 133 insertions(+), 51 deletions(-)
