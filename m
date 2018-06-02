Received: from eggs.gnu.org ([2001:4830:134:3::10]:44261)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <keno@juliacomputing.com>) id 1fPE6G-0007Y9-Sp
	for qemu-devel@nongnu.org; Sat, 02 Jun 2018 17:30:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <keno@juliacomputing.com>) id 1fPE6C-0005AB-Ui
	for qemu-devel@nongnu.org; Sat, 02 Jun 2018 17:30:12 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:33376)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <keno@juliacomputing.com>)
	id 1fPE6C-00059g-PN
	for qemu-devel@nongnu.org; Sat, 02 Jun 2018 17:30:08 -0400
Received: by mail-qk0-x243.google.com with SMTP id h7-v6so15377985qkm.0
	for <qemu-devel@nongnu.org>; Sat, 02 Jun 2018 14:30:08 -0700 (PDT)
From: Keno Fischer <keno@juliacomputing.com>
Date: Sat,  2 Jun 2018 17:29:34 -0400
Message-Id: <cover.1527973524.git.keno@juliacomputing.com>
Subject: [Qemu-devel] [PATCH v3 0/5] Prepratory cleanup for 9p darwin support
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

this is a respin of just the first couple of patches of my 9p Darwin
series. These patches should be applicable independent of the darwin
work.

Keno Fischer (5):
  cutils: Provide strchrnul
  9p: xattr: Fix crashes due to free of uninitialized value
  9p: local: Avoid warning if FS_IOC_GETVERSION is not defined
  9p: Properly error check and translate flags in unlinkat
  9p: xattr: Properly translate xattrcreate flags

 configure             | 15 +++++++++++++++
 hmp.c                 |  8 ++++----
 hw/9pfs/9p-handle.c   |  8 +-------
 hw/9pfs/9p-local.c    | 42 ++++++++++++++++++++++++------------------
 hw/9pfs/9p.c          | 34 ++++++++++++++++++++++++++++------
 hw/9pfs/9p.h          |  4 ++++
 include/qemu/cutils.h |  8 ++++++++
 monitor.c             |  8 ++------
 util/cutils.c         | 15 +++++++++++++++
 util/qemu-option.c    |  6 +-----
 util/uri.c            |  6 ++----
 11 files changed, 104 insertions(+), 50 deletions(-)

-- 
2.8.1
