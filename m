Received: from eggs.gnu.org ([2001:4830:134:3::10]:41767)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=66179fe3f=Paul.Durrant@citrix.com>)
	id 1fGhfb-0004Bw-SR
	for qemu-devel@nongnu.org; Thu, 10 May 2018 05:15:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=66179fe3f=Paul.Durrant@citrix.com>)
	id 1fGhfZ-0002MW-Ee
	for qemu-devel@nongnu.org; Thu, 10 May 2018 05:15:27 -0400
Received: from smtp03.citrix.com ([162.221.156.55]:30400)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=66179fe3f=Paul.Durrant@citrix.com>)
	id 1fGhfY-0002K7-TJ
	for qemu-devel@nongnu.org; Thu, 10 May 2018 05:15:25 -0400
From: Paul Durrant <paul.durrant@citrix.com>
Date: Thu, 10 May 2018 10:15:17 +0100
Message-ID: <20180510091518.28199-3-paul.durrant@citrix.com>
In-Reply-To: <20180510091518.28199-1-paul.durrant@citrix.com>
References: <20180510091518.28199-1-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 2/3] checkpatch: generalize xen handle
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
Cc: Paul Durrant <paul.durrant@citrix.com>, Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>

All the xen stable APIs define handle types of the form:

<name of API>_handle

and some define additional handle types of the form:

<name of API>_<purpose of handle>_handle

Examples of these are xenforeignmemory_handle and
xenforeignmemory_resource_handle.

Both of these types will be misparsed by checkpatch if they appear as the
first token in a line since, as types defined by an external library, they
do not conform to the QEMU CODING_STYLE, which suggests CamelCase.

A previous patch (5ac067a24a8) added xendevicemodel_handle to the list
of types. This patch changes that to xen\w+_handle such that it will
match all Xen stable API handles of the forms detailed above.

Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
---
Cc: Eric Blake <eblake@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Daniel P. Berrange <berrange@redhat.com>

v2:
 - New in this version
---
 scripts/checkpatch.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 5b8735defb..98ed799f29 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -266,7 +266,7 @@ our @typeList = (
 	qr{target_(?:u)?long},
 	qr{hwaddr},
 	qr{xml${Ident}},
-	qr{xendevicemodel_handle},
+	qr{xen\w+_handle},
 );
 
 # This can be modified by sub possible.  Since it can be empty, be careful
-- 
2.11.0
