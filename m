Received: from eggs.gnu.org ([2001:4830:134:3::10]:56713)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fRH8Q-0005Ui-Bg
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 09:08:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fRH8P-0006hl-7c
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 09:08:54 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38338 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fRH8P-0006hV-2W
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 09:08:53 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BB6C5BB43B
	for <qemu-devel@nongnu.org>; Fri,  8 Jun 2018 13:08:52 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Fri,  8 Jun 2018 14:08:44 +0100
Message-Id: <20180608130846.22234-6-dgilbert@redhat.com>
In-Reply-To: <20180608130846.22234-1-dgilbert@redhat.com>
References: <20180608130846.22234-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH v3 5/7] hmp: Add info commands for preconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, armbru@redhat.com, imammedo@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Allow a bunch of the info commands to be used in preconfig.

version, chardev, name, uuid,memdev, iothreads
  Were enabled in QMP in the previous patch from Igor

status, hotpluggable_cpus
  Was enabled in the original allow-preconfig series

history
  is HMP specific

usbhost, qom-tree, numa
  Don't have a QMP equivalent

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 hmp-commands-info.hx | 12 ++++++++++++
 hmp-commands.hx      |  1 +
 2 files changed, 13 insertions(+)

diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index ddfcd5adcc..f4d0d7d2d0 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -19,6 +19,7 @@ ETEXI
         .params     = "",
         .help       = "show the version of QEMU",
         .cmd        = hmp_info_version,
+        .flags      = "p",
     },
 
 STEXI
@@ -47,6 +48,7 @@ ETEXI
         .params     = "",
         .help       = "show the character devices",
         .cmd        = hmp_info_chardev,
+        .flags      = "p",
     },
 
 STEXI
@@ -165,6 +167,7 @@ ETEXI
         .params     = "",
         .help       = "show the command line history",
         .cmd        = hmp_info_history,
+        .flags      = "p",
     },
 
 STEXI
@@ -315,6 +318,7 @@ ETEXI
         .params     = "",
         .help       = "show NUMA information",
         .cmd        = hmp_info_numa,
+        .flags      = "p",
     },
 
 STEXI
@@ -343,6 +347,7 @@ ETEXI
         .params     = "",
         .help       = "show host USB devices",
         .cmd        = hmp_info_usbhost,
+        .flags      = "p",
     },
 
 STEXI
@@ -399,6 +404,7 @@ ETEXI
         .params     = "",
         .help       = "show the current VM status (running|paused)",
         .cmd        = hmp_info_status,
+        .flags      = "p",
     },
 
 STEXI
@@ -457,6 +463,7 @@ ETEXI
         .params     = "",
         .help       = "show the current VM name",
         .cmd        = hmp_info_name,
+        .flags      = "p",
     },
 
 STEXI
@@ -471,6 +478,7 @@ ETEXI
         .params     = "",
         .help       = "show the current VM UUID",
         .cmd        = hmp_info_uuid,
+        .flags      = "p",
     },
 
 STEXI
@@ -613,6 +621,7 @@ ETEXI
         .params     = "[path]",
         .help       = "show QOM composition tree",
         .cmd        = hmp_info_qom_tree,
+        .flags      = "p",
     },
 
 STEXI
@@ -671,6 +680,7 @@ ETEXI
         .params     = "",
         .help       = "show memory backends",
         .cmd        = hmp_info_memdev,
+        .flags      = "p",
     },
 
 STEXI
@@ -699,6 +709,7 @@ ETEXI
         .params     = "",
         .help       = "show iothreads",
         .cmd        = hmp_info_iothreads,
+        .flags      = "p",
     },
 
 STEXI
@@ -829,6 +840,7 @@ ETEXI
         .params     = "",
         .help       = "Show information about hotpluggable CPUs",
         .cmd        = hmp_hotpluggable_cpus,
+        .flags      = "p",
     },
 
 STEXI
diff --git a/hmp-commands.hx b/hmp-commands.hx
index 8bf590ae4b..dc82ed526f 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -1856,6 +1856,7 @@ ETEXI
         .help       = "show various information about the system state",
         .cmd        = hmp_info_help,
         .sub_table  = info_cmds,
+        .flags      = "p",
     },
 
 STEXI
-- 
2.17.0
