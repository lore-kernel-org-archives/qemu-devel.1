Received: from eggs.gnu.org ([2001:4830:134:3::10]:60127)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fSfT2-00081V-JB
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 05:19:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fSfT1-00015o-85
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 05:19:56 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46186 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fSfT1-00015W-2t
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 05:19:55 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B43F77B2B1
	for <qemu-devel@nongnu.org>; Tue, 12 Jun 2018 09:19:54 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Tue, 12 Jun 2018 10:19:46 +0100
Message-Id: <20180612091948.14367-6-dgilbert@redhat.com>
In-Reply-To: <20180612091948.14367-1-dgilbert@redhat.com>
References: <20180612091948.14367-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH v4 5/7] hmp: Add commands for preconfig
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

Also enable the qom commands qom-list and qom-set.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 hmp-commands-info.hx | 12 ++++++++++++
 hmp-commands.hx      |  3 +++
 2 files changed, 15 insertions(+)

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
index 8bf590ae4b..bd87569229 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -1829,6 +1829,7 @@ ETEXI
         .params     = "path",
         .help       = "list QOM properties",
         .cmd        = hmp_qom_list,
+        .flags      = "p",
     },
 
 STEXI
@@ -1842,6 +1843,7 @@ ETEXI
         .params     = "path property value",
         .help       = "set QOM property",
         .cmd        = hmp_qom_set,
+        .flags      = "p",
     },
 
 STEXI
@@ -1856,6 +1858,7 @@ ETEXI
         .help       = "show various information about the system state",
         .cmd        = hmp_info_help,
         .sub_table  = info_cmds,
+        .flags      = "p",
     },
 
 STEXI
-- 
2.17.1
