Received: from eggs.gnu.org ([2001:4830:134:3::10]:40312)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eMHzy-0003AT-Eu
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 13:31:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eMHzx-0005JA-QA
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 13:31:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53240)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eMHzx-0005Ij-Jx
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 13:31:17 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C88DD85543
	for <qemu-devel@nongnu.org>; Tue,  5 Dec 2017 18:31:16 +0000 (UTC)
Received: from donizetti.redhat.com (ovpn-117-52.ams2.redhat.com
	[10.36.117.52])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 31DA05E25F
	for <qemu-devel@nongnu.org>; Tue,  5 Dec 2017 18:31:16 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  5 Dec 2017 19:31:15 +0100
Message-Id: <20171205183115.3792-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [qemu-web PATCH] lock more dependencies for RHEL7
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This is required to work with Ruby 2.0; jekyll-watch 1.5.1 was
released on Dec 2 and requires Ruby 2.2.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Gemfile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Gemfile b/Gemfile
index 933b92b..b01dff9 100644
--- a/Gemfile
+++ b/Gemfile
@@ -26,5 +26,8 @@ end
 
 # for RHEL7
 gem 'public_suffix', "< 3.0"
+gem 'jekyll-watch', '= 1.5.0'
+gem 'listen', '< 3.1'
+gem 'ruby_dep', '< 1.4'
 gem 'json'
 gem 'json_pure'
-- 
2.14.3
