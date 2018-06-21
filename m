Received: from eggs.gnu.org ([2001:4830:134:3::10]:45047)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fW2kH-00045Z-1k
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 12:47:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fW2kD-0003k6-WA
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 12:47:41 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35224 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fW2kD-0003jT-Px
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 12:47:37 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Thu, 21 Jun 2018 17:47:25 +0100
Message-Id: <20180621164727.36626-8-dgilbert@redhat.com>
In-Reply-To: <20180621164727.36626-1-dgilbert@redhat.com>
References: <20180621164727.36626-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PULL 7/9] hmp: Add commands for preconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, imammedo@redhat.com, sjitindarsingh@gmail.com, walling@linux.ibm.com
Cc: armbru@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Allow a bunch of the info commands to be used in preconfig.

version, chardev, name, uuid,memdev, iothreads
  Were enabled in QMP in the previous patch from Igor

status, hotpluggable_cpus
  Was enabled in the original allow-preconfig series

history
  is HMP specific

qom-tree
  Don't have a QMP equivalent

Also enable the qom commands qom-list and qom-set.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Message-Id: <20180620153947.30834-6-dgilbert@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
  Dropped info numa as per Igor's 2018-06-21 review
---
 hmp-commands-info.hx | 10 ++++++++++
 hmp-commands.hx      |  3 +++
 2 files changed, 13 insertions(+)

diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index ddfcd5adcc..6db3457a78 100644
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
@@ -399,6 +402,7 @@ ETEXI
         .params     = "",
         .help       = "show the current VM status (running|paused)",
         .cmd        = hmp_info_status,
+        .flags      = "p",
     },
 
 STEXI
@@ -457,6 +461,7 @@ ETEXI
         .params     = "",
         .help       = "show the current VM name",
         .cmd        = hmp_info_name,
+        .flags      = "p",
     },
 
 STEXI
@@ -471,6 +476,7 @@ ETEXI
         .params     = "",
         .help       = "show the current VM UUID",
         .cmd        = hmp_info_uuid,
+        .flags      = "p",
     },
 
 STEXI
@@ -613,6 +619,7 @@ ETEXI
         .params     = "[path]",
         .help       = "show QOM composition tree",
         .cmd        = hmp_info_qom_tree,
+        .flags      = "p",
     },
 
 STEXI
@@ -671,6 +678,7 @@ ETEXI
         .params     = "",
         .help       = "show memory backends",
         .cmd        = hmp_info_memdev,
+        .flags      = "p",
     },
 
 STEXI
@@ -699,6 +707,7 @@ ETEXI
         .params     = "",
         .help       = "show iothreads",
         .cmd        = hmp_info_iothreads,
+        .flags      = "p",
     },
 
 STEXI
@@ -829,6 +838,7 @@ ETEXI
         .params     = "",
         .help       = "Show information about hotpluggable CPUs",
         .cmd        = hmp_hotpluggable_cpus,
+        .flags      = "p",
     },
 
 STEXI
diff --git a/hmp-commands.hx b/hmp-commands.hx
index 7ce991f4dd..4acf6a3222 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -1828,6 +1828,7 @@ ETEXI
         .params     = "path",
         .help       = "list QOM properties",
         .cmd        = hmp_qom_list,
+        .flags      = "p",
     },
 
 STEXI
@@ -1841,6 +1842,7 @@ ETEXI
         .params     = "path property value",
         .help       = "set QOM property",
         .cmd        = hmp_qom_set,
+        .flags      = "p",
     },
 
 STEXI
@@ -1855,6 +1857,7 @@ ETEXI
         .help       = "show various information about the system state",
         .cmd        = hmp_info_help,
         .sub_table  = info_cmds,
+        .flags      = "p",
     },
 
 STEXI
-- 
2.17.1
