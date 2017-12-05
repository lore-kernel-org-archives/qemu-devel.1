Received: from eggs.gnu.org ([2001:4830:134:3::10]:40300)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eMHzw-0003AC-GK
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 13:31:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eMHzt-0005H1-CY
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 13:31:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41362)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eMHzt-0005GX-7H
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 13:31:13 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3D81E820FB
	for <qemu-devel@nongnu.org>; Tue,  5 Dec 2017 18:31:12 +0000 (UTC)
Received: from donizetti.redhat.com (ovpn-117-52.ams2.redhat.com
	[10.36.117.52])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A43016269E
	for <qemu-devel@nongnu.org>; Tue,  5 Dec 2017 18:31:11 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  5 Dec 2017 19:31:10 +0100
Message-Id: <20171205183110.3739-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [qemu-web PATCH] require older version of public_suffix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

New versions require Ruby version >= 2.1.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Gemfile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Gemfile b/Gemfile
index 90dc8a9..933b92b 100644
--- a/Gemfile
+++ b/Gemfile
@@ -25,5 +25,6 @@ end
 
 
 # for RHEL7
+gem 'public_suffix', "< 3.0"
 gem 'json'
 gem 'json_pure'
-- 
2.14.3
