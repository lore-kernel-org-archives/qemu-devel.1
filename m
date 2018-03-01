Received: from eggs.gnu.org ([2001:4830:134:3::10]:59031)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1erNrs-0004ji-Cm
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 08:03:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1erNrn-0007hc-No
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 08:03:28 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Thu,  1 Mar 2018 14:01:56 +0100
Message-Id: <20180301130201.24666-23-cohuck@redhat.com>
In-Reply-To: <20180301130201.24666-1-cohuck@redhat.com>
References: <20180301130201.24666-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL v2 22/27] qemu-doc: deprecate query-cpus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, borntraeger@de.ibm.com, rth@twiddle.net, agraf@suse.de, david@redhat.com, thuth@redhat.com, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>

From: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>

Start the deprecation period for QAPI query-cpus (replaced by
query-cpus-fast) beginning with 2.12.0.

Signed-off-by: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <1518797321-28356-5-git-send-email-mihajlov@linux.vnet.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 qapi-schema.json | 4 ++++
 qemu-doc.texi    | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/qapi-schema.json b/qapi-schema.json
index e6ca63f718..cd98a94388 100644
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
index 8e3556976b..b3c2763624 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -2762,6 +2762,10 @@ by the ``convert -l snapshot_param'' argument instead.
 "autoload" parameter is now ignored. All bitmaps are automatically loaded
 from qcow2 images.
 
+@subsection query-cpus (since 2.12.0)
+
+The ``query-cpus'' command is replaced by the ``query-cpus-fast'' command.
+
 @section System emulator human monitor commands
 
 @subsection host_net_add (since 2.10.0)
-- 
2.13.6
