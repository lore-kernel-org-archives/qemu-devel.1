Received: from eggs.gnu.org ([2001:4830:134:3::10]:45458)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cROgg-0003Nu-SE
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 14:35:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cROgf-0003Pm-NP
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 14:35:58 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:36177)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cROgf-0003PF-GF
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 14:35:57 -0500
Received: by mail-wm0-x241.google.com with SMTP id r126so313254wmr.3
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 11:35:57 -0800 (PST)
Received: from 640k.lan (94-39-158-71.adsl-ull.clienti.tiscali.it.
	[94.39.158.71]) by smtp.gmail.com with ESMTPSA id
	k11sm10463101wmb.18.2017.01.11.11.35.54 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 11 Jan 2017 11:35:55 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 11 Jan 2017 20:35:16 +0100
Message-Id: <1484163327-111841-23-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1484163327-111841-1-git-send-email-pbonzini@redhat.com>
References: <1484163327-111841-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 22/33] hxtool: emit Texinfo headings as
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
1.8.3.1
