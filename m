Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84694C3A59C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 17:08:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1886F20665
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 17:08:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1886F20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyfiX-0004rm-QJ
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 13:08:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49701)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1hyfhm-0004Ih-9K
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 13:07:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1hyfhk-0007BM-Q4
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 13:07:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58996)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>)
 id 1hyfhk-0007Ae-I6; Fri, 16 Aug 2019 13:07:56 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8CD68308427C;
 Fri, 16 Aug 2019 17:07:55 +0000 (UTC)
Received: from localhost (ovpn-116-32.gru2.redhat.com [10.97.116.32])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5CACD87B6;
 Fri, 16 Aug 2019 17:07:52 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 16 Aug 2019 14:07:50 -0300
Message-Id: <20190816170750.23910-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Fri, 16 Aug 2019 17:07:55 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2] pc: Don't make die-id mandatory unless
 necessary
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
Cc: Peter Krempa <pkrempa@redhat.com>,
 Vanderson Martins do Rosario <vandersonmr2@gmail.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Like Xu <like.xu@linux.intel.com>,
 Erik Skultety <eskultet@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-stable@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We have this issue reported when using libvirt to hotplug CPUs:
https://bugzilla.redhat.com/show_bug.cgi?id=3D1741451

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

Fixes: commit 176d2cda0dee ("i386/cpu: Consolidate die-id validity in smp=
 context")
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Changes v1 -> v2:
* v1 was "pc: Don't make CPU properties mandatory unless necessary"
* Make only die-id optional (Igor Mammedov)
---
 hw/i386/pc.c                             |  8 ++++++
 tests/acceptance/pc_cpu_hotplug_props.py | 35 ++++++++++++++++++++++++
 2 files changed, 43 insertions(+)
 create mode 100644 tests/acceptance/pc_cpu_hotplug_props.py

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 3ab4bcb3ca..9c3f6ae828 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -2406,6 +2406,14 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplu=
g_dev,
         int max_socket =3D (ms->smp.max_cpus - 1) /
                                 smp_threads / smp_cores / pcms->smp_dies=
;
=20
+        /*
+         * die-id was optional in QEMU 4.0 and older, so keep it optiona=
l
+         * if there's only one die per socket.
+         */
+        if (cpu->die_id < 0 && pcms->smp_dies =3D=3D 1) {
+            cpu->die_id =3D 0;
+        }
+
         if (cpu->socket_id < 0) {
             error_setg(errp, "CPU socket-id is not set");
             return;
diff --git a/tests/acceptance/pc_cpu_hotplug_props.py b/tests/acceptance/=
pc_cpu_hotplug_props.py
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
+# License along with this library; if not, see <http://www.gnu.org/licen=
ses/>.
+#
+
+from avocado_qemu import Test
+
+class OmittedCPUProps(Test):
+    """
+    :avocado: tags=3Darch:x86_64
+    """
+    def test_no_die_id(self):
+        self.vm.add_args('-nodefaults', '-S')
+        self.vm.add_args('-smp', '1,sockets=3D2,cores=3D2,threads=3D2,ma=
xcpus=3D8')
+        self.vm.add_args('-cpu', 'qemu64')
+        self.vm.add_args('-device', 'qemu64-x86_64-cpu,socket-id=3D1,cor=
e-id=3D0,thread-id=3D0')
+        self.vm.launch()
+        self.assertEquals(len(self.vm.command('query-cpus')), 2)
--=20
2.21.0


