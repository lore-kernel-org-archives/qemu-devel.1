Received: from eggs.gnu.org ([2001:4830:134:3::10]:42031)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fQB34-0003oB-C2
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 08:26:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fQB32-0005Ge-KV
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 08:26:50 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34724 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fQB32-0005GC-Cn
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 08:26:48 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 75250402382F
	for <qemu-devel@nongnu.org>; Tue,  5 Jun 2018 12:26:47 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Tue,  5 Jun 2018 13:26:34 +0100
Message-Id: <20180605122636.33654-5-dgilbert@redhat.com>
In-Reply-To: <20180605122636.33654-1-dgilbert@redhat.com>
References: <20180605122636.33654-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH 4/6] hmp: Add info commands for preconfig
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
Could probably add most of them.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 hmp-commands-info.hx | 9 +++++++++
 hmp-commands.hx      | 1 +
 2 files changed, 10 insertions(+)

diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index ddfcd5adcc..00735e7d1c 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -19,6 +19,7 @@ ETEXI
         .params     = "",
         .help       = "show the version of QEMU",
         .cmd        = hmp_info_version,
+        .flags      = "p",
     },
 
 STEXI
@@ -33,6 +34,7 @@ ETEXI
         .params     = "",
         .help       = "show the network state",
         .cmd        = hmp_info_network,
+        .flags      = "p",
     },
 
 STEXI
@@ -47,6 +49,7 @@ ETEXI
         .params     = "",
         .help       = "show the character devices",
         .cmd        = hmp_info_chardev,
+        .flags      = "p",
     },
 
 STEXI
@@ -62,6 +65,7 @@ ETEXI
         .help       = "show info of one block device or all block devices "
                       "(-n: show named nodes; -v: show details)",
         .cmd        = hmp_info_block,
+        .flags      = "p",
     },
 
 STEXI
@@ -151,6 +155,7 @@ ETEXI
         .params     = "",
         .help       = "show infos for each CPU",
         .cmd        = hmp_info_cpus,
+        .flags      = "p",
     },
 
 STEXI
@@ -165,6 +170,7 @@ ETEXI
         .params     = "",
         .help       = "show the command line history",
         .cmd        = hmp_info_history,
+        .flags      = "p",
     },
 
 STEXI
@@ -255,6 +261,7 @@ ETEXI
         .help       = "show memory tree (-f: dump flat view for address spaces;"
                       "-d: dump dispatch tree, valid with -f only)",
         .cmd        = hmp_info_mtree,
+        .flags      = "p",
     },
 
 STEXI
@@ -399,6 +406,7 @@ ETEXI
         .params     = "",
         .help       = "show the current VM status (running|paused)",
         .cmd        = hmp_info_status,
+        .flags      = "p",
     },
 
 STEXI
@@ -829,6 +837,7 @@ ETEXI
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
