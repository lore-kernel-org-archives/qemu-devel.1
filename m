Received: from eggs.gnu.org ([2001:4830:134:3::10]:54894)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1da0Xy-0003LC-33
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 10:10:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1da0Xu-0002ny-ST
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 10:10:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53506)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1da0Xu-0002nF-LY
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 10:10:46 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 920E2FBA4
	for <qemu-devel@nongnu.org>; Tue, 25 Jul 2017 14:10:45 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Tue, 25 Jul 2017 15:10:41 +0100
Message-Id: <20170725141041.1195-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH] qemu-options: document existance of versioned
 machine types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

The -machine docs did not explain what the versioned machine
types are for, nor that they'll be maintained across
releases.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 qemu-options.hx | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index 746b5fa75d..9f6e2adfff 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -49,7 +49,20 @@ STEXI
 @item -machine [type=]@var{name}[,prop=@var{value}[,...]]
 @findex -machine
 Select the emulated machine by @var{name}. Use @code{-machine help} to list
-available machines. Supported machine properties are:
+available machines.
+
+For architectures which aim to support live migration compatibility
+across releases, each release will introduce a new versioned machine
+type. For example, the 2.8.0 release introduced machine types
+``pc-i440fx-2.8'' and ``pc-q35-2.8'' for the x86_64/i686 architectures.
+
+To allow live migration of guests from QEMU version 2.8.0, to QEMU
+version 2.9.0, the 2.9.0 version must support the ``pc-i440fx-2.8''
+and ``pc-q35-2.8'' machines too. To allow users live migrating VMs
+to skip multiple intermediate releases when upgrading, new releases
+of QEMU will support machine types from many previous versions.
+
+Supported machine properties are:
 @table @option
 @item accel=@var{accels1}[:@var{accels2}[:...]]
 This is used to enable an accelerator. Depending on the target architecture,
-- 
2.13.3
