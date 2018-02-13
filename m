Received: from eggs.gnu.org ([2001:4830:134:3::10]:43362)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1elk4v-0006jn-Nn
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 18:33:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1elk4v-0003Va-0k
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 18:33:37 -0500
From: Eric Blake <eblake@redhat.com>
Date: Tue, 13 Feb 2018 17:33:23 -0600
Message-Id: <20180213233324.5096-2-eblake@redhat.com>
In-Reply-To: <20180213233324.5096-1-eblake@redhat.com>
References: <20180213233324.5096-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH 1/2] qcow2: Prefer 'entries' over 'size' for
 non-byte values in spec
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, berto@igalia.com, mreitz@redhat.com, Kevin Wolf <kwolf@redhat.com>

We want to limit the use of the term 'size' for only values that
count by bytes.  Renaming fields in the spec does not invalidate
any existing implementation, but may make future implementations
easier to write.

A reasonable followup would be to rename internal qemu code that
operates on qcow2 images to also use the distinction between
size and entries in variable names.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 docs/interop/qcow2.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/docs/interop/qcow2.txt b/docs/interop/qcow2.txt
index d7fdb1fee31..597d3f261d5 100644
--- a/docs/interop/qcow2.txt
+++ b/docs/interop/qcow2.txt
@@ -47,7 +47,7 @@ The first cluster of a qcow2 image contains the file header:
                     1 for AES encryption
                     2 for LUKS encryption

-         36 - 39:   l1_size
+         36 - 39:   l1_entries
                     Number of entries in the active L1 table

          40 - 47:   l1_table_offset
@@ -538,7 +538,7 @@ Structure of a bitmap directory entry:
                     (described below) for the bitmap starts. Must be aligned to
                     a cluster boundary.

-         8 - 11:    bitmap_table_size
+         8 - 11:    bitmap_table_entries
                     Number of entries in the bitmap table of the bitmap.

         12 - 15:    flags
-- 
2.14.3
