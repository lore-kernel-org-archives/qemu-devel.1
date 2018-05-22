Received: from eggs.gnu.org ([2001:4830:134:3::10]:50753)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1fLCJ9-0001fH-3u
	for qemu-devel@nongnu.org; Tue, 22 May 2018 14:46:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1fLCJ4-0007QU-BY
	for qemu-devel@nongnu.org; Tue, 22 May 2018 14:46:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:43546)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1fLCJ4-0007Pn-5r
	for qemu-devel@nongnu.org; Tue, 22 May 2018 14:46:46 -0400
From: Stefano Stabellini <sstabellini@kernel.org>
Date: Tue, 22 May 2018 11:46:33 -0700
Message-Id: <1527014802-11289-6-git-send-email-sstabellini@kernel.org>
In-Reply-To: <alpine.DEB.2.10.1805221136110.24793@sstabellini-ThinkPad-X260>
References: <alpine.DEB.2.10.1805221136110.24793@sstabellini-ThinkPad-X260>
Subject: [Qemu-devel] [PULL v2 06/15] checkpatch: generalize xen handle
 matching in the list of types
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

All the xen stable APIs define handle types of the form:

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
Acked-by: Anthony PERARD <anthony.perard@citrix.com>
Signed-off-by: Stefano Stabellini <sstabellini@kernel.org>
---
 scripts/checkpatch.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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
-- 
1.9.1
