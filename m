Received: from eggs.gnu.org ([2001:4830:134:3::10]:47610)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1d5WO0-0001xW-S6
	for qemu-devel@nongnu.org; Tue, 02 May 2017 07:54:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1d5WNx-0007L7-RW
	for qemu-devel@nongnu.org; Tue, 02 May 2017 07:54:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53156)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1d5WNx-0007Kk-Kz
	for qemu-devel@nongnu.org; Tue, 02 May 2017 07:54:29 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6A2067B8BC
	for <qemu-devel@nongnu.org>; Tue,  2 May 2017 11:54:28 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
Date: Tue,  2 May 2017 13:54:22 +0200
Message-Id: <1493726062-31743-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] Mark legacy option '-no-kvm' as deprecated
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>

'-no-kvm' was just a legacy convenience option for the users of
qemu-kvm, it never made sense in the normal QEMU tree since TCG is
the default here anyway. The option has also never been specified
in the QEMU docs and in the '--help' list, so likely hardly anybody
knows about this option at all. I think we could get rid of this
without bothering anybody nowadays, but just in case, let's print
out a warning for a couple of releases first.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 vl.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/vl.c b/vl.c
index d5ec87e..2d44621 100644
--- a/vl.c
+++ b/vl.c
@@ -3709,7 +3709,9 @@ int main(int argc, char **argv, char **envp)
                     exit(1);
                 }
                 break;
-             case QEMU_OPTION_no_kvm:
+            case QEMU_OPTION_no_kvm:
+                error_report("'-no-kvm' is depreacted, please use "
+                             "'-accel tcg' instead");
                 olist = qemu_find_opts("machine");
                 qemu_opts_parse_noisily(olist, "accel=tcg", false);
                 break;
-- 
1.8.3.1
