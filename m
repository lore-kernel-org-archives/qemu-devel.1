Received: from eggs.gnu.org ([2001:4830:134:3::10]:50994)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mihajlov@de.ibm.com>) id 1emGem-0006Eg-GT
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 05:20:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mihajlov@de.ibm.com>) id 1emGee-0001yF-P7
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 05:20:48 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37766
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mihajlov@de.ibm.com>) id 1emGee-0001y1-KF
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 05:20:40 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w1FAEFQm039810
	for <qemu-devel@nongnu.org>; Thu, 15 Feb 2018 05:20:39 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2g57yj12ku-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 15 Feb 2018 05:20:39 -0500
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mihajlov@de.ibm.com>;
	Thu, 15 Feb 2018 10:20:37 -0000
From: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
Date: Thu, 15 Feb 2018 11:20:27 +0100
In-Reply-To: <1518690027-31318-1-git-send-email-mihajlov@linux.vnet.ibm.com>
References: <1518690027-31318-1-git-send-email-mihajlov@linux.vnet.ibm.com>
Message-Id: <1518690027-31318-5-git-send-email-mihajlov@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCHv3 4/4] qemu-doc: deprecate query-cpus and info
 cpus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: agraf@suse.de, ehabkost@redhat.com, armbru@redhat.com, cohuck@redhat.com, david@redhat.com, dgilbert@redhat.com, borntraeger@de.ibm.com, qemu-s390x@nongnu.org, pbonzini@redhat.com, rth@twiddle.net, eblake@redhat.com

Start the deprecation period for QAPI query-cpus (replaced by
query-cpus-fast) and HMP 'info cpus' (replaced by 'info cpus_fast')
beginning with 2.12.0.

Signed-off-by: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
---
 hmp-commands-info.hx |  4 ++--
 qapi-schema.json     |  4 ++++
 qemu-doc.texi        | 10 ++++++++++
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index 16ac602..2ccb9c7 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -149,14 +149,14 @@ ETEXI
         .name       = "cpus",
         .args_type  = "",
         .params     = "",
-        .help       = "show infos for each CPU",
+        .help       = "show infos for each CPU (deprecated, use info cpus_fast instead)",
         .cmd        = hmp_info_cpus,
     },
 
 STEXI
 @item info cpus
 @findex info cpus
-Show infos for each CPU.
+Show infos for each CPU. Deprecated, please use @code{info cpus_fast} instead.
 ETEXI
 
     {
diff --git a/qapi-schema.json b/qapi-schema.json
index e6ca63f..cd98a94 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -587,6 +587,10 @@
 #       ]
 #    }
 #
+# Notes: This interface is deprecated (since 2.12.0), and it is strongly
+#        recommended that you avoid using it. Use @query-cpus-fast to
+#        obtain information about virtual CPUs.
+#
 ##
 { 'command': 'query-cpus', 'returns': ['CpuInfo'] }
 
diff --git a/qemu-doc.texi b/qemu-doc.texi
index 769968a..46aacb6 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -2757,6 +2757,12 @@ used and it will be removed with no replacement.
 The ``convert -s snapshot_id_or_name'' argument is obsoleted
 by the ``convert -l snapshot_param'' argument instead.
 
+@section System emulator monitor commands
+
+@subsection query-cpus (since 2.12.0)
+
+The ``query-cpus'' command is replaced by the ``query-cpus-fast'' command.
+
 @section System emulator human monitor commands
 
 @subsection host_net_add (since 2.10.0)
@@ -2767,6 +2773,10 @@ The ``host_net_add'' command is replaced by the ``netdev_add'' command.
 
 The ``host_net_remove'' command is replaced by the ``netdev_del'' command.
 
+@subsection info cpus (since 2.12.0)
+
+The ``info cpus'' command is replaced by the ``info cpus_fast'' command.
+
 @section System emulator devices
 
 @subsection ivshmem (since 2.6.0)
-- 
1.9.1
