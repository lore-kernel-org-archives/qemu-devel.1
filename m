Received: from eggs.gnu.org ([2001:4830:134:3::10]:33125)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=6664e1dc0=Paul.Durrant@citrix.com>)
	id 1fId0X-0005s6-Mi
	for qemu-devel@nongnu.org; Tue, 15 May 2018 12:41:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=6664e1dc0=Paul.Durrant@citrix.com>)
	id 1fId0T-0007QU-OD
	for qemu-devel@nongnu.org; Tue, 15 May 2018 12:41:01 -0400
Received: from smtp03.citrix.com ([162.221.156.55]:23739)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=6664e1dc0=Paul.Durrant@citrix.com>)
	id 1fId0T-0007Pf-FL
	for qemu-devel@nongnu.org; Tue, 15 May 2018 12:40:57 -0400
From: Paul Durrant <paul.durrant@citrix.com>
Date: Tue, 15 May 2018 17:40:52 +0100
Message-ID: <20180515164053.14604-3-paul.durrant@citrix.com>
In-Reply-To: <20180515164053.14604-1-paul.durrant@citrix.com>
References: <20180515164053.14604-1-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v3 2/3] checkpatch: generalize xen handle
 matching in the list of types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, xen-devel@lists.xenproject.org
Cc: Paul Durrant <paul.durrant@citrix.com>, Paolo Bonzini <pbonzini@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>

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
---
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Daniel P. Berrange <berrange@redhat.com>

v3:
 - Adjusted commit comment slightly as suggested by Eric

v2:
 - New in this version
---
 scripts/checkpatch.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index cb1b652388..e3d8c2cdfc 100755
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
2.11.0
