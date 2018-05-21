Received: from eggs.gnu.org ([2001:4830:134:3::10]:41683)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1fKqaO-0000fP-W8
	for qemu-devel@nongnu.org; Mon, 21 May 2018 15:35:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1fKqaM-0003EY-KJ
	for qemu-devel@nongnu.org; Mon, 21 May 2018 15:35:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:60274)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1fKqaM-0003Cf-FK
	for qemu-devel@nongnu.org; Mon, 21 May 2018 15:35:10 -0400
From: Stefano Stabellini <sstabellini@kernel.org>
Date: Mon, 21 May 2018 12:34:55 -0700
Message-Id: <1526931304-7289-6-git-send-email-sstabellini@kernel.org>
In-Reply-To: <alpine.DEB.2.10.1805211229070.4520@sstabellini-ThinkPad-X260>
References: <alpine.DEB.2.10.1805211229070.4520@sstabellini-ThinkPad-X260>
Subject: [Qemu-devel] [PULL 06/15] All the xen stable APIs define handle
 types of the form:
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, stefanha@gmail.com
Cc: sstabellini@kernel.org, stefanha@redhat.com, anthony.perard@citrix.com, xen-devel@lists.xenproject.org, qemu-devel@nongnu.org, Paul Durrant <paul.durrant@citrix.com>

From: Paul Durrant <paul.durrant@citrix.com>

xen<subject of API>_handle

and some define additional handle types of the form:

xen<subject of API>_<purpose of handle>_handle

Examples of these are xenforeignmemory_handle and
xenforeignmemory_resource_handle.

Both of these types will be misparsed by checkpatch if they appear as the
first token in a line since, as types defined by an external library, they
do not conform to the QEMU CODING_STYLE, which suggests CamelCase.

A previous patch (5ac067a24a8) added xendevicemodel_handle to the list
of types. This patch changes that to xen\w+_handle such that it will
match all Xen stable API handles of the forms detailed above.

Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Stefano Stabellini <sstabellini@kernel.org>
---
 dtc                   | 2 +-
 scripts/checkpatch.pl | 2 +-
 ui/keycodemapdb       | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/dtc b/dtc
index e543880..558cd81 160000
--- a/dtc
+++ b/dtc
@@ -1 +1 @@
-Subproject commit e54388015af1fb4bf04d0bca99caba1074d9cc42
+Subproject commit 558cd81bdd432769b59bff01240c44f82cfb1a9d
diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index cb1b652..e3d8c2c 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -271,7 +271,7 @@ our @typeList = (
 	qr{hwaddr},
         # external libraries
 	qr{xml${Ident}},
-	qr{xendevicemodel_handle},
+	qr{xen\w+_handle},
 	# Glib definitions
 	qr{gchar},
 	qr{gshort},
diff --git a/ui/keycodemapdb b/ui/keycodemapdb
index 6b3d716..10739aa 160000
--- a/ui/keycodemapdb
+++ b/ui/keycodemapdb
@@ -1 +1 @@
-Subproject commit 6b3d716e2b6472eb7189d3220552280ef3d832ce
+Subproject commit 10739aa26051a5d49d88132604539d3ed085e72e
-- 
1.9.1
