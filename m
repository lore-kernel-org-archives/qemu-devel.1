Received: from eggs.gnu.org ([2001:4830:134:3::10]:50827)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dVf2s-00005n-LZ
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 10:24:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dVf2n-0001oG-Ki
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 10:24:46 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:34832)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dVf2n-0001ml-Eb
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 10:24:41 -0400
Received: by mail-wm0-x243.google.com with SMTP id u23so5454188wma.2
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 07:24:41 -0700 (PDT)
Received: from 640k.lan (94-39-191-51.adsl-ull.clienti.tiscali.it.
	[94.39.191.51]) by smtp.gmail.com with ESMTPSA id
	k75sm6042448wmh.10.2017.07.13.07.24.38 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 13 Jul 2017 07:24:39 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 13 Jul 2017 16:23:54 +0200
Message-Id: <1499955874-10954-2-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1499955874-10954-1-git-send-email-pbonzini@redhat.com>
References: <1499955874-10954-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 01/41] build: add -Wexpansion-to-defined
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
index 5096cbc..239f142 100755
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
1.8.3.1
