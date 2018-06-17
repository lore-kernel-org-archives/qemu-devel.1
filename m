Received: from eggs.gnu.org ([2001:4830:134:3::10]:56782)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <keno@juliacomputing.com>) id 1fUM0R-0005h5-Lx
	for qemu-devel@nongnu.org; Sat, 16 Jun 2018 20:57:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <keno@juliacomputing.com>) id 1fUM0M-0003ES-R1
	for qemu-devel@nongnu.org; Sat, 16 Jun 2018 20:57:23 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:45249)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <keno@juliacomputing.com>)
	id 1fUM0M-0003EJ-LL
	for qemu-devel@nongnu.org; Sat, 16 Jun 2018 20:57:18 -0400
Received: by mail-qt0-x244.google.com with SMTP id i18-v6so12370259qtp.12
	for <qemu-devel@nongnu.org>; Sat, 16 Jun 2018 17:57:18 -0700 (PDT)
From: Keno Fischer <keno@juliacomputing.com>
Date: Sat, 16 Jun 2018 20:56:44 -0400
Message-Id: <cover.1529196703.git.keno@juliacomputing.com>
Subject: [Qemu-devel] [PATCH v3 00/13] 9p: Add support for Darwin
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Keno Fischer <keno@juliacomputing.com>, groug@kaod.org

Hi Greg,

this is the rebased version of the patch series adding
support for building the 9p server on Darwin. As you
know a number of patches from the v2 version of this
series are already landed. This is the remaining patches.
Other than rebasing, there is onnly one minor change
in patch 11.

Keno

Keno Fischer (13):
  9p: linux: Fix a couple Linux assumptions
  9p: Rename 9p-util -> 9p-util-linux
  9p: darwin: Handle struct stat(fs) differences
  9p: darwin: Handle struct dirent differences
  9p: darwin: Explicitly cast comparisons of mode_t with -1
  9p: darwin: Ignore O_{NOATIME, DIRECT}
  9p: darwin: Provide a compatibility definition for XATTR_SIZE_MAX
  9p: darwin: *xattr_nofollow implementations
  9p: darwin: Compatibility for f/l*xattr
  9p: darwin: Provide a fallback implementation for utimensat
  9p: darwin: Implement compatibility for mknodat
  9p: darwin: virtfs-proxy: Implement setuid code for darwin
  9p: darwin: configure: Allow VirtFS on Darwin

 Makefile                    |   6 ++
 Makefile.objs               |   1 +
 configure                   |  22 +++--
 fsdev/file-op-9p.h          |   2 +-
 fsdev/virtfs-proxy-helper.c | 230 ++++++++++++++++++++++++++++----------------
 hw/9pfs/9p-local.c          |  25 +++--
 hw/9pfs/9p-proxy.c          |  17 +++-
 hw/9pfs/9p-synth.c          |   4 +
 hw/9pfs/9p-util-darwin.c    | 191 ++++++++++++++++++++++++++++++++++++
 hw/9pfs/9p-util-linux.c     |  70 ++++++++++++++
 hw/9pfs/9p-util.c           |  59 ------------
 hw/9pfs/9p-util.h           |  27 ++++++
 hw/9pfs/9p.c                |  71 ++++++++++++--
 hw/9pfs/Makefile.objs       |   4 +-
 include/qemu/statfs.h       |  19 ++++
 include/qemu/xattr.h        |   4 +-
 16 files changed, 579 insertions(+), 173 deletions(-)
 create mode 100644 hw/9pfs/9p-util-darwin.c
 create mode 100644 hw/9pfs/9p-util-linux.c
 delete mode 100644 hw/9pfs/9p-util.c
 create mode 100644 include/qemu/statfs.h

-- 
2.8.1
