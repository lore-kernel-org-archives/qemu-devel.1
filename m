Received: from eggs.gnu.org ([2001:4830:134:3::10]:60148)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=228f1c8ea=Paul.Durrant@citrix.com>)
	id 1cjlgj-0004J3-Jv
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 06:47:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=228f1c8ea=Paul.Durrant@citrix.com>)
	id 1cjlgg-000173-Lj
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 06:47:57 -0500
Received: from smtp.citrix.com ([66.165.176.89]:7547)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=228f1c8ea=Paul.Durrant@citrix.com>)
	id 1cjlgg-00016D-FV
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 06:47:54 -0500
From: Paul Durrant <paul.durrant@citrix.com>
Date: Fri, 3 Mar 2017 11:47:46 +0000
Message-ID: <1488541671-26740-1-git-send-email-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v3 0/5] xen: use new xendevicemodel library
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: xen-devel@lists.xenproject.org, qemu-devel@nongnu.org
Cc: Paul Durrant <paul.durrant@citrix.com>

My recent patches to Xen [1] introduced a new library to support
running device models for HVM guests.
This series ports QEMU onto the new library if it is available in the
build environment.

[1] Patches starting with http://xenbits.xen.org/gitweb/?p=xen.git;a=commit;h=b108240265deea37601f1a605910069a837da841

Paul Durrant (5):
  xen: make use of xen_xc implicit in xen_common.h inlines
  xen: rename xen_modified_memory() to xen_hvm_modified_memory()
  xen: create wrappers for all other uses of xc_hvm_XXX() functions
  configure: detect presence of libxendevicemodel
  xen: use libxendevicemodel when available

 configure                    |  19 +++
 hw/i386/xen/xen_platform.c   |   2 +-
 hw/xen/xen_backend.c         |   2 -
 include/exec/ram_addr.h      |   4 +-
 include/hw/xen/xen.h         |   2 +-
 include/hw/xen/xen_backend.h |   2 -
 include/hw/xen/xen_common.h  | 285 +++++++++++++++++++++++++++++++++++--------
 xen-common.c                 |  11 ++
 xen-hvm-stub.c               |   2 +-
 xen-hvm.c                    |  49 ++++----
 10 files changed, 292 insertions(+), 86 deletions(-)

-- 
2.1.4
