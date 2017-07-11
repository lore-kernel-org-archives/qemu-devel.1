Received: from eggs.gnu.org ([2001:4830:134:3::10]:58769)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dUqSM-0002LQ-GP
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 04:23:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dUqSJ-0003Bq-DH
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 04:23:42 -0400
Received: from mail-lf0-x243.google.com ([2a00:1450:4010:c07::243]:34728)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dUqSJ-0003BT-4F
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 04:23:39 -0400
Received: by mail-lf0-x243.google.com with SMTP id g21so13299000lfk.1
	for <qemu-devel@nongnu.org>; Tue, 11 Jul 2017 01:23:37 -0700 (PDT)
Received: from donizetti.redhat.com (94-39-191-51.adsl-ull.clienti.tiscali.it.
	[94.39.191.51]) by smtp.gmail.com with ESMTPSA id
	j137sm13033322wmd.18.2017.07.11.01.23.34 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 11 Jul 2017 01:23:35 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 11 Jul 2017 10:23:26 +0200
Message-Id: <20170711082326.12990-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] build: disable Xen on ARM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

While ARM could present the xenpv machine, it does not and trying to enable
it breaks compilation.

Fixes: 3b6b75506de44c5070639943c30a0ad5850f5d02
Reported-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure | 1 -
 1 file changed, 1 deletion(-)

diff --git a/configure b/configure
index a2bec60a97..97b02244fe 100755
--- a/configure
+++ b/configure
@@ -203,7 +203,6 @@ supported_xen_target() {
     test "$xen" = "yes" || return 1
     glob "$1" "*-softmmu" || return 1
     case "${1%-softmmu}:$cpu" in
-        arm:arm | aarch64:aarch64 | \
         i386:i386 | i386:x86_64 | x86_64:i386 | x86_64:x86_64)
             return 0
         ;;
-- 
2.13.0
