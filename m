Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D550C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 18:55:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FC6720658
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 18:55:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y2hTDwQR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FC6720658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCpSY-0005eV-F5
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 14:55:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59864)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jCpGm-0002ZM-2U
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 14:42:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jCpGk-0006Vf-Cq
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 14:42:51 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:27288
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jCpGk-0006Uo-9H
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 14:42:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584124969;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RRyDWw95dJommAqN2W7J/+LU6ZDRn1YTu8tBofHJOHo=;
 b=Y2hTDwQR5/J0WM4VNmM6XZjdUq/g2z2WS4kl6G8OUiPRgoDHX03psoGiKXui5g1rIy0zpi
 6G4ynb24z/XfbKvDRn6htqakkiY7F2xeqrjZ0VpmjLgNQtLlYKrBKSJ8VxPeLzRKKSeXpA
 ZHrbgNt8h4w3nYQJ+Rlhg8/e5jd6n7o=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-207-kvX61bR3PWq0WGsfPJaw1Q-1; Fri, 13 Mar 2020 14:42:44 -0400
X-MC-Unique: kvX61bR3PWq0WGsfPJaw1Q-1
Received: by mail-wr1-f71.google.com with SMTP id b12so4764411wro.4
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2020 11:42:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=BJAcmokJWBLuNcr+8yfIvUvFzq5Jj9wL/tRzXK130E4=;
 b=kMIIORmJoTGQiN1BAn9JqapbS9cM2y2u+fI9ZkoUh7L3vio6pRKqhZ9eKfSykYRLCo
 U/8hmKl0e5kironIkpHuG0Mag8B1G2kBCrH9ol91MHhUy9JN9LDPbujw1IYkz+ApUKu0
 aOx6w87IkxrrvwWWG5jCy0UVG1AUVhHNptUXiwRVsFaa6mTneOBk2AqORyEYofEXXCZB
 yXpW/C3ZwX4bymWmxwbMKGevx3LFd2yIGRi0ojeU6RzLlZrys4I5zR5MoXiTPv206LLn
 EEridtcdOmA95C978SUfPfSB1behyG0fRTYcwMYXWEk0WmYvU+kuIESuMtS66FsqrYqv
 yDCw==
X-Gm-Message-State: ANhLgQ36VhAiQPxLX0ibVyTNeqxAQR6XnI6zvUi4myKScuPDrgikMRUt
 fkHfkF1vQX1ihS87aGfaDj5bX986L6g7HaXpNHx1W+B6u9dtWjD7jn2pxYfdfc0EqDEZ5ZJ30G2
 s6AgbIUmKl5WQTuU=
X-Received: by 2002:a5d:5342:: with SMTP id t2mr137003wrv.104.1584124960648;
 Fri, 13 Mar 2020 11:42:40 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvFHIGrf5NUxUUGAYLRTrdbtx/VL7qA6r/G/YjypCpBOF/S/kh4nKAMekiQ4HFAzFX8h9bvOA==
X-Received: by 2002:a5d:5342:: with SMTP id t2mr136967wrv.104.1584124960320;
 Fri, 13 Mar 2020 11:42:40 -0700 (PDT)
Received: from x1w.redhat.com (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id x13sm18382962wmj.5.2020.03.13.11.42.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2020 11:42:39 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 9/9] qapi/misc: Restrict device memory commands to machine code
Date: Fri, 13 Mar 2020 19:41:53 +0100
Message-Id: <20200313184153.11275-10-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200313184153.11275-1-philmd@redhat.com>
References: <20200313184153.11275-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Ben Warren <ben@skyportsystems.com>, Peter Lieven <pl@kamp.de>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Igor Mammedov <imammedo@redhat.com>,
 Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 qapi/machine.json               | 131 +++++++++++++++++++++++++++++++
 qapi/misc.json                  | 132 --------------------------------
 include/hw/mem/memory-device.h  |   1 +
 include/hw/virtio/virtio-pmem.h |   2 +-
 4 files changed, 133 insertions(+), 133 deletions(-)

diff --git a/qapi/machine.json b/qapi/machine.json
index 33b259dbd0..17ccebda14 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -1476,3 +1476,134 @@
 #
 ##
 { 'command': 'query-pci', 'returns': ['PciInfo'] }
+
+##
+# @MemoryInfo:
+#
+# Actual memory information in bytes.
+#
+# @base-memory: size of "base" memory specified with command line
+#               option -m.
+#
+# @plugged-memory: size of memory that can be hot-unplugged. This field
+#                  is omitted if target doesn't support memory hotplug
+#                  (i.e. CONFIG_MEM_DEVICE not defined at build time).
+#
+# Since: 2.11.0
+##
+{ 'struct': 'MemoryInfo',
+  'data'  : { 'base-memory': 'size', '*plugged-memory': 'size' } }
+
+##
+# @query-memory-size-summary:
+#
+# Return the amount of initially allocated and present hotpluggable (if
+# enabled) memory in bytes.
+#
+# Example:
+#
+# -> { "execute": "query-memory-size-summary" }
+# <- { "return": { "base-memory": 4294967296, "plugged-memory": 0 } }
+#
+# Since: 2.11.0
+##
+{ 'command': 'query-memory-size-summary', 'returns': 'MemoryInfo' }
+
+##
+# @PCDIMMDeviceInfo:
+#
+# PCDIMMDevice state information
+#
+# @id: device's ID
+#
+# @addr: physical address, where device is mapped
+#
+# @size: size of memory that the device provides
+#
+# @slot: slot number at which device is plugged in
+#
+# @node: NUMA node number where device is plugged in
+#
+# @memdev: memory backend linked with device
+#
+# @hotplugged: true if device was hotplugged
+#
+# @hotpluggable: true if device if could be added/removed while machine is=
 running
+#
+# Since: 2.1
+##
+{ 'struct': 'PCDIMMDeviceInfo',
+  'data': { '*id': 'str',
+            'addr': 'int',
+            'size': 'int',
+            'slot': 'int',
+            'node': 'int',
+            'memdev': 'str',
+            'hotplugged': 'bool',
+            'hotpluggable': 'bool'
+          }
+}
+
+##
+# @VirtioPMEMDeviceInfo:
+#
+# VirtioPMEM state information
+#
+# @id: device's ID
+#
+# @memaddr: physical address in memory, where device is mapped
+#
+# @size: size of memory that the device provides
+#
+# @memdev: memory backend linked with device
+#
+# Since: 4.1
+##
+{ 'struct': 'VirtioPMEMDeviceInfo',
+  'data': { '*id': 'str',
+            'memaddr': 'size',
+            'size': 'size',
+            'memdev': 'str'
+          }
+}
+
+##
+# @MemoryDeviceInfo:
+#
+# Union containing information about a memory device
+#
+# nvdimm is included since 2.12. virtio-pmem is included since 4.1.
+#
+# Since: 2.1
+##
+{ 'union': 'MemoryDeviceInfo',
+  'data': { 'dimm': 'PCDIMMDeviceInfo',
+            'nvdimm': 'PCDIMMDeviceInfo',
+            'virtio-pmem': 'VirtioPMEMDeviceInfo'
+          }
+}
+
+##
+# @query-memory-devices:
+#
+# Lists available memory devices and their state
+#
+# Since: 2.1
+#
+# Example:
+#
+# -> { "execute": "query-memory-devices" }
+# <- { "return": [ { "data":
+#                       { "addr": 5368709120,
+#                         "hotpluggable": true,
+#                         "hotplugged": true,
+#                         "id": "d1",
+#                         "memdev": "/objects/memX",
+#                         "node": 0,
+#                         "size": 1073741824,
+#                         "slot": 0},
+#                    "type": "dimm"
+#                  } ] }
+#
+##
+{ 'command': 'query-memory-devices', 'returns': ['MemoryDeviceInfo'] }
diff --git a/qapi/misc.json b/qapi/misc.json
index 699a533e6c..48a0c5410b 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -486,39 +486,6 @@
 ##
 { 'command': 'closefd', 'data': {'fdname': 'str'} }
=20
-##
-# @MemoryInfo:
-#
-# Actual memory information in bytes.
-#
-# @base-memory: size of "base" memory specified with command line
-#               option -m.
-#
-# @plugged-memory: size of memory that can be hot-unplugged. This field
-#                  is omitted if target doesn't support memory hotplug
-#                  (i.e. CONFIG_MEM_DEVICE not defined at build time).
-#
-# Since: 2.11.0
-##
-{ 'struct': 'MemoryInfo',
-  'data'  : { 'base-memory': 'size', '*plugged-memory': 'size' } }
-
-##
-# @query-memory-size-summary:
-#
-# Return the amount of initially allocated and present hotpluggable (if
-# enabled) memory in bytes.
-#
-# Example:
-#
-# -> { "execute": "query-memory-size-summary" }
-# <- { "return": { "base-memory": 4294967296, "plugged-memory": 0 } }
-#
-# Since: 2.11.0
-##
-{ 'command': 'query-memory-size-summary', 'returns': 'MemoryInfo' }
-
-
 ##
 # @AddfdInfo:
 #
@@ -756,105 +723,6 @@
  'returns': ['CommandLineOptionInfo'],
  'allow-preconfig': true }
=20
-##
-# @PCDIMMDeviceInfo:
-#
-# PCDIMMDevice state information
-#
-# @id: device's ID
-#
-# @addr: physical address, where device is mapped
-#
-# @size: size of memory that the device provides
-#
-# @slot: slot number at which device is plugged in
-#
-# @node: NUMA node number where device is plugged in
-#
-# @memdev: memory backend linked with device
-#
-# @hotplugged: true if device was hotplugged
-#
-# @hotpluggable: true if device if could be added/removed while machine is=
 running
-#
-# Since: 2.1
-##
-{ 'struct': 'PCDIMMDeviceInfo',
-  'data': { '*id': 'str',
-            'addr': 'int',
-            'size': 'int',
-            'slot': 'int',
-            'node': 'int',
-            'memdev': 'str',
-            'hotplugged': 'bool',
-            'hotpluggable': 'bool'
-          }
-}
-
-##
-# @VirtioPMEMDeviceInfo:
-#
-# VirtioPMEM state information
-#
-# @id: device's ID
-#
-# @memaddr: physical address in memory, where device is mapped
-#
-# @size: size of memory that the device provides
-#
-# @memdev: memory backend linked with device
-#
-# Since: 4.1
-##
-{ 'struct': 'VirtioPMEMDeviceInfo',
-  'data': { '*id': 'str',
-            'memaddr': 'size',
-            'size': 'size',
-            'memdev': 'str'
-          }
-}
-
-##
-# @MemoryDeviceInfo:
-#
-# Union containing information about a memory device
-#
-# nvdimm is included since 2.12. virtio-pmem is included since 4.1.
-#
-# Since: 2.1
-##
-{ 'union': 'MemoryDeviceInfo',
-  'data': { 'dimm': 'PCDIMMDeviceInfo',
-            'nvdimm': 'PCDIMMDeviceInfo',
-            'virtio-pmem': 'VirtioPMEMDeviceInfo'
-          }
-}
-
-##
-# @query-memory-devices:
-#
-# Lists available memory devices and their state
-#
-# Since: 2.1
-#
-# Example:
-#
-# -> { "execute": "query-memory-devices" }
-# <- { "return": [ { "data":
-#                       { "addr": 5368709120,
-#                         "hotpluggable": true,
-#                         "hotplugged": true,
-#                         "id": "d1",
-#                         "memdev": "/objects/memX",
-#                         "node": 0,
-#                         "size": 1073741824,
-#                         "slot": 0},
-#                    "type": "dimm"
-#                  } ] }
-#
-##
-{ 'command': 'query-memory-devices', 'returns': ['MemoryDeviceInfo'] }
-
 ##
 # @ReplayMode:
 #
diff --git a/include/hw/mem/memory-device.h b/include/hw/mem/memory-device.=
h
index 04476acb8f..76f3de0f7e 100644
--- a/include/hw/mem/memory-device.h
+++ b/include/hw/mem/memory-device.h
@@ -14,6 +14,7 @@
 #define MEMORY_DEVICE_H
=20
 #include "hw/qdev-core.h"
+#include "qapi/qapi-types-machine.h"
 #include "qapi/qapi-types-misc.h"
 #include "qom/object.h"
=20
diff --git a/include/hw/virtio/virtio-pmem.h b/include/hw/virtio/virtio-pme=
m.h
index 33f1999320..72863412b2 100644
--- a/include/hw/virtio/virtio-pmem.h
+++ b/include/hw/virtio/virtio-pmem.h
@@ -15,7 +15,7 @@
 #define HW_VIRTIO_PMEM_H
=20
 #include "hw/virtio/virtio.h"
-#include "qapi/qapi-types-misc.h"
+#include "qapi/qapi-types-machine.h"
=20
 #define TYPE_VIRTIO_PMEM "virtio-pmem"
=20
--=20
2.21.1


