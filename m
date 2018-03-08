Received: from eggs.gnu.org ([2001:4830:134:3::10]:57062)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=5980b9d75=Ian.Jackson@citrix.com>)
	id 1eu0pS-0000qa-0E
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 14:03:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=5980b9d75=Ian.Jackson@citrix.com>)
	id 1eu0pQ-0002gg-R7
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 14:03:50 -0500
Received: from smtp.citrix.com ([66.165.176.89]:27694)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=5980b9d75=Ian.Jackson@citrix.com>)
	id 1eu0pQ-0002cK-KO
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 14:03:48 -0500
From: Ian Jackson <ian.jackson@eu.citrix.com>
Date: Thu, 8 Mar 2018 19:02:56 +0000
Message-ID: <1520535787-6223-2-git-send-email-ian.jackson@eu.citrix.com>
In-Reply-To: <1520535787-6223-1-git-send-email-ian.jackson@eu.citrix.com>
References: <1520535787-6223-1-git-send-email-ian.jackson@eu.citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 01/12] checkpatch: Add xendevicemodel_handle to
 the list of types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Ross Lagerwall <ross.lagerwall@citrix.com>, Anthony PERARD <anthony.perard@citrix.com>, Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, xen-devel@lists.xenproject.org, Ian Jackson <ian.jackson@eu.citrix.com>, Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Ian Jackson <Ian.Jackson@eu.citrix.com>

This avoids checkpatch misparsing (as statements) long function
definitions or declarations, which sometimes start with constructs
like this:

  static inline int xendevicemodel_relocate_memory(
      xendevicemodel_handle *dmod, domid_t domid, ...

CC: Eric Blake <eblake@redhat.com>
CC: Paolo Bonzini <pbonzini@redhat.com>
CC: Daniel P. Berrange <berrange@redhat.com>
Signed-off-by: Ian Jackson <Ian.Jackson@eu.citrix.com>
---
v6.1: New patch
---
 scripts/checkpatch.pl | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index d1fe79b..3e488f7 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -266,6 +266,7 @@ our @typeList = (
 	qr{target_(?:u)?long},
 	qr{hwaddr},
 	qr{xml${Ident}},
+	qr{xendevicemodel_handle},
 );
 
 # This can be modified by sub possible.  Since it can be empty, be careful
-- 
2.1.4
