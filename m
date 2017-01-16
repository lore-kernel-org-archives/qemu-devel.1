Received: from eggs.gnu.org ([2001:4830:134:3::10]:58115)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cTAdC-0000zo-Tz
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 11:59:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cTAdC-00008C-39
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 11:59:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50582)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cTAdB-00007m-PP
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 11:59:41 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DE5FD4E4D0
	for <qemu-devel@nongnu.org>; Mon, 16 Jan 2017 16:59:41 +0000 (UTC)
Received: from donizetti.redhat.com (ovpn-116-100.ams2.redhat.com
	[10.36.116.100])
	by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id v0GGxGV8001760
	for <qemu-devel@nongnu.org>; Mon, 16 Jan 2017 11:59:41 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 16 Jan 2017 17:59:05 +0100
Message-Id: <20170116165916.8575-22-pbonzini@redhat.com>
In-Reply-To: <20170116165916.8575-1-pbonzini@redhat.com>
References: <20170116165916.8575-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 21/32] hxtool: emit Texinfo headings as
 @subsection
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Remove the colon, and add it in qemu-options-wrapper.h instead.
The introduction of @subsection also found a case where the table
was not closed and reopened around a heading, so fix it.

Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qemu-options-wrapper.h |  2 +-
 qemu-options.hx        | 31 +++++++++++++++++++------------
 scripts/hxtool         | 11 +++++++++--
 3 files changed, 29 insertions(+), 15 deletions(-)

diff --git a/qemu-options-wrapper.h b/qemu-options-wrapper.h
index 13bfea0..4d7aeb1 100644
--- a/qemu-options-wrapper.h
+++ b/qemu-options-wrapper.h
@@ -14,7 +14,7 @@
 
 #define ARCHHEADING(text, arch_mask) \
     if ((arch_mask) & arch_type)    \
-        puts(stringify(text));
+        puts(stringify(text) ":");
 
 #define DEFHEADING(text) ARCHHEADING(text, QEMU_ARCH_ALL)
 
diff --git a/qemu-options.hx b/qemu-options.hx
index c534a2f..b62d2d7 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -6,7 +6,7 @@ HXCOMM construct option structures, enums and help message for specified
 HXCOMM architectures.
 HXCOMM HXCOMM can be used for comments, discarded from both texi and C
 
-DEFHEADING(Standard options:)
+DEFHEADING(Standard options)
 STEXI
 @table @option
 ETEXI
@@ -468,7 +468,7 @@ STEXI
 ETEXI
 DEFHEADING()
 
-DEFHEADING(Block device options:)
+DEFHEADING(Block device options)
 STEXI
 @table @option
 ETEXI
@@ -856,7 +856,7 @@ STEXI
 ETEXI
 DEFHEADING()
 
-DEFHEADING(USB options:)
+DEFHEADING(USB options)
 STEXI
 @table @option
 ETEXI
@@ -920,7 +920,7 @@ STEXI
 ETEXI
 DEFHEADING()
 
-DEFHEADING(Display options:)
+DEFHEADING(Display options)
 STEXI
 @table @option
 ETEXI
@@ -1449,7 +1449,7 @@ STEXI
 ETEXI
 ARCHHEADING(, QEMU_ARCH_I386)
 
-ARCHHEADING(i386 target only:, QEMU_ARCH_I386)
+ARCHHEADING(i386 target only, QEMU_ARCH_I386)
 STEXI
 @table @option
 ETEXI
@@ -1565,7 +1565,7 @@ STEXI
 ETEXI
 DEFHEADING()
 
-DEFHEADING(Network options:)
+DEFHEADING(Network options)
 STEXI
 @table @option
 ETEXI
@@ -2146,7 +2146,7 @@ STEXI
 ETEXI
 DEFHEADING()
 
-DEFHEADING(Character device options:)
+DEFHEADING(Character device options)
 STEXI
 
 The general form of a character device option is:
@@ -2481,7 +2481,7 @@ STEXI
 ETEXI
 DEFHEADING()
 
-DEFHEADING(Device URL Syntax:)
+DEFHEADING(Device URL Syntax)
 STEXI
 
 In addition to using normal file images for the emulated storage devices,
@@ -2711,7 +2711,7 @@ STEXI
 @end table
 ETEXI
 
-DEFHEADING(Bluetooth(R) options:)
+DEFHEADING(Bluetooth(R) options)
 STEXI
 @table @option
 ETEXI
@@ -2787,7 +2787,7 @@ ETEXI
 DEFHEADING()
 
 #ifdef CONFIG_TPM
-DEFHEADING(TPM device options:)
+DEFHEADING(TPM device options)
 
 DEF("tpmdev", HAS_ARG, QEMU_OPTION_tpmdev, \
     "-tpmdev passthrough,id=id[,path=path][,cancel-path=path]\n"
@@ -2861,7 +2861,7 @@ DEFHEADING()
 
 #endif
 
-DEFHEADING(Linux/Multiboot boot specific:)
+DEFHEADING(Linux/Multiboot boot specific)
 STEXI
 
 When using these options, you can use a given Linux or Multiboot
@@ -2917,7 +2917,7 @@ STEXI
 ETEXI
 DEFHEADING()
 
-DEFHEADING(Debug/Expert options:)
+DEFHEADING(Debug/Expert options)
 STEXI
 @table @option
 ETEXI
@@ -3775,7 +3775,14 @@ Dump json-encoded vmstate information for current machine type to file
 in @var{file}
 ETEXI
 
+STEXI
+@end table
+ETEXI
+DEFHEADING()
 DEFHEADING(Generic object creation)
+STEXI
+@table @option
+ETEXI
 
 DEF("object", HAS_ARG, QEMU_OPTION_object,
     "-object TYPENAME[,PROP1=VALUE1,...]\n"
diff --git a/scripts/hxtool b/scripts/hxtool
index 04f7d7b..5468cd7 100644
--- a/scripts/hxtool
+++ b/scripts/hxtool
@@ -16,6 +16,13 @@ hxtoh()
     done
 }
 
+print_texi_heading()
+{
+    if test "$*" != ""; then
+        printf "@subsection %s\n" "$*"
+    fi
+}
+
 hxtotexi()
 {
     flag=0
@@ -45,10 +52,10 @@ hxtotexi()
             fi
             ;;
             DEFHEADING*)
-            printf '%s\n' "$(expr "$str" : "DEFHEADING(\(.*\))")"
+            print_texi_heading "$(expr "$str" : "DEFHEADING(\(.*\))")"
             ;;
             ARCHHEADING*)
-            printf '%s\n' "$(expr "$str" : "ARCHHEADING(\(.*\),.*)")"
+            print_texi_heading "$(expr "$str" : "ARCHHEADING(\(.*\),.*)")"
             ;;
             *)
             test $flag -eq 1 && printf '%s\n' "$str"
-- 
2.9.3
