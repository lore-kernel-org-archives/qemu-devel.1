Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3793CC33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 16:49:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03C38208C4
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 16:49:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dYOlm817"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03C38208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ios2x-0001AN-G0
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 11:49:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47202)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iorld-0008Vb-TC
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 11:31:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iorlc-0005l9-AH
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 11:31:41 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:44568
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iorlc-0005kl-6p
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 11:31:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578414699;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HtbxL2MG3al1vaYV6o8j0WZPnL+D8nNZeJUMf96yEUQ=;
 b=dYOlm81734keZuBNmeMCn/I+0Aur1B7nHM5DazkuiUn8vg9Ej1I+4LO5dD/2+7MdeNxE0k
 m33iYRIwQCNyKib1Kd8pFhJtdhUgf8Mchac0XhdAYxOPbeOVICp/Js5oJTgrPux9qYD5vo
 ny05p9oDn1ef7Hj7NJmKGZY07QWff9E=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-381-ncw2GS9kNtqNQVzTXuE6Gw-1; Tue, 07 Jan 2020 11:31:38 -0500
Received: by mail-qk1-f198.google.com with SMTP id l7so144488qke.8
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 08:31:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ukejZrijNO6M+6ThiPk3cjbO646qqmDoI6mt9ROtSGs=;
 b=q62KQrXY0rxk4H3gtZc4v1UpM64ClsbseUPKxtmn/6eNs5okENgqIctMAhn6nmiKaS
 W3OJSILCbstz99RwXAxmDR1WZpyeKIHEeBCILEjsKxnj49LRuwyegYqeXP/QYrQFnSTM
 HT245jYldG80VOgR4GW/3y7uQn5TC0/rkQZtMruxJcVG5pvnZ30PIxDXOFdPHgK/MUEe
 Ydo1OJ+I8+lIC2uKnHnwGdpFUyR02RxRWyqz6PH58HG5onB4FcZtDyEnpG1TGdZQ8wYB
 ZWf3CWfLt2qqS4lit6BOSyG8pr+znEOeLeDho1YQIJfmYuFpoS2n48fOAyqb12byHRMD
 SrBw==
X-Gm-Message-State: APjAAAXx1DEO2S4AurfCl81kW7Hzll9c5Jx31G2RwRFHqpuSVJSgGsps
 /EsQp/FZOnfrA6a1z4Ly9o45yjVMYpf7dHnSMd1rOGSRVs6rNyAxkjiJhipsvbrzshajZoHffUh
 hYKfEQlOzH0IHeao=
X-Received: by 2002:ac8:42d7:: with SMTP id g23mr65266439qtm.206.1578414697388; 
 Tue, 07 Jan 2020 08:31:37 -0800 (PST)
X-Google-Smtp-Source: APXvYqwhBOQOT+vtm2OhyjeBtvj8TZzlt6UdqcY679CT1AnyTX5UZWUlUscfLneG9zgpE8GsjhgXdg==
X-Received: by 2002:ac8:42d7:: with SMTP id g23mr65266419qtm.206.1578414697161; 
 Tue, 07 Jan 2020 08:31:37 -0800 (PST)
Received: from redhat.com (bzq-79-183-34-164.red.bezeqint.net. [79.183.34.164])
 by smtp.gmail.com with ESMTPSA id h6sm108958qtr.33.2020.01.07.08.31.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2020 08:31:36 -0800 (PST)
Date: Tue, 7 Jan 2020 11:31:33 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v3 27/32] tests: add virtio-scsi and virtio-blk seg_max_adjust
 test
Message-ID: <20200107162850.411448-28-mst@redhat.com>
References: <20200107162850.411448-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200107162850.411448-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-MC-Unique: ncw2GS9kNtqNQVzTXuE6Gw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Denis Plotnikov <dplotnikov@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Denis Plotnikov <dplotnikov@virtuozzo.com>

It tests proper seg_max_adjust settings for all machine types except
'none', 'isapc', 'microvm'

Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
Message-Id: <20191220140905.1718-3-dplotnikov@virtuozzo.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/acceptance/virtio_seg_max_adjust.py | 134 ++++++++++++++++++++++
 1 file changed, 134 insertions(+)
 create mode 100755 tests/acceptance/virtio_seg_max_adjust.py

diff --git a/tests/acceptance/virtio_seg_max_adjust.py b/tests/acceptance/v=
irtio_seg_max_adjust.py
new file mode 100755
index 0000000000..5458573138
--- /dev/null
+++ b/tests/acceptance/virtio_seg_max_adjust.py
@@ -0,0 +1,134 @@
+#!/usr/bin/env python
+#
+# Test virtio-scsi and virtio-blk queue settings for all machine types
+#
+# Copyright (c) 2019 Virtuozzo International GmbH
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program.  If not, see <http://www.gnu.org/licenses/>.
+#
+
+import sys
+import os
+import re
+
+sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'pytho=
n'))
+from qemu.machine import QEMUMachine
+from avocado_qemu import Test
+
+#list of machine types and virtqueue properties to test
+VIRTIO_SCSI_PROPS =3D {'seg_max_adjust': 'seg_max_adjust'}
+VIRTIO_BLK_PROPS =3D {'seg_max_adjust': 'seg-max-adjust'}
+
+DEV_TYPES =3D {'virtio-scsi-pci': VIRTIO_SCSI_PROPS,
+             'virtio-blk-pci': VIRTIO_BLK_PROPS}
+
+VM_DEV_PARAMS =3D {'virtio-scsi-pci': ['-device', 'virtio-scsi-pci,id=3Dsc=
si0'],
+                 'virtio-blk-pci': ['-device',
+                                    'virtio-blk-pci,id=3Dscsi0,drive=3Ddri=
ve0',
+                                    '-drive',
+                                    'driver=3Dnull-co,id=3Ddrive0,if=3Dnon=
e']}
+
+
+class VirtioMaxSegSettingsCheck(Test):
+    @staticmethod
+    def make_pattern(props):
+        pattern_items =3D ['{0} =3D \w+'.format(prop) for prop in props]
+        return '|'.join(pattern_items)
+
+    def query_virtqueue(self, vm, dev_type_name):
+        query_ok =3D False
+        error =3D None
+        props =3D None
+
+        output =3D vm.command('human-monitor-command',
+                            command_line =3D 'info qtree')
+        props_list =3D DEV_TYPES[dev_type_name].values();
+        pattern =3D self.make_pattern(props_list)
+        res =3D re.findall(pattern, output)
+
+        if len(res) !=3D len(props_list):
+            props_list =3D set(props_list)
+            res =3D set(res)
+            not_found =3D props_list.difference(res)
+            not_found =3D ', '.join(not_found)
+            error =3D '({0}): The following properties not found: {1}'\
+                     .format(dev_type_name, not_found)
+        else:
+            query_ok =3D True
+            props =3D dict()
+            for prop in res:
+                p =3D prop.split(' =3D ')
+                props[p[0]] =3D p[1]
+        return query_ok, props, error
+
+    def check_mt(self, mt, dev_type_name):
+        with QEMUMachine(self.qemu_bin) as vm:
+            vm.set_machine(mt["name"])
+            for s in VM_DEV_PARAMS[dev_type_name]:
+                vm.add_args(s)
+            vm.launch()
+            query_ok, props, error =3D self.query_virtqueue(vm, dev_type_n=
ame)
+
+        if not query_ok:
+            self.fail('machine type {0}: {1}'.format(mt['name'], error))
+
+        for prop_name, prop_val in props.items():
+            expected_val =3D mt[prop_name]
+            self.assertEqual(expected_val, prop_val)
+
+    @staticmethod
+    def seg_max_adjust_enabled(mt):
+        # machine types >=3D 5.0 should have seg_max_adjust =3D true
+        # others seg_max_adjust =3D false
+        mt =3D mt.split("-")
+
+        # machine types with one line name and name like pc-x.x
+        if len(mt) <=3D 2:
+            return False
+
+        # machine types like pc-<chip_name>-x.x[.x]
+        ver =3D mt[2]
+        ver =3D ver.split(".");
+
+        # versions >=3D 5.0 goes with seg_max_adjust enabled
+        major =3D int(ver[0])
+
+        if major >=3D 5:
+            return True
+        return False
+
+    def test_machine_types(self):
+        # collect all machine types except 'none', 'isapc', 'microvm'
+        with QEMUMachine(self.qemu_bin) as vm:
+            vm.launch()
+            machines =3D [m['name'] for m in vm.command('query-machines')]
+            vm.shutdown()
+        machines.remove('none')
+        machines.remove('isapc')
+        machines.remove('microvm')
+
+        for dev_type in DEV_TYPES:
+            # create the list of machine types and their parameters.
+            mtypes =3D list()
+            for m in machines:
+                if self.seg_max_adjust_enabled(m):
+                    enabled =3D 'true'
+                else:
+                    enabled =3D 'false'
+                mtypes.append({'name': m,
+                               DEV_TYPES[dev_type]['seg_max_adjust']: enab=
led})
+
+            # test each machine type for a device type
+            for mt in mtypes:
+                self.check_mt(mt, dev_type)
--=20
MST


