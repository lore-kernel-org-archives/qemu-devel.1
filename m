Received: from eggs.gnu.org ([2001:4830:134:3::10]:54803)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fEC2c-0006pp-IP
	for qemu-devel@nongnu.org; Thu, 03 May 2018 07:04:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fEC2X-00085g-L4
	for qemu-devel@nongnu.org; Thu, 03 May 2018 07:04:50 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36026 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fEC2X-00085N-Gh
	for qemu-devel@nongnu.org; Thu, 03 May 2018 07:04:45 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Thu,  3 May 2018 13:04:33 +0200
Message-Id: <1525345473-31593-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] qemu-options: Mark -virtioconsole as deprecated
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Amit Shah <amit@kernel.org>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Cc: mst@redhat.com, berrange@redhat.com

The qemu-doc already states that this option is only maintained for
backward compatibility and "-device virtconsole" should be used
instead. So let's take the next step and mark this option officially
as deprecated.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 qemu-doc.texi   | 5 +++++
 qemu-options.hx | 2 +-
 vl.c            | 2 ++
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/qemu-doc.texi b/qemu-doc.texi
index 5813d27..e48ed05 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -2931,6 +2931,11 @@ The @code{-localtime} option has been replaced by @code{-rtc base=localtime}.
 
 The @code{-startdate} option has been replaced by @code{-rtc base=@var{date}}.
 
+@subsection -virtioconsole (since 2.13.0)
+
+You can use @code{-device virtconsole} instead of @code{-virtioconsole}
+to configure a virtio-console.
+
 @section qemu-img command line arguments
 
 @subsection convert -s (since 2.0.0)
diff --git a/qemu-options.hx b/qemu-options.hx
index c611766..7693d2c 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -3676,7 +3676,7 @@ STEXI
 @findex -virtioconsole
 Set virtio console.
 
-This option is maintained for backward compatibility.
+This option is deprecated and only maintained for backward compatibility.
 
 Please use @code{-device virtconsole} for the new way of invocation.
 ETEXI
diff --git a/vl.c b/vl.c
index 7487535..c409ff3 100644
--- a/vl.c
+++ b/vl.c
@@ -3634,6 +3634,8 @@ int main(int argc, char **argv, char **envp)
                 }
                 break;
             case QEMU_OPTION_virtiocon:
+                warn_report("This option is deprecated, "
+                            "use '-device virtconsole' instead.");
                 add_device_config(DEV_VIRTCON, optarg);
                 default_virtcon = 0;
                 if (strncmp(optarg, "mon:", 4) == 0) {
-- 
1.8.3.1
