Return-Path: <SRS0=H3r+=CW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74CA4C433E2
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2020 19:58:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7E0C21D80
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2020 19:58:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FYtwXhCH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7E0C21D80
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHY8r-0002Qe-49
	for qemu-devel@archiver.kernel.org; Sun, 13 Sep 2020 15:58:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36540)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kHY4x-0004eK-06
 for qemu-devel@nongnu.org; Sun, 13 Sep 2020 15:54:27 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37874
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kHY4u-0002IK-HE
 for qemu-devel@nongnu.org; Sun, 13 Sep 2020 15:54:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600026863;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XKKM3MMvaieCjl80oR6LZSA2au+FTTXY452d1zBdI20=;
 b=FYtwXhCHu0ahL66PTPNYEU4YJLsxXSJV6IE0GjMYm2wvjl+u/gWSeFsgEm/bXGhOSeSiWh
 VWvG2Ij9va9ntqPtnPEGZ/wYPD3GgjL6QHcIhiuKnPJegG9mxIjQSb8GOnX2o+6ndcTA56
 3Hb9MqY/8k5DnGNpC1INrqKUpAMn4cw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-587-9N8IpZuRP7KFXURKFx0QcA-1; Sun, 13 Sep 2020 15:54:22 -0400
X-MC-Unique: 9N8IpZuRP7KFXURKFx0QcA-1
Received: by mail-wr1-f69.google.com with SMTP id n15so5882775wrv.23
 for <qemu-devel@nongnu.org>; Sun, 13 Sep 2020 12:54:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=XKKM3MMvaieCjl80oR6LZSA2au+FTTXY452d1zBdI20=;
 b=jhSXOFCDwo3ulmeRdVuFb3zh6iqCU5FQUFn6wA4fIW6UOAteN3ZiDfEcptpX+BwlHg
 4+C2cr25cvdCve1PTdng+PCHOtgPLEOqKamakBjnKsHKKHHXZsQp3PcLExhTkcbMoSHH
 kQmC/4MZ7LZQ9sFlWUd1mGkpTQXDiNLwlvNaP57eFoTUTxQ9Vq8vsymPG9v6TDCNAHIU
 ZSE7xzfvmCiD/EX/tdWeyKAc91dpXiVc3X89sBla61kkda1bIi6UKpml2/2/AushiAZ8
 A8LZvAV/pOzRTbSuweTb5v5AzISlR0FL+G+8IoZ76/GslujnKPRhmi9OGLeeHm6DO+ZH
 cOBA==
X-Gm-Message-State: AOAM530/P9t2m/hkuCPp0KF5YTuyyKTiZw5e+AT4IwbtuO+K2rusinba
 5AHqPFE1LvKYl/fsV0BNABYqu8hZHshptIWz08/PtVJxvlr2zYLeJ6WYVWfs/3fLvJyUAdct9dQ
 uj8XZ0XgQV7Izavc=
X-Received: by 2002:a7b:cb82:: with SMTP id m2mr12305550wmi.56.1600026860290; 
 Sun, 13 Sep 2020 12:54:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzQGl3enJKL1jwV7fPHgkwQ/wW6+xwZz9qmQqXGQkYrQy91ZouKWh4GhrkFLM7gT3ccVUEsUw==
X-Received: by 2002:a7b:cb82:: with SMTP id m2mr12305520wmi.56.1600026859692; 
 Sun, 13 Sep 2020 12:54:19 -0700 (PDT)
Received: from localhost.localdomain (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id a13sm4468487wme.26.2020.09.13.12.54.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2020 12:54:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Markus Armbruster <armbru@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v5 6/8] qapi: Restrict device memory commands to machine code
Date: Sun, 13 Sep 2020 21:53:46 +0200
Message-Id: <20200913195348.1064154-7-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200913195348.1064154-1-philmd@redhat.com>
References: <20200913195348.1064154-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/13 14:58:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.695,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Only qemu-system-FOO and qemu-storage-daemon provide QMP
monitors, therefore such declarations and definitions are
irrelevant for user-mode emulation.

Restricting the memory commands to machine.json allows
pulling less declarations/definitions to user-mode.

Acked-by: Igor Mammedov <imammedo@redhat.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 qapi/machine.json               | 216 +++++++++++++++++++++++++++++++
 qapi/misc.json                  | 217 --------------------------------
 include/hw/mem/memory-device.h  |   2 +-
 include/hw/virtio/virtio-pmem.h |   2 +-
 hw/acpi/memory_hotplug.c        |   1 +
 hw/virtio/virtio-mem-pci.c      |   1 +
 6 files changed, 220 insertions(+), 219 deletions(-)

diff --git a/qapi/machine.json b/qapi/machine.json
index 9b849be2aa6..39fbefb033b 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -1109,3 +1109,219 @@
 ##
 { 'event': 'BALLOON_CHANGE',
   'data': { 'actual': 'int' } }
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
+# @hotpluggable: true if device if could be added/removed while machine is running
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
+# @VirtioMEMDeviceInfo:
+#
+# VirtioMEMDevice state information
+#
+# @id: device's ID
+#
+# @memaddr: physical address in memory, where device is mapped
+#
+# @requested-size: the user requested size of the device
+#
+# @size: the (current) size of memory that the device provides
+#
+# @max-size: the maximum size of memory that the device can provide
+#
+# @block-size: the block size of memory that the device provides
+#
+# @node: NUMA node number where device is assigned to
+#
+# @memdev: memory backend linked with the region
+#
+# Since: 5.1
+##
+{ 'struct': 'VirtioMEMDeviceInfo',
+  'data': { '*id': 'str',
+            'memaddr': 'size',
+            'requested-size': 'size',
+            'size': 'size',
+            'max-size': 'size',
+            'block-size': 'size',
+            'node': 'int',
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
+# virtio-mem is included since 5.1.
+#
+# Since: 2.1
+##
+{ 'union': 'MemoryDeviceInfo',
+  'data': { 'dimm': 'PCDIMMDeviceInfo',
+            'nvdimm': 'PCDIMMDeviceInfo',
+            'virtio-pmem': 'VirtioPMEMDeviceInfo',
+            'virtio-mem': 'VirtioMEMDeviceInfo'
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
+
+##
+# @MEMORY_DEVICE_SIZE_CHANGE:
+#
+# Emitted when the size of a memory device changes. Only emitted for memory
+# devices that can actually change the size (e.g., virtio-mem due to guest
+# action).
+#
+# @id: device's ID
+# @size: the new size of memory that the device provides
+#
+# Note: this event is rate-limited.
+#
+# Since: 5.1
+#
+# Example:
+#
+# <- { "event": "MEMORY_DEVICE_SIZE_CHANGE",
+#      "data": { "id": "vm0", "size": 1073741824},
+#      "timestamp": { "seconds": 1588168529, "microseconds": 201316 } }
+#
+##
+{ 'event': 'MEMORY_DEVICE_SIZE_CHANGE',
+  'data': { '*id': 'str', 'size': 'size' } }
+
+
+##
+# @MEM_UNPLUG_ERROR:
+#
+# Emitted when memory hot unplug error occurs.
+#
+# @device: device name
+#
+# @msg: Informative message
+#
+# Since: 2.4
+#
+# Example:
+#
+# <- { "event": "MEM_UNPLUG_ERROR"
+#      "data": { "device": "dimm1",
+#                "msg": "acpi: device unplug for unsupported device"
+#      },
+#      "timestamp": { "seconds": 1265044230, "microseconds": 450486 } }
+#
+##
+{ 'event': 'MEM_UNPLUG_ERROR',
+  'data': { 'device': 'str', 'msg': 'str' } }
diff --git a/qapi/misc.json b/qapi/misc.json
index 05db6295fe0..71d11365ead 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -826,39 +826,6 @@
 ##
 { 'command': 'closefd', 'data': {'fdname': 'str'} }
 
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
@@ -1154,190 +1121,6 @@
  'returns': ['CommandLineOptionInfo'],
  'allow-preconfig': true }
 
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
-# @hotpluggable: true if device if could be added/removed while machine is running
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
-# @VirtioMEMDeviceInfo:
-#
-# VirtioMEMDevice state information
-#
-# @id: device's ID
-#
-# @memaddr: physical address in memory, where device is mapped
-#
-# @requested-size: the user requested size of the device
-#
-# @size: the (current) size of memory that the device provides
-#
-# @max-size: the maximum size of memory that the device can provide
-#
-# @block-size: the block size of memory that the device provides
-#
-# @node: NUMA node number where device is assigned to
-#
-# @memdev: memory backend linked with the region
-#
-# Since: 5.1
-##
-{ 'struct': 'VirtioMEMDeviceInfo',
-  'data': { '*id': 'str',
-            'memaddr': 'size',
-            'requested-size': 'size',
-            'size': 'size',
-            'max-size': 'size',
-            'block-size': 'size',
-            'node': 'int',
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
-# virtio-mem is included since 5.1.
-#
-# Since: 2.1
-##
-{ 'union': 'MemoryDeviceInfo',
-  'data': { 'dimm': 'PCDIMMDeviceInfo',
-            'nvdimm': 'PCDIMMDeviceInfo',
-            'virtio-pmem': 'VirtioPMEMDeviceInfo',
-            'virtio-mem': 'VirtioMEMDeviceInfo'
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
-##
-# @MEMORY_DEVICE_SIZE_CHANGE:
-#
-# Emitted when the size of a memory device changes. Only emitted for memory
-# devices that can actually change the size (e.g., virtio-mem due to guest
-# action).
-#
-# @id: device's ID
-# @size: the new size of memory that the device provides
-#
-# Note: this event is rate-limited.
-#
-# Since: 5.1
-#
-# Example:
-#
-# <- { "event": "MEMORY_DEVICE_SIZE_CHANGE",
-#      "data": { "id": "vm0", "size": 1073741824},
-#      "timestamp": { "seconds": 1588168529, "microseconds": 201316 } }
-#
-##
-{ 'event': 'MEMORY_DEVICE_SIZE_CHANGE',
-  'data': { '*id': 'str', 'size': 'size' } }
-
-
-##
-# @MEM_UNPLUG_ERROR:
-#
-# Emitted when memory hot unplug error occurs.
-#
-# @device: device name
-#
-# @msg: Informative message
-#
-# Since: 2.4
-#
-# Example:
-#
-# <- { "event": "MEM_UNPLUG_ERROR"
-#      "data": { "device": "dimm1",
-#                "msg": "acpi: device unplug for unsupported device"
-#      },
-#      "timestamp": { "seconds": 1265044230, "microseconds": 450486 } }
-#
-##
-{ 'event': 'MEM_UNPLUG_ERROR',
-  'data': { 'device': 'str', 'msg': 'str' } }
-
 ##
 # @ACPISlotType:
 #
diff --git a/include/hw/mem/memory-device.h b/include/hw/mem/memory-device.h
index cde52e83c9a..30d7e99f52c 100644
--- a/include/hw/mem/memory-device.h
+++ b/include/hw/mem/memory-device.h
@@ -14,7 +14,7 @@
 #define MEMORY_DEVICE_H
 
 #include "hw/qdev-core.h"
-#include "qapi/qapi-types-misc.h"
+#include "qapi/qapi-types-machine.h"
 #include "qom/object.h"
 
 #define TYPE_MEMORY_DEVICE "memory-device"
diff --git a/include/hw/virtio/virtio-pmem.h b/include/hw/virtio/virtio-pmem.h
index 56df9a03cea..826ddd3d564 100644
--- a/include/hw/virtio/virtio-pmem.h
+++ b/include/hw/virtio/virtio-pmem.h
@@ -15,7 +15,7 @@
 #define HW_VIRTIO_PMEM_H
 
 #include "hw/virtio/virtio.h"
-#include "qapi/qapi-types-misc.h"
+#include "qapi/qapi-types-machine.h"
 #include "qom/object.h"
 
 #define TYPE_VIRTIO_PMEM "virtio-pmem"
diff --git a/hw/acpi/memory_hotplug.c b/hw/acpi/memory_hotplug.c
index 8d2e82240ff..dfe57af4292 100644
--- a/hw/acpi/memory_hotplug.c
+++ b/hw/acpi/memory_hotplug.c
@@ -7,6 +7,7 @@
 #include "migration/vmstate.h"
 #include "trace.h"
 #include "qapi/error.h"
+#include "qapi/qapi-events-machine.h"
 #include "qapi/qapi-events-misc.h"
 
 #define MEMORY_SLOTS_NUMBER          "MDNR"
diff --git a/hw/virtio/virtio-mem-pci.c b/hw/virtio/virtio-mem-pci.c
index 590cec041b4..913f4a33260 100644
--- a/hw/virtio/virtio-mem-pci.c
+++ b/hw/virtio/virtio-mem-pci.c
@@ -14,6 +14,7 @@
 #include "virtio-mem-pci.h"
 #include "hw/mem/memory-device.h"
 #include "qapi/error.h"
+#include "qapi/qapi-events-machine.h"
 #include "qapi/qapi-events-misc.h"
 
 static void virtio_mem_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
-- 
2.26.2


