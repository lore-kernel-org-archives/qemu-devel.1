Received: from eggs.gnu.org ([2001:4830:134:3::10]:57787)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gHtoM-0000eo-2W
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 12:57:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gHtoH-0002nb-SP
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 12:57:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47166)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gHtoH-0002cE-FK
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 12:57:37 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 45FC8308FB9B
	for <qemu-devel@nongnu.org>; Wed, 31 Oct 2018 16:57:28 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Wed, 31 Oct 2018 16:57:23 +0000
Message-Id: <20181031165725.61938-2-dgilbert@redhat.com>
In-Reply-To: <20181031165725.61938-1-dgilbert@redhat.com>
References: <20181031165725.61938-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/3] COLO: Fix Colo doc secondeary should be
 secondary
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, quintela@redhat.com

From: wangguang <wang.guang55@zte.com.cn>

Signed-off-by: Guang Wang <wang.guang55@zte.com.cn>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 docs/COLO-FT.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docs/COLO-FT.txt b/docs/COLO-FT.txt
index 6302469d0e..e2686bb338 100644
--- a/docs/COLO-FT.txt
+++ b/docs/COLO-FT.txt
@@ -173,7 +173,7 @@ Secondary:
 { 'execute': 'nbd-server-start',
   'arguments': {'addr': {'type': 'inet', 'data': {'host': 'xx.xx.xx.xx',=
 'port': '8889'} } }
 }
-{'execute': 'nbd-server-add', 'arguments': {'device': 'secondeary-disk0'=
, 'writable': true } }
+{'execute': 'nbd-server-add', 'arguments': {'device': 'secondary-disk0',=
 'writable': true } }
=20
 Note:
   a. The qmp command nbd-server-start and nbd-server-add must be run
--=20
2.19.1
