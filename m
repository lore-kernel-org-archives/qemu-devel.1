Received: from eggs.gnu.org ([2001:4830:134:3::10]:58763)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fOR8k-0003t0-TG
	for qemu-devel@nongnu.org; Thu, 31 May 2018 13:13:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fOR8j-0000Pt-Sh
	for qemu-devel@nongnu.org; Thu, 31 May 2018 13:13:30 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33544 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fOR8j-0000PF-Np
	for qemu-devel@nongnu.org; Thu, 31 May 2018 13:13:29 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 626E4406F619
	for <qemu-devel@nongnu.org>; Thu, 31 May 2018 17:13:29 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 31 May 2018 19:12:36 +0200
Message-Id: <20180531171253.21012-37-pbonzini@redhat.com>
In-Reply-To: <20180531171253.21012-1-pbonzini@redhat.com>
References: <20180531171253.21012-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 36/53] qemu-options: Mark the non-functional
 -clock option as deprecated
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>

From: Thomas Huth <thuth@redhat.com>

The function is only ignored since QEMU version 1.7.0. Let's mark
it as deprecated, so that we can finally completely remove it soon.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <1526990298-17924-1-git-send-email-thuth@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qemu-doc.texi | 5 +++++
 vl.c          | 1 +
 2 files changed, 6 insertions(+)

diff --git a/qemu-doc.texi b/qemu-doc.texi
index 0e0e0ae72b..057a48ec1f 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -2922,6 +2922,11 @@ The @code{-startdate} option has been replaced by @code{-rtc base=@var{date}}.
 Option @option{-virtioconsole} has been replaced by
 @option{-device virtconsole}.
 
+@subsection -clock (since 3.0.0)
+
+The @code{-clock} option is ignored since QEMU version 1.7.0. There is no
+replacement since it is not needed anymore.
+
 @section qemu-img command line arguments
 
 @subsection convert -s (since 2.0.0)
diff --git a/vl.c b/vl.c
index 4a0e17833d..c70ce25de7 100644
--- a/vl.c
+++ b/vl.c
@@ -3713,6 +3713,7 @@ int main(int argc, char **argv, char **envp)
                 /* Clock options no longer exist.  Keep this option for
                  * backward compatibility.
                  */
+                warn_report("This option is ignored and will be removed soon");
                 break;
             case QEMU_OPTION_startdate:
                 warn_report("This option is deprecated, use '-rtc base=' instead.");
-- 
2.17.0
