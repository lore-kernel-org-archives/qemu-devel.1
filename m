Received: from eggs.gnu.org ([2001:4830:134:3::10]:38674)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mihajlov@de.ibm.com>) id 1emelK-0002I4-Dy
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 07:05:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mihajlov@de.ibm.com>) id 1emelF-00031r-Sv
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 07:05:10 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33418)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mihajlov@de.ibm.com>) id 1emelF-000300-KE
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 07:05:05 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w1GBuUc8034552
	for <qemu-devel@nongnu.org>; Fri, 16 Feb 2018 07:05:04 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2g5tvk9ty6-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 16 Feb 2018 07:05:04 -0500
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mihajlov@de.ibm.com>;
	Fri, 16 Feb 2018 12:05:01 -0000
From: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
Date: Fri, 16 Feb 2018 13:04:51 +0100
In-Reply-To: <1518782691-1232-1-git-send-email-mihajlov@linux.vnet.ibm.com>
References: <1518782691-1232-1-git-send-email-mihajlov@linux.vnet.ibm.com>
Message-Id: <1518782691-1232-5-git-send-email-mihajlov@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCHv4 4/4] qemu-doc: deprecate query-cpus
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
query-cpus-fast) beginning with 2.12.0.

Signed-off-by: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
---
 qapi-schema.json | 4 ++++
 qemu-doc.texi    | 4 ++++
 2 files changed, 8 insertions(+)

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
index 137f581..221f565 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -2764,6 +2764,10 @@ by the ``convert -l snapshot_param'' argument instead.
 "autoload" parameter is now ignored. All bitmaps are automatically loaded
 from qcow2 images.
 
+@subsection query-cpus (since 2.12.0)
+
+The ``query-cpus'' command is replaced by the ``query-cpus-fast'' command.
+
 @section System emulator human monitor commands
 
 @subsection host_net_add (since 2.10.0)
-- 
1.9.1
