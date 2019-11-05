Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A6CC5DF60
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 21:45:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3786921A49
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 21:45:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3786921A49
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50608 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iS6e2-0008FA-PZ
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 16:45:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58990)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1iS5pg-0001S8-CS
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 15:53:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1iS5pe-0002Uw-OB
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 15:53:44 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48288)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
 id 1iS5pe-0002Bd-GM; Tue, 05 Nov 2019 15:53:42 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 xA5KpWD3144541; Tue, 5 Nov 2019 15:53:21 -0500
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2w3fuuhaew-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 Nov 2019 15:53:21 -0500
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id xA5Kqgw3147059;
 Tue, 5 Nov 2019 15:53:21 -0500
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com
 [169.63.121.186])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2w3fuuhaea-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 Nov 2019 15:53:21 -0500
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
 by ppma03wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xA5Knur1017653;
 Tue, 5 Nov 2019 20:53:20 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26]) by ppma03wdc.us.ibm.com with ESMTP id 2w11e7h8uw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 Nov 2019 20:53:20 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com
 [9.57.199.107])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xA5KrJ0o27853128
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 5 Nov 2019 20:53:19 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8026E12405C;
 Tue,  5 Nov 2019 20:53:19 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6CE2D124058;
 Tue,  5 Nov 2019 20:53:19 +0000 (GMT)
Received: from localhost (unknown [9.53.179.218])
 by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
 Tue,  5 Nov 2019 20:53:19 +0000 (GMT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 05/55] pc: Don't make die-id mandatory unless necessary
Date: Tue,  5 Nov 2019 14:51:53 -0600
Message-Id: <20191105205243.3766-6-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191105205243.3766-1-mdroth@linux.vnet.ibm.com>
References: <20191105205243.3766-1-mdroth@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-11-05_07:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1911050170
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 148.163.156.1
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-stable@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Eduardo Habkost <ehabkost@redhat.com>

We have this issue reported when using libvirt to hotplug CPUs:
https://bugzilla.redhat.com/show_bug.cgi?id=1741451

Basically, libvirt is not copying die-id from
query-hotpluggable-cpus, but die-id is now mandatory.

We could blame libvirt and say it is not following the documented
interface, because we have this buried in the QAPI schema
documentation:

> Note: currently there are 5 properties that could be present
> but management should be prepared to pass through other
> properties with device_add command to allow for future
> interface extension. This also requires the filed names to be kept in
> sync with the properties passed to -device/device_add.

But I don't think this would be reasonable from us.  We can just
make QEMU more flexible and let die-id to be omitted when there's
no ambiguity.  This will allow us to keep compatibility with
existing libvirt versions.

Test case included to ensure we don't break this again.

Fixes: commit 176d2cda0dee ("i386/cpu: Consolidate die-id validity in smp context")
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <20190816170750.23910-1-ehabkost@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
(cherry picked from commit fea374e7c8079563bca7c8fac895c6a880f76adc)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/i386/pc.c                             |  8 ++++++
 tests/acceptance/pc_cpu_hotplug_props.py | 35 ++++++++++++++++++++++++
 2 files changed, 43 insertions(+)
 create mode 100644 tests/acceptance/pc_cpu_hotplug_props.py

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 549c437050..947f81070f 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -2403,6 +2403,14 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
         int max_socket = (ms->smp.max_cpus - 1) /
                                 smp_threads / smp_cores / pcms->smp_dies;
 
+        /*
+         * die-id was optional in QEMU 4.0 and older, so keep it optional
+         * if there's only one die per socket.
+         */
+        if (cpu->die_id < 0 && pcms->smp_dies == 1) {
+            cpu->die_id = 0;
+        }
+
         if (cpu->socket_id < 0) {
             error_setg(errp, "CPU socket-id is not set");
             return;
diff --git a/tests/acceptance/pc_cpu_hotplug_props.py b/tests/acceptance/pc_cpu_hotplug_props.py
new file mode 100644
index 0000000000..08b7e632c6
--- /dev/null
+++ b/tests/acceptance/pc_cpu_hotplug_props.py
@@ -0,0 +1,35 @@
+#
+# Ensure CPU die-id can be omitted on -device
+#
+#  Copyright (c) 2019 Red Hat Inc
+#
+# Author:
+#  Eduardo Habkost <ehabkost@redhat.com>
+#
+# This library is free software; you can redistribute it and/or
+# modify it under the terms of the GNU Lesser General Public
+# License as published by the Free Software Foundation; either
+# version 2 of the License, or (at your option) any later version.
+#
+# This library is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+# Lesser General Public License for more details.
+#
+# You should have received a copy of the GNU Lesser General Public
+# License along with this library; if not, see <http://www.gnu.org/licenses/>.
+#
+
+from avocado_qemu import Test
+
+class OmittedCPUProps(Test):
+    """
+    :avocado: tags=arch:x86_64
+    """
+    def test_no_die_id(self):
+        self.vm.add_args('-nodefaults', '-S')
+        self.vm.add_args('-smp', '1,sockets=2,cores=2,threads=2,maxcpus=8')
+        self.vm.add_args('-cpu', 'qemu64')
+        self.vm.add_args('-device', 'qemu64-x86_64-cpu,socket-id=1,core-id=0,thread-id=0')
+        self.vm.launch()
+        self.assertEquals(len(self.vm.command('query-cpus')), 2)
-- 
2.17.1


