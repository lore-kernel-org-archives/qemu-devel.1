Received: from eggs.gnu.org ([2001:4830:134:3::10]:41372)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fGAt7-00036n-4k
	for qemu-devel@nongnu.org; Tue, 08 May 2018 18:15:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fGAt5-0001UY-R8
	for qemu-devel@nongnu.org; Tue, 08 May 2018 18:15:13 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:37214)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fGAt5-0001UB-LJ
	for qemu-devel@nongnu.org; Tue, 08 May 2018 18:15:11 -0400
Received: by mail-wm0-x244.google.com with SMTP id l1-v6so24209771wmb.2
	for <qemu-devel@nongnu.org>; Tue, 08 May 2018 15:15:11 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed,  9 May 2018 00:14:34 +0200
Message-Id: <1525817687-34620-18-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1525817687-34620-1-git-send-email-pbonzini@redhat.com>
References: <1525817687-34620-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 17/30] qemu-options: Mark -virtioconsole as
 deprecated
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

The qemu-doc already states that this option is only maintained for
backward compatibility and "-device virtconsole" should be used
instead. So let's take the next step and mark this option officially
as deprecated.

Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <1525446790-16139-1-git-send-email-thuth@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qemu-doc.texi   | 5 +++++
 qemu-options.hx | 5 +----
 vl.c            | 2 ++
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/qemu-doc.texi b/qemu-doc.texi
index 0ed0f19..4add403 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -2931,6 +2931,11 @@ The @code{-localtime} option has been replaced by @code{-rtc base=localtime}.
 
 The @code{-startdate} option has been replaced by @code{-rtc base=@var{date}}.
 
+@subsection -virtioconsole (since 2.13.0)
+
+Option @option{-virtioconsole} has been replaced by
+@option{-device virtconsole}.
+
 @section qemu-img command line arguments
 
 @subsection convert -s (since 2.0.0)
diff --git a/qemu-options.hx b/qemu-options.hx
index c611766..091ded6 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -3675,10 +3675,7 @@ STEXI
 @item -virtioconsole @var{c}
 @findex -virtioconsole
 Set virtio console.
-
-This option is maintained for backward compatibility.
-
-Please use @code{-device virtconsole} for the new way of invocation.
+This option is deprecated, please use @option{-device virtconsole} instead.
 ETEXI
 
 DEF("show-cursor", 0, QEMU_OPTION_show_cursor, \
diff --git a/vl.c b/vl.c
index 12e31d1..b928e3e 100644
--- a/vl.c
+++ b/vl.c
@@ -3587,6 +3587,8 @@ int main(int argc, char **argv, char **envp)
                 }
                 break;
             case QEMU_OPTION_virtiocon:
+                warn_report("This option is deprecated, "
+                            "use '-device virtconsole' instead");
                 add_device_config(DEV_VIRTCON, optarg);
                 default_virtcon = 0;
                 if (strncmp(optarg, "mon:", 4) == 0) {
-- 
1.8.3.1
