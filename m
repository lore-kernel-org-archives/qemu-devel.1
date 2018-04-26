Received: from eggs.gnu.org ([2001:4830:134:3::10]:34557)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=647a3a28a=Ian.Jackson@citrix.com>)
	id 1fBjGL-0000yB-VY
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 11:56:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=647a3a28a=Ian.Jackson@citrix.com>)
	id 1fBjGK-0003ea-Gx
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 11:56:50 -0400
Received: from smtp03.citrix.com ([162.221.156.55]:29394)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=647a3a28a=Ian.Jackson@citrix.com>)
	id 1fBjGK-0003eD-89
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 11:56:48 -0400
From: Ian Jackson <ian.jackson@eu.citrix.com>
Date: Thu, 26 Apr 2018 16:56:12 +0100
Message-ID: <1524758187-9351-2-git-send-email-ian.jackson@eu.citrix.com>
In-Reply-To: <1524758187-9351-1-git-send-email-ian.jackson@eu.citrix.com>
References: <1524758187-9351-1-git-send-email-ian.jackson@eu.citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PULL 01/16] checkpatch: Add xendevicemodel_handle to
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

The type xendevicemodel_handle does not conform to Qemu CODING_STYLE,
which would suggest CamelCase.  However, it is a type defined by the
Xen Project in xen.git.  It would be possible to introduce a typedef
to allow the qemu code to refer to it by a differently-spelled name,
but that would obfuscate more than it would clarify.

CC: Eric Blake <eblake@redhat.com>
CC: Paolo Bonzini <pbonzini@redhat.com>
CC: Daniel P. Berrange <berrange@redhat.com>
Signed-off-by: Ian Jackson <Ian.Jackson@eu.citrix.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 scripts/checkpatch.pl | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index d52207a..5b8735d 100755
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
