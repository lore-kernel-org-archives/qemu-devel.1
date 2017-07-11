Received: from eggs.gnu.org ([2001:4830:134:3::10]:56162)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dUqFk-0007E5-Ir
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 04:10:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dUqFh-00079K-4p
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 04:10:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37730)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dUqFg-00078q-SJ
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 04:10:37 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 99CAE81138
	for <qemu-devel@nongnu.org>; Tue, 11 Jul 2017 08:10:35 +0000 (UTC)
Received: from donizetti.redhat.com (ovpn-116-87.ams2.redhat.com
	[10.36.116.87])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0C5D360657
	for <qemu-devel@nongnu.org>; Tue, 11 Jul 2017 08:10:34 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 11 Jul 2017 10:10:33 +0200
Message-Id: <20170711081033.12399-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH] build: add -Wexpansion-to-defined
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This warning is included in -Wall by clang, but not by GCC (which only
enables it for -Wextra).  Include it in the list of warnings we enable
to minimize the differences between the compilers:

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure b/configure
index 806658c98b..bd1769d4d8 100755
--- a/configure
+++ b/configure
@@ -1583,7 +1583,7 @@ gcc_flags="-Wold-style-declaration -Wold-style-definition -Wtype-limits"
 gcc_flags="-Wformat-security -Wformat-y2k -Winit-self -Wignored-qualifiers $gcc_flags"
 gcc_flags="-Wno-missing-include-dirs -Wempty-body -Wnested-externs $gcc_flags"
 gcc_flags="-Wendif-labels -Wno-shift-negative-value $gcc_flags"
-gcc_flags="-Wno-initializer-overrides $gcc_flags"
+gcc_flags="-Wno-initializer-overrides -Wexpansion-to-defined $gcc_flags"
 gcc_flags="-Wno-string-plus-int $gcc_flags"
 # Note that we do not add -Werror to gcc_flags here, because that would
 # enable it for all configure tests. If a configure test failed due
-- 
2.13.0
